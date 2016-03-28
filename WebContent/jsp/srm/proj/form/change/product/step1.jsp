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
.title_sp{padding-left: 10px;font-size: 14px; margin-bottom:10px; margin-top:10px; font-weight: bold;color: #333;}
</style>
<form action="<s:url value='/srm/proj/mine/saveStep'/>" method="post" id="projForm" style="position: relative;">
    <input type="hidden" id="pageName" name="pageName" value="step1"/>
	<input type="hidden" id="recFlow" name="recFlow" value="${projRec.recFlow}"/>
    <input type="hidden" id="projFlow" name="projFlow" value="${proj.projFlow}"/>
	<input type="hidden" id="recTypeId" name="recTypeId" value="${param.recTypeId}"/>
	<div class="title_sp">一、项目概况</div>
	<table width="100%" cellpadding="0" cellspacing="0" class="basic">
        <tr>
            <th colspan="4" style="text-align: left;padding-left: 15px;">基本信息</th>
        </tr>
        <c:if test="${not empty resultMap }">
            <tr>
          	    <td width="20%" style="text-align: right;">项目名称：</td>
    			<td colspan="3"><input type="text" name="projName" value="${resultMap.projName}" class="inputText" style="width:80%;" readonly="readonly"/></td>
          	</tr>
          	<tr>
          	    <td width="20%" style="text-align: right;">单位名称：</td>
    			<td width="30%">
    			    <input name="orgName" value="${resultMap.orgName}" class="inputText"  style="width: 70%;"  />
    			</td>
    			<td width="20%" style="text-align: right;">联系人：</td>
    			<td width="30%">
    			    <input name="userName" value="${resultMap.userName}" class="inputText"  style="width: 70%;" />
    			</td>
          	</tr>
          	<tr>
          	    <td width="20%" style="text-align: right;">联系电话：</td>
    		    <td width="30%"><input name="userPhone" value='${resultMap.userPhone}' class="inputText"  style="width: 70%;"/></td>
          	    <td width="20%" style="text-align: right;">电子邮箱：</td>
			    <td><input name="userEmail" value="${resultMap.userEmail}" class="inputText" style="width: 70%;" /></td>
          	</tr>
          	<tr>
          	    <td width="20%" style="text-align: right;">邮政编码：</td>
				<td width="30%"><input name="addressId" value="${resultMap.addressId}" class="inputText" style="width: 70%;"/></td>
				<td width="20%" style="text-align: right;">通讯地址：</td>
				<td><input name="orgAddress" value="${resultMap.orgAddress}" class="inputText" style="width: 70%;"/></td>
          	</tr>
          	<tr>
          	    <td width="20%" style="text-align: right;">合同开始时间：</td>
				<td width="30%"><input name="projStartTime" value="${resultMap.projStartTime}" class="inputText" readonly="readonly" onClick="WdatePicker({dateFmt:'yyyy-MM-dd'})" style="width: 70%;"/></td>
				<td width="20%" style="text-align: right;">合同结束时间：</td>
				<td><input name="projEndTime" value="${resultMap.projEndTime}" class="inputText" readonly="readonly" onClick="WdatePicker({dateFmt:'yyyy-MM-dd'})" style="width: 70%;"/></td>
          	</tr>
          	<tr>
          	    <td style="text-align: right;">计划结束时间：</td>
                <td><input name="planEndTime" value="${resultMap.planEndTime}" class="inputText" readonly="readonly" onClick="WdatePicker({dateFmt:'yyyy-MM-dd'})" style="width: 70%;"/></td>
          		<td style="text-align: right;">主管部门(丙方)：</td>
				<td><input type="text" name="chargeOrgName" value="${resultMap.chargeOrgName}" class="inputText" style="width: 70%;" /></td>
          	</tr>
        </c:if>
        <c:if test="${empty resultMap }">
            <tr>
          	    <td width="20%" style="text-align: right;">项目名称：</td>
    			<td colspan="3"><input type="text" name="projName" value="${proj.projName}" class="inputText" style="width:80%;" readonly="readonly"/></td>
          	</tr>
          	<tr>
          	    <td width="20%" style="text-align: right;">单位名称：</td>
    			<td width="30%">
    			    <input name="orgName" value="${user.orgName}" class="inputText"   style="width: 70%;" />
    			</td>
    			<td width="20%" style="text-align: right;">联系人：</td>
    			<td width="30%">
    			    <input name="userName" value="${user.userName}" class="inputText"  style="width: 70%;" />
    			</td>
          	</tr>
          	<tr>
          	    <td width="20%" style="text-align: right;">联系电话：</td>
    			<td width="30%"><input name="userPhone" value='${user.userPhone}' class="inputText" style="width: 70%;" /></td>
          		<td width="20%" style="text-align: right;">电子邮箱：</td>
                <td><input name="userEmail" value="${user.userEmail}" class="inputText" style="width: 70%;" /></td>
          	</tr>
          	<tr>
          	    <td width="20%" style="text-align: right;">邮政编码：</td>
				<td width="30%"><input name="addressId" value="${contractMap.addressId}" class="inputText" style="width: 70%;"/></td>
				<td width="20%" style="text-align: right;">通讯地址：</td>
				<td><input name="orgAddress" value="${org.orgAddress}" class="inputText" style="width: 70%;"/></td>
          	</tr>
          	<tr>
          	    <td width="20%" style="text-align: right;">合同开始时间：</td>
				<td width="30%"><input name="projStartTime" value="${contractMap.projStartTime}" class="inputText" readonly="readonly" onClick="WdatePicker({dateFmt:'yyyy-MM-dd'})" style="width: 70%;"/></td>
				<td width="20%" style="text-align: right;">合同结束时间：</td>
				<td><input name="projEndTime" value="${contractMap.projEndTime}" class="inputText"  readonly="readonly" onClick="WdatePicker({dateFmt:'yyyy-MM-dd'})" style="width: 70%;"/></td>
          	</tr>
          	<tr>
          	    <td style="text-align: right;">计划结束时间：</td>
                <td><input name="planEndTime" value="${resultMap.planEndTime}" class="inputText"  readonly="readonly" onClick="WdatePicker({dateFmt:'yyyy-MM-dd'})" style="width: 70%;"/></td>
          		<td style="text-align: right;">主管部门(丙方)：</td>
				<td><input type="text" name="chargeOrgName" value="${resultMap.chargeOrgName}" class="inputText"  style="width: 70%;"/></td>
          	</tr>
        </c:if>
    </table>
	<table width="100%" cellspacing="0" cellpadding="0" class="basic">
	    <tbody>
		    <tr>
			    <th style="text-align: left;padding-left: 15px;">合同内容和指标：</th>
			</tr>
			<tr>
			    <td>
				    <c:choose>
                        <c:when test="${param.view==GlobalConstant.FLAG_Y}">
                            ${resultMap.projContentTarget}
                        </c:when>
                        <c:otherwise>
				            <textarea placeholder="此处填写合同内容和指标" name="projContentTarget" style="width: 98%;height: 150px;" class="xltxtarea"  >${resultMap.projContentTarget}</textarea>
				        </c:otherwise>
				    </c:choose>
				</td>
				</tr>
				<tr>
				    <th style="text-align: left;padding-left: 15px;">申请调整内容：</th>
				</tr>
				<tr>
				    <td>
				        <c:choose>
                            <c:when test="${param.view==GlobalConstant.FLAG_Y}">
                                ${resultMap.changeContent}
                            </c:when>
                            <c:otherwise>
				                <textarea placeholder="此处填写申请调整的内容" name="changeContent" style="width: 98%;height: 150px;" class="xltxtarea" >${resultMap.changeContent}</textarea>
				            </c:otherwise>
				        </c:choose>
				    </td>
				</tr>
				<tr>
				    <th style="text-align: left;padding-left: 15px;">调整原因说明：</th>
				</tr>
				<tr>
				    <td>
				        <c:choose>
                            <c:when test="${param.view==GlobalConstant.FLAG_Y}">
                                ${resultMap.changeReason}
                            </c:when>
                            <c:otherwise>
				                <textarea placeholder="此处填写调整的原因" name="changeReason" style="width: 98%;height: 150px;" class="xltxtarea">${resultMap.changeReason}</textarea>
				            </c:otherwise>
				        </c:choose>
				    </td>
				</tr>
				<tr>
				    <th style="text-align: left;padding-left: 15px;">调整后考核指标：</th>
				</tr>
				<tr>
				    <td>
				        <c:choose>
                            <c:when test="${param.view==GlobalConstant.FLAG_Y}">
                                ${resultMap.afterChangeTarget}
                            </c:when>
                            <c:otherwise>
				                <textarea placeholder="此处填写调整后考核指标" name="afterChangeTarget" style="width: 98%;height: 150px;" class="xltxtarea">${resultMap.afterChangeTarget}</textarea>
				            </c:otherwise>
				        </c:choose>
				    </td>
				</tr>
            </tbody>
    </table>
</form>
<div class="button"  width="100%" style="
    <c:if test="${param.view == GlobalConstant.FLAG_Y}">display:none;</c:if>">
        <input id="nxt" type="button" onclick="nextOpt('step2')" class="search" value="下一步"/>
</div>

