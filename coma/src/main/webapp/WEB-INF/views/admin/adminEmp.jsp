<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<jsp:include page="/WEB-INF/views/common/header.jsp">
	<jsp:param name="id" value="mine" />
</jsp:include>
<script type="text/javascript" src="https://www.gstatic.com/charts/loader.js"></script>
<style>
/*     div{
      border: 2px solid red;
    } */
</style>
<!-- TEAM COMA SPACE -->
<div class="coma-container" style="margin-top:5px; margin-bottom: 5px;">
	<div style="text-align:center;">
		<h1>사원 관리 페이지</h1>
	</div>
	<div class="row">
		<div class="col-12">
			<div class="row">
				<div class="col-1"></div>
				<div id="chart_div" class="col-10"></div>
				<div class="col-1"></div>
			</div>
		</div>
	</div>
	<div style="text-align:center; margin:10px 0px 10px 0px;">
		<h1>부서별 사원 명수</h1>
	</div>
	<div class="row" style="margin-top:10px; margin-bottom: 10px; display: flex; justify-content: space-around;">
		<div class="col-1"></div>
		<div class="col-2.5">
			<div class="form-group">
			    <div class="input-group">
			      <div class="input-group-prepend">
			        <span class="input-group-text" id="inputGroup-sizing-default">촣 사원</span>
			      </div>
			      <input type="text" style="background-color: #ffffff;" class="form-control" aria-label="Sizing example input" aria-describedby="inputGroup-sizing-default" readonly>
			    </div>
			</div>
		</div>
		
		<div class="col-2.5">
			<div class="form-group">
			    <div class="input-group">
			      <div class="input-group-prepend">
			        <span class="input-group-text" id="inputGroup-sizing-default">행정팀</span>
			      </div>
			      <input type="text" style="background-color: #ffffff;" class="form-control" aria-label="Sizing example input" aria-describedby="inputGroup-sizing-default" readonly>
			    </div>
			</div>
		</div>
		<div class="col-2.5">
			<div class="form-group">
			    <div class="input-group">
			      <div class="input-group-prepend">
			        <span class="input-group-text" id="inputGroup-sizing-default">교육팀</span>
			      </div>
			      <input type="text" style="background-color: #ffffff;" class="form-control" aria-label="Sizing example input" aria-describedby="inputGroup-sizing-default" readonly>
			    </div>
			</div>
		</div>
		<div class="col-2.5">
			<div class="form-group">
			    <div class="input-group">
			      <div class="input-group-prepend">
			        <span class="input-group-text" id="inputGroup-sizing-default">회계팀</span>
			      </div>
			      <input type="text" style="background-color: #ffffff;" class="form-control" aria-label="Sizing example input" aria-describedby="inputGroup-sizing-default" readonly>
			    </div>
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
			<select class="form-control form-control-sm" name="selectEmp">
			  <option value="empName">이름</option>
			  <option value="deptCode">부서</option>
			  <option value="jobCode">직책</option>
			</select>
		</div>
		<div class="col-2" style="padding-left:0px;">
			<input class="form-control form-control-sm" type="text" placeholder="검색바">
		</div>
		<div class="col-5" style="padding-left:0px;">
			<button type="button" class="btn btn-secondary btn-sm">검색</button>
		</div>
		<div class="col-2">
			<div class="row">
				<div class="col-8" style="padding-right:0px;">
					<form>
					<input class="form-control form-control-sm" type="text" placeholder="추가할 사원 이름" required>
				</div>
				<div class="col-2">
					<button type=submit class="btn btn-primary btn-sm">
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
		        <tbody class="list">
		        	<tr>
		        		<td>아이디</td>
		        		<td><a href="#">이름</a></td>
		        		<td>부서</td>
		        		<td>직책</td>
		        		<td><a href="#">근무상태</a></td>
		        		<td>
			        		<button type="button" class="btn btn-secondary btn-sm">삭제</button>
		        		</td>
		        	</tr>
		        </tbody>
		    </table>
		</div>
	</div>
</div>
<script>
google.charts.load('current', {'packages':['bar']});
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
}
</script>
<!-- TEAM COMA SPACE -->
<jsp:include page="/WEB-INF/views/common/footer.jsp"/>