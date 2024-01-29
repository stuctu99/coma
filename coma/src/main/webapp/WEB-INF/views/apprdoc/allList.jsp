<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.Collection,com.coma.model.dto.ApprovalDoc" %>
<jsp:include page="/WEB-INF/views/common/header.jsp">
	<jsp:param name="id" value="mine" />
</jsp:include>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<c:set var="path" value="${pageContext.request.contextPath }" />
<c:set var="e" value="${sessionScope.SPRING_SECURITY_CONTEXT.authentication.principal }"/>
<style>

.card-stats {
	width:240px;
	margin: 0 20px 0 20px;
}

.table td{
	text-align: left;
}

.doc-no{
	width: 110px;
}

.doc-type{
	width: 94px;
}

.doc-title{

}

.doc-writer{
	width: 90px;
	text-align: center !important;
}

.doc-date{
	width: 100px;
	text-align: center !important;
}

.doc-end{
	width: 140px;
}

.doc-pg{
	width: 100px;
}
.dropbtn{
  display : block;
  background-color: #fcfcfc;
  font-weight: 400;
  color : rgb(124, 124, 124);
  padding : 12px;
  width :140px;
  height: 40px;
  text-align: left;
  cursor : pointer;
  font-size : 12px;
  z-index :1;
  position : relative;
}

.dropdown-content{
  display : none;
  font-weight: 400;
  background-color: #fcfcfc;
  width: 110px;
  border-radius: 8px;
  height : 167px;
  overflow : hidden;
  box-shadow: 0px 0px 10px 3px rgba(190, 190, 190, 0.6);
}
.dropdown-content::-webkit-scrollbar{
  width : 5px;
  height : 10px;
}
.dropdown-content::-webkit-scrollbar-thumb{
  border-radius : 2px;
  background-color :rgb(194, 194, 194)
}

.dropdown-content div{
  display : block;
  text-decoration : none;
  color : rgb(37, 37, 37);
  font-size: 12px;
  padding : 12px 20px;
}

.dropdown-content div:hover{
  background-color: rgb(226, 226, 226);
}

