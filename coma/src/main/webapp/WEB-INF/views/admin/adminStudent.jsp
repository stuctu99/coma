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
    .tableSize{
    	width:300px;
    }
</style>
<!-- TEAM COMA SPACE -->
<div class="coma-container" style="margin-top:5px; margin-bottom: 5px;">
	<div class="row" style="margin-top:10px;">
		<div class="col-1"></div>
		<div class="col-6" >
			<div style="text-align:center;">
				<h1>학생 근태 통계</h1>
			</div>
			<div>
				<canvas id="stuCurentChart" style="height:200px; width:400px"></canvas>
			</div>
		</div>
		<div class="col-4">
			<div class="row" style="display: flex; justify-content: center;">
				<div class="tableSize" style="text-align:center;">
					<h1>학생 근태 수치</h1>
					<table class="table align-items-center" style="text-align: center; margin-top: 39px;">
						<thead class="list">
							<c:forEach var="s" items="${studentCount }">
								<tr>
									<td><c:out value="${s.EMP_NAME }"/></td>
									<td><c:out value="${s.STUDENTCOUNT }"/>명</td>
								</tr>
							</c:forEach>
						</thead>
					</table>
				</div>
			</div>
		</div>
		<div class="col-1"></div>
	</div>
	<div style="border: 1px solid #c1c0c073;"></div>
	<div class="row" style="margin-top:20px;">
		<div class="col-1"></div>
		<div class="col-6" >
			<div style="text-align:center;">
				<h1>학생 수료율 통계</h1>
			</div>
			<div>
				<canvas id="stuComChart" style="height:200px; width:400px"></canvas>
			</div>
		</div>
		<div class="col-4">
			<div class="row" style="display: flex; justify-content: center;">
				<div class="tableSize" style="text-align:center;">
					<h1>학생 수료율 수치</h1>
					<table class="table align-items-center" style="text-align: center; margin-top: 39px;">
						<thead class="list">
							<c:forEach var="sbc" items="${studentByComTable}">
				                <tr>
				                    <td><c:out value="${sbc.EMP_NAME}"/></td>
				                    <td><c:out value="${sbc.COM_RATE}"/>%</td>
				                </tr>
				            </c:forEach>
						</thead>
					</table>
				</div>
			</div>
		</div>
		<div class="col-1"></div>
	</div>
	<div style="border: 1px solid #c1c0c073;"></div>
	<div class="row" style="margin-top:20px;">
		<div class="col-1"></div>
		<div class="col-6" >
			<div style="text-align:center;">
				<h1>학생 취업율 통계</h1>
			</div>
			<div>
				<canvas id="stuEmpChart" style="height:200px; width:400px"></canvas>
			</div>
		</div>
		<div class="col-4">
			<div class="row" style="display: flex; justify-content: center;">
				<div class="tableSize" style="text-align:center;">
					<h1>학생 취업율 수치</h1>
					<table class="table align-items-center" style="text-align: center; margin-top: 39px;">
						<thead class="list">
							<c:forEach var="sbe" items="${studentByEmpTable}">
				                <tr>
				                    <td><c:out value="${sbe.EMP_NAME}"/></td>
				                    <td><c:out value="${sbe.EMP_RATE}"/>%</td>
				                </tr>
				            </c:forEach>
						</thead>
					</table>
				</div>
			</div>
		</div>
		<div class="col-1"></div>
	</div>
</div>
<div style="border: 1px solid #c1c0c073;"></div>
<div style="text-align:center; margin:10px 0px 10px 0px;">
	<h1 style="margin-top:50px;">학생 리스트</h1>
</div>
<div class="coma-container" style="margin-top:5px; margin-bottom: 5px;">
	<div class="row" style="display: flex; align-items: center;">
		<div class="col-1"></div>
		<div class="col-1.5" style="padding-left:0px; ">
			<input class="form-control form-control-sm" type="text" id="textData" placeholder="이름으로 검색">
		</div>
		<div class="col-9.5" style="padding-left:0px;">
			<button type="button" class="btn btn-secondary btn-sm" onclick="fn_searchStudent();">검색</button>
		</div>
	</div>
	<div class="table-responsive" style="padding: 0px 115px 0px 115px;">
		<div>
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
		        		<td><a href="#"><c:out value="${s.STU_NAME }"/></a></td>
		        		<td><c:out value="${s.EMP_NAME }"/></td>
		        		<td><c:out value="${s.STU_COM_STATUS }"/></td>
		        		<td><c:out value="${s.STU_EMP_STATUS }"/></td>
		        	</tr>
		        </c:forEach>
		        </tbody>
		    </table>
		    <div id="pageBar">${pageBar}</div>
		</div>
	</div>
