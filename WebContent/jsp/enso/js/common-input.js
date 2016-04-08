$(document).ready(function(){
	$("input[type='radio']:checked").closest("label").addClass("selected");
	$("input[type='checkbox']:checked").closest("label").addClass("selected");
});
$(document).ready(function(){
	$(".frm_radio_label").click(function(){
		if($(this).hasClass("selected")){
			$(this).find("input[type='checkbox']").attr("checked",false);
			$(this).removeClass("selected");
		}else{
			$(this).addClass("selected");
			$(this).find("input[type='checkbox']").attr("checked",true);
		}
	});
});
$(document).ready(function(){
	$(".radio").click(function(){
		if(!$(this).hasClass("selected")){
			$(this).siblings().each(function(){
				$(this).removeClass("selected");
				$(this).find("input[type='radio']").attr("checked",false);
			});
			$(this).addClass("selected");
			$(this).find("input[type='radio']").attr("checked",true);
		}
	});
});
function checkPhone(str) {
   var re = /^1\d{10}$/
   if (re.test(str)) {
      return true;
   } else {
       return false;
   }
}
function checkEmail(str){
   var re = /^(\w-*\.*)+@(\w-?)+(\.\w{2,})+$/
   if(re.test(str)){
	   return true;
   }else{
	   return false;
   }
}