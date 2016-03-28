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

		<font style="font-size: 14px; font-weight:bold;color: #333; ">五、主要内容和目标</font>
		<table class="basic" style="width: 100%; margin-top: 10px;" >
			<tr>
				<th style="text-align: left;padding-left: 20px;">主要内容和目标</th>
			</tr>
			<tr>
				<td style="text-align:left;">
		     		<textarea placeholder="主要内容和目标（主要技术、经济指标、有关知识产权获得情况）" class="validate[maxSize[1000]] xltxtarea" style="height: 300px;" name="mainContentTarget">${resultMap.mainContentTarget}</textarea>
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

		