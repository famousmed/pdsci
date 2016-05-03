<script>
$(document).ready(function(){
	$(".faqscene_close").click(function(){
	    $(".js_faq_main_panel").css({
	        display: 'none'
	    });
	});

	$(".js_faq_trigger").mouseover(function(){
	    $(".js_faq_main_panel").show();
	});
	
	var dropDiv = $('.faqscene_panel');
	dropDiv.on('click',function(e){e.stopPropagation();});
	dropDiv.on('click',function(){
		$(this).find(".faqscene_panel").stop().show();
    });
    $(document).on('click',function(){$(".faqscene_panel").hide();});
});
function showContent(contentid,obj){
	$(".js_faqscene_content").hide();
	$("#"+contentid).show();
	
	
	$(".active").removeClass("active");
	
}
$(function () {
	$("#inputForm input:text :first").focus();
    $("#inputForm input:text").keypress(function (e) {
        if (e.which == 13) {// 判断所按是否回车键  
            var inputs = $("#inputForm input:text"); // 获取表单中的所有输入框  
            var idx = inputs.index(this); // 获取当前焦点输入框所处的位置  
            if (idx == inputs.length - 1) {// 判断是否是最后一个输入框  
                if (jboxConfirm("最后一个输入框已经输入,是否提交?"),function(){
                }); // 用户确认  
            } else {
                inputs[idx + 1].focus(); // 设置焦点  
                inputs[idx + 1].select(); // 选中文字  
            }
            return false; // 取消默认的提交行为  
        }
    });
}); 

function expAll(){
	$(".caseDiv").show();
}
function cosAll(){
	$(".caseDiv").hide();
}
</script>
<div class="faqscene" id="js_faqscene_p">
	<div class="faqscene_inner">
		<div class="faqscene_name js_faq_trigger" style="margin-right:-25px;border-left-width: 0px;">录入帮助</div>
		<div class="faqscene_panel js_faq_main_panel" style="display: none;margin-right:8px;">
			<a href="###" class="faqscene_close">x</a>
			<div class="faqscene_hd">病例录入说明</div>
			<div class="faqscene_bd">
				<div class="faqscene_tabs">
					<div class="faqscene_tab_hd">
						<ul class="js_faq_class1">

							<li data-report-id="233"><a class="active"
								href="javascript:showContent('233',this);">填写说明</a></li>

							<li data-report-id="234"><a  href="javascript:showContent('234',this);">快速定位</a></li>

							<li data-report-id="235"><a href="javascript:showContent('235',this);">修改记录</a></li>

							<li data-report-id="236"><a href="javascript:showContent('236',this);">操作日志</a></li>

							<li data-report-id="237"><a href="javascript:;" class="to_top">返回顶部</a></li>

						</ul>
					</div>


					<div class="faqscene_tab_bd js_faqscene_content"
						style="display:block ;height: 173px;" id="233">
						<ul>


							<li><a target="_blank"
								href="javascript:void(0);">Enter/Tab 切换输入框</a></li>


							<li><a target="_blank"
								href="javascript:void(0);">保存后可继续修改数据</a></li>
							<li><a target="_blank"
								href="javascript:void(0);">提交后无法修改</a></li>
							<li><a target="_blank"
								href="javascript:void(0);">双份录入需全部录入一致才可以提交</a></li>
							<li><a target="_blank"
								href="javascript:void(0);">提交后的数据才可监查与统计</a></li>
						</ul>
					</div>


					<div class="faqscene_tab_bd js_faqscene_content"
						style="display:  none;overflow: auto;height: 173px;" id="234">
						<ul>
							<li><a href="javascript:cosAll();">全部收缩</a>&#12288;
							<a href="javascript:expAll();">全部展开</a>&#12288;
							<a href="javascript:;" class="to_top">返回顶部</a>
							</li>
						<c:forEach items="${sessionScope.projDescForm.visitModuleMap[currVisit.visitFlow]}" var="visitModule">
							<li><a href="javascript:scrollToModule('${visitModule.recordFlow }');">${visitModule.moduleName}</a></li>
						</c:forEach>
						</ul>
					</div>






					<div class="faqscene_tab_bd js_faqscene_content"
						style="display: none;overflow: auto;height: 173px;" id="235">
						<ul>


						</ul>
					</div>



					<div class="faqscene_tab_bd js_faqscene_content"
						style="display: none;overflow: auto;height: 173px;" id="236">
						<ul>

						</ul>
					</div>



				</div>
			</div>
			<div class="faqscene_ft">
				<c:if test="${edcPatientVisit.inputOperStatusId != edcInputStatusEnumSubmit.id}">
        				<a href="javascript:javascript:saveData('${edcInputStatusEnumSave.id}');" style="color: ;" class="btn btn_default btn_input">保&#12288;存</a>&#12288;
        				<a href="javascript:javascript:saveData('${edcInputStatusEnumSubmit.id }');" style="color: " class="btn btn_primary js_complete_bnt">提&#12288;交</a>
        				</c:if>
        				<c:if test="${edcPatientVisit.inputOperStatusId == edcInputStatusEnumSubmit.id}">
        				<a href="javascript:void(0);" style="color: " class="btn btn_primary js_complete_bnt">已提交</a>
        				</c:if>
			</div>
		</div>
	</div>
</div>
