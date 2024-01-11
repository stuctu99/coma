<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
<jsp:include page="/WEB-INF/views/common/header.jsp">
   <jsp:param name="id" value="mine" />
</jsp:include>
<style>
div {
  /*  border: 2px solid red; */
   
   
   
}  
.bigbax{
	/* border: 2px solid blue; */
	margin: 15px;
	/* border: 2px solid lightgrey */;
	border-radius: 20px;
	background-color: #f1edff;
	padding: 20px 10px 20px 20px ;
	box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
	
}
.containerbig{
	margin: 50px;
	/* box-shadow: 0 0 10px rgba(0, 0, 0, 0.1); */
	text-align: center;
	/* padding: 50px 50px 50px 70px; */
	padding: 20px;
	/* background-color : white; */
	/*background-color: #f1edff; */
	border-radius: 20px;
}



/* You may need to adjust the styling based on your specific requirements */

</style>
<div class="coma-container containerbig" >
   <div class="row" style="text-align:center;">
   	<div class="col-1" > </div>   	
      <div class="col-3 bigbax" >
         <div class="">
            <h2 class="col-8">일반 근무 정보</h2>
            <button   class="col-4">근무   기록</button>
         </div>
         <div class=" row">
            <div class="col-6">
               <div class="">
                  <h3 class="">지각</h3>
               </div>
               <div class="row">
                  <p>1회</p>
               </div>
            </div>
            <div class=" col-6 ">
               <div class=" ">
                  <h3 class="">조기퇴근</h3>
               </div>
               <div class="row">
                  <p>1회</p>
               </div>
            </div>
         </div>
         <div class=" row">
            <div class=" col-6">
               <div class="">
                  <h3 class="">퇴근미체크</h3>
               </div>
               <div class="row">
                  <p>0회</p>
               </div>
            </div>
            <div class=" col-6" >
               <div class="">
                  <h3 class="">결근</h3>
               </div>
               <div class="row">
                  <p>0회</p>
               </div>
            </div>
         </div>
      </div>
      <div  class="col-3 bigbax" >
         <div class="">
            <h2 class="">오늘 근무 현황</h2>
         </div>
         <div class="" >
            <div class="">
               <h3 class="">근무
                  계획</h3>
            </div>
            <div class="">
               <div class="">
                  <p class="">10</p>
                  <p>수요일</p>
               </div>
               <p class="">9시 출근</p>
               <p>09:00 ~ 18:00 (점심 1시간)</p>
               <div class="">
                  <button class="">내 근무 계획</button>
                  <button class="">대체근무신청</button>
                  <button class="">휴가/외출신청</button>
               </div>
            </div>
         </div>
      </div>
      <div  class="col-3 bigbax">
         <div class="">
            <h2 class="">근무 시간</h2>
         </div>
         <div class="" >
            <div class="">
               <h3 class="">근무 타이머</h3>
            </div>
            <div class="">
               <div class="">
                  <div class="">
                     <p class=" ">22 : 56 : 04</p>
                     <button class=" ">근무 종료</button>
                  </div>
                  <div class="">
                     <p>출근하기</p>
                     <p class="mt-2">09:17:36</p>
                     <button class="">퇴근하기</button>
                  </div>
               </div>
            </div>
         </div>
      </div>
      <!-- <div class="col-1"></div> -->
   </div>
   <div class="row">
   	  <div class=col-1></div>
      <div class="col-3 bigbax" style="text-align:center;">
         <div class="">
            <h3 class="">근무 요약</h3>
         </div>
         <div class="">
            <div class="">
               <div>
                  <p class="">근무일수</p>
                  <p>1일</p>
               </div>
               <div>
                  <p class="">총근무시간</p>
                  <p>17분</p>
               </div>
            </div>
         </div>
      </div>
      <div class="col-3 bigbax" style="text-align:center;">
         <div class="">
            <h3 class="">근무 시간</h3>
         </div>
         <div class="">
            <div class="">
               <div class="">
                  <p>09:17</p>
                  <p class="mt-2">출근</p>
               </div>
               <div class="text-center">
                  <p>09:17</p>
                  <p class="mt-2">퇴근</p>
               </div>
            </div>
            <button class="">근무시간 수정</button>
         </div>
      </div>
      <div class="col-3 bigbax" style="text-align:center;">
         <div class="">
            <h3 class="">근무 현황</h3>
         </div>
         <div class="">
            <div class="">
               <div>
                  <p class="">근무일수</p>
                  <p>1일</p>
               </div>
               <div>
                  <p class="">총근무시간</p>
                  <p>17분</p>
               </div>
               <div>
                  <p class="">보정시간</p>
                  <p>17분</p>
               </div>
            </div>
         </div>
      </div>
   </div>
</div>
<div class="coma-container">
   <div class="row"> <!-- 총 12칸 -->
      <div class="col-4">1</div>
      <div class="col-4">2</div>
      <div class="col-4">3</div>
   </div>
</div>


<jsp:include page="/WEB-INF/views/common/footer.jsp" />