<link rel="stylesheet" type="text/css" 	href="<s:url value='/jsp/medroad/css/base.css'/>?v=${applicationScope.sysCfgMap['sys_version']}"></link>
 <c:set var="count" value="0" />
  <c:set var="signDays" value="0" />
<script type="text/javascript">
$(document).ready(function(){
	$("#patientCountSpan").html($("#patientCount").val());
	$("#signDaysSpan").html($("#signDays").val());
	$(".img_sms").on("click",function(){
		
		if($(this).attr("notice-flag")=='${GlobalConstant.FLAG_Y}'){
			jboxTip("该患者已发过随访提醒短信.");
			return;
		}
		
		$(".popover").css({"left":$(this).offset().left-135,"top":$(this).offset().top+20});
		$(".popover").show();
		$("#recordFlow").val($(this).attr("record-flow"));
		var patientName = $(this).attr("patient-name");
		var windowLeft = $(this).attr("window-left");
		var windowRight = $(this).attr("window-right");
		$(".frm_textarea").val(patientName+",您好，请您于"+windowLeft+"至 "+windowRight+"日前往我院进行跟踪治疗!");
	});
});
function sendFollowSms(){
	var data = {
			 "recordFlow":$("#recordFlow").val(),
			 "msgContent":$(".frm_textarea").val(),
	}
	jboxPost("<s:url value='/medroad/sendFollowSms'/>",data,function(resp){
		jboxTip(resp);
		$(".pos_center").hide();
	},null,true);
}
$(function(){
	var dropBtn = $('.img_sms');
	dropBtn.on('click',function(e){e.stopPropagation();});
	dropBtn.on('click',function(){
		$(this).find(".pos_center").stop().show();
    });
	var dropDiv = $('.pos_center');
	dropDiv.on('click',function(e){e.stopPropagation();});
	dropDiv.on('click',function(){
		$(this).find(".pos_center").stop().show();
    });
    $(document).on('click',function(){$(".pos_center").hide();});
    
});

</script>
<div class="main_hd">
	<h2 class="underline">随访提醒
	</h2>
</div>
 <div class="col_main" id="content">
       <div class="content_main">
	       	<div style="font-size: 24px;">
	 			当前共有&nbsp;<span id="patientCountSpan"></span>&nbsp;名受试者需要访视&#12288;
	 			距离最近患者需要随访还有&nbsp;<span id="signDaysSpan"></span>&nbsp;天
	 		</div>
	        <div style="margin-top: 20px;">
	        	<table border="0" cellpadding="0" cellspacing="0" class="grid" style="width: 100%">
		            <tr>
		                <th>姓名</th>
		                <th>性别</th>
		                <th>联系方式</th>
		                <th>上次访视日期</th>
		              	<th>访视窗	</th>
		                <th>状态</th>
		                <th  width="100px;">操作</th>
		            </tr>
		           
		            <c:forEach items="${windowList}" var="window">
		            	<c:if test="${ patientMap[window.patientFlow].patientStageId==patientStageEnumIn.id}">
		            	<tr><td>${window.patientName }</td>
		            		<td>${patientMap[window.patientFlow].sexName }</td>
		            		<td>${patientMap[window.patientFlow].patientPhone }</td>
		            		<td>${window.visitDate }</td>
		            		<td>${window.windowVisitLeft }&nbsp;~&nbsp;${window.windowVisitRight}</td>
		            		<td>
		            			<c:choose>
									<c:when test="${pdfn:getCurrDate()>window.windowVisitLeft}">访视中...
										<c:set var="count" value="${count+1 }"/>
									</c:when>
									<c:otherwise>距离${pdfn:signDaysBetweenTowDate(window.windowVisitLeft,pdfn:getCurrDate()) }天
										<c:if test="${signDays=='0' or signDays> pdfn:signDaysBetweenTowDate(window.windowVisitLeft,pdfn:getCurrDate()) }">
											<c:set var="signDays" value="${pdfn:signDaysBetweenTowDate(window.windowVisitLeft,pdfn:getCurrDate())}"/>
										</c:if>
									</c:otherwise>
								</c:choose>
		            		</td>
		            		<td>
			            			<img class="img_sms" notice-flag='${window.isNotice }' record-flow='${window.recordFlow }' patient-name='${window.patientName}' window-left='${window.windowVisitLeft }' window-right='${window.windowVisitRight}'  src="<s:url value='/css/skin/${skinPath}/images/call_sms.png'/>" title="短信提醒" style="cursor: pointer;"/>
				            			&nbsp;
		            				<img onclick="visit('${window.patientFlow}');" src="<s:url value='/css/skin/${skinPath}/images/feedback.png'/>" title="访视" style="cursor: pointer;"/>
		            		</td>
		            		</tr>
		            	</c:if>
		            	
		            </c:forEach>
		            		<input type="hidden" id="patientCount" value="${count }"/>
		            		<input type="hidden" id="signDays" value="${signDays }"/>
	            </table>
	       </div>
	        <div class="popover pos_center " style="display:none;z-index: 999;">
			    <div class="popover_inner">
			        <div class="popover_content jsPopOverContent">短信内容   
			         <span class="frm_textarea_box with_counter counter_in append count" style="width: 220px;">
			       	<textarea  class="frm_textarea">您好，请您于20XX-XX-XX至 20XX-XX-XX日前往市中心医院进行跟踪治疗!</textarea></span>
			   </div>
			        <div class="popover_bar"><a href="javascript:sendFollowSms();" class="btn btn_primary jsPopoverBt">确定</a>&nbsp;<a href="javascript:$('.popover').hide();" class="btn btn_default jsPopoverBt">取消</a></div>
			    </div>
			    <i class="popover_arrow popover_arrow_out"></i>
			    <i class="popover_arrow popover_arrow_in"></i> 
			    <input type="hidden" id="recordFlow" value=""/>
			</div>
       </div>
      
</div>
