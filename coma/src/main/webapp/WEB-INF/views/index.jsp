<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<jsp:include page="/WEB-INF/views/common/header.jsp">
   <jsp:param name="id" value="mine" />
</jsp:include>
<c:set var="path" value="${pageContext.request.contextPath }" />
<c:set var="emp" value="${sessionScope.SPRING_SECURITY_CONTEXT.authentication.principal }" />
<script src='https://cdn.jsdelivr.net/npm/fullcalendar/index.global.min.js'></script>

<!-- TEAM COMA SPACE -->
<style>
::-webkit-scrollbar {
   /* 스크롤바 숨기기 */
   display: none;
   /*#5e72e4*/
}
.bigContainer {
   box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
   text-align: center;
   background-color: white;
   border-radius: 20px;
   margin: 0px 0px 20px;
}

#calendar {
   height: 500px;
}

td {
   padding: 15px;
}

.btncss {
   box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
   display: inline-block;
   padding: 10px 15px;
   background-color: #5e72e4;
   color: #fff;
   border: none;
   border-radius: 5px;
   cursor: pointer;
}

.btn i {
   margin-right: 5px;
}
/* 일요일 날짜 빨간색 */
.fc-day-sun  {
  color: #f0a3a9;
  text-decoration: none;
}
.fc-day-sat {
  color: #8965e0;
  text-decoration: none;
}
/* 캘린더 전달, 다음달 커스텀 버튼 css  */
.fc-customPrev-button{
	background-color:#5e72e4 !important;
	color:#ffffff !important;
	border-color:#5e72e4!important;
	margin:10px !important;
	border-radius: 5px !important;
}
.fc-customNext-button{
	background-color: #5e72e4 !important;
	color: !important;
	border-color:#5e72e4 !important;
	margin:10px !important;
	border-radius: 5px !important;
	
}

.notice *:not(h1):not(span) {
	font-size: 16px;
}



</style>

