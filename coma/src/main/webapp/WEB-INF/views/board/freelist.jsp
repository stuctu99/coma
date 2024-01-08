<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<jsp:include page="/WEB-INF/views/common/header.jsp">
	<jsp:param name="id" value="mine" />
</jsp:include>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
    <!-- TEAM COMA SPACE -->
<link href="${path }/resource/css/board/board.css" rel="stylesheet">

<div class="coma-container">
<div class="container-xl">
	<div class="table-responsive">
		<div class="table-wrapper">
			<div class="table-title">
				<div class="row">
					<div class="col-sm-6">
						<h2>자유게시판</h2>
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
						<th>번호</th>
						<th>제목</th>
						<th>작성자</th>
						<th>작성일</th>
						<th>조회수</th>
					</tr>
				</thead>
				<tbody>
   					<c:forEach var="free" items="${boards}">
					<tr>
						<td>
							<span class="custom-checkbox">
								<input type="checkbox" id="checkbox1" name="options[]" value="1">
								<label for="checkbox1"></label>
							</span>
						</td>
						<td>${free.boardNo }</td>
	   					<td><a href="/board/freePost?boardNo=${free.boardNo }">${free.boardTitle }</a></td>
	   					<td>${free.emp.empId }</td>
	   					<td>${free.boardDate }</td>
	   					<td>${free.boardReadCount }</td>
					</tr>				
					</c:forEach>
				</tbody>
			</table>
			<div class="col-sm-6" style="text-align: right;">
				<a href="/writePost" class="btn btn-success"><span>글쓰기</span></a>					
			</div>
		</div>
	</div>        
</div>
</div>

    <!-- TEAM COMA SPACE -->
<jsp:include page="/WEB-INF/views/common/footer.jsp"/>