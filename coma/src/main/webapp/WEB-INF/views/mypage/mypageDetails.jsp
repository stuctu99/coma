<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<c:set var="path" value="${pageContext.request.contextPath}"/>
<c:set var="emp" value="${sessionScope.SPRING_SECURITY_CONTEXT.authentication.principal}"/>
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

select:disabled, select[readonly] {
    background-color:  #f1edff;  
}


</style>
<!-- TEAM COMA SPACE -->
<div class="coma-container" style="margin-top: 5px; margin-bottom: 5px;">
	<div class="container" style="text-align: center; margin-top: 5px; margin-bottom: 5px;">
		<!-- coma content space -->
		 <form id="employeeForm" action="${pageContext.request.contextPath}/mypage/updatemypage" method="post"  enctype="multipart/form-data">
			<div class="row">
				<div class="col-6">
				 <input type="file" id="accompany-file" name="empPhoto" accept="image/bmp,image/gif,image/jpg,image/jpeg,image/png,image/raw,image/tif,image/heif,image/heic,image/mp4,image/avi,image/mov,image/wmv,image/mkv,image/mpg,image/rm,image/asf,image/m4v,image/mpeg,image/mpg" style="display: none; margin: 0px; padding: 0px;">
					<div class="file-btn" onclick="openFileDialog();" style="cursor: pointer;">
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
						<h5>사진을 눌러주세요</h5>	
					</div>
					<div>
						<div class="row">
							<div class="form-group col-6">
						        <label for="example-deptCode-input" class="form-control-label">부서</label>
						        <input class="form-control" type="text" value="${emp.dept.deptType}" id="example-deptCode-input" style="background-color:  #f1edff;" readonly>
						    </div>
						    <div class="form-group col-6">
						        <label for="example-jobCode-input" class="form-control-label">직책</label>
						        <input class="form-control" type="text" value="${emp.job.jobType}" id="example-jobCode-input" style="background-color:  #f1edff;" readonly>
						    </div>
						 </div>
						<div class="row">
						 	<div class="form-group col-6">
							    <label for="exampleFormControlSelect1" class="form-control-label"">연차 개수 </label>
							 		<c:set var="empVacation" value="${emp.empVacation}" />
									<c:choose>
									    <c:when test="${empVacation % 1 == 0}">
									        <fmt:formatNumber var="formattedNumber" value="${empVacation}" pattern="0" />
							 				<input class="form-control" type="text" value="${formattedNumber}" id="exampleFormControlSelect1" style="background-color:  #f1edff;" readonly>
									    </c:when>
									    <c:otherwise>
							 				<input class="form-control" type="text" value="${emp.empVacation}" id="exampleFormControlSelect1" style="background-color:  #f1edff;" readonly>
									    </c:otherwise>
									</c:choose>	
							  </div>
							<div class="form-group col-6">
							    <label for="example-hiredate-input" class="form-control-label">채용일시</label>
							    <input class="form-control" type="date" value="${emp.empHireDate}" id="example-hiredate-input" style="background-color:  #f1edff;" disabled>
							</div>
						 </div>
					</div>
				</div>
				<div class="col-6">
					<div class="row">
						<div class="form-group col-6" >
					        <label for="example-id-input" class="form-control-label">아이디</label>
					        <input class="form-control" type="text" value="${emp.empId}" id="example-id-input" name="empId" style="background-color:  #f1edff;" readonly >
					    </div>
		   			    <div class="form-group col-6">
					        <label for="example-name-input" class="form-control-label">이름</label>
					        <input class="form-control" type="text" value="${emp.empName}" id="example-name-input" name="empName">
					    </div>
					</div>
					<div class="row">
					  <div class="form-group col-6" style="margin-bottom: 0;">
					    <label for="example-password-input" class="form-control-label">New Password</label>
					    <input class="form-control" type="password" placeholder="새 비밀번호" id="example-password-input" name="empPw">
					  </div>
					  <div class="form-group col-6" style="margin-bottom: 0;">
					    <label for="example-password2-input" class="form-control-label">Password</label>
					    <input class="form-control" type="password" placeholder="비밀번호 확인" id="example-password2-input">
					  </div>
					</div>
					<div class="row" style ="padding-left: 20px; padding-bottom: 30px;">
						<div id="passwordMatchMessage"></div>
					</div>
				    <div class="row">
					    <div class="form-group col-6" style="display:block">
					        <label for="example-birthday-input" class="form-control-label">생일</label>
					        <input class="form-control" type="date" value="${emp.empBrithDate}" id="example-birthday-input" name="empBrithDate">
					    </div>
						<div class="form-group col-6">
						    <label class="form-control-label">성별</label>
						    <div class="row">
						        <div class="custom-control custom-radio mb-3 col-4">
						            <input type="radio" id="customRadio1" name="empGender" value="M" class="custom-control-input"
						                   <c:if test="${emp.empGender == 'M'}">checked</c:if>>
						            <label class="custom-control-label" for="customRadio1">M</label>
						        </div>
						
						        <div class="custom-control custom-radio col-8">
						            <input type="radio" id="customRadio2" name="empGender" value="F" class="custom-control-input"
						                   <c:if test="${emp.empGender == 'F'}">checked</c:if>>
						            <label class="custom-control-label" for="customRadio2">F</label>
						        </div>
						    </div>
						</div>
				    </div>
				    <div class="form-group">
				        <label for="example-tel-input" class="form-control-label">전화번호</label>
				        <input type= "tel" class="form-control" value= "${emp.empPhone}"  id="example-tel-input" name="empPhone">
				    </div>
				    <div class="form-group"  > 
					    <label for="address_kakao" class="form-control-label">주소 변경</label>
						<input class="form-control" type="text" id="address_kakao" name="address" value= "${emp.empAddr}" placeholder="주소입력시 클릭하세요." style="width:500px;cursor: pointer;">
						<input class="form-control" type="text" name="address_detail" value= "${emp.empAddrDetail}" placeholder="상세주소" style="width:500px;">
				    </div>
				    <button type="button" class="btn btn-primary" onclick="submitEmployeeForm()">회원정보 변경</button>
				</div>
			</div>
		</div>
	</form>
