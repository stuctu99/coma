<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<jsp:include page="/WEB-INF/views/common/header.jsp">
	<jsp:param name="id" value="mine" />
</jsp:include>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<style>
@import url('https://fonts.googleapis.com/css2?family=Noto+Sans+KR&display=swap');

* {
font-family: 'Noto Sans KR', sans-serif;
}
	
	
.main-content{
	height: 100%;
}

body {
	color: #566787;
	background: #f5f5f5;
	font-size: 13px;
}
.table-responsive {
    margin: 30px 0;
}
.table-wrapper {
	background: #fff;
	padding: 20px 25px;
	border-radius: 3px;
	min-width: 1000px;
	box-shadow: 0 1px 1px rgba(0,0,0,.05);
}
.table-title {        
	padding-bottom: 15px;
	color: #fff;
	padding: 16px 30px;
	min-width: 100%;
	margin: -20px -25px 10px;
	border-radius: 3px 3px 0 0;
}
.table-title h2 {
	margin: 5px 0 0;
	font-size: 24px;
}
.table-title .btn-group {
	float: right;
}
.table-title .btn {
	color: #fff;
	float: right;
	font-size: 13px;
	border: none;
	min-width: 50px;
	border-radius: 2px;
	border: none;
	outline: none !important;
	margin-left: 10px;
}
.table-title .btn i {
	float: left;
	font-size: 21px;
	margin-right: 5px;
}
.table-title .btn span {
	float: left;
	margin-top: 2px;
}
table.table tr th, table.table tr td {
	border-color: #e9e9e9;
	padding: 12px 15px;
	vertical-align: middle;
}
table.table tr th:first-child {
	width: 60px;
}
table.table tr th:last-child {
	width: 100px;
}
table.table-striped tbody tr:nth-of-type(odd) {
	background-color: #fcfcfc;
}
table.table-striped.table-hover tbody tr:hover {
	background: #f5f5f5;
}
table.table th i {
	font-size: 13px;
	margin: 0 5px;
	cursor: pointer;
}	
table.table td:last-child i {
	opacity: 0.9;
	font-size: 22px;
	margin: 0 5px;
}
table.table td a {
	font-weight: bold;
	color: #566787;
	display: inline-block;
	text-decoration: none;
	outline: none !important;
}
table.table td a:hover {
	color: #2196F3;
}
table.table td a.edit {
	color: #FFC107;
}
table.table td a.delete {
	color: #F44336;
}
table.table td i {
	font-size: 19px;
}
table.table .avatar {
	border-radius: 50%;
	vertical-align: middle;
	margin-right: 10px;
}
.pagination {
	float: right;
	margin: 0 0 5px;
}
.pagination li a {
	border: none;
	font-size: 13px;
	min-width: 30px;
	min-height: 30px;
	color: #999;
	margin: 0 2px;
	line-height: 30px;
	border-radius: 2px !important;
	text-align: center;
	padding: 0 6px;
}
.pagination li a:hover {
	color: #666;
}	
.pagination li.active a, .pagination li.active a.page-link {
	background: #03A9F4;
}
.pagination li.active a:hover {        
	background: #0397d6;
}
.pagination li.disabled i {
	color: #ccc;
}
.pagination li i {
	font-size: 16px;
	padding-top: 6px
}
.hint-text {
	float: left;
	margin-top: 10px;
	font-size: 13px;
}    
</style>

<div class="container-xl">
	<div class="table-responsive">
		<div class="table-wrapper">
			<div class="table-title">
				<div class="row">
					<div class="col-sm-6">
						<h2>공지사항</h2><br><br>
					</div>
					<div class="col-sm-6">
						<a href="#addEmployeeModal" class="btn btn-success" data-toggle="modal"><span>공지추가</span></a>
						<a href="#deleteEmployeeModal" class="btn btn-danger" data-toggle="modal"><span>공지삭제</span></a>						
					</div>
				</div>
			</div>
			<table class="table table-striped table-hover">
				<thead>
					<tr>
						<th>
							<span class="custom-checkbox">
								<input type="checkbox" id="selectAll">
								<label for="selectAll"></label>
							</span>
						</th>
						<th>작성일</th>
						<th>제목</th>
						<th>조회수</th>
						<th></th>
						<th></th>
					</tr>
				</thead>
				<tbody>
   					<c:forEach var="notice" items="${notices}">
					<tr>
						<td>
							<span class="custom-checkbox">
								<input type="checkbox" id="checkbox1" name="options[]" value="1">
								<label for="checkbox1"></label>
							</span>
						</td>
						<td>${notice.boardDate }</td>
	   					<td><a href="">${notice.boardTitle }</a></td>
	   					<td>${notice.boardReadCount }</td>
	   					<td></td>
	   					<td></td>
					</tr>				
					</c:forEach>
				</tbody>
			</table>
		</div>
	</div>        
</div>

<%-- <style>
	@import url('https://fonts.googleapis.com/css2?family=Noto+Sans+KR&display=swap');
	* {
	font-family: 'Noto Sans KR', sans-serif;
	}
	.section *{
		font-size:24px;
	}
	
	.container {
		margin:0 0 0 0px;	
		padding: 20px 20px 20px 20px;
		width:1100px;
		height:100%;
	}
	
	
</style>
    <!-- TEAM COMA SPACE -->
    <div class="section section-properties" style="height: 1110.760px;">
	  <div class="container">
	   	<div class="two_third first" style="display: flex">
		  <div class="" style="width:900px;">
		   <h2 class="font-weight-bold text-primary heading">공지사항</h2>
		   <hr/><br><br>
  <!-- board list area -->
    <div id="board-list" style="text-align: left">
        <div class="container">
        	<div class="" style="display: flex;">
	        	<div class="" style="width:137px">
	        		<p>작성일</p>
	        	</div>
	        	<div class="" style="width:170px">
	        		<p>제목</p>
	        	</div>
	        	<div class="">
	        		<p>조회수</p>
	        	</div>
        	</div>
   			<table>
   				<c:forEach var="notice" items="${notices}">
   				<tr>
   					<td>${notice.boardDate }</td>
   					<td><a href="">${notice.boardTitle }</a></td>
   					<td>${notice.boardReadCount }</td>
   				</tr>
   				</c:forEach>
       		</table>
        </div>
    </div>
   </div>
   </div>
  </div>
</div> --%>
    <!-- TEAM COMA SPACE -->
<jsp:include page="/WEB-INF/views/common/footer.jsp"/>