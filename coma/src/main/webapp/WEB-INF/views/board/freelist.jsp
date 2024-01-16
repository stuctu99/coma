<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.Collection,com.coma.model.dto.Board" %>
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
						<a href="${path }"><h2>자유게시판</h2></a>
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
						<th class="no">번호</th>
						<th class="title">제목</th>
						<th class="writer">작성자</th>
						<th class="date">작성일</th>
						<th class="read">조회수</th>
					</tr>
				</thead>
				<tbody>
   					<c:forEach var="free" items="${frees}">
					<tr>
						<c:if test="${fn:contains(emp.authorities, 'ADMIN')}">
						<td>
							<span class="custom-checkbox">
								<input type="checkbox" id="checkbox1" name="options[]" value="1">
								<label for="checkbox1"></label>
							</span>
						</td>
						</c:if>
						<td class="no">${free.boardNo }</td>
	   					<td class="title"><a href="/board/freePost?boardNo=${free.boardNo }">${free.boardTitle }&emsp;</a>
	   						
	   						<strong style="color: red;">
	   							<c:if test="${free.replyCount > 0 }">
	   								${free.replyCount }
	   							</c:if>
	   						</strong>
	   						
	   					</td>
	   					<td class="writer">${free.emp.empName }</td>
	   					
	   					<!-- 날짜출력 오늘: 시간:분 , 24년도-> 월-일만 출력, 그 외 년-월-일 -->
						<c:set var="today" value="<%=java.time.LocalDate.now()%>"/>
						<c:set var="todayHour" value="<%=java.time.LocalDateTime.now().getHour()%>"/>
						<td class="date">
				          <%--   <%=java.time.ChronoUnit.HOURS.between(java.time.LocalDate.now(),
				            		pageContext.getAttribute("boards"))%> --%>
							<c:choose>
								<c:when test="${free.boardDate.toLocalDate() == today}">
									<c:set var="checkHour" value='<%=(new java.util.Date().getTime()-((Board)pageContext.getAttribute("free"))
													.getBoardDate().getTime())/(1000*60*60)%>'/>
									<span>								
										${checkHour>0?"".concat(checkHour).concat("시간 전"):'방금전'}
									</span>
									<%-- <p><%=java.time.LocalDateTime.now().getHour() 
										 -new java.sql.Timestamp(((Board)pageContext.getAttribute("boards"))
													.getBoardDate().getTime()).toLocalDateTime().getHour() %></p> --%>
							        <%-- <fmt:formatDate value="${boards.boardDate}" pattern="HH:mm" /> --%>
							    </c:when>
				                <c:when test="${free.boardDate.year == 124}">
				                    <fmt:formatDate value="${free.boardDate}" pattern="MM-dd" />
				                </c:when>
				                <c:otherwise>
				                    <fmt:formatDate value="${free.boardDate}" pattern="yyyy-MM-dd" />
				                </c:otherwise>
				            </c:choose>
						</td>
	   					<td class="read">${free.boardReadCount }</td>
					</tr>				
					</c:forEach>
				</tbody>
			</table>
			<div class="search-container">
			    <form name="searchForm" autocomplete="off">
				    <select class="se" id="category" name="search-type">
				        <option value="search-title">제목</option>
				        <option value="search-content">내용</option>
				        <option value="search-writer">작성자</option>
				    </select>
				    <input type="hidden" name="boardType" value="${type }">
				    <input class="se" type="text" name="search-keyword" id="searchInput">
				    <button type="button" class="se btn btn-success" onclick="getSearchList()">
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
	function handleEnterKey(event) {
		if (event.key === 'Enter') {
			getSearchList();
		}
	}
	
	$(document).ready(function () {
		$('#searchInput').on('keyup', handleEnterKey);
	});
	
	//검색기능
	function getSearchList(){
		console.log($("form[name=searchForm]"));
		$.ajax({
			type: 'POST',
			url : "/board/search",
			data : $("form[name=searchForm]").serialize(),
			success : function(result){
				$('.table > tbody').empty();
				if(result.length>=1){
					result.forEach(function(searchBoard){
						console.log(searchBoard);
						str='<tr>'
						str += "<td>"+searchBoard.boardNo+"</td>";
						str+="<td><a href = '/board/freePost?boardNo=" + searchBoard.boardNo + "'>" + searchBoard.boardTitle + "</a></td>";
						str+="<td>"+searchBoard.emp.empName+"</td>";
						str+="<td>"+searchBoard.boardDate+"</td>";
						str+="<td>"+searchBoard.boardReadCount+"</td>";
						str+="</tr>";
						console.log(str);
						$('.table').append(str);
	        		})
				}
			}
		})
	}
</script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    <!-- TEAM COMA SPACE -->
<jsp:include page="/WEB-INF/views/common/footer.jsp"/>