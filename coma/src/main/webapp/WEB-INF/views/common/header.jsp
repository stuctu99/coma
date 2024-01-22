<%-- <%@ page import="com.coma.model.dto.Emp" %>
<%@ page import="org.springframework.security.core.context.SecurityContextHolder" %> --%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<c:set var="path" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="utf-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
  <title>
    Coma Academy
  </title>
  <!-- Favicon -->
  <link href="${path }/resource/img/brand/comacon.png" rel="icon" type="image/png">
  <!-- Fonts -->
  <link href="https://fonts.googleapis.com/css?family=Open+Sans:300,400,600,700" rel="stylesheet">
  <!-- Icons -->
  <link href="${path }/resource/js/plugins/nucleo/css/nucleo.css" rel="stylesheet" />
  <link href="${path }/resource/js/plugins/@fortawesome/fontawesome-free/css/all.min.css" rel="stylesheet" />
  <!-- CSS Files -->
  <link href="${path }/resource/css/argon-dashboard.css?v=1.1.2" rel="stylesheet" />
<!-- 1.19 15:27 jm 폰트추가 -->
<style>
	@import url('https://fonts.googleapis.com/css2?family=Noto+Sans+KR&display=swap');
	
	* {
	font-family: 'Noto Sans KR', sans-serif;
	}
