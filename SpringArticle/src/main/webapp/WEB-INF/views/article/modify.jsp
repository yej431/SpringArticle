<%@ page contentType="text/html; charset=UTF-8" language="java" %> 
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %> 
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %> 
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>

<div>
<form role="form" id="writeForm" method="post" action="${path}/article/modify">
<div>
	<div>
		<h3>게시글 수정</h3>
	</div>
	<div>
		<input type="hidden" name="article_no" value="${article.article_no}">
		<input type="hidden" name="page" value="${criteria.page}">
		<input type="hidden" name="perPageNum" value="${criteria.perPageNum}">
		<div>
			<label for="title">제목</label>
			<input id="title" name="title" placeholder="제목을 입력하세요" value="${article.title}"/>
		</div>
		<div>
			<label for="content">내용</label>
			<textarea id="content" name="content" rows="5" placeholder="내용을 입력해주세요"
				style="resize:none; width:70%">${article.content}</textarea>
		</div>
		<div>
			<label for="writer">작성자</label>
			<input id="writer" name="writer" value="${article.writer}" readonly>
		</div>
	</div>
	<div>
		<button type="button" class="listBtn">목록</button>
		<button type="button" class="modBtn">수정</button>
		<button type="button">삭제</button>
	</div>
</div>
</form>
</div>

<script src="//code.jquery.com/jquery-3.2.1.min.js"></script>
<script>
$(document).ready(function () {
    var formObj = $("form[role='form']");
    console.log(formObj);

    $(".modBtn").on("click", function () {
        formObj.submit();
    });

    $(".cancelBtn").on("click", function () {
        history.go(-1);
    });

    $(".listBtn").on("click", function () {
        self.location = "/article/list?page=${criteria.page}&perPageNum=${criteria.perPageNum}";
    });
});
</script>
</body>
</html>