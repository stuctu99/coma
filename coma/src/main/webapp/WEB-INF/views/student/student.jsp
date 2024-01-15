<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<c:set var="path" value="${pageContext.request.contextPath}"/>
<jsp:include page="/WEB-INF/views/common/header.jsp">
	<jsp:param name="id" value="mine" />
</jsp:include>
<c:set var="emp" value="${sessionScope.SPRING_SECURITY_CONTEXT.authentication.principal }"/>
<!-- <script type="text/javascript" src="https://www.gstatic.com/charts/loader.js"></script> -->
<script src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/2.4.0/Chart.min.js"></script>
<style>
/*   	div{
      border: 2px solid red;
    }  */
    
    input:read-only{
    	background-color:white;
    }
</style>
<div class="coma-container" style="margin-top:5px; margin-bottom: 5px;">
	<div class="row">
		<div class="col-1"></div>
		<div class="col-5" style="text-align:center;">
			<h1 style="">학생 리스트</h1>
			<div>
		    <table class="table align-items-center" style="text-align: center;">
		        <thead class="">
			      <tr>
			        <th>학생 번호</th>
			        <th>학생 이름</th>
			        <th>담당 강사</th>
			        <th>
			          <div class="custom-control custom-checkbox">
			            <input type="checkbox" class="custom-control-input" id="attendanceToggle" onclick="fn_Checkboxes('attendance')">
			            <label class="custom-control-label" for="attendanceToggle">출석 여부</label>
			          </div>
			        </th>
			      </tr>
		        </thead>
		        <tbody class="list" id="studentTable">
		        	<form action="/student/insertStudent" method="post">
			        <c:forEach var="s" items="${students }">
			        	<tr>
			        		<td><c:out value="${s.STU_NO }"/></td>
			        		<td><button type="button" class="btn btn-secondary btn-sm" onclick="fn_stuInfo('${s.STU_NO }');"><c:out value="${s.STU_NAME }"/></button></td>
			        		<td><c:out value="${s.EMP_NAME }"/></td>
			        		<td>
								<input type="checkbox" name="attendance" value="${s.STU_NO }" ${s.STU_COMMUTE_STATUS!='Y'?'':'disabled'}>
			        		</td>
			        	</tr>
			        </c:forEach>
		        </tbody>
		    </table>
		    <div class="row">
		    	<div class="col-1"></div>
		    	<div class="col-5"></div>
		    	<div class="col-6" style="display: flex; justify-content: flex-end;">
		    		<button type="reset" class="btn btn-default btn-sm">선택 취소</button>
					<button type="submit" class="btn btn-primary btn-sm">입력 완료</button>
		    	</div>
		    </div>
		    </form>
		</div>
		</div>
		<div class="col-5" style="text-align:center;">
			<h1 style="">학생 정보창</h1>
			<div class="row">
				<div class="col-6">
					<input type="file" id="accompany-file" name="studentPhoto" accept="image/bmp,image/gif,image/jpg,image/jpeg,image/png,image/raw,image/tif,image/heif,image/heic,image/mp4,image/avi,image/mov,image/wmv,image/mkv,image/mpg,image/rm,image/asf,image/m4v,image/mpeg,image/mpg" style="display: none; margin: 0px; padding: 0px;">
					<div class="file-btn" onclick="openFileDialog();" style="cursor: pointer; margin-top:50px;">
					 	<img src="${pageContext.request.contextPath}/resource/upload/profile/user.png" alt="Profile Image" id="profileImage" style="width: 300px; height: 300px;">
					</div>
				</div>
				<div class="col-6" id="stu_viewDetails">
				    <div class="form-group">
				        <label for="example-text-input" class="form-control-label">이름</label>
				        <input class="form-control" type="text" value="학생 이름" id="example-text-input" >
				    </div>
				    <div class="form-group">
				        <label for="example-datetime-local-input" class="form-control-label">강의 시작일</label>
				        <input class="form-control" type="date" value="" id="example-search-input" >
				    </div>
				    <div class="form-group">
				        <label for="example-datetime-local-input" class="form-control-label">수료일</label>
				        <input class="form-control" type="date" value="" id="example-email-input" >
				    </div>
				    <div class="form-group">
				        <label for="example-datetime-local-input" class="form-control-label">생일</label>
				        <input class="form-control" type="date" value="" id="example-datetime-local-input" >
				    </div>
				</div>
			</div>
			<h1>출석 현황</h1>
			<div class="row" id="stu_regulatoryStatus">
				<div class="col-4">
			        <label for="example-text-input" class="form-control-label">총 출석 수</label>
			        <input class="form-control" type="text" value="0/120" id="example-text-input" style="text-align:center;" >
				</div>
				<div class="col-8">
			        <div style="width:470px; margin-left: 10px;">
					  <div class="progress-info" style="margin-top: 3px;">
					    <label for="example-text-input" class="form-control-label">출석일 수/총 수업일 수</label>
					    <div class="progress-percentage">
					      <span>0%</span>
					    </div>
					  </div>
					  <div class="progress" style="margin-top: 15px;">
					    <div class="progress-bar bg-primary" role="progressbar" aria-valuenow="0" aria-valuemin="0" aria-valuemax="100" style="width: 0%;"></div>
					  </div>
					</div>
				</div>
			</div>
		</div>
		<div class="col-1"></div>
	</div>
