<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<jsp:include page="/WEB-INF/views/common/header.jsp">
	<jsp:param name="id" value="mine" />
</jsp:include>
<!-- 
<link href="/resource/css/approval/writedoc.css" rel="stylesheet" />
<script src="/resource/js/approval/approval.js"></script> -->
<!-- 에디터 -->
<script src="https://uicdn.toast.com/editor/latest/toastui-editor-all.min.js"></script>
  <!-- Editor's Style -->
  <link rel="stylesheet" href="https://uicdn.toast.com/editor/latest/toastui-editor.min.css" />

<link href="/resource/css/approval/writedoc.css" rel="stylesheet" />

    <!-- TEAM COMA SPACE -->

    <div class="coma-container" style="margin-top:5px; margin-bottom: 5px;">
        <div class="container" style="text-align: center; margin-top:5px; margin-bottom: 5px;">
          <!-- coma content space -->
          
          <div class="doc_basic">
			  <div class="row">
			  	<div class="col-12 line1">
			  		작성자
			  	</div>
			  	
			  </div>      
	          
	          <div class="row">
	       
		            <div class="col-12">
		            	 <select class="form-control form-control-sm" onchange="docType(this.value);">
						  <option value="" selected disabled hidden>선택하세요</option>
						  <option value="leave">휴가신청서</option>
						  <option value="cash">지출결의서</option>
						  <option value="req">품의서</option>
						  <option value="etc">기타</option>
						</select> 
					
		            </div>
		            <div class="col"></div>
		      </div>    
	          <div class="row line3">
	
	          </div> 
	          <div class="row">
	            <div class="col-3">
	            </div>
	            <div class="col-6">
	            	<input class="form-control" type="text" placeholder="제목">
	            </div>
	            <div class="col-3">
	            	2023-12-27
	            </div>
	          </div>
          </div>
          <div class="row">
            <div class="col-3">
            	<button type="button" class="btn btn-secondary btn-lg">결재선 설정</button>
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
          <!-- 토스트 에디터 -->
          <div class="row">
            <div class="col-12">
             	  <div id="content"></div>
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
		       <div class="row">
				<!-- 휴가 신청 날짜 선택 -->
					<div class="input-daterange datepicker row align-items-center">
						    <div class="col">
						        <div class="form-group">
						            <div class="input-group">
						                <div class="input-group-prepend">
						                    <span class="input-group-text"><i class="ni ni-calendar-grid-58"></i></span>
						                </div>
						                <input class="form-control" placeholder="Start date" type="text" value="06/18/2020">
						            </div>
						        </div>
						    </div>
						    <div class="col">
						        <div class="form-group">
						            <div class="input-group">
						                <div class="input-group-prepend">
						                    <span class="input-group-text"><i class="ni ni-calendar-grid-58"></i></span>
						                </div>
						                <input class="form-control" placeholder="End date" type="text" value="06/22/2020">
						            </div>
						        </div>
						    </div>
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
  

<script src="/resource/js/approval/approval.js"></script> 

<jsp:include page="/WEB-INF/views/common/footer.jsp"/>


