<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>   
<jsp:include page="/WEB-INF/views/common/header.jsp">
   <jsp:param name="id" value="mine" />
</jsp:include>
<c:set var="emp" value="${sessionScope.SPRING_SECURITY_CONTEXT.authentication.principal }"/>
<style>
div {
	/*  border: 2px solid red; */
	
}

.bigbax {
	/* border: 2px solid blue; */
	/* margin: 15px; */
	/* border: 2px solid lightgrey */;
	border-radius: 20px;
	background-color: #ffffff;
	padding: 20px;
	box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
}

.containerbig {
	margin: 50px;
	text-align: center;
	padding: 20px;
	border-radius: 20px;
}

</style>
<div class="coma-container containerbig">
	<div class="row">
				<div class="col-1" ></div>
				<div class="col-2" style="display:flex;">
					<h1 >휴가 정보</h1>
				</div>
				<div class="col-7"></div>
				
				<div class="col-1"></div>
			</div>
	<div class="row" style="text-align: center;">
		<div class="col-1"></div>
		<div class="col-10  bigbax">
			<div class="row" style= "text-align: center;">
				<div class="col-1"></div>
				<div class="col-3 smallbox">
					<div class="">
						<h3 class="">남은 연차</h3>
					</div>
					<div class="blank">
						<h4> ${emp.empVacation } 일 <h4/>
					</div>
				</div>
				<div class=" col-3 smallbox">
					<div class=" ">
						<h3 class="">사용한 연차</h3>
					</div>
					<div class="blank">
						<h4>${finishCount } 회</h4>
					</div>
				</div>
				<div class=" col-3 smallbox">
					<div class="">
						<h3 class="">결재 중인 휴가 결재</h3>
					</div>
					<div class="blank">
						<h4>${ waitCount} 건</h4>
					</div>
				</div>
				<div class="col-1"></div>
			</div>
		</div>
		<div class="col-1"></div>
	</div>
	<div class="row" style="text-align: center;">
		<div class="col-1"></div>
		<div class="col-10  ">
			<div class="row" style="margin-top:30px">
				<div class="col-2"><h1>휴가 신청 내역</h1></div>
				<div class="col-8">
					<div class=""></div>
				</div>
				<div class="col-1">
					<button type="button" class="btn btn-primary" id ="vacationWriteBtn">휴가 신청하기</button>
				</div>
				<div class="col-1"></div>
			</div>
			<div class="row">
				<div class="col-1"></div>
				<div class="col-10">
					<table class="table align-items-center" style="text-align: center;">
						<thead class="thead-light">
							<tr>
								<th>문서  번호</th>
								<th>문서 제목 </th>
								<th>연차 종류</th>
								<th>일수</th>
								<th>기간</th>
								<th>상태</th>
							</tr>
						</thead>
						<tbody class="list" id="empTable">
							 <c:if test="${not empty vacation}">
					        	<c:forEach var="v" items="${vacation }">
					        	<tr>
					        		<td><c:out value="${v.DOC_NO}"/></td>
					        		<td>
					        			<a href="#">
					        				<c:out value="${v.DOC_TITLE }"/>
					        			</a>
					        		</td>
					        		<td><c:out value="${v.LEAVE_TYPE }"/></td>
			 		        		<td>${v.DOC_DIFF eq 1 ?(v.LEAVE_TYPE  eq '연차' ?1 : 0.5)   : v.DOC_DIFF}</td>
					        		<td>
					        			<fmt:formatDate value="${v.LEAVE_START}" pattern="yyyy-MM-dd" />-<fmt:formatDate value="${v.LEAVE_END}" pattern="yyyy-MM-dd" />
									</td>
					        		<td><c:out value="${v.DOC_PROGRESS}"/></td>
					        	</tr>
								 </c:forEach>
					           </c:if> 
						</tbody>
					</table>
					<div id="pageBar">${pageBar }</div>
				</div>
				<div class="col-1"></div>
			</div>
		</div>
		<div class="col-1"></div>
	</div>
</div>

<script>
document.getElementById('vacationWriteBtn').addEventListener('click', function() {
    window.location.href = ${pageContext.request.contextPath}'/approval/writedoc';
});
</script>


<jsp:include page="/WEB-INF/views/common/footer.jsp" />