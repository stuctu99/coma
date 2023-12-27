<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<jsp:include page="/WEB-INF/views/common/header.jsp">
	<jsp:param name="id" value="mine" />
</jsp:include>
<script type="text/javascript" src="https://www.gstatic.com/charts/loader.js"></script>
<style>
</style>
<!-- TEAM COMA SPACE -->
<div class="coma-container" style="margin-top:5px; margin-bottom: 5px;">
	<div class="row">
		<div class="col-6">
			<div>
				<div id="chart_div"></div>
			    <br/>
			    <div id="btn-group">
			      <button class="button button-blue" id="none">No Format</button>
			      <button class="button button-blue" id="scientific">Scientific Notation</button>
			      <button class="button button-blue" id="decimal">Decimal</button>
			      <button class="button button-blue" id="short">Short</button>
			    </div>
			</div>
		</div>
		<div class="col-6">
			<div class="row">
				<div class="col-2.5" style="display: flex; align-items: center;">
					<div>
						<i class="ni ni-circle-08">총 사원 수 : </i>
					</div>
				</div>
				<div>
					<input type="text" class="form-control" placeholder="Default input">
				</div>
			</div>
			<div class="row">
				<div class="col-2.5" style="display: flex; align-items: center;">
					<div>
						<i class="ni ni-circle-08">행정팀 사원 수 : </i>
					</div>
				</div>
				<div>
					<input type="text" class="form-control" placeholder="Default input">
				</div>
			</div>
			<div class="row">
				<div class="col-2.5" style="display: flex; align-items: center;">
					<div>
						<i class="ni ni-circle-08">교육팀 사원 수 : </i>
					</div>
				</div>
				<div>
					<input type="text" class="form-control" placeholder="Default input">
				</div>
			</div>
			<div class="row">
				<div class="col-2.5" style="display: flex; align-items: center;">
					<div>
						<i class="ni ni-circle-08">회계팀 사원 수 : </i>
					</div>
				</div>
				<div>
					<input type="text" class="form-control" placeholder="Default input">
				</div>
			</div>
		</div>
	</div>
</div>
<div class="coma-container" style="margin-top:5px; margin-bottom: 5px;">
	<div class="row">
		<div style="display: flex; align-items: center;">
			<i class="ni ni-circle-08">
				<select>
					<option>이름</option>
					<option>부서</option>
				</select>
			</i>
		</div>
		<div>
			<input type="text" class="form-control" placeholder="검색바">
		</div>
		<div>
			<button type="button" class="btn btn-outline-default">검색</button>
		</div>
	</div>
	<div class="table-responsive">
	<div>
    <table class="table align-items-center">
        <thead class="thead-light">
            <tr>
                <th scope="col" class="sort" data-sort="name">Project</th>
                <th scope="col" class="sort" data-sort="budget">Budget</th>
                <th scope="col" class="sort" data-sort="status">Status</th>
                <th scope="col">Users</th>
                <th scope="col" class="sort" data-sort="completion">Mergi</th>
                <th scope="col">Delete</th>
            </tr>
        </thead>
        <tbody class="list">
        	<tr>
        		<td>아이디</td>
        		<td>이름</td>
        		<td>부서</td>
        		<td>직책</td>
        		<td><button type="button" class="btn btn-primary btn-sm">수정</button></td>
        		<td><button type="button" class="btn btn-secondary btn-sm">삭제</button></td>
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
    ['Year', 'Sales', 'Expenses', 'Profit','bslove','bslove2','bslove3'],
    ['2014', 1000, 400, 200, 500, 500, 500],
    ['2015', 1170, 460, 250, 500, 500, 500],
    ['2016', 660, 1120, 300, 500, 500, 500],
    ['2017', 1030, 540, 350, 500, 500, 500]
  ]);

  var options = {
    chart: {
      title: 'Company Performance',
      subtitle: 'Sales, Expenses, and Profit: 2014-2017',
    },
    bars: 'horizontal', // Required for Material Bar Charts.
    hAxis: {format: 'decimal'},
    height: 400,
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