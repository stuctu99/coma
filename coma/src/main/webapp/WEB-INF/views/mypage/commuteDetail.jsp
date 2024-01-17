<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<jsp:include page="/WEB-INF/views/common/header.jsp">
	<jsp:param name="id" value="mine" />
</jsp:include>
<c:set var="emp"
	value="${sessionScope.SPRING_SECURITY_CONTEXT.authentication.principal }" />

<script src="/resource/js/jquery-3.7.0.js"></script>
<style>
div {
	/*  border: 2px solid red; */
	
}

.bigbax {
	/* border: 2px solid blue; */
	margin: 15px;
	/* border: 2px solid lightgrey */;
	border-radius: 20px;
	background-color: #f1edff;
	padding: 20px 10px 0px 20px;
	box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
}

.containerbig {
	margin: 50px;
	text-align: center;
	padding: 20px;
	border-radius: 20px;
}

.smallbox {
	margin: 30px;
	/* border: 1px solid lightgrey;   */
}

.blank {
	padding-top: 20px;
}

/* You may need to adjust the styling based on your specific requirements */
</style>
<div class="coma-container containerbig">
	  <%-- ${commute}  --%>
	<div class="row">
		<div class="col-1"></div>
		<div class="col-2" style="display: flex;">
			<h1>근태 정보</h1>
		</div>
		<div class="col-7"></div>
		
		<div class="col-1"></div>
	</div>
	<div class="row" style="text-align: center;">
		<div class="col-1"></div>
		<div class="col-2">
			<div class="form-group">
		        <input class="form-control" type="date" name="startTime"  id="example-date-input-start">
		    </div>
		</div>
		<div class="col-2">
			<div class="form-group">
		        <input class="form-control" type="date" name="endTime"  id="example-date-input-end">
		    </div>
		</div>
		<div class="col-1">
			<button type="button" class="btn btn-primary"  onclick="submitForm()">검색</button>
		</div>
		
		<div class="col-1">
			<button type="button" class="btn btn-primary"  onclick="submitForm()">전체보기</button>
		</div>
	</div>
	<div class="row">
		<div class="col-1"></div>
		<div class="col-10  bigbax">
			<div class="row" style="margin-left: 30px">
				<div class="col-2 smallbox" >
					<div class="">
						<h3 >근무 일수</h3>
					</div>
					
					<div class="blank">
					<!--  -->
						<c:if test="${not empty commute}">
						    <c:set var="nomalCount" value="0" />
						    <c:set var="nonAntteCount" value="0" />
						    	<c:forEach var="c" items="${commute}" varStatus="loop">
							        <c:set var="nomalCount" value="${nomalCount + 1}" />
							        <c:if test="${c. EMP_COMMUTE_STATUS == 'nonAntte'}">
							        	<c:set var="nonAntteCount" value="${nonAntteCount + 1}" />
							        </c:if>
						   	 	</c:forEach>
						    	<h4 id="finishCount">${nomalCount-nonAntteCount}</h4>
						</c:if>
					</div>
				</div>
				<div class="col-2 smallbox" >
					<div class=" ">
						<h3 class="">정상 근무</h3>
					</div>
					<div class="blank">
						<c:if test="${not empty commute}">
					    <c:set var="nomalCount" value="0" />
					    	<c:forEach var="c" items="${commute}" varStatus="loop">
					    	<!-- 지각 안한사람  -->
						        <c:if test="${c. EMP_COMMUTE_LATENESS == 'N'}">
						            <c:set var="nomalCount" value="${nomalCount + 1}" />
						        </c:if>
					   	 	</c:forEach>
					    <h4 id="finishCount">${nomalCount}</h4>
						</c:if>
					</div>
					
				</div>
				<div class=" col-2 smallbox">
					<div class="">
						<h3 class="">지각</h3>
					</div>
					<div class="blank">
						<c:if test="${not empty commute}">
					    <c:set var="lateCount" value="0" />
					    <c:forEach var="c" items="${commute}" varStatus="loop">
					    <!-- 지각 안한사람  -->
					        <c:if test="${c. EMP_COMMUTE_LATENESS == 'Y'}">
					            <c:set var="lateCount" value="${lateCount + 1}" />
					        </c:if>
					    </c:forEach>
						
					    <h4 id="lateCount">${lateCount}</h4>
					</c:if>
					</div>
				</div>
				<div class=" col-2 smallbox">
					<div class="">
						<h3 class="">결근</h3>
					</div>
					<div class="blank">
						<c:set var="nonAntteCount" value="0" />
						<c:if test="${not empty commute}">
						    <c:set var="absenceCount" value="0" />
						    <c:forEach var="c" items="${commute}" varStatus="loop">
						        <c:if test="${c.EMP_COMMUTE_ABSENCE == 'Y'}">
						            <c:set var="absenceCount" value="${absenceCount + 1}" />
						        </c:if>
						        <c:if test="${c. EMP_COMMUTE_STATUS == 'nonAntte'}">
							        	<c:set var="nonAntteCount" value="${nonAntteCount + 1}" />
							    </c:if>
						    </c:forEach>
						    <h4 id="finishCount">${absenceCount-nonAntteCount}</h4>
						</c:if>
					</div>
				</div>
			</div>
		</div>
		<div class="col-1"></div>
	</div>
	<div class="row" style="text-align: center;">
		<div class="col-1"></div>
		<div class="col-10">
			<div class="row" style="margin-top: 30px">
				<div class="col-2">
					<h1>근태 상세보기</h1>
				</div>
				
				<div class="col-8">
					<div class=""></div>
				</div>
				<div class="col-1">
					<button type="button" class="btn btn-outline-primary" id="commuteWriteBtn">근태 변경 신청하기</button>
				</div>
			</div>
			<div class="col-1"></div>
		</div>
		<div class="col-1"></div>
	</div>
	<div class="row">
		<div class="col-1"></div>
		
	</div>
	<div class="row">
		<div class="col-1"></div>
		<div class="col-10">
			<div class="col">
				<table class="table align-items-center" style="text-align: center;">
					<thead class="thead-light">
						<tr>
							<th>상태</th>
							<th>날짜</th>
							<th>출근 시간</th>
							<th>퇴근 시간</th>
							<th>근무시간</th>
							<th>외출 시작 시간</th>
							<th>외출 끝 시간</th>
							<th>외출시간</th>
						</tr>
					</thead>
					<tbody class="list" id="empTable">
						<c:if test="${not empty commute}">
							<c:forEach var="c" items="${commute }">
								<c:if test="${ c.EMP_COMMUTE_STATUS ne 'nonAntte'}">
									<tr>
										<td is=""><c:out value="${c.EMP_COMMUTE_STATUS }" /></td>
										<td><fmt:formatDate value="${c.EMP_COMMUTE_WORKDATE}" pattern="yyyy-MM-dd" /></td>
										<td><fmt:formatDate  value="${c.EMP_COMMUTE_CLOCKIN.toJdbc() }" pattern="hh:mm:ss"/></td> 
										<td><fmt:formatDate  value="${c.EMP_COMMUTE_CLOCKOUT.toJdbc() }" pattern="hh:mm:ss" /></td>
										<td><c:out value="${c.WORK_DURATION }" /></td>  
										<td><fmt:formatDate value="${c.EMP_COMMUTE_STARTTIME.toJdbc() }" pattern="hh:mm:ss"/></td> 
										<td><fmt:formatDate  value="${c.EMP_COMMUTE_ENDTIME.toJdbc() }" pattern="hh:mm:ss" /></td> 
										<td><c:out value="${c.BREAK_DURATION }" /></td> 									
									</tr>
								</c:if>
							</c:forEach>
						</c:if>
					</tbody>
				</table>
				<div id="pageBar">${pageBar }</div>
			</div>
		</div>
		<div class="col-1"></div>
	</div>
