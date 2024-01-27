<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<jsp:include page="/WEB-INF/views/common/header.jsp">
	<jsp:param name="id" value="mine" />
</jsp:include>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<c:set var="path" value="${pageContext.request.contextPath }" />

<script src="https://uicdn.toast.com/editor/latest/toastui-editor-all.min.js"></script>
  <!-- Editor's Style -->
  <link rel="stylesheet" href="https://uicdn.toast.com/editor/latest/toastui-editor.min.css" />
<script src="${path }/resource/js/jquery-3.7.0.js"></script>
<link href="${path }/resource/css/approval/writedoc.css" rel="stylesheet" />
<script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script> <!-- sweetAlert -->


<c:set var="loginMember" value="${sessionScope.SPRING_SECURITY_CONTEXT.authentication.principal }"/> 
	
	<!-- path.. -->
	<input type="hidden" id="pathValue" value="${pageContext.request.contextPath}"/> 


    <!-- TEAM COMA SPACE -->
	<form action="${pageContext.request.contextPath }/approval/insertdoc" method="post"
					enctype="multipart/form-data" id="app_form">
					
	<input type="hidden" name="empId" value="${loginMember.empId }">
	
	
    <div class="coma-container" style="margin-top:5px; margin-bottom: 5px;">
        <div class="container" style="text-align: center; margin-top:5px; margin-bottom: 5px;">
          <!-- coma content space -->
   
<!----------------------- 공통사항 ----------------------->          
          <div class="doc_basic">
    		<input type="hidden" name="loginMember" value="${loginMember }">
	  
	          
	          <div class="row">
	       			<div class="col-3 type_lable">
	       				문서 종류
	       			</div>
		            <div class="col-7">
		            	 <select required class="form-control form-control-sm" onchange="fn_docType(this.value);">
							  <option value="" selected disabled hidden>문서 종류를 선택하세요.</option>
							  <option value="leave">휴가신청서</option>
							  <option value="cash">지출결의서</option>
							  <option value="req">품의서</option>
							  <option value="etc">기타</option>
						</select> 
						<input type="hidden" id="docType" name="docType">
		            </div>
		            <div class="col-2">
		            </div>

		     </div>    

	         <div class="row">
	            <div class="col-3 write_lable">
	            	문서 제목
	            </div>
	            <div class="col-7">
	            	<input class="form-control" id="ck_title" type="text" placeholder="제목" name="title">
	            </div>  
	            <div class="col-2"></div>
	         </div>
          </div><!-- doc_basic -->
          
          
<!----------------------- 결재선 설정 ------------------------->        
	<hr>  
      <div class="app_line">
	     
        </div>
     
  		<div class="row" >
  			<div class="col-3">
  			</div>
        	<div class="col-3 remake">
        		<!-- 모달창 코드는 맨 밑에 -->
        		<button type="button" id="take_btn" onclick="take_line();" class="btn btn-block btn-primary mb-3" data-toggle="modal" data-target="#modal-default">결재선 불러오기</button>	 
        		<button type="button" onclick="fn_reset();" id="reset_btn" style="display:none" class="btn btn-block btn-outline-danger mb-3">리셋</button>
        	</div>
       
        	<div class="col-3">
        		<button class="btn btn-block btn-primary mb-3" id="save_btn" onclick="save_appr();" type="button">결재선 저장</button>
        	</div>
        
        	<div class="col-3">
        	</div>
        </div>

        <div class="row add_appr" >
	   		<div class="col-3 write_lable">
	   			결재자
	   		</div>
   		
         	<div class="col-7">
           		 <div class="input-group mb-3">	  
					  <input required type="text" list="search_list1" id="search_app" class="form-control" 
					   placeholder="이름을 입력하세요." aria-label="Example text with button addon" 
					   aria-describedby="button-addon1" autocomplete="off">
					 		<datalist id="search_list1">
					 		</datalist> 	 		
					  <div class="input-group-prepend">
					   		<button class="btn btn-outline-primary app_btn" type="button" id="button-addon1" 
					   		onclick="addAppr();">추가하기</button>	  
					  </div>
				</div>
         	</div>
         	<div class="col-2">
       	    </div>
        </div> 	


        <div class="row ck_appr">
        	<div class="col-3">
        	</div>
        	<div class="col-7 appr_container">
        		
        	</div>	
        	
        	<input type="hidden" name="appr_result[]" class="appr_result" id="ck_appr">
       		<input type="hidden" name="appr_result[]" class="appr_result">
       		<input type="hidden" name="appr_result[]" class="appr_result">
       	
        	<div class="col-2">
				
        	</div>
        	
        </div>
        
        <div class="row save_appr" style="display:none">
        	<div class="col-3">
        		결재선 이름
        	</div>
        	<div class="col-7">

        	<div class="input-group mb-3">
			  <input type="text" class="form-control" placeholder="ex) 휴가 신청 결재선" aria-describedby="button-addon2">
			  <div class="input-group-append">
			    <button class="btn btn-outline-primary" onclick="line_submit();" type="button" id="button-addon2">저장하기</button>
			  </div>
			</div>

        		
        	</div>
        	<div class="col-2">
        		<button class="btn btn-primary" onclick="cancel_appr();" type="button">취소</button>
        	</div>
        	
        	
        </div>
        
         <div class="row">
 			<div class="col-3 write_lable">
 				참조자
     		</div>
	        <div class="col-7">
           		<div class="input-group mb-3">	  
					   <input type="text" list="search_list2" id="search_ref" class="form-control" 
					   placeholder="이름을 입력하세요." aria-label="Example text with button addon" 
					   aria-describedby="button-addon1">
					 		<datalist id="search_list2">
					 		</datalist> 	 	
					  <div class="input-group-prepend">
					    <button class="btn btn-outline-primary ref_btn" type="button" id="button-addon1"
					    onclick="addref();">추가하기</button>
					  </div>
				</div>

            </div>
	   		<div class="col-2">
	   		</div>
	   	</div>
	   	<div class="row ck_appr">
          	<div class="col-3">
          	</div>
          	<div class="col-7 ref_container">
				<input type="hidden" name="ref_result[]" class="ref_result">
          		<input type="hidden" name="ref_result[]" class="ref_result">
          		<input type="hidden" name="ref_result[]" class="ref_result">
          	</div>
          	<div class="col-2">
          	</div>
        </div> 

