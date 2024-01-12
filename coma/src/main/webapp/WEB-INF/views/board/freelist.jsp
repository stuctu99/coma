<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<jsp:include page="/WEB-INF/views/common/header.jsp">
	<jsp:param name="id" value="mine" />
</jsp:include>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.17.0/font/bootstrap-icons.css">
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
    <!-- TEAM COMA SPACE -->
<link href="${path }/resource/css/board/board.css" rel="stylesheet">
<c:set var="emp" value="${sessionScope.SPRING_SECURITY_CONTEXT.authentication.principal }"/>
<style>
    .search-container {
        display: flex;
        align-items: center;
        justify-content: space-between;
    }

    .search-container form {
        display: flex;
        gap: 0;
    }

    #searchInput {
        flex: 1;
    }
    
    .se {
		border-radius: 0;
		border: 1px solid #375472;
		height: 30px;
	}
</style>

<div class="coma-container">
<div class="container-xl">
	<div class="table-responsive">
		<div class="table-wrapper">
			<div class="table-title">
				<div class="row">
					<div class="col-sm-6">
						<h2>자유게시판</h2>
					</div>
					
				</div>
			</div>
			<table class="table table-striped table-hover">
				<thead>
					<tr>
						<c:if test="${fn:contains(emp.authorities, 'ADMIN')}">
						<th>
							<span class="custom-checkbox">
								<input type="checkbox" id="selectAll">
								<label for="selectAll"></label>
							</span>
						</th>
						</c:if>
						<th>번호</th>
						<th>제목</th>
						<th>작성자</th>
						<th>작성일</th>
						<th>조회수</th>
					</tr>
				</thead>
				<tbody>
   					<c:forEach var="free" items="${totalReply}">
					<tr>
						<c:if test="${fn:contains(emp.authorities, 'ADMIN')}">
						<td>
							<span class="custom-checkbox">
								<input type="checkbox" id="checkbox1" name="options[]" value="1">
								<label for="checkbox1"></label>
							</span>
						</td>
						</c:if>
						<td>${free.boardNo }</td>
	   					<td><a href="/board/freePost?boardNo=${free.boardNo }">${free.boardTitle }&emsp;</a>
	   						
	   						<strong style="color: red;">
	   							<c:if test="${free.replyCount > 0 }">
	   								${free.replyCount }
	   							</c:if>
	   						</strong>
	   						
	   					</td>
	   					<td>${free.emp.empName }</td>
	   					<td>${free.boardDate }</td>
	   					<td>${free.boardReadCount }</td>
					</tr>				
					</c:forEach>
				</tbody>
			</table>
			<%-- <form action="${path }/board/writePost" method="post"> --%>

<!-- 				<button type="submit">글쓰기</button>	
			</form>	 -->			
			<div class="search-container">
			    <form action="searchForm" onsubmit="return false;" autocomplete="off">
				    <select class="se" id="category" name="category">
				        <option value="cate-title">제목</option>
				        <option value="cate-content">내용</option>
				        <option value="cate-author">작성자</option>
				    </select>
				    <input class="se" type="text" id="searchInput">
				    <button type="button" class="se btn btn-success" onclick="movePage(1)">
				   		 <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-search" viewBox="0 0 16 16">
						  <path d="M11.742 10.344a6.5 6.5 0 1 0-1.397 1.398h-.001c.03.04.062.078.098.115l3.85 3.85a1 1 0 0 0 1.415-1.414l-3.85-3.85a1.007 1.007 0 0 0-.115-.1zM12 6.5a5.5 5.5 0 1 1-11 0 5.5 5.5 0 0 1 11 0z"/>
						</svg>
				    </button>
			    </form>
   				<div class="wrtie" style="text-align: right;">
					<a href="${path }/board/writeView?boardType=1" class="btn btn-success"><span>글쓰기</span></a>	
				</div>
			</div>
			<div class="">
						${pageBarFree }
			</div>
		</div>
	</div>        
</div>
</div>

<script>
	function movePage(page) {
		
		const form = document.getElementById('searchForm');
		
		const queryParam = {
			page: (page)? page : 1,
					recordSize: 10,
					pageSize: 10,
					searchType: form.category.value,
					keyword: from.searchInput.value
		}
		
		location.href = location.pathname + '?' + new URLSearchParams(queryParams).toString();
	}
</script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    <!-- TEAM COMA SPACE -->
<jsp:include page="/WEB-INF/views/common/footer.jsp"/>