<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<c:set var="path" value="${pageContext.request.contextPath}"/>
<c:set var="emp" value="${sessionScope.SPRING_SECURITY_CONTEXT.authentication.principal }"/>
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
		 <form id="employeeForm" action="${path}/mypage/updatemypage" method="post"  enctype="multipart/form-data">
		<div class="row">
			<div class="col-6">
			 <input type="file" id="accompany-file" name="profile" accept="image/bmp,image/gif,image/jpg,image/jpeg,image/png,image/raw,image/tif,image/heif,image/heic,image/mp4,image/avi,image/mov,image/wmv,image/mkv,image/mpg,image/rm,image/asf,image/m4v,image/mpeg,image/mpg" style="display: none; margin: 0px; padding: 0px;">
				<div class="file-btn" onclick="openFileDialog();">
					  <%-- 프로필 이미지 가 없으면 기본이미지 --%>
					 <c:if test="${empty loginMember.profileImage}" >
					 	<img src="https://www.shutterstock.com/image-vector/vector-flat-illustration-grayscale-avatar-600nw-2264922221.jpg"
							alt="Profile Image" class="profile-image" style="width: 200px; height: 300px">
					 	<!-- <img src="/resources/upload/profile/user.png" id="profileImage"> -->
                     </c:if>
					 <%-- 프로필 이미지 가 있으면 이미지 --%>
                        <c:if test="${!empty loginMember.profileImage}" >
                            <img src = "${emp.empPhoto}" id="profileImage">
                      </c:if>
					 
						
				</div>
				<div>
					<h5>사진을 눌러주세요</h5>	
				</div>
				<div>
					<div class="row">
						<div class="form-group col-6">
					        <label for="example-deptCode-input" class="form-control-label">부서</label>
					        <input class="form-control" type="text" value="${emp.dept.deptType}" id="example-deptCode-input" readonly>
					    </div>
					    <div class="form-group col-6">
					        <label for="example-jobCode-input" class="form-control-label">직책</label>
					        <input class="form-control" type="text" value="${emp.job.jobType}" id="example-jobCode-input" readonly>
					    </div>
					 </div>
					<div class="form-group" >
				        <label for="example-hiredate-input" class="form-control-label">채용일시</label>
				        <input class="form-control" type="date" value="${emp.empHireDate}" id="example-hiredate-input" readonly>
				    </div>
					
				</div>
			</div>
			<div class="col-6">
				<div class="row">
					<div class="form-group col-6" >
				        <label for="example-id-input" class="form-control-label">아이디</label>
				        <input class="form-control" type="text" value="${emp.empId}" id="example-id-input" name="empId" readonly>
				    </div>
	   			    <div class="form-group col-6">
				        <label for="example-name-input" class="form-control-label">이름</label>
				        <input class="form-control" type="text" value="${emp.empName}" id="example-name-input" name="empName">
				    </div>
				</div>
				<div class="row">
				    <div class="form-group col-6">
				        <label for="example-password-input" class="form-control-label">New Password</label>
				        <input class="form-control" type="newPwd" placeholder="새 비밀번호"  id="example-password-input" name="empPw" >
				    </div>
				    <div class="form-group col-6">
				        <label for="example-password2-input" class="form-control-label">Password</label>
				        <input class="form-control" type="checkPwd" placeholder="비밀번호 확인"  id="example-password2-input">
				    </div>
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
			    <div class="form-group" > 
				    <label for="address_kakao" class="form-control-label">주소 변경</label>
					<input class="form-control" type="text" id="address_kakao" name="address" value= "${emp.empAddr}" placeholder="주소입력시 클릭하세요." style="width:500px;">
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

//사진 누르면 파일  미리보기 기능 함수 
function openFileDialog() {
    const fileInput = document.querySelector('input[type=file]');
      fileInput.click();
      fileInput.addEventListener('change', function () {
         const selectedFiles = fileInput.files;
         console.log(selectedFiles);
     });
}
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
function submitEmployeeForm() {
    var form = document.getElementById("employeeForm");
    form.submit();
}
</script>

<!-- TEAM COMA SPACE -->
<jsp:include page="/WEB-INF/views/common/footer.jsp" />