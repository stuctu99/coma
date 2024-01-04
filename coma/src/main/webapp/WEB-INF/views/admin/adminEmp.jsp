<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<c:set var="path" value="${pageContext.request.contextPath}"/>
<jsp:include page="/WEB-INF/views/common/header.jsp">
	<jsp:param name="id" value="mine" />
</jsp:include>
<!-- <script type="text/javascript" src="https://www.gstatic.com/charts/loader.js"></script> -->
<script src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/2.4.0/Chart.min.js"></script>
<style>
/* 	div{
      border: 2px solid red;
    } */
</style>
<!-- TEAM COMA SPACE -->
<div class="coma-container" style="margin-top:5px; margin-bottom: 5px;">
	<div class="row">
		<div class="col-1"></div>
		<div class="col-7" >
			<div style="text-align:center;">
				<h1>사원 관리 페이지</h1>
			</div>
			<div style="width:100%; height:550px;">
				<!-- <div id="chart_div" class="col-10"></div> -->
				<canvas id="myChart"></canvas>
			</div>
		</div>
		<div class="col-3">
			<div style="text-align:center;">
				<h1>부서별 사원 명수</h1>
			</div>
			<div class="row">
			<c:forEach var="ec" items="${empCount }">
				<div class="col-6" style="text-align: center;">
					<div>
						<label for="example-text-input" class="form-control-label"><c:out value="${ec.DEPT_TYPE }"/></label>
						<input class="form-control form-control-sm" type="text" style="background-color: #ffffff; text-align: center;" placeholder="${ec.DEPTCOUNT }명" readonly>
					</div>
				</div>
			</c:forEach>
			</div>
		</div>
		<div class="col-1"></div>
	</div>
</div>
<div style="text-align:center; margin:10px 0px 10px 0px;">
	<h1>사원 리스트</h1>
</div>
<div class="coma-container" style="margin-top:5px; margin-bottom: 5px;">
	<div class="row" style="display: flex; align-items: center;">
	<div class="col-1"></div>
		<div class="col-1" style="margin-left:15px;">
			<select class="form-control form-control-sm" id="searchData">
			  <option value="all">전체</option>
			  <option value="EMP_NAME">이름</option>
			  <option value="DEPT_CODE">부서</option>
			  <option value="JOB_CODE">직책</option>
			</select>
		</div>
		<div class="col-2" style="padding-left:0px;">
			<input class="form-control form-control-sm" type="text" id="textData" placeholder="검색할 단어 입력">
		</div>
		<div class="col-5" style="padding-left:0px;">
			<button type="button" class="btn btn-secondary btn-sm" style="width:50px;" onclick="fn_searchEmp();">검색</button>
		</div>
		<div class="col-2">
			<div class="row">
				<div class="col-8" style="padding-right:0px;">
					<form>
					<input class="form-control form-control-sm" id="empName" type="text" placeholder="추가할 사원 이름" required>
				</div>
				<div class="col-2">
					<button type=submit class="btn btn-primary btn-sm" onclick="fn_addEmp();">
						<span>사원 추가</span>
					</button>
					</form>
				</div>
			</div>
		</div>
	</div>
	<div class="table-responsive" style="padding: 0px 95px 0px 95px;">
		<div class="col">
		    <table class="table align-items-center" style="text-align: center;">
		        <thead class="thead-light">
		            <tr>
		                <th>사원 아이디</th>
		                <th>사원 이름</th>
		                <th>소속 부서</th>
		                <th>직책</th>
		                <th>근태상태</th>
		                <th></th>
		            </tr>
		        </thead>
		        <tbody class="list" id="empTable">
		         <c:if test="${not empty emps}">
		        	<c:forEach var="e" items="${emps }">
		        	<tr>
		        		<td><c:out value="${e.empId }"/></td>
		        		<td><a href="#"><c:out value="${e.empName }"/></a></td>
		        		<td><c:out value="${e.deptCode.deptCode }"/></td>
		        		<td><c:out value="${e.jobCode.jobCode }"/></td>
		        		<td><a href="#"><c:out value="${e.empCurrent }"/></a></td>
		        		<td>
			        		<button type="button" class="btn btn-secondary btn-sm" onclick="fn_deleteEmp('${e.empId }');">삭제</button>
		        		</td>
		        	</tr>
					 </c:forEach>
		           </c:if>
		        </tbody>
		    </table>
		    <div>${pageBar }</div>
		</div>
	</div>
