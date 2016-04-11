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
		
		<!-- <font style="font-size: 14px; font-weight:bold;color: #333;">学科简述</font> -->
		<table class="basic" style="width: 100%; margin-top: 15px;" >
			<tr>
				<th style="text-align: left;padding-left: 20px;">二、学科特色与优势</th>
			</tr>
	        <tr>
		     	<td style="text-align:left;">
		     		<textarea placeholder=""  class="validate[maxSize[1000]] xltxtarea" name="featuresAdvantages">${resultMap.featuresAdvantages}</textarea>
		     	</td>
		    </tr>
	    </table>
	    
	    <table class="basic" style="width: 100%; margin-top: 15px;" >
			<tr>
				<th style="text-align: left;padding-left: 20px;">三、学科主攻方向和意义</th>
			</tr>
	        <tr>
		     	<td style="text-align:left;">
		     		<textarea placeholder=""  class="validate[maxSize[1000]] xltxtarea" name="mainAttackDirection">${resultMap.mainAttackDirection}</textarea>
		     	</td>
		    </tr>
	    </table>
	    
	    <table class="basic" style="width: 100%; margin-top: 15px;" >
			<tr>
				<th style="text-align: left;padding-left: 20px;">四、科学发展规划</th>
			</tr>
	        <tr>
		     	<td style="text-align:left;">
		     		<textarea placeholder=""  class="validate[maxSize[1000]] xltxtarea" name="developmentPlanning">${resultMap.developmentPlanning}</textarea>
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
   
  

		