<div class="coma-container" style="margin-top:30px;">
	<div class="row">
		<div class=" col-1"></div>
		<div class=" col-3">
			<div class="bigContainer" style="border-radius: 20px; margin: 0px 0px 20px 0px; height:170px;">
				<h1 id="stopwatch">00:00:00</h1>
				<div class="row" style="display: flex; flex-direction: row; justify-content: space-evenly; height: 44px">
					
					<c:choose>
						<%-- 출근 시간이 값이 없으면  --%>
						<c:when test="${myCommute.commuteClockin == null}">
							<div class=" col-3 " id="clockin">
								<button type="button"  class="btn btn-primary" id = "clockin1" onclick="clockin1()"><i class="ni ni-briefcase-24"></i></button>
							</div>
						</c:when>
						<c:otherwise>
						<%-- 출근 시간이 값이 있으면   --%>
							<div class="col-3">
								<div class="col-3" id="clockInResult"><fmt:formatDate value="${myCommute.commuteClockin}" pattern="HH:mm:ss" />	</div>				
							</div>
						</c:otherwise>
					</c:choose>
					<!-- 외출하기 -->
					<c:choose>
						<c:when test="${myCommute.commuteStarttime == null}">
							<c:choose>
								<c:when test="${myCommute.commuteClockin != null}">
									<div class=" col-3" id="starttime">
										<button type="button"  class="btn btn-primary" id = "starttime1" onclick="starttime1()"><i class="ni ni-button-pause"></i></button>
									</div>
								</c:when>
								<c:otherwise>
									<div class=" col-3" id="starttime">
										<button type="button"  class="btn btn-primary" id = "starttime1"  onclick="starttime1()" disabled ><i class="ni ni-button-pause"></i></button>
									</div>
								</c:otherwise>
							</c:choose>
						</c:when>
						<c:otherwise>
							<div class="col-3" id="starttimeResult">
								<fmt:formatDate value="${myCommute.commuteStarttime}" pattern="HH:mm:ss" />
							</div> 
						</c:otherwise>
					</c:choose>
					<c:choose>
						<c:when test="${myCommute.commuteEndtime == null}">
							<c:choose>
								<%--외출한 시간이 있다면  --%>
								<c:when test="${myCommute.commuteStarttime != null}">
									<div class=" col-3" id="endtime">
										<button type="button"  class="btn btn-primary" id = "endtime1" onclick="endtime1()" ><i class="ni ni-button-play"></i></button>
									</div>
								</c:when>
								
								<c:otherwise>
									<div class=" col-3" id="endtime">
										<button type="button"  class="btn btn-primary" id = "endtime1"  onclick="endtime1()" disabled ><i class="ni ni-button-play"></i></button>
									</div>
								</c:otherwise>
							</c:choose>
						</c:when>
						<c:otherwise>
							<div class="col-3" id="endtimeResult"><fmt:formatDate value="${myCommute.commuteEndtime}" pattern="HH:mm:ss" /></div>
						</c:otherwise>
					</c:choose>
					<c:choose>
						<c:when test="${myCommute.commuteClockout == null}">
							<c:choose>
								<c:when test="${(myCommute.commuteClockin != null && myCommute.commuteStarttime != null && myCommute.commuteEndtime != null)
									||(myCommute.commuteClockin != null && myCommute.commuteStarttime == null && myCommute.commuteEndtime == null) }">
									<div class="col-3" id="clockout">
										<button type="button"  class="btn btn-primary" id ="clockout1" onclick="clockout1()" ><i class="ni ni-spaceship"></i></button>							
									</div>
								</c:when>
								<c:otherwise>
									<div class="col-3" id="clockout">
										<button type="button"  class="btn btn-primary" id ="clockout1" onclick="clockout1()"disabled><i class="ni ni-spaceship"></i></button>
									</div>
								</c:otherwise>
							</c:choose>
						</c:when>
						<c:otherwise>
							<div class="col-3" id="clockoutResult"><fmt:formatDate value="${myCommute.commuteClockout}" pattern="HH:mm:ss" /></div>
						</c:otherwise>
					</c:choose>
				</div>
				<div class="row"style="display: flex; flex-direction: row; justify-content: space-evenly;">
					<div class="col-3">
						<label for="clockin" class="form-control-label">출근하기</label>
					</div>
					<div class="col-3">
						<label for="starttime" class="form-control-label">외출하기</label>
					</div>
					<div class="col-3">
					<label for="endtime" class="form-control-label">복귀하기</label>
					</div>
					<div class="col-3">
						<label for="clockout" class="form-control-label">퇴근하기</label>
					</div>
				</div>
			</div>
			<div class="bigContainer" style="display: flex;border-radius: 20px;height:150px;margin: 0px 0px 20px 0px;justify-content: center;flex-direction: column;">
				<div>
					<h2>잔여 휴가 
						<c:set var="empVacation" value="${emp.empVacation}" />
						<c:choose>
						    <c:when test="${empVacation % 1 == 0}">
						        <fmt:formatNumber var="formattedNumber" value="${empVacation}" pattern="0" />
						    		${formattedNumber} 일
						    </c:when>
						    <c:otherwise>
						       ${emp.empVacation} 일
						    </c:otherwise>
						</c:choose>
					남았습니다.</h2>
				</div>
				<div class="row">
					<div class="col-2"></div>
					<div class="col-4">
						<button type="button" class="btn btn-primary" id="myCommuteBtn">근태 정보</button>
					</div>
					<div class="col-4">
						<button type="button" class="btn btn-primary" id="vacationButton">휴가 정보</button>
					</div>
					<div class="col-2"></div>
				</div>
			</div>
			
			<div class="bigContainer notice" style="display: flex;border-radius: 20px;height:380px;margin: 0px 0px 20px 0px;justify-content: center;flex-direction: column;">
				<div class="row">
				<div class=col-12>
					<h1>
						공지사항
					</h1>
				</div>
					<div class=col-12 style="text-align: -webkit-center;">
						<table class="table" style="width:100%;">
							<a href="${path }/board/noticelist" style="color: inherit; text-decoration: none;">
								<span style="font-size: 16px; float: right; padding: 0 24px 16px 0;">+더보기</span>
							</a>
							<c:forEach var="mainNotice" items="${mainNotice}">
								<tr>
									<td class="notice-title"><a
										href="${path }/board/freePost?boardNo=${mainNotice.boardNo }">${mainNotice.boardTitle}</a></td>
									
									<c:choose>
										<c:when test="${mainNotice.boardDate.year == 124}">
						                    <td class="noitce-date" style="text-align: right;"><fmt:formatDate value="${mainNotice.boardDate}" pattern="MM-dd" /></td>
						                </c:when>
						                <c:otherwise>
						                    <td class="noitce-date" style="text-align: right;"><fmt:formatDate value="${mainNotice.boardDate}" pattern="yyyy-MM-dd" /></td>
						                </c:otherwise>
						            </c:choose>
								</tr>
							</c:forEach>
						</table>
					</div>
				</div>
			</div>
			
		</div>
		<div class=" col-7">
			<div class="bigContainer">
				<div class="row">
					<div class=col-12 style="">
						<img src="${path }/resource/img/brand/COMA2.png">
						<h1>${emp.empName }님	환영합니다</h1>
					</div>
				</div>
			</div>

			<div class="bigContainer" style="height:530px; display: flex; justify-content: center; align-items: center;">
				<div id='calendar' style="width:90%;"></div>
			</div>

		</div>
 	<!-- <button type="button" class="btn btn-primary" id="updateUncleared">퇴근 미처리</button>
	<button type="button" class="btn btn-primary" id="checkInsert">근태 정보</button>   -->

   <div class=" col-1"></div>
   </div>
