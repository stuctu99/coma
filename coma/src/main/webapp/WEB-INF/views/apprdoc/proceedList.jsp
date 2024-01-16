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

.table td{
	text-align: left;
}
</style>
    <div class="coma-container" style="margin-top:5px; margin-bottom: 5px;">
        
    <div class="space-y-2" style="text-align: center">
      <div class="flex flex-col">
		<h1>진행중인 문서</h1>
      	<a href="${path }">
        <span class="text-sm font-semibold text-gray-500">진행중인 문서</span>
        </a>
        <a href="${path }/apprdoc/docList">
          <span class="text-sm font-semibold text-gray-500">문서함</span>
        </a>
      </div>
      <div>
	    <a href="${path }/approval/writedoc" class="inline-flex items-center justify-center btn btn-success">
	  		<span>작성하기</span>
	    </a>
	  </div>
    </div>
  <main class="flex-1 p-5">
    <div class="flex justify-between items-center mb-6">
      <div class="flex space-x-2" style ="text-align: right;">
     	<form name="searchForm" autocomplete="off">
        <input
          class="flex h-10 w-full rounded-md border border-input bg-background px-3 py-2 text-sm"
          placeholder="문서 검색" name="keyword"/>
        <select
          aria-hidden="true"
          tabindex="-1"
          style="position: absolute; border: 0px; width: 1px; height: 1px; padding: 0px; margin: -1px; overflow: hidden; clip: rect(0px, 0px, 0px, 0px); white-space: nowrap; overflow-wrap: normal;">
          <option value=""></option>
        </select>
        <button type="button" class="inline-flex items-center justify-center btn btn-success" onclick="getSearchList()">
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
              <th class="h-12 px-4 text-left align-middle font-medium text-muted-foreground">
                문서 번호
              </th>
              <th class="h-12 px-4 text-left align-middle font-medium text-muted-foreground">
                종류
              </th>
              <th class="h-12 px-4 text-left align-middle font-medium text-muted-foreground">
                제목
              </th>
              <th class="h-12 px-4 text-left align-middle font-medium text-muted-foreground">
                기안자
              </th>
              <th class="h-12 px-4 text-left align-middle font-medium text-muted-foreground">
                기안일
              </th>
              <th class="h-12 px-4 text-left align-middle font-medium text-muted-foreground">
                상태
              </th>
            </tr>
          </thead>
          <tbody>
         		<c:forEach var="proceeds" items="${proceed}">
	         		<c:if test="${proceeds.docProgress eq '대기' || proceeds.docProgress eq '진행'}">
		         		<tr>
			          		<td>${proceeds.docNo }</td>
			          		<td>${proceeds.docType }</td>
			          		<td><a href="/approval/viewdoc?docNo=${proceeds.docNo }">${proceeds.docTitle }</a></td>
			          		<td>${proceeds.emp.empName }</td>
			          		<td><fmt:formatDate value="${proceeds.docDate}" pattern="MM-dd" /></td>
			          		<td>${proceeds.docProgress }</td>
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
				result.filter(e=>e.docProgress.includes('대기')||e.docProgress.includes('진행'))
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