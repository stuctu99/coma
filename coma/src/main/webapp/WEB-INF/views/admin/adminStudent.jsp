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
/*     div{
      border: 2px solid red;
    } */
</style>
<!-- TEAM COMA SPACE -->
<div class="coma-container" style="margin-top:5px; margin-bottom: 5px;">
	<div class="row">
	<div class="col-1"></div>
		<div class="col-7" >
			<div style="text-align:center;">
				<h1>학생 관리 페이지</h1>
			</div>
			<div style="width:100%; height:550px;">
				<!-- <div id="chart_div" class="col-10"></div> -->
				<canvas id="myChart"></canvas>
				<div class="row">
					<div style="text-align: center; display: flex; flex-direction: column; align-items: center;">
						<label for="example-text-input" class="form-control-label"><c:out value="총 누적 학생 수"/></label>
						<input class="form-control form-control-sm" type="text" style="background-color: #ffffff; text-align: center; width:200px;" value="${totalStudent }명" readonly>
					</div>
					<div style="text-align: center; display: flex; flex-direction: column; align-items: center;">
						<label for="example-text-input" class="form-control-label"><c:out value="총 누적 학생 수"/></label>
						<input class="form-control form-control-sm" type="text" style="background-color: #ffffff; text-align: center; width:200px;" value="${totalStudent }명" readonly>
					</div>
				</div>
			</div>
		</div>
		<div class="col-3">
			<div style="text-align:center;">
				<h1>반별 학생 수</h1>
			</div>
			<div class="row">
			<c:forEach var="s" items="${studentCount }">
				<div class="col-6">
					<div style="text-align: center;">
						<label for="example-text-input" class="form-control-label"><c:out value=""/>${s.EMP_NAME }</label>
						<input class="form-control form-control-sm" type="text" value="${s.STUDENTCOUNT }명" style="text-align: center;">
					</div>
				</div>
			</c:forEach>
			</div>
		</div>
	</div>
	<div class="col-1"></div>
</div>
<div style="text-align:center; margin:10px 0px 10px 0px;">
	<h1>학생 리스트</h1>
</div>
<div class="coma-container" style="margin-top:5px; margin-bottom: 5px;">
	<div class="row" style="display: flex; align-items: center;">
		<div class="col-1"></div>
		<!-- <div class="col-1" style="margin-left:15px;">
			<select class="form-control form-control-sm" id="searchData">
			  <option value="student">학생</option>
			  <option value="studentCom">수료생</option>
			  <option value="studentEmp">취업생</option>
			</select>
		</div> -->
		<div class="col-1.5" style="padding-left:0px; ">
			<input class="form-control form-control-sm" type="text" id="textData" placeholder="이름으로 검색">
		</div>
		<div class="col-9.5" style="padding-left:0px;">
			<button type="button" class="btn btn-secondary btn-sm" onclick="fn_searchStudent();">검색</button>
		</div>
	</div>
	<div class="table-responsive" style="padding: 0px 115px 0px 115px;">
		<div class="col">
		    <table class="table align-items-center" style="text-align: center;">
		        <thead class="thead-light">
		            <tr>
		                <th>학생 이름</th>
		                <th>담당 강사</th>
		                <th>수료여부</th>
		                <th>취업여부</th>
		            </tr>
		        </thead>
		        <tbody class="list" id="studentTable">
		        <c:forEach var="s" items="${students }">
		        	<tr>
		        		<td><a href="#"><c:out value="${s.stuName }"/></a></td>
		        		<td><c:out value="${s.empId }"/></td>
		        		<td><c:out value="${s.stuComStatus }"/></td>
		        		<td><c:out value="${s.stuEmpStatus }"/></td>
		        	</tr>
		        </c:forEach>
		        </tbody>
		    </table>
		    <div id="pageBar">${pageBar }</div>
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

function fn_searchStudent(cPage=1,numPerpage=10,url){
	//const searchData=document.getElementById("searchData").value;
	const textData=document.getElementById("textData").value;
	console.log(textData);
	fetch(url?'${path}'+url:"/admin/searchStudent",{
		method:"post",
		headers:{"Content-Type":"application/json"},
		body:JSON.stringify({
			cPage:cPage,
			numPerpage:numPerpage,
			textData:textData
		})
	}).then(response=>{
		if(response.status!=200) throw new Error(repsonse.status);
		return response.json();
	}).then(result=>{
		//console.log(result.pageBar);
		//console.log(result.students);
		const $tbody=document.getElementById("studentTable");
		const $div=document.getElementById("pageBar");
		const $trList = $tbody.querySelectorAll("tr"); //querySelectorAll을 사용하여 모든 <tr> 요소의 NodeList를 가져옵니다.
		$trList.forEach($tr => {
		    $tbody.removeChild($tr); //각 $tr 요소를 $tbody에서 제거합니다.
		});
		//Array.prototype.forEach.call($tbody.children,e=>e.remove());
		result.students.forEach((e)=>{
			const $tr=document.createElement('tr');
			const $td1=document.createElement('td');
			const $a=document.createElement('a');
			$a.setAttribute('href','#');
			$a.innerText=e.stuName;
			$td1.appendChild($a);
			const $td2=document.createElement('td');
			$td2.innerText=e.empId;
			const $td3=document.createElement('td');
			$td3.innerText=e.stuComStatus;
			const $td4=document.createElement('td');
			$td4.innerText=e.stuEmpStatus;
			$tr.appendChild($td1);
			$tr.appendChild($td2);
			$tr.appendChild($td3);
			$tr.appendChild($td4);
			$tbody.appendChild($tr);
		})		
		$div.innerText="";
		$div.innerHTML=result.pageBar;
		
	}).catch(e=>{
		console.log(e);
	})
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