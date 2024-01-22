<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<c:set var="path" value="${pageContext.request.contextPath}"/>
<jsp:include page="/WEB-INF/views/common/header.jsp">
	<jsp:param name="id" value="mine" />
</jsp:include>
<style>
/* 	div{
		border: 2px solid red;
	} */
	h1{
		margin:30px 0px 30px 0px;
	}
</style>
<c:set var="emp" value="${sessionScope.SPRING_SECURITY_CONTEXT.authentication.principal }"/>
	<div class="coma-container" style="margin-top:5px; margin-bottom: 5px; text-align:center; display: math;">
		<div class="row">
			<div class="col-1"></div>
			<div class="col-6">
				<h1>조직도</h1>
			</div>
			<div class="col-5">
				<h1>부서 소개</h1>
			</div>
		</div>
		<div class="row">
			<div class="col-1"></div>
			<div class="col-6">
				<div style="width: 100%; height: 100%;">
					<img src="${path }/resource/img/organization/COMA_demo.png" style="width: 100%; height: 650px; border-radius: 25px; box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);">
				</div>
			</div>
			<div class="col-5">
				<div class="row" style="display: flex; justify-content: space-evenly;">
					<div class="12">
					    <ul class="nav nav-pills nav-fill flex-column flex-md-row" id="tabs-icons-text" role="tablist">
					        <li class="nav-item">
					            <a class="nav-link mb-sm-3 mb-md-0 active" id="tabs-icons-text-1-tab" data-toggle="tab" href="#tabs-icons-text-1" role="tab" aria-controls="tabs-icons-text-1" aria-selected="true"><i class="ni ni-world-2 mr-2"></i>원장</a>
					        </li>
					        <li class="nav-item">
					            <a class="nav-link mb-sm-3 mb-md-0" id="tabs-icons-text-2-tab" data-toggle="tab" href="#tabs-icons-text-2" role="tab" aria-controls="tabs-icons-text-2" aria-selected="false"><i class="ni ni-folder-17 mr-2"></i>행정팀</a>
					        </li>
					        <li class="nav-item">
					            <a class="nav-link mb-sm-3 mb-md-0" id="tabs-icons-text-3-tab" data-toggle="tab" href="#tabs-icons-text-3" role="tab" aria-controls="tabs-icons-text-3" aria-selected="false"><i class="ni ni-hat-3 mr-2"></i>교육팀</a>
					        </li>
					        <li class="nav-item">
					            <a class="nav-link mb-sm-3 mb-md-0" id="tabs-icons-text-4-tab" data-toggle="tab" href="#tabs-icons-text-4" role="tab" aria-controls="tabs-icons-text-4" aria-selected="false"><i class="ni ni-single-02 mr-2"></i>취업팀</a>
					        </li>
					        <li class="nav-item">
					            <a class="nav-link mb-sm-3 mb-md-0" id="tabs-icons-text-5-tab" data-toggle="tab" href="#tabs-icons-text-5" role="tab" aria-controls="tabs-icons-text-5" aria-selected="false"><i class="ni ni-money-coins mr-2"></i>회계팀</a>
					        </li>
					    </ul>
					</div>
				</div>
				<div class="col-1"></div>
				<div class="row" style="display: flex; justify-content: center;">
					<div class="card shadow" style="height: 500px; margin-top: 20px; width: 600px;">
					    <div class="card-body">
					        <div class="tab-content" id="myTabContent">
					            <div class="tab-pane fade show active" id="tabs-icons-text-1" role="tabpanel" aria-labelledby="tabs-icons-text-1-tab">
					            	<h2>"COMA_THINK"</h2>
					                <p class="description">
					                	“인간다움”을 존중하는 소통과 공감을 소중하게 생각합니다.<br>
					                	먹고 살기 위한 단순 취업이나 취업률이라는 숫자만을 고집하지는 않습니다.<br>
					                	내가 하는 일에 대한 기여, 보람, 가치를 기반으로 미래를 꿈꾸는 것<br>
					                	그것이 바로 COMA Academy가 생각하는 취업입니다.<br>
					                	모두가 도전하고 목표하는 바를 이룰 수 있도록 최선을 다하겠습니다<br>
					                </p>
					                <h1 class="description"
					           >     	Coma Academy 대표 : 이원장
					                </h1>
					            </div>
					            <div class="tab-pane fade" id="tabs-icons-text-2" role="tabpanel" aria-labelledby="tabs-icons-text-2-tab">
					                <h2>"COMA_행정팀"</h2>
					                <p class="description">
					                	여러분들의 원활한 업무와 강의를 위해 노력하겠습니다.<br>
					                	365일 여러분의 뒤에서 튼튼한 버팀목 행정팀이 되겠습니다.<br>
					                </p>
					                <h1 class="description">
					                	부장 : 행부장<br>
					                	팀장 : 행팀장<br>
					                	사원 : 행사원<br>
					                </h1>
					            </div>
					            <div class="tab-pane fade" id="tabs-icons-text-3" role="tabpanel" aria-labelledby="tabs-icons-text-3-tab">
					                <h2>"COMA_교육팀"</h2>
					                <p class="description">
										“노력은 절대 배신하지 않는다. 노력하는 만큼 성장한다.”<br>
										사람마다 지식을 습득하는 시간에는 차이가 있습니다.<br>
										그 차이를 좁이기 위해서는 노력이 필요합니다.<br>
										그 노력에 힘을 실어주고 도움이 되어 드리겠습니다.<br>
										꾸준히 공부하고 노력한다면 누구든 멋진 개발자가 될 수 있습니다.<br>
										멋진 개발자가 되기 위한 기반을 만들어 드리겠습니다. 함께 노력하시죠!<br>
					                </p>
					                <h1 class="description">
					                	부장 : 교부장<br>
					                	팀장 : 교팀장<br>
					                	사원 : 교사원<br>
					                	강사 : 김강사<br>
					                	강사 : 유강사<br>
					                	강사 : 우강사<br>
					                	강사 : 최강사<br>
					                	강사 : 한강사<br>
					                </h1>
					            </div>
					            <div class="tab-pane fade" id="tabs-icons-text-4" role="tabpanel" aria-labelledby="tabs-icons-text-4-tab">
					                <h2>"COMA_취업팀"</h2>
					                <p class="description">
					                	“인생의 바다에서 방향을 고민하는 당신을 응원합니다.”<br>
										공부와 취업 준비는 어두운 터널을 지나는 과정이 아니라<br>
										나를 발견하고 인생의 방향을 결정하는 가슴뛰는 중요한 과정입니다.<br>
										그 과정의 시간을 헛되이 보내지 않도록 옆에서 도와드리겠습니다.<br>
					                </p>
					                <h1 class="description">
					                	부장 : 취부장<br>
					                	팀장 : 취팀장<br>
					                	사원 : 취사원<br>
					                </h1>
					            </div>
					            <div class="tab-pane fade" id="tabs-icons-text-5" role="tabpanel" aria-labelledby="tabs-icons-text-5-tab">
					            	<h2>"COMA_회계팀"</h2>
					                <p class="description">
										"여러분의 학원 생활에 부족함 없이 꼼꼼히 관리하는 회계팀이 되겠습니다."<br>
					                </p>
					                <h1 class="description">
					                	부장 : 회부장<br>
					                </h1>
					            </div>
					        </div>
					    </div>
					</div>
				</div>
			</div>
		</div>
	</div>
<!-- TEAM COMA SPACE -->
<jsp:include page="/WEB-INF/views/common/footer.jsp"/>