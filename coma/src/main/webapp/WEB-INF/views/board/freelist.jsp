<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<jsp:include page="/WEB-INF/views/common/header.jsp">
	<jsp:param name="id" value="mine" />
</jsp:include>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
    <!-- TEAM COMA SPACE -->
<style>
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
		   <h2 class="font-weight-bold text-primary heading">자유게시판</h2>
		   <hr/><br><br>
  <!-- board list area -->
    <div id="board-list" style="text-align: left">
        <div class="container">
        	<div class="" style="display: flex;">
        		<div class="" style="width:100px">
	        		<p>번호</p>
	        	</div>
	        	<div class="" style="width:100px">
	        		<p>제목</p>
	        	</div>
	        	<div class="" style="width:80px">
	        		<p>작성자</p>
	        	</div>
	        	<div class="" style="width:100px">
	        		<p>작성일</p>
	        	</div>
	        	<div class="">
	        		<p>조회수</p>
	        	</div>
        	</div>
   			<table>
   				<c:forEach var="free" items="${frees}">
   				<tr>
   					<td>${free.boardNo }</td>
   					<td><a href="">${free.boardTitle }</a></td>
   					<td>${free.empId }</td>
   					<td>${free.boardDate }</td>
   					<td>${free.boardReadCount }</td>
   				</tr>
   				</c:forEach>
       		</table>
        </div>
    </div>
   </div>
   </div>
  </div>
</div>
    <!-- TEAM COMA SPACE -->
<jsp:include page="/WEB-INF/views/common/footer.jsp"/>