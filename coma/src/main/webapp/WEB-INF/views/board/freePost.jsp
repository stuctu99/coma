<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<jsp:include page="/WEB-INF/views/common/header.jsp">
	<jsp:param name="id" value="mine" />
</jsp:include>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<link href="${path }/resource/css/board/board.css" rel="stylesheet">
<script src="https://code.jquery.com/jquery-3.6.4.min.js"></script>
<c:set var="post" value="${post }"/>
<c:set var="e" value="${sessionScope.SPRING_SECURITY_CONTEXT.authentication.principal }"/>
<div class="coma-container">
<div class="container-xl">
	<div class="table-responsive">
		<div class="table-wrapper">
			<div class="table-title">
				<div class="row">
					<div class="board-name col-sm-6">
						<c:choose>
					      <c:when test="${post.boardType eq 0}">
					          <a href="${path }/board/noticelist"><h2>공지사항</h2></a>
					      </c:when>
					      <c:when test="${post.boardType eq 1}">
					          <a href="${path }/board/freelist"><h2>자유게시판</h2></a>
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
							<div class="" id="contents" name="contents" style="">
								<span>${post.boardTitle}</span>
							</div>
						</td>
					</tr>
					<tr>
						<th></th>
						<td colspan="6" style="height:300px; vertical-align:baseline; text-align: left;">
							<div class="" id="contents" name="contents" >
								<span>${post.boardContent}</span>
							</div>
						</td>
					</tr>
					<c:if test="${post.boardType eq 1}">
						<tr>
					        <th>이름</th>
					        <th>댓글내용</th>
					        <th>댓글날짜</th>
					        <th></th>
					    </tr>
					    <c:forEach var="reply" items="${reply}">
					        <tr>
					            <td>${reply.board.emp.empName }</td>
					            <td>${reply.replyContent}</td>
					            <td>${reply.replyDate}</td>
					            <td>
					            	<button type="button" class="reply-re">답글</button>
					            	<button class="reply-del">삭제</button>
					            </td>
					        </tr>
					    </c:forEach>
					    <tr>
						<th>댓글작성</th>
						<td colspan="6" class="view_text">
							<form action="${path }/board/writeReply" class="reply-detior" method="post">
							<div class="d-flex">
								<input type="hidden" name="boardNo" value="${post.boardNo }">
								<textarea class="form-control" id="contents" name="replyContent" style="width: 100%" placeholder="^0^"></textarea>
								<button class="btn btn-success m1-2">등록</button>
							</div>
							</form>
						</td>
						</tr>
					</c:if>
					<tr>
						<td>
							 <c:choose>
							     <c:when test="${post.boardType eq 0}">
							         <a href="${path}/board/noticelist" class="btn btn-success"><span>글목록</span></a>
							     </c:when>
							     <c:otherwise>
							         <a href="${path}/board/freelist" class="btn btn-success"><span>글목록</span></a>
							     </c:otherwise>
							 </c:choose>
						</td>
					</tr>
					<c:if test="${post.emp.empId eq e.empId }">
					<tr>
						<td>
							<a href="${path }/board/updatePost?boardNo=${post.boardNo }" class="btn btn-success"><span>글수정</span></a>
						</td>
						<td>
							<a href="${path }/board/delete?boardNo=${post.boardNo }&boardType=${post.boardType}" class="btn btn-success"><span>글삭제</span></a>
						</td>
					</tr>
					</c:if>
				</tbody>
			</table>
	</div>
			</div>
		</div>
	</div>        
</div>
</div>

<script>
	$(".reply-re").click(e=>{
		
		const $tr=$("<tr>");
		const $td=$("<td>").attr("colspan","2");
		const $form=$(".reply-detior").clone();
		$td.append($form);
		$tr.append($td);
		
		$(e.target).parents("tr").after($tr);
	})
	
	$(".reply-del").click(e=>{
		
		var confirmDelete =confirm("댓글을 삭제하시겠습니까?");
		
		if(confirmDelete){
			
			$.ajax({
				url: "/replyDelete",
				method: "DELETE".
				data: {}
			})
			
			alert("삭제되었습니다");
		}
		
		
	})
	
	document
</script>

















<jsp:include page="/WEB-INF/views/common/footer.jsp"/>