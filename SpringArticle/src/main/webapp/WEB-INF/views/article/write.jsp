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
<form role="form" id="writeForm" method="post" action="${path}/article/write">
<div>
	<div>
		<h3>게시글 작성</h3>
	</div>
	<div>
		<label for="title">제목</label>
		<input id="title" name="title" placeholder="제목을 입력하세요">
	</div>
	<div>
		<label for="content">내용</label>
		<textarea id="content" name="content" rows="6" placeholder="내용을 입력하세요" style="width:70%">
		</textarea>
	</div>
	<div>
		<label for="writer">작성자</label>
		<input id="writer" name="writer">
	</div>
</div>
<div>
	<button type="button">목록</button>
	<div>
		<button type="reset">초기화</button>
		<button type="submit">저장</button>
	</div>
</div>
</form>
</div>

</body>
</html>