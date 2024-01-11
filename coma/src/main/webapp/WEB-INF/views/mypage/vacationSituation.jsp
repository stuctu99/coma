<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<jsp:include page="/WEB-INF/views/common/header.jsp">
	<jsp:param name="id" value="mine" />
</jsp:include>
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
	padding: 20px 10px 20px 20px;
	box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
}

.containerbig {
	margin: 50px;
	/* box-shadow: 0 0 10px rgba(0, 0, 0, 0.1); */
	text-align: center;
	/* padding: 50px 50px 50px 70px; */
	padding: 20px;
	/* background-color : white; */
	/*background-color: #f1edff; */
	border-radius: 20px;
}

.smallbox {
	border: 2px solid blue;
}

/* You may need to adjust the styling based on your specific requirements */
</style>
<div class="coma-container containerbig">
	<div class="row" style="text-align: center;">
		<div class="col-1"></div>
		<div class="col-10  bigbax">
			<div class="row">
				<h2 class="col-8">휴가 정보</h2>
				<button type="button" class="btn btn-primary">휴가 신청하기</button>
			</div>
			<div class="row">
				<div class="col-3 smallbox">
					<div class="">
						<h3 class="">지각</h3>
					</div>
					<div class="row">
						<p>1회</p>
					</div>
				</div>
				<div class=" col-3 smallbox">
					<div class=" ">
						<h3 class="">조기퇴근</h3>
					</div>
					<div class="row">
						<p>1회</p>
					</div>
				</div>
				<div class=" col-3 smallbox">
					<div class="">
						<h3 class="">퇴근미체크</h3>
					</div>
					<div class="row">
						<p>0회</p>
					</div>
				</div>
				<div class=" col-3 smallbox">
					<div class="">
						<h3 class="">결근</h3>
					</div>
					<div class="row">
						<p>0회</p>
					</div>
				</div>
			</div>
		</div>
		<div class="col-1"></div>
	</div>
	<div class="row">
		<div class=col-1></div>
		<div class="col-3 bigbax" style="text-align: center;">
			<div class="">
				<h3 class="">근무 요약</h3>
			</div>
			<div class="">
				<div class="">
					<div>
						<p class="">근무일수</p>
						<p>1일</p>
					</div>
					<div>
						<p class="">총근무시간</p>
						<p>17분</p>
					</div>
				</div>
			</div>
		</div>
		<div class="col-3 bigbax" style="text-align: center;">
			<div class="">
				<h3 class="">근무 시간</h3>
			</div>
			<div class="">
				<div class="">
					<div class="">
						<p>09:17</p>
						<p class="mt-2">출근</p>
					</div>
					<div class="text-center">
						<p>09:17</p>
						<p class="mt-2">퇴근</p>
					</div>
				</div>
				<button class="">근무시간 수정</button>
			</div>
		</div>
		<div class="col-3 bigbax" style="text-align: center;">
			<div class="">
				<h3 class="">근무 현황</h3>
			</div>
			<div class="">
				<div class="">
					<div>
						<p class="">근무일수</p>
						<p>1일</p>
					</div>
					<div>
						<p class="">총근무시간</p>
						<p>17분</p>
					</div>
					<div>
						<p class="">보정시간</p>
						<p>17분</p>
					</div>
				</div>
			</div>
		</div>
	</div>
</div>
<div class="coma-container">
	<div class="row">
		<!-- 총 12칸 -->
		<div class="col-4">1</div>
		<div class="col-4">2</div>
		<div class="col-4">3</div>
	</div>
</div>


<jsp:include page="/WEB-INF/views/common/footer.jsp" />