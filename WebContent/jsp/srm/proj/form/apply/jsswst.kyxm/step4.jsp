<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
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
  
	<form action="<s:url value='/srm/proj/mine/saveStep'/>" method="post" style="position: relative;"
		id="projForm" style="position:relative;">
		<input type="hidden" id="pageName" name="pageName" value="step4" /> 
		<input type="hidden" id="recFlow" name="recFlow" value="${projRec.recFlow}"/>
		<input type="hidden" id="projFlow" name="projFlow" value="${proj.projFlow}"/>
		<input type="hidden" id="recTypeId" name="recTypeId" value="${param.recTypeId}"/>
		
	    <font style="font-size: 14px; font-weight:bold; margin-bottom: 20px;">四、主要研究内容及考核指标</font><br/><br/>
	    <fieldset>
			<legend>主要研究内容及考核指标（关键技术、特色与创新之处、考核指标，300字以内） </legend>
			<table width="100%" class="basic" style="margin: 20px 0px;">
				<tr>
					<td width="30%" style="text-align: right;" rowspan="2">关键词：（不超过3个）</td>
					<td>
						<input type="text" name="keyword1" class="inputText" value="${resultMap.keyword1}" style="width: 200px;"/>、
						<input type="text" name="keyword2" class="inputText" value="${resultMap.keyword2}" style="width: 200px;"/>、
					</td>
				</tr>
				<tr>
					<td>
						<input type="text" name="keyword3" class="inputText" value="${resultMap.keyword3}" style="width: 200px;"/>
					</td>
				</tr>
				<tr>
	                <td colspan="2">
	                    <textarea name="mainContent" placeholder="主要研究内容及考核指标（关键技术、特色与创新之处、考核指标，300字以内）" class="xltxtarea" style="height: 300px;">${resultMap.mainContent}</textarea>
	                </td>
				</tr>
			</table>
		</fieldset>
	</form>
    <div class="button" style="width: 100%; <c:if test="${param.view == GlobalConstant.FLAG_Y}">display:none</c:if>">
        <input type="button" onclick="nextOpt('step3')" class="search" value="上一步"/>
	    <input type="button" onclick="nextOpt('step5')" class="search" value="下一步"/>
    </div>

		