</div>

<script>
    // myCommute 객체에서 시간 값들을 가져옴
    var ex = new Date('${myCommute.commuteClockin}').getTime();
    var commuteClockin = new Date("<fmt:formatDate value="${myCommute.commuteClockin}" pattern="yyyy-MM-dd'T'HH:mm:ss"/>").getTime();
    var commuteStarttime = new Date("<fmt:formatDate value="${myCommute.commuteStarttime}" pattern="yyyy-MM-dd'T'HH:mm:ss"/>").getTime();
    var commuteEndtime = new Date("<fmt:formatDate value="${myCommute.commuteEndtime}" pattern="yyyy-MM-dd'T'HH:mm:ss"/>").getTime();
    var commuteClockout = new Date("<fmt:formatDate value="${myCommute.commuteClockout}" pattern="yyyy-MM-dd'T'HH:mm:ss"/>").getTime();
    var nowTime = new Date().getTime();  
    //외출하지않고 출근하고 타이머 시작 시간
    var time1 = (nowTime - commuteClockin);
    //외출했을 때 타이머는 가지않고 그때까지의 출근시간만 보여주는 시간
    var time2 = (commuteStarttime-commuteClockin);
    var totalwork1 = (commuteStarttime-commuteClockin) + (commuteClockout-commuteEndtime);
    var totalwork2 = commuteClockout-commuteClockin;
    var time3 = time2 + (nowTime -commuteEndtime);       
    // 시간을 HH:mm:ss 형식으로 변환
    function formatTime(milliseconds) {
                var seconds = Math.floor(milliseconds / 1000);
                var minutes = Math.floor(seconds / 60);
                var hours = Math.floor(minutes / 60);   
                seconds %= 60;
                minutes %= 60;
                hours %= 24;   
                return pad(hours) + ':' + pad(minutes) + ':' + pad(seconds);
    }
    function pad(number) {
         return (number < 10 ? '0' : '') + number;
     }
    
    function getFormatTime(date){
         var hh=date.getHours();
         hh = hh >= 10 ? hh : '0' +hh;
         var mm =date.getMinutes();
         mm = mm >= 10 ? mm : '0' +mm;
         var ss =date.getSeconds();
         ss = ss >= 10 ? ss : '0' +ss;
         return hh + ':'+mm + ':'+ ss ;   
      }
    //setInterval 변수로 지정해주기 => 타이머 중지때문에 
    var interval;
    function generatePattern(milliseconds) {   
       function updatePattern() {
           // 패턴 생성
           const pattern = formatTime(milliseconds);   
           // HTML 요소에 표시
           document.getElementById("stopwatch").innerText = pattern;   
           // 1초씩 증가
           milliseconds += 1000;
       }
       // 1초마다 updatePattern 함수 진행
        interval = setInterval(updatePattern, 1000);
   }
   // 값이 있는 경우에만 타이머 작동
   if (commuteClockin) {
       // 외출시간이 있다면
       if (commuteStarttime) {
           // 외출끝 유무
           if (commuteEndtime) {
               if (commuteClockout) {
                   // 퇴근이 있는 경우
                   console.log('퇴근했다 ㅠ');
                   document.getElementById("stopwatch").innerText = formatTime(totalwork1);                   
               }else{
                  // 외출 시작시간과 외출 끝이 있는 경우
                  // 외출전 근무시간 + (외출끝 - 현재시간) 타이머 진행 중
                  console.log('외출 시작시간이 있고 외출 끝하고 근무중 -> 아직 퇴근안함');
                  generatePattern(time3);
               }
           } else {
               // 외출 시작시간이 있고 외출 끝시간이 없는 경우
               // 타이머는 멈추고 외출 전까지 근무한 시간만 출력
               document.getElementById("stopwatch").innerText = formatTime(time2);
               console.log('외출 시작시간이 있고 외출 끝시간이 없는 경우');
           }
       } else {          
           if (commuteClockout) {
              if(commuteStarttime){
                  // 퇴근이 찍혔는데 오늘 외출을 했다 ! 
                  console.log('외출했다가 퇴근했음');
                  document.getElementById("stopwatch").innerText = formatTime(totalwork1);
              }else{
                 console.log('외출 안했고 퇴근했음');
                  document.getElementById("stopwatch").innerText = formatTime(totalwork2);
              }
           }else{
              //출근했다 !
              console.log('출근했어요!');
              generatePattern(time1);
              //document.getElementById("stopwatch").innerText = formatTime(time1);
           }
       }       
   } else{
      if(totalwork2){
         //commuteClockin이 없고 ( 출근했지만 새로고침하지 않을 상태) + 외출은 안하고퇴근을 눌렀다 ? 
         console.log('commuteClockin이 없고 ( 출근했지만 새로고침하지 않을 상태) + 외출은 안하고퇴근을 눌렀다 ? ');
         document.getElementById("stopwatch").innerText = formatTime(totalwork2);
      }
   }
   /* 달력 */