<!------------------------- 문서별 입력 내용 -------------------------->

    <!-------------- 휴가신청서 --------------->   
          <div id="leave" style="display:none;">
       		<hr>		
       		<h2>휴가 신청서</h2>
	          <div class="row">
	          		<div class="col-3 write_lable">
	          			휴가 종류
	          		</div>
		          	<div class="col-7">
		          		<select class="form-control form-control-sm" onchange="fn_leaveType(this.value)";>
		          		  <option value="" selected disabled hidden>휴가 종류를 선택하세요.</option>
						  <option>연차</option>
						  <option>반차(오전)</option>
						  <option>반차(오후)</option>
						</select>
		          		<input type="hidden" name="leaveType" id="leaveType">
		          	</div>
		          	
		          	<div class="col-2">
		          	</div>
		  
	          </div>  
		      <div class="row">
				<!-- 휴가 신청 날짜 선택 -->
					<div class="col-3 write_lable">
	          			휴가 날짜
	          		</div>
					<div class="col-7">
						<div class="input-daterange datepicker row align-items-center date_bo">
							    <div class="col start_bo">
							        <div class="form-group">
							            <div class="input-group">
							                <div class="input-group-prepend">
							                    <span class="input-group-text"><i class="ni ni-calendar-grid-58"></i></span>
							                </div>
							                <input class="form-control" name="leaveStart" placeholder="시작 날짜" type="text" >
							            </div>
							        </div>
							    </div>
						    <div class="col end_bo">
						        <div class="form-group">
						            <div class="input-group">
						                <div class="input-group-prepend">
						                    <span class="input-group-text"><i class="ni ni-calendar-grid-58"></i></span>
						                </div>
						                <input class="form-control" name="leaveEnd" placeholder="끝 날짜" type="text" >
						            </div>
						        </div>
						    </div>
						    
						</div>   
					</div>
		     		<div class="col-2"></div>
			    </div>  

	      </div>

    <!--------------- 지출결의서 ----------------->   		        
          <div id="cash" style="display:none;">  
          <hr>    
          	<h2>지출결의서</h2>
	          <div class="row">
		          	<div class="col-3 write_lable">
		          		비용
		          	</div>
		          	<div class="col-7">
		          		<div class="form-group">
						    <div class="input-group">
						      <div class="input-group-prepend">
						        <span class="input-group-text">￦</span>
						      </div>
						      <input type="text" name="expense" class="form-control" aria-label="Amount (to the nearest dollar)">
						      <div class="input-group-append">
						        <span class="input-group-text">.00</span>
						      </div>
						    </div>
						</div>
		          	</div>
		          	<div class="col-2"></div>
	          </div> 
	          <div class="row">
	          	<div class="col-3 write_lable">
	          		지출 날짜
	          	</div>
	          	<div class="col-7">
          		   <div class="form-group date_bo">
					   <div class="input-group">
					        <div class="input-group-prepend">
					            <span class="input-group-text"><i class="ni ni-calendar-grid-58"></i></span>
					        </div>
					        <input name="cashDate" class="form-control datepicker" placeholder="날짜를 선택하세요." type="text" >
					    </div>
					</div>
	          	</div>
	          	<div class="col-2"></div>
	          </div>
           </div>
    <!------------ 품의서 ------------>              
          <div id="req" style="display:none;">
          <hr>
          	<h2>품의서</h2>
	          <div class="row">
	          	<div class="col-3 write_lable">
	          		기안 날짜
	          	</div>
	          	<div class="col-7">
          		    <div class="form-group date_bo">
					   <div class="input-group">
					        <div class="input-group-prepend">
					            <span class="input-group-text"><i class="ni ni-calendar-grid-58"></i></span>
					        </div>
					        <input name="reqDate" class="form-control datepicker" placeholder="날짜를 선택하세요." type="text">
					    </div>
					</div>
	          	</div>
	          	<div class="col-2"></div>
	          </div>
          </div>
         
    <!------------ 기타 문서 ------------>             
          <div id="etc" style="display:none;">
          <hr>
          		<h2>기타 문서</h2>
           <div class="row">
          	<div class="col-3 write_lable">
          		기안 날짜
          	</div>
          	<div class="col-7">
         		    <div class="form-group date_bo">
				   <div class="input-group">
				        <div class="input-group-prepend">
				            <span class="input-group-text"><i class="ni ni-calendar-grid-58"></i></span>
				        </div>
				        <input name="etcDate" class="form-control datepicker" placeholder="날짜를 선택하세요." type="text">
				    </div>
				</div>
          	</div>
          	<div class="col-2"></div>
          </div>
	    
	     </div>
          
              
