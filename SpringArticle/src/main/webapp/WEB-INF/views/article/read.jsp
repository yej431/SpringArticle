<%@ page contentType="text/html; charset=UTF-8" language="java" %> 
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %> 
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %> 
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style>
.paging ul li{
	padding:10px;display:inline
}
.paging ul li:first-child{
	padding-left:0px; 
}
</style>
</head>
<body>

<div>
	<div>
		<h3>글제목: ${article.title}</h3>
	</div>
	<div>
		${article.content}
	</div>
	<div style="margin-top:20px;">
		<span>
			<a href="#">${article.writer}</a>
		</span>
		<span><fmt:formatDate value="${article.regDate}" pattern="yyyy-MM-dd"/></span>
	</div>
</div>
<div style="margin-top:20px;">
<form role="form" >
   <input type="hidden" name="article_no" value="${article.article_no}">
   <input type="hidden" name="page" value="${criteria.page}">
   <input type="hidden" name="perPageNum" value="${criteria.perPageNum}">
</form>
<button type="submit" class="list">목록</button>
<button type="submit" class="modify">수정</button>
<button type="submit" class="delete">삭제</button>
</div>

<div style="margin-top:40px;">
<form role="form" method="post">
	<div>
		<div>댓글</div>
		<textarea id="newReplyText" name="reply_text"  rows="2" style="width:50%"></textarea>
	</div>
	<div style="margin-top:5px;">
		<label for="newReplyWriter">작성자: </label>
		<input id="newReplyWriter" name="reply_writer" placeholder="댓글 작성자를 입력해주세요">
	</div>
	 <div style="margin-top:10px;">
		<button type="button" id="replyAddBtn">저장</button>
	</div>
	<div style="margin-top:30px;">
		<ul id="replies" style="list-style:none;">

		</ul>
	</div>
	<div class="paging">
		<ul class="pagination pagination-sm" style="list-style:none; ">
         	
		</ul>
	</div>
</form>  
</div>

<script src="//code.jquery.com/jquery-3.2.1.min.js"></script>
<script>
$(document).ready(function () {	
	
	$.ajaxSetup({cache:false});	

	var articleNo = "${article.article_no}";  // 현재 게시글 번호
    var replyPageNum = 1; // 댓글 페이지 번호 초기화
    
 	// 댓글 목록 함수 호출
    getRepliesPaging(replyPageNum);

	//댓글 목록 출력 함수
	function getReplies() {
	    $.getJSON("/reply/all/" + articleNo, function (data) {
	        console.log(data);
	        var str = "";
	
	        $(data).each(function () {
	            str += "<li data-replyNo='" + this.reply_no + "' class='replyNo' value='"+this.reply_no+"'>"
	                +   "<span class='replyText' style='padding-right:80px;'" + this.reply_text + "</span>"
	                +   "<span class='replyWriter'>작성자: " + this.reply_writer + "</span>"
	                +   "<a href='/reply/modView?reply_no="+this.reply_no+"&reply_text="+this.reply_text+"&reply_writer="+this.reply_writer+"' style='margin-left:30px'>수정</a>&nbsp;"
	    			+ "&nbsp;<a href='' class='delBtn'>삭제</a>"
	                + "</li>"
	                + "<hr/>";
	        });
	        $("#replies").html(str);
	    });
	}
	
	// 댓글 목록 출력 함수
	function getRepliesPaging(page) {
		$.getJSON("/reply/" + articleNo + "/" + page, function (data) {
			console.log(data);
			var str = "";
			
			$(data.replies).each(function () {
				str += "<li style='display:inline'; data-replyNo='"+this.reply_no+"' class='replyNo' value='"+this.reply_no+"'>"
				+   "<span class='replyText' style='padding-right:80px;'>" + this.reply_text + "</span>"
				+   "<span class='replyWriter'>작성자: " + this.reply_writer + "</span>"
				+   "<a href='/reply/modView?reply_no="+this.reply_no+"&reply_text="+this.reply_text+"&reply_writer="+this.reply_writer+"' style='margin-left:30px'>수정</a>&nbsp;"
				+ "&nbsp;<a href='' class='delBtn'>삭제</a>"
	  			+ "</li>"
				+ "<hr/>";
	 		});
			
			$("#replies").html(str);
			
			//페이지 번호 출력 호출
			printPageNumbers(data.pageMaker);
		});
	}
	
	//댓글 목록 페이지 번호 출력 함수
	function printPageNumbers(pageMaker) {
		var str = "";
        if (pageMaker.prev) {
            str += "<li><a href='"+(pageMaker.startPage-1)+"'>이전</a></li>";
        }
        for (var i = pageMaker.startPage, len = pageMaker.endPage; i <= len; i++) {
            var strCalss = pageMaker.criteria.page == i ? 'class=active' : '';
            str += "<li "+strCalss+"><a href='"+i+"'>"+i+"</a></li>";
        }
        if (pageMaker.next) {
            str += "<li><a href='"+(pageMaker.endPage + 1)+"'>다음</a></li>";
        }
        $(".pagination-sm").html(str);
	}
	
	//목록페이지 번호 클릭 이벤트
	$(".pagination").on("click", "li a", function(event){
		event.preventDefault();
        replyPageNum = $(this).attr("href");
        getRepliesPaging(replyPageNum);
	});
	
	//댓글 저장 버튼 클릭 이벤트 발생시
	$("#replyAddBtn").on("click", function(){
			// 입력 form 선택자
		    var replyWriterObj = $("#newReplyWriter");
		    var replyTextObj = $("#newReplyText");
		    var replyWriter = replyWriterObj.val();
		    var replyText = replyTextObj.val();
	        
	        //Ajax 통신 : post
	        $.ajax({
	        	type : "post",
	        	url : "/reply/",
	        	headers : {
	        		"Content-type" : "application/json",
	        		"X-HTTP-Method-Override" : "POST"
	        	},
	        	dataType : "text",
	        	data : JSON.stringify({
	        		article_no : articleNo,
	        		reply_text : replyText,
	        		reply_writer : replyWriter
	        	}),
	        	success : function (result) {
	                if (result == "regSuccess") {
	                    alert("댓글 등록 완료!");
	                }
	                //getReplies();
	                getRepliesPaging(replyPageNum);
	                replyText.val("");
	                replyWriter.val("");
	            }
		});
	});
	
	$(document).on("click", "button[name='mod']", function(){
		formObj.attr("action", "${path}/reply/modView");
		formObj.attr("method", "post");
		formObj.submit();
	});
	
	$(document).on("click", ".delBtn", function(){
		//댓글 번호
		var reply_no = $(".replyNo").val();
		
		//Ajax통신 : delete
		$.ajax({
			type : "delete",
			url: "/reply/del/" + reply_no,
			headers:{
				"Content-type" : "application/json",
				"X-HTTP-Method-Override" : "delete"
			},
			dataType : "text",
			success : function (result) {
                console.log("result : " + result);
                if (result == "delSuccess") {
                    alert("댓글 삭제 완료!");
                    getRepliesPaging(replyPageNum);
                }
            }
		});
	});
	
	var formObj = $("form[role='form']");
    console.log(formObj);
    $(".modify").on("click", function () {
        formObj.attr("action", "/article/modify");
        formObj.attr("method", "get");
        formObj.submit();
    });
    $(".delete").on("click", function () {
       formObj.attr("action", "/article/remove");
       formObj.attr("method", "post");
       formObj.submit();
    });
    $(".list").on("click", function () {
       formObj.attr("method", "get");
       formObj.attr("action", "/article/list");
       formObj.submit();
    });
});
</script>
</body>
</html>