<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<jsp:include page="/WEB-INF/views/common/header.jsp">
	<jsp:param name="id" value="mine" />
</jsp:include>
<c:set var="emp"
	value="${sessionScope.SPRING_SECURITY_CONTEXT.authentication.principal }" />
<script type="text/javascript"
	src="https://cdn.jsdelivr.net/jquery/latest/jquery.min.js"></script>
<script type="text/javascript"
	src="https://cdn.jsdelivr.net/momentjs/latest/moment.min.js"></script>
<script type="text/javascript"
	src="https://cdn.jsdelivr.net/npm/daterangepicker/daterangepicker.min.js"></script>
<link rel="stylesheet" type="text/css"
	href="https://cdn.jsdelivr.net/npm/daterangepicker/daterangepicker.css" />

<script src="/resource/js/jquery-3.7.0.js"></script>
<style>
div {
	/*  border: 2px solid red; */
	
}

.bigbax {
	/* border: 2px solid blue; */
	margin: 15px;
	/* border: 2px solid lightgrey */;
	border-radius: 20px;
	background-color: #f1edff;
	padding: 20px 10px 0px 20px;
	box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
}

.containerbig {
	margin: 50px;
	text-align: center;
	padding: 20px;
	border-radius: 20px;
}

.smallbox {
	margin: 30px;
	/* border: 1px solid lightgrey;   */
}

.blank {
	padding-top: 20px;
}

/* You may need to adjust the styling based on your specific requirements */
</style>
<div class="coma-container containerbig">
${commute}
	<div class="row">
		<div class="col-1"></div>
		<div class="col-2" style="display: flex;">
			<h1>근태 정보</h1>
		</div>
		<div class="col-7"></div>
		<div class="col-1">
			<button type="button" class="btn btn-outline-primary">근태 변경
				신청하기</button>
		</div>
		<div class="col-1"></div>
	</div>
	<div class="row" style="text-align: center;">
		<div class="col-1"></div>
		<div class="col-10  bigbax">
			<div class="row" style="margin-left: 30px">

				<div class="col-3 smallbox">
					<div class="">
						<h3 class="">지각</h3>
					</div>
					<div class="blank">
						<h4>
							${emp.empVacation } 일
							<h4 />
					</div>
				</div>
				<div class=" col-3 smallbox">
					<div class=" ">
						<h3 class="">사용한 연차</h3>
					</div>
					<div class="blank">
						<h4>${finishCount }회</h4>
					</div>
				</div>
				<div class=" col-3 smallbox">
					<div class="">
						<h3 class="">결재 중인 휴가 결재</h3>
					</div>
					<div class="blank">
						<h4>${ waitCount}</h4>
					</div>
				</div>
			</div>
		</div>
		<div class="col-1"></div>
	</div>
	<div class="row" style="text-align: center;">
		<div class="col-1"></div>
		<div class="col-10  ">
			<div class="row" style="margin-top: 30px">
				<div class="col-3">
					<h1>휴가 신청 내역</h1>
				</div>
				<div class="col-9">
					<div class=""></div>
				</div>
			</div>
			<form id = "searchForm">
				<div class="row">
					<div class="input-daterange datepicker row align-items-center">
						<div class="input-daterange datepicker row align-items-center">
							<div class="col">
								<div class="form-group">
									<div class="input-group">
										<div class="input-group-prepend">
											<span class="input-group-text"><i
												class="ni ni-calendar-grid-58"></i></span>
										</div>
										<input class="form-control" placeholder="Start date"
											type="text" value="06/18/2020">
									</div>
								</div>
							</div>
							<div class="col">
								<div class="form-group">
									<div class="input-group">
										<div class="input-group-prepend">
											<span class="input-group-text"><i
												class="ni ni-calendar-grid-58"></i></span>
										</div>
										<input class="form-control" placeholder="End date" type="text"
											value="06/22/2020">
									</div>
								</div>
							</div>
						</div>
						<div class="col">
							<div class="form-group">
								<input type="submit" class="btn btn-outline-primary" value="검색">
							</div>
						</div>
					</div>
			</form>
		</div>
	</div>
	<div class="col-1"></div>
	<div class="row">
		<div class="col-1"></div>
		<div class="col-10">
				<div class="col">
					<table class="table align-items-center" style="text-align: center;">
						<thead class="thead-light">
							<tr>
								<th>상태</th> <!-- 지각, 결근,  -->
								<th>출근 시간</th>
								<th>퇴근 시간 </th>
								<th>외출 시작 시간</th>
								<th>외출 끝 시간</th>
								<th>근무시간</th>
								<th>외출시간</th>
							</tr>
						</thead>
						<tbody class="list" id="empTable">
							<c:if test="${not empty commute}">
								<c:forEach var="c" items="${commute }">
									<tr>
 										<td><fmt:formatDate value="${c.EMP_COMMUTE_WORKDATE}" pattern="yyyy-MM-dd" /></td>
										<td><c:out value="${c.EMP_COMMUTE_STATUS }" /></td>	
												
										<%-- <td><fmt:formatDate value="${c.EMP_COMMUTE_CLOCKIN}" pattern="HH:mm:ss" /></td>
										<td><fmt:formatDate value="${c.EMP_COMMUTE_CLOCKOUT}" pattern="HH:mm:ss" /></td>
										<td><fmt:formatDate value="${c.EMP_COMMUTE_CLOCKIN}" pattern="HH:mm:ss" /></td>
										<td><fmt:formatDate value="${c.EMP_COMMUTE_CLOCKIN}" pattern="HH:mm:ss" /></td>
										<td><fmt:formatDate value="${c.EMP_COMMUTE_CLOCKIN}" pattern="HH:mm:ss" /></td> --%>
									</tr>
								</c:forEach>
							</c:if>
						</tbody>
					</table>
					<div id="pageBar">${pageBar }</div>
				</div>
			</div>
		<div class="col-1"></div>

	</div>
</div>
<!-- <div class="coma-container">
	<div class="row">
		총 12칸
		<div class="col-4">1</div>
		<div class="col-4">2</div>
		<div class="col-4">3</div>
	</div>
</div> -->

<script>
document.getElementById('searchForm').addEventListener('submit', function(event) {
    event.preventDefault(); // 폼의 기본 동작을 막음

    // 시작 날짜와 종료 날짜 가져오기
    const startDate = document.getElementById('start-date').value;
    const endDate = document.getElementById('end-date').value;

    // 서버로 검색 요청
    fetch(`${path}/commute/searchCommute?startDate=${startDate}&endDate=${endDate}`, {
        method: 'GET',
        headers: {
            'Content-Type': 'application/json'
            // 필요에 따라 다른 헤더 추가 가능
        },
        // body: JSON.stringify({ startDate, endDate }) // POST 요청일 경우 사용
    })
    .then(response => response.json())
    .then(data => {
        // 검색 결과를 사용하여 화면 업데이트
        console.log(data);
    })
    .catch(error => console.error('Error:', error));
});
	
</script>





<script src="${path }/resource/js/plugins/jquery/dist/jquery.min.js"></script>
<jsp:include page="/WEB-INF/views/common/footer.jsp" />