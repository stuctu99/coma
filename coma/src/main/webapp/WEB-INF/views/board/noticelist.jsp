<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<jsp:include page="/WEB-INF/views/common/header.jsp">
	<jsp:param name="id" value="mine" />
</jsp:include>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="path" value="${pageContext.request.contextPath }"/>
<link href="${path }/resource/css/board/board.css" rel="stylesheet">

<div class="coma-container">
<div class="container-xl">
	<div class="table-responsive">
		<div class="table-wrapper">
			<div class="table-title">
				<div class="row">
					<div class="col-sm-6">
						<h2>공지사항</h2>
					</div>
					<!-- 잠시주석 -->
					<%-- <div class="col-sm-6">
						<a href="${pageContext.request.contextPath }/createPost" class="btn btn-success" data-toggle="modal"><span>공지추가</span></a>
						<a href="#deleteEmployeeModal" class="btn btn-danger" data-toggle="modal"><span>공지삭제</span></a>						
					</div> --%>
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
   					<c:forEach var="boards" items="${boards}">
					<tr>
						<td>
							<span class="custom-checkbox">
								<input type="checkbox" id="checkbox1" name="options[]" value="1">
								<label for="checkbox1"></label>
							</span>
						</td>
						<td>${boards.boardDate }</td>
	   					<td><a href="/board/freePost?boardNo=${boards.boardNo }">
	   						${boards.boardTitle }</a></td>
	   					<td>${boards.boardReadCount }</td>
	   					<td></td>
	   					<td></td>
					</tr>				
					</c:forEach>
				</tbody>
			</table>
		</div>
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