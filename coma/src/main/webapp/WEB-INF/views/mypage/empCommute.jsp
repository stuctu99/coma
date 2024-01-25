<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<jsp:include page="/WEB-INF/views/common/header.jsp">
	<jsp:param name="id" value="mine" />
</jsp:include>
<c:set var="path" value="${pageContext.request.contextPath}"/>
<c:set var="emp" value="${sessionScope.SPRING_SECURITY_CONTEXT.authentication.principal }" />
<script src="${path }/resource/js/jquery-3.7.0.js"></script>
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

</style>
<%-- ${ commute} --%>
<div class="coma-container containerbig">  
	<div class="row">
		<div class="col-1"></div>
		<div class="col-4" style="display: flex;">
			<h1 style= "color:blue;">${empName.empName}</h1> <h1>님의 근태 정보</h1>
		</div>
		<div class="col-5"></div>
		
		<div class="col-1"></div>
	</div>
	<div class="row" style="text-align: center;">
	<div class="col-1"></div>
	<div class="col-2">
			<div class="form-group">
				<input class="form-control" value= "" type="date" name="endTime"  id="endTime"  onchange="updateEndTimeMin()">
		    </div>
		</div>
		<div class="col-2">
			<div class="form-group">
		        <input class="form-control" type="date" name="start"  id="start">
		    </div>
		</div>
		<div class="col-1">
			<button type="button" class="btn btn-primary"  onclick="submitForm();">검색</button>
		</div>
		<div class="col-1">
			<a href="${path }/commute/empCommute?empId=${empId }">
				<img src="${path }/resource/img/icons/common/back.png" style="width: 40px;">
			</a>
		</div>
	</div>
	<td>            
	<div class="row">
		<div class="col-1"></div>
		<div class="col-10">
			<div class="col">
			<form action="${path}/commute/updateEmployeeCommute" method="post">
				<table class="table align-items-center" style="text-align: center;">
					<thead class="thead-light">
						<tr>
							<th>상태</th>
							<th>날짜</th>
							<th>출근 시간</th>
							<th>퇴근 시간</th>
							<th>외출 시작 시간</th>
							<th>외출 끝 시간</th>
							<th>수정</th>
						</tr>
					</thead>
					
					<tbody class="list" id="empTable">
						<c:if test="${not empty commute}">
							<c:forEach var="c" items="${commute }">
								<c:if test="${ c.EMP_COMMUTE_STATUS ne 'nonAntte'}">
									<tr>
										<td>
										    <select class="form-control" id="exampleFormControlSelect1" name="status">
										     <option value="근무중" <c:if test="${c.STATUS eq '근무중'}"> selected="selected" </c:if>>근무중</option>
										     <option value="외근중"<c:if test="${c.STATUS eq '외근중'}"> selected="selected" </c:if>>외근중</option>
										     <option value="퇴근 미처리"<c:if test="${c.STATUS eq '퇴근 미처리'}"> selected="selected" </c:if>>퇴근 미처리</option>
										     <option value="퇴근"<c:if test="${c.STATUS eq '퇴근'}"> selected="selected" </c:if>>퇴근</option>
										     <option value="결근"<c:if test="${c.STATUS eq '결근'}"> selected="selected" </c:if>>결근</option>
										     <option value="지각" <c:if test="${c.STATUS eq '지각'}"> selected="selected" </c:if>>지각</option>
										     <option value="연차" <c:if test="${c.STATUS eq '연차'}"> selected="selected" </c:if>>연차</option>
										     <option value="반차" <c:if test="${c.STATUS eq '반차'}"> selected="selected" </c:if>>반차</option>
										     </select>

										</td>
										<td>
											<fmt:formatDate value="${c.EMP_COMMUTE_WORKDATE}" pattern="yyyy-MM-dd" />
										</td>
										<td>
									        <input class="form-control" type="time" name= "clockin" step="1"
									        value="<fmt:formatDate  value="${c.EMP_COMMUTE_CLOCKIN.toJdbc() }" pattern="HH:mm:ss"/>" id="example-search-input"/>
										</td> 
										<td>
											<input class="form-control" type="time" name= "clockout" step="1"
									        value="<fmt:formatDate  value="${c.EMP_COMMUTE_CLOCKOUT.toJdbc() }" pattern="HH:mm:ss"/>" id="example-search-input"/>
										</td>
										<td>
											<input class="form-control" type="time" name= "starttime" step="1"
									        value="<fmt:formatDate value="${c.EMP_COMMUTE_STARTTIME.toJdbc() }" pattern="HH:mm:ss"/>" id="example-search-input"/>
										</td> 
										<td>
											<input class="form-control"  type="time" name= "endtime" step="1"
									        value="<fmt:formatDate  value="${c.EMP_COMMUTE_ENDTIME.toJdbc() }" pattern="HH:mm:ss" />" id="example-search-input"/>
										</td> 	
										<td>
											<button type="submit" class="btn btn-secondary btn-sm">근무 수정</button>
										</td>
									</tr>
									<input type="hidden" value = "<fmt:formatDate value="${c.EMP_COMMUTE_WORKDATE}" pattern="yy/MM/dd" />" name= "workdate">
									<input type="hidden" value = "${empId }" name= "empId" id="empId" >									
								</c:if>
							</c:forEach>
						</c:if>
					</tbody>
				</table>
				</form>
				<div id="pageBar">${pageBar }</div>
			</div>
		</div>
		<div class="col-1"></div>
	</div>
