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