</div>
<script>
	//체크 박스 전체 선택
	function fn_Checkboxes(checkboxName) {
	    const checkboxes = document.querySelectorAll('input[name="' + checkboxName + '"]');
	    const masterCheckbox = document.getElementById(checkboxName + 'Toggle');
	
	    checkboxes.forEach(function (checkbox) {
	        checkbox.addEventListener('change', function() {
	            // 체크박스가 disabled 상태가 아니고, 하나라도 체크가 풀리면 masterCheckbox 해제
	            if (!checkbox.disabled && !isCheckedAll(checkboxes)) {
	                masterCheckbox.checked = false;
	            } else {
	                // 모든 체크박스가 체크되면 masterCheckbox 선택
	                masterCheckbox.checked = isCheckedAll(checkboxes);
	            }
	        });
	    });
	
	    // 모든 체크박스가 체크되어 있는지 확인하는 함수
	    function isCheckedAll(checkboxes) {
	        return Array.from(checkboxes).every(function(checkbox) {
	            return checkbox.checked;
	        });
	    }
	
	    // masterCheckbox가 변경되었을 때 모든 체크박스의 상태를 일괄적으로 변경
	    masterCheckbox.addEventListener('change', function() {
	        checkboxes.forEach(function (checkbox) {
	            // 체크박스가 disabled 상태가 아닌 경우에만 선택 상태를 변경
	            if (!checkbox.disabled) {
	                checkbox.checked = masterCheckbox.checked;
	            }
	        });
	    });
	}
	
	//학생 정보 출력
	function fn_stuInfo(stuNo) {
		console.log(stuNo);
		fetch("${path}/student/infoStudent",{
			method:"post",
			headers:{"Content-Type":"application/json"},
			body:JSON.stringify({
				stuNo:stuNo
				
			})
		}).then(response=>{
			if(response.status!=200) throw new Error(repsonse.status);
			return response.json();
		}).then(student=>{
			console.log(student);
			const $divStuInfo = document.getElementById("stu_viewDetails");
			const $divStuRegulatoryStatus = document.getElementById("stu_regulatoryStatus");
			student.forEach(student=>{
				//이름
				const $div1=document.createElement("div");
				$div1.className = "form-group";
				const $input1=document.createElement("input");
				$input1.className = "form-control";
				$input1.type = "text";
				$input1.value = student.STU_NAME;
				$input1.id = "example-text-input";
				const $label1=document.createElement("label");
				$label1.className = "form-control-label";
				$label1.htmlFor = "example-text-input";
				$label1.textContent = "이름";
				$div1.appendChild($label1);
				$div1.appendChild($input1);
	
				//강의 시작일
				const $div2=document.createElement("div");
				$div2.className = "form-group";
				const $input2=document.createElement("input");
				$input2.className = "form-control";
				$input2.type = "date";
				const stuStart = student.STU_START_DATE.slice(0, 10);
				$input2.value = stuStart;
				$input2.id = "example-search-input";
				const $label2=document.createElement("label");
				$label2.className = "form-control-label";
				$label2.htmlFor = "example-datetime-local-input";
				$label2.textContent = "강의 시작일";
				$div2.appendChild($label2);
				$div2.appendChild($input2);
				
				//수료일
				const $div3=document.createElement("div");
				$div3.className = "form-group";
				const $input3=document.createElement("input");
				$input3.className = "form-control";
				$input3.type = "date";
				const stuEnd = student.STU_END_DATE.slice(0, 10);
				$input3.value = stuEnd;
				$input3.id = "example-email-input";
				const $label3=document.createElement("label");
				$label3.className = "form-control-label";
				$label3.htmlFor = "example-datetime-local-input";
				$label3.textContent = "수료일";
				$div3.appendChild($label3);
				$div3.appendChild($input3);
				
				//생일
				const $div4=document.createElement("div");
				$div4.className = "form-group";
				const $input4=document.createElement("input");
				$input4.className = "form-control";
				$input4.type = "date";
				const stuBirth = student.STU_BIRTH.slice(0, 10);
				$input4.value = stuBirth;
				$input4.id = "example-email-input";
				const $label4=document.createElement("label");
				$label4.className = "form-control-label";
				$label4.htmlFor = "example-datetime-local-input";
				$label4.textContent = "생일";
				$div4.appendChild($label4);
				$div4.appendChild($input4);
				
				while ($divStuInfo.firstChild) {
				    $divStuInfo.removeChild($divStuInfo.firstChild);
				};
				
				$divStuInfo.appendChild($div1);
				$divStuInfo.appendChild($div2);
				$divStuInfo.appendChild($div3);
				$divStuInfo.appendChild($div4);
				
				//총 출석수
				const $div5=document.createElement("div");
				$div5.className = "col-4";
				const $input5=document.createElement("input");
				$input5.className = "form-control";
				$input5.type = "text";
				$input5.value = student.COUNTATTENDANCE+"/120";
				$input5.id = "example-text-input";
				$input5.style.textAlign = "center";
				const $label5=document.createElement("label");
				$label5.className = "form-control-label";
				$label5.htmlFor = "example-text-input";
				$label5.textContent = "총 출석 수";
				$div5.appendChild($label5);
				$div5.appendChild($input5);
				
				
				//개인 출석율
				const $div6=document.createElement("div");
				$div6.className = "col-8";
				const $div7=document.createElement("div");
				$div7.style.width = "470px";
				$div7.style.marginLeft = "10px";
				const $div8=document.createElement("div");
				$div8.className = "progress-info";
				const $label6=document.createElement("label");
				$label6.className = "form-control-label";
				$label6.htmlFor = "example-text-input";
				$label6.textContent = "출석일 수/총 수업일 수";
				const $div9=document.createElement("div");
				$div9.className = "progress-percentage";
				const $span=document.createElement("span");
				$span.textContent = student.AVGATTENDANCE+"%";
				const $div10=document.createElement("div");
				$div10.className = "progress";
				$div10.style.marginTop = "15px";
				const $div11=document.createElement("div");
				$div11.className = "progress-bar bg-primary";
				$div11.role = "progressbar";
				$div11.ariaValuenow = "0";
				$div11.ariaValuemin = "0";
				$div11.ariaValuemax = "100";
				$div11.style.width = student.AVGATTENDANCE+"%";
				
				$div8.appendChild($label6);
				$div8.appendChild($div9);
				$div9.appendChild($span);
				$div10.appendChild($div11);
				$div7.appendChild($div8);
				$div7.appendChild($div10);
				$div6.appendChild($div7);
				
				while ($divStuRegulatoryStatus.firstChild) {
				    $divStuRegulatoryStatus.removeChild($divStuRegulatoryStatus.firstChild);
				};
				
				$divStuRegulatoryStatus.appendChild($div5);
				$divStuRegulatoryStatus.appendChild($div6);
			})
		}).catch(e=>{
			console.log(e);
		})
	}
</script>
<!-- TEAM COMA SPACE -->
<jsp:include page="/WEB-INF/views/common/footer.jsp"/>s