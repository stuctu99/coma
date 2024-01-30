<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<jsp:include page="/WEB-INF/views/common/header.jsp">
	<jsp:param name="id" value="mine" />
</jsp:include>
<c:set var="path" value="${pageContext.request.contextPath}"/>
<c:set var="emp" value="${sessionScope.SPRING_SECURITY_CONTEXT.authentication.principal }" />
<script src="${path }/resource/js/jquery-3.7.0.js"></script>
<style>
table {
	border-collapse: collapse;
}

td {
	width: 150px;
	height: 100px;
	
	
}
.calendarContainer{
	box-shadow: 0 0 10px rgba(0, 0, 0, 0.1); 
	text-align: center;
	padding: 0px;
	background-color:white;
	border-radius: 50px; 

}
td
</style>
<%-- ${commute} --%>
<body onload="autoReload();">
	<div class="coma-container containerbig">
		<div class="row" style = "padding: 40px 0px 20px; ">
			<div class="col-2 "></div>
			<div class="col-7 ">
				<h1 style="text-align:center;">나의 근태 확인하기</h1>
			</div>
			<div class="col-3"><button type="button" class="btn btn-primary" id="commuteDetail">  근태 상세 보기</button></div>
			
		</div>
		<div class="row ">
			<div class="col-2 "></div>
				<div class=" col-8 calendar ">
				<table align="center" id="calendar" class= "calendarContainer">
					<tr>
						<td><a id="before" href="javascript:beforem()"></a></td>
						<td colspan="4" align="center">
							<div id="yearmonth"></div>
						</td>
						<td><a id="next" href="javascript:nextm()"></a></td>
						<td><h1 href="javascript:thisMonth()">오늘</h1></td>
					</tr>
					<tr>
						<td width="14%">월</td>
						<td width="14%">화</td>
						<td width="14%">수</td>
						<td width="14%">목</td>
						<td width="14%">금</td>
						<td width="14%" style ="background-color: #f1edff;"><font color="#009de0">토</font></td>
						<td width="14%" style ="background-color: #f1edff;"><font color="#ed5353">일</font></td>
					</tr>
				</table>
			</div>
		</div>
		<div class="col-2 "></div>
	</div>
