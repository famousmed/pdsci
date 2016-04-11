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
		<input type="hidden" id="pageName" name="pageName" value="step2" /> 
		<input type="hidden" id="recFlow" name="recFlow" value="${projRec.recFlow}"/>
		<input type="hidden" id="projFlow" name="projFlow" value="${proj.projFlow}"/>
		<input type="hidden" id="recTypeId" name="recTypeId" value="${param.recTypeId}"/>

		<font style="font-size: 14px; font-weight:bold;color: #333; ">二、申请人简历</font>
		<table class="basic" style="width: 100%; margin-top: 10px;" >
			<tr>
				<th style="text-align: left;padding-left: 20px;">学习经历</th>
			</tr>
			<tr>
				<td style="text-align:left;">
					<textarea placeholder="学习经历（包括学习起止年月、院校、专业、学位、毕业论文题目、主要进修、留学、重要学术交流情况等）" style="height: 300px;" class="validate[maxSize[1000]] xltxtarea"  name="educationResume">${resultMap.educationResume}</textarea>
		     	</td>
			</tr>
		 </table>
		 
		 <table class="basic" style="width: 100%;margin-top: 10px;">
			<tr>
				<th style="text-align: left;padding-left: 20px;">工作简历</th>
			</tr>           
			<tr>
				<td style="text-align:left;">
		     		<textarea placeholder="工作简历（包括起止年月、工作单位、部门、行政及专业技术职务等）" style="height: 300px;" class="validate[maxSize[1000]] xltxtarea"  name="workResume">${resultMap.workResume}</textarea>
		     	</td>
			</tr>
		 </table>
		 
		 <table class="basic" style="width: 100%;margin-top: 10px;"> 
			<tr>
				<th style="text-align: left;padding-left: 20px;">科研履历</th>
			</tr>          
			<tr>
				<td style="text-align:left;">
		     		<textarea placeholder="科研工作简历（包括研究起止年月、项目名称、任务来源、资助强度、第几承担人等）、近五年论文论著（名称、类别、出版年月、期刊名称及卷期、第几作者等）" style="height: 300px;" class="xltxtarea"  name="researchWorkResume">${resultMap.researchWorkResume}</textarea>
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

		