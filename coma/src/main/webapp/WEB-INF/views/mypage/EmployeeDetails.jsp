<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<c:set var="path" value="${pageContext.request.contextPath}"/>
<jsp:include page="/WEB-INF/views/common/header.jsp">
	<jsp:param name="id" value="mine" />
</jsp:include>

<script  src="${path }http://code.jquery.com/jquery-latest.min.js"></script>

<style>
.container {
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

#example-tel-input
</style>
<!-- TEAM COMA SPACE -->
<div class="coma-container" style="margin-top: 5px; margin-bottom: 5px;">
	<div class="container" style="text-align: center; margin-top: 40px; margin-bottom: 5px;">
			<div class="row">
				<div class="col-2">
					<h1>직원 정보</h1>
				</div>					
			</div>
			<div class="row">
				<div class="col-6">
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
					<div>
						<div class="row">
							<div class="form-group col-6">
							<form action="${path}/mypage/EmployeeDetailEnd" method="post">	
							<label for="dept" class="form-control-label">부서</label>
							    <select class="form-control" id="dept " name="dept">
								    <option value='D6' <c:if test="${emp.dept.deptType eq '미배치'}"> selected="selected" </c:if>>미배치</option>
							    	<option value='D3' <c:if test="${emp.dept.deptType eq '회계'}"> selected="selected" </c:if>>회계팀</option>
							        <option value='D2' <c:if test="${emp.dept.deptType eq '행정'}"> selected="selected" </c:if>>행정팀</option>
							        <option value='D4' <c:if test="${emp.dept.deptType eq '교육'}"> selected="selected" </c:if>>교육팀</option>
							        <option value='D5' <c:if test="${emp.dept.deptType eq '취업'}"> selected="selected" </c:if>>취업팀</option>
							        <option value='D1' <c:if test="${emp.dept.deptType eq '관리'}"> selected="selected" </c:if>>관리부</option>
							    </select>
						    </div>
						    <div class="form-group col-6">
							    <label for="job" class="form-control-label">직책</label>
							    <select class="form-control" id="job" name="job">
							        <option value='J4' <c:if test="${emp.job.jobType eq '사원'}"> selected="selected" </c:if>>사원</option>
							        <option value='J3' <c:if test="${emp.job.jobType eq '팀장'}"> selected="selected" </c:if>>팀장</option>
							        <option value='J2' <c:if test="${emp.job.jobType eq '부장'}"> selected="selected" </c:if>>부장</option>
							        <option value='J1' <c:if test="${emp.job.jobType eq '관리자'}"> selected="selected" </c:if>>관리자</option>
							        <option value='TT' <c:if test="${emp.job.jobType eq '강사'}"> selected="selected" </c:if>>강사</option>							        
							        <option value='J5' <c:if test="${emp.job.jobType eq '인턴'}"> selected="selected" </c:if>>인턴</option>
							    
							    </select>
							</div>
	
						 </div>
						 <div class="row">
						 	<div class="form-group col-6"">
						        <label for="example-number-input" class="form-control-label">연차</label>
						       <c:set var="empVacation" value="${emp.empVacation}" />
									<c:choose>
									    <c:when test="${empVacation % 1 == 0}">
									        <fmt:formatNumber var="formattedNumber" value="${empVacation}" pattern="0" />
							 				<input class="form-control" type="number" value="${formattedNumber}" id="example-number-input" name = "empVacation" oninput="validateInput()">
									    </c:when>
									    <c:otherwise>
						        			<input class="form-control" type="number" value="${emp.empVacation}" id="example-number-input" name = "empVacation"oninput="validateInput()">
									    </c:otherwise>
									</c:choose>	
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
				    <button type="submit" class="btn btn-primary"  >회원정보 변경</button>
				</div>
			</div>
		</div>
		</form>
	</div>
</div>
<script>
document.addEventListener("DOMContentLoaded", function() {
    var initialVacationValue = "${emp.empVacation}";
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
//유효성 검사 함수
function validateInput() {
  var inputElement = document.getElementById("example-number-input");
  var inputValue = inputElement.value;

  // 음수인 경우 경고 메시지 출력 및 입력값 초기화
  if (inputValue < 0) {
    alert("음수는 입력할 수 없습니다.");
    inputElement.value = "";
  }
}
</script>


<!-- TEAM COMA SPACE -->
<jsp:include page="/WEB-INF/views/common/footer.jsp" />