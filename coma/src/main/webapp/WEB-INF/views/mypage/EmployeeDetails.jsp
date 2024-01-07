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
		 <form id="employeeForm" action="${path}/mypage/EmployeeDetailEnd" method="post">
		<div class="row">
			<div class="col-6">
				<div class="file-btn" ">
					<div class="file-btn" >
					  <%-- 프로필 이미지 가 없으면 기본이미지 --%>
						 <c:if test="${emp.empPhoto == null}" >
						 	<img src="${pageContext.request.contextPath}/resource/upload/profile/user.png" alt="Profile Image" id="profileImage" style="width: 200px; height: 300px">
	                     </c:if>
						 <%-- 프로필 이미지 가 있으면 이미지 --%>
	                      <c:if test="${emp.empPhoto != null}" >
								<img src="${pageContext.request.contextPath}/resource/upload/profile/${emp.empPhoto}" alt="Profile Image" id="profileImage"style="width: 200px; height: 300px">
	                      </c:if>
					</div>
				</div>
				<div>
					<div class="row">
						<div class="form-group col-6">
						<label for="dept" class="form-control-label">부서</label>
						    <select class="form-control" id="dept " name="dept">
						    	<option value='D3' <c:if test="${emp.job.jobType eq '회계'}"> selected="selected" </c:if>>회계팀</option>
						        <option value='D2' <c:if test="${emp.job.jobType eq '행정'}"> selected="selected" </c:if>>행정팀</option>
						        <option value='D4' <c:if test="${emp.job.jobType eq '강사'}"> selected="selected" </c:if>>강사팀</option>
						        <option value='D5' <c:if test="${emp.job.jobType eq '취업'}"> selected="selected" </c:if>>취업팀</option>
						        <option value='D1' <c:if test="${emp.job.jobType eq '관리자'}"> selected="selected" </c:if>>관리부</option>
						    </select>
					    </div>
					    <div class="form-group col-6">
						    <label for="job" class="form-control-label">직책</label>
						    <select class="form-control" id="job" name="job">
						        <option value='J4' <c:if test="${emp.job.jobType eq '사원'}"> selected="selected" </c:if>>사원</option>
						        <option value='J3' <c:if test="${emp.job.jobType eq '팀장'}"> selected="selected" </c:if>>팀장</option>
						        <option value='J2' <c:if test="${emp.job.jobType eq '부장'}"> selected="selected" </c:if>>부장</option>
						        <option value='J1' <c:if test="${emp.job.jobType eq '관리자'}"> selected="selected" </c:if>>관리자</option>
						    </select>
						</div>

					 </div>
					 <div class="row">
					 	<div class="form-group col-6">
						    <label for="exampleFormControlSelect1" class="form-control-label"">연차 개수 </label>
						    <select class="form-control" id="exampleFormControlSelect1" name="empVacation">
						      <option>1</option>
						      <option>2</option>
						      <option>3</option>
						      <option>4</option>
						      <option>5</option>
						      <option>6</option>
						      <option>7</option>
						      <option>8</option>
						      <option>9</option>
						      <option>10</option>
						      <option>11</option>
						      <option>12</option>
						      <option>13</option>
						      <option>14</option>
						      <option>15</option>
						      <option>16</option>
						      <option>17</option>
						      <option>18</option>
						      <option>19</option>
						      <option>20</option>
						      <option>21</option>
						      <option>22</option>
						      <option>23</option>
						      <option>24</option>
						      <option>25</option>
						    </select>
						  </div>
						<div class="form-group col-6">
						    <label for="example-hiredate-input" class="form-control-label">채용일시</label>
						    <input class="form-control" type="date" value="${emp.empHireDate}" id="example-hiredate-input" name="empHireDate">
						</div>

					 </div>
				</div>
			</div>
			<div class="col-6">
				<div class="row">
					<div class="form-group col-6" >
				        <label for="example-id-input" class="form-control-label">아이디</label>
				        <input class="form-control" type="text" value="${emp.empId}" name = "empId" id="example-id-input" style="background-color:  #f1edff;" readonly>
				    </div>
	   			    <div class="form-group col-6">  			    
				        <label for="example-name-input" class="form-control-label">이름</label>
				        <input class="form-control" type="text" value="${emp.empName}"  id="example-name-input" style="background-color:  #f1edff;" readonly>
				    </div>
				</div>
			    <div class="row">
				    <div class="form-group col-6" style="display:block">
				        <label for="example-birthday-input" class="form-control-label">생일</label>
				        <input class="form-control" type="date" value="${emp.empBrithDate}" id="example-birthday-input" style="background-color:  #f1edff;" readonly>
				    </div>
					<div class="form-group col-6">
				        <label for="example-gender-input" class="form-control-label">성별</label>
				        <input class="form-control" type="text" value="${emp.empGender == 'M' ? '남' : '여'}" id="example-gender-input" style="background-color:  #f1edff;" readonly>
				    </div>
			    </div>
			    <div class="form-group">
			        <label for="example-tel-input" class="form-control-label">전화번호</label>
			        <input type= "email" class="form-control" value= "${emp.empPhone}"  id="example-tel-input" style="background-color:  #f1edff;" readonly>
			    </div>
			    <div class="form-group" > 
				    <label for="address_kakao" class="form-control-label">주소 변경</label>
					<input class="form-control" type="text" id="address_kakao"  value= "${emp.empAddr}" placeholder="주소입력시 클릭하세요." style="width:500px; background-color:  #f1edff;" readonly>
					<input class="form-control" type="text"  value= "${emp.empAddrDetail}" placeholder="상세주소" style="width:500px; background-color:  #f1edff;" readonly>
			    </div>
			    <button type="submit" class="btn btn-primary" onclick="submitEmployeeForm();" >회원정보 변경</button>
			</div>
		</div>
	</div>
	</form>
</div>
<script>
document.addEventListener("DOMContentLoaded", function() {
    // Assuming emp.empVacation holds the initial value
    var initialVacationValue = "${emp.empVacation}";
    
    // Set the selected attribute based on the initial value
    var selectElement = document.getElementById("exampleFormControlSelect1");
    for (var i = 0; i < selectElement.options.length; i++) {
      if (selectElement.options[i].value === initialVacationValue) {
        selectElement.options[i].selected = true;
        break;
      }
    }
  });



function count(type)  {
	  // 결과를 표시할 element
	  const resultElement = document.getElementById('result');
	  
	  // 현재 화면에 표시된 값
	  let number = resultElement.innerText;
	  
	  // 더하기/빼기
	  if(type === 'plus') {
	    number = parseInt(number) + 1;
	  }else if(type === 'minus')  {
	    number = parseInt(number) - 1;
	  }
	  
	  // 결과 출력
	  resultElement.innerText = number;
	}
</script>


<!-- TEAM COMA SPACE -->
<jsp:include page="/WEB-INF/views/common/footer.jsp" />