document.addEventListener('DOMContentLoaded', function() {
	 var empId = '${emp.empId}';
    const calendarEl = document.getElementById('calendar');
    const calendar = new FullCalendar.Calendar(calendarEl, {    	   
        dateClick: function(info){
            window.location.href="${path}/calendar";
        },
        eventClick: function(info){
            window.location.href="${path}/calendar";
        }, 
        initialView: 'dayGridMonth',
        firstDay:1,
        locale:'kr',
        headerToolbar:{
            left:'',
            center:'title',
            right:'customPrev,customNext'
        },
        views: {
            dayGridMonth: {
                dayMaxEventRows: 1
            }
        }, 
        customButtons:{
            customPrev:{
                text: '전달',
                click: function(){
                    calendar.prev();
                }
            },
            customNext:{
                text:'다음달',
                click: function(){
                    calendar.next();
                }
            }  
        },
        
        events: function(fetchInfo, successCallback, failureCallback) {
            $.ajax({
                url: "${path}/calendar/calendarMy",
                method: 'POST',
                dataType: 'json',
                contentType: 'application/json; charset=utf-8',
                data: JSON.stringify({
                    empId: empId
                }),
                success: function(data) {
                    var events = [];
                    data.forEach(event => {
                        events.push({
                            id:'MY',
                            title: event.calTitle,
                            start: event.calStart,
                            end: event.calEnd,
                            backgroundColor:'#fbc5cb',
                            textColor: '#787b80'
                        });
                    });
                    successCallback(events);
                },
                error: function() {
                    failureCallback();
                }
            });
        },
        expandRows: true,
    });
    calendar.render();
});



