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
<form action="<s:url value='/srm/proj/mine/saveStep'/>" method="post" id="projForm" style="position: relative;">
    <input type="hidden" id="pageName" name="pageName" value="step1"/>
	<input type="hidden" id="recFlow" name="recFlow" value="${projRec.recFlow}"/>
    <input type="hidden" id="projFlow" name="projFlow" value="${proj.projFlow}"/>
	<input type="hidden" id="recTypeId" name="recTypeId" value="${param.recTypeId}"/>
    <div style="font-size: 14px; font-weight:bold; padding-left: 10px; margin-top: 10px;color: #333; ">一、项目概况 </div>
	<table width="100%" style="margin-top: 10px;" cellpadding="0" cellspacing="0" class="basic">
        <tr>
            <th colspan="11" style="text-align: left; padding-left: 15px;">基本信息</th>
     	</tr>
        <tbody>
		    <c:if test="${not empty resultMap }">
     		    <tr>
     			    <td width="20%" style="text-align: right;">项目名称：</td>
					<td colspan="3" ><input type="text" name="projName" value="${resultMap.projName}"  class="inputText validate[required]" style="width:80%;"/></td>
     			</tr>
     			<tr>
     			    <td width="20%" style="text-align: right;">单位名称：</td>
					<td width="30%">
					    <input name="orgName" value="${resultMap.orgName}" class="inputText validate[required]"   />
					</td>
					<td width="20%" style="text-align: right;">联系人：</td>
					<td width="30%">
					    <input name="userName" value="${resultMap.userName}" class="inputText validate[required]"  />
					</td>
     			</tr>
     			<tr>
     			    <td width="20%" style="text-align: right;">联系电话：</td>
					<td width="30%"><input name="userPhone" value='${resultMap.userPhone}' class="inputText validate[required]" /></td>
     				<td width="20%" style="text-align: right;">电子邮箱：</td>
	                <td><input name="userEmail" value="${resultMap.userEmail}" class="inputText validate[required]" /></td>
     			</tr>
     		    <tr>
     			    <td width="20%" style="text-align: right;">邮政编码：</td>
	                <td width="30%"><input name="addressId" value="${resultMap.addressId}" class="inputText validate[required]"/></td>
	                <td width="20%" style="text-align: right;">通讯地址：</td>
	                <td><input name="orgAddress" value="${resultMap.orgAddress}" class="inputText validate[required]"/></td>
     			</tr>
     			<tr>
     			    <td width="20%" style="text-align: right;">合同开始时间：</td>
	                <td width="30%"><input name="projStartTime" value="${resultMap.projStartTime}"   class="inputText validate[required]" readonly="readonly" onClick="WdatePicker({dateFmt:'yyyy-MM-dd'})"/></td>
	                <td width="20%" style="text-align: right;">合同结束时间：</td>
	                <td><input name="projEndTime" value="${resultMap.projEndTime}" class="inputText validate[required]"  readonly="readonly" onClick="WdatePicker({dateFmt:'yyyy-MM-dd'})"/></td>
     			</tr>
     			<tr>
     			    <td style="text-align: right;">计划结束时间：</td>
                    <td><input name="planEndTime" value="${resultMap.planEndTime}" class="inputText validate[required]"  readonly="readonly" onClick="WdatePicker({dateFmt:'yyyy-MM-dd'})"/></td>
     				<td style="text-align: right;">主管部门(丙方)：</td>
	                <td><input type="text" name="chargeOrg" value="${resultMap.chargeOrg}" class="inputText validate[required]" /></td>
     			</tr>
     		</c:if>
            <c:if test="${empty resultMap }">
     		    <tr>
     			    <td width="20%" style="text-align: right;">项目名称：</td>
					<td colspan="3"><input type="text" name="projName" value="${contractMap.projName}" class="inputText validate[required]" style="width:50%;"/></td>
     			</tr>
     			<tr>
     			    <td width="20%" style="text-align: right;">单位名称：</td>
					<td width="30%">
					    <input name="orgName" value="${user.orgName}" class="inputText validate[required]"   />
					</td>
					<td width="20%" style="text-align: right;">联系人：</td>
					<td width="30%">
					    <input name="userName" value="${user.userName}" class="inputText validate[required]"  />
					</td>
     			</tr>
     			<tr>
     			    <td width="20%" style="text-align: right;">联系电话：</td>
					<td width="30%"><input name="userPhone" value='${user.userPhone}' class="inputText validate[required]" /></td>
     				<td width="20%" style="text-align: right;">电子邮箱：</td>
	                <td><input name="userEmail" value="${user.userEmail}" class="inputText validate[required]" /></td>
     			</tr>
     			<tr>
     			    <td width="20%" style="text-align: right;">邮政编码：</td>
	                <td width="30%"><input name="addressId" value="${contractMap.addressId}" class="inputText validate[required]"/></td>
	                <td width="20%" style="text-align: right;">通讯地址：</td>
	                <td><input name="orgAddress" value="${org.orgAddress}" class="inputText validate[required]"/></td>
     			</tr>
     			<tr>
     			    <td width="20%" style="text-align: right;">合同开始时间：</td>
	                <td width="30%"><input name="projStartTime" value="${contractMap.projStartTime}"   class="inputText validate[required]" readonly="readonly" onClick="WdatePicker({dateFmt:'yyyy-MM-dd'})"/></td>
	                <td width="20%" style="text-align: right;">合同结束时间：</td>
	                <td><input name="projEndTime" value="${contractMap.projEndTime}" class="inputText validate[required]"  readonly="readonly" onClick="WdatePicker({dateFmt:'yyyy-MM-dd'})"/></td>
     			</tr>
     			<tr>
     			    <td style="text-align: right;">计划结束时间：</td>
                    <td><input name="planEndTime" value="${resultMap.planEndTime}" class="inputText validate[required]"  readonly="readonly" onClick="WdatePicker({dateFmt:'yyyy-MM-dd'})"/></td>
     			    <td style="text-align: right;">主管部门(丙方)：</td>
	                <td><input type="text" name="chargeOrg" value="${resultMap.chargeOrg}" class="inputText validate[required]" /></td>
     			</tr>
     		</c:if>
     	</tbody>
    </table>
    <table width="100%" cellspacing="0" cellpadding="0" class="basic" style="border-top: none;">
        <tr>
            <th colspan="11" style="text-align: left; padding-left: 20px;margin-top: 15px;">合同内容和指标：</th>
        </tr>
        <tr>
            <td>
                <c:choose>
                    <c:when test="${param.view==GlobalConstant.FLAG_Y}">
                        ${resultMap.projContentTarget}
                    </c:when>
                    <c:otherwise>
               	        <textarea placeholder="此处填写该项目合同内容和指标" name="projContentTarget" class="xltxtarea" ><c:choose><c:when test="${! empty resultMap.projContentTarget and resultMap.projContentTarget !='' }">${resultMap.projContentTarget}</c:when><c:otherwise>${contractMap.projContentTarget }</c:otherwise></c:choose></textarea>
                    </c:otherwise>
               </c:choose>
           </td>
       </tr>
       <tr>
           <th colspan="11" style="text-align: left; padding-left: 15px;">实际完成情况：</th>
       </tr>
       <tr>
           <td>
               <c:choose>
                   <c:when test="${param.view==GlobalConstant.FLAG_Y}">
                       ${resultMap.projContentTarget}
                   </c:when>
                   <c:otherwise>
                       <textarea placeholder="此处填写该项目的实际完成情况" name="finishContent" class="xltxtarea validate[required]">${resultMap.finishContent}</textarea>
                   </c:otherwise>
               </c:choose> 
           </td>
       </tr>
       <tr>
           <th colspan="11" style="text-align: left; padding-left: 15px;">项目中止撤销原因详细说明：</th>
       </tr>
       <tr>
           <td>
               <c:choose>
                   <c:when test="${param.view==GlobalConstant.FLAG_Y}">
                       ${resultMap.projContentTarget}
                   </c:when>
                   <c:otherwise>
                       <textarea placeholder="此处填写该项目的中止撤销原因" name="terminateReason" class="xltxtarea validate[required]">${resultMap.terminateReason}</textarea>
                   </c:otherwise>
               </c:choose>
           </td>
       </tr>
    </table>
</form>
<div class="button" style="width:100%; <c:if test="${param.view == GlobalConstant.FLAG_Y}">display:none</c:if>">
    <input onclick="nextOpt('step2')" id="nxt" class="search" type="button" value="下一步"/>
</div>
      			   
