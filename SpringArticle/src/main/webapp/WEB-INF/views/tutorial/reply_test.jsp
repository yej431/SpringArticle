<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>

<section class="content container-fluid">
<form role="form" method="post">
  <div class="col-lg-12">
    <div class="box box-primary">
        <div class="box-header with-border">
            <h3 class="box-title">댓글 작성</h3>
        </div>
        <div class="box-body">
            <div class="form-group">
                <label for="newReplyText">댓글 내용</label>
                <input class="form-control" id="newReplyText" name="reply_text" placeholder="댓글 내용을 입력해주세요">
            </div>
            <div class="form-group">
                <label for="newReplyWriter">댓글 작성자</label>
                <input class="form-control" id="newReplyWriter" name="reply_writer" placeholder="댓글 작성자를 입력해주세요">
            </div>
            <div class="pull-right">
            	<button type="button" id="replyAddBtn"><i class="fa fa-save"></i> 댓글 저장</button>
             </div>
        </div>
        <div class="box-footer">
            <ul id="replies">

            </ul>
        </div>
        <div class="box-footer">
         	<ul class="pagination pagination-sm">

        	</ul>
        </div>
    </div>
  </div>
</form>  
</section>

<script src="//code.jquery.com/jquery-3.2.1.min.js"></script>
<script>
$(document).ready(function () {
    var formObj = $("form[role='form']");
    console.log(formObj);
    $(".modBtn").on("click", function () {
        formObj.attr("action", "/article/modify");
        formObj.attr("method", "get");
        formObj.submit();
    });
    $(".delBtn").on("click", function () {
       formObj.attr("action", "/article/remove");
       formObj.submit();
    });
    $(".listBtn").on("click", function () {
       formObj.attr("method", "get");
       formObj.attr("action", "/article/list");
       formObj.submit();
    });
});

//1000번째 게시글
var articleNo =4;

// 댓글 목록 호출
getReplies();

//댓글 목록 출력 함수
function getReplies() {
    $.getJSON("/reply/all/" + articleNo, function (data) {
        console.log(data);
        var str = "";

        $(data).each(function () {
            str += "<li data-replyNo='" + this.reply_no + "' class='replyNo' value='"+this.reply_no+"'>"
                +   "<span class='replyText'>" + this.reply_text + "</span>"
                +   "<span class='replyWriter'>" + this.reply_writer + "</span>"
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
			+   "<span class='replyText'>" + this.reply_text + "</span>"
			+   "<span class='replyWriter'>" + this.reply_writer + "</span>"
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
    // 이전 버튼 활성화
    if (pageMaker.prev) {
        str += "<li><a href='"+(pageMaker.startPage-1)+"'>이전</a></li>";
    }
    // 페이지 번호
    for (var i = pageMaker.startPage, len = pageMaker.endPage; i <= len; i++) {
        var strClass = pageMaker.criteria.page == i ? 'class=active' : '';
        str += "<li "+strClass+"><a href='"+i+"'>"+i+"</a></li>";
    }
    // 다음 버튼 활성화
    if (pageMaker.next) {
        str += "<li><a href='"+(pageMaker.endPage + 1)+"'>다음</a></li>";
    }
    $(".pagination-sm").html(str);
}

//목록페이지 번호 변수 선언, 1로 초기화(첫번째 페이지)
var replyPageNum=1;

//목록페이지 번호 클릭 이벤트
$(".pagination").on("click", "li a", function(event){
	event.preventDefault();
    replyPageNum = $(this).attr("href"); // 목록 페이지 번호 추출
    getRepliesPaging(replyPageNum); // 목록 페이지 호출
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
		success : function(result){
        	//성공적인 댓글 등록 처리 알림
			if(result == "regSuccess"){
				alert("댓글이 등록되었습니다.");
                replyPageNum = 1;  // 페이지 1로 초기화
                getReplies("/reply/" + articleNo + "/" + replyPageNum); // 댓글 목록 호출
                replyTextObj.val("");   // 댓글 입력창 공백처리
                replyWriterObj.val("");   // 댓글 입력창 공백처리
			}
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
		success : function(result){
			console.log("result : "+result);
			if(result == "delSuccess"){
				alert("댓글 삭제 완료");
				getReplies(); //댓글 목록 갱신
			}
		}
	});
});
</script>
</body>
</html>