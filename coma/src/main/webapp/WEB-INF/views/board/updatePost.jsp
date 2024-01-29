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
<c:set var="post" value="${post }"/>

<div class="container" style="">
	<div class="row">
		<div class="col-sm-12">
	      <div class="col-9 table-wrapper">
				<div class="row">
					<div class="col-10">
						<h1>글수정</h1>
					</div>
					
				</div>
			</div>
	        <form name="boardForm" action="${path }/board/update" method="POST" enctype="multipart/form-data">	
	        	<input type="hidden" name="boardType" value="${post.boardType }">
				<div class="form-group">
				  <input type="text" class="form-control" id="title" name="title" value="${post.boardTitle }">
				</div>
	        	<div>
	        		<input type="hidden" class="form-control" value="${loginMember.empName }" style="width:100px;" disabled="disabled">
	        		<input type="hidden" name="boardNo" value="${post.boardNo }" >
	        	</div>
				<br>
				
				
				<!-- 에디터 적용할 div -->
			    <!-- <div class="content form-group"></div> -->
				<textarea name="content" id="editor">${post.boardContent }</textarea>
				
				
			    <button type="button" class="btn btn-primary" onclick="insertBoard();" onclick="insertBoard();" style="float: right; width:120px; margin-top: 15px;">수정</button>
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

        xhr.open( 'POST', '${path}/board/ckFile', true );
        xhr.responseType = 'json';
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

            if ( !response || response.error ) {
                return reject( response && response.error ? response.error : genericErrorText );
            }

            resolve( {
                default: '${path}'+response.url
            } );
        } );

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

        this.xhr.send( data );
    }
}

function MyCustomUploadAdapterPlugin( editor ) {
    editor.plugins.get( 'FileRepository' ).createUploadAdapter = ( loader ) => {
     
        return new MyUploadAdapter( loader );
    };
}
let ckeditor;
ClassicEditor
.create( document.querySelector('#editor'),{
	extraPlugins: [MyCustomUploadAdapterPlugin]
}).then(editor=>ckeditor=editor);

</script>
<jsp:include page="/WEB-INF/views/common/footer.jsp"/>