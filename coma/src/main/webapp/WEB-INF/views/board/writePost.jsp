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
<c:set var="loginMember" value="${sessionScope.SPRING_SECURITY_CONTEXT.authentication.principal }"/> 
<c:set var="boardType" value="${boardType }"/>

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
	        <form name="boardForm" action="${path }/board/writePost" method="POST" enctype="multipart/form-data">	
	        	<input type="hidden" name="boardType" value="${boardType }">
				<div class="form-group">
				  <input type="text" class="form-control" id="title" name="title" placeholder="제목을 입력해주세요">
				</div>
	        	<div>
	        		<input type="text" class="form-control" value="${loginMember.empName }" style="width:100px;" disabled="disabled">
	        		<input type="hidden" name="writer" value="${loginMember.empId }" >
	        	</div>
				<br>
				
				
				<!-- 에디터 적용할 div -->
			    <!-- <div class="content form-group"></div> -->
				<textarea name="content" id="editor"></textarea>
				
				
			    <button type="button" class="btn btn-primary" onclick="insertBoard();">글쓰기</button>
			  </form>
		</div>
	</div>
</div>
<!-- TOAST UI Editor CDN(JS) -->
<script src="https://uicdn.toast.com/editor/latest/toastui-editor-all.min.js"></script>
<!-- CKEDITOR5 -->
<script src="https://cdn.ckeditor.com/ckeditor5/40.2.0/classic/ckeditor.js"></script>
<script>

function insertBoard(){
	console.log(ckeditor.getData());
	document.querySelector("#editor").innerText=ckeditor.getData();
	boardForm.submit();
}

class MyUploadAdapter {
    constructor( loader ) {
        // The file loader instance to use during the upload.
        this.loader = loader;
    }

    // Starts the upload process.
    upload() {
    	const reader=new FileReader();
        return this.loader.file
            .then( file => new Promise( ( resolve, reject ) => {
                this._initRequest();
                this._initListeners( resolve, reject, file );
                this._sendRequest( file );
            } ) );
    }

    // Aborts the upload process.
    abort() {
        if ( this.xhr ) {
            this.xhr.abort();
        }
    }

    // Initializes the XMLHttpRequest object using the URL passed to the constructor.
    _initRequest() {
        const xhr = this.xhr = new XMLHttpRequest();

        // Note that your request may look different. It is up to you and your editor
        // integration to choose the right communication channel. This example uses
        // a POST request with JSON as a data structure but your configuration
        // could be different.
        xhr.open( 'POST', '${path}/board/ckFile', true );
        xhr.responseType = 'json';
        
        xhr.setRequestHeader('X-Requested-With', 'XMLHttpRequest');

    }

    // Initializes XMLHttpRequest listeners.
    _initListeners( resolve, reject, file ) {
        const xhr = this.xhr;
        const loader = this.loader;
        const genericErrorText = `Couldn't upload file: ${ file.name }.`;

        xhr.addEventListener( 'error', () => reject( genericErrorText ) );
        xhr.addEventListener( 'abort', () => reject() );
        xhr.addEventListener( 'load', () => {
            const response = xhr.response;

            // This example assumes the XHR server's "response" object will come with
            // an "error" which has its own "message" that can be passed to reject()
            // in the upload promise.
            //
            // Your integration may handle upload errors in a different way so make sure
            // it is done properly. The reject() function must be called when the upload fails.
            if ( !response || response.error ) {
                return reject( response && response.error ? response.error : genericErrorText );
            }

            // If the upload is successful, resolve the upload promise with an object containing
            // at least the "default" URL, pointing to the image on the server.
            // This URL will be used to display the image in the content. Learn more in the
            // UploadAdapter#upload documentation.
            resolve( {
                default: '${path}'+response.url
            } );
        } );

        // Upload progress when it is supported. The file loader has the #uploadTotal and #uploaded
        // properties which are used e.g. to display the upload progress bar in the editor
        // user interface.
        if ( xhr.upload ) {
            xhr.upload.addEventListener( 'progress', evt => {
                if ( evt.lengthComputable ) {
                    loader.uploadTotal = evt.total;
                    loader.uploaded = evt.loaded;
                }
            } );
        }
    }

    // Prepares the data and sends the request.
    _sendRequest( file ) {
        // Prepare the form data.
        const data = new FormData();
		console.log(file);
        data.append( 'upload', file );
		
        data.append( 'resize', true );
        
        this.xhr.send( data );
    }
}

function MyCustomUploadAdapterPlugin( editor ) {
    editor.plugins.get( 'FileRepository' ).createUploadAdapter = ( loader ) => {
        // Configure the URL to the upload script in your back-end here!
        return new MyUploadAdapter( loader );
    };
}

let ckeditor;
ClassicEditor
.create( document.querySelector('#editor'),{
	extraPlugins: [MyCustomUploadAdapterPlugin]
}).then(editor=>ckeditor=editor);

			




/* const editor = new toastui.Editor({
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
                /* const formData = new FormData();
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
}); */


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