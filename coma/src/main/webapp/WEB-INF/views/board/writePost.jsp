<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<jsp:include page="/WEB-INF/views/common/header.jsp">
	<jsp:param name="id" value="mine" />
</jsp:include>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<c:set var="path" value="${pageContext.request.contextPath }"/>
<link href="${path }/resource/css/board/board.css" rel="stylesheet">
<!-- TOAST UI Editor CDN(JS) -->
<script src="https://uicdn.toast.com/editor/latest/toastui-editor-all.min.js"></script>
<!-- TOAST UI Editor CDN(CSS) -->
<link rel="stylesheet" href="https://uicdn.toast.com/editor/latest/toastui-editor.min.css" />
<c:set var="loginMember" value="${sessionScope.SPRING_SECURITY_CONTEXT.authentication.principal }"/> 

<div class="container" style="margin-top:30px">
	<div class="row">
		<div class="col-sm-12">
	      <div class="table-title">
				<div class="row">
					<div class="col-sm-6">
						<h2>글작성</h2>
					</div>
					
				</div>
			</div>
	        <form action="${path }/board/writePost" method="POST" enctype="multipart/form-data">
				<div class="form-group">
				  <input type="text" class="form-control" id="title" name="title" placeholder="제목을 입력해주세요">
				</div>
	        	<div>
	        		<input type="text" class="form-control" value="${loginMember.empName }" style="width:100px;">
	        		<input type="hidden" name="writer" value="${loginMember.empId }" >
	        	</div>
				<br>
				<!-- TOAST에디터 적용할 div -->
			    <div class="content form-group">
				</div>
				<input type="text" name="contenttest" id="test1" style="display:none">
				
			    <button type="submit" class="btn btn-primary">글쓰기</button>
			  </form>
			  <button type="button" id="test" class="btn btn-primary" onclick="fn_test();">테스트</button>
		</div>
	</div>
</div>	

<script>
const editor = new toastui.Editor({
    el: document.querySelector('.content'),
    initialEditType: 'wysiwyg',
    previewStyle: 'vertical',
    height: '500px',
    initialValue: '',
    events: {
        change: function () {
            console.log(editor.getMarkdown());
        }
    },
    hooks: {
        async addImageBlobHook(blob, callback) { // 이미지 업로드 로직 커스텀
            try {
                /*
                 * 1. 에디터에 업로드한 이미지를 FormData 객체에 저장
                 *    (이때, 컨트롤러 uploadEditorImage 메서드의 파라미터인 'image'와 formData에 append 하는 key('image')값은 동일해야 함)
                 */
                const formData = new FormData();
                formData.append('upFile', blob);

                // 2. FileApiController - uploadEditorImage 메서드 호출
                const response = await fetch('/board/writePost', {
                    method : 'POST',
                    body : formData,
                });

                // 3. 컨트롤러에서 전달받은 디스크에 저장된 파일명
                const filename = await response.text();
                console.log('서버에 저장된 파일명 : ', filename);

                // 4. addImageBlobHook의 callback 함수를 통해, 디스크에 저장된 이미지를 에디터에 렌더링
                const imageUrl = `/tui-editor/image-print?filename=${filename}`;
                callback(imageUrl, 'image alt attribute');

            } catch (error) {
                console.error('업로드 실패 : ', error);
            }
        }
    }
});


/* const fn_test = () =>{
	const content = editor.getHTML();
	const test = document.querySelector("#test1").innerHTML = content;
	console.log(content);
} */


/* .boaunction submitForm() { //input type="button"

    const editorContentInput = document.getElementById('editorContent'); //hidden input
    const markdownContent = editor.getMarkdown(); //입력한 값
    editorContentInput.value = markdownContent; //hidden input에 입력 값 넣기
    
    const editorForm = document.getElementById('app_form'); //form태그
    
    editorForm.submit(); //form submit
} */
</script>
<jsp:include page="/WEB-INF/views/common/footer.jsp"/>