<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>
<c:if test="${param.view != GlobalConstant.FLAG_Y}">
<script type="text/javascript">
	function nextOpt(step){
		if(false==$("#projForm").validationEngine("validate")){
			return false;
		}
		var form = $('#projForm');
		var action = form.attr('action');
		action+="?nextPageName="+step;
		form.attr("action" , action);
		form.submit();
	}
</script>
</c:if>
<style>
	.xltxtarea{height: 200px;}
</style>

	<form action="<s:url value='/srm/proj/mine/saveStep'/>" method="post" style="position: relative;"
		id="projForm">
		<input type="hidden" id="pageName" name="pageName" value="step2" /> 
		<input type="hidden" id="recFlow" name="recFlow" value="${projRec.recFlow}"/>
		<input type="hidden" id="projFlow" name="projFlow" value="${proj.projFlow}"/>
		<input type="hidden" id="recTypeId" name="recTypeId" value="${param.recTypeId}"/>
		
		<font style="font-size: 14px; font-weight:bold;color: #333;">二、项目简介</font>
		<table class="basic" style="width: 100%; margin-top: 10px;" >
			<tr>
				<th style="text-align: left;padding-left: 20px;">一、项目简介（包括项目研究开发的主要内容，与国内外同类技术的比较等）：</th>
			</tr>
	        <tr>
		     	<td style="text-align:left;">
		     		<textarea placeholder="" class="validate[maxSize[1000]] xltxtarea" name="planIntroduction">${resultMap.planIntroduction}</textarea>
		     	</td>
		    </tr>
			<tr>
				<th style="text-align: left;padding-left: 20px;">二、项目合同规定的主要内容、技术经济指标及完成情况：</th>
			</tr>
	        <tr>
		     	<td style="text-align:left;">
		     		<textarea placeholder=""  class="validate[maxSize[1000]] xltxtarea" name="contractContent">${resultMap.contractContent}</textarea>
		     	</td>
		    </tr>
			<tr>
				<th style="text-align: left;padding-left: 20px;">三、关键技术及创新点、获自主知识产权情况、成果应用和产业化情况：</th>
			</tr>
	        <tr>
		     	<td style="text-align:left;">
		     		<textarea placeholder=""  class="validate[maxSize[1000]] xltxtarea" name="technologyContent">${resultMap.technologyContent}</textarea>
		     	</td>
		    </tr>
			<tr>
				<th style="text-align: left;padding-left: 20px;">四、项目资金使用情况：</th>
			</tr>
	        <tr>
		     	<td style="text-align:left;">
		     		<textarea placeholder=""  class="validate[maxSize[1000]] xltxtarea" name="fundUseInfo">${resultMap.fundUseInfo}</textarea>
		     	</td>
		    </tr>
			<tr>
				<th style="text-align: left;padding-left: 20px;">五、提供验收的技术资料目录（按《浙江省科技计划项目验收管理暂行办法》规定提供验收资料，已通过鉴定（评审）的，需提供鉴定（评审）证书）：</th>
			</tr>
	        <tr>
		     	<td style="text-align:left;">
		     		<textarea placeholder=""  class="validate[maxSize[1000]] xltxtarea" name="informationCatalogue">${resultMap.informationCatalogue}</textarea>
		     	</td>
		    </tr>
		</table>
	</form>
	
    <c:if test="${param.view!=GlobalConstant.FLAG_Y}">
		<div align="center" style="margin-top: 10px">
		    <input id="prev" type="button" onclick="nextOpt('step1')" class="search" value="上一步"/>
     	    <input id="nxt" type="button" onclick="nextOpt('step3')" class="search" value="下一步"/>
       	</div>
    </c:if>
   
  

		