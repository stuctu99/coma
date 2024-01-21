const fn_docType = function(value){
	
	$('#docType').val(value);
	
	
	document.getElementById("leave").style.display= "none";
	document.getElementById("cash").style.display= "none";
	document.getElementById("req").style.display= "none";
	document.getElementById("etc").style.display= "none";

	document.getElementById(value).style.display="block";
}
  
  	
const fn_leaveType = function(value){
	
	$('#leaveType').val(value);

}

/* ----------------------- 에디터 생성 ----------------------- */
  	
const editor = new toastui.Editor({
    el: document.querySelector('#content'), // 에디터를 적용할 요소 (컨테이너)
    height: '500px',                        // 에디터 영역의 높이 값 (OOOpx || auto)
    initialEditType: 'wysiwyg',     // 내용의 초기 값으로, 반드시 마크다운 문자열 형태여야 함
    previewStyle: 'vertical'                // 마크다운 프리뷰 스타일 (tab || vertical)
});

/* ---------------------- 전체 데이터 + 에디터 데이터 넘기기 ----------------------- */

function submitForm() { //input type="button"

    const editorContentInput = document.getElementById('editorContent'); //hidden input
    const markdownContent = editor.getMarkdown(); //입력한 값
    
       console.log('Markdown Content:', markdownContent); 
         if (!markdownContent) {
        alert('Markdown 내용을 입력하세요.'); // 또는 다른 사용자에게 보여줄 메시지
        return; // 폼 제출을 중지
    }
    
    editorContentInput.value = markdownContent; //hidden input에 입력 값 넣기
    
    const editorForm = document.getElementById('app_form'); //form태그
    
    
    
    // required가 적용이 안돼서 직접 분기처리 
      
     if(!$('#docType').val()){
		   alert("문서 종류를 선택하세요.");
		   return false; //제출 금지
		   
	 }else if(!$('#ck_title').val()){
		   alert("제목을 입력하세요.");
		   return false; //제출 금지
	 }else if(!$('#ck_appr').val()){
		   alert("결재자를 입력하세요.");
		   return false; //제출 금지
	 }
    
    
    editorForm.submit(); //form submit
}


/* ----------------------- 파일 첨부 ----------------------- */

const addDelFunction=(function(){
	let count=2;
	const addFile=()=>{
		if(count<=3){
			const fileForm = $("#basicFileForm").clone(true);
			fileForm.find(".custom-file-label").text("");
			fileForm.find(".file_span").text("첨부파일 " + count);
			$(".btn_container").before(fileForm);
			count++; 
		}else{
			alert("첨부파일은 3개까지 추가 가능합니다.");
		}
		
	};
	const delFile=()=>{
		if(count!=2){
			$(".btn_container").prev().remove();
			count--;
		}
		
	};
	
	return [addFile, delFile];
	
})();
    
const fn_addFileForm=addDelFunction[0];
const fn_deleteFileForm=addDelFunction[1];

//파일이름

$(document).on("change",".custom-file-input",(e=>{
	
	const fileName = e.target.files[0].name;
	console.log(fileName)
	$(e.target).next(".custom-file-label").text(fileName);
	
}));

/*-----------------------  결재자 검색을 위한 datalist ----------------------- */


const searchAppInput = document.querySelector("#search_app");

searchAppInput.addEventListener("keyup",(()=>{
	let requestFunc; //closure
	return e=>{
		
		if(requestFunc){
			clearTimeout(requestFunc);
		}
		requestFunc = setTimeout(()=>{
			fetch("/approval/apprline?data="+e.target.value)
			.then(result=>result.text())
			.then(data=>{
				
				$('.app_op').remove();			
				JSON.parse(data).forEach(e=>{
					/* datalist 옵션태그 만들기 */
				
					const search_op = $('<option class="app_op">');

					search_op.val(e.empId + " "+ e.empName+" "+e.dept.deptType+" "+e.job.jobType);
					
					
					$("#search_list1").append(search_op);
				
				});
				
				
			});
		
	},800);
			}
})());


/* ----------------------- 결재자 추가, 삭제 ----------------------- */
const app_all_arr = [];
const app_id_arr = [];
const app_name_arr = [];
const app_dept_arr = [];
const app_job_arr = [];