</body>
<script>
	var today = new Date(); //오늘 날짜        
	var date = new Date();
	//이전달
	function beforem() {
		//이전 달을 today에 값을 저장
		today = new Date(today.getFullYear(), today.getMonth() - 1, today.getDate());
		autoReload(); //만들기
	}

	//다음달
	function nextm(){
		//다음 달을 today에 저장
		today = new Date(today.getFullYear(), today.getMonth() + 1, today.getDate());
		autoReload();
	}
	function thisMonth() {
		//오늘선택
		today = new Date();
		autoReload();
	}
	function autoReload() {
		var nMonth = new Date(today.getFullYear(), today.getMonth(), 1); //현재달의 첫째 날
		var lastDate = new Date(today.getFullYear(), today.getMonth() + 1, 0); //현재 달의 마지막 날
		var tbcal = document.getElementById("calendar"); // 테이블 달력을 만들 테이블
		var yearmonth = document.getElementById("yearmonth"); //  년도와 월 출력할곳
		yearmonth.innerHTML = "<h1>"+today.getFullYear() + "년 "+ (today.getMonth() + 1) + "월"+"</h1>"; //년도와 월 출력

		if (today.getMonth() + 1 == 12) {
		//  눌렀을 때 월이 넘어가는 곳
			before.innerHTML = "<h1><i class='ni ni-bold-left'></h1>";
			next.innerHTML = "<h1><i class='ni ni-bold-right'></h1>";

		} else if (today.getMonth() + 1 == 1) {
		//  1월 일 때
			before.innerHTML = "<h1><i class='ni ni-bold-left'></h1>";
			next.innerHTML = "<h1><i class='ni ni-bold-right'></h1>";
		} else {
		//   12월 일 때
			before.innerHTML ="<h1><i class='ni ni-bold-left'></h1>";
			next.innerHTML = "<h1><i class='ni ni-bold-right'><h1>";
		}
		// 남은 테이블 줄 삭제
		while (tbcal.rows.length > 2) {
			tbcal.deleteRow(tbcal.rows.length - 1);
		}
		var row = null;
		row = tbcal.insertRow();
		var cnt = 0;
		var dayCheck = (nMonth.getDay() == 0) ? 7 : nMonth.getDay(); //일요일을 마지막으로 넣기 위해서.

		// 1일 시작칸 찾기
		for (i = 0; i < (dayCheck - 1); i++) {
			cnt = cnt + 1; //요일값
			cell = row.insertCell();
			if (i > 4) { //주말
				cell.style.backgroundColor = "#f1edff";
			}
		}

		// 달력 출력
		for (i = 1; i <= lastDate.getDate(); i++) {
			// 1일부터 마지막 일까지
			cell = row.insertCell();
			var str = "";
			str += "<div>" + i + "</div>";			
			var tdId =   today.getFullYear() + "-" + (today.getMonth() + 1 < 10 ? "0" + (today.getMonth() + 1) : today.getMonth() + 1) + "-" + (i < 10 ? "0" + i : i) ;
			str += "<div id='"+tdId+"'></div>"; //원하는 날에 일정을 넣기위해 id값을 날자로 설정 2024-01-01이런 패턴으로 넣어줌. 
			cell.innerHTML = str;
			cnt = cnt + 1;
			if (cnt % 7 == 6) {//토요일
				var str = "";
				str += "<div>" + i + "</div>";
				var day = (i < 10) ? "0" + i : i;
				str += "<div id='"+tdId+"'>";
				str += "</div>";
				cell.innerHTML = str;
				cell.style.color = "#009de0";
				cell.style.backgroundColor = "#f1edff";
			}
			if (cnt % 7 == 0) { //일요일
				var str = "";
				str += "<div>" + i + "</div>";
				var day = (i < 10) ? "0" + i : i;
				str += "<div id='"+tdId+"'>";
				str += "</div>";
				cell.innerHTML = str;
				row = calendar.insertRow();// 줄 추가
				cell.style.color = "#ed5353";
				cell.style.backgroundColor = "#f1edff";
			}
			//마지막 날짜가 지나면 일요일 칸 그리기
			if (lastDate.getDate() == i && ((cnt % 7) != 0)) {
				var add = 7 - (cnt % 7);
				for (var k = 1; k <= add; k++) {
					cell = row.insertCell();
					cnt = cnt + 1;
					if (cnt % 7 == 6) {//토요일
						/* cell.style.backgroundColor = "#f1edff"; */
					}
					if (cnt % 7 == 0) { //일요일
						/* cell.style.backgroundColor = "#f1edff"; */
					}
				}
			}
			//오늘날짜배경색
			if (today.getFullYear() == date.getFullYear()
					&& today.getMonth() == date.getMonth()
					&& i == date.getDate()) {
				cell.style.backgroundColor = "#e2f3da"; //오늘날짜배경색
			}

			//마지막 날짜가 지나면 일요일까지 칸 그리기
			if (lastDate.getDate() == i && ((cnt % 7) != 0)) {
				var add = 7 - (cnt % 7);
				for (var k = 1; k <= add; k++) {
					cell = row.insertCell();
					cnt = cnt + 1;
					if (cnt % 7 == 6) {//토요일
						cell.style.backgroundColor = "#f1edff";
					}
					if (cnt % 7 == 0) { //일요일
						cell.style.backgroundColor = "#f1edff";
					}
				}
			}
		}
		<c:forEach var="item" items="${commute}">
			var tdId = '<fmt:formatDate value="${item.EMP_COMMUTE_WORKDATE}" pattern="yyyy-MM-dd"/>'
			var clockIn = "${item.EMP_COMMUTE_CLOCKIN}";
			clockIn = clockIn.substring(10, clockIn.length - 5);			
			/* console.log(tdId); */
			var str = "";
			str +="<span style='font-weight: bold;color: #F7878E1'>" +clockIn+" </span><span style='color: #F7878E1;font-weight: bold;'>출근 </span>";
			if("${item.EMP_COMMUTE_CLOCKOUT}"){
				var clockOut = "${item.EMP_COMMUTE_CLOCKOUT}"
				clockOut = clockOut.substring(10, clockOut.length - 5);
				str += "<br><span style='font-weight: bold; color: #F7878E1;'>"+clockOut+ "</span><span style='color: #F7878E1;font-weight: bold;' > 퇴근</span> ";
			}
			
			if ("${item.EMP_COMMUTE_LATENESS}" === 'Y') {
				str += "<h4 style='color: #FF6464;'>지각</h4>";
			}

			document.getElementById(tdId).innerHTML = str;
		</c:forEach>
	}

	document.getElementById('commuteDetail').addEventListener('click', function() {
	    window.location.href = '${pageContext.request.contextPath}/commute/commuteDetail';
	});

</script>
<script src="${path }/resource/js/plugins/jquery/dist/jquery.min.js"></script>
<jsp:include page="/WEB-INF/views/common/footer.jsp" />