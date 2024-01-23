<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.Collection,com.coma.model.dto.Reply" %>
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
					
					<c:if test="${post.boardType eq 1 }">
						<tr>
					        <th></th>
					        <th></th>
					        <th></th>
					        <th></th>
					    </tr>
					    
					    <c:forEach var="replys" items="${reply}">
					   	<c:choose>
					    	<c:when test="${replys.replyLevel == 1 }">
					        <tr class="level1">
					            <td>${replys.emp.empName}</td>
					            <td>${replys.replyContent}</td>
					            
								<!-- 날짜출력 오늘: 시간:분 , 24년도-> 월-일만 출력, 그 외 년-월-일 -->
								<c:set var="today" value="<%=java.time.LocalDate.now()%>"/>
								<c:set var="todayHour" value="<%=java.time.LocalDateTime.now().getHour()%>"/>
								<td class="date">
									<c:choose>
										<c:when test="${replys.replyDate.toLocalDate() == today}">
											<c:set var="checkHour" value='<%=(new java.util.Date().getTime()-((Reply)pageContext.getAttribute("replys"))
															.getReplyDate().getTime())/(1000*60*60)%>'/>
											<span>								
												${checkHour>0?"".concat(checkHour).concat("시간 전"):'방금전'}
											</span>
									    </c:when>
						                <c:when test="${free.boardDate.year == 124}">
						                    <fmt:formatDate value="${replys.replyDate}" pattern="MM-dd" />
						                </c:when>
						                <c:otherwise>
						                    <fmt:formatDate value="${replys.replyDate}" pattern="yyyy-MM-dd" />
						                </c:otherwise>
						            </c:choose>
								</td>
								
					            <td>
					            	<input type="hidden" class="replyNo" name="replyNo" value="${replys.replyNo }">
					            	<button type="button" value="${replys.replyNo }" class="btn reply-re">답글</button>
					            	<button type="button" class="btn reply-del">삭제</button>
					            </td>
					        </tr>
					        </c:when>
					        
					        <c:otherwise>
					          <tr class="level2">
					          	<td>ㄴ${replys.emp.empName}</td>
					            <td>${replys.replyContent}</td>
								<!-- 날짜출력 오늘: 시간:분 , 24년도-> 월-일만 출력, 그 외 년-월-일 -->
								<c:set var="today" value="<%=java.time.LocalDate.now()%>"/>
								<c:set var="todayHour" value="<%=java.time.LocalDateTime.now().getHour()%>"/>
								<td class="date">
									<c:choose>
										<c:when test="${replys.replyDate.toLocalDate() == today}">
											<c:set var="checkHour" value='<%=(new java.util.Date().getTime()-((Reply)pageContext.getAttribute("replys"))
															.getReplyDate().getTime())/(1000*60*60)%>'/>
											<span>								
												${checkHour>0?"".concat(checkHour).concat("시간 전"):'방금전'}
											</span>
									    </c:when>
						                <c:when test="${free.boardDate.year == 124}">
						                    <fmt:formatDate value="${replys.replyDate}" pattern="MM-dd" />
						                </c:when>
						                <c:otherwise>
						                    <fmt:formatDate value="${replys.replyDate}" pattern="yyyy-MM-dd" />
						                </c:otherwise>
						            </c:choose>
								</td>
								
					            <td></td>
					        </tr>
					        </c:otherwise>
					    </c:choose>
					    </c:forEach>
					        
					    <tr>
						<th>${e.empName }</th>
						<td colspan="6" class="view_text">
							<form action="${path }/board/writeReply" class="reply-editor" method="post">
							<div class="d-flex">
								<input type="hidden" name="boardNo" value="${post.boardNo }">
								<input type="hidden" name="level" value="1">
								<input type="hidden" name="replyEmpId" value="${e.empId }">
								<input type="hidden" name="replyParentNo" value="0">
								<textarea class="form-control" id="contents" name="replyContent" style="width: 100%" placeholder="^0^"></textarea>
								<button class="btn btn-primary m1-2" id="btn-insert">등록</button>
							</div>
							</form>
						</td>
						</tr>
					</c:if>
					
					<tr>
						<td>
							 <c:choose>
							     <c:when test="${post.boardType eq 0}">
							         <a href="${path}/board/noticelist" class="btn btn-primary"><span>글목록</span></a>
							     </c:when>
							     <c:otherwise>
							         <a href="${path}/board/freelist" class="btn btn-primary"><span>글목록</span></a>
							     </c:otherwise>
							 </c:choose>
						</td>
						<c:if test="${post.emp.empId eq e.empId or fn:contains(e.authorities, 'ADMIN')}">	
						<td>
							<a href="${path }/board/updatePost?boardNo=${post.boardNo }" class="btn btn-primary"><span>글수정</span></a>
						</td>
						<td>
							<a href="${path }/board/delete?boardNo=${post.boardNo }&boardType=${post.boardType}" class="btn btn-primary"><span>글삭제</span></a>
						</td>
						</c:if>		
					</tr>	
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
		const $td=$("<td>").attr("colspan","3");
		const $form=$(".reply-editor").clone();
		
		$form.find("input[name=level]").val("2");
		$form.find("textarea").attr("rows","2");
		$form.find("button").removeAttr("id").addClass("btn-insert2");
		$form.find("input[name=replyParentNo]").val($(e.target).val());
		$td.append($form);
		$tr.append($td);
		
		$(e.target).parents("tr").after($tr);
	})
	
	$(".reply-del").click(e=>{
		
		const confirmDelete = confirm("댓글을 삭제하시겠습니까?");
		
		if(confirmDelete){
			
			const replyNo = $(e.target).closest("tr").find(".replyNo").val();
			
			$.ajax({
				url: "/board/deleteReply",
				method: "GET",
				data: { replyNo:replyNo },
				success: function(response) {
	                alert("삭제되었습니다");
	                location.reload();
	            },
	            error: function(error) {
	                console.error("삭제 실패", error);
	            }
			});
		}		
	});
</script>

















<jsp:include page="/WEB-INF/views/common/footer.jsp"/>