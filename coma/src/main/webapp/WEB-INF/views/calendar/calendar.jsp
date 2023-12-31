<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<jsp:include page="/WEB-INF/views/common/header.jsp"/>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<c:set var="loginmember" value="${sessionScope.SPRING_SECURITY_CONTEXT.authentication.principal }"/>
<head>
    <meta charset='utf-8' />
   
    <script src='https://cdn.jsdelivr.net/npm/fullcalendar@6.1.8/index.global.min.js'></script>
</head>

 <style>
	  #calendar {
	      width: 80vw;
	      height: 80vh;
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

#cont button {
  background-color: #4CAF50;
  color: white;
  padding: 10px 20px;
  border: none;
  cursor: pointer;
  margin-right: 10px;
  border-radius: 3px;
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

/* 일요일 날짜 빨간색 */
.fc-day-sun a {
  color: red;
  text-decoration: none;
}
.fc-day-sat a {
  color: blue;
  text-decoration: none;
}
    </style>
</head>


<!-- <head>
    <meta charset='utf-8' />
 
    <script src='https://cdn.jsdelivr.net/npm/fullcalendar@6.1.8/index.global.min.js'></script>
</head>
 -->
<body>
    <!-- 모달은 메인 영역 밖으로 빼어 놓는게 좋음-->
    <div id="Modal">
        <div id="cont" style="text-align: center;">
            <br>
            <h1>일정 상세페이지</h1>
            <div class="colflex">
            <div>
              
             <input type="hidden" id="id" value="">
             </div>
              <div>
              <input type="text" id="empId" value=""> 
                <span>제목</span> <input type="text" id="calTitle" value="">
              </div>
               <div>
              <span>타입</span>
               <select id="calType">
                  <option value="MY">개인</option>
                  <option value="DEPT">부서</option>
                  <option value="ALL">전체</option>
                </select>
              </div>
              <div>
                <span>시작시간</span> <input type="datetime-local" id="calStart" value="" />
              </div>
              <div>
                <span>종료시간</span> <input type="datetime-local" id="calEnd" value=""/>
              </div>
              <div>
                <h3>내용</h3> <textarea id="calContent"> </textarea>
              </div>
              
              <div>
              <span>일정색상</span>
               <select id="calColor" name="calColor">
                  <option value="yellow">노랑색</option>
                  <option value="red">빨강색</option>
                  <option value="orange">주황색</option>
                  <option value="green">초록색</option>
                  <option value="blue">파랑색</option>
                  <option value="indigo">남색</option>
                  <option value="purple">보라색</option>
                </select>
              </div>
              
              
              <div>
              
                <button onclick="fCalAdd()">저장하기</button>
                <button onclick="fMClose()">취소하기</button>
              </div>
            </div>
        </div>
    </div>
    <!-- 실제 화면을 담을 영역 -->
    	 <div>              
                <button onclick="fcDept()">부서별</button>                
         </div>
    <div id="Wrapper">
        <div id='calendar'>
        </div>
    </div>
    <script>
   	  
   	   
        const Modal = document.querySelector("#Modal");
        const calendarEl = document.querySelector('#calendar');
        const calStart = document.querySelector("#calStart");
        const calEnd = document.querySelector("#calEnd");
        const calTitle = document.querySelector("#calTitle");
        const calColor = document.querySelector("#calColor");      
        const calContent = document.querySelector("#calContent");
        const calType = document.querySelector("#calType");
		const empId = document.querySelector("#empId");
        //캘린더 헤더 옵션
        const headerToolbar = {
            left: 'prevYear,prev,next,nextYear today',
            center: 'title',
            right: 'dayGridMonth,dayGridWeek,timeGridDay'
        }

        // 캘린더 생성 옵션(참고)
        const calendarOption = {
            height: '700px', // calendar 높이 설정
            expandRows: true, // 화면에 맞게 높이 재설정
            slotMinTime: '09:00', // Day 캘린더 시작 시간
            slotMaxTime: '18:00', // Day 캘린더 종료 시간
            // 맨 위 헤더 지정
            headerToolbar: headerToolbar,
            initialView: 'dayGridMonth',  // default: dayGridMonth 'dayGridWeek', 'timeGridDay', 'listWeek'
            firstDay: 1,
            locale: 'kr',        // 언어 설정
            selectable: true,    // 영역 선택
            selectMirror: true,  // 오직 TimeGrid view에만 적용됨, default false
            navLinks: true,      // 날짜,WeekNumber 클릭 여부, default false
            // weekNumbers: true,   // WeekNumber 출력여부, default false
            editable: true,      // event(일정) 
            /* 시작일 및 기간 수정가능여부
            eventStartEditable: false,
            eventDurationEditable: true,
            */
            dayMaxEvents: true,  // Row 높이보다 많으면 +숫자 more 링크 보임
            
            /* views: {
                dayGridMonth: {
                    dayMaxEventRows: 3
                }
            }, */
            
            nowIndicator: true,
    
             events: {
            	    url: "calendar/calendar.do",
            	    method: "GET",
            	    extraParams: {
            	        dataType: "JSON"
            	  
            	    },
            	    
            	    success: function(data, xhr) {
            	        var events = [];
            	        $.each(data, function(index, event) {
            	            events.push({
            	            	id:event.calNo,
            	                title: event.calTitle,
            	                start: event.calStart,
            	                end: event.calEnd,
            	                 backgroundColor: event.calColor,
            	               extendedProps: {
            	               	calContent: event.calContent,	// 추가s
            	                 empId: event.empId,// 추가
            	                calType: event.calType//추가
            	               }
            	            });
            	        });
            	  		console.log(events);
            	        return events;
            	  	},
            	    failure: function() {
            	        alert('이벤트를 가져오는 도중 오류가 발생했습니다!');
            	    },
            	
            	    }
            	}
       
	
        // 캘린더 생성
        const calendar = new FullCalendar.Calendar(calendarEl, calendarOption);
        // 캘린더 그리깅
        calendar.render();

        // 캘린더 이벤트 등록
        calendar.on("eventAdd", info => console.log("Add:", info));
         /*  calendar.on("eventChange", info => console.log("Change:", info));
        calendar.on("eventRemove", info => console.log("Remove:", info)); */
        calendar.on("eventClick", info => {
        	
        	console.log("이거이거: ",info.id);
             console.log("eClick:", info);
             /*console.log('Event: ', info.event.extendedProps);
            console.log('Coordinates: ', info.jsEvent);
            console.log('View: ', info.view);  */
            console.log('요거요거:',info.event.title);
            calTitle.value= info.event.title;
            
            calContent.value=info.event.extendedProps.calContent; 
            calType.value=info.event.extendedProps.calType;
            console.log(info.event.extendedProps.empId); //COMA_1 이렇게 나옴
            empId.value=info.event.extendedProps.empId[0].empId; //[object Object]이렇게 넘어옴 ;;
			
            let dateEnd = new Date(info.event.endStr); 			
			let localOffsetEnd = dateEnd.getTimezoneOffset() * 60000;
			let localISOTimeEnd = (new Date(dateEnd - localOffsetEnd)).toISOString().slice(0,16);
			calEnd.value = localISOTimeEnd;
                  
			let date = new Date(info.event.startStr);
			let localOffset = date.getTimezoneOffset() * 60000;
			let localISOTime = (new Date(date - localOffset)).toISOString().slice(0,16);
			calStart.value = localISOTime;
			
			calColor.value = info.event.backgroundColor;
			
			
            Modal.style.display = "block"; 
        });
        /* calendar.on("eventMouseEnter", info => console.log("eEnter:", info));
        calendar.on("eventMouseLeave", info => console.log("eLeave:", info)); */ 
        calendar.on("dateClick", info => {
        	console.log("dateClick: "+info);
        	console.log("dateClick:", info.dateStr);
        	calStart.value=info.dateStr+" 09:00:00";
        	calEnd.value=info.dateStr+" 18:00:00";
        	calTitle.value="";
            calContent.value="";
            empId.value="${loginmember.empId}";
        }); 
         calendar.on("select", info => {                  
            calStart.value=info.startStr+" 09:00:00";
           var endData=new Date(info.endStr.substr(0,4),info.endStr.substr(5,2)-1,info.endStr.substr(8,2));
           var dateString = endData.toISOString();
           dateString = dateString.split("T")[0] + " 18:00:00";
           calEnd.value=  dateString;
          
           info.endStr=calEnd.value; 
           info.end=dateString;
           calTitle.value="";
           calContent.value="";
           empId.value="${loginmember.empId}";
            Modal.style.display = "block";         
        }); 
         	/* function fcDept(){
      		$.ajax({
      			url: "/calendar/calendarDept",
      			method: "POST",
      			dataType: "json",
      			data:{deptCode:loginmember.deptCode};
      		})
      	};  */
 
        // 일정(이벤트) 추가하기
        function fCalAdd() {
            if (!calTitle.value) {
                alert("제목을 입력해주세요")
                calTitle.focus();
                return;
                
            }
            let event = {
            
                    empId: empId.value, //추가
                    calTitle: calTitle.value, 
                    calContent: calContent.value, // 추가
            		calStart: calStart.value,
                    calEnd: calEnd.value,
                    calType: calType.value, //추가
                    calColor: calColor.value
            };
            $.ajax({
                url: "/calendar/calendarInsert",
                method: "POST",
                dataType: "json",
                data: JSON.stringify(event),
                contentType: 'application/json',
                success: function(data){
		           // calendar.addEvent(data); 
		            location.href='/calendar';
                },
                error: function(e){
                	alert('일정등록중 오류가 발생하였습니다 다시 시도하십시오');
                	console.log(e);
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