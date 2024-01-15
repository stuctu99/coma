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
</style>
    <div class="coma-container" style="margin-top:5px; margin-bottom: 5px;">
        <div class="container" style="text-align: center; margin-top:5px; margin-bottom: 5px;">
    <nav class="space-y-2">
      <div class="flex flex-col">
      	<a href="#">
        <span class="text-sm font-semibold text-gray-500">진행중인문서</span>
        </a>
        <a href="#">
          <span class="text-sm font-semibold text-gray-500">문서함</span>
        </a>
      </div>
    <button class="inline-flex items-center justify-center btn btn-success">
      작성하기
    </button>
    </nav>
  <main class="flex-1 p-5">
    <div class="flex justify-between items-center mb-6">
      <button type="button">
        <span style="pointer-events: none;">모든 문서</span>
      </button>
      <select>
              <option value=""></option>
      </select>
      <div class="flex space-x-2">
        <input
          class="flex h-10 w-full rounded-md border border-input bg-background px-3 py-2 text-sm"
          placeholder="문서 검색"/>
        <select
          aria-hidden="true"
          tabindex="-1"
          style="position: absolute; border: 0px; width: 1px; height: 1px; padding: 0px; margin: -1px; overflow: hidden; clip: rect(0px, 0px, 0px, 0px); white-space: nowrap; overflow-wrap: normal;"
        >
          <option value=""></option>
        </select>
      </div>
    </div>
    <div class="bg-white p-5 border rounded">
      <div class="relative w-full overflow-auto">
        <table class="w-full caption-bottom text-sm">
          <thead class="[&amp;_tr]:border-b">
            <tr class="border-b transition-colors hover:bg-muted/50 data-[state=selected]:bg-muted">
              <th class="h-12 px-4 text-left align-middle font-medium text-muted-foreground">
                문서 번호
              </th>
              <th class="h-12 px-4 text-left align-middle font-medium text-muted-foreground">
                제목
              </th>
              <th class="h-12 px-4 text-left align-middle font-medium text-muted-foreground">
                종류
              </th>
              <th class="h-12 px-4 text-left align-middle font-medium text-muted-foreground">
                기안자
              </th>
              <th class="h-12 px-4 text-left align-middle font-medium text-muted-foreground">
                기안일
              </th>
            </tr>
          </thead>
          <tbody>
          		<tr>
	          		<td>1</td>
	          		<td>제제제목목</td>
	          		<td>종종류류류</td>
	          		<td>기기안안자</td>
	          		<td>기기안안일</td>
          		</tr>
          </tbody>
        </table>
      </div>
    </div>
  </main>
  </div>
  </div>
<jsp:include page="/WEB-INF/views/common/footer.jsp"/>