</div>
<script>
//chart.js
const ctx = document.getElementById('myChart').getContext('2d');
const myChart = new Chart(ctx, {
    type: 'bar',
    data: {
        labels: ['Red', 'Blue', 'Yellow', 'Green', 'Purple', 'Orange'],
        datasets: [{
            label: '# of Votes',
            data: [12, 19, 3, 5, 2, 3],
            backgroundColor: [
                'rgba(255, 99, 132, 0.2)',
                'rgba(54, 162, 235, 0.2)',
                'rgba(255, 206, 86, 0.2)',
                'rgba(75, 192, 192, 0.2)',
                'rgba(153, 102, 255, 0.2)',
                'rgba(255, 159, 64, 0.2)'
            ],
            borderColor: [
                'rgba(255, 99, 132, 1)',
                'rgba(54, 162, 235, 1)',
                'rgba(255, 206, 86, 1)',
                'rgba(75, 192, 192, 1)',
                'rgba(153, 102, 255, 1)',
                'rgba(255, 159, 64, 1)'
            ],
            borderWidth: 1
        }]
    },
    options: {
        scales: {
            y: {
                beginAtZero: true
            }
        }
    }
});

//사원 부서별, 직책별 검색
function fn_searchEmp(){
	const searchData=document.getElementById("searchData").value;
	const textData=document.getElementById("textData").value;
	console.log(searchData,textData);
	fetch("/admin/searchEmp",{
		method:"post",
		headers:{"Content-Type":"application/json"},
		body:JSON.stringify({
			searchData:searchData,
			textData:textData
		})
	}).then(response=>{
		if(response.status!=200) throw new Error(repsonse.status);
		return response.json();
	}).then(result=>{
		console.log(result);
		console.log(result);
		const $tbody=document.getElementById("empTable");
		const $trList = $tbody.querySelectorAll("tr"); //querySelectorAll을 사용하여 모든 <tr> 요소의 NodeList를 가져옵니다.
		$trList.forEach($tr => {
		    $tbody.removeChild($tr); //각 $tr 요소를 $tbody에서 제거합니다.
		});
		//Array.prototype.forEach.call($tbody.children,e=>e.remove());
		result.students.forEach((e)=>{
			const $tr=document.createElement('tr');
			const $td1=document.createElement('td');
			const $a=document.createElement('a');
			$td1.innerText=e.emps.empId;
			
			const $td2=document.createElement('td');
			$a.setAttribute('href','#');
			$a.innerText=e.emps.empName;
			$td2.appendChild($a);
			
			const $td3=document.createElement('td');
			$td3.innerText=e.emps.deptCode;
			
			const $td4=document.createElement('td');
			$td4.innerText=e.emps.jobCode;;
			
			const $td5=document.createElement('td');
			$td5.innerText=e.emps.empCurrent;
			
			const $td6 = document.createElement('td');
			const $button = document.createElement('button');
			$button.setAttribute('type', 'button');
			$button.setAttribute('class', 'btn btn-secondary btn-sm');
			$button.setAttribute('onclick', `fn_deleteEmp('${e.empId}');`);
			$button.innerText = '삭제';
			$td6.appendChild($button);
			
			$tr.appendChild($td1);
			$tr.appendChild($td2);
			$tr.appendChild($td3);
			$tr.appendChild($td4);
			$tr.appendChild($td5);
			$tr.appendChild($td6);
			$tbody.appendChild($tr);
		})
	}).catch(e=>{
		console.log(e);
	})
}


//신입사원 아이디 생성 및 배포
function fn_addEmp(){
	const empName=document.getElementById("empName").value;
	console.log(empName);
	fetch("/admin/insertEmp",{
		method:"post",
		headers:{"Content-Type":"application/json"},
		body:JSON.stringify({empName:empName})
	})
	.then(response=>{
		console.log(response);
		if(response.status!=200){
			throw new Error("");
		}
		return response.json();
	}).then(result=>{
		console.log(result);
		const $tbody=document.getElementById("empTable");
		const $trList = $tbody.querySelectorAll("tr"); //querySelectorAll을 사용하여 모든 <tr> 요소의 NodeList를 가져옵니다.
		$trList.forEach($tr => {
		    $tbody.removeChild($tr); //각 $tr 요소를 $tbody에서 제거합니다.
		});
		//Array.prototype.forEach.call($tbody.children,e=>e.remove());
		result.students.forEach((e)=>{
			const $tr=document.createElement('tr');
			const $td1=document.createElement('td');
			const $a=document.createElement('a');
			$td1.innerText=e.emps.empId;
			
			const $td2=document.createElement('td');
			$a.setAttribute('href','#');
			$a.innerText=e.emps.empName;
			$td2.appendChild($a);
			
			const $td3=document.createElement('td');
			$td3.innerText=e.emps.deptCode;
			
			const $td4=document.createElement('td');
			$td4.innerText=e.emps.jobCode;;
			
			const $td5=document.createElement('td');
			$td5.innerText=e.emps.empCurrent;
			
			const $td6 = document.createElement('td');
			const $button = document.createElement('button');
			$button.setAttribute('type', 'button');
			$button.setAttribute('class', 'btn btn-secondary btn-sm');
			$button.setAttribute('onclick', `fn_deleteEmp('${e.empId}');`);
			$button.innerText = '삭제';
			$td6.appendChild($button);
			
			$tr.appendChild($td1);
			$tr.appendChild($td2);
			$tr.appendChild($td3);
			$tr.appendChild($td4);
			$tr.appendChild($td5);
			$tr.appendChild($td6);
			$tbody.appendChild($tr);
		})
	}).catch(e=>{
		alert(e);
	});
}

