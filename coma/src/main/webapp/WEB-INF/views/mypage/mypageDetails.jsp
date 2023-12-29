<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<jsp:include page="/WEB-INF/views/common/header.jsp">
	<jsp:param name="id" value="mine" />
</jsp:include>

<style>
/* div{
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
		<div class="container">
			<div class="profile">
				<div>
				<img src="https://www.shutterstock.com/image-vector/vector-flat-illustration-grayscale-avatar-600nw-2264922221.jpg"
					alt="Profile Image" class="profile-image" style="width: 300px; height: 300px">
					
					<form>
						<div class="custom-file">
							<input type="file" class="custom-file-input" id="customFileLang" lang="en">
							<label class="custom-file-label" for="customFileLang">Select file</label>
						</div>
					</form>
				</div>
				<form>	
					<table>
						<tr>
							<td colspan='2'>
								<h1>나의 정보</h1>
							</td>
						</tr>
						<tr>
							<td>
								<div class="form-group" >
							        <label for="example-text-input" class="form-control-label">아이디</label>
							        <input class="form-control" type="text" value="user01" id="example-text-input">
							    </div>
							</td>
							<td>
								<div class="form-group">
							        <label for="example-text-input" class="form-control-label">이름</label>
							        <input class="form-control" type="text" value="정우현" id="example-text-input">
							    </div>
							</td>
						</tr>
						<tr>
							<td>
								 <div class="form-group" style="display:block">
							        <label for="example-date-input" class="form-control-label">생일</label>
							        <input class="form-control" type="date" value="2018-11-23" id="example-date-input">
							    </div>
							</td>
							<td>
								<div class="form-group">
							        <label for="example-text-input" class="form-control-label">성별</label>
							        <input class="form-control" type="text" value="여" id="example-text-input">
							    </div>
							</td>
						</tr>
						<tr>
							<td>
								 <div class="form-group">
							        <label for="example-email-input" class="form-control-label">Email</label>
							        <input type= "email" class="form-control" type="email" value="dngus@gus" id="example-email-input">
							    </div>
							</td>
							<td>
								<div class="form-group">
							        <label for="example-tel-input" class="form-control-label">연락처</label>
							        <input class="form-control" type="tel" value="01012345678" id="example-tel-input">
							    </div>
							</td>
						</tr>
						<tr>
							<td  colspan='2'> 
								<div class="form-group" > 
								    <label for="example-tel-input" class="form-control-label">주소 변경</label>
								    <div style="display:flex">
									    <input class="form-control" type="text" id="example-tel-input" placeholder="우편번호" style="width:150px;">
										<input type="button" onclick="sample6_execDaumPostcode()" value="우편번호 찾기">
									</div>
									<input class="form-control" type="text" id="example-tel-input" placeholder="주소" style="width:500px;">
									<input class="form-control" type="text" id="example-tel-input" placeholder="상세주소" style="width:500px;">
									<input class="form-control" type="text" id="example-tel-input" placeholder="참고항목" style="width:500px;">
							    </div>
							</td>
							<td>
							
							</td>
						</tr>
					</table>
					<table>
						<tr>
							<td colspan='2'>
								<h1>상세 정보</h1>
							</td>
						</tr>
						<tr>
							<td>
								<label for="dept">부서</label>
							    <select class="form-control" id="dept">
							      <option>회계팀</option>
							      <option>행정팀</option>
							      <option>강사팀</option>
							      <option>취업팀</option>
							      <option>관리자</option>
							    </select>
							</td>
							<td>
								<label for="job">직책</label>
							    <select class="form-control" id="job">
							      <option>사원</option>
							      <option>팀장</option>
							      <option>부장</option>
							      <option>관리자</option>
							    </select>
							</td>
						</tr>
						<tr>
							<td  colspan='2'>
								 <div class="form-group" >
							        <label for="example-date-input" class="form-control-label">채용일시</label>
							        <input class="form-control" type="date" value="2018-11-23" id="example-date-input">
							    </div>
							</td>
						</tr>
					</table>
				</form>
			</div>
		</div>
	</div>
</div>

<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script>
    function sample6_execDaumPostcode() {
        new daum.Postcode({
            oncomplete: function(data) {
                // 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.

                // 각 주소의 노출 규칙에 따라 주소를 조합한다.
                // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
                var addr = ''; // 주소 변수
                var extraAddr = ''; // 참고항목 변수

                //사용자가 선택한 주소 타입에 따라 해당 주소 값을 가져온다.
                if (data.userSelectedType === 'R') { // 사용자가 도로명 주소를 선택했을 경우
                    addr = data.roadAddress;
                } else { // 사용자가 지번 주소를 선택했을 경우(J)
                    addr = data.jibunAddress;
                }

                // 사용자가 선택한 주소가 도로명 타입일때 참고항목을 조합한다.
                if(data.userSelectedType === 'R'){
                    // 법정동명이 있을 경우 추가한다. (법정리는 제외)
                    // 법정동의 경우 마지막 문자가 "동/로/가"로 끝난다.
                    if(data.bname !== '' && /[동|로|가]$/g.test(data.bname)){
                        extraAddr += data.bname;
                    }
                    // 건물명이 있고, 공동주택일 경우 추가한다.
                    if(data.buildingName !== '' && data.apartment === 'Y'){
                        extraAddr += (extraAddr !== '' ? ', ' + data.buildingName : data.buildingName);
                    }
                    // 표시할 참고항목이 있을 경우, 괄호까지 추가한 최종 문자열을 만든다.
                    if(extraAddr !== ''){
                        extraAddr = ' (' + extraAddr + ')';
                    }
                    // 조합된 참고항목을 해당 필드에 넣는다.
                    document.getElementById("sample6_extraAddress").value = extraAddr;
                
                } else {
                    document.getElementById("sample6_extraAddress").value = '';
                }

                // 우편번호와 주소 정보를 해당 필드에 넣는다.
                document.getElementById('sample6_postcode').value = data.zonecode;
                document.getElementById("sample6_address").value = addr;
                // 커서를 상세주소 필드로 이동한다.
                document.getElementById("sample6_detailAddress").focus();
            }
        }).open();
    }
</script>

<!-- TEAM COMA SPACE -->
<jsp:include page="/WEB-INF/views/common/footer.jsp" />