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
		<input type="hidden" id="pageName" name="pageName" value="step3" /> 
		<input type="hidden" id="recFlow" name="recFlow" value="${projRec.recFlow}"/>
		<input type="hidden" id="projFlow" name="projFlow" value="${proj.projFlow}"/>
		<input type="hidden" id="recTypeId" name="recTypeId" value="${param.recTypeId}"/>

		<font style="font-size: 14px; font-weight:bold;color: #333; ">三、研究项目简介</font>
		<table class="basic" style="width: 100%; margin-top: 10px;" >
			<tr>
				<th style="text-align: left;padding-left: 20px;">立题依据（字数限制在3000字以内）</th>
			</tr>
			<tr>
				<td style="text-align:left;">
		     		<textarea placeholder="包括国内外研究现状、水平和发展趋势（含知识产权和技术标准状况）、经济建设和社会发展需求，当前须解决的主要问题、学术价值等。" style="height: 500px;" class="xltxtarea"  name="subjectAccording">${resultMap.subjectAccording}</textarea>
		     	</td>
			</tr>
		 </table>
		 
		 <table class="basic" style="width: 100%;margin-top: 10px;">
			<tr>
				<th style="text-align: left;padding-left: 20px;">课题研究的总目标和创新点，主要研究内容及关键技术</th>
			</tr>          
			<tr>
				<td style="text-align:left;">
		     		<textarea placeholder="课题研究的总目标和创新点，主要研究内容及关键技术。" class=" xltxtarea" style="height: 500px;" name="targetContentTechnology">${resultMap.targetContentTechnology}</textarea>
		     	</td>
			</tr>
		 </table>
		 
		 <table class="basic" style="width: 100%;margin-top: 10px;">
			<tr>
				<th style="text-align: left;padding-left: 20px;">项目完成形式和考核指标</th>
			</tr>           
			<tr>
				<td style="text-align:left;">
		     		<textarea placeholder="主要技术指标、形成的专利、标准、新技术、新产品、新装置、论文专著等数量、指标及其水平等；社会、经济效益考核指标。" class=" xltxtarea"  name="completeModalityExamineNorm">${resultMap.completeModalityExamineNorm}</textarea>
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

		