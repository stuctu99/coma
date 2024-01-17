<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>   
<jsp:include page="/WEB-INF/views/common/header.jsp">
   <jsp:param name="id" value="mine" />
</jsp:include>
<c:set var="emp" value="${sessionScope.SPRING_SECURITY_CONTEXT.authentication.principal }"/>
<script src='https://cdn.jsdelivr.net/npm/fullcalendar/index.global.min.js'></script>

<!-- TEAM COMA SPACE -->
<style>
/*   div{
   border: 2px solid red;
}   */

.bigContainer{
   box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
   text-align: center;
   padding: 50px 50px 50px 70px;
   background-color: #f1edff;
   border-radius: 20px;
}
.bigContainer2{
   box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
   text-align: center;
   padding: 30px;
   background-color: #f1edff;
   border-radius: 50px;
}
#calendar{
   height: 500px;
}

 td{
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

</style>

<div class="coma-container"style="margin-top: 5px; margin-bottom: 5px; padding: 50px;">

<button type="button" class="btn btn-primary" id="checkInsert">근태 정보</button>


<%-- ${myCommute} --%>
<%-- ${mainNotice} --%>
   <div class="row">
      <div class=" col-4">
         <div class="row">
            <div class="col-12">
               <h2>근무체크</h2>
            </div>
         </div>
         <div class="bigContainer" style="text-align: center; padding: 50px; background-color: #f1edff; border-radius: 20px;">        
            <h1 id="stopwatch" >00:00:00</h1>               
            <div class="row" style="display: flex; flex-direction: row; justify-content: space-evenly; height : 44px">
               <c:choose>
                   <c:when test="${myCommute.commuteClockin == null}">
                       <div class=" col-3" id="clockin">
                          <div class="btncss" id="clockin1"> 
                              <i class="ni ni-briefcase-24"  ></i>
                           </div>
                       </div>
                   </c:when>
                   <c:otherwise>
                       <div class="col-3" id="clockin"> </div>
                   </c:otherwise>
               </c:choose>
               <c:choose>
                   <c:when test="${myCommute.commuteStarttime == null}">
                       <div class=" col-3" id="starttime">
                          <div class="btncss" id="starttime1">
                              <i class="ni ni-button-pause" ></i>
                           </div>
                       </div>
                   </c:when>
                   <c:otherwise>
                       <div class="col-3" id="starttime"> </div>
                   </c:otherwise>
               </c:choose>
               <c:choose>
                   <c:when test="${myCommute.commuteEndtime == null}">
                       <div class=" col-3" id="endtime">
                          <div class="btncss" id="endtime1">
                              <i class="ni ni-button-play"></i>
                           </div>
                       </div>
                   </c:when>
                   <c:otherwise>
                       <div class="col-3" id="endtime"> </div>
                   </c:otherwise>
               </c:choose>
               <c:choose>
                   <c:when test="${myCommute.commuteClockout == null}">
                       <div class="col-3" id="clockout">
                          <div class="btncss" id="clockout1">
                              <i class="ni ni-spaceship"></i>
                           </div>
                       </div>
                   </c:when>
                   <c:otherwise>
                       <div class="col-3" id="clockout"> </div>
                   </c:otherwise>
               </c:choose>
               
            </div>
            <div class="row "  style="display: flex; flex-direction: row; justify-content: space-evenly;">
               <label for="clockin" class="form-control-label">출근하기</label>
               <label for="starttime" class="form-control-label">외출하기</label>
               <label for="endtime" class="form-control-label">복귀하기</label>
               <label for="clockout" class="form-control-label">퇴근하기</label>

            </div>
            <div class="row " style="display: flex; flex-direction: row; justify-content: space-evenly;">                              
                <div id="clockInResult" class="col-3"><fmt:formatDate value="${myCommute.commuteClockin}" pattern="HH:mm:ss" /></div>
                <div id="starttimeResult" class="col-3"><fmt:formatDate value="${myCommute.commuteStarttime}" pattern="HH:mm:ss" /></div>
                <div id="endtimeResult" class="col-3"><fmt:formatDate value="${myCommute.commuteEndtime}" pattern="HH:mm:ss" /></div>
                <div id="clockoutResult" class="col-3"><fmt:formatDate value="${myCommute.commuteClockout}" pattern="HH:mm:ss" /></div>               
            </div>
         </div>
         <div class="row">
            <div class="col-12">
               <h2>Work Life </h2>
            </div>
         </div>
         <div class="bigContainer" style="text-align: center; padding: 50px; background-color: #f1edff; border-radius: 20px;">
            <h4>잔여 휴가 ${emp.empVacation} 일 남았습니다.</h4>
            <button type="button" class="btn btn-primary" id="myCommuteBtn">근태 정보</button>
            <button type="button" class="btn btn-primary" id="vacationButton">휴가 정보</button>
         </div>
         <div class="row">
            <div class="col-12">
               <h2>내 일정</h2>
            </div>
         </div>
         <div class="bigContainer2">
            <div id='calendar'></div>
         </div>
      </div>
      
      <div class=" col-8">
         <div class="bigContainer"  >
            <div class = "row">
               <div class= col-12 style="text-align: center;">
               		<img src="/resource/img/brand/COMA2.png">
                  <h1 style="text-align: center; margin : 10px;"> ${emp.empName }님 환영합니다 </h1>
               </div>
            </div>
            <div class = "row" style="padding:10px;">
               <div class= col-12>
                  <h1><i class="ni ni-check-bold"></i>공지사항 </h1>
               </div>
            </div>
            <div class = "row" style="padding:30px;">
               <div class= col-12 style="text-align: -webkit-center;">
                  <table>
                     <c:forEach var="mainNotice" items="${mainNotice}">
                            <tr>
                               <td>${mainNotice.boardNo }</td>
                                <td>${mainNotice.emp.empId}</td>
                                <td>${mainNotice.emp.empName}</td>
                                <td><a href="/board/freePost?boardNo=${mainNotice.boardNo }">${mainNotice.boardTitle}</a></td>
                                <td>${mainNotice.boardDate}</td>
                            </tr>
                        </c:forEach>
                  </table>
               </div>
            </div>
         </div>
      </div>
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
	 //값이 있으면 false
	 //console.log(!commuteStarttime);
	 //console.log(!commuteEndtime);	 
	 
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
	            	document.getElementById("stopwatch").innerText = formatTime(totalwork1);
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
       const calendarEl = document.getElementById('calendar')
       const calendar = new FullCalendar.Calendar(calendarEl, {
          initialView: 'dayGridMonth',
           expandRows: true, // 화면에 맞게 높이 설정
       })
           calendar.render();
    });


