<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>
<c:if test="${param.view != GlobalConstant.FLAG_Y}">
<script type="text/javascript">
function nextOpt(step){
	if(false==$("#projForm").validationEngine("validate")){
			return false;
		}
	var form = $('#projForm');
	form.append("<input name='nextPageName' value='"+step+"' type='hidden'/>");
	$('#nxt').attr({"disabled":"disabled"});
	jboxStartLoading();
	form.submit();
}
</script>
</c:if>

 	<form action="<s:url value='/srm/proj/mine/saveStep'/>" method="post"
		id="projForm" style="position: relative;">
		<input type="hidden" id="pageName" name="pageName" value="step1"/>
		<input type="hidden" id="recFlow" name="recFlow" value="${projRec.recFlow}"/>
        <input type="hidden" id="projFlow" name="projFlow" value="${proj.projFlow}"/>
		<input type="hidden" name="recTypeId" value="${param.recTypeId}"/>
                                            
       	<table width="100%" cellpadding="0" cellspacing="0" class="basic">
		  <c:choose>
   		    <c:when test="${param.view==GlobalConstant.FLAG_Y}">
   		        <tbody>
		    	<tr>
					<th colspan="4" style="text-align: left;padding-left: 15px;font-size: 14px;font-weight: bold;">基本信息</th>
				</tr>
		    	<tr>
		    		<td width="20%" style="text-align:right;">项目名称：</td>
		    		<td colspan="3">
		    			${resultMap.projName}
                    </td>
		    	</tr>
		    	<tr>
		    		<td style="text-align:right;">承担单位：  </td>
		    		<td colspan="3">
		    			${resultMap.orgName}
                    </td>
		    	</tr>
		    	<tr>
		    		<td style="text-align:right;">应用单位：</td>
		    		<td colspan="3">
		    			${resultMap.useOrg}
                    </td>
		    	</tr>
		    	<tr>
		    		<td style="text-align:right;">单位地址： </td>
		    		<td>
		    			${resultMap.orgAddress}
                    </td>
		    		<td width="20%" style="text-align:right;">邮编：</td>
		    		<td>
		    			${resultMap.postcode}
                    </td>
		    	<tr>
		    		<td style="text-align:right;">项目负责人：  </td>
		    		<td>
		    			${resultMap.projResponsible}
                    </td>
		    		<td width="20%" style="text-align:right;">电话：</td>
		    		<td>
		                ${resultMap.telephone}
                    </td>
		    	</tr>
		    	<tr>
		    		<td style="text-align:right;">主管部门：</td>
		    		<td colspan="3">
		    			${resultMap.chargeOrg}
                    </td>
		    	</tr>
		    	<tr>
		    		<td style="text-align:right;">申报日期：</td>
		    		<td colspan="3">
		    			${resultMap.declareDate}
                    </td>
		    	</tr>
		    	
		    </tbody>
   		    </c:when>
   		    <c:otherwise>
		    <tbody>
		    	<tr>
					<th colspan="4" style="text-align: left;padding-left: 15px;font-size: 14px;font-weight: bold;">基本信息</th>
				</tr>
		    	<tr>
		    		<td width="20%" style="text-align:right;">项目名称：</td>
		    		<td colspan="3">
		    			<input name="projName" type="text" value="<c:if test='${empty resultMap.projName and param.view != GlobalConstant.FLAG_Y}'>${proj.projName}</c:if><c:if test='${!empty resultMap.projName}'>${resultMap.projName}</c:if>"  class="inputText" style="width: 80%; "/>
                        <!-- <span class="redspan" style="color: red;padding: 0px;margin-left: 10px;">*</span> -->
                    </td>
		    	</tr>
		    	<tr>
		    		<td style="text-align:right;">承担单位：  </td>
		    		<td colspan="3">
		    			<input name="orgName" type="text" value="<c:if test='${empty resultMap.orgName and param.view != GlobalConstant.FLAG_Y}'>${proj.applyOrgName}</c:if><c:if test='${!empty resultMap.orgName}'>${resultMap.orgName}</c:if>" class="inputText" style="width: 80%; "/>
                    </td>
		    	</tr>
		    	<tr>
		    		<td style="text-align:right;">应用单位：</td>
		    		<td colspan="3">
		    			<input name="useOrg" type="text" value="${resultMap.useOrg}" class="inputText" style="width: 80%; "/>
                    </td>
		    	</tr>
		    	<tr>
		    		<td style="text-align:right;">单位地址： </td>
		    		<td>
		    			<input name="orgAddress" type="text" value="<c:if test='${empty resultMap.orgAddress and param.view != GlobalConstant.FLAG_Y}'>${org.orgAddress}</c:if><c:if test='${!empty resultMap.orgAddress}'>${resultMap.orgAddress}</c:if>" class="inputText" style="width: 80%; "/>
                    </td>
		    		<td width="20%" style="text-align:right;">邮编：</td>
		    		<td>
		    			<input name="postcode" type="text" value="<c:if test='${empty resultMap.postcode and param.view!=GlobalConstant.FLAG_Y}'>${org.orgZip}</c:if><c:if test='${! empty resultMap.postcode}'>${resultMap.postcode}</c:if>" class="validate[custom[chinaZip]] inputText" style="width: 80%; "/>
                    </td>
		    	<tr>
		    		<td style="text-align:right;">项目负责人：  </td>
		    		<td>
		    			<input name="projResponsible" type="text" value="<c:if test='${empty resultMap.projResponsible and param.view!=GlobalConstant.FLAG_Y}'>${proj.applyUserName}</c:if><c:if test='${! empty resultMap.projResponsible}'>${resultMap.projResponsible}</c:if>" class="inputText" style="width: 80%; "/>
                    </td>
		    		<td width="20%" style="text-align:right;">电话：</td>
		    		<td>
		    			<input name="telephone" type="text" value="<c:if test='${empty resultMap.telephone and param.view!=GlobalConstant.FLAG_Y}'>${user.userPhone}</c:if><c:if test='${! empty resultMap.telephone}'>${resultMap.telephone}</c:if>" class="validate[custom[phone2]] inputText" style="width: 80%; "/>
                    </td>
		    	</tr>
		    	<tr>
		    		<td style="text-align:right;">主管部门：</td>
		    		<td colspan="3">
		    			<input name="chargeOrg" type="text" value="<c:if test='${empty resultMap.chargeOrg and param.view!=GlobalConstant.FLAG_Y}'>${org.chargeOrgName}</c:if><c:if test='${! empty resultMap.chargeOrg}'>${resultMap.chargeOrg}</c:if>" class="inputText" style="width: 80%; "/>
                    </td>
		    	</tr>
		    	<tr>
		    		<td style="text-align:right;">申报日期：</td>
		    		<td colspan="3">
		    			<input type="text" name="declareDate" value="${resultMap.declareDate}" onClick="WdatePicker({dateFmt:'yyyy年MM月dd日'})"  class="inputText ctime" readonly="readonly"/>
                    </td>
		    	</tr>
		    	
		    </tbody>
		    </c:otherwise>
		    </c:choose>
       	</table>
       	
       	<c:if test="${param.view != GlobalConstant.FLAG_Y}">
       	<div align="center" style="margin-top: 10px">
       	    <input id="nxt" type="button" onclick="nextOpt('step2')" class="search" value="下一步"/>
       	</div>
       	</c:if>	
       	          
	</form>

