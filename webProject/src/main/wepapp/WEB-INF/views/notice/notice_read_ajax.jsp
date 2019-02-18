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
	    <div class="col-lg-6">
	      <!-- Default Card Example -->
	      <div class="card mb-4">
	        <div class="card-header">
	          	글 제목
	        </div>
	        <div class="card-body">
	          <%=title%>
	        </div>
	      </div>
        </div>
       	<div class="col-lg-6">
	      <!-- Default Card Example -->
	      <div class="card mb-4">
	        <div class="card-header">
	          작성자
	        </div>
	        <div class="card-body">
	          <%=id%>
	        </div>
	      </div>
        </div>
		<div class="card shadow mb-4" style="width:100%">
           <!-- Card Header - Dropdown -->
           <div class="card-header py-3 d-flex flex-row align-items-center justify-content-between">
             <h6 class="m-0 font-weight-bold text-primary">작성글 보기</h6>
             <div class="dropdown no-arrow">
               <a class="dropdown-toggle" href="#" role="button" id="dropdownMenuLink" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                 <i class="fas fa-ellipsis-v fa-sm fa-fw text-gray-400"></i>
               </a>
               <div class="dropdown-menu dropdown-menu-right shadow animated--fade-in" aria-labelledby="dropdownMenuLink" x-placement="bottom-end" style="position: absolute; transform: translate3d(-156px, 18px, 0px); top: 0px; left: 0px; will-change: transform;">
                 <div class="dropdown-header">작성 글 보기</div>
                 <a class="dropdown-item" href="#">Action</a>
                 <a class="dropdown-item" href="#">Another action</a>
                 <div class="dropdown-divider"></div>
                 <a class="dropdown-item" href="#">Something else here</a>
               </div>
             </div>
           </div>
           <!-- Card Body -->
           <div class="card-body">
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
         </div>
     </div>
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