</div>
<script>

var today = new Date();
var year = today.getFullYear();
var month = today.getMonth() + 1; 
var day = today.getDate();
// 날짜를 "YYYY-MM-DD" 형식의 문자열로 만들기
var formattedDate = (year % 100) + '-' + (month < 10 ? '0' + month : month) + '-' + (day < 10 ? '0' + day : day);
console.log(formattedDate);
// 입력 요소에 현재 날짜 설정
document.getElementById('start').value = formattedDate;


function submitForm(cPage = 1, numPerpage = 10, url) {
    var empId = $("#empId").val();
    var endTime = $("#start").val();
    var startTime = $("#endTime").val();
    var loginId = $("#empId").val();
    console.log(startTime);
    console.log(endTime);
    console.log(empId);
    fetch(url?"${path}"+url:"${path}/commute/empCommuteEnd", {
        method: "POST",
        headers: { "Content-Type": "application/json" },
        body: JSON.stringify({
            cPage: cPage,
            numPerpage: numPerpage,
            startTime: startTime,
            endTime: endTime,
            loginId: loginId,
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
           
            
            const $tbody = document.getElementById("empTable");
    	    const $div = document.getElementById("pageBar");
    	    const $trList = $tbody.querySelectorAll("tr");

    	    $trList.forEach($tr => {
    	        $tr.remove();
    	    });
			console.log(data);
    	    data.commuteList.forEach(c => {
    	    	if(c.EMP_COMMUTE_STATUS!='nonAntte'){
	    	        const $tr = document.createElement('tr');
	
	    	        const $td1 = document.createElement('td');

	    	        const selectElement = document.createElement('select');
	    	        selectElement.className = 'form-control';
	    	        selectElement.id = 'exampleFormControlSelect1';
	    	        selectElement.name = 'status';

	    	        const options = ['근무중', '외근중', '퇴근 미처리', '퇴근', '결근', '지각', '연차', '반차'];

	    	        options.forEach(optionValue => {
	    	          const optionElement = document.createElement('option');
	    	          optionElement.value = optionValue;

	    	          optionElement.selected = (optionValue === c.STATUS);

	    	          optionElement.innerText = optionValue;
	    	          selectElement.appendChild(optionElement);
	    	        });

	    	        $td1.appendChild(selectElement);
	    	        
	    	        const $td2 = document.createElement('td');
	    	        $td2.innerText = c.EMP_COMMUTE_WORKDATE.substring(0, 10);
					
					
	    	        const $td3 = document.createElement('td');
	    	        const $input1 = document.createElement('input');
	    	        $input1.className = 'form-control';
	    	        $input1.type = 'time';
	    	        $input1.name = 'clockin';
	    	        $input1.step='1';
	    	        $input1.value = c.EMP_COMMUTE_CLOCKIN  // 원하는 초기값 설정
	    	        $input1.id = 'example-search-input';
	    	        $td3.appendChild($input1);
	    	        console.log(typeof c.EMP_COMMUTE_WORKDATE);
	
	    	        const $td4 = document.createElement('td');
	    	        const $input2 = document.createElement('input');
	    	        $input2.className = 'form-control';
	    	        $input2.type = 'time';
	    	        $input2.name = 'clockout';
	    	        $input2.step='1';
	    	        $input2.value = c.EMP_COMMUTE_CLOCKOUT;  // 초기값 설정
	    	        $input2.id = 'example-search-input';
	    	        $td4.appendChild($input2);
	
	    	        const $td5 = document.createElement('td');
	    	        const $input3 = document.createElement('input');8
	    	        $input3.className = 'form-control';
	    	        $input3.type = 'time';
	    	        $input3.step='1';
	    	        $input3.name = 'starttime';
	    	        $input3.value = c.EMP_COMMUTE_STARTTIME;  // 초기값 설정
	    	        $input3.id = 'example-search-input';
	    	        $td5.appendChild($input3);
	
	    	        const $td6 = document.createElement('td');
	    	        const $input4 = document.createElement('input');
	    	        $input4.className = 'form-control';
	    	        $input4.type = 'time';
	    	        $input4.name = 'endtime';
	    	        $input4.step='1';
	    	        $input4.value = c.EMP_COMMUTE_ENDTIME ;  // 초기값 설정
	    	        $input4.id = 'example-search-input';
	    	        $td6.appendChild($input4);
	    			
	    	        const $td7 = document.createElement('td');
	    	        const $button = document.createElement('button');
	    	        $button.type = 'submit';
	    	        $button.className = 'btn btn-secondary btn-sm';
	    	        $button.innerText = '근무 수정';
	    	        $td7.appendChild($button);
	
	    	        const $hiddenInput1 = document.createElement('input');
	    	        $hiddenInput1.type = 'hidden';
	    	        $hiddenInput1.value = c.EMP_COMMUTE_WORKDATE;
	    	        $hiddenInput1.name = 'workdate';
	
	    	        const $hiddenInput2 = document.createElement('input');
	    	        $hiddenInput2.type = 'hidden';
	    	        $hiddenInput2.value = empId;
	    	        $hiddenInput2.name = 'empId';
	    	        $hiddenInput2.id = 'empId';
	
	    	        // 필요한 hidden input 요소들을 각각의 td에 추가
	    	        $td3.appendChild($hiddenInput1);
	    	        $td3.appendChild($hiddenInput2);

	    	        $tr.appendChild($td1);
	    	        $tr.appendChild($td2);
	    	        $tr.appendChild($td3);
	    	        $tr.appendChild($td4);
	    	        $tr.appendChild($td5);
	    	        $tr.appendChild($td6);
	    	        $tr.appendChild($td7); 
	    	        $tbody.appendChild($tr);
    	    	}
    	    });
    	    $div.innerText="";
			$div.innerHTML=data.pageBar;
        })
        .catch(error => {
            console.error("Error:", error);
        });
}

//기간 시작 기간보다 끝기간 못 지정하기 
function updateEndTimeMin() {
    var startTimeInput = document.getElementById('endTime');
    var selectedDate = startTimeInput.value;
    var endTimeInput = document.getElementById('start');
    endTimeInput.min = selectedDate;
}


</script>

<script src="${path }/resource/js/plugins/jquery/dist/jquery.min.js"></script>
<jsp:include page="/WEB-INF/views/common/footer.jsp" />