const addDelAppr=(function(){
	
	let appr_num=0; // n번째 결재자. id, name 뒤에 붙음 
	
	
	const addAppr=()=>{
					
				const emp = $('#search_app').val(); // id + name + dept + job 
	
		
				const emp_arr = emp.split(" ");

				const emp_id = emp_arr[0]
				const emp_name = emp_arr[1];
				const emp_dept = emp_arr[2];
				const emp_job = emp_arr[3];
			
	
			
			/*적힌 값과 선택한 값 일치하는지 비교*/
				if($('#search_app').val()==emp_id+" "+emp_name+" "+emp_dept+" "+emp_job){ //수정 필요
					
					/* 중복 결재자 있는지 확인 */
					if(!app_all_arr.includes($('#search_app').val())){
					
						/* 추가한 결재자 3명 이하인지 확인 */
						if(appr_num<=2){
							const btn_tag = $('<button type="button" class="btn btn-secondary" id="app_fix'+appr_num +'"'
												+ 'data-container="body" data-toggle="popover" data-color="secondary"'
												+ 'name="app_fix'+appr_num +'"'+'data-placement="top">');
							const i_tag = $('<i class="ni ni-fat-remove" style="cursor:pointer" onclick="delAppr(this);">');
							
					
							app_all_arr.push(emp);
							app_id_arr.push(emp_id);
							app_name_arr.push(emp_name);
							app_dept_arr.push(emp_dept);
							app_job_arr.push(emp_job);
							
							
							
							btn_tag.text(emp_id +" "+ emp_name);
							btn_tag.attr('data-content',emp_dept+" "+emp_job);


							
							$('.appr_container').append(btn_tag);
							$('.appr_container').append(i_tag);
						
							btn_tag.popover();
							 /* 부트스트랩은 js를 사용하여 동적으로 웹 페이지를 조작하고 업데이트하기때문에 
				            동적으로 생성된 요소에 대해서는 초기화 작업이 필요.*/
							appr_num++;
	
							let appr_result = $('.appr_result'); // hidden input
							
							for(let i=0; i<app_all_arr.length; i++){ //배열 길이만큼 반복
								appr_result[i].value = app_all_arr[i]; // hidden input의 value에 배열 값 넣기
							
							}
							
							
							$('#search_app').val("");
						}else{
							
							alert("결재자는 3명까지 추가 가능합니다.");
						}
					
					}else{
						alert("이미 추가된 결재자입니다.");
					}
				
				
				}else{
					alert("없는 사원입니다.");
				}
				
			
			
		
	}; 
	
	const delAppr=(element)=>{ // element : 삭제 icon 
		if(appr_num!=0){
			
			const btn = $(element).prev(); 
			
			if(btn.data('bs.popover')){ 
				/* data()메소드를 사용하여 요소에 연결된 데이터를 가져옴.
					-> 해당 요소에 popver가 초기화되었는지 확인.
				   bs.popver 데이터가 존재하면 초기화된 것.
					-> popver('dispose')호출해 popver 제거. */
				btn.popover('dispose');
			}
				

					
				const del_name = btn.text();
				
				const del_type = btn.attr('data-content');
				
			
				for(let i=0; i<app_all_arr.length; i++){   // 추가된 결재자 배열의 길이만큼 반복 
					if(app_all_arr[i]===del_name+" "+del_type){ // 배열 안에 선택한 값과 일치하는 값이 있는지 
						app_all_arr.splice(i, 1); // i 인덱스에서 1개 요소 제거 
						i--; // 현재 인덱스에서 다시 검사 
					}
				}

				let appr_result = $('.appr_result'); // hidden input
					
				for(let i=0; i<app_all_arr.length; i++){ // 배열의 길이만큼 반복 
				
					appr_result[i].value = app_all_arr[i]; // hidden input의 value에 배열 값 넣기
				
				}

	
			for(let i=app_all_arr.length; i<3; i++){ //배열길이부터 ~ hidden 개수 전까지 비워주기
				appr_result[i].value=""; 
			}

			// 서버로 값 보낼때는 app_all_arr 파싱해서 보내기 
		
			btn.remove();
			$(element).remove();
		
			appr_num--;

		
		}
		
	}
	return [addAppr, delAppr];
	
})();

const addAppr=addDelAppr[0];
const delAppr=addDelAppr[1];

	

/*-----------------------  참조자 검색을 위한 datalist ----------------------- */

document.querySelector("#search_ref").addEventListener("keyup",(()=>{
			
	let requestFunc; //closure
	return e=>{
		
		if(requestFunc){
			clearTimeout(requestFunc);
			
		}
		requestFunc = setTimeout(()=>{
			fetch("/approval/apprline?data="+e.target.value)
			.then(result=>result.text())
			.then(data=>{
				$('.ref_op').remove();	
				
				JSON.parse(data).forEach(e=>{
					//datalist 옵션 태그 만들기
				
					const search_op = $('<option class="ref_op">');
					search_op.val(e.empId+" "+e.empName+" "+e.dept.deptType+" "+ e.job.jobType);
					 $('#search_list2').append(search_op);
						

				});
			});
		
	},800);
			}
})());



