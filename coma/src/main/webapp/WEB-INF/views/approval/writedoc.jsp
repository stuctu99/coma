<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<jsp:include page="/WEB-INF/views/common/header.jsp">
	<jsp:param name="id" value="mine" />
</jsp:include>
<link href="/resource/css/approval/writedoc.css" rel="stylesheet" />
    <!-- TEAM COMA SPACE -->
    <div class="coma-container" style="margin-top:5px; margin-bottom: 5px;">
        <div class="container" style="text-align: center; margin-top:5px; margin-bottom: 5px;">
          <!-- coma content space -->
          <div class="row">
            <div class="col-3">
              <h3>문서 종류</h3>
            </div>
            <div class="col-3">
            	<select class="form-control form-control-sm" onchange="docType(this.value);">
				  <option value="" selected disabled hidden>선택하세요</option>
				  <option value="leave">휴가신청서</option>
				  <option value="cash">지출결의서</option>
				  <option value="req">품의서</option>
				  <option value="etc">기타</option>
				</select>
            </div>
            <div class="col-3">
              <h1>작성자</h1>
            </div>
            <div class="col-3">
             	<h2>보여닝</h2>
            </div>
           </div> 
          <div class="row">
            <div class="col-3">
            </div>
            <div class="col-6">
            	<h1><input class="form-control" type="text" placeholder="제목"></h1>
            </div>
            <div class="col-3">
            	<h2>2023-12-27</h2>
            </div>
          </div>
          <div class="row">
            <div class="col-3">
              <h2>결재선 설정</h2>
            </div>
            <div class="col-3">
            </div>
            <div class="col-3">
            </div>
            <div class="col-3">
            </div>
          </div>
          <div class="row">
            <div class="col-12">
              <table class="appr_table">
              	<tr>
              		<td>
              			
              		</td>
              		<td>
              			직책
              		</td>
              		<td>
              			직책
              		</td>
              		<td>
              			직책
              		</td>
              		<td>
              			직책
              		</td>
              	</tr>
              	<tr>
              		<td>
              			<h1>결</h1>
              			<h1>재</h1>
              		</td>
              		<td>
              			<h1>서</h1>
              			<h1>명</h1>
              		</td>
              		<td >
              			<h1>서</h1>
              			<h1>명</h1>
              		</td>
              		<td >
              			<h1>서</h1>
              			<h1>명</h1>
              		</td>
              		<td >
              			<h1>서</h1>
              			<h1>명</h1>
              		</td>
              	</tr>
            
              	<tr>
              		<td>
              			
              		</td>
              		<td>
              			이름
              		</td>
              		<td>
              			이름
              		</td>
              		<td>
              			이름
              		</td>
              		<td>
              			이름
              		</td>
              	</tr>
           		<tr>
           			<th style="width:120px" >참조자</th>
           			<td colspan="4">이보연</td>
           		</tr>
              </table>
            </div>
    	
          </div>
          <div class="row">
            <div class="col-12">
            </div>
          </div>
          <div class="row">
            <div class="col-12">
             	<hr>
            </div>
          </div>
          
          <div id="leave" style="display:none;">
	          <div class="row">
		          	<div class="col-3">
		          		<h2>휴가종류</h2>
		          	</div>
		          	<div class="col-3">
		          		<select class="form-control form-control-sm" onchange="leave_type(this.value)">
						  <option>연차</option>
						  <option>반차</option>
						</select>
		          	</div>
		          	<div class="col-3">
		          	</div>
		          	<div class="col-3">
		          	</div>
	          </div>
	          <div id="half_leave">
		          <div class="row">
		          	<ul class="nav nav-pills nav-fill flex-column flex-sm-row" id="tabs-text" role="tablist">
					  <li class="nav-item">
					    <a class="nav-link mb-sm-3 mb-md-0 active" id="tabs-text-1-tab" data-toggle="tab" href="#tabs-text-1" role="tab" aria-controls="tabs-text-1" aria-selected="true">오전</a>
					  </li>
					  <li class="nav-item">
					    <a class="nav-link mb-sm-3 mb-md-0" id="tabs-text-2-tab" data-toggle="tab" href="#tabs-text-2" role="tab" aria-controls="tabs-text-2" aria-selected="false">오후</a>
					  </li>
					</ul>
		          </div>
		       </div>
	      </div>
	        
          <div id="cash" style="display:none;">      
	          <div class="row">
		          	<div class="col-3">
		          		<h2>지출결의서</h2>
		          	</div>
		          	<div class="col-3">
		          	</div>
		          	<div class="col-3">
		          	</div>
		          	<div class="col-3">
		          	</div>
	          </div> 
           </div>
          <div id="req" style="display:none;">
	          <div class="row">
		          	<div class="col-3">
		          		<h2>품의서</h2>
		          	</div>
		          	<div class="col-3">	
		          	</div>
		          	<div class="col-3">
		          	</div>
		          	<div class="col-3">
		          	</div>
	          </div>
          </div>
          
          <div id="etc" style="display:none;">
	           <div class="row">
		          	<div class="col-3">
		          		<h2>기타 문서</h2>
		          	</div>
		          	<div class="col-3">
		          	</div>
		          	<div class="col-3">
		          	</div>
		          	<div class="col-3">
		          	</div>
	          </div>
	     </div>
          
          <!-- coma content space -->
        </div>
    </div>
    <!-- TEAM COMA SPACE -->
    </div>
  </div>
  
  
  <script>
  	const docType = function(value){
  		
  		document.getElementById("leave").style.display= "none";
  		document.getElementById("cash").style.display= "none";
  		document.getElementById("req").style.display= "none";
  		document.getElementById("etc").style.display= "none";
  	
  		document.getElementById(value).style.display="block";
  	}
  
  	
  	const leave_type = function(value){
  		
  		document.getElementById("half_leave").style.display="none";
  		
  		document.getElementById(value).style.display="block";
  	}
  	
  </script>
<!--   
  <style>
  	 .appr_table{
    width: 700px;
    height: 150px;
    border: 1px solid #444444;
    
  }
  .ref_table{
  	width: 700px;
  	height: 30px;
  	  border: 1px solid #444444;
  }
  th, td, th {
    border: 1px solid #444444;
  }
  .nav-item{
  	margin: 5px;
  }
  </style> -->
<jsp:include page="/WEB-INF/views/common/footer.jsp"/>