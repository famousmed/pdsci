<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<c:if test="${param.view!=GlobalConstant.FLAG_Y}">
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

	<form action="<s:url value='/srm/proj/mine/saveStep'/>" method="post" style="position: relative;"
		id="projForm">
		<input type="hidden" id="pageName" name="pageName" value="step1" /> 
		<input type="hidden" id="recFlow" name="recFlow" value="${projRec.recFlow}"/>
		<input type="hidden" id="projFlow" name="projFlow" value="${proj.projFlow}"/>
		<input type="hidden" id="recTypeId" name="recTypeId" value="${param.recTypeId}"/>
		
		<font style="font-size: 14px; font-weight:bold;color: #333;">一、项目目标和主要研究内容</font>
		<table class="basic" style="width: 100%;margin-top: 10px; margin-bottom: 20px;">
			<tr>
				<th style="text-align: left;padding-left: 20px;">项目目标和主要研究内容</th>
			</tr>           
			<tr>
				<td style="text-align:left;">
		    		<textarea placeholder="要解决的主要技术难题和问题，项目研究的创新点和内容等。" style="height: 500px;" class="validate[maxSize[2000]] xltxtarea"  name="projTargetResearchContent">${resultMap.projTargetResearchContent}</textarea>
		    	</td>
			</tr>
		</table>
		
		<font style="font-size: 14px; font-weight:bold;color: #333;">二、项目验收内容和考核指标</font>
		<table class="basic" style="width: 100%;margin-top: 10px;">
			<tr>
				<th style="text-align: left;padding-left: 20px;">项目验收内容和考核指标</th>
			</tr>           
			<tr>
				<td style="text-align:left;">
		    		<textarea placeholder="包括1.主要技术指标：如形成的专利、新技术、新产品、新装置、论文专著等数量、指标及其水平等；2.主要经济指标：如技术及产品所形成的市场规模、效益等；3.其他应考核的指标。" 
		    			 style="height: 200px;"	class="validate[maxSize[1000]] xltxtarea"  name="checkAcceptContentExamineNorm">${resultMap.checkAcceptContentExamineNorm}</textarea>
		    	</td>
			</tr>
		</table>
	</form>
	
    <c:if test="${param.view!=GlobalConstant.FLAG_Y}">
		<div align="center" style="margin-top: 10px">
		    <input id="nxt" type="button" onclick="nextOpt('step2')" class="search" value="下一步"/>
       	</div>
    </c:if>

		