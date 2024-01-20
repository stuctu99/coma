<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<jsp:include page="/WEB-INF/views/common/header.jsp"/>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<c:set var="loginmember" value="${sessionScope.SPRING_SECURITY_CONTEXT.authentication.principal }"/>

<head>
    <meta charset='utf-8' />
   
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>

    <script src='https://cdn.jsdelivr.net/npm/fullcalendar@6.1.8/index.global.min.js'></script>
</head>

 <style>
 
	  #calendar {
	      width: 70vw;
	      height: 70vh;
		 position: relative;
 		 z-index: 0;
 		margin: 20px auto;
 		 
	  }
	#Modal {
  display: none;
  position: fixed;
  z-index: 1000;
  left: 0;
  top: 0;
  width: 100%;
  height: 100%;
  overflow: auto;
  background-color: rgba(0, 0, 0, 0.4);
}

#cont {
  background-color: #f9f9f9;
  margin: 10% auto;
  padding: 20px;
  border-radius: 5px;
  width: 70%;
  max-width: 500px;
  box-shadow: 0 0 10px rgba(0, 0, 0, 0.3);
}

#cont h1 {
  font-size: 24px;
  margin-bottom: 20px;
  text-align: center;
}

#cont input[type="text"],
#cont select {
  width: 90%;
  padding: 10px;
  margin-bottom: 10px;
  border: 1px solid #ccc;
  border-radius: 3px;
}

#cont input[type="checkbox"] {
  margin-bottom: 10px;
}


#cont button:last-child {
  background-color: #f44336;
}

#cont button:hover {
  opacity: 0.8;
}
 #cont select {
  width: 30%;
  padding: 10px;
  margin-bottom: 10px;
  border: 1px solid #ccc;
  border-radius: 3px;
  appearance: none;
  background-repeat: no-repeat;
  background-position: right center;
  background-size: 10px;
} 
#calContent {
  width: 90%;
  height: 100px;
  padding: 10px;
  margin-bottom: 10px;
  border: 1px solid #ccc;
  border-radius: 3px;
  resize: none;
}
input[type="datetime-local"] {
  padding: 5px;
  margin-bottom: 10px;
  border: 1px solid #ccc;
  border-radius: 3px;
}
.colflex{
  display: flex;
  flex-direction: column;
}
.colflex>div{
  display: flex;
}
.colflex>div:last-child{
  justify-content: center;
}
.colflex>div>span:first-child,.colflex>div>h3:first-child{
  width:30%;
}
#delBtn{
	display: none;
}
/* 일요일 날짜 빨간색 */
.fc-day-sun {
  color: red;
  text-decoration: none;
}
.fc-day-sat {
  color: blue;
  text-decoration: none;
}
#calType[readonly] {
  background-color: #ddd;
  pointer-events: none;
}
#calColor[readonly] {
  background-color: #ddd;
   pointer-events: none; 
}
#calContent[readonly]{
  pointer-events: none;
}
 .typeBtn{      
        border: none;
        color: white;
   	    box-shadow: 0 10px 14px 0 rgba(0,0,0,0.2);
        padding: 10px 24px;
        text-align: center;
        text-decoration: none;
        display: inline-block;
        font-size: 16px;
        margin: 4px 5px;
        cursor: pointer;
        transition-duration: 0.4s;
        border-radius: 5px;
  
    }

 #myBtn   {
 background-color: #fbc5cb;
 }
 #allBtn{
 background-color: #c5cefb;
 }
 #deptBtn{
 background-color: #fbdfc5;
 }
    </style>
</head>


<!-- <head>
    <meta charset='utf-8' />
 
    <script src='https://cdn.jsdelivr.net/npm/fullcalendar@6.1.8/index.global.min.js'></script>
</head>
 -->
