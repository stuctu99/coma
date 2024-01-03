const docType = function(value){
	
	console.log(value);
	
	document.getElementById("leave").style.display= "none";
	document.getElementById("cash").style.display= "none";
	document.getElementById("req").style.display= "none";
	document.getElementById("etc").style.display= "none";

	document.getElementById(value).style.display="block";
}
  
  	
const leave_type = function(value){
	
	document.getElementById("half_leave").style.display="none";
	
	document.getElementById(value).style.display="block";
}
  	
const editor = new toastui.Editor({
    el: document.querySelector('#content'), // 에디터를 적용할 요소 (컨테이너)
    height: '500px',                        // 에디터 영역의 높이 값 (OOOpx || auto)
    initialEditType: 'wysiwyg',     // 내용의 초기 값으로, 반드시 마크다운 문자열 형태여야 함
    previewStyle: 'vertical'                // 마크다운 프리뷰 스타일 (tab || vertical)
});


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


$(document).on("change",".custom-file-input",(e=>{
	
	const fileName = e.target.files[0].name;
	console.log(fileName)
	$(e.target).next(".custom-file-label").text(fileName);
	
}));


document.querySelector("#search_app").addEventListener("keyup",(()=>{
	let requestFunc; //closure
	return e=>{
		
		if(requestFunc){
			clearTimeout(requestFunc);
			
		}
		requestFunc = setTimeout(()=>{
			fetch("/approval/approver?data="+e.target.value)
			.then(result=>result.text())
			.then(data=>{
				$('option').remove();			
				JSON.parse(data).forEach(e=>{
					/* datalist 옵션태그 만들기 */
				
					/*console.log(e.empName);*/
					const search_op = $('<option>');
					search_op.val(e.empName+" "+e.dept.deptType + e.job.jobType);
					
					 $('#serach_list').append(search_op);
					
				});
			});
		
	},800);
			}
})());


document.querySelector("#search_ref").addEventListener("keyup",(()=>{
			
	let requestFunc; //closure
	return e=>{
		
		if(requestFunc){
			clearTimeout(requestFunc);
			
		}
		requestFunc = setTimeout(()=>{
			fetch("/approval/approver?data="+e.target.value)
			.then(result=>result.text())
			.then(data=>{
				$('option').remove();	
				
				JSON.parse(data).forEach(e=>{
		
				/*	console.log(e.dept.deptType + e.job.jobType);*/
					const search_op = $('<option>');
					search_op.val(e.empName+" "+e.dept.deptType + e.job.jobType);
					 $('#serach_list2').append(search_op);
						

				});
			});
		
	},800);
			}
})());

const addDelAppr=(function(){
	let appr_num=1;
	
	const addAppr=()=>{
		if(appr_num<=3){
			const btn_tag = $('<button type="button" class="btn btn-secondary" id="app_fix'+appr_num +'"'
								+ 'data-container="body" data-toggle="popover" data-color="secondary" data-placement="top">');
			const i_tag = $('<i class="ni ni-fat-remove" style="cursor:pointer" onclick="delAppr(this);">');
			
			const emp = $('#search_app').val();
			const emp_arr = emp.split(" ");
			
			const emp_name = emp_arr[0];
			const emp_type = emp_arr[1];
		
			
			btn_tag.text(emp_name);
			console.log(emp_type)
			btn_tag.attr('data-content',emp_type);
			/*btn_tag.setAttribute('data-content',emp_type);*/
			
			$('.appr_container').append(btn_tag);
			$('.appr_container').append(i_tag);
		
			btn_tag.popover();
			 /* 부트스트랩은 js를 사용하여 동적으로 웹 페이지를 조작하고 업데이트하기때문에 
            동적으로 생성된 요소에 대해서는 초기화 작업이 필요.*/
			appr_num++;
		}else{
			
			alert("결재자는 3명까지 추가 가능합니다.");
		}
		
	}; 
	
	const delAppr=(element)=>{ /* element : 삭제 icon */
		if(appr_num!=1){
			
			const btn = $(element).prev(); 
			
			if(btn.data('bs.popover')){ 
				/* data()메소드를 사용하여 요소에 연결된 데이터를 가져옴.
				-> 해당 요소에 popver가 초기화되었는지 확인.
				bs.popver 데이터가 존재하면 초기화된 것.
				-> popver('dispose')호출해 popver 제거. */
				btn.popover('dispose');
			}
			
			btn.remove();
			$(element).remove();
		
			
			appr_num--;
		}
		
	}
	return [addAppr, delAppr];
	
})();

const addAppr=addDelAppr[0];
const delAppr=addDelAppr[1];
	
/*	$('.app_btn').on("click", function(){
		
		let app_num=1;
		 
		
		const i_tag = $('<i class="ni ni-fat-remove">');
		const btn_tag = $('<button type="button" class="btn btn-secondary" id="app_fix'+app_num +'"'
							+ 'data-container="body" data-toggle="popover" data-color="secondary" data-placement="top">');
		
		const emp = $('#search_app').val();
		const emp_arr = emp.split(" ");
		
		const emp_name = emp_arr[0];
		const emp_type = emp_arr[1];
	
		
		btn_tag.text(emp_name);
		console.log(emp_type)
		btn_tag.attr('data-content',emp_type);
		btn_tag.setAttribute('data-content',emp_type);
		
		$('.appr_container').append(i_tag);
		$('.appr_container').append(btn_tag);
	
		btn_tag.popover();
	
		app_num++;
		
		}
	
})();
*/
	
	
	