/* ----------------------- 참조자 추가, 삭제 -----------------------  */

const ref_id_arr = [];
const ref_name_arr = [];
const ref_dept_arr = [];
const ref_job_arr = [];
const ref_all_arr = [];

const addDelref=(function(){
	let ref_num=0; //n번째 참조자. id, name 뒤에 붙음.
	
	const addref=()=>{

				const emp = $('#search_ref').val(); //id + name + dept + job 
	
				const emp_arr = emp.split(" ");
				
				const emp_id = emp_arr[0]
				const emp_name = emp_arr[1];
				const emp_dept = emp_arr[2];
				const emp_job = emp_arr[3];
			
			/*적힌 값과 선택한 값 일치하는지 비교*/
				if($('#search_ref').val()==emp_id+" "+emp_name+" "+emp_dept+" "+emp_job){ //수정 필요
					
					/* 중복 참조자 있는지 확인 */
					if(!ref_all_arr.includes($('#search_ref').val())){
					
						/* 추가한 참조자 3명 이하인지 확인 */
						if(ref_num<=3){
							const ref_btn_tag = $('<button type="button" class="btn btn-secondary" id="ref_fix'+ref_num +'"'
												+ 'data-container="body" data-toggle="popover" data-color="secondary" data-placement="top">');
							const ref_i_tag = $('<i class="ni ni-fat-remove" style="cursor:pointer" onclick="delref(this);">');
							
							console.log("idddd: "+emp_id);
					
							ref_all_arr.push(emp);
							ref_id_arr.push(emp_id);
							ref_name_arr.push(emp_name);
							ref_dept_arr.push(emp_dept);
							ref_job_arr.push(emp_job);
							
							ref_btn_tag.text(emp_id+" "+emp_name);
							ref_btn_tag.attr('data-content',emp_dept+" "+emp_job);

							
							$('.ref_container').append(ref_btn_tag);
							$('.ref_container').append(ref_i_tag);
						
							ref_btn_tag.popover();
							ref_num++;

							let ref_result = $('.ref_result'); // hidden input
							
							for(let i=0; i<ref_all_arr.length; i++){ //배열 길이만큼 반복
								ref_result[i].value = ref_all_arr[i]; // hidden input의 value에 배열 값 넣기
							
							}
							

							$('#search_ref').val("");
						}else{
							
							alert("참조자는 3명까지 추가 가능합니다.");
						}
					
					}else{
						alert("이미 추가된 참조자입니다.");
					}
				
				
				}else{
					alert("없는 사원입니다.");
				}
				
			
			
		
	}; 
		
	
	const delref=(element)=>{ /* element : 삭제 icon */
		if(ref_num!=0){
			
			const btn = $(element).prev(); 
			
			if(btn.data('bs.popover')){ 
				btn.popover('dispose');
			}
				

					
				const del_ref_name = btn.text();

				const del_ref_type = btn.attr('data-content');
			
				for(let i=0; i<ref_all_arr.length; i++){
					if(ref_all_arr[i]===del_ref_name+" "+del_ref_type){
						ref_all_arr.splice(i, 1);
						i--;
					}
				}
				
			let ref_result = $('.ref_result'); //hidden input
			
			for(let i=0; i<ref_all_arr.length; i++){ //추가된 참조자 배열 길이만큼 반복
				ref_result[i].value = ref_all_arr[i]; //hidden input의 value에 배열 값 넣기
				
			}
			
			for(let i=ref_all_arr.length; i<3; i++){ //배열 길이부터 ~ hidden개수 전까지
				ref_result[i].value=""; //비워주기
				
			}

			// 서버로 값 보낼때는 ref_all_arr 파싱해서 보내기 
		
			btn.remove();
			$(element).remove();
		
		
			
			ref_num--;
		}
		
	}
	return [addref, delref];
	
})();

const addref=addDelref[0];
const delref=addDelref[1];


// ---------------------- 자주 쓰는 결재선 저장 ---------------------------

const save_appr=()=>{
/*	$(".save_appr").show();
	$("#save_btn").hide();*/
	
//	localStorage.clear();
	
	let apprListNum =""; //루프 밖에서 초기화 
	let apprList = []; 
	
	// 수정 필요
	for(let i=0; i<$(".appr_result").length; i++){	
		 
		
		if($('input[name="appr_result[]"]')[i].value){
				apprList.push($('input[name="appr_result[]"]')[i].value);
				apprListNum += (i+1)+". " + apprList[i] + "\n";
		} 
	}

	console.log(apprList);

	let lineName = prompt(apprListNum, '결재선 이름을 설정하세요.');
	
	localStorage.setItem(lineName, apprList);
	
	let test = localStorage.getItem(lineName); 
	
//	console.log("localStorage.getItem(lineName): "+ test);
	let all_appr_line = "";

}


