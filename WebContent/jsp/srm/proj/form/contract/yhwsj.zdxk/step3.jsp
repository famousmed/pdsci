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
		<input type="hidden" id="pageName" name="pageName" value="step3" /> 
		<input type="hidden" id="recFlow" name="recFlow" value="${projRec.recFlow}"/>
		<input type="hidden" id="projFlow" name="projFlow" value="${proj.projFlow}"/>
		<input type="hidden" id="recTypeId" name="recTypeId" value="${param.recTypeId}"/>
		
		<font style="font-size: 14px; font-weight:bold;color: #333;">五、学科建设具体指标(三年后拟达到目标)</font>
		<table class="basic" style="width: 100%; margin-top: 10px;" >
			<tr>
				<th style="text-align: left;padding-left: 20px;">1、业务目标</th>
			</tr>
	        <tr>
		     	<td style="text-align:left;">
		     		<textarea placeholder=""  class="validate[maxSize[1000]] xltxtarea" name="businessTarget">${resultMap.businessTarget}</textarea>
		     	</td>
		    </tr>
			<tr>
				<th style="text-align: left;padding-left: 20px;">2、人才培养目标</th>
			</tr>
	        <tr>
		     	<td style="text-align:left;">
		     		<textarea placeholder=""  class="validate[maxSize[1000]] xltxtarea" name="objectiveOfPersonnelCultivation">${resultMap.objectiveOfPersonnelCultivation}</textarea>
		     	</td>
		    </tr>
			<tr>
				<th style="text-align: left;padding-left: 20px;">3、新技术开展与适宜技术推广目标</th>
			</tr>
	        <tr>
		     	<td style="text-align:left;">
		     		<textarea placeholder=""  class="validate[maxSize[1000]] xltxtarea" name="promotionalObjectives">${resultMap.promotionalObjectives}</textarea>
		     	</td>
		    </tr>
			<tr>
				<th style="text-align: left;padding-left: 20px;">4、学术交流目标</th>
			</tr>
	        <tr>
		     	<td style="text-align:left;">
		     		<textarea placeholder=""  class="validate[maxSize[1000]] xltxtarea" name="communicationObjectives">${resultMap.communicationObjectives}</textarea>
		     	</td>
		    </tr>
			<tr>
				<th style="text-align: left;padding-left: 20px;">5、科研课题、论文、奖励等目标</th>
			</tr>
	        <tr>
		     	<td style="text-align:left;">
		     		<textarea placeholder=""  class="validate[maxSize[1000]] xltxtarea" name="scientificResearchObjectives">${resultMap.scientificResearchObjectives}</textarea>
		     	</td>
		    </tr>
			<tr>
				<th style="text-align: left;padding-left: 20px;">6、学科管理与制度建设</th>
			</tr>
	        <tr>
		     	<td style="text-align:left;">
		     		<textarea placeholder=""  class="validate[maxSize[1000]] xltxtarea" name="manageInstitutionalImprovement">${resultMap.manageInstitutionalImprovement}</textarea>
		     	</td>
		    </tr>
		</table>
	</form>
	
    <c:if test="${param.view!=GlobalConstant.FLAG_Y}">
		<div align="center" style="margin-top: 10px">
		    <input id="prev" type="button" onclick="nextOpt('step2')" class="search" value="上一步"/>
     	    <input id="nxt" type="button" onclick="nextOpt('step4')" class="search" value="下一步"/>
       	</div>
    </c:if>
   
  

		