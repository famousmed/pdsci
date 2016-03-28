<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>

<c:if test="${param.view != GlobalConstant.FLAG_Y}">
<jsp:include page="/jsp/common/htmlhead.jsp">
	<jsp:param name="ueditor" value="true"/>
</jsp:include>
<script type="text/javascript">
function nextOpt(step){
	if(false==$("#projForm").validationEngine("validate")){
		return false;
	}
	var form = $("#projForm");
	form.append('<input type="hidden" name="nextPageName" value="'+step+'"/>');
	$('#nxt').attr({"disabled":"disabled"});
	jboxStartLoading();
	form.submit();
}
</script>
</c:if>
    <form action="<s:url value='/srm/proj/mine/saveStep'/>" method="post" id="projForm" style="position: relative;">
	    <input type="hidden" id="pageName" name="pageName" value="step1"/>
		<input type="hidden" id="recFlow" name="recFlow" value="${projRec.recFlow}"/>
	    <input type="hidden" id="projFlow" name="projFlow" value="${proj.projFlow}"/>
		<input type="hidden" name="recTypeId" value="${param.recTypeId}"/>

        <table width="100%" cellpadding="0" cellspacing="0" class="basic">
            <tr>
			    <th  colspan="4" style="text-align: left;padding-left: 15px;font-size: 14px; font-weight:bold;">一、项目概况</th>
			</tr>
			<c:choose>
                <c:when test="${param.view == GlobalConstant.FLAG_Y}">
                    <tr>
				        <td width="20%" style="text-align: right;">项目编号：</td>
						<td colspan="3" width="80%">${proj.projNo}</td>
					</tr>
					<tr>
					    <td width="20%" style="text-align: right;">项目名称：</td>
						<td colspan="3" width="80%">${resultMap.projName}</td>
					</tr>
					<tr>
					    <td width="20%" style="text-align: right;">承担单位：</td>
						<td colspan="3" width="80%">${resultMap.orgName}</td>
					</tr>
					<tr>
					    <td width="20%" style="text-align: right;">承担单位主管部门：</td>
						<td colspan="3" width="80%">${resultMap.chargeOrgName}</td>
					</tr>
				    <tr>
					    <td width="20%" style="text-align: right;">项目负责人：</td>
						<td colspan="3" width="80%">${resultMap.applyUserName}</td>
					</tr>
					<tr>
					    <td width="20%" style="text-align: right;">起止年限：</td>
						<td colspan="3" width="80%">
				            ${resultMap.startYear}&#12288;~&#12288;
				            ${resultMap.endYear}
				        </td>
					</tr>
                </c:when>
                <c:otherwise>
			    	<tr>
			    		<td width="20%" style="text-align: right;">项目编号：</td>
			    		<td colspan="3" width="80%">
			    			<input name="projNo" type="text" value="${proj.projNo}" readonly="readonly" class="validate[required] inputText" style="width: 400px; "/>
	                        <span class="redspan" style="color: red;padding: 0px;margin-left: 10px;">*</span>
	                    </td>
			    	</tr>
			    	<tr>
			    		<td width="20%" style="text-align: right;">项目名称：</td>
			    		<td colspan="3" width="80%">
	                       	<input name="projName" type="text" value="<c:if test='${empty resultMap.projName and param.view != GlobalConstant.FLAG_Y}'>${proj.projName}</c:if><c:if test='${!empty resultMap.projName}'>${resultMap.projName}</c:if>" class="validate[required] inputText"  style="width: 400px; "/>
	                        <span class="redspan" style="color: red;padding: 0px;margin-left: 10px;">*</span>
	                    </td>
			    	</tr>
			    	<tr>
			    		<td width="20%" style="text-align: right;">承担单位：</td>
			    		<td colspan="3" width="80%">
	                       	<input name="orgName" type="text" value="<c:if test='${empty resultMap.orgName and param.view != GlobalConstant.FLAG_Y}'>${proj.applyOrgName}</c:if><c:if test='${!empty resultMap.orgName}'>${resultMap.orgName}</c:if>" class="validate[required] inputText"   style="width: 400px; "/>
	                        <span class="redspan" style="color: red;padding: 0px;margin-left: 10px;">*</span>
	                    </td>
			    	</tr>
			    	<tr>
			    		<td width="20%" style="text-align: right;">承担单位主管部门：</td>
			    		<td colspan="3" width="80%">
	                       	<input name="chargeOrgName" type="text" value="<c:if test='${empty resultMap.chargeOrgName and param.view != GlobalConstant.FLAG_Y}'>${org.chargeOrgName}</c:if><c:if test='${!empty resultMap.chargeOrgName}'>${resultMap.chargeOrgName}</c:if>" class="validate[required] inputText" style="width: 400px; "/>
	                        <span class="redspan" style="color: red;padding: 0px;margin-left: 10px;">*</span>
	                    </td>
			    	</tr>
			    	
			    	<tr>
			    		<td width="20%" style="text-align: right;">项目负责人：</td>
			    		<td colspan="3" width="80%">
	                       	<input name="applyUserName" type="text" value="<c:if test='${empty resultMap.applyUserName and param.view != GlobalConstant.FLAG_Y}'>${proj.applyUserName}</c:if><c:if test='${!empty resultMap.applyUserName }'>${resultMap.applyUserName}</c:if>" class="validate[required] inputText"  style="width: 400px; "/>
	                        <span class="redspan" style="color: red;padding: 0px;margin-left: 10px;">*</span>
	                    </td>
			    	</tr>
			    	<tr>
			    		<td width="20%" style="text-align: right;">起止年限：</td>
			    		<td colspan="3" width="80%">
	                       	<input name="startYear" type="text" value="<c:if test='${empty resultMap.startYear}'>${applicationScope.sysCfgMap['srm_contract_start_time']}</c:if><c:if test='${! empty resultMap.startYear}'>${resultMap.startYear}</c:if>" class="validate[required] inputText" readonly="readonly" <c:if test="${empty applicationScope.sysCfgMap['srm_contract_start_time']}">onClick="WdatePicker({dateFmt:'yyyy'})"</c:if>/>~&#12288;
	                       	<input name="endYear" type="text" value="<c:if test='${empty resultMap.endYear}'>${applicationScope.sysCfgMap['srm_contract_end_time']}</c:if><c:if test='${! empty resultMap.endYear}'>${resultMap.endYear}</c:if>" class="validate[required] inputText" readonly="readonly" <c:if test="${empty applicationScope.sysCfgMap['srm_contract_end_time']}">onClick="WdatePicker({dateFmt:'yyyy'})"</c:if>/>
	                        <span class="redspan" style="color: red;padding: 0px;margin-left: 10px;">*</span>
	                    </td>
			    	</tr>
				</c:otherwise>
			</c:choose>
		</table>
       	<c:if test="${param.view != GlobalConstant.FLAG_Y}">
       	<div align="center" style="margin-top: 10px">
       		<input type="button" id="nxt" onclick="nextOpt('step2')" class="search" value="下一步"/>
       	</div>
       	</c:if>	          
    </form>
