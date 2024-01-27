$(".sub-menu li a").mouseenter(function (e) {
      console.log(e.target);
      $(e.target).css('backgroundColor', '#5e72e4').css("color", "white");
    })
    $(".sub-menu li a").mouseleave(function (e) {
      console.log(e.target);
      $(e.target).css('backgroundColor', 'white').css("color", "#5e72e4");
    })

    $(".nav-item").on("mouseenter", function (e) {

      $(this).css("cursor", "pointer");
})

/*$("#messenger-btn").click(function(){
	${pageContext.request.contextPath}
	open("/messenger","_blank","width=550px; height=600px;");
})
*/
  
const messenger_active = (path) => {
	const url = path+"/messenger";
	const windowName = "messenger";
	const options = "resizeable=no, width=600, height=650, top=10,scrollbars=yes";
	
	window.open(url,windowName,options);
	/*open(path+"/messenger","_blank","width=600px; height=600px; left=0px; top=0px;");*/
	
}
    