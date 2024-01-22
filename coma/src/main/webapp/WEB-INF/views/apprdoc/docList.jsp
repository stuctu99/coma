<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<jsp:include page="/WEB-INF/views/common/header.jsp">
	<jsp:param name="id" value="mine" />
</jsp:include>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<style>
@import url('https://fonts.googleapis.com/css2?family=Noto+Sans+KR&display=swap');

* {
font-family: 'Noto Sans KR', sans-serif;
}

.card-stats {
	width:240px;
	margin: 0 20px 0 20px;
}

.table td{
	text-align: left;
}
</style>

    <div class="coma-container" style="margin-top:5px; margin-bottom: 5px;">

    <nav class="space-y-2" style="text-align: center">
      <div class="flex flex-col">
      	<h1>문서함</h1>
      </div>
    <a href="${path }/approval/writedoc" class="inline-flex items-center justify-center btn btn-primary">
  		<span>작성하기</span>
    </a>
    </nav>
    
   <div class="card-container">
	<div class="" style="margin: 20px 0 0 0; display: flex; width: 100%; justify-content: center;">
		<div class="card card-stats alldoc">
		    <a href="${path }/apprdoc/allList">
		    <div class="card-body">
				<div class="row">
				    <div class="col">
				        <h5 class="card-title text-uppercase text-muted mb-0">총 문서</h5>
				        <span class="h2 font-weight-bold mb-0">${allCount }개</span>
				    </div>
				    <div class="col-auto">
				      <div class="icon icon-shape bg-green text-white rounded-circle shadow">
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
			<a href="${path }/apprdoc/proceedList">
		    <div class="card-body"> 
				<div class="row">
				    <div class="col">
				        <h5 class="card-title text-uppercase text-muted mb-0">진행중인 문서</h5>
				        <span class="h2 font-weight-bold mb-0">${startCount }개</span>
				    </div>
				    <div class="col-auto">
				      <div class="icon icon-shape bg-blue text-white rounded-circle shadow">
				          <i class="ni ni-button-play"></i>
				      </div>
				    </div>
				</div>
				<p class="mt-3 mb-0 text-sm">
				    <span class="text-success mr-2"><i class="fa fa-arrow-up"></i></span>
				    <span class="text-nowrap">결재할 문서가 있습니다</span>
				</p>
		    </div>
		    </a>
		</div>
		<div class="card card-stats enddoc">
			<a href="${path }/apprdoc/docList">
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
				    <span class="text-success mr-2"><i class="fa fa-arrow-up"></i></span>
				    <span class="text-nowrap">업데이트된 문서가 있습니다</span>
				</p>
		    </div>
		    </a>
		</div>
	</div>
   </div>
    
  <main class="flex-1 p-5">
    <div class="flex justify-between items-center mb-3">
      <div class="flex space-x-2" style ="text-align: right;">
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
        <button type="button" class="inline-flex items-center justify-center btn btn-primary" onclick="getSearchList()">
        	검색
	    </button>
	   </form>
      </div>
    </div>
    <div class="bg-white p-5 border rounded">
      <div class="relative w-full overflow-auto">
        <table class="table w-full caption-bottom text-sm">
          <thead class="[&amp;_tr]:border-b">
            <tr class="border-b transition-colors hover:bg-muted/50 data-[state=selected]:bg-muted">
              <th>
                문서 번호
              </th>
              <th>
                종류
              </th>
              <th>
                제목
              </th>
              <th>
                기안자
              </th>
              <th>
                기안일
              </th>
              <th>
                완료일
              </th>
              <th>
                상태
              </th>
            </tr>
          </thead>
          <tbody>
	       		<c:forEach var="docs" items="${doc}">
		       		<c:if test="${docs.docProgress eq '완료' || docs.docProgress eq '반려'}">
		        		<tr>
			         		<td>${docs.docNo }</td>
			         		<td>${docs.docType }</td>
			         		<td><a href="${path }/approval/viewdoc?docNo=${docs.docNo }">${docs.docTitle }</a></td>
			         		<td>${docs.emp.empName }</td>
			         		<td><fmt:formatDate value="${docs.docDate}" pattern="YYYY-MM-dd" /></td>
			         		<td><fmt:formatDate value="${docs.docDate}" pattern="YYYY-MM-dd" /></td>
		         			<td>${docs.docProgress }</td>
		        		</tr>
		       		</c:if>
	       		</c:forEach>
          </tbody>
        </table>
      </div>
    </div>
  </main>
  </div> 
<script>
//검색기능
function getSearchList(){
	console.log($("form[name=searchForm]"));
	$.ajax({
		type: 'POST',
		url : "/apprdoc/search",
		data : $("form[name=searchForm]").serialize(),
		success : function(result){
			$('.table > tbody').empty();
			if(result.length>=1){
				result.filter(e=>e.docProgress.includes('반려')||e.docProgress.includes('완료'))
				.forEach(function(searchDoc){
					console.log(searchDoc);
					const writeDate=new Date(searchDoc.docDate);
					str='<tr>'
					str+="<td>"+searchDoc.docNo+"</td>";
					str+="<td>"+searchDoc.docType+"</td>";
					str+="<td><a href = '/approval/viewdoc?docNo=" + searchDoc.docNo + "'>" + searchDoc.docTitle + "</a></td>";
					str+="<td>"+searchDoc.emp.empName+"</td>";
					str+="<td>"+writeDate.getFullYear()+"-"+writeDate.getMonth()+1+"-"+writeDate.getDate()+"</td>";
					str+="<td>"+searchDoc.docCorrectDate+"</td>";
					str+="<td>"+searchDoc.docProgress+"</td>";
					str+="</tr>";
					console.log(str);
					$('.table').append(str);
        		})
			}
		}
	})
}
</script>
<jsp:include page="/WEB-INF/views/common/footer.jsp"/>