</div>

<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
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


//카카오 지도 관련 함수 
window.onload = function(){
    document.getElementById("address_kakao").addEventListener("click", function(){ //주소입력칸을 클릭하면
        //카카오 지도 발생
        new daum.Postcode({
            oncomplete: function(data) { //선택시 입력값 세팅
                document.getElementById("address_kakao").value = data.address; // 주소 넣기
                document.querySelector("input[name=address_detail]").focus(); //상세입력 포커싱
            }
        }).open();
    });
}

//사진 부분을 누르면 input type이 file로 변하게 되는 함수. 
function openFileDialog() {
    const fileInput = document.querySelector('input[type=file]');
      fileInput.click();
      fileInput.addEventListener('change', function () {
         const selectedFiles = fileInput.files;
         console.log(selectedFiles);
     });
}
/* 사진 미리보기 기능 함수  */
$("#accompany-file").change(e => {
    $.each(e.target.files, (i, f) => {
        const filereader = new FileReader();
        filereader.readAsDataURL(f);
        filereader.onload = (e) => {
            console.log(e.target.result);
            $(".file-btn").attr("display", "none");
            const path = e.target.result;
            const img = $("<img>").attr({ "src": path, "width": "200px", "height": "250px" }).on("click",openFileDialog);
            $(".file-btn").html(img);
        }
    });
});
/* submit 기능 함수  */
function submitEmployeeForm() {
	var newPassword = $('#example-password-input').val();
    var confirmPassword = $('#example-password2-input').val();
    if (newPassword === confirmPassword) {
    	var form = document.getElementById("employeeForm");
        form.submit();
      } else {
        alert('비밀번호를 확인해주세요.');
        
      }
}


/* 비밀번호 확인 여부 ajax */
$(document).ready(function () {
    function checkPasswordMatch() {
      var newPassword = $('#example-password-input').val();
      var confirmPassword = $('#example-password2-input').val();
      var messageElement = $('#passwordMatchMessage');

      if (newPassword === confirmPassword) {
        messageElement.text('비밀번호가 일치합니다.');
        messageElement.css('color', 'green'); 
      } else {
        messageElement.text('비밀번호가 일치하지 않습니다.');
        messageElement.css('color', 'red');  
      }
    }

    $('#example-password-input, #example-password2-input').on('input', checkPasswordMatch);
  });
</script>

<!-- TEAM COMA SPACE -->
<jsp:include page="/WEB-INF/views/common/footer.jsp" />