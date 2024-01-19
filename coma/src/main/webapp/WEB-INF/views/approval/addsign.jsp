<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<jsp:include page="/WEB-INF/views/common/header.jsp">
	<jsp:param name="id" value="mine" />
</jsp:include>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<script src="https://uicdn.toast.com/editor/latest/toastui-editor-all.min.js"></script>
<script src="/resource/js/jquery-3.7.0.js"></script>

<link href="/resource/css/approval/viewdoc.css" rel="stylesheet" />
<c:set var="loginMember" value="${sessionScope.SPRING_SECURITY_CONTEXT.authentication.principal }"/> 
    <!-- TEAM COMA SPACE -->

    <div class="coma-container" style="margin-top:5px; margin-bottom: 5px;">
        <div class="container" style="text-align: left; margin-top:5px; margin-bottom: 5px;">
          <!-- coma content space -->
    
          <div class="doc_basic">
            <form method="post" enctype="multipart/form-data" action="${pageContext.request.contextPath }/approval/getSignImg">    
          	  <input type="hidden" name="empId" value="${loginMember.empId }">
          	  
          	   <div class="row">
          	   		<div class="col-8">
          	   			<h2>서명 새로 만들기</h2>
          	   			<span>
          	   				서명을 새로 그려 png파일로 저장합니다. 
          	   			</span>
          	   		</div>
          	   		<div class="col-2">
          	   			<input type="button" onclick="openSign();" class="btn btn-primary btn-lg" style="width:110px;" value="서명 만들기">
          	   		</div>
          	   		<div class="col-2">
          	   		</div>
          	   </div>
          	   <div class="row">
          	   		<div class="col-10">
          	   			<hr>
          	   		</div>
          	   		<div class="col-2">
          	   		</div>
          	   </div>		
          	   <div class="row">
	          	   	<div class="col-8">
	          	   		<h2>서명 가져오기</h2>
	          	   		<span>
	          	   			저장된 서명을 가져와 추가하기 버튼을 누르면 
	          	   			해당 아이디의 서명이 등록됩니다.
	          	   		</span>
	          	   	</div>
	          	   	<div class="col-4">
	          	   	</div>
          	   </div>
          	   <div class="row">
          	   		<div class="col-7">
          	   		  <div class="custom-file">
						        <input type="file" accept="image/*" name="imgFile" class="custom-file-input" id="customFileLang" lang="en">
						        <label class="custom-file-label" for="customFileLang">서명 가져오기</label>
						    </div>
          	   		</div>
          	   		<div class="col-1"></div>
          	   		<div class="col-2">
          	   			<input type="hidden" name="imgName">
						<input type="submit" value="추가하기" class="btn btn-primary btn-lg" style="width:110px;">
          	   		</div>
          	   		<div class="col-2">
          	   		
          	   		</div>
          	   </div>
          	    <div class="row">
          	   		<div class="col-10">
          	   			<hr>
          	   		</div>
          	   		<div class="col-2">
          	   		</div>
          	   </div>	
          	   <div class="row">
          	   		<div class="col-8">
          	   			<h2>결재 승인 예시</h2>
          	   			<span>
          	   				결재 승인 후 pdf로 문서 다운로드시 결재 승인란에 자동으로 서명이 추가됩니다.
          	   			</span>
          	   		</div>
          	   		<div class="col-2">
          	   		</div>
          	   		<div class="col-2">
          	   		</div>
          	   </div>
          	   <div class="row">
          	   		<div class="col-8">
          	   			<img src="${path }/resource/upload/sign/appr_example.png"/>
          	   		</div>
          	   		<div class="col-4">
          	   		</div>
          	   </div>
		</form>
          <!-- coma content space -->

        </div>
    </div>
    <!-- TEAM COMA SPACE -->
    </div>
  </div>





<script>


const openSign=()=>{
	/*  open("${path }/approval/newSign","_blank","width=350, height=350");*/
	
	var _width = '350';
	var _height = '350';

	// 팝업 화면 중앙에 띄우기
	var _left = Math.max(0, Math.floor((window.screen.width - parseInt(_width)) / 2));
	var _top = Math.max(0, Math.floor((window.screen.height - parseInt(_height)) / 2));

	window.open('${path}/approval/signCanvas', 'popup-test', 'width=' + _width + ', height=' + _height + ', left=' + _left + ', top=' + _top);


}

const chooseSign=()=>{
		
	
}

$(document).on("change",".custom-file-input",(e=>{
	
	const fileName = e.target.files[0].name;
	console.log(fileName)
	$(e.target).next(".custom-file-label").text(fileName);
	
}));

</script>
<jsp:include page="/WEB-INF/views/common/footer.jsp"/>


