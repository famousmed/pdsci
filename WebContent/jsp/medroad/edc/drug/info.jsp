<script>
$(document).ready(function(){
	$(".icon_msg_mini").on("mouseenter mouseleave",function(){
		$(this).parent().next("div").toggle();
		$(this).parent().next("div").css({"left":$(this).offset().left-245,"top":$(this).offset().top+15});
	});
	
	$(".popover").on("mouseenter mouseleave",function(){
		$(this).toggle();
	});
});
function drugInfo(drugFlow){
	jboxLoad("content","<s:url value='/medroad/drug/info'/>?drugFlow="+drugFlow,true);
}
</script>
<style>
.page_advanced_interface .agreement_box .tool_area{padding:.5em 0 1em}.page_advanced_interface .agreement_box .tool_bar{text-align:center;padding-left:0}.page_advanced_interface .agreement_box .tool_bar .btn{margin:0}.page_advanced_interface .frm_label{width:115px;}.page_advanced_interface .main_bd{padding:15px 30px}.page_advanced_interface .page_nav{margin-bottom:0}.page_advanced_interface .frm_desc{padding-bottom:40px}.page_advanced_interface .frm_input_box {width:530px;}.page_advanced_interface .key_input_box{width:350px}.page_advanced_interface .frm_tips{width:auto}.page_advanced_interface .msg_encrypt_type{padding-top:.3em;overflow:hidden}.page_advanced_interface .msg_encrypt_type dd{margin-top:5px}.page_advanced_interface .msg_encrypt_type .frm_tips{margin-left:19px}
</style>
<div class="main_hd">
	<h2>药物信息</h2>
	<div class="page_nav title_bottom">
        <a class="icon_goback" href="javascript:drugList();"></a>
		<a href="javascript:drugList();">药物信息</a>
		/
        ${drug.drugName }    </div>
</div>
<div class="main_bd page_advanced_interface">
	<form action="" id="form" class="form" novalidate="novalidate" style="margin-left: 50px;">
			<fieldset class="frm_fieldset">
			<p class="frm_desc">${drug.drugNote }</p>
				<div class="frm_control_group">
					<label for="token" class="frm_label">库存</label>
					<div class="frm_controls">
						<c:forEach items="${drugLotSurplusCountMap }" var="lotMap">
					${lotMap.key }&#12288;(${lotMap.value }${drug.minPackUnitName})&#12288;&#12288;
				</c:forEach>
				&nbsp;<a href="#">&#12288;申请配送</a>
						<p class="frm_tips">
						</p>
					</div>
				</div>
				<div class="frm_control_group">
				  <label for="url" class="frm_label">药品名称</label>
				  <div class="frm_controls">
					<span class="frm_input_box" ><input type="text"  name="drugName" value="${drug.drugName }" readonly="readonly" class="frm_input interface"></span>
                    <p class="frm_tips">
                       
                    </p>
				  </div>
				</div>
				<div class="frm_control_group">
					<label for="token" class="frm_label">规格</label>
					<div class="frm_controls">
						<span class="frm_input_box"><input type="text" id="spec" readonly="readonly" value="${drug.spec }" name="spec" class="frm_input interface"></span>
						<p class="frm_tips">
						</p>
					</div>
				</div>
				<div class="frm_control_group">
					<label for="token" class="frm_label">给药途径</label>
					<div class="frm_controls">
						<span class="frm_input_box"><input type="text" id="usageName" readonly="readonly" value="${drug.usageName }" name="usageName" class="frm_input interface"></span>
						<p class="frm_tips">
						</p>
					</div>
				</div>
				<div class="frm_control_group">
					<label for="" class="frm_label">储藏方式</label>
					<div class="frm_controls">
                        <span class="frm_input_box"><input type="text" id="storageCondition" readonly="readonly" value="${drug.storageCondition }" name="storageCondition" class="frm_input interface"></span>
						<p class="frm_tips">
						</p>
					</div>
				</div>
				<div class="frm_control_group">
					<label for="" class="frm_label">保质期</label>
					<div class="frm_controls">
                        <span class="frm_input_box"><input type="text" id="bzq" readonly="readonly" value="" name="bzq" class="frm_input interface"></span>
						<p class="frm_tips">
						</p>
					</div>
				</div>
				<div class="frm_control_group">
					<label for="" class="frm_label">用法用量</label>
					<div class="frm_controls" id="js_encrypt_type">
                        <span class="frm_textarea_box" style="width: 545px;"> 
                        	<textarea  class="frm_textarea" style=" text-indent: 2px;" readonly="readonly">${drug.recipeUsage}</textarea>
                        	</span>
						<p class="frm_tips">
						</p>
					</div>
				</div> 
				<div class="frm_control_group">
					<label for="token" class="frm_label">生成厂家</label>
					<div class="frm_controls">
						<span class="frm_input_box"><input type="text" id="manufacturer" readonly="readonly" value="${drug.manufacturer }" name="manufacturer" class="frm_input interface"></span>
						<p class="frm_tips">
						</p>
					</div>
				</div>
			</fieldset>
			<div class="tool_bar border tc with_form" style="display: none">
			  	<span class="btn btn_input btn_primary">
			  		<button class="submit" type="submit">提交</button>
			  	</span>
			</div>
		</form>
</div>
