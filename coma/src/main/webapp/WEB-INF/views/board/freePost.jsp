<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<jsp:include page="/WEB-INF/views/common/header.jsp">
	<jsp:param name="id" value="mine" />
</jsp:include>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<link href="${path }/resource/css/board/board.css" rel="stylesheet">
<c:set var="post" value="${post }"/>
<div class="coma-container">
<div class="container-xl">
	<div class="table-responsive">
		<div class="table-wrapper">
			<div class="table-title">
				<div class="row">
					<div class="board-name col-sm-6">
						<h2>글화면</h2>
					</div>
				</div>
			</div>
			<div class="table post-details-flex">
			  <div class="title">제목 ${post.boardTitle}</div>
			  <div class="author">글쓴이 ${post.empId}</div>
			  <div class="content">내용 ${post.boardContent}</div>
			</div>
		</div>
	</div>        
</div>
</div>
<jsp:include page="/WEB-INF/views/common/footer.jsp"/>