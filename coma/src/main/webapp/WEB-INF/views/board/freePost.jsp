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
						<c:choose>
					      <c:when test="${post.boardType eq 0}">
					          <h2>공지사항</h2>
					      </c:when>
					      <c:when test="${post.boardType eq 1}">
					          <h2>자유게시판</h2>
					      </c:when>
					  	</c:choose>
					</div>
				</div>
			</div>
			<div class="table post-details-flex justify-content-center align-items-center">
			  <div class="container" style="text-align: center;">
	    	<table class="board_detail">
				<colgroup>
					<col width="20%"/>
					<col width="35%"/>
					<col width="15%"/>
					<col width="35%"/>
				</colgroup>
				<tbody>
					<tr>
						<th>글 번호</th>
						<td>${post.boardNo }</td>
						<th>조회수</th>
						<td>${post.boardReadCount }</td>
					</tr>
					<tr>
						<th>작성자</th>
						<td>${post.emp.empName}</td>
						<th>작성일</th>
						<td>${post.boardDate }</td>
					</tr>
					<tr>
						<th>제목</th>
						<td colspan="6">
							<input type="text" class="form-control" id="title" name="title" style="width: 100%" value="${post.boardTitle}"/>
						</td>
					</tr>
					<tr>
						<td colspan="6" class="view_text">
							<input type="text" class="form-control" id="contents" name="contents" style="width: 100%" value="${post.boardContent}"/>
						</td>
					</tr>
					<c:if test="${post.boardType eq 1}">
						<tr>
					        <th>이름</th>
					        <th>댓글내용</th>
					        <th>댓글날짜</th>
					    </tr>
					    <c:forEach var="reply" items="${reply}">
					        <tr>
					            <td>${reply.board.emp.empName }</td>
					            <td>${reply.replyContent}</td>
					            <td>${reply.replyDate}</td>
					        </tr>
					    </c:forEach>
						<th>댓글작성</th>
						<td colspan="6" class="view_text">
							<div class="d-flex">
							<textarea class="form-control" id="contents" name="contents" style="width: 100%" placeholder="^0^"></textarea>
							<button class="btn btn-success m1-2">확인</button>
							</div>
						</td>
					</tr>
					</c:if>
					<tr>
						<td>
							<a href="${path }/board/delete?boardNo=${post.boardNo }&boardType=${post.boardType}" class="btn btn-success"><span>글삭제</span></a>
						</td>
					</tr>
				</tbody>
			</table>
	</div>
			</div>
		</div>
	</div>        
</div>
</div>


<jsp:include page="/WEB-INF/views/common/footer.jsp"/>