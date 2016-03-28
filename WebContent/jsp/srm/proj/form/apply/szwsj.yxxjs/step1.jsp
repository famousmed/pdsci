<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<c:if test="${param.view != GlobalConstant.FLAG_Y}">
<script type="text/javascript">
function nextOpt(step){
	if(false==$("#projForm").validationEngine("validate")){
		return false;
	}
var form = $('#projForm');
form.append('<input type="hidden" name="nextPageName" value="'+step+'"/>');
$('#nxt').attr({"disabled":"disabled"});
jboxStartLoading();
form.submit();
}

</script>
</c:if>
<style type="text/css">
 .bs_tb tbody td input{text-align: left;margin-left: 10px;}
</style>
	<form action="<s:url value='/srm/proj/mine/saveStep'/>" method="post"
		id="projForm" style="position: relative;">
		<input type="hidden" id="pageName" name="pageName" value="step1" /> 
		<input type="hidden" id="recFlow" name="recFlow" value="${projRec.recFlow}"/>
		<input type="hidden" id="projFlow" name="projFlow" value="${proj.projFlow}"/>
		<input type="hidden" id="recTypeId" name="recTypeId" value="${param.recTypeId}"/>
		<table style="width: 100%;" class="basic">
			<tr><th colspan="3" style="font-size: 14px; text-align:left; padding-left:15px;" >一、基本信息</th></tr>
             <c:choose>
               <c:when test="${param.view == GlobalConstant.FLAG_Y}">
                 <tr>
            	<td width="150px"  rowspan="2" style="text-align:center; font-size: 14px;">项目名称</td>
                <td width="80px" style="text-align: center;padding:0px;">中文</td>
                <td style="text-align: left;padding-left: 20px;">
                  ${resultMap.zhName}
                </td>
            </tr>
            <tr>
            	<td style="text-align: center;padding:0px;">英文</td>
                <td style="text-align: left;padding-left: 20px;">
                 ${resultMap.enName}
            </tr>
            <tr>
            	<td colspan="2" style="text-align: center;" >申报学科</td>
                <td style="text-align: left;padding-left: 20px;">
                ${resultMap.subjectName}&#12288;&#12288;&#12288;
                  <font >代码：</font> 
                ${resultMap.subjectCode}
                </td>
            </tr>
            <tr>
            	<td colspan="2" style="text-align: center;" >完成单位</td>
                <td>
                &#12288;&nbsp;${resultMap.finishOrg}
                </td>
            </tr>
            <tr>
                <td colspan="2" style="text-align: center;">主要完成人</td>
                <td colspan="3" style="padding-left: 20px;">
                   <c:if test="${not empty resultMap.finishUser1 }">
                   1.&#12288;${resultMap.finishUser1}&#12288;
                   </c:if>
                   <c:if test="${not empty resultMap.finishUser2 }">
                   2.&#12288;${resultMap.finishUser2}&#12288;
                   </c:if>
                   <c:if test="${not empty resultMap.finishUser3 }">
                   3.&#12288;${resultMap.finishUser3}&#12288;
                   </c:if>
                </td>
            </tr>
            <tr>
            	<td colspan="2" style="text-align: center;">申报奖励等级</td>
                <td colspan="3" style="padding-left: 20px;">
                	<c:forEach items="${projRewardLevelEnumList }" var="reward">
					 <input type="radio" class="validate[required]" name="rewardLevel" id="RewardLevel_${reward.id }" value="${reward.id }" <c:if test='${resultMap.rewardLevel eq reward.id}'>checked="checked"</c:if>/>
					 <label for="RewardLevel_${reward.id }">${reward.name}</label>&#12288;&#12288;
                    </c:forEach>
                </td>
            </tr>
            <tr>
            	<td colspan="2" style="text-align: center;">项目首创单位</td>
                <td style="padding-left: 20px;">
                  ${resultMap.firstCreateOrg}
                  &#12288;&#12288;<font >时间：</font>
                  &#12288;${resultMap.firstCreateTime}
                </td>
            </tr>
            <tr>
            	<td colspan="2" style="text-align: center;">项目首用单位</td>
                <td style="padding-left: 20px;" >
                  ${resultMap.firstUseOrg}
                   &#12288;&#12288;<font >时间：</font>
                  &#12288;${resultMap.firstUseTime}
                </td>
            </tr>
            <tr>
            	<td colspan="2" style="text-align: center;">国内首用单位</td>
                <td colspan="3" style="padding-left: 20px;">
                   ${resultMap.inlandFirstUseOrg}
                </td>
            </tr>
            <tr>
            	<td colspan="2" style="text-align: center;">本单位引进时间</td>
                <td colspan="3" style="padding-left: 20px;">
                ${resultMap.selfOrgImpTime}
                </td>
            </tr>
            <tr>
            	<td colspan="2" style="text-align: center;">联系人</td>
                <td style="padding-left: 20px;">
                 ${resultMap.contactUser}
                &#12288;&#12288;<font >电话：</font>
                &#12288;${resultMap.contactPhone}
                </td>
            </tr>
               </c:when>
               
             <c:otherwise>
            <tr>
            	<td width="150px"  rowspan="2" style="text-align: center;">项目名称</td>
                <td width="80px" style="text-align: center;padding:0px;">中文</td>
                <td style="text-align: left;padding-left: 20px;">
                   <input type="text" class="validate[required] inputText" style="width: 500px" name="zhName" value="<c:if test='${empty resultMap.zhName}'>${proj.projName}</c:if><c:if test='${! empty resultMap.zhName }'>${resultMap.zhName}</c:if>"/>
                   <span class="redspan" style="color: red;padding: 0px;margin-left: 10px;">*</span>
                </td>
            </tr>
            <tr>
            	<td style="text-align: center;">英文</td>
                <td style="text-align: left;padding-left: 20px;"><input type="text" class="inputText"  style="width: 500px"  name="enName" value="${resultMap.enName}"/></td>
            </tr>
            <tr>
            	<td colspan="2" style="text-align: center;" >申报学科</td>
                <td style="text-align: left;padding-left: 20px;">
                <input type="text" name="subjectName" class="validate[required] inputText" style="width:250px" value="<c:if test='${empty resultMap.subjectName and param.view != GlobalConstant.FLAG_Y}'>${projInfoMap.subjectName}</c:if><c:if test='${!empty resultMap.subjectName}'>${resultMap.subjectName}</c:if>"/>
                  <span class="redspan" style="color: red;padding: 0px;margin-left: 10px;">*</span>
                  <font >代码：</font> 
                  <input type="text" name="subjectCode" class="inputText" style="width: 200px" value="<c:if test='${empty resultMap.subjectCode}'>${projInfoMap.subjectCode}</c:if><c:if test='${! empty resultMap.subjectCode}'>${resultMap.subjectCode}</c:if>"/>
                </td>
            </tr>
            <tr>
            	<td colspan="2" style="text-align: center;">完成单位</td>
                <td colspan="3" style="text-align: left;padding-left: 20px;"><input type="text" class="validate[required] inputText" style="width: 250px" name="finishOrg" value="<c:if test='${empty resultMap.finishOrg and param.view != GlobalConstant.FLAG_Y}'>${proj.applyOrgName}</c:if><c:if test='${!empty resultMap.finishOrg}'>${resultMap.finishOrg}</c:if>"/>
                <span class="redspan" style="color: red;padding: 0px;margin-left: 10px;">*</span>
                </td>
                
            </tr>
            <tr>
                <td colspan="2" style="text-align: center;">主要完成人</td>
                <td colspan="3" style="padding-left: 20px;">
                	1.&#12288;<input type="text" class="validate[required] inputText"   name="finishUser1" value="${resultMap.finishUser1}"/><span class="redspan" style="color: red;padding: 0px;margin-left: 10px;">*</span>&#12288;
                	2.&#12288;<input type="text" class="inputText"  name="finishUser2" value="${resultMap.finishUser2}"/>&#12288;
                	3.&#12288;<input type="text" class="inputText"   name="finishUser3" value="${resultMap.finishUser3}"/>
                    
                </td>
            </tr>
            <tr>
            	<td colspan="2" style="text-align: center;">申报奖励等级</td>
                <td colspan="3" style="padding-left: 20px;">
                	<c:forEach items="${projRewardLevelEnumList }" var="reward">
					 <input type="radio" class="validate[required]" name="rewardLevel" id="RewardLevel_${reward.id }" value="${reward.id }" <c:if test='${resultMap.rewardLevel eq reward.id}'>checked="checked"</c:if>/>
					 <label for="RewardLevel_${reward.id }">${reward.name}</label>&#12288;&#12288;
                    </c:forEach>
                     <span class="redspan" style="color: red;padding: 0px;margin-left: 10px;">*</span>
                </td>
            </tr>
            <tr>
            	<td colspan="2" style="text-align: center;">项目首创单位</td>
                <td style="padding-left: 20px;">
                  <input type="text" class="inputText" style="width: 33%" name="firstCreateOrg" value="${resultMap.firstCreateOrg}"/>
                  &#12288;<font >时间：</font>
                  <input type="text" class="inputText" style="width: 150px" name="firstCreateTime" value="${resultMap.firstCreateTime}" readonly="readonly"  onClick="WdatePicker({dateFmt:'yyyy-MM-dd'})" />
                </td>
            </tr>
            <tr>
            	<td colspan="2" style="text-align: center;">项目首用单位</td>
                <td style="padding-left: 20px;" >
                  <input type="text" class="inputText" style="width: 33%" name="firstUseOrg" value="${resultMap.firstUseOrg}"/>
                   &#12288;<font >时间：</font>
                  <input type="text" class="inputText" style="width: 150px" name="firstUseTime" value="${resultMap.firstUseTime}" readonly="readonly"  onClick="WdatePicker({dateFmt:'yyyy-MM-dd'})" />
                </td>
            </tr>
            <tr>
            	<td colspan="2" style="text-align: center;">国内首用单位</td>
                <td colspan="3" style="padding-left: 20px;">
                   <input type="text" class="inputText" style="width:250px" name="inlandFirstUseOrg" value="${resultMap.inlandFirstUseOrg}"/>
                </td>
            </tr>
            <tr>
            	<td colspan="2" style="text-align: center;">本单位引进时间</td>
                <td colspan="3" style="padding-left: 20px;">
                <input type="text" class="validate[required] inputText" style="width: 200px" name="selfOrgImpTime" value="${resultMap.selfOrgImpTime}" readonly="readonly"  onClick="WdatePicker({dateFmt:'yyyy-MM-dd'})"   />
                <span class="redspan" style="color: red;padding: 0px;margin-left: 10px;">*</span>
                </td>
            </tr>
            <tr>
            	<td colspan="2" style="text-align: center;">联系人</td>
                <td style="padding-left: 20px;">
                 <input type="text" class="validate[required] inputText" style="width: 250px" name="contactUser" value="<c:if test='${empty resultMap.contactUser and param.view != GlobalConstant.FLAG_Y}'>${proj.applyUserName}</c:if><c:if test='${!empty resultMap.contactUser}'>${resultMap.contactUser}</c:if>"/>
                 <span class="redspan" style="color: red;padding: 0px;margin-left: 10px;">*</span>
                <font >电话：</font>
                <input type="text" class="validate[required] inputText" style="width: 200px" name="contactPhone" value="<c:if test='${empty resultMap.contactPhone and param.view != GlobalConstant.FLAG_Y}'>${user.userPhone}</c:if><c:if test='${!empty resultMap.contactPhone}'>${resultMap.contactPhone}</c:if>"/>
                <span class="redspan" style="color: red;padding: 0px;margin-left: 10px;">*</span>
                </td>
            </tr>
           </c:otherwise>
           </c:choose>
        </table>
		
	</form>
	 <div class="button" style="width: 100%; <c:if test="${param.view == GlobalConstant.FLAG_Y}">display:none</c:if>">
	     <input id="nxt" type="button" onclick="nextOpt('step2')" class="search" value="下一步"/>
    </div>
