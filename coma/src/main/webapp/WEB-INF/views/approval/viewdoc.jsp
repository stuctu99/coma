<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<jsp:include page="/WEB-INF/views/common/header.jsp">
	<jsp:param name="id" value="mine" />
</jsp:include>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<script src="https://uicdn.toast.com/editor/latest/toastui-editor-all.min.js"></script>

<link href="/resource/css/approval/viewdoc.css" rel="stylesheet" />
    <!-- TEAM COMA SPACE -->

    <div class="coma-container" style="margin-top:5px; margin-bottom: 5px;">
        <div class="container" style="text-align: center; margin-top:5px; margin-bottom: 5px;">
          <!-- coma content space -->
          
          <div class="doc_basic">
          	   <div class="row">
          	   		<div class="col-10">
          	   		</div>
          	   		<div class="col-2">
          	   			<input type="button" onclick="downloadPdf();" class="btn btn-primary btn-lg" value="pdf 받기">
          	   		</div>
          	   </div>
			
			 
			  <div class="row">
			  		<div class="col-12">
			  			<table class="table table-bordered">
						  
						  <tbody>
						    <tr>
						      <th scope="row" class="mylabel">문서 종류</th>
						      <td>${typeKor }</td>
						      <th scope="row" class="mylabel">작성일</td>
						      <td>${onlyDate }</td>
						    </tr>
						    <tr>
						      <th scope="row" class="mylabel">기안자</th>
						      <td>${writer.empName }</td>
						      <th scope="row" class="mylabel">부서</th>
						      <td>${writer.dept.deptType } </td>
						    </tr>
						    <tr>
						      <th scope="row" class="mylabel mytitle">제목</th>
						      <td colspan="3">${doc.docTitle }</td>
						    
						    </tr>
						  </tbody>
						</table>
						
			 		</div>
			 </div>
			 
			 
			<c:choose> 
				<c:when test="${typeKor == '휴가 신청서'}">
				 dd
				 </c:when>
				 
				 <c:when test="${typeKor == '지출 결의서' }">
					<div class="row">
						<div class="col-12">
							<table class="table table-bordered">
						  
							  <tbody>
							    <tr>
							      <th scope="row" class="mylabel">비용</th>
							      <td>${doc.cash.cashExpense } ￦ </td>
							      <th scope="row" class="mylabel">지출일</th>
							      <td>${doc.cash.cashDate }</td>
							    </tr>
									
							  </tbody>
							</table>
						</div>	
					</div>	
							 <div class="row">
							 	<div class="col-12">
							 		<table class="table table-bordered">
							 			<tr>
									        <th scope="row" class="mylabel">상세 내용</th>
									    </tr>
									    <tr>
									    	<td height="600">
									    		${doc.cash.cashDetail }
									    	</td>
									    </tr>
							 		
							 		</table>
							 	</div>
							 	
							 </div>		
					
				 </c:when>
				 
				 <c:when test="${typeKor == '품의서'}">
				
					 <div class="row">
					 	<div class="col-12">
					 		<table class="table table-bordered">
					 			<tr>
							        <th scope="row" class="mylabel">상세 내용</th>
							    </tr>
							    <tr>
							    	<td height="600">
							    		${doc.req.reqDetail }
							    	</td>
							    </tr>
					 		
					 		</table>
					 	</div>
					 	
					 </div>		
				 
				 </c:when>
				 
				 <c:when test="${typeKor == '기타 문서' }">
				 dd
				 </c:when>
		</c:choose>
          <!-- coma content space -->
        </div>
    </div>
    <!-- TEAM COMA SPACE -->
    </div>
  </div>
  

<script src="/resource/js/approval/apprView.js"></script> 

<jsp:include page="/WEB-INF/views/common/footer.jsp"/>


