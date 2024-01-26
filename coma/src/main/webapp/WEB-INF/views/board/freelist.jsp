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
<c:set var="path" value="${pageContext.request.contextPath }"/>
    <!-- TEAM COMA SPACE -->
<link href="${path }/resource/css/board/board.css" rel="stylesheet">
<c:set var="emp" value="${sessionScope.SPRING_SECURITY_CONTEXT.authentication.principal }"/>
<style>


	
</style>

<div class="coma-container">
	<div class="row">
		<div class="col-1"></div>
		<div class="col-9 table-wrapper">
			<div class="title">
					<div class="">
						<a href="${path }/board/freelist"><h1>자유게시판</h1></a>
					</div>
					
				</div>
			</div>
			<!-- 관리자 글삭제 -->
				<c:if test="${fn:contains(emp.authorities, 'ADMIN')}">
					<div class="col-1" style="align-self: center;">
				      <button onclick="deleteSelected()" class="btn btn-outline-primary">게시글삭제</button>   
				  	</div>
				</c:if>
			<div class="col-1"></div>
			</div>
			
			<div class="row">
			<div class="col-1"></div>
			<table class="col-10 table table-hover">
				<thead>
					<tr>
						<c:if test="${fn:contains(emp.authorities, 'ADMIN')}">
						<th>
							<span class="custom-checkbox">
								<input type="checkbox" id="selectAll" onclick="allChecked()">
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
								<input type="checkbox" id="checkbox1" name="options[]" value="${free.boardNo }" onclick="boxClicked()">
								<label for="checkbox1"></label>
							</span>
						</td>
						</c:if>
						<td class="no">${free.boardNo }</td>
						
	   					<td class="title">
	   						<a href="${path }/board/freePost?boardNo=${free.boardNo }" style="display: flex">
	   							<!-- 글 제목 -->
	   							${free.boardTitle }&emsp;
	   							<!-- 글 이미지여부 -->
		   						<c:if test="${free.boardFileCount > 0 }">
		   							<i class="ni ni-image" style="color: black;"></i>&emsp;
		   						</c:if>
		   						<!-- 글 댓글여부  -->
		   						<strong style="color: red;">
		   							<c:if test="${free.replyCount > 0 }">
		   								${free.replyCount }
		   							</c:if>
		   						</strong>
		   					</a>
	   					</td>
	   					
	   					<td class="writer" data-toggle="tooltip" data-placement="top"
	   										title='<c:if test="${free.emp.dept.deptType != '관리' }">
	   													${free.emp.dept.deptType }과</c:if>
	   													${free.emp.job.jobType}'>
   						 	${free.emp.empName }
   						 </td>
	   					
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
			<div class="col-1"></div>
			</div>
			
			
			
			<div class="row">
				<div class="col-1"></div>
					<div class="row" style="display: flex">
						<div class="col-12">
						    <form name="searchForm" autocomplete="off">
							    <select class="" id="category" name="search-type">
							        <option value="search-title">제목</option>
							        <option value="search-content">내용</option>
							        <option value="search-writer">작성자</option>
							    </select>
							    <input type="hidden" name="boardType" value="${type }">
							    <input class="form-control-sm" type="text" name="search-keyword" id="searchInput">
							    <button type="button" class="btn btn-primary" onclick="getSearchList()">
							   		 <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-search" viewBox="0 0 16 16">
									  <path d="M11.742 10.344a6.5 6.5 0 1 0-1.397 1.398h-.001c.03.04.062.078.098.115l3.85 3.85a1 1 0 0 0 1.415-1.414l-3.85-3.85a1.007 1.007 0 0 0-.115-.1zM12 6.5a5.5 5.5 0 1 1-11 0 5.5 5.5 0 0 1 11 0z"/>
									</svg>
							    </button>
						    </form>
						</div>
					</div>
				<div class="col-4 pageBar-container">
							${pageBarFree }
				</div>
				
				
					<div class="col-3 wrtie" style="text-align: right;">
						<a href="${path }/board/writeView?boardType=1" class="btn btn-primary" ><span>글쓰기</span></a>	
					</div>
				<div class="col-1"></div>
			</div>
	</div>        

<script>

const path='${path}';

//관리자(COMA_1) 체크박스 글삭제
function allChecked() {
    // 'selectAll' 체크박스가 변경되면 모든 하위 체크박스를 선택/해제
    var checkboxes = document.getElementsByName('options[]');
    var selectAllCheckbox = document.getElementById('selectAll');

    for (var i = 0; i < checkboxes.length; i++) {
        checkboxes[i].checked = selectAllCheckbox.checked;
    }
}

function boxClicked() {
    // 하위 체크박스 중 하나라도 체크가 해제되면 'selectAll' 체크박스도 해제
    var checkboxes = document.getElementsByName('options[]');
    var selectAllCheckbox = document.getElementById('selectAll');

    for (var i = 0; i < checkboxes.length; i++) {
        if (!checkboxes[i].checked) {
            selectAllCheckbox.checked = false;
            return;
        }
    }

    // 모든 하위 체크박스가 체크되면 'selectAll' 체크박스도 체크
    selectAllCheckbox.checked = true;
}

function deleteSelected() {
    // 선택된 체크박스의 값을 수집하여 삭제 요청 등을 수행
    var checkboxes = document.getElementsByName('options[]');
    var selectedIds = [];

    for (var i = 0; i < checkboxes.length; i++) {
        if (checkboxes[i].checked) {
            // 여기에서 선택된 체크박스의 ID 값을 추출하고 배열에 추가
        	selectedIds.push(checkboxes[i].getAttribute('value'));
        }
    }

    // 선택된 ID 값을 사용하여 삭제 동작 수행 (예: AJAX 요청 등)
    if (selectedIds.length > 0) {
        // 여기에서 선택된 ID 값을 사용하여 삭제 동작 수행
    	 $.ajax({
             url: path+'/board/checkDelete', 
             method: 'POST',
             contentType: 'application/json',
             data: JSON.stringify(selectedIds),
             success: function(response) {
                 alert('삭제 성공!');
                 location.reload();
             },
             error: function(error) {
                 console.error("삭제 실패", error);
             }
         });
		
    } else {
        alert('선택된 항목이 없습니다.');
    }
}

//	


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
			url : path+"/board/search",
			data : $("form[name=searchForm]").serialize(),
			success : function(result){
				$('.table > tbody').empty();
				if(result.length>=1){
					result.forEach(function(searchBoard){
						console.log(searchBoard);
						str='<tr>'
						str += "<td class='no'>"+searchBoard.boardNo+"</td>";
						str+="<td class='title'><a href = '/board/freePost?boardNo=" + searchBoard.boardNo + "'>" + searchBoard.boardTitle + "</a></td>";
						str+="<td class='writer'>"+searchBoard.emp.empName+"</td>";
						str+="<td class='date'>"+searchBoard.boardDate+"</td>";
						str+="<td class='read'>"+searchBoard.boardReadCount+"</td>";
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