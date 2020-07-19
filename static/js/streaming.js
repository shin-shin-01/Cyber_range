$(function() {
	setInterval(function(){
              var img_path = "static/img/streaming.jpg?t="+jQuery.now();
              $("#monitor").attr("src", img_path);
            },1000);
	
	var ROTATION_STEP = 20;
	$("#left-arrow").on('click', function () {
		var angle = $("#angle").text()
		angle = parseInt(angle);
		if (30 <= angle-ROTATION_STEP) {
			$.get("/operation?p=-"+ROTATION_STEP, function(data){
				$("#angle").text(data);
			});
		}
	})
	$("#right-arrow").on('click', function () {
		var angle = $("#angle").text()
		angle = parseInt(angle);
		if (angle+ROTATION_STEP <= 150) {
			$.get("/operation?p="+ROTATION_STEP, function(data){
				$("#angle").text(data);
			});
		}
	})
})
