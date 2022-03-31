<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>

<div>
	<h4>댓글 수정창</h4>
	<div>
		<label for="replyNo">댓글 번호</label>
		<input id="replyNo" name="replyNo" value="${reply.reply_no}"  readonly>
	   	<div>
			<label for="replyText">댓글 내용</label>
			<input id="replyText" name="replyText" value="${reply.reply_text}">
		</div>
		 <div>
			 <label for="replyWriter">댓글 작성자</label>
			<input id="replyWriter" name="replyWriter" value="${reply.reply_writer}" readonly>
		</div>
  	</div>
	<div>
		<button type="button" id="listBtn">목록</button>
		<button type="button" id="modBtn">수정</button>                
	</div>
</div>

<script src="//code.jquery.com/jquery-3.2.1.min.js"></script>
<script>
//댓글 저장 버튼 클릭 이벤트 발생시
$("#modBtn").on("click", function(){
		// 입력 form 선택자
	    var reply_no = $("#replyNo").val();
	    var reply_text = $("#replyText").val();
        
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
        		reply_no : reply_no,
        		reply_text : replyText
        	}),
		success : function(result){
        	//성공적인 댓글 등록 처리 알림
			if(result == "modSuccess"){
                location.href="/reply/test" // 댓글 목록 호출
			}
		}
	});
});

$("#modBtn").on("click", function(){
	var reply_no=$("#replyNo").val();
	var reply_text=$("#replyText").val();
	console.log(reply_no + reply_text);
	$.ajax({
		type:"put",
		url:"/reply/"+reply_no+"/"+reply_text,
		headers:{
			"Content-type" : "application/json",
			"X-HTTP-Method-Override" : "PUT"
		},
		dataType : "text",
		success : function(result){
			console.log("result : "+result);
			if(result == "modSuccess"){
				alert("댓글 수정 완료");
			}
		}
	});
});
</script>
</body>
</html>