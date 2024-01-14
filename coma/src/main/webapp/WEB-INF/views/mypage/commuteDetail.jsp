<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>   
<jsp:include page="/WEB-INF/views/common/header.jsp">
   <jsp:param name="id" value="mine" />
</jsp:include>
<c:set var="emp" value="${sessionScope.SPRING_SECURITY_CONTEXT.authentication.principal }"/>
<head>
    <title>Your JSP Page</title>

    <!-- jQuery -->
    <script type="text/javascript" src="https://cdn.jsdelivr.net/jquery/latest/jquery.min.js"></script>

    <!-- Moment.js -->
    <script type="text/javascript" src="https://cdn.jsdelivr.net/momentjs/latest/moment.min.js"></script>

    <!-- DateRangePicker -->
    <script type="text/javascript" src="https://cdn.jsdelivr.net/npm/daterangepicker/daterangepicker.min.js"></script>

    <!-- DateRangePicker CSS -->
    <link rel="stylesheet" type="text/css" href="https://cdn.jsdelivr.net/npm/daterangepicker/daterangepicker.css" />
</head>
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
.blank{
	padding-top: 20px;
	


}

/* You may need to adjust the styling based on your specific requirements */
</style>
<div class="coma-container containerbig">
	<div class="row">
				<div class="col-1" ></div>
				<div class="col-2" style="display:flex;">
					<h1 >근태 정보 </h1>
				</div>
				<div class="col-7"></div>
				<div class="col-1">
					<button type="button" class="btn btn-outline-primary">근태 변경 신청하기</button>
				</div>
				<div class="col-1"></div>
			</div>
	<div class="row" style="text-align: center;">
		<div class="col-1"></div>
		<div class="col-10  bigbax">
			<div class="row" style="margin-left:30px">
				
				<div class="col-3 smallbox">
					<div class="">
						<h3 class=""> 지각</h3>
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
			<div class="row" style="margin-top:30px">
				<div class="col-2"><h1>휴가 신청 내역</h1></div>
				<div class="col-10">
					<div class=""></div>
					
				</div>
			</div>
			<div class="row">
				<input type="text" id="demo" name="demo" value="" />

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


		  
$('#demo').daterangepicker({
    "locale": {
        "format": "YYYY-MM-DD",
        "separator": " ~ ",
        "applyLabel": "확인",
        "cancelLabel": "취소",
        "fromLabel": "From",
        "toLabel": "To",
        "customRangeLabel": "Custom",
        "weekLabel": "W",
        "daysOfWeek": ["일", "월", "화", "수", "목", "금", "토"],
        "monthNames": ["1월", "2월", "3월", "4월", "5월", "6월", "7월", "8월", "9월", "10월", "11월", "12월"],
    },
    "startDate": new Date(),
    "endDate": new Date(),
    "drops": "auto"
}, function (start, end, label) {
    console.log('New date range selected: ' + start.format('YYYY-MM-DD') + ' to ' + end.format('YYYY-MM-DD') + ' (predefined range: ' + label + ')');
});

</script>




<%-- <script src="${path }/resource/js/mypage/mypage.js"></script> --%>
<script src="${path }/resource/js/plugins/jquery/dist/jquery.min.js"></script>
<jsp:include page="/WEB-INF/views/common/footer.jsp" />