const cancel_appr=()=>{ // 결재선 저장 취소
	$("#save_btn").show();
	$(".save_appr").hide();
	
	
}

const line_submit=()=>{ //결재선 저장 submit
	
	
}


// ------------------------ 결재선 불러오기 ------------------------
let selectedRadio = '';

const take_line=()=>{
	
	let all_appr_line = "";

	let radioContainer = $('#take_line');


	radioContainer.empty();
	
	for(let i=0; i<window.localStorage.length; i++){ //전체 결재선 정보
	
		const line_key = window.localStorage.key(i);
		const line_val = window.localStorage.getItem(line_key);
	 	all_appr_line += line_key + " : "+ line_val + "\n";

	//localStorage key값 분기처리
	if (line_key !== null && line_key !== 'TOAST UI editor for localhost: Statistics' && line_key !== 'null') {
			radioContainer.append(
				$('<label>').text(line_key).append(
					$('<input>').attr({
						type: 'radio',
						name: 'line_radio',
						value: line_key
					})
				)
				
			).append('<br>');

		}
	}
	

	
}


const line_end=()=>{
	
	selectedRadio = $('input[name="line_radio"]:checked').val(); 
	
	let selected_line = localStorage.getItem(selectedRadio);
	
//	console.log("line", selected_line);
	
	let selected_line_arr = selected_line.split(',');
	
//	console.log("arr", selected_line_arr);
	
	// 버튼 생성 ----------
	
	for (let i = 0; i < selected_line_arr.length; i++) {
		
		const emp = selected_line_arr[i];

		const emp_arr = emp.split(" ");

		const emp_id = emp_arr[0]
		const emp_name = emp_arr[1];
		const emp_dept = emp_arr[2];
		const emp_job = emp_arr[3];
		
		const btn_tag = $('<button type="button" class="btn btn-secondary"'
												+ 'data-container="body" data-toggle="popover" data-color="secondary"'
												+ 'name="app_fix"'+'data-placement="top">');
//							const i_tag = $('<i class="ni ni-fat-remove" style="cursor:pointer" onclick="delAppr(this);">');
							
					
							app_all_arr.push(emp); //배열에 추가
							app_id_arr.push(emp_id);
							app_name_arr.push(emp_name);
							app_dept_arr.push(emp_dept);
							app_job_arr.push(emp_job);
							
							
							
							btn_tag.text(emp_id +" "+ emp_name);
							btn_tag.attr('data-content',emp_dept+" "+emp_job);


							
							$('.appr_container').append(btn_tag);
//							$('.appr_container').append(i_tag);
						
							btn_tag.popover();
							 /* 부트스트랩은 js를 사용하여 동적으로 웹 페이지를 조작하고 업데이트하기때문에 
				            동적으로 생성된 요소에 대해서는 초기화 작업이 필요.*/
				
							let appr_result = $('.appr_result'); // hidden input
							
							for(let i=0; i<app_all_arr.length; i++){ //배열 길이만큼 반복
								if(appr_result[i]) 
									appr_result[i].value = app_all_arr[i]; // hidden input의 value에 배열 값 넣기
							
							}

							
//							console.log("불러오기 후 확인", $('.appr_result').val());
							$('#search_app').val("");
							$('#modal-default').modal('hide'); //모달창 닫기
	}
	
	// 결재선 불러오기 버튼 -> 리셋 버튼
	$('#take_btn').remove();
	$('#reset_btn').show();
	
	
}


fn_reset=()=>{
	
	const btn_tag = $('<button type="button" id="take_btn" onclick="take_line();" class="btn btn-block btn-primary mb-3" data-toggle="modal" data-target="#modal-default">결재선 불러오기</button>');
	
	//리셋 버튼 -> 결재선 불러오기 버튼
	$('input[name="app_fix"]').remove();
	$('#reset_btn').hide();
	$('.remake').prepend(btn_tag);
	$('.appr_container').empty();
	

	let appr_result = $('.appr_result');

	for (let i=0; i < app_all_arr.length; i++) {
	    
	appr_result[i].value = ""; //hidden input 비워주기
	
	console.log("222: ",  appr_result[i].value);
		
	}

	for (let i = app_all_arr.length - 1; i >= 0; i--) { //배열 값 삭제
	    app_all_arr.pop(); // 역순으로 pop 호출
	    
		console.log("111: ", app_all_arr[i]);
	}
	
	


}


	