<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<c:if test="${param.view!=GlobalConstant.FLAG_Y }">
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
    <input type="hidden" name="pageName" value="step1"/>
	<input type="hidden" id="recFlow" name="recFlow" value="${projRec.recFlow}"/>
	<input type="hidden" id="projFlow" name="projFlow" value="${proj.projFlow}"/>
	<input type="hidden" name="recTypeId" value="${param.recTypeId}"/>
	<table id="table1" width="100%" cellspacing="0" cellpadding="0" class="basic">
	    <tbody>
		    <tr>
			    <th colspan="7"  style="text-align: left;padding-left: 15px;font-size: 14px;font-weight: bold;">一、项目概况</th>
			</tr>
	        <tr>
	           <td style="text-align: right;"> 单位名称：</td>
	           <td><input type="text" name="orgName" value="${user.orgName}" class="inputText" /></td>
	           <td style="text-align: right;"> 通信地址：</td>
	           <td><input type="text" name="orgAddress" class="inputText" <c:if test="${empty resultMap.orgAddress}">value="${org.orgAddress}"</c:if><c:if test="${! empty resultMap.orgAddress}">value="${resultMap.orgAddress}"</c:if>/></td>
	        </tr>
	        <tr>
	           <td style="text-align: right;"> 联系人：</td>
	           <td><input type="text" name="userName" class="inputText" <c:if test='${empty resultMap.userName}'>value='${user.userName}'</c:if><c:if test='${! empty resultMap.userName}'>value='${resultMap.userName}'</c:if>/></td>
	           <td style="text-align: right;">联系电话：</td>
    		   <td><input name="userPhone"  <c:if test='${empty resultMap.userPhone}'>value='${user.userPhone}'</c:if><c:if test='${! empty resultMap.userPhone}'>value='${resultMap.userPhone}'</c:if> class="inputText"/></td>
	        </tr>
	        <tr>
	           <td style="text-align: right;">邮政编码：</td>
			   <td>
				 <input name="addressId"  <c:if test="${empty resultMap.addressId}">value="${contractMap.addressId}"</c:if><c:if test="${! empty resultMap.addressId}">value="${resultMap.addressId}"</c:if> class="inputText"/>
			   </td>
			   <td style="text-align: right;">电子邮箱：</td>
			   <td><input name="userEmail" class="inputText" <c:if test="${empty resultMap.userEmail}">value="${user.userEmail}"</c:if><c:if test="${! empty resultMap.userEmail}">value="${resultMap.userEmail}"</c:if>/></td>
	        </tr>
	        <tr>
	            <td style="text-align: right;">项目主管部门：</td>
			    <td><input name="chargeOrg"  <c:if test="${empty resultMap.chargeOrg}">value="${contractMap.chargeOrg}"</c:if><c:if test="${! empty resultMap.chargeOrg}">value="${resultMap.chargeOrg}"</c:if>  class="inputText"/></td>
	            <td style="text-align: right;">项目开始时间：</td>
				<td style="text-align: left;">
					<input name="projStartTime"  <c:if test="${empty resultMap.projStartTime}">value="${contractMap.projStartTime}"</c:if><c:if test="${! empty resultMap.projStartTime}">value="${resultMap.projStartTime}"</c:if> class="inputText" onClick="WdatePicker({dateFmt:'yyyy-MM-dd'})"/>
				</td>
	        </tr>
	        <tr>
	           <td style="text-align: right;">项目结束时间：</td>
			   <td style="text-align: left;">
			  	 <input name="projEndTime"  <c:if test="${empty resultMap.projEndTime}">value="${contractMap.projEndTime}"</c:if><c:if test="${! empty resultMap.projEndTime}">value="${resultMap.projEndTime}"</c:if> class="inputText"  onClick="WdatePicker({dateFmt:'yyyy-MM-dd'})"/>
			   </td>
	           <td style="text-align: right;">验收形式：</td>
	           <td><input class="inputText" type="text" name="checkType" value="${resultMap.checkType }"/></td>
	        </tr>
            <tr>
               <td style="text-align: right;">计划验收时间：</td>
	           <td style="text-align: left;">
	           	<input class="inputText"  onClick="WdatePicker({dateFmt:'yyyy-MM-dd'})" type="text" name="checkTime" value="${resultMap.checkTime }" />
	           </td>
	           
               <td style="text-align: right;"> 验收地点：</td>
	           <td><input class="inputText" type="text" name="checkPlace" value="${resultMap.checkPlace }"/></td>
	        </tr>       
	        <tr>
	           <td style="text-align: right;"> 专利申请：</td>
	           <td><input class="inputText" type="text" name="patentApply" value="${resultMap.patentApply }"/></td>
	           <td style="text-align: right;"> 专利授权：</td>
	           <td><input class="inputText" type="text" name="patentAuthorize" value="${resultMap.patentAuthorize }"/></td>
	        </tr>  
	        <tr>
	           <td style="text-align: right;"> 论文总数：</td>
	           <td><input class="inputText" type="text" name="thesisCount" value="${resultMap.thesisCount }"/></td>
	           <td style="text-align: right;"> SCI总数：</td>
	           <td> <input class="inputText" type="text" name="sciCount" value="${resultMap.sciCount }"/></td>
	        </tr>
	        <tr>
	           <td style="text-align: right;"> EI总数：</td>
	           <td colspan="3" style="text-align: left;"> 
	           	<input class="inputText"  type="text" name="eiCount" value="${resultMap.eiCount }"/>
	           </td>
	        </tr>
	        <tr>
	           <td style="text-align: right;"> 成果形式：</td>
	           <td colspan="3">
	             <c:forEach items="${achTypeEnumList }" var="achType">
	             	<c:if test='${achType.id != achTypeEnumAppraisal.id}'>
	               		<input type="checkbox" name="resultType" value="${achType.id }" id="resultType__${achType.id }"<c:forEach var="op" items="${resultMap.resultType }"><c:if test="${op eq achType.id}">checked="checked"</c:if></c:forEach>/><label for="resultType_${achType.id }">${achType.name }</label>
	             	</c:if>
	             </c:forEach>
	           </td>
	        </tr>  
	        <tr>
	           <td style="text-align: right;"> 主要研究内容及完成情况：</td>
	           <td colspan="3" style="padding-right: 5px;padding-left: 5px;">
	           <c:choose>
                   <c:when test="${param.view==GlobalConstant.FLAG_Y}">
                    ${resultMap.projContentContent}
                   </c:when>
                 <c:otherwise> 
	           <textarea name="projContentContent" rows="6" cols="20"  class="xltxtarea"><c:if test="${empty resultMap.projContentContent}">${contractMap.projContentContent}</c:if><c:if test="${! empty resultMap.projContentContent}">${resultMap.projContentContent}</c:if></textarea>
	           </c:otherwise>
	           </c:choose>
	           </td>
	        </tr>
	    </tbody>
	</table>
</form>
<c:if test="${param.view!=GlobalConstant.FLAG_Y }">
    <div class="button" style="width: 100%;">
        <input id="nxt" type="button" onclick="nextOpt('step2')" class="search" value="下一步"/>
    </div>
</c:if>
