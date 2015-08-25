$(function(){
	$("#filemanage").click(function (){showManager('filemanager')});
	$("#photomanage").click(function (){showManager('photomanager')});
	$("#hidden_helper").click(function (){hideHelper()});
	$(".closemanager").click(function (){hideHelper()});
	$("#additiontoggle").click(function (){$("#addition").toggle(); $(this).find("span").toggle();});
	$(".deleteimg").click(function(){deleteimg($(this).attr('deleteimg'))});
	$(".deletefile").click(function(){deletefile($(this).attr('deletefile'))});



      // Initialize the jQuery File Upload widgets:
      $('#new_photo').fileupload({
		dataType: 'script'
	});

	$('#new_file').fileupload({
		dataType: 'script'
	});

});

function showManager (manager) {
		$("#hidden_helper").css({"height": document.body.clientHeight });
		$("#hidden_helper").show();
		$("#"+manager).show();
	};

function hideHelper () {
	$("#hidden_helper").hide();
	$("#filemanager").hide();
	$("#photomanager").hide();
};

function toggleAddition (){
	$("#addition").toggle();
};

function deleteimg (id) {
	$.ajax({
		url: '/clients/deletephoto',
		type: 'POST',
		beforeSend: function(xhr) {xhr.setRequestHeader('X-CSRF-Token', $('meta[name="csrf-token"]').attr('content'));},
		data: 'id='+id,
		//dataType: "json",
		success: function(){
			console.log("Success!");
			var thisname = "#photoprw_"+id
			console.log($(thisname));
			$(thisname).remove();
			var photosnumber = $("#photosnumber").text();
			photosnumber = parseInt(photosnumber);
			$("#photosnumber").text(photosnumber-1);
		}
		//error: function(){alert("Возникла ошибка!");}
	});
}

function deletefile (id) {
	$.ajax({
		url: '/clients/deletefile',
		type: 'POST',
		beforeSend: function(xhr) {xhr.setRequestHeader('X-CSRF-Token', $('meta[name="csrf-token"]').attr('content'));},
		data: 'id='+id,
		//dataType: "json",
		success: function(){
			console.log("Success!");
			var thisname = "#file_"+id
			//console.log($(thisname));
			$(thisname).remove();
			var filesnumber = $("#filesnumber").text();
			filesnumber = parseInt(filesnumber);
			$("#filesnumber").text(filesnumber-1);
		}
		//error: function(){alert("Возникла ошибка!");}
	});
}