//ajax로 받는 시간을 변수로 선언 
let clockIn, clockout,endtime, starttime;
//출근하기 버튼을 눌렀을 때
function clockin1(){
    var empId = '${emp.empId}';
    clockIn = new Date().getTime();
    
    console.log('출근 버튼'+clockIn);
    // Fetch to insert commute record
    fetch('${path}/commute/updateClockIn', {
        method: "post",
        headers: { "Content-Type": "application/json" },
        body: JSON.stringify({
            empId: empId
        })
    }).then(response => {
        console.log(response);
        if (response.status != 200) {
            throw new Error("");
        }
        return response.json();
    }).then(result => {
        if (result > 0) {
            alert("출근했습니다.");
            document.getElementById('clockin').textContent = getFormatTime(new Date());
            document.getElementById('starttime1').disabled = false;
            document.getElementById('clockout1').disabled = false;
            //출근 누르면 타이머 시작!
            generatePattern(1000);
            
        }
    }).catch(e => {
        alert(e);
    });
};


//외출시작하기 눌렀을 때
function starttime1(){
	var empId = '${emp.empId}';
	starttime = new Date().getTime();  
	fetch('${path}/commute/updatestarttime', {
	    method: "post",
	    headers: { "Content-Type": "application/json" },
	    body: JSON.stringify({
	        empId: empId
	    })
	}).then(response => {
	    console.log(response);
	    if (response.status != 200) {
	        throw new Error("");
	    }
	    return response.json();
	}).then(result => {
	    if (result > 0) {
	        alert("외출을 시작합니다.");
	        //시간 찍기 
	        document.getElementById('starttime').textContent = getFormatTime(new Date());
	        //타이머 중지시키고 타이머 칸 비우기 
	        clearInterval(interval);
	        document.getElementById("stopwatch").innerText='';            
	        if(commuteClockin){
	           //commuteClockin 지금 새로고침해서 commuteClockin시간이 있다 !
	           var now=  new Date().getTime()-commuteClockin;
	            document.getElementById("stopwatch").innerText = formatTime(now-2000);
	        }else {
	           //지금 이시간 업성? 
	           var now=  new Date().getTime()-clockIn;
	            document.getElementById("stopwatch").innerText = formatTime(now);
	        }
	        document.getElementById('endtime1').disabled = false;
	        document.getElementById('clockout1').disabled = true;
	    }
	}).catch(e => {
	    alert(e);
	});
}
 //외출하고 돌아왔을 때  눌렀을 때
 function endtime1(){

	var empId = '${emp.empId}';
	endtime = new Date().getTime();
	
	fetch('${path}/commute/updateEndtime', {
	    method: "post",
	    headers: { "Content-Type": "application/json" },
	    body: JSON.stringify({
	        empId: empId
	    })
	}).then(response => {
	    console.log(response);
	    if (response.status != 200) {
	        throw new Error("");
	    }
	    return response.json();
	}).then(result => {
	    if (result > 0) {
	        alert("근무를 시작합니다.");
	        document.getElementById('endtime').textContent = getFormatTime(new Date());
	        //출근시간이 있니 ?
	        if(commuteClockin){
	           //외출 시작 시간이 있으면 한번은 새로고침한 상태 
	           if(commuteStarttime){
	              //복귀누르기 전에 새로고침을 한 상태
	              generatePattern(time2);                 
	           }else{
	              //외출하기 전에 새로고침을 한 생태라서 js에 외출기록을 있음. 
	              var timeResult= starttime-commuteClockin;
	              generatePattern(timeResult);
	           }
	           
	        }else{
	           //외출 시작 시간 -> ajax로 남아있다.
	           //console.log('지금 새로고침 한번도 안한 상태 !!!!!!!!!!!!!');
	           var timeResult= starttime-clockIn;
	            generatePattern(timeResult);
	        }
	        document.getElementById('clockout1').disabled = false;
	    }
	}).catch(e => {
	    alert(e);
	});
 }