<body>

    <!-- 모달창-->
    <div id="Modal">
        <div id="cont" style="text-align: center;">
            <br>
            <h1>일정 상세페이지</h1>
            <div class="colflex">
            
              <div> 
              <input type="text" id="empId" > 
         	  <input type="text" id="calNo" > 
                <span>제목</span> <input type="text" id="calTitle" class="modalV" readonly >
              </div>
               <div>
               <span>타입</span>
            <!--   <select id="calType" class="modalV" readonly>
                  <option value="MY">개인</option>                                  
                  <option value="DEPT">부서</option>
                  <option value="ALL">전체</option>
                </select> -->
                <input type="text" id="calType" class="" value="MY" readonly>
              </div>
              <div>
                <span>시작시간</span> <input type="datetime-local" id="calStart" class="modalV" />
              </div>
              <div>
                <span>종료시간</span> <input type="datetime-local" id="calEnd" class="modalV" />
              </div>
              <div>
                <h3>내용</h3> <textarea id="calContent" class="modalV" readonly> </textarea>
              </div>
              
              <div>
              <span>일정색상</span>
               <select id="calColor" readonly >
                  <option value="#fbc5cb">my</option>
                  <option value="#c5cefb">all</option>
                  <option value="#fbdfc5">dept</option>
                </select>
              </div>
              
              
              <div>
              
                <button type="button" class="btn btn-primary btn" onclick="fCalAdd()" id="addBtn">저장하기</button>
                <button type="button" class="btn btn-outline-danger btn" onclick="fMClose()" id="closeBtn">취소하기</button>
                <button type="button" class="btn btn-danger btn" onclick="delClose()" id="delBtn">삭제하기</button>
         
              </div>
            </div>
        </div>
    </div>
    <div class="row">
    <div class="col-1"></div>
    	 <div >              
                <button class="typeBtn" id="myBtn" onclick="fcMy()">개인일정</button>   
         </div>  
         <div >        
                  <button class="typeBtn" id="allBtn" onclick="fcAll()">전사일정</button>           
         </div>
         <div>        
                 <button class="typeBtn" id="deptBtn" onclick="fcDept()">부서일정</button> 
        	</div>
         </div>
         <!-- 캘린더 타입 구분해주는 값 -->
         <div>             
             <input type="hidden" id="calId" value="MY" >
             </div>
    <!-- 캘린더 영역 -->
    <div id="Wrapper">
        <div id='calendar'>
        
        </div>
    </div>
    <script>
    	const loginmemberJobCode="${loginmember.job.jobCode}";
    	const loginmemberDeptCode="${loginmember.dept.deptCode}";
    	const loginmemberEmpId = '${loginmember.empId}';
   	  	const delBtn = document.querySelector("#delBtn");
   	    const calNo = document.querySelector("#calNo");
        const Modal = document.querySelector("#Modal");
        const calendarEl = document.querySelector('#calendar');
        const calStart = document.querySelector("#calStart");
        const calEnd = document.querySelector("#calEnd");
        const calTitle = document.querySelector("#calTitle");
        const calColor = document.querySelector("#calColor");      
        const calContent = document.querySelector("#calContent");
        const calType = document.querySelector("#calType");
		const empId = document.querySelector("#empId");
		
		const calId =document.querySelector("#calId");
		const eventSources = getEventSources(calId);
        //캘린더 헤더 옵션
        const headerToolbar = {
            left: 'prevYear,prev,next,nextYear today',
            center: 'title',
            right: 'dayGridMonth,dayGridWeek,timeGridDay,listWeek'
        }
		//타입별 캘린더 
        function getEventSources(calId) {
      	
        	  var eventSource1 = {
        	      id: 'default',
        	      events: function(fetchInfo, successCallback, failureCallback) {
        	        $.ajax({
        	          url: "/calendar/calendarAll",
        	          method: "POST",
        	          dataType: "JSON",
        	          contentType: 'application/json; charset=utf-8',
        	          data: JSON.stringify({
          	            empId: loginmemberEmpId
          	          }),
        	          success: function(data) {
        	        	 
        	            var events = [];
        	            $.each(data, function(index, event) {
        	            	
        	              events.push({
        	                id:'default'+index,
        	                title: event.calTitle,
        	                start: event.calStart,
        	                end: event.calEnd,
        	                backgroundColor: event.calColor,
        	             
        	                extendedProps: {
        	                  calContent: event.calContent,
        	                  empId: event.empId,
        	                  calType: event.calType,
        	                  calNo: event.calNo
        	                }
        	              });
        	            });
        	     
        	            successCallback(events);
        	          
        	          },
        	          error: function() {
        	            failureCallback('이벤트를 가져오는 도중 오류가 발생했습니다!');
        	          }
        	        });
        	      }
        	    };

        	  var eventSource2 = {
        	      id: 'dept2',
        	      events: function(fetchInfo, successCallback, failureCallback) {
        	        $.ajax({
        	          url: "/calendar/calendarDept",
        	          method: 'POST',
        	          dataType: 'json',
        	          contentType: 'application/json; charset=utf-8',
        	          data: JSON.stringify({
        	            empId: loginmemberEmpId
        	          }),
        	          success: function(data) {
        	            var events = [];
        	            
        	            data.forEach(event => {
        	            	
        	              events.push({
        	                id:'dept2',
        	                title: event.calTitle,
        	                start: event.calStart,
        	                end: event.calEnd,
        	                backgroundColor: event.calColor,
        	                extendedProps: {
        	                  calContent: event.calContent,
        	                  empId: event.empId,
        	                  calType: event.calType,
        	                  calNo: event.calNo
        	                }
        	              });
        	            
        	            });
        	            successCallback(events);
        	           
        	          },
        	          error: function() {
        	            failureCallback('이벤트를 가져오는 도중 오류가 발생했습니다!');
        	          }
        	        });
        	      }
        	    };
        	  var eventSource3 = {
            	      id: 'MY',
            	      events: function(fetchInfo, successCallback, failureCallback) {
            	        $.ajax({
            	          url: "/calendar/calendarMy",
            	          method: 'POST',
            	          dataType: 'json',
            	          contentType: 'application/json; charset=utf-8',
            	          data: JSON.stringify({
            	            empId: loginmemberEmpId
            	          }),
            	          success: function(data) {
            	            var events = [];
            	            data.forEach(event => {
            	           
            	              events.push({
            	                id:'MY',
            	                title: event.calTitle,
            	                start: event.calStart,
            	                end: event.calEnd,
            	                backgroundColor: event.calColor,
            	                extendedProps: {
            	                  calContent: event.calContent,
            	                  empId: event.empId,
            	                  calType: event.calType,
            	                  calNo: event.calNo
            	                }
            	              });
            	            });
            	            successCallback(events);
            	            
            	          },
            	          error: function() {
            	            failureCallback('이벤트를 가져오는 도중 오류가 발생했습니다!');
            	          }
            	        });
            	      }
            	    };
        	  var eventSource4 = {
            	      id: 'approval',
            	      events: function(fetchInfo, successCallback, failureCallback) {
            	        $.ajax({
            	          url: "/calendar/calendarApproval",
            	          method: 'POST',
            	          dataType: 'json',
            	          contentType: 'application/json; charset=utf-8',
            	          data: JSON.stringify({
            	            empId: loginmemberEmpId
            	          }),
            	         
            	          success: function(data) {
            	            var events = [];
            	            data.forEach(event => {
            	            	console.log("s너다던",event);
            	            	 var endDate = new Date(event.leaveEnd);
            	            	  endDate.setDate(endDate.getDate() + 1);
            	              events.push({
            	                id:'approval',
            	                title: event.leaveType,
            	                start: event.leaveStart,
            	                end: endDate.toISOString().split('T')[0],
            	               backgroundColor: '#A2D2FF'
            	               
            	              });
            	            });
            	            successCallback(events);           	              	           
            	          },
            	          error: function(e) {	   
            	            failureCallback('이벤트를 가져오는 도중 오류가 발생했습니다!');
            	          }
            	        });
            	      }
            	    };
        	  if (calId.value === 'ALL') {
        	    // 첫 번째 이벤트 소스만 사용
        	    return [eventSource1];
        	  } else if(calId.value==="DEPT"){
        	    // 두 번째 이벤트 소스 추가 사용
        	    return [eventSource2];
        	  } else if(calId.value==="MY"){
        		  return [eventSource3,eventSource4];
        	  }
        	}

      
        // 캘린더 생성 옵션
        const calendarOption = {
        		//일정우선순위 시간 순서 및 시간이 같을 시 최근등록 아니면 order 라는 옵션을줘서 설정
      
            eventSources: eventSources, //내가 설정한 이벤트 소스
            height: '700px', // calendar 높이 설정
            expandRows: true, // 화면에 맞게 높이 재설정
            slotMinTime: '09:00', // Day 캘린더 시작 시간
            slotMaxTime: '18:00', // Day 캘린더 종료 시간
            // 맨 위 헤더 지정
            headerToolbar: headerToolbar,
            initialView: 'dayGridMonth',   // default: dayGridMonth 'dayGridWeek', 'timeGridDay', 'listWeek'
            firstDay: 1,		// 첫번째 날짜가 월요일로 설정
            locale: 'kr',        // 언어 설정
            selectable: true,    // 영역 선택
            selectMirror: true,  // 오직 TimeGrid view에만 적용됨, default false
            navLinks: true,      // 날짜,WeekNumber 클릭 여부, default false
            // weekNumbers: true,   // WeekNumber 출력여부, default false
            editable: false,      // event(일정) // 바 컨트롤

            dayMaxEvents: 3,  // Row 높이보다 많으면 +숫자 more 링크 보임 일정 출력되는 최대 객수
            
             views: {
                dayGridMonth: {
                    dayMaxEventRows: 3
                }
            }, 
   
            nowIndicator: true,            	    
            	}       
		
        // 캘린더 생성
        let calendar;
        calendar = new FullCalendar.Calendar(calendarEl, calendarOption);
  
        calendar.render();
		
        // 캘린더 이벤트 등록
        function handleEventAdd(info) {
    console.log("Add:", info);
}
        calendar.on("eventAdd", handleEventAdd);        
      
   
        function handleEventClick(info){
   			
			 if( info.event.endStr.length>10){
            calTitle.value= info.event.title;
            calNo.value= info.event.extendedProps.calNo;
            calContent.value=info.event.extendedProps.calContent; 
            calType.value=info.event.extendedProps.calType;
            console.log("찾아",info.event.extendedProps.empId); //COMA_1 이렇게 나옴
           
            empId.value=info.event.extendedProps.empId[0].empId; 
            
            let dateEnd = new Date(info.event.endStr); 			
			let localOffsetEnd = dateEnd.getTimezoneOffset() * 60000;
			let localISOTimeEnd = (new Date(dateEnd - localOffsetEnd)).toISOString().slice(0,16);
			calEnd.value =  localISOTimeEnd; //여기서 형변환 시도 해볼까 ?
                  
			let date = new Date(info.event.startStr);
			let localOffset = date.getTimezoneOffset() * 60000;
			let localISOTime = (new Date(date - localOffset)).toISOString().slice(0,16);
			calStart.value = localISOTime;
			
			calColor.value = info.event.backgroundColor;
			
			if(loginmemberEmpId===empId.value){			
				$(".modalV").removeAttr("readonly");
				delBtn.style.display="block";	
					}else{
				$(".modalV").attr("readonly",true);	
				delBtn.style.display="none";	
					};
				
		            Modal.style.display = "block";
        }
		        };
		         
			
        calendar.on("eventClick",handleEventClick);
   
        function handleDateClick(info){        	
      
        	var year = info.date.getFullYear();
        	var month = info.date.getMonth()+1;
        	if(month < 10) {
            	month = "0" + month;
            }
        	var date = info.date.getDate();
            if(date < 10){
            	date = "0" + date;
            }
        	var dateStr = year + "-" + month + "-" + date;
            
        	console.log(info);

     		delBtn.style.display="none";
     		if(info.allDay) {
     			console.log(info.allDay);
     			calStart.value=dateStr+" 09:00:00";
     			calEnd.value=dateStr+" 18:00:00";
     			console.log("이거다잉",dateStr);
     		} else {
     			console.log(info.allDay);
     			var hour = info.date.getHours();
     			if(hour <10){
     				hour = "0" + hour;
     			}
     			var min = info.date.getMinutes();
     			var minEnd = info.date.getMinutes()+20;
     			console.log(minEnd);
     			if(min < 10) {
     				min = "0" + min;
     			}
     			var timeStr = hour + ":" + min + ":" + "00";
     			var timeEnd = hour + ":" + minEnd + ":" + "00";
     			calStart.value=dateStr+" "+timeStr;
     			calEnd.value=dateStr+" "+timeStr;
     			if(calStart.value==calEnd.value){
     				calEnd.value=dateStr+" "+timeEnd;
     			}
     			
     		}
        	calTitle.value="";
       		$(".modalV").removeAttr("readonly");
			
            calContent.value="";
            calNo.value="";
            empId.value="${loginmember.empId}";    
        }; 
        calendar.on("dateClick",handleDateClick);
        
        function handleSelect(info){       	
         	
  			console.log("야",info);
    
  	delBtn.style.display="none";
  			if(info.allDay){
             calStart.value=info.startStr+" 09:00:00";
           var endData=new Date(info.endStr.substr(0,4),info.endStr.substr(5,2)-1,info.endStr.substr(8,2));
           var dateString = endData.toISOString();
           dateString = dateString.split("T")[0] + " 18:00:00";
           calEnd.value=  dateString; 
  			}else{
  				console.log(info.startStr);
  				console.log(info.endStr);
  				console.log(info.allDay);
  				calStart.value= info.startStr.substring(0, 19);
  					calEnd.value=info.endStr.substring(0, 19);
  			}
           
           
       $(".modalV").removeAttr("readonly");
           info.endStr=calEnd.value; 
           info.end=dateString;
           calNo.value="";
           calTitle.value="";
           calContent.value="";
           empId.value="${loginmember.empId}";
            Modal.style.display = "block";         
        };
        calendar.on("select",handleSelect);
        
         //부서일정으로 ㄱㄱ
         function fcDept() {
        	 	calType.value="DEPT";
        	    calColor.value="#fbdfc5";
        	    calId.value = "DEPT";       	    
        	    // 캘린더를 제거합니다.
        	    calendar.destroy();
        	    // 새로운 이벤트 소스를 가져옵니다.
        	    const newEventSources = getEventSources(calId);

        	    // 캘린더 옵션을 업데이트합니다.
        	    calendarOption.eventSources = newEventSources;

        	    // 캘린더를 다시 생성합니다.
        	    calendar = new FullCalendar.Calendar(calendarEl, calendarOption);
        	    calendar.render();
        	    
        	    calendar.on("eventClick",handleEventClick);
        	    calendar.on("eventClick",info=>{
        	    
        	    	if(loginmemberJobCode=="J2"){
        	    		addBtn.style.display="block";
        	    		delBtn.style.display="block";
        	    		
        	    	}else{
        	    		addBtn.style.display="none";
        	    		delBtn.style.display="none";
        	    	}
        	    })
        	    calendar.on("dateClick",handleDateClick);
        	    calendar.on("dateClick",info=>{
        	    
        	    	if(loginmemberJobCode=="J2"){        	    		
        	    		addBtn.style.display="block";
        	    	}else{
        	    		addBtn.style.display="none";
        	    	}
        	    })
        	    calendar.on("select",handleSelect);
        	    calendar.on("select",info=>{
           		 if(loginmemberJobCode=="J2"){
     	    		addBtn.style.display="block";           			
           		 }else{
     	    		addBtn.style.display="none";
     	    	}
           	 })
        	   
        	    
         }
         function fcAll(){
        	 calType.value="ALL";
        	 calColor.value="#c5cefb";  
        	 calId.value="ALL";
        	 calendar.destroy();
        	 
        	 const newEventSources =getEventSources(calId);
        	 calendarOption.eventSources = newEventSources;
        	 calendar= new FullCalendar.Calendar(calendarEl, calendarOption);
        	 calendar.render();
        	 calendar.on("eventClick",handleEventClick);
        	 console.log(loginmemberEmpId);
        	 calendar.on("eventClick",info =>{
        		
        		 if(loginmemberDeptCode!="D1"){
        			 addBtn.style.display="none";
        		 }else{
        			 addBtn.style.display="block";
        		 }
        	 })
     	    calendar.on("dateClick",handleDateClick);
        	 calendar.on("dateClick",info =>{
        	
        		 if(loginmemberDeptCode!="D1"){
        			 addBtn.style.display="none";
        		 }else{
        			 addBtn.style.display="block";
        		 }
        	 })
     	    calendar.on("select",handleSelect);
        	 calendar.on("select",info=>{
        		 if(loginmemberDeptCode!="D1"){
        			 addBtn.style.display="none";
        		 }else{
        			 addBtn.style.display="block";
        		 }
        	 })
        	 
        	 
         }
         function fcMy(){
        	 calType.value="MY";
        	 calColor.value="#fbc5cb";
        	 calId.value="MY";
        	 calendar.destroy();
        	 const newEventSources=getEventSources(calId);
        	 calendarOption.eventSources = newEventSources;
        	 calendar= new FullCalendar.Calendar(calendarEl, calendarOption);
        	 calendar.render();
        	 calendar.on("eventClick",handleEventClick);
        	 calendar.on("eventClick",info=>{
        		 if(loginmemberEmpId===empId.value){
        			 addBtn.style.display="block";
        		 }else{
        			 addBtn.style.display="none";
        		 }
        	 })
     	    calendar.on("dateClick",handleDateClick);
        	 calendar.on("dateClick",info=>{
        		 if(loginmemberEmpId===empId.value){
        			 addBtn.style.display="block";
        		 }else{
        			 addBtn.style.display="none";
        		 }
        	 })
     	    calendar.on("select",handleSelect);
        	 calendar.on("select",info=>{
        		 if(loginmemberEmpId===empId.value){
        			 addBtn.style.display="block";
        		 }else{
        			 addBtn.style.display="none";
        		 }
        	 })
        	 
         }
         
        // 일정(이벤트) 추가하기
        function fCalAdd() {
            if (!calTitle.value) {
                alert("제목을 입력해주세요")
                calTitle.focus();
                return;
                
            }
             let event = {
            		calNo: calNo.value,
                    empId: empId.value, //추가
                    calTitle: calTitle.value, 
                    calContent: calContent.value, // 추가
            		calStart: calStart.value,
                    calEnd: calEnd.value,
                    calType: calType.value, //추가
                    calColor: calColor.value
            }; 
            if(!calNo.value){
            $.ajax({
                url: "/calendar/calendarInsert",
                method: "POST",
                dataType: "json",
                data: JSON.stringify(event),
                contentType: 'application/json',
                success: function(data){
		      
		           calendar.refetchEvents();
		           alert("일정등록이 되었습니다.")
                },
                error: function(e){
                	alert('일정등록중 오류가 발생하였습니다 다시 시도하십시오');
                	console.log(e);
                }
            })
            }else{
            	$.ajax({
            		url: "/calendar/calendarUpdate",
            		method: "POST",
            		dataType: "json",
            		data: JSON.stringify(event),
            		contentType: 'application/json',
            		success: function(data){
            			calendar.refetchEvents();
            		},
            		error: function(e){
            			alert('일정 수정중 요류가 발생하였습니다. 다시 입력 하십시오');
            			console.log(e);
            		}
            	})
            }
            	
	            fMClose();
	        }    	
       
      //일정 (이벤트) 삭제하기
 		function delClose(){
 			let event = {
            		calNo: calNo.value
            };
 			$.ajax({
        		url: "/calendar/calendarDelete",
        		method: "POST",
        		dataType: "json",
        		data: JSON.stringify(event),
        		contentType: 'application/json',
        		success: function(data){
        			calendar.refetchEvents();
        			alert("일정이 삭제되었습니다.");
        		},
        		error: function(e){
        			alert('일정 삭제중 요류가 발생하였습니다. 다시 입력 하십시오');       		
        		}
        	})
            fMClose();
        }
        	
 		 // 모달 닫기
        function fMClose() {
            Modal.style.display = "none";
        }
      
    </script>
</body>

<jsp:include page="/WEB-INF/views/common/footer.jsp"/>