</div>
<!-- <div class="coma-container">
	<div class="row">
		총 12칸
		<div class="col-4">1</div>
		<div class="col-4">2</div>
		<div class="col-4">3</div>
	</div>
</div> -->

<script>
function submitForm(cPage = 1, numPerpage = 10, url) {
    var startTime = $("#example-date-input-start").val();
    var endTime = $("#example-date-input-end").val();
    fetch("${path}/commute/commuteDetailEnd", {
        method: "POST",
        headers: { "Content-Type": "application/json" },
        body: JSON.stringify({
            cPage: cPage,
            numPerpage: numPerpage,
            startTime: startTime,
            endTime: endTime,
            jsName: "submitForm"
        })
    })
        .then(response => {
            if (!response.ok) {
                throw new Error(`HTTP error! Status: ${response.status}`);
            }
            return response.json();
        })
        .then(data => {      
            console.log(data);           
            updateTable(data.commuteList);
            console.log(totalData); 
            $('#totalwork').html(totalData);
        })
        .catch(error => {
            console.error("Error:", error);
        });
}

function updateTable(commuteList) {
    $("#empTable").empty();
    var clockInTime, clockOutTime,startTime,endTime,workDate,absenceCount,latenessCount ;
    var absenceCount=0,latenessCount = 0,nonabsence =0;
    commuteList.forEach(c => {
         clockInTime = c.EMP_COMMUTE_CLOCKIN;
         clockOutTime = c.EMP_COMMUTE_CLOCKOUT;
         startTime = c.EMP_COMMUTE_STARTTIME;
         endTime = c.EMP_COMMUTE_ENDTIME;
         //날짜만 잘라준다 
         workDate = c.EMP_COMMUTE_WORKDATE.substring(0, 10);
       
        /* console.error("clockInTime:", clockInTime);
        console.error("clockOutTime:", clockOutTime);
        console.error("startTime:", startTime);
        console.error("endTime:", endTime);
        console.error("workDate:", workDate); */  
        var row = document.createElement("tr");

        var statusCell = document.createElement("td");
        statusCell.textContent = c.EMP_COMMUTE_STATUS;
        row.appendChild(statusCell);

        var workDateCell = document.createElement("td");
        workDateCell.textContent = workDate;
        row.appendChild(workDateCell);

        var clockInTimeCell = document.createElement("td");
        clockInTimeCell.textContent = clockInTime;
        row.appendChild(clockInTimeCell);

        var clockOutTimeCell = document.createElement("td");
        clockOutTimeCell.textContent = clockOutTime;
        row.appendChild(clockOutTimeCell);

        var workDurationCell = document.createElement("td");
        workDurationCell.textContent = c.WORK_DURATION;
        row.appendChild(workDurationCell);

        var startTimeCell = document.createElement("td");
        startTimeCell.textContent = startTime;
        row.appendChild(startTimeCell);

        var endTimeCell = document.createElement("td");
        endTimeCell.textContent = endTime;
        row.appendChild(endTimeCell);

        var breakDurationCell = document.createElement("td");
        breakDurationCell.textContent = c.BREAK_DURATION;
        row.appendChild(breakDurationCell);

        // Append the row to the table
        $("#empTable").append(row);
        if (c.EMP_COMMUTE_ABSENCE === 'Y') {
            absenceCount++;
        }
        if (c.EMP_COMMUTE_ABSENCE === 'N') {
        	nonabsence++;
        }

        if (c.EMP_COMMUTE_LATENESS === 'Y') {
            latenessCount++;
        }
        
    });
    
    
    console.error("latenessCount:", latenessCount);
    console.error("absenceCount:", absenceCount);
    console.error("nonabsence:", nonabsence);
    var total = absenceCount+nonabsence
    $('#lateCount').html(${'latenessCount'});
    $('#finishCount').html(${'absenceCount'});
    $('#absence').html(${'nonabsence'});
    $('#totalwork').html(${'total'});
    
}
document.getElementById('commuteWriteBtn').addEventListener('click', function() {
    window.location.href = ${pageContext.request.contextPath}'/approval/writedoc';
});


	
</script>
<script src="${path }/resource/js/plugins/jquery/dist/jquery.min.js"></script>
<jsp:include page="/WEB-INF/views/common/footer.jsp" />