.dropdown-content.show{
  display : block;

</style>






<div class="coma-container" style="margin-top:20px; margin-bottom: 5px;">

	<div class="space-y-2" style="text-align: center">
	  <div class="flex flex-col">
	  	<h1>${e.empName } 문서함</h1>
	  </div>
		
	</div>
 
<div class="card-container">
	<div class="" style="margin: 20px 0 20px 0; display: flex; width: 100%; justify-content: center;">
		<div class="card card-stats alldoc">
		    <a href="${path }/apprdoc/allList?empId=${e.empId}">
		    <div class="card-body">
				<div class="row">
				    <div class="col">
				        <h5 class="card-title text-uppercase text-muted mb-0">총 문서</h5>
				        <span class="h2 font-weight-bold mb-0">${allCount }개</span>
				    </div>
				    <div class="col-auto">
				      <div class="icon icon-shape bg-blue text-white rounded-circle shadow">
				          <i class="ni ni-archive-2"></i>
				      </div>
				    </div>
				</div>
				<p class="mt-3 mb-0 text-sm">
				    <span class="text-success mr-2"></span>
				    <span class="text-nowrap"></span>
				</p>
		    </div>
			</a>
		</div>
		<div class="card card-stats pgdoc">
			<a href="${path }/apprdoc/proceedList?empId=${e.empId}">
		    <div class="card-body"> 
				<div class="row">
				    <div class="col">
				        <h5 class="card-title text-uppercase text-muted mb-0">진행중인 문서</h5>
				        <span class="h2 font-weight-bold mb-0">${startCount }개</span>
				    </div>
				    <div class="col-auto">
				      <div class="icon icon-shape bg-green text-white rounded-circle shadow">
				          <i class="ni ni-button-play"></i>
				      </div>
				    </div>
				</div>
				<p class="mt-3 mb-0 text-sm">
				<c:if test="${startCount > 0}">
				    <span class="text-success mr-2"><i class="fa fa-arrow-up"></i></span>
				    <span class="text-nowrap">결재할 문서가 있습니다</span>
				</c:if>
				</p>
		    </div>
		    </a>
		</div>
		<div class="card card-stats enddoc">
			<a href="${path }/apprdoc/docList?empId=${e.empId}">
		    <div class="card-body"> 
				<div class="row">
				    <div class="col">		    
				        <h5 class="card-title text-uppercase text-muted mb-0">완료된 문서</h5>
				        <span class="h2 font-weight-bold mb-0">${endCount }개</span>
				   
				    </div>
				    <div class="col-auto">
				      <div class="icon icon-shape bg-orange text-white rounded-circle shadow">
				          <i class="ni ni-folder-17"></i>
				      </div>
				    </div>
				</div>
				<p class="mt-3 mb-0 text-sm">
				<c:if test="${endCount > 0}">
				    <span class="text-success mr-2"><i class="fa fa-arrow-up"></i></span>
				    <span class="text-nowrap">업데이트된 문서가 있습니다</span>
				</c:if>
				</p>
		    </div>
		    </a>
		</div>
	</div>
	<div style="text-align: center">
	    <a href="${path }/approval/writedoc" class="inline-flex items-center justify-center btn btn-primary" style="width:46%;">
	  		<span style="font-size:16px;">+ 문서 작성하기</span>
	    </a>
	 </div>
   </div>
    
  <main class="flex-1 p-5" style="padding-left: 139.91px !important; padding-right: 139.91px !important;">
    <div class="flex justify-between items-center mb-3">
      <div class="flex space-x-2" style ="text-align: right; display: flex; justify-content: space-between;">
      
      	<div class="dropdown" style="position : relative; display : inline-block; height: 40px; width: 98.41px;">
		    <button class="dropbtn_click btn btn-outline-primary"  onclick="dropdown()" style="width: 111.64px;">
		    	모든 문서
		    </button>
		    
		    <div class="dropdown-content">
		      <div class="mydoc" onclick="showMenu('모든 문서') getData('모든');">모든 문서</div>	
		      <div class="mydoc" onclick="showMenu('휴가신청서'); getData('휴가');">휴가신청서</div>
		      <div class="mydoc" onclick="showMenu('지출결의서'); getData('지출');">지출결의서</div>
		      <div class="mydoc" onclick="showMenu('품의서'); getData('품의');">품의서</div>
		      <div class="mydoc" onclick="showMenu('기타'); getData('기타');">기타</div>
		    </div>
		  </div>
      
      <form name="searchForm" autocomplete="off">
        <input class="flex h-10 w-full rounded-md border border-input bg-background px-3 py-2 text-sm"
          placeholder="문서 검색" name="keyword"/>
        <select
          aria-hidden="true"
          tabindex="-1"
          style="position: absolute; border: 0px; width: 1px; height: 1px; padding: 0px; margin: -1px; overflow: hidden; clip: rect(0px, 0px, 0px, 0px); white-space: nowrap; overflow-wrap: normal;"
        >   
        <option value=""></option>
        </select>
        <input type="hidden" name="empId" value="${e.empId }"/>
        <button type="button" class="inline-flex items-center justify-center btn btn-primary" onclick="getSearchList()">
        	검색
	    </button>
	   </form>
      </div>
    </div>
    <div class="bg-white p-5 border rounded">
      <div class="relative w-full overflow-auto">
        <table class="table table-hover w-full caption-bottom text-sm">
          <thead class="[&amp;_tr]:border-b">
            <tr class="border-b transition-colors hover:bg-muted/50 data-[state=selected]:bg-muted">
              <th class="doc-no">
                &nbsp;문서 번호
              </th>
              <th class="doc-type">
                종류
              </th>
              <th class="doc-title">
                제목
              </th>
              <th class="doc-writer">
                &nbsp;기안자
              </th>
              <th class="doc-date">
                기안일
              </th>
              <th class="doc-pg">
                상태
              </th>
            </tr>
          </thead>
          <tbody>
                    <c:forEach var="proceeds" items="${proceed}">
                        <tr>
                            <td class="doc-no">${proceeds.docNo }</td>
                            <td class="doc-type">
                            	<c:choose>
                            		<c:when test="${proceeds.docType eq 'cash'}">
							           	지출
							        </c:when>
							        <c:when test="${proceeds.docType eq 'leave'}">
							            휴가
							        </c:when>
							        <c:when test="${proceeds.docType eq 'req'}">
							           	품의
							        </c:when>
							        <c:when test="${proceeds.docType eq 'etc'}">
							            기타
							        </c:when>
							    </c:choose>
                            </td>
                            <td class="doc-title"><a href="${path }/approval/viewdoc?docNo=${proceeds.docNo }">${proceeds.docTitle }</a></td>
                            <td class="doc-writer" data-toggle="tooltip" data-placement="top" 
	   										title='<c:if test="${proceeds.emp.dept.deptType != '관리'}">
	   													${proceeds.emp.dept.deptType }과</c:if>
	   													${proceeds.emp.job.jobType}'>${proceeds.emp.empName }</td>
	   													
                        <!-- 날짜출력 오늘: 시간:분 , 24년도-> 월-일만 출력, 그 외 년-월-일 -->
						<td class="doc-date">
							<c:choose>
				                <c:when test="${proceeds.docDate.year == 124}">
				                    <fmt:formatDate value="${proceeds.docDate}" pattern="MM-dd" />
				                </c:when>
				                <c:otherwise>
				                    <fmt:formatDate value="${proceeds.docDate}" pattern="yyyy-MM-dd" />
				                </c:otherwise>
				            </c:choose>
				            
						</td>
                            <td class="doc-pg">${proceeds.docProgress }</td>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>
      </div>
    </div>
  </main>
  	<div>${pageBar }</div>
  </div> 
<script>

const path = "${path}"

//검색기능
function getSearchList(){
	console.log($("form[name=searchForm]"));
	$.ajax({
		type: 'POST',
		url : path+"/apprdoc/search",
		data : $("form[name=searchForm]").serialize(),
		success : function(result){
			$('.table > tbody').empty();
			if(result.length>=1){
				result
				.forEach(function(searchDoc){
					console.log(searchDoc);
					const writeDate=new Date(searchDoc.docDate);
					str='<tr>'
						str+="<td class='doc-no'>"+searchDoc.docNo+"</td>";

						switch (searchDoc.docType) {
                        case 'etc':
                            str += "<td>기타</td>";
                            break;
                        case 'cash':
                            str += "<td>지출</td>";
                            break;
                        case 'req':
                            str += "<td>품의</td>";
                            break;
                        case 'leave':
                            str += "<td>휴가</td>";
                            break;
                    	}
						
						str+="<td class='doc-title'><a href = '/approval/viewdoc?docNo=" + searchDoc.docNo + "'>" + searchDoc.docTitle + "</a></td>";
						str+="<td class='doc-writer'>"+searchDoc.emp.empName+"</td>";
						str+="<td class='doc-date'>"+writeDate.getFullYear()+"-"+writeDate.getMonth()+1+"-"+writeDate.getDate()+"</td>";
						str+="<td class='doc-pg'>"+searchDoc.docProgress+"</td>";
					str+="</tr>";
					console.log(str);
					$('.table').append(str);
					
        		})
			}
		}
	})
}

//문서 필터링
window.onload=()=>{
    document.querySelector('.dropbtn_click').onclick = ()=>{
      dropdown();
    }
    
    document.getElementsByClassName('mydoc').onclick = ()=>{
      showMenu(value);
    };
    
    dropdown = () => {
      var v = document.querySelector('.dropdown-content');
      var dropbtn = document.querySelector('.dropbtn')
      v.classList.toggle('show');
    }

    showMenu=(value)=>{
      var dropbtn_content = document.querySelector('.dropbtn_content');
      var dropbtn_click = document.querySelector('.dropbtn_click');
      var dropbtn = document.querySelector('.dropbtn');

      dropbtn_click.innerText = '';
      dropbtn_click.innerText = value;
      
      
    }
  }
  
  window.onclick= (e)=>{
    if(!e.target.matches('.dropbtn_click')){
      var dropdowns = document.getElementsByClassName("dropdown-content");
      
      var dropbtn_content = document.querySelector('.dropbtn_content');
      var dropbtn_click = document.querySelector('.dropbtn_click');
      var dropbtn = document.querySelector('.dropbtn');

      var i;
      for (i = 0; i < dropdowns.length; i++) {
        var openDropdown = dropdowns[i];
        if (openDropdown.classList.contains('show')) {
          openDropdown.classList.remove('show');
        }
      }
    }
  }
  
  function getData(value) {
	  	
	  	const empId = "${e.empId}";
	  
	    $.ajax({
	        url: path+'/apprdoc/filterAll',
	        type: 'POST',
	        data: { filter: value,
	            empId: empId},
	        dataType: 'json',
	        success: function (response) {
	            $('.table > tbody').empty();
	            if (response.length >= 1) {
	                response.forEach(function (filterdoc) {
	                    console.log(filterdoc);
	                    const writeDate=new Date(filterdoc.docDate);
	                    var str = `<tr>`;
	                    str += `<td class='no'>`+filterdoc.docNo+`</td>`;
	                    
	                    switch (filterdoc.docType) {
                        case 'etc':
                            str += "<td>기타</td>";
                            break;
                        case 'cash':
                            str += "<td>지출</td>";
                            break;
                        case 'req':
                            str += "<td>품의</td>";
                            break;
                        case 'leave':
                            str += "<td>휴가</td>";
                            break;
                    	}
	                    
	                    str += `<td class='title'><a href='${path}/approval/viewdoc?docNo=`+filterdoc.docNo+`'>`+filterdoc.docTitle+`</a></td>`;
	                    str += `<td class='writer'>`+filterdoc.emp.empName+`</td>`;
	                    str += `<td class='date'>`+writeDate.getFullYear()+"-"+writeDate.getMonth()+1+"-"+writeDate.getDate()+`</td>`;
	                    str += `<td class='read'>`+filterdoc.docProgress+`</td>`;
	                    str += `</tr>`;
	                    console.log(str);
	                    $('.table').append(str);
	                });
	            }
	        },
	        error: function (error) {
	            console.log('AJAX 요청 실패:', error);
	        }
	    });
	}

</script>
<jsp:include page="/WEB-INF/views/common/footer.jsp"/>