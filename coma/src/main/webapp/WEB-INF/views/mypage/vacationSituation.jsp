<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<jsp:include page="/WEB-INF/views/common/header.jsp">
	<jsp:param name="id" value="mine" />
</jsp:include>
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
						<h1 style="text-align: center; margin : 150px;"> <i class="ni ni-world"></i>인사과 user1님, 환영합니다. </h1>
					</div>
				</div>
				<div class = "row" style="padding:30px;">
					<div class= col-12>
						<h1><i class="ni ni-check-bold"></i>공지사항 </h1>
					</div>
				</div>
				<div class = "row" style="padding:30px;">
					<div class= col-12>
						<table >
							<tr>
								<td>김코마</td>
								<td>새해가 밝았습니다</td>
								<td>2023.12.29</td>
							</tr>
							<tr>
								<td>김사장</td>
								<td>COMA에 산타가 나타났다! 이벤트</td>
								<td>2023.12.15</td>
							</tr>
							<tr>
								<td>김코마</td>
								<td>방역시간 안내공지</td>
								<td>2023.12.5</td>
							</tr>
							<tr>
								<td>김코마</td>
								<td>컴퓨터 설치 안내공지</td>
								<td>2023.11.20</td>
							</tr>
							<tr>
								<td>김코마</td>
								<td>간식이 간다 이벤트</td>
								<td>2023.11.5</td>
							</tr>
						</table>
					</div>
				</div>
			</div>
		</div>
	</div>
</div>
    <!-- TEAM COMA SPACE -->
<jsp:include page="/WEB-INF/views/common/footer.jsp"/>