<!--------------------- 토스트 에디터 ----------------------->
    <div class="row">
      <div class="col-12">
       	  <div id="content" style="position: relative; z-index:-999;" name="content"></div>
      </div>
    </div>      
    
    <input type=hidden name="editorContent" id="editorContent">
<!------------------------ 첨부파일 ------------------------->
	<div class="row">
		<div class="col-12">
			<button type="button" class="btn btn-outline-primary" onclick="fn_addFileForm();">파일 추가</button>
			<button type="button" class="btn btn-outline-danger" onclick="fn_deleteFileForm();">파일 삭제</button>
		</div>
	</div>
    	
   	<div class="row" id="basicFileForm" >
   		<div class="col-3">
   			<span class="file_span">첨부파일 1</span>
   		</div>
		<div class="col-7">
			    <div class="custom-file">
			        <input type="file" name="upFile" class="custom-file-input" id="customFileLang" lang="en">
			        <label class="custom-file-label" for="customFileLang"></label>
			    </div>
		</div>
		<div class="col-2"></div>
		
	</div>    
	 
<!----------------------- 작성 완료 버튼 ----------------------->          
    <div class="row btn_container">
    	<div class="col-11"></div>
    	<div class="col-1">
    			<input type="button" onclick="submitForm()" class="btn btn-primary btn-lg" value="작성완료">
    			<!--제출 전 에디터 값 넘기기 위해 type="button"으로 줌 -->
    	</div>
    </div>      
    	
    	
       
      <!----------------------- 결재선 불러오기 모달 창 ----------------------->
  
    <div class="row">
	  <div class="col-md-4">
	     
	      <div class="modal fade" id="modal-default" tabindex="-1" role="dialog" aria-labelledby="modal-default" aria-hidden="true">
		    <div class="modal-dialog modal- modal-dialog-centered modal-" role="document">
		       	 <div class="modal-content">
			        	
			            <div class="modal-header">
				                <h6 class="modal-title" id="modal-title-default">결재선 이름</h6>
				                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
				                    <span aria-hidden="true">×</span>
				                </button>
			            </div>
			            
		           		<div class="modal-body" id="take_line"> <!-- radio 출력 div -->
		               
		           		</div>
			            
			            <div class="modal-footer">
			                <button type="button" class="btn btn-danger" onclick="del_line();">초기화</button>
			                <button type="button" onclick="line_end();" class="btn btn-primary ml-auto">확인</button>
			            </div>
			            
			        </div>
			    </div>
			</div>
	    </div>
	</div>	

    <!--  --> 	
  
          <!-- coma content space -->
        </div>
    </div>

</form>   

    
    <!-- TEAM COMA SPACE -->
    </div>
  </div>
  
<script>
	const path = '${path}';
</script>
 <script src="${path }/resource/js/approval/approval.js"></script> 

<jsp:include page="/WEB-INF/views/common/footer.jsp"/>


	          