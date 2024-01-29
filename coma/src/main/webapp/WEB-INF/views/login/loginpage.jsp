<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">

<head>
  <meta charset="utf-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
  <title>
    Coma Login
  </title>
  <!-- Favicon -->
  <link href="${pageContext.request.contextPath }/resource/img/brand/favicon.png" rel="icon" type="image/png">
  <!-- Fonts -->
  <link href="https://fonts.googleapis.com/css?family=Open+Sans:300,400,600,700" rel="stylesheet">
  <!-- Icons -->
  <link href=".${pageContext.request.contextPath }/resource/js/plugins/nucleo/css/nucleo.css" rel="stylesheet" />
  <link href="${pageContext.request.contextPath }/resource/js/plugins/@fortawesome/fontawesome-free/css/all.min.css" rel="stylesheet" />
  <!-- CSS Files -->
  <link href="${pageContext.request.contextPath }/resource/css/argon-dashboard.css?v=1.1.2" rel="stylesheet" />
  <link href="${pageContext.request.contextPath }/resource/assets/test.css"/>
</head>
<style>
</style>
<body class="bg-gradient-primary">
  <div class="main-content">
<div class="header bg-gradient-primary py-7 py-lg-8">
      <div class="container">
        <div class="header-body text-center mb-7">
        </div>
      </div>
      <div class="separator separator-bottom separator-skew zindex-100">
        <svg x="0" y="0" viewBox="0 0 2560 100" preserveAspectRatio="none" version="1.1" xmlns="http://www.w3.org/2000/svg">
          <polygon class="fill-default" points="2560 0 2560 100 0 100"></polygon>
        </svg>
      </div>
    </div>
    <!-- Page content -->
    <div class="container mt--8 pb-5">
      <div class="row justify-content-center">
        <div class="col-lg-5 col-md-7">
          <div class="card bg-secondary shadow border-0">
            <!-- <div class="card-header bg-transparent pb-5"> -->
              <div class="text-muted text-center mt-2 mb-3" style="padding-top: 14px;"><small><img src="${pageContext.request.contextPath }/resource/img/brand/coma.jpg" style="width: 120px; height: 28px;"></img></small></div>
              <div class="card-body px-lg-5 py-lg-5">
              <!-- <div class="text-center text-muted mb-4">
                <small>Or sign in with credentials</small>
              </div> -->
              <form action="${pageContext.request.contextPath }/logintest" method="post" role="form">
                <div class="custom-control custom-control-alternative custom-checkbox" style="margin-bottom: 14px;">
                
                  <input class="custom-control-input remember-me" 
                  name="rememberck" id=" customCheckLogin" type="checkbox">
                  <label class="custom-control-label" for=" customCheckLogin">
                    <span class="text-muted" style="text-align: center">로그인 유지</span>
                  </label>
                </div>
                <div class="form-group mb-3">
                  <div class="input-group input-group-alternative">
                    <div class="input-group-prepend">
                      <span class="input-group-text"><i class="ni ni-email-83"></i></span>
                    </div>
                    <input class="form-control" placeholder="아이디" type="text" name="username">
                  </div>
                </div>
                <div class="form-group" style="margin-bottom: 10px;">
                  <div class="input-group input-group-alternative">
                    <div class="input-group-prepend">
                      <span class="input-group-text"><i class="ni ni-lock-circle-open"></i></span>
                    </div>
                    <input class="form-control" placeholder="패스워드" type="password" name="password">
                  </div>
                </div>
                
                <div class="text-center">
                  <button  class="btn btn-primary my-4" style="width: 350px; height: 51.6px;">로그인</button>
                </div>
              </form>
            </div>
          </div>
          <div class="row mt-3" style="justify-content: center;">
            <div class="col-6" style="text-align: center;">
              <a href="#" class="text-light" data-toggle="modal" data-target="#modal-default"><small>계정에 문제가 생기셨나요?</small></a>
            </div>
            <!-- <div class="col-6 text-right">
              <a href="#" class="text-light"><small>Create new account</small></a>
            </div> -->
          </div>
        </div>
      </div>
    </div>
    <footer class="py-5">
      <div class="container">
      </div>
    </footer>
  </div>
  
  <!-- modal -->
  <div class="row">
	  <div class="col-md-4">
	     
	      <div class="modal fade" id="modal-default" tabindex="-1" role="dialog" aria-labelledby="modal-default" aria-hidden="true">
		    <div class="modal-dialog modal- modal-dialog-centered modal-">
		       	 <div class="modal-content">
			        	
			            <div class="modal-header">
				                
				                
			            </div>
			            
		           		<div class="modal-body" id="take_line" style="align-self: center;">
		           		 		<h2 class="modal-title" id="modal-title-default">관리자에게 문의하세요</h2>
		           		</div>
			            
			            <div class="modal-footer" style="align-self: center;">
			                <button type="button" onclick="line_end();"  data-dismiss="modal" aria-label="Close" class="btn btn-primary ml-auto">확인</button>
			            </div>
			            
			        </div>
			    </div>
			</div>
	    </div>
	</div>	
  
  
  
  <!--   Core   -->
  <script src="${pageContext.request.contextPath }/resource/js/plugins/jquery/dist/jquery.min.js"></script>
  <script src="${pageContext.request.contextPath }/resource/js/plugins/bootstrap/dist/js/bootstrap.bundle.min.js"></script>
  <!--   Optional JS   -->
  <!--   Argon JS   -->
  <script src="${pageContext.request.contextPath }/resource/js/argon-dashboard.min.js?v=1.1.2"></script>
  <script src="https://cdn.trackjs.com/agent/v3/latest/t.js"></script>
  <script>
  const path = '${pageContext.request.contextPath }';
  
    window.TrackJS &&
      TrackJS.install({
        token: "ee6fab19c5a04ac1a32a645abde4613a",
        application: "argon-dashboard-free"
      });
    
    //* * 로그인유지 체크박스 데이터 */
   /*  const data = {
            remember_me: document.getElementById('customCheckLogin').checked,
        };
    
        fetch(path+'/security', {
    	method: 'POST',
    	headers: {
            'Content-Type': 'application/json',
        },
        body: JSON.stringify(data), 
    })
    .then(response => response.json()); */
    
    
        
  </script>
</body>

</html>