</div>
<script>
//chart.js 
//학생 근태 차트 데이터
const satd=${studentAttence}	//응답받은 차트데이터 변수에 저장
const sado=JSON.stringify(satd);	//JSON형식으로 데이터 형변환
const satdoc=JSON.parse(sado);	//JSON 형식의 문자열을 다시 JavaScript 객체로 변환

//JSON형식으로 변환한 값을 저장하기 배열 생성
var labelList = new Array();
var valueList = new Array();
var colorList = new Array();

//차트 색상 랜덤 설정
function colorize() {
	var r = Math.floor(Math.random()*200);
	var g = Math.floor(Math.random()*200);
	var b = Math.floor(Math.random()*200);
	var color = 'rgba(' + r + ', ' + g + ', ' + b + ', 0.2)';
	return color;
}

//JSON형식으로 변환한 chartEmpData 데이터 값만큼 반복문 실행하면 배열 변수에 각각의 값을 대입 
for(let i=0;i<satdoc.length;i++){
	let e=satdoc[i];
	labelList.push(e.EMP_NAME);
	valueList.push(e.ATTENCE_RATE);
	colorList.push(colorize());
}

const ctx = document.getElementById('stuCurentChart').getContext('2d');
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
					suggestedMax: 100,
					beginAtZero : true,
				}
			} ]
        }
    }
});

//학생 수료율 차트 데이터
const sbc=${studentByCom}
const sbco=JSON.stringify(sbc);
const sbcoc=JSON.parse(sbco);

//JSON형식으로 변환한 값을 저장하기 배열 생성
var labelList3 = new Array();
var valueList3 = new Array();
var colorList3 = new Array();

//차트 색상 랜덤 설정
function colorize() {
	var r = Math.floor(Math.random()*200);
	var g = Math.floor(Math.random()*200);
	var b = Math.floor(Math.random()*200);
	var color = 'rgba(' + r + ', ' + g + ', ' + b + ', 0.2)';
	return color;
}

for(let i=0;i<sbcoc.length;i++){
	let e=sbcoc[i];
	labelList3.push(e.EMP_NAME);
	valueList3.push(e.COM_RATE);
	colorList3.push(colorize());
}
const ctx2 = document.getElementById('stuComChart').getContext('2d');
const myChart2 = new Chart(ctx2, {
    type: 'bar',
    data: {
        labels: labelList3,
        datasets: [{
            label: '학생 수료율',
            data: valueList3,
            backgroundColor: colorList3
        }]
    },
    options: {
        scales: {
        	yAxes : [ {
				ticks : {
					suggestedMax: 100,
					beginAtZero : true,
				}
			} ]
        }
    }
});
//학생 취업율 차트 데이터
const sbe=${studentByEmp}
const sbeo=JSON.stringify(sbe);
const sbeoc=JSON.parse(sbeo);

var labelList4 = new Array();
var valueList4 = new Array();
var colorList4 = new Array();

for(let i=0;i<sbeoc.length;i++){
	let e=sbeoc[i];
	labelList4.push(e.EMP_NAME);
	valueList4.push(e.EMP_RATE);
	colorList4.push(colorize());
}
const ctx3 = document.getElementById('stuEmpChart').getContext('2d');
const myChart3 = new Chart(ctx3, {
    type: 'bar',
    data: {
        labels: labelList4,
        datasets: [{
            label: '학생 취업율',
            data: valueList4,
            backgroundColor: colorList4
        }]
    },
    options: {
        scales: {
        	yAxes : [ {
				ticks : {
					suggestedMax: 100,
					beginAtZero : true,
				}
			} ]
        }
    }
});


//학생 검색 기능
function fn_searchStudent(cPage=1,numPerpage=10,url){
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
			$a.innerText=e.STU_NAME;
			$td1.appendChild($a);
			const $td2=document.createElement('td');
			$td2.innerText=e.EMP_NAME;
			const $td3=document.createElement('td');
			$td3.innerText=e.STU_COM_STATUS;
			const $td4=document.createElement('td');
			$td4.innerText=e.STU_EMP_STATUS;
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
</script>
<!-- TEAM COMA SPACE -->
<jsp:include page="/WEB-INF/views/common/footer.jsp"/>