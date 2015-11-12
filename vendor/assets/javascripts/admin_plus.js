$(function(){
	$(".toggle_editor").click(toggleEditor);
	$(".filter_btn").click(toggleAdminFilter);
	$(".filter_choice").click(filterChoice);
});

function toggleEditor (){
	$(".hide_editor").toggle();
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