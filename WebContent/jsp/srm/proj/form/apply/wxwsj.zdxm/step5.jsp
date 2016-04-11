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
		<input type="hidden" id="pageName" name="pageName" value="step5" /> 
		<input type="hidden" id="recFlow" name="recFlow" value="${projRec.recFlow}"/>
		<input type="hidden" id="projFlow" name="projFlow" value="${proj.projFlow}"/>
		<input type="hidden" id="recTypeId" name="recTypeId" value="${param.recTypeId}"/>

		<font style="font-size: 14px; font-weight:bold;color: #333; ">五、意见</font><br/><br/>
		<font style="font-size: 14px; font-weight:bold;color: #333; ">单位伦理委员会意见</font>
		<table class="basic" style="width: 100%; margin-top: 10px;" >
			<tr>
				<th style="text-align: left;padding-left: 20px;">单位伦理委员会意见</th>
			</tr>
			<tr>
				<td style="text-align:left;">
		     		<textarea placeholder="包括国内外研究现状、水平和发展趋势（含知识产权和技术标准状况）、经济建设和社会发展需求，当前须解决的主要问题、学术价值等。" class="validate[maxSize[1000]] xltxtarea"  name="orgEthicsCommitteeSuggest">${resultMap.orgEthicsCommitteeSuggest}</textarea>
		     		若申报项目内容需要进行伦理审查，请填写相关意见，并在最后上传附件；若项目不需要伦理审查，可不填。
		     	</td>
			</tr>
		 </table>
		 
		 <table class="basic" style="width: 100%;margin-top: 10px;">
			<tr>
				<th style="text-align: left;padding-left: 20px;">1、效益分析</th>
			</tr>          
			<tr>
				<td style="text-align:left;">
		     		<textarea placeholder="" class="validate[maxSize[1000]] xltxtarea" style="height: 300px;" name="benefitAnalyse">${resultMap.benefitAnalyse}</textarea>
		     	</td>
			</tr>
		 </table>
		 
		 <table class="basic" style="width: 100%;margin-top: 10px;">
			<tr>
				<th style="text-align: left;padding-left: 20px;">2、成果应用趋向和应用单位</th>
			</tr>           
			<tr>
				<td style="text-align:left;">
		     		<textarea placeholder="" class="validate[maxSize[1000]] xltxtarea" name="useTrendUseOrg">${resultMap.useTrendUseOrg}</textarea>
		     	</td>
			</tr>           
		</table>
		
		<br/>
		
		<font style="font-size: 14px; font-weight:bold;color: #333; ">合作形式、内容和合作单位意见</font>
		<table class="basic" style="width: 100%;margin-top: 10px;">
			<tr>
				<th style="text-align: left;padding-left: 20px;">1、合作形式和内容</th>
			</tr>           
			<tr>
				<td style="text-align:left;">
		     		<textarea placeholder="" class="validate[maxSize[1000]] xltxtarea" name="cooperationContent">${resultMap.cooperationContent}</textarea>
		     	</td>
			</tr>           
		</table>
		
		<table class="basic" style="width: 100%;margin-top: 10px;">
			<tr>
				<th style="text-align: left;padding-left: 20px;">2、合作单位意见（对合作内容、形式、参加人员素质及保证工作条件等）签署具体意见</th>
			</tr>           
			<tr>
				<td style="text-align:left;">
		     		<textarea placeholder="" class="validate[maxSize[1000]] xltxtarea" name="cooperationOrgSuggest">${resultMap.cooperationOrgSuggest}</textarea>
		     	</td>
			</tr>           
		</table>
	</form>

   	<c:if test="${param.view!=GlobalConstant.FLAG_Y}">
		<div align="center" style="margin-top: 10px">
		    <input id="prev" type="button" onclick="nextOpt('step4')" class="search" value="上一步"/>
		    <input id="nxt" type="button" onclick="nextOpt('step6')" class="search" value="下一步"/>
       	</div>
    </c:if>

		