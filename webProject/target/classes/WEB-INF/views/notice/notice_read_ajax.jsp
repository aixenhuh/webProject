<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%
	String id = request.getAttribute("ID").toString();
	String title = request.getAttribute("TITLE").toString();
	String content = request.getAttribute("CONTENTS").toString();
	String crea_dtm = request.getAttribute("CREA_DTM").toString();
	String idx = request.getAttribute("IDX").toString();
%>
<html>
<head>
</head>
    
<body>

<div class="container">
	<div class="row">
		<table class="table table-striped" style="text-align: center; border: 1px solid #dddddd">
			<thead>
				<tr>
					<th colspan="3" style="background-color: #eeeeee; text-align: center;">글 보기 </th>
				</tr>
			</thead>
			<tbody>
				<tr>
					<td style="width: 20%;"> 글 제목 </td>
					<td colspan="2"><%=title%></td>
				</tr>
				<tr>
					<td>작성자</td>
					<td colspan="2"><%=id%></td>
				</tr>
				<tr>
					<td>작성일</td>
					<td colspan="2"><%=crea_dtm%></td>
				</tr>
				<tr>
					<td>내용</td>
					<td colspan="2" style="min-height: 200px; text-align: left;"><%=content%></td>
				</tr>
			</tbody>
		</table>
</div>
<script>
//글쓰기
function fn_addtoBoard(){
    var form = $("#writeForm");
    form.attr("action", '/notice/notice_write.do');
    form.submit();
}
 
//목록
function fn_cancel(){
    var form = document.getElementById("writeForm");
    form.action = "<c:url value='/notice/notice.do'/>";
    form.submit();
}

$(document).ready(function(){
	$("#writer").val('${userEmail}');
})
</script>
</div>
</body>
</html>