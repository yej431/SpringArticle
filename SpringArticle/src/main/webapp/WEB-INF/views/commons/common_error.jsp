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
	<div>
		<h3>${exception.getMessage()}</h3>
		<ul>
			<c:forEach items="${exception.getStackTrace()}" var="stack">
				<li>${stack.toString()}</li>
			</c:forEach>
		</ul>
	</div>
</div>

<aside>
	<div>
		<h5>Title</h5>
		<p>Sidebar content</p>
	</div>
</aside>

</body>
</html>