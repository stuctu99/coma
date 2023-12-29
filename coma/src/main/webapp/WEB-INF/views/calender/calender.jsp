<%-- <%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<script src="https://cdn.jsdelivr.net/npm/fullcalendar@6.1.10/index.global.min.js"></script>
<jsp:include page="/WEB-INF/views/common/header.jsp">
	<jsp:param name="id" value="mine" />
</jsp:include>

  --%>
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
    Argon Dashboard - Free Dashboard for Bootstrap 4 by Creative Tim
  </title>
  <!-- Favicon -->
  <link href="/resource/img/brand/favicon_2.png" rel="icon" type="image/png">
  <!-- Fonts -->
  <link href="https://fonts.googleapis.com/css?family=Open+Sans:300,400,600,700" rel="stylesheet">
  <!-- Icons -->
  <link href="/resource/js/plugins/nucleo/css/nucleo.css" rel="stylesheet" />
  <link href="/resource/js/plugins/@fortawesome/fontawesome-free/css/all.min.css" rel="stylesheet" />
  <!-- CSS Files -->
  <link href="/resource/css/argon-dashboard.css?v=1.1.2" rel="stylesheet" />
   <script src='https://cdn.jsdelivr.net/npm/fullcalendar/index.global.min.js'></script>
    <script>
      document.addEventListener('DOMContentLoaded', function() {
        const calendarEl = document.getElementById('calendar')
        const calendar = new FullCalendar.Calendar(calendarEl, {
          headerToolbar:{
        	  left : 'prevYear,prev,next,nextYear',
        	  center:'title',
        	  right :'today dayGridMonth,dayGridWeek,timeGridDay'
          },
          expandRows: true, // 화면에 맞게 높이 설정
          slotMinTime: '9:00', // 일자별 캘린더 시작 시간
          slotMaxTime: '18:00', // 일자별 캘린더 종료 시간
          initialView: 'dayGridMonth', 
          locale:'kr', // 언어설정
          selectable:true, //영역 선택
          navLinks: true, //날짜 클릭여부
          editable: true, // 일정
          
        })
        calendar.render();
        calendar.on("eventAdd", info => console.log("Add:", info)); 
        calendar.on("eventChange", info => console.log("Change:", info));
        calendar.on("eventRemove", info => console.log("Remove:", info));
        calendar.on("eventClick", info => {
            console.log("eClick:", info);
            console.log('Event: ', info.event.extendedProps);
            console.log('Coordinates: ', info.jsEvent);
            console.log('View: ', info.view);
    
        });
        
        calendar.on("eventMouseEnter", info => console.log("eEnter:", info));
        calendar.on("eventMouseLeave", info => console.log("eLeave:", info));
        calendar.on("dateClick", info => console.log("dateClick:", info));
        calendar.on("select", info => {
            console.log(":", info);

            mySchStart.value = info.startStr;
            mySchEnd.value = info.endStr;

            YrModal.style.display = "block";});
    	
      })
    </script>
  <style>
     /* div{
      border: 2px solid red;
    } */
    #yrModal {
          /*   position: fixed; */
            width: 100%;
            height: 100%;
            background-color: rgba(50, 150, 150, 0.7);
            display: none;
            z-index: 1000;
        }
  </style>
  
</head>

<body class="">
  <nav class="navbar navbar-vertical fixed-left navbar-expand-md navbar-light bg-white" id="sidenav-main">
    <div class="container-fluid">
      <!-- Toggler -->
      <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#sidenav-collapse-main" aria-controls="sidenav-main" aria-expanded="false" aria-label="Toggle navigation">
        <span class="navbar-toggler-icon"></span>
      </button>
      <!-- Brand -->
      <a class="navbar-brand pt-0" href="./index.html">
        <img src="/resource/img/brand/COMA2.png" class="navbar-brand-img" alt="...">
      </a>
      <!-- User -->
      <ul class="nav align-items-center d-md-none">
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
            <a href="#!" class="dropdown-item">
              <i class="ni ni-user-run"></i>
              <span>Logout</span>
            </a>
          </div>
        </li>
      </ul>
      <!-- Collapse -->
      <div class="collapse navbar-collapse" id="sidenav-collapse-main">
        <!-- Collapse header -->
        <div class="navbar-collapse-header d-md-none">
          <div class="row">
            <div class="col-6 collapse-brand">
              <a href="./index.html">
                <img src="/resource/img/brand/blue.png">
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
            <a class="nav-link  active " href="#">
              <i class="ni ni-tv-2 text-primary"></i> 내 부서
            </a>
          </li>
          <li class="nav-item">
            <a class="nav-link ">
              <i class="ni ni-planet text-blue"></i> 전자결재
            </a>
            <ul class="sub-menu" style="display: none;list-style-type: none; font-size: 0.9rem; padding-left: 70px;">
              <li><a href="">결재신청</a></li>
              <li><a href="">결재문서함</a></li>
              <li><a href="">?</a></li>
            </ul>
          </li>
          <li class="nav-item">
            <a class="nav-link " href="/calender">
              <i class="ni ni-pin-3 text-orange"></i> 캘린더
            </a>
          </li>
          <li class="nav-item">
            <a class="nav-link ">
              <i class="ni ni-single-02 text-yellow"></i> 공지사항
            </a>
            <ul class="sub-menu" style="display: none;list-style-type: none; font-size: 0.9rem; padding-left: 70px;">
              <li><a href="">사내공지사항</a></li>
            </ul>
          </li>
          <li class="nav-item">
            <a class="nav-link ">
              <i class="ni ni-bullet-list-67 text-red"></i> 테스트1
            </a>
            <ul class="sub-menu" style="display: none;list-style-type: none; font-size: 0.9rem; padding-left: 70px;">
              <li><a href="">인사부</a></li>
              <li><a href="">인사부</a></li>
              <li><a href="">인사부</a></li>
            </ul>
          </li>
          <li class="nav-item">
            <a class="nav-link">
              <i class="ni ni-key-25 text-info"></i> 테스트2
            </a>
            <ul class="sub-menu" style="display: none;list-style-type: none; font-size: 0.9rem; padding-left: 70px;">
              <li><a href="">인사부</a></li>
              <li><a href="">인사부</a></li>
              <li><a href="">인사부</a></li>
            </ul>
          </li>
          <li class="nav-item">
            <a class="nav-link">
              <i class="ni ni-circle-08 text-pink"></i> 테스트3
            </a>
          </li>
        </ul>
        <!-- Divider -->
        <hr class="my-3">
        <!-- Heading -->
        <h6 class="navbar-heading text-muted">PLUS</h6>
        <!-- Navigation -->
        <ul class="navbar-nav mb-md-3">
          <li class="nav-item">
            <a class="nav-link" id="messenger-btn">
              <i class="ni ni-spaceship"></i> Messenger
            </a>
          </li>
      </div>
    </div>
  </nav>

  <div class="main-content">
    
    <!-- Navbar -->
    <nav class="navbar navbar-top navbar-expand-md navbar-dark" id="navbar-main">
      <div class="container-fluid">
        <!-- Brand -->
        <a class="h4 mb-0 text-white text-uppercase d-none d-lg-inline-block" href="./index.html">COMA GROUPWARE</a>
        <!-- User -->
        <ul class="navbar-nav align-items-center d-none d-md-flex">
          <li class="nav-item dropdown">
            <a class="nav-link pr-0" href="#" role="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
              <div class="media align-items-center">
                <span class="avatar avatar-sm rounded-circle">
                  <img alt="Image placeholder" src="/resource/img/theme/team-4-800x800.jpg">
                </span>
                <div class="media-body ml-2 d-none d-lg-block">
                  <span class="mb-0 text-sm  font-weight-bold">COMA EMP</span>
                </div>
              </div>
            </a>
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
              <a href="#!" class="dropdown-item">
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
 
 <div id="yrModal">
 	<div id="cont" style="text-align: center;">
 	<br>
 	<h1>일정을 입력해주세요</h1>
 	제목<input type="text" id="schTitle" value=""><br>
 	내용<input type="text" id="schContent" value=""><br>
 	시작일<input type="text" id="schStart" value=""><br>
 	종료일<input type="text" id="schEnd" value=""><br>
 	<button onclick="fCalAdd()">저장하기</button><br>
            <button onclick="fMClose()">닫기</button>
        </div>
    </div>
 
	 <div id="Wrapper">
    <div id='calendar'></div>
    </div>
 <script>
 	const YrModal = document.querySelector("#yrModal");
 	const mySchTitle = document.querySelector("#schTitle");
 	const mySchContent = document.querySelector("#schContent");
 	const mySchStart = document.querySelector("#schStart");
 	const mySchEnd = document.querySelector("#schEnd");
 	 
 	  
 					
 	 function fCalAdd() {
         if (!mySchTitle.value) {
             alert("제목입력")
             mySchTitle.focus();
             return;
         };
/*          let bColor = mySchBColor.value;
         let fColor = mySchFColor.value;
         if (fColor == bColor) {
             bColor = "black";
             fColor = "yellow";
             YrModal.style.display = "block"
         }; */

         let event = {
             start: mySchStart.value,
             end: mySchEnd.value,
             title: mySchTitle.value,
             content: mySchContent.value
          /*    backgroundColor: bColor,
             textColor: fColor */ 
         };
         calendar.addEvent(event);
         fMClose();
     };

     // 모달 닫기
     function fMClose() {
         YrModal.style.display = "none";
     };
 </script>
 
 
 
 
 
 
 
 
 
	</div>
  </div>
  <!--   Core   -->
  <script src="/resource/js/plugins/jquery/dist/jquery.min.js"></script>
  <script src="/resource/js/plugins/bootstrap/dist/js/bootstrap.bundle.min.js"></script>
  <!--   Optional JS   -->
  <script src="/resource/js/plugins/chart.js/dist/Chart.min.js"></script>
  <script src="/resource/js/plugins/chart.js/dist/Chart.extension.js"></script>
  <!--   Argon JS   -->
  <script src="/resource/js/argon-dashboard.min.js?v=1.1.2"></script>
  <script src="https://cdn.trackjs.com/agent/v3/latest/t.js"></script>
  <script src="/resource/js/coma-index.js"></script>
  <script>
    window.TrackJS &&
      TrackJS.install({
        token: "ee6fab19c5a04ac1a32a645abde4613a",
        application: "argon-dashboard-free"
      });
      $(".nav-item").click(function (e) {
      const item = $(this).children("ul");
      console.log(item);
      item.slideToggle(500);
    })
  </script>
</body>

</html>
 
 

<%-- <jsp:include page="/WEB-INF/views/common/footer.jsp"/> --%>