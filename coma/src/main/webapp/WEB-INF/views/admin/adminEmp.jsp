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
    .tableSize{
    	width:300px;
    }
</style>
<!-- TEAM COMA SPACE -->
<div class="coma-container" style="margin-top:5px; margin-bottom: 5px;">
	<div class="row">
		<div class="col-1"></div>
		<div class="col-7" >
			<div style="text-align:center;">
				<h1>사원 관리 페이지</h1>
			</div>
			<div style="width:100%; height:100%;">
				<canvas id="myChart"></canvas>
			</div>
		</div>
		<div class="col-3">
			<div class="tableSize" style="text-align:center;">
				<h1>부서별 사원 명수</h1>
				<table class="table align-items-center" style="text-align: center; margin-top: 39px;">
					<thead class="list">
						<tr>
							<th>총 사원 수</th>
							<td><c:out value="${totalEmp }"/></td>
						</tr>
						<c:forEach var="ec" items="${empCount }">
							<tr>
								<th><c:out value="${ec.DEPT_TYPE }"/></th>
								<td><c:out value="${ec.DEPTCOUNT }"/></td>
							</tr>
						</c:forEach>
					</thead>
				</table>
			</div>
		</div>
		<div class="col-1"></div>
	</div>
</div>
<div style="border: 1px solid #c1c0c073;"></div>
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
			  <option value="DEPT_TYPE">부서</option>
			  <option value="JOB_TYPE">직책</option>
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
		                <th>직책</th>
		                <th>소속 부서</th>
		                <th>근태상태</th>
		                <th></th>
		            </tr>
		        </thead>
		        <tbody class="list" id="empTable">
		         <c:if test="${not empty emps}">
		        	<c:forEach var="e" items="${emps }">
		        	<tr>
		        		<td><c:out value="${e.empId }"/></td>
		        		<td><a href="${path }/mypage/EmployeeDetails?empId=${e.empId }"><c:out value="${e.empName }"/></a></td>
		        		<td><c:out value="${e.job.jobType }"/></td>
 		        		<td><c:out value="${e.dept.deptType }"/></td>
		        		<td><a href="#"><c:out value="${e.empCurrent}"/></a></td>
		        		<td>
			        		<button type="button" class="btn btn-secondary btn-sm" onclick="fn_deleteEmp('${e.empId }');">삭제</button>
		        		</td>
		        	</tr>
					 </c:forEach>
		           </c:if>
		        </tbody>
		    </table>
		    <div id="pageBar"></div>
		</div>
	</div>
</div>
<script>
//chart.js
const chartData=${chartEmpData}	//응답받은 차트데이터 변수에 저장
const chartObject=JSON.stringify(chartData);	//JSON형식으로 데이터 형변환
const chartEmpData=JSON.parse(chartObject);	//JSON 형식의 문자열을 다시 JavaScript 객체로 변환

//JSON형식으로 변환한 값을 저장하기 배열 생성
var labelList = new Array();
var valueList = new Array();
var colorList = new Array();

//JSON형식으로 변환한 chartEmpData 데이터 값만큼 반복문 실행하면 배열 변수에 각각의 값을 대입 
for(let i=0;i<chartEmpData.length;i++){
	let e=chartEmpData[i];
	labelList.push(e.DEPT_TYPE);
	valueList.push(e.DEPTCOUNT);
	colorList.push(colorize());

}
//차트 색상 랜덤 설정
function colorize() {
	var r = Math.floor(Math.random()*200);
	var g = Math.floor(Math.random()*200);
	var b = Math.floor(Math.random()*200);
	var color = 'rgba(' + r + ', ' + g + ', ' + b + ', 0.2)';
	return color;
}


const ctx = document.getElementById('myChart').getContext('2d');
const myChart = new Chart(ctx, {
    type: 'bar',
    data: {
        labels: labelList,
        datasets: [{
            label: '사원 근태 통계',
            data: valueList,
            backgroundColor: colorList
        }]
    },
    options: {
        scales: {
        	yAxes : [ {
				ticks : {
					beginAtZero : true,
					stepSize: 1
				}
			} ]

        }
    }
});

//사원 부서별, 직책별 검색
function fn_searchEmp(cPage=1,numPerpage=10,url){
	const searchData=document.getElementById("searchData").value;
	const textData=document.getElementById("textData").value;
	console.log(searchData,textData);
	fetch(url?'${path}'+url:"/admin/searchEmp",{
		method:"post",
		headers:{"Content-Type":"application/json"},
		body:JSON.stringify({
			cPage:cPage,
			numPerpage:numPerpage,
			searchData:searchData,
			textData:textData
		})
	}).then(response=>{
		if(response.status!=200) throw new Error(repsonse.status);
		return response.json();
	}).then(result=>{
		console.log(result);
		const $tbody=document.getElementById("empTable");
		const $div=document.getElementById("pageBar");
		const $trList = $tbody.querySelectorAll("tr"); //querySelectorAll을 사용하여 모든 <tr> 요소의 NodeList를 가져옵니다.
		$trList.forEach($tr => {
		    $tbody.removeChild($tr); //각 $tr 요소를 $tbody에서 제거합니다.
		});
		result.emps.forEach((e)=>{
			const $tr=document.createElement('tr');
			const $td1=document.createElement('td');
			const $a=document.createElement('a');
			const $a2=document.createElement('a');
			$td1.innerText=e.empId;
			
			const $td2=document.createElement('td');
			$a.setAttribute('href','#');
			$a.innerText=e.empName;
			$td2.appendChild($a);
			
			const $td3=document.createElement('td');
			$td3.innerText=e.job.jobType;
			
			const $td4=document.createElement('td');
			$td4.innerText=e.dept.deptType;
			
			const $td5=document.createElement('td');
			$a2.setAttribute('href','#');
			$a2.innerText=e.empCurrent;
			$td5.appendChild($a2);
			
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
		$div.innerText="";
		$div.innerHTML=result.pageBar;
	}).catch(e=>{
		console.log(e);
	})
}


//신입사원 아이디 생성 및 배포
function fn_addEmp(){
	const empName=document.getElementById("empName").value;
	console.log(empName);
	fetch("${path}/admin/insertEmp",{
		method:"post",
		headers:{"Content-Type":"application/json"},
		body:JSON.stringify({
			empName:empName
			})
	})
	.then(response=>{
		console.log(response);
		if(response.status!=200){
			throw new Error("");
		}
		return response.json();
	}).then(result=>{
		if(result>0){
			alert("신규 아이디가 등록 되었습니다.");
			window.location.href = "${path}/admin/adminEmp";
		}
	}).catch(e=>{
		alert(e);
	});
} 

//사원 퇴사후 아이디 비활성화
function fn_deleteEmp(e){
	fetch("${path}/admin/deleteEmp",{
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
		if(result>0){
			alert("퇴사처리 완료 되었습니다.");
			window.location.href = "${path}/admin/adminEmp";
		}
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