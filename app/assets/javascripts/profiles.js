$(document).ready(function() { 
	$(".btn-pref .btn").click(function () { 
		$(".btn-pref .btn").removeClass("btn-primary").addClass("btn-default"); 
		$(".tab").addClass("active");
		$(this).removeClass("btn-default").addClass("btn-primary"); 
	}); 
});