//사원 퇴사후 아이디 비활성화
function fn_deleteEmp(e){
	console.log(e);
	fetch("/admin/deleteEmp",{
		method:"post",
		headers:{"Content-Type":"application/json"},
		body:JSON.stringify({
			empId:e
		})
	})
	.then(response=>{
		console.log(response);
		if(response.status!=200){
			throw new Error("");
		}
		return response.json();
	}).then(result=>{
		console.log(result);
		const $tbody=document.getElementById("empTable");
		const $trList = $tbody.querySelectorAll("tr"); //querySelectorAll을 사용하여 모든 <tr> 요소의 NodeList를 가져옵니다.
		$trList.forEach($tr => {
		    $tbody.removeChild($tr); //각 $tr 요소를 $tbody에서 제거합니다.
		});
		//Array.prototype.forEach.call($tbody.children,e=>e.remove());
		result.students.forEach((e)=>{
			const $tr=document.createElement('tr');
			const $td1=document.createElement('td');
			const $a=document.createElement('a');
			$td1.innerText=e.emps.empId;
			
			const $td2=document.createElement('td');
			$a.setAttribute('href','#');
			$a.innerText=e.emps.empName;
			$td2.appendChild($a);
			
			const $td3=document.createElement('td');
			$td3.innerText=e.emps.deptCode;
			
			const $td4=document.createElement('td');
			$td4.innerText=e.emps.jobCode;;
			
			const $td5=document.createElement('td');
			$td5.innerText=e.emps.empCurrent;
			
			const $td6 = document.createElement('td');
			const $button = document.createElement('button');
			$button.setAttribute('type', 'button');
			$button.setAttribute('class', 'btn btn-secondary btn-sm');
			$button.setAttribute('onclick', `fn_deleteEmp('${e.empId}');`);
			$button.innerText = '삭제';
			$td6.appendChild($button);
			
			$tr.appendChild($td1);
			$tr.appendChild($td2);
			$tr.appendChild($td3);
			$tr.appendChild($td4);
			$tr.appendChild($td5);
			$tr.appendChild($td6);
			$tbody.appendChild($tr);
		})
	}).catch(e=>{
		alert(e);
	});

}

//Google 차트 js
/* google.charts.load('current', {'packages':['bar']});
google.charts.setOnLoadCallback(drawChart);

function drawChart() {
  var data = google.visualization.arrayToDataTable([
    ['YEAR', 'BS1', 'BS2', 'BS3','BS4','BS5','BS6'],
    ['2019', 100, 90, 98, 80, 50, 70],
    ['2020', 100, 90, 98, 80, 50, 70],
    ['2021', 100, 90, 98, 80, 50, 70],
    ['2022', 100, 90, 98, 80, 50, 70],
    ['2023', 100, 90, 98, 80, 50, 70]
  ]);

  var options = {
    chart: {
      title: 'COMA_EMP',
      subtitle: 'EMP 사원 년도별 근태 현황',
    },
    bars: 'horizontal', // Required for Material Bar Charts.
    hAxis: {format: 'decimal'},
    height: 600,
    colors: ['#1b9e77', '#d95f02', '#7570b3']
  };

  var chart = new google.charts.Bar(document.getElementById('chart_div'));

  chart.draw(data, google.charts.Bar.convertOptions(options));

  var btns = document.getElementById('btn-group');

  btns.onclick = function (e) {

    if (e.target.tagName === 'BUTTON') {
      options.hAxis.format = e.target.id === 'none' ? '' : e.target.id;
      chart.draw(data, google.charts.Bar.convertOptions(options));
    }
  }
} */
</script>
<!-- TEAM COMA SPACE -->
<jsp:include page="/WEB-INF/views/common/footer.jsp"/>