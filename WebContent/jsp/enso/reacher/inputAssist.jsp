<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
	<!-- <style type="text/css">
		/* suspend */
		.suspend{width:40px;height:198px;position:fixed;top:2px;right:0;overflow:hidden;z-index:9999;}
		.suspend dl{width:120px;height:198px;border-radius:25px 0 0 25px;padding-left:40px;box-shadow:0 0 5px #e4e8ec;}
		.suspend dl dt{width:40px;height:198px;background:url(<s:url value='/css/skin/${skinPath}/images/suspend.png'/>);position:absolute;top:0;left:0;cursor:pointer;}
		.suspend dl dd.suspendQQ{width:120px;height:85px;background:#ffffff;}
		.suspend dl dd.suspendQQ a{width:120px;height:85px;display:block;background:url(<s:url value='/css/skin/${skinPath}/images/suspend.png'/>) -40px 0;overflow:hidden;}
		.suspend dl dd.suspendTel{width:120px;height:112px;background:#ffffff;border-top:1px solid #e4e8ec;}
		.suspend dl dd.suspendTel a{width:120px;height:112px;display:block;background:url(<s:url value='/css/skin/${skinPath}/images/suspend.png'/>) -40px -86px;overflow:hidden;}
		* html .suspend{position:absolute;left:expression(eval(document.documentElement.scrollRight));top:expression(eval(document.documentElement.scrollTop+200))}
	</style>
	<div class="suspend">
		<dl>
			<dt class="IE6PNG"></dt>
			<dd class="suspendQQ"><a href="javascript:void(0);"></a></dd>
			<dd class="suspendTel"><a href="javascript:void(0);"></a></dd>
		</dl>
	</div>
	<script type="text/javascript">           
	$(function(){
		$(".suspend").mouseover(function() {
	        $(this).stop();
	        $(this).animate({width: 160}, 400);
	    });
	    $(".suspend").mouseout(function() {
	        $(this).stop();
	        $(this).animate({width: 40}, 400);
	    });
	});
	</script> -->
	
	<style>
		@charset "utf-8";
		
		/* cus_ser */
		#cus_ser{z-index:9999;width:300px;height:800px;position:fixed;right:0px;top:350px;overflow:hidden;background-color: white}
		*html #cus_ser{position:absolute;top:expression(eval(document.documentElement.scrollTop));margin:200px 0 0 0;}
		.cus_ser_{width:300px;height:148px;border-bottom-left-radius:4px; border-top-left-radius:4px;overflow:hidden;}
		#cus_ser .title{width:32px;height:138px;float:left;cursor:pointer;}
		#cus_ser .close{border:0;margin:0;padding:0;display:inline-block;width:16px;height:16px;overflow:hidden;cursor:pointer;margin-right:4px;float:right;margin:0;padding:0;list-style-type:none;}
		#cus_ser ul, ol{list-style: none;margin:0 0 9px 0;}
		#cus_ser span img{border:0;margin:0;padding:0;background: #ffffff;}
	</style>
	
	<div id="cus_ser">
		<div class="cus_ser_">
			<div class="title"> <i class="icon_msg_mini info" style="height: 10px;float: left;margin-top: 10px;margin-left: 10px;">录入提示</i></div>
			<div style="width: 100%;line-height:30px;border: 1px solid #e7e7eb;padding-left: 60px;">
        				<div >Enter/Tab 切换输入框</div>
        				<div >保存后可继续修改数据</div>
        				<div >提交后无法修改</div>
        				<p style="margin-bottom: 10px;margin-top: 10px;text-align: left;">
        				<a href="javascript:javascript:saveData('${edcInputStatusEnumSave.id}');" style="color: ;" class="btn btn_default btn_input">保&#12288;存</a>&#12288;
        				<a href="javascript:javascript:submitData('${edcInputStatusEnumSubmit.id }');" style="color: " class="btn btn_primary js_complete_bnt">提&#12288;交</a></p>
      		</div>
      		
		</div>
		<div class="close" style="width: 100px; height: 20px; color: rgb(0, 0, 0); float: right; margin-right: 0px; font-size: 12px; font-family: 微软雅黑; text-align: right; line-height: 20px; background-color: rgb(255, 255, 255);">
			<span id="to_top">返回顶部</span>&#12288;&#12288;<span class="closeBtn">隐藏</span></div>
		<%-- <span class="close"><img src="<s:url value='/css/skin/${skinPath}/images/icon_close.png'/>"/></span> --%>
		<div style="float: left;overflow: auto; " class="maodian">
				<table class="grid">
					<tr style="height: 20px">
						<td>
							<ul class="dbsx">
								<li>
									<c:forEach items="${sessionScope.projDescForm.visitModuleMap[visit.visitFlow]}" var="visitModule">
										<span style="margin-left: 5px;"><a href="javascript:scrollToModule('${visitModule.recordFlow }');">${visitModule.moduleName}</a></span>
									</c:forEach>
								</li>
							</ul>
							</td>
						</tr>
				</table>
		</div>
	</div>
	
	<script type="text/javascript">
	function scrollToModule(recordFlow){
		 $("#indexBody").scrollTo('.'+recordFlow,500, { offset:{ top:-20} } );
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
	function openCusSer(){
		if($("#cus_ser").css("display")=="none"){
			$("#cus_ser").css({
		        display: ''
		    });
		    $("#cus_ser").stop();
			$("#cus_ser").animate({width: 165},400,'swing');
		}else{
		    $("#cus_ser").stop();
		    $("#cus_ser").animate({width:32},400, 'swing');
		    $("#cus_ser").css({
		        display: 'none'
		    });
		}
	}
	
	$(".closeBtn").click(function(){
		if($(".closeBtn").html()=="隐藏"){
			 $("#cus_ser").stop();
		    $("#cus_ser").animate({width:32},400, 'swing');
		    $(".closeBtn").html("展开");
		    $(".maodian").hide();
		}else {
		  	$("#cus_ser").stop();
		    $("#cus_ser").animate({width: 300},400,'swing');
		    $(".closeBtn").html("隐藏");
		    $(".maodian").show();
		}
	});
	</script>
		