let clockIn, clockout,endtime, starttime;
//출근하기 버튼을 눌렀을 때
document.getElementById('clockin').addEventListener('click', function() {
    var empId = '${emp.empId}';
    clockIn = new Date().getTime();
    
    console.log('출근 버'+clockIn);
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
            var clockinDiv = document.getElementById('clockin1');
            clockinDiv.remove();
            // Display clock-in time
            document.getElementById('clockInResult').textContent = getFormatTime(new Date());
            //출근 누르면 타이머 시작!
            generatePattern(2000);
        }
    }).catch(e => {
        alert(e);
    });
});
 //외출시작하기 눌렀을 때
 document.getElementById('starttime').addEventListener('click', function() {
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
            var clockinDiv = document.getElementById('starttime1');
            clockinDiv.remove();
            document.getElementById('starttimeResult').textContent = getFormatTime(new Date());
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
        }
    }).catch(e => {
        alert(e);
    });
});
 //외출하고 돌아왔을 때  눌렀을 때
 document.getElementById('endtime').addEventListener('click', function() {
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
            var clockinDiv = document.getElementById('endtime1');
            clockinDiv.remove();
            document.getElementById('endtimeResult').textContent = getFormatTime(new Date());
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
        }
    }).catch(e => {
        alert(e);
    });
});
//퇴근 눌렀을 때
 document.getElementById('clockout').addEventListener('click', function() {
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
            var clockinDiv = document.getElementById('clockout1');
            clockinDiv.remove();
            document.getElementById('clockoutResult').textContent = getFormatTime(new Date());
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
            		now= new Date().getTime()-clockIn;
            	}
            }
            //console.log('최종으로 근무시간을 찍어볼게요 ! '+formatTime(now));
            document.getElementById("stopwatch").innerText = formatTime(now);
            
            
        }
    }).catch(e => {
        alert(e);
    });
});

//휴가 근황 페이지 전환되는 기능 
document.getElementById('vacationButton').addEventListener('click', function() {
    window.location.href = '/mypage/MyvacationInfo';
});

document.getElementById('myCommuteBtn').addEventListener('click', function() {
    window.location.href = '/commute/MyCommuteInfo';
});
checkInsert
document.getElementById('checkInsert').addEventListener('click', function() {
    window.location.href = '/commute/checkInsert';
});
 /* window.onload=()=>{
 var test='<fmt:formatDate value="${myCommute.commuteClockin}" pattern="yyyy-MM-dd'T'HH24:mm:ss"/>';
   console.log(test);
   var value = new Date("<fmt:formatDate value="${myCommute.commuteClockin}" pattern="yyyy-MM-dd'T'HH:mm:ss"/>");
   console.log(value.getHours(),value.getMinutes(),value.getSeconds());
   console.log(value.getTime());
   console.log(new Date().getTime());
   //const hours=new Date()
   //분에 대한 것 
   console.log((new Date().getTime()-value.getTime())/(60*1000));
   //시간에 대한 것 
   console.log((new Date().getTime()-value.getTime())/(60*60*1000));
   var temp_value = "${myCommute.commuteClockin}";
   //현재 시간을 얻습니다.
   // 현재 시간을 나타내는 Date 객체 생성
   var currentDate = new Date();
   // value 변수에 저장된 날짜와의 차이를 계산
   var timeDifference = currentDate.getTime() - value.getTime();
   // 밀리초를 초로 변환
   var seconds = Math.floor(timeDifference / 1000);
   // 초를 분으로 변환
   var minutes = Math.floor(seconds / 60);
   seconds %= 60;
   // 분을 시간으로 변환
   var hours = Math.floor(minutes / 60);
   minutes %= 60;
   console.log("시간: " + hours + " 시간, 분: " + minutes + " 분, 초: " + seconds + " 초");

} */
</script>

<!-- TEAM COMA SPACE -->
<jsp:include page="/WEB-INF/views/common/footer.jsp" />