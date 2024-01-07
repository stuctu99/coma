<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>	
<jsp:include page="/WEB-INF/views/common/header.jsp">
	<jsp:param name="id" value="mine" />
</jsp:include>
<script src='https://cdn.jsdelivr.net/npm/fullcalendar/index.global.min.js'></script>
 <script>
      document.addEventListener('DOMContentLoaded', function() {
        const calendarEl = document.getElementById('calendar')
        const calendar = new FullCalendar.Calendar(calendarEl, {
          initialView: 'dayGridMonth',
          expandRows: true, // 화면에 맞게 높이 설정
        })
        calendar.render()
      })

    </script>


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

</style>
<c:set var="emp" value="${sessionScope.SPRING_SECURITY_CONTEXT.authentication.principal }"/>
<div class="coma-container"
	style="margin-top: 5px; margin-bottom: 5px; padding: 50px;">
	<div class="row">
		<div class=" col-4">
			<div class="row">
				<div class="col-12">
					<h2>근무체크</h2>
				</div>
			</div>
			<div class="bigContainer"
				style="text-align: center; padding: 50px; background-color: #f1edff; border-radius: 20px;">
				<h1 class="current-time" id="current-time">09:11:32</h1>
				<div class="row" class="row"
					style="display: flex; flex-direction: row; justify-content: space-evenly;">
					<div>
						<i class="ni ni-briefcase-24"></i>
					</div>
					<div>
						<i class="ni ni-button-pause"></i>
					</div>
					<div>
						<i class="ni ni-button-play"></i>
					</div>
					<div>
						<i class="ni ni-spaceship"></i>
					</div>
				</div>
				<div class="row " 
					style="display: flex; flex-direction: row; justify-content: space-evenly;">
					<div>출근하기</div>
					<div>외출하기</div>
					<div>복귀하기</div>
					<div>퇴근하기</div>
				</div>
				<div class="row "
					style="display: flex; flex-direction: row; justify-content: space-evenly;">
					<div>08:51</div>
					<div>11:50</div>
					<div>15:23</div>
					<div>18:01</div>
				</div>
			</div>
			<div class="row">
				<div class="col-12">
					<h2>휴가현황</h2>
				</div>
			</div>
			<div class="bigContainer"
				style="text-align: center; padding: 50px; background-color: #f1edff; border-radius: 20px;">
				<h5>잔여 휴가 18일 남았습니다.</h5>
				<button type="button" class="btn btn-primary">휴가 신청</button>
				<button type="button" class="btn btn-primary">휴가 신청</button>
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
				                    <td>${mainNotice.empId}</td>
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


<!-- TEAM COMA SPACE -->
<jsp:include page="/WEB-INF/views/common/footer.jsp" />