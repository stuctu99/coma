<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<jsp:include page="/WEB-INF/views/common/header.jsp">
	<jsp:param name="id" value="mine" />
</jsp:include>
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
				  <option value="휴가신청서">휴가신청서</option>
				  <option value="지출결의서">지출결의서</option>
				  <option value="품의서">품의서</option>
				  <option value="기타">기타</option>
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
           
              </table>
            </div>
    	
          </div>
          <div class="row">
            <div class="col-12">
              <table class="ref_table">
              	<tr>
              		<th>
              			참조자
              		</th>
              		<td>
              			이보연
              		</td>
              		<td>
              			윤영찬
              		</td>
              		<td>
              			이규홍
              		</td>
              		<td>
              			유병승
              		</td>
              	</tr>
              </table>
            </div>
          </div>
          <div class="row">
            <div class="col-12">
             	<hr>
            </div>
          </div>
          
          <div id="휴가신청서" style="display:none;">
	          <div class="row">
		          	<div class="col-3">
		          		<h2>휴가종류</h2>
		          	</div>
		          	<div class="col-3">
		          		<select class="form-control form-control-sm">
						  <option>연차</option>
						  <option>반차</option>
						</select>
		          	</div>
		          	<div class="col-3">
		          	</div>
		          	<div class="col-3">
		          	</div>
	          </div>
	      </div>
	        
          <div id="지출결의서" style="display:none;">      
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
          <div id="품의서" style="display:none;">
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
          
          <div id="기타" style="display:none;">
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
  		
  		console.log("테스트: " + value);
  		
  		document.getElementById("휴가신청서").style.display= "none";
  		document.getElementById("지출결의서").style.display= "none";
  		document.getElementById("품의서").style.display= "none";
  		document.getElementById("기타").style.display= "none";
  		
  		document.getElementById(value).style.display="block";
  	}
  
  </script>
  
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
  </style>
<jsp:include page="/WEB-INF/views/common/footer.jsp"/>