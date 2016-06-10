$(function(){
	$(".toggle_editor").click(toggleEditor);
	$(".filter_btn").click(toggleAdminFilter);
	$(".filter_choice").click(filterChoice);

	$(".send_ajax").bind("ajax:beforeSend", function(){
		$("#flash_container").append("<div id='flash' class='flash flash_notice' style='visibility: visible;' >Отправка письма...подождите.<a href='' id='flash_close'>Закрыть</a></div>");
	});

	$(".number_format").on("keyup", function(event){
		if (event.key == ",") {
			str = $(this).val();
			$(this).val(str.replace(/,/, "."));
		}
	});
	$(".number_format").on("focusout", function(){
		str = $(this).val();
		$(this).val(str.replace(/,/, "."));
	});
});

function toggleEditor (){
	$(".hide_editor").toggle();
	$(".no_hide_editor").toggle();
};

function toggleAdminFilter (){
	$(".hidden_filter").toggle();
};

function filterChoice () {
	// var filter = $(this).attr("data-choice");
	$(".filter_btn").text($(this).text());
	$(".hidden_filter").hide();
	
	// alert(filter);
}