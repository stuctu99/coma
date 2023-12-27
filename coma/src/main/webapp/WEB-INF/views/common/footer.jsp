<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
  <!--   Core   -->
  <script src="/resource/js/plugins/jquery/dist/jquery.min.js"></script>
  <script src="/resource/js/plugins/bootstrap/dist/js/bootstrap.bundle.min.js"></script>
  <!--   Optional JS   -->
  <script src="/resource/js/plugins/chart.js/dist/Chart.min.js"></script>
  <script src="/resource/js/plugins/chart.js/dist/Chart.extension.js"></script>
  <!--   Argon JS   -->
  <script src="/resource/js/argon-dashboard.min.js?v=1.1.2"></script>
  <script src="https://cdn.trackjs.com/agent/v3/latest/t.js"></script>
  <script src="/resource/js/coma-index.js"></script>
  <script>
    window.TrackJS &&
      TrackJS.install({
        token: "ee6fab19c5a04ac1a32a645abde4613a",
        application: "argon-dashboard-free"
      });
      $(".nav-item").click(function (e) {
      const item = $(this).children("ul");
      console.log(item);
      item.slideToggle(500);
    })
  </script>
</body>

</html>