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
		#cus_ser{z-index:9999;width:32px;height:182px;position:fixed;right:0px;color:#FFF;top:200px;overflow:hidden;}
		*html #cus_ser{position:absolute;top:expression(eval(document.documentElement.scrollTop));margin:200px 0 0 0;}
		.cus_ser_{width:165px;height:148px;background:#1595d4;border-bottom-left-radius:4px; border-top-left-radius:4px;overflow:hidden;}
		#cus_ser .title{width:32px;height:138px;float:left;background:url(<s:url value='/css/skin/${skinPath}/images/zxzx.jpg'/>) no-repeat 2px 15px;cursor:pointer;}
		#cus_ser ul{padding:10px 0px 0px 2px;width:130px;float:left;}
		#cus_ser ul li#zqq{height:30px;line-height:30px;display:block;font-size:14px;padding-left:24px;background:url(<s:url value='/css/skin/${skinPath}/images/zqq.png'/>) no-repeat 2px 7px;}
		#cus_ser ul li#zphone{height:30px;line-height:30px;display:block;font-size:14px;padding-left:24px;background:url(<s:url value='/css/skin/${skinPath}/images/zphone.png'/>) no-repeat 2px 8px;}
		#cus_ser ul li#wb{height:30px;line-height:30px;display:block;font-size:12px;padding-left: 12px;}
		#cus_ser ul li a{color:#FFF;}
		#cus_ser ul li a:hover{text-decoration:underline;}
		#cus_ser .close{border:0;margin:0;padding:0;display:inline-block;width:16px;height:16px;overflow:hidden;cursor:pointer;margin-right:4px;float:right;margin:0;padding:0;list-style-type:none;}
		#cus_ser ul, ol{list-style: none;margin:0 0 9px 0;}
		#cus_ser span img{border:0;margin:0;padding:0;background: #ffffff;}
	</style>
	
	<div id="cus_ser">
		<div class="cus_ser_">
			<div class="title"></div>
			<ul>
				<c:if test="${not empty applicationScope.sysCfgMap['online_service_qq1']}">
				<li id="zqq"><a href="#">${applicationScope.sysCfgMap['online_service_qq1'] }</a></li>
				</c:if>
				
				<c:if test="${not empty applicationScope.sysCfgMap['online_service_qq2']}">
				<li id="zqq"><a href="#">${applicationScope.sysCfgMap['online_service_qq2'] }</a></li>
				</c:if>
				
				<c:if test="${not empty applicationScope.sysCfgMap['online_service_phone1']}">
				<li id="zphone"><a href="#">${applicationScope.sysCfgMap['online_service_phone1'] }</a></li>
				</c:if>
				
				<c:if test="${not empty applicationScope.sysCfgMap['online_service_phone2']}">
				<li id="zphone"><a href="#">${applicationScope.sysCfgMap['online_service_phone2'] }</a></li>
				</c:if>
			</ul>
		</div>
		<div class="close" style="width: 40px; height: 20px; color: rgb(0, 0, 0); float: right; margin-right: 0px; font-size: 12px; font-family: 微软雅黑; text-align: right; line-height: 20px; background-color: rgb(255, 255, 255);">关闭</div>
		<%-- <span class="close"><img src="<s:url value='/css/skin/${skinPath}/images/icon_close.png'/>"/></span> --%>
	</div>
	
	<script type="text/javascript">
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
	
	$("#cus_ser .close").click(function(){
	    $("#cus_ser").css({
	        display: 'none'
	    });
	});
	
	$("#cus_ser").mouseover(function(){
	    $("#cus_ser").stop();
	    $("#cus_ser").animate({width: 165},400,'swing');
	});
	
	$("#cus_ser").mouseout(function(){
	    $("#cus_ser").stop();
	    $("#cus_ser").animate({width:32},400, 'swing');
	});
	</script>
		