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
	<h3>게시글 목록</h3>
</div>
<div>
	<table>
		<thead>
			<tr>
				<th style="width:30px;">#</th>
				<th>제목</th>
				<th style="width:100px">작성자</th>
				<th style="width:150px">작성시간</th>
				<th style="width:60px">조회</th>
			</tr>
		</thead>
		<tbody>
			<c:forEach items="${articles}" var="article">
			<tr>
			    <td>${article.article_no}</td>
			    <%--<td><a href="${path}/article/read?articleNo=${article.articleNo}">${article.title}</a></td>--%>
			    <td>
			      <a href="${path}/article/read${pageMaker.makeQuery(pageMaker.criteria.page)}&article_no=${article.article_no}">
			        ${article.title}
			      </a>
			    </td>
			    <td>${article.writer}</td>
			    <td><fmt:formatDate value="${article.regDate}" pattern="yyyy-MM-dd a HH:mm"/></td>
			    <td><span class="badge bg-red">${article.viewCnt}</span></td>
			</tr>
			</c:forEach>
		</tbody>
	</table>
</div>

<div>
	<a href="/article/write">글쓰기</a>
</div>
</div>

<div> 
<form id="listPageForm">
<input type="hidden" name="page" value="${pageMaker.criteria.page}">
<input type="hidden" name="perPageNum" value="${pageMaker.criteria.perPageNum}">
<ul class="pagination">
    <c:if test="${pageMaker.prev}">
        <%--<li><a href="${path}/article/listPaging?page=${pageMaker.startPage - 1}">이전</a></li>--%>
        <%--<li><a href="${path}/article/listPaging${pageMaker.makeQuery(pageMaker.startPage - 1)}">이전</a></li>--%>
        <li style="display:inline"><a href="${pageMaker.startPage - 1}">이전</a></li>
    </c:if>
    <c:forEach begin="${pageMaker.startPage}" end="${pageMaker.endPage}" var="idx">
        <li style="display:inline" <c:out value="${pageMaker.criteria.page == idx ? 'class=active' : ''}"/>>
            <%--<a href="${path}/article/listPaging?page=${idx}">${idx}</a>--%>
            <%--<a href="${path}/article/listPaging${pageMaker.makeQuery(idx)}">${idx}</a>--%>
            <a href="${idx}">${idx}</a>
        </li>
    </c:forEach>
    <c:if test="${pageMaker.next && pageMaker.endPage > 0}">
        <%--<li><a href="${path}/article/listPaging?page=${pageMaker.endPage + 1}">다음</a></li>--%>
        <%--<li><a href="${path}/article/listPaging?${pageMaker.makeQuery(pageMaker.endPage + 1)}">다음</a></li>--%>
        <li style="display:inline"><a href="${pageMaker.endPage + 1}">다음</a></li>
    </c:if>
</ul>
</form>
</div>

<script src="//code.jquery.com/jquery-3.2.1.min.js"></script>
<script>
var result="${msg}";
if(result == "regSuccess"){
	alert("게시글 등록이 완료되었습니다.");
}else if(result=="modSuccess"){
	alert("게시글 수정이 완료되었습니다.");
}else if(result=="delSuccess"){
	alert("게시글 삭제가 완료되었습니다.");
}

$(".pagination li a").on("click", function (event) {
    event.preventDefault();

    var targetPage = $(this).attr("href");
    var listPageForm = $("#listPageForm");
    listPageForm.find("[name='page']").val(targetPage);
    listPageForm.attr("action", "/").attr("method", "get");
    listPageForm.submit();
});
</script>
</body>
</html>