</style>
</head>
<body class="">
  <c:set var="e" value="${sessionScope.SPRING_SECURITY_CONTEXT.authentication.principal }"/>
  <nav class="navbar navbar-vertical fixed-left navbar-expand-md navbar-light bg-white" id="sidenav-main">
    <div class="container-fluid">
      <!-- Toggler -->
      <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#sidenav-collapse-main" aria-controls="sidenav-main" aria-expanded="false" aria-label="Toggle navigation">
        <span class="navbar-toggler-icon"></span>
      </button>
      <!-- Brand -->
      <a class="navbar-brand pt-0" href="/">
        <img src="${path }/resource/img/brand/COMA2.png" class="navbar-brand-img" alt="...">
      </a>
      <!-- User -->
      <!-- <ul class="nav align-items-center d-md-none">
        <li class="nav-item dropdown">
          <div class="dropdown-menu dropdown-menu-arrow dropdown-menu-right">
            <div class=" dropdown-header noti-title">
              <h6 class="text-overflow m-0">Welcome!</h6>
            </div>
            <a href="./examples/profile.html" class="dropdown-item">
              <i class="ni ni-single-02"></i>
              <span>My profile</span>
            </a>
            <a href="./examples/profile.html" class="dropdown-item">
              <i class="ni ni-settings-gear-65"></i>
              <span>Settings</span>
            </a>
            <a href="./examples/profile.html" class="dropdown-item">
              <i class="ni ni-calendar-grid-58"></i>
              <span>Activity</span>
            </a>
            <a href="./examples/profile.html" class="dropdown-item">
              <i class="ni ni-support-16"></i>
              <span>Support</span>
            </a>
            <div class="dropdown-divider"></div>
            <a href="/logout" class="dropdown-item">
              <i class="ni ni-user-run"></i>
              <span>Logout</span>
            </a>
          </div>
        </li>
      </ul> -->
      <!-- Collapse -->
      <div class="collapse navbar-collapse" id="sidenav-collapse-main">
        <!-- Collapse header -->
        <div class="navbar-collapse-header d-md-none">
          <div class="row">
            <div class="col-6 collapse-brand">
              <a href="/">
                <img src="${path }/resource/img/brand/blue.png">
              </a>
            </div>
            <div class="col-6 collapse-close">
              <button type="button" class="navbar-toggler" data-toggle="collapse" data-target="#sidenav-collapse-main" aria-controls="sidenav-main" aria-expanded="false" aria-label="Toggle sidenav">
                <span></span>
                <span></span>
              </button>
            </div>
          </div>
        </div>

        <!-- Navigation -->
        <ul class="navbar-nav">
          <li class="nav-item  active ">
            <a class="nav-link  active " href="${path }/organization/organization">
              <i class="ni ni-tv-2 text-primary"></i> 조직도
            </a>
          </li>
          <li class="nav-item">
            <a class="nav-link ">
              <i class="ni ni-planet text-blue"></i> 전자결재
            </a>
            <ul class="sub-menu" style="display: none;list-style-type: none; font-size: 0.9rem; padding-left: 70px;">
              <li><a href="${pageContext.request.contextPath}/approval/addsign">서명 등록</a></li>
              <li><a href="${pageContext.request.contextPath}/approval/writedoc">결재신청</a></li>
              <li><a href="${path }/apprdoc/allList">문서함</a></li>
            </ul>
          </li>
          <li class="nav-item">
            <a class="nav-link " href="/calendar">
              <i class="ni ni-pin-3 text-orange"></i> 캘린더
            </a>
          </li>
          <li class="nav-item">
            <a class="nav-link ">
              <i class="ni ni-single-02 text-yellow"></i> 게시판
            </a>
            <ul class="sub-menu" style="display: none;list-style-type: none; font-size: 0.9rem; padding-left: 70px;">
              <li><a href="${path }/board/noticelist?boardType=0">공지게시판</a></li>
              <li><a href="${path }/board/freelist?boardType=1">자유게시판</a></li>
            </ul>
          </li>
          <li class="nav-item">
            <a class="nav-link ">
              <i class="ni ni-bullet-list-67 text-red"></i> 관리자 페이지
            </a>
            <ul class="sub-menu" style="display: none;list-style-type: none; font-size: 0.9rem; padding-left: 70px;">
              <li><a href="${path }/admin/adminEmp">사원관리</a></li>
              <li><a href="${path }/admin/adminStudent">학생관리</a></li>
              <li><a href="${path }/student/student">학생 페이지</a></li>
              <li><a href="${path }/student/studentEmp">학생 취업현황</a></li>
            </ul>
          </li>
          <li class="nav-item">
            <a class="nav-link" id="messenger-btn" onclick="messenger_active('${pageContext.request.contextPath}');">
             <i class="ni ni-chat-round text-primary"></i> 메신저
            </a>
          </li>
        </ul>
      </div>
    </div>
  </nav>

  <div class="main-content">
    
    <!-- Navbar -->
    <nav class="navbar navbar-top navbar-expand-md navbar-dark" id="navbar-main">
      <div class="container-fluid">
        <!-- Brand -->
        <a class="h4 mb-0 text-white text-uppercase d-none d-lg-inline-block" href="/">COMA GROUPWARE</a>
        <!-- User -->
        <ul class="navbar-nav align-items-center d-none d-md-flex">
          <li class="nav-item dropdown">
            <a class="nav-link pr-0" href="#" role="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
              <div class="media align-items-center">
                <span class="avatar avatar-sm rounded-circle">
               	<c:if test="${e.empPhoto == null}" >
				 	<img src="${path}/resource/upload/profile/user.png" alt="Profile Image" id="profileImage" style="width: 36px; height: 36px">
                 </c:if>
				 <%-- 프로필 이미지 가 있으면 이미지 --%>
                   <c:if test="${e.empPhoto != null}" >
						<img src="${path }/resource/upload/profile/${e.empPhoto}" alt="Profile Image" id="profileImage"style="width: 36px; height: 36px">
                   </c:if>
                </span>
                <div class="media-body ml-2 d-none d-lg-block">
                  <span class="mb-0 text-sm  font-weight-bold">${e.empName }</span>
                </div>
              </div>
            </a>
            <div class="dropdown-menu dropdown-menu-arrow dropdown-menu-right">
              <div class=" dropdown-header noti-title">
                <h6 class="text-overflow m-0">Welcome!</h6>
              </div>
              <a href="${path}/mypage/mypageDetails" class="dropdown-item">
                <i class="ni ni-single-02"></i>
                <span>My profile</span>
              </a>
              <a href="${path}/commute/commuteDetail" class="dropdown-item">
                <i class="ni ni-settings-gear-65"></i>
                <span>근태 상태</span>
              </a>
              <a href="${path}/commute/MyCommuteInfo" class="dropdown-item">
                <i class="ni ni-calendar-grid-58"></i>
                <span>근태 상세보기</span>
              </a>
              <a href="${path}/mypage/MyvacationInfo" class="dropdown-item">
                <i class="ni ni-support-16"></i>
                <span>나의 휴가 </span>
              </a>
              <div class="dropdown-divider"></div>
              <a href="${path }/logout" class="dropdown-item">
                <i class="ni ni-user-run"></i>
                <span>Logout</span>
              </a>
            </div>
          </li>
        </ul>
      </div>
    </nav>
    <!-- End Navbar -->

    <!-- Header -->
    <div class="header bg-gradient-primary pb-8">
      <div class="container-fluid">
        <div class="header-body">
        </div>
      </div>
    </div>