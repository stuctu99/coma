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
			        <th>
			          <div class="custom-control custom-checkbox">
			            <input type="checkbox" class="custom-control-input" id="checkOutToggle" onclick="fn_Checkboxes('checkOut')">
			            <label class="custom-control-label" for="checkOutToggle">퇴실 여부</label>
			          </div>
			        </th>
			      </tr>
		        </thead>
		        <tbody class="list" id="studentTable">
		        	<form action="" method="post">
			        <c:forEach var="s" items="${students }">
			        	<tr>
			        		<td><c:out value="${s.STU_NO }"/></td>
			        		<td><button type="button" class="btn btn-secondary btn-sm" onclick="fn_stuInfo('${s.STU_NO }');" id="stuName"><c:out value="${s.STU_NAME }"/></button></td>
			        		<td><c:out value="${s.EMP_NAME }"/></td>
			        		<td>
								<input type="checkbox" name="attendance" value="${s.STU_NO }">
			        		</td>
			        		<td>
			        			<input type="checkbox" name="checkOut" value="${s.STU_NO }">
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
				<div class="col-6">
				    <div class="form-group">
				        <label for="example-text-input" class="form-control-label">이름</label>
				        <input class="form-control" type="text" value="학생 이름" id="example-text-input">
				    </div>
				    <div class="form-group">
				        <label for="example-datetime-local-input" class="form-control-label">강의 시작일</label>
				        <input class="form-control" type="date" value="2018-11-23" id="example-search-input">
				    </div>
				    <div class="form-group">
				        <label for="example-datetime-local-input" class="form-control-label">수료일</label>
				        <input class="form-control" type="date" value="2018-11-23" id="example-email-input">
				    </div>
				    <div class="form-group">
				        <label for="example-datetime-local-input" class="form-control-label">생일</label>
				        <input class="form-control" type="date" value="2018-11-23" id="example-datetime-local-input">
				    </div>
				</div>
			</div>
			<h1>출석 현황</h1>
			<div class="row">
				<div class="4">
			        <label for="example-text-input" class="form-control-label">총 출석 수</label>
			        <input class="form-control" type="text" value="0/120" id="example-text-input" style="text-align:center;">
				</div>
				<div class="8">
			        <div style="width:470px; margin-left: 10px;">
					  <div class="progress-info" style="margin-top: 3px;">
					    <label for="example-text-input" class="form-control-label">출석일 수/총 수업일 수</label>
					    <div class="progress-percentage">
					      <span>80%</span>
					    </div>
					  </div>
					  <div class="progress" style="margin-top: 15px;">
					    <div class="progress-bar bg-primary" role="progressbar" aria-valuenow="0" aria-valuemin="0" aria-valuemax="100" style="width: 80%;"></div>
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

	      checkboxes.forEach(function(checkbox) {
	        checkbox.checked = masterCheckbox.checked;
	      });
	}
	
	//학생 정보 출력
	function fn_stuInfo(stuNo) {
		console.log(stuNo);
		fetch("${path}/student/infoStudent",{
			stuNo=stuNo
		}).then(response=>{
			if(response.status!=200) throw new Error(repsonse.status);
			return response.json();
		}).then(result=>{
			//이름
			const $div1=document.createElement("div");
			const $input1=documnet.createElement("input");
			const $label1=documnet.createElement("label");
			//강의 시작일
			const $div2=document.createElement("div");
			const $input2=documnet.createElement("input");
			const $label2=documnet.createElement("label");
			//수료일
			const $div3=document.createElement("div");
			const $input3=documnet.createElement("input");
			const $label3=documnet.createElement("label");
			//생일
			const $div4=document.createElement("div");
			const $input4=documnet.createElement("input");
			const $label4=documnet.createElement("label");
			//총 출석수
			const $div5=document.createElement("div");
			const $input5=documnet.createElement("input");
			const $label5=documnet.createElement("label");
			
			//개인 출석율
			const $div6=document.createElement("div");
			const $div7=document.createElement("div");
			const $div8=document.createElement("div");
			const $label6=documnet.createElement("label");
			const $div9=document.createElement("div");
			const $span=document.createElement("span");
			const $div10=document.createElement("div");
			const $div11=document.createElement("div");
				
		}).catch(e=>{
			console.log(e);
		})
	}

//FRTCH()함수 참조 태그
/*  <div class="form-group">
     <label for="example-text-input" class="form-control-label">이름</label>
     <input class="form-control" type="text" value="학생 이름" id="example-text-input">
 </div>
 <div class="form-group">
     <label for="example-datetime-local-input" class="form-control-label">강의 시작일</label>
     <input class="form-control" type="date" value="2018-11-23" id="example-search-input">
 </div>
 <div class="form-group">
     <label for="example-datetime-local-input" class="form-control-label">수료일</label>
     <input class="form-control" type="date" value="2018-11-23" id="example-email-input">
 </div>
 <div class="form-group">
     <label for="example-datetime-local-input" class="form-control-label">생일</label>
     <input class="form-control" type="date" value="2018-11-23" id="example-datetime-local-input">
 </div>

	
<div class="4">
    <label for="example-text-input" class="form-control-label">총 출석 수</label>
    <input class="form-control" type="text" value="0/120" id="example-text-input" style="text-align:center;">
</div>
<div class="8">
    <div style="width:470px; margin-left: 10px;">
	  <div class="progress-info" style="margin-top: 3px;">
	    <label for="example-text-input" class="form-control-label">출석일 수/총 수업일 수</label>
	    <div class="progress-percentage">
	      <span>80%</span>
	    </div>
	  </div>
	  <div class="progress" style="margin-top: 15px;">
	    <div class="progress-bar bg-primary" role="progressbar" aria-valuenow="0" aria-valuemin="0" aria-valuemax="100" style="width: 80%;"></div>
	  </div>
	</div>
</div> */
</script>
<!-- TEAM COMA SPACE -->
<jsp:include page="/WEB-INF/views/common/footer.jsp"/>s