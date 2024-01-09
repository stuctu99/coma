<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>	
<jsp:include page="/WEB-INF/views/common/header.jsp">
	<jsp:param name="id" value="mine" />
</jsp:include>
<script src='https://cdn.jsdelivr.net/npm/fullcalendar/index.global.min.js'></script>

<!-- TEAM COMA SPACE -->
<style>
/*   div{
	border: 2px solid red;
}   */

.bigContainer{
	box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
	text-align: center;
	padding: 50px 50px 50px 70px;
	background-color: #f1edff;
	border-radius: 20px;
}
.bigContainer2{
	box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
	text-align: center;
	padding: 30px;
	background-color: #f1edff;
	border-radius: 50px;
}
#calendar{
	height: 500px;
}

 td{
	    padding: 15px;
} 


.btncss {
	box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
    display: inline-block;
    padding: 10px 15px;
    background-color: #5e72e4;
    color: #fff;
    border: none;
    border-radius: 5px;
    cursor: pointer;
}

.btn i {
    margin-right: 5px;
}

</style>
<c:set var="emp" value="${sessionScope.SPRING_SECURITY_CONTEXT.authentication.principal }"/>
<div class="coma-container"style="margin-top: 5px; margin-bottom: 5px; padding: 50px;">
<%-- ${myCommute.commuteClockin}
${myCommute}
${formattedClockin}  --%>
	<div class="row">
		<div class=" col-4">
			<div class="row">
				<div class="col-12">
					<h2>근무체크</h2>
				</div>
			</div>
			<div class="bigContainer" style="text-align: center; padding: 50px; background-color: #f1edff; border-radius: 20px;">
				<h1 id="stopwatch" >00:00:00</h1>
				<div class="row" style="display: flex; flex-direction: row; justify-content: space-evenly;">
					<c:choose>
					    <c:when test="${myCommute == null}">
					        <div class=" col-3" id="clockin">
					        	<div class="btncss" id="clockin1"> 
					            	<i class="ni ni-briefcase-24"  ></i>
					            </div>
					        </div>
					    </c:when>
					    <c:otherwise>
					        <div class="col-3" id="clockin"> </div>
					    </c:otherwise>
					</c:choose>
					<c:choose>
					    <c:when test="${myCommute.commuteStarttime == null}">
					        <div class=" col-3" id="starttime">
					        	<div class="btncss" id="starttime1">
					            	<i class="ni ni-button-pause" ></i>
					            </div>
					        </div>
					    </c:when>
					    <c:otherwise>
					        <div class="col-3" id="starttime"> </div>
					    </c:otherwise>
					</c:choose>
					<c:choose>
					    <c:when test="${myCommute.commuteEndtime == null}">
					        <div class=" col-3" id="endtime">
					        	<div class="btncss" id="endtime1">
					            	<i class="ni ni-button-play"></i>
					            </div>
					        </div>
					    </c:when>
					    <c:otherwise>
					        <div class="col-3" id="endtime"> </div>
					    </c:otherwise>
					</c:choose>
					<c:choose>
					    <c:when test="${myCommute.commuteClockout == null}">
					        <div class="col-3" id="clockout">
					        	<div class="btncss" id="clockout1">
					            	<i class="ni ni-spaceship"></i>
					            </div>
					        </div>
					    </c:when>
					    <c:otherwise>
					        <div class="col-3" id="clockout"> </div>
					    </c:otherwise>
					</c:choose>
					
				</div>
				<div class="row "  style="display: flex; flex-direction: row; justify-content: space-evenly;">
					<label for="clockin" class="form-control-label">출근</label>
					<label for="starttime" class="form-control-label">외출하기</label>
					<label for="endtime" class="form-control-label">복귀하기</label>
					<label for="clockout" class="form-control-label">퇴근하기</label>

				</div>
				<div class="row " style="display: flex; flex-direction: row; justify-content: space-evenly;">										
				    <div id="clockInResult" class="col-3"><fmt:formatDate value="${myCommute.commuteClockin}" pattern="HH:mm:ss" /></div>
				    <div id="starttimeResult" class="col-3"><fmt:formatDate value="${myCommute.commuteStarttime}" pattern="HH:mm:ss" /></div>
				    <div id="endtimeResult" class="col-3"><fmt:formatDate value="${myCommute.commuteEndtime}" pattern="HH:mm:ss" /></div>
				    <div id="clockoutResult" class="col-3"><fmt:formatDate value="${myCommute.commuteClockout}" pattern="HH:mm:ss" /></div>					
					<!-- <div class="col-3" id="clockInResult"></div>
					<div class="col-3" id="starttimeResult"></div>
					<div class="col-3" id="endtimeResult"></div>
					<div class="col-3" id="clockoutResult"></div> -->
				</div>
			</div>
			<div class="row">
				<div class="col-12">
					<h2>휴가현황</h2>
				</div>
			</div>
			<div class="bigContainer"
				style="text-align: center; padding: 50px; background-color: #f1edff; border-radius: 20px;">
				<h4>잔여 휴가 ${emp.empVacation} 일 남았습니다.</h4>
				<button type="button" class="btn btn-primary">휴가 신청</button>
				<button type="button" class="btn btn-primary" id="vacationButton">휴가 근황</button>
			</div>
			<div class="row">
				<div class="col-12">
					<h2>내 일정</h2>
				</div>
			</div>
			<div class="bigContainer2">
				<div id='calendar'></div>
			</div>
		</div>
		
		<div class=" col-8">
			<div class="bigContainer"  >
				<div class = "row">
					<div class= col-12 style="text-align: center;">
						<h1 style="text-align: center; margin : 150px;"> <i class="ni ni-world"></i>${emp.dept.deptType }과 ${emp.empName }님 환영합니다 </h1>
					</div>
				</div>
				<div class = "row" style="padding:30px;">
					<div class= col-12>
						<h1><i class="ni ni-check-bold"></i>공지사항 </h1>
					</div>
				</div>
				<div class = "row" style="padding:30px;">
					<div class= col-12 style="text-align: -webkit-center;">
						<table>
							<c:forEach var="mainNotice" items="${mainNotice}">
				                <tr>
				                	<td>${mainNotice.boardNo }</td>
				                    <%-- <td>${mainNotice.emp.empId}</td>
				                    <td>${mainNotice.emp.empName}</td> --%>
				                    <td><a href="/board/freePost?boardNo=${mainNotice.boardNo }">${mainNotice.boardTitle}</a></td>
				                    <td>${mainNotice.boardDate}</td>
				                </tr>
				            </c:forEach>
						</table>
					</div>
				</div>
			</div>
		</div>
	</div>
</div>
 <script>
/* 달력 */
 	document.addEventListener('DOMContentLoaded', function() {
	    const calendarEl = document.getElementById('calendar')
	    const calendar = new FullCalendar.Calendar(calendarEl, {
	    	initialView: 'dayGridMonth',
	        expandRows: true, // 화면에 맞게 높이 설정
	    })
	        calendar.render();
    });
//휴가 근황 페이지 전환되는 기능 
/* $(document).ready(function() {
    $('#vacationButton').click(function() {
        window.location.href = '${path}/mypage/vacationSituation';
    });
}); */
//출근하기 버튼누르기 !
function getFormatTime(date){
	var hh=date.getHours();
	hh = hh >= 10 ? hh : '0' +hh;
	var mm =date.getMinutes();
	mm = mm >= 10 ? mm : '0' +mm;
	var ss =date.getSeconds();
	ss = ss >= 10 ? ss : '0' +ss;
	return hh + ':'+mm + ':'+ ss ;
	
}
//출근하기 버튼을 눌렀을때
document.getElementById('clockin').addEventListener('click', function() {
    var empId = '${emp.empId}';
    var time = getFormatTime(new Date());
    fetch('${path}/commute/insertCommute', {
        method: "post",
        headers: { "Content-Type": "application/json" },
        body: JSON.stringify({
            empId: empId
        })
    }).then(response => {
        console.log(response);
        if (response.status != 200) {
            throw new Error("");
        }
        return response.json();
    }).then(result => {
        if (result > 0) {
            alert("출근했습니다.");
            var clockinDiv = document.getElementById('clockin1');
            clockinDiv.remove();
            document.getElementById('clockInResult').textContent = time;
        }
    }).catch(e => {
        alert(e);
    });
});


 //외출시작하기 눌렀을 때
 document.getElementById('starttime').addEventListener('click', function() {
    var empId = '${emp.empId}';
    var time = getFormatTime(new Date());
    fetch('${path}/commute/updatestarttime', {
        method: "post",
        headers: { "Content-Type": "application/json" },
        body: JSON.stringify({
            empId: empId
        })
    }).then(response => {
        console.log(response);
        if (response.status != 200) {
            throw new Error("");
        }
        return response.json();
    }).then(result => {
        if (result > 0) {
            alert("외출을 시작합니다.");
            var clockinDiv = document.getElementById('starttime1');
            clockinDiv.remove();
            document.getElementById('starttimeResult').textContent = time;
        }
    }).catch(e => {
        alert(e);
    });
});
 //외출하고 돌아왔을 때  눌렀을 때
 document.getElementById('endtime').addEventListener('click', function() {
    var empId = '${emp.empId}';
    var time = getFormatTime(new Date());
    fetch('${path}/commute/updateEndtime', {
        method: "post",
        headers: { "Content-Type": "application/json" },
        body: JSON.stringify({
            empId: empId
        })
    }).then(response => {
        console.log(response);
        if (response.status != 200) {
            throw new Error("");
        }
        return response.json();
    }).then(result => {
        if (result > 0) {
            alert("근무를 시작합니다.");
            var clockinDiv = document.getElementById('endtime1');
            clockinDiv.remove();
            document.getElementById('endtimeResult').textContent = time;
        }
    }).catch(e => {
        alert(e);
    });
});
//퇴근 눌렀을 때
 document.getElementById('clockout').addEventListener('click', function() {
    var empId = '${emp.empId}';
    var time = getFormatTime(new Date());
    fetch('${path}/commute/updateclockout', {
        method: "post",
        headers: { "Content-Type": "application/json" },
        body: JSON.stringify({
            empId: empId
        })
    }).then(response => {
        console.log(response);
        if (response.status != 200) {
            throw new Error("");
        }
        return response.json();
    }).then(result => {
        if (result > 0) {
            alert("퇴근합니다.");
            var clockinDiv = document.getElementById('clockout1');
            clockinDiv.remove();
            document.getElementById('clockoutResult').textContent = time;
        }
    }).catch(e => {
        alert(e);
    });
});



</script>

<!-- TEAM COMA SPACE -->
<jsp:include page="/WEB-INF/views/common/footer.jsp" />