<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<c:set var="path" value="${pageContext.request.contextPath}"/>
<%-- <c:set var="emp" value="${sessionScope.SPRING_SECURITY_CONTEXT.authentication.principal }"/> --%>
<jsp:include page="/WEB-INF/views/common/header.jsp">
	<jsp:param name="id" value="mine" />
</jsp:include>
<script  src="http://code.jquery.com/jquery-latest.min.js"></script>

<style>
/*  div{
	border: 2px solid red;
}  */
.container {
	/* //max-width: 600px; */
	margin: 50px auto;
	background-color: #fff;
	padding: 20px;
	border-radius: 8px; //
	box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
}

form {
	display: flex;
	flex-direction: column;
	
}

label {
	margin-bottom: 8px;
}

input {
	margin-bottom: 16px;
	padding: 8px;
}

button {
	background-color: #4caf50;
	color: white;
	border: none;
	padding: 10px;
	text-align: center;
	text-decoration: none;
	display: inline-block;
	font-size: 16px;
	cursor: pointer;
}
h1 {
text-align: left;
}
label{
text-align: left;
}
/* .form-group{
	display: flex;
	align-items: center;

} */




#example-tel-input
</style>
<!-- TEAM COMA SPACE -->

<div class="coma-container" style="margin-top: 5px; margin-bottom: 5px;">
	<div class="container" style="text-align: center; margin-top: 5px; margin-bottom: 5px;">
		<!-- coma content space -->
		<form>
		<div class="row">
			<div class="col-6">
				<div class="file-btn" onclick="openFileDialog();">
					<img src="https://www.shutterstock.com/image-vector/vector-flat-illustration-grayscale-avatar-600nw-2264922221.jpg"
						alt="Profile Image" class="profile-image" style="width: 200px; height: 300px">	
				</div>
				<div>
					<div class="row">
						<div class="form-group col-6">
						<label for="dept">부서</label>
						    <select class="form-control" id="dept">
						    	<option value='회계' <c:if test="${emp.job.jobType eq '회계'}"> selected="selected" </c:if>>회계팀</option>
						        <option value='행정' <c:if test="${emp.job.jobType eq '행정'}"> selected="selected" </c:if>>행정팀</option>
						        <option value='강사' <c:if test="${emp.job.jobType eq '강사'}"> selected="selected" </c:if>>강사팀</option>
						        <option value='취업' <c:if test="${emp.job.jobType eq '취업'}"> selected="selected" </c:if>>취업팀</option>
						        <option value='관리' <c:if test="${emp.job.jobType eq '관리자'}"> selected="selected" </c:if>>관리부</option>
						    </select>
					    </div>
					    <div class="form-group col-6">
					    <label for="job">직책</label>
					    <select class="form-control" id="job">
					        <option value='사원' <c:if test="${emp.job.jobType eq '사원'}"> selected="selected" </c:if>>사원</option>
					        <option value='팀장' <c:if test="${emp.job.jobType eq '팀장'}"> selected="selected" </c:if>>팀장</option>
					        <option value='부장' <c:if test="${emp.job.jobType eq '부장'}"> selected="selected" </c:if>>부장</option>
					        <option value='관리자' <c:if test="${emp.job.jobType eq '관리자'}"> selected="selected" </c:if>>관리자</option>
					    </select>
					</div>

					 </div>
					<div class="form-group">
					    <label for="example-hiredate-input" class="form-control-label">채용일시</label>
					    <input class="form-control" type="date" value="${emp.empHireDate}" id="example-hiredate-input">
					</div>

					
				</div>
			</div>
			<div class="col-6">
				<div class="row">
					<div class="form-group col-6" >
				        <label for="example-id-input" class="form-control-label">아이디</label>
				        <input class="form-control" type="text" value="${emp.empId}" id="example-id-input" readonly>
				    </div>
	   			    <div class="form-group col-6">  			    
				        <label for="example-name-input" class="form-control-label">이름</label>
				        <input class="form-control" type="text" value="${emp.empName}" id="example-name-input" readonly>
				    </div>
				</div>
			    <div class="row">
				    <div class="form-group col-6" style="display:block">
				        <label for="example-birthday-input" class="form-control-label">생일</label>
				        <input class="form-control" type="date" value="${emp.empBrithDate}" id="example-birthday-input" readonly>
				    </div>
					<div class="form-group col-6">
				        <label for="example-gender-input" class="form-control-label">성별</label>
				        <input class="form-control" type="text" value="${emp.empGender == 'M' ? '남' : '여'}" id="example-gender-input" readonly>
				    </div>
			    </div>
			    <div class="form-group">
			        <label for="example-tel-input" class="form-control-label">전화번호</label>
			        <input type= "email" class="form-control" value= "${emp.empPhone}"  id="example-tel-input" readonly>
			    </div>
			    <div class="form-group" > 
				    <label for="address_kakao" class="form-control-label">주소 변경</label>
					<input class="form-control" type="text" id="address_kakao" name="address" value= "${emp.empAddr}" placeholder="주소입력시 클릭하세요." style="width:500px;" readonly>
					<input class="form-control" type="text" name="address_detail" value= "${emp.empAddrDetail}" placeholder="상세주소" style="width:500px;" readonly>
			    </div>
			    <button type="submit" class="btn btn-primary" >회원정보 변경</button>
			</div>
		</div>
	</div>
	</form>
</div>


<!-- TEAM COMA SPACE -->
<jsp:include page="/WEB-INF/views/common/footer.jsp" />