//퇴근 눌렀을 때
function clockout1(){
	var empId = '${emp.empId}';
	fetch('${path}/commute/updateclockout', {
	    method: "post",
	    headers: { "Content-Type": "application/json" },
	    body: JSON.stringify({
	        empId: empId
	    })
	}).then(response => {
	    console.log(response);
	    if (response.status != 200) {
	        throw new Error("");
	    }
	    return response.json();
	}).then(result => {
	    if (result > 0) {
	        alert("퇴근합니다.");
	        document.getElementById('clockout').textContent = getFormatTime(new Date());
	        //타이머 멈추기
	        clearInterval(interval);
	        //''비워주고 
	        document.getElementById("stopwatch").innerText='';            
	        var now;           
	        if(commuteClockin){
	           if(commuteStarttime){
	              if(commuteEndtime){
	                 //console.log('퇴근하기 버튼누르기전에 새로고침한 상태 ');
	                 now= (commuteStarttime-commuteClockin)+(new Date().getTime()-commuteEndtime) ; 
	                 //console.log('퇴근 시작 !!!!!!!!!!!!!!!!!!!!'+now);
	              }else{
	                 //console.log('복귀하기 누르기전에 새로고침한 상태 ');                     
	                 now= (commuteStarttime-commuteClockin)+(new Date().getTime()-endtime) ; 
	                 //console.log('퇴근 시작 !!!!!!!!!!!!!!!!!!!!'+now);                     
	              }
	           }else{
	              if(starttime){
	                 //console.log('출근 값은 DB -> 출근 버튼 누르고 새로고침한 상태 나머지 ajax 데이터가 있음 ');                  
	                 now= (starttime-commuteClockin)+(new Date().getTime()-endtime) ; 
	                 //console.log('퇴근 시작 !!!!!!!!!!!!!!!!!!!!'+now);
	              }else{
	                 //외출안하고 퇴근하는 사람 
	                 //console.log('출근은 했는데 새로고침하고 외출안하고 퇴근하는 사람 ')
	                 now= new Date().getTime()-commuteClockin;
	              }
	           }
	           
	        }else{
	           //새로고침 한번도 안하고 모든 데이터가 ajax로 값을 구하는 것 
	           if(starttime){
	              //console.log('새로고침 한번도 안하고 모든 데이터가 ajax로 값을 구하는 것 ');
	              now= (starttime-clockIn)+(new Date().getTime()-endtime) ;   
	              //console.log('퇴근 시작 !!!!!!!!!!!!!!!!!!!!'+now);
	           }else{
	              //출근하고 외출안한상태에서 한번도 새로고침안하고 퇴근 
	              //console.log ('출근하고 외출안한상태에서 한번도 새로고침안하고 퇴근' );
	              now= (new Date().getTime())-clockIn;
	              //console.log (now );
	           }
	        }
	        console.log('최종으로 근무시간을 찍어볼게요 ! '+formatTime(now));
	        document.getElementById("stopwatch").innerText = formatTime(now);
	    }
	}).catch(e => {
	    alert(e);
	});
}
//휴가 근황 페이지 전환되는 기능 
document.getElementById('vacationButton').addEventListener('click', function() {
    window.location.href = '${path}/mypage/MyvacationInfo';
});

document.getElementById('myCommuteBtn').addEventListener('click', function() {
    window.location.href = '${path}/commute/MyCommuteInfo';
});
/*   document.getElementById('checkInsert').addEventListener('click', function() {
    window.location.href = '/commute/checkInsert';
});
document.getElementById('updateUncleared').addEventListener('click', function() {
    window.location.href = '/commute/updateUncleared';
});   */

</script>


<!-- TEAM COMA SPACE -->
<jsp:include page="/WEB-INF/views/common/footer.jsp" />