<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@include file="/jsp/common/doctype.jsp" %>
<jsp:include page="/jsp/common/htmlhead.jsp">
	<jsp:param name="basic" value="true"/>
	<jsp:param name="jbox" value="true"/>
	<jsp:param name="jquery_form" value="true"/>
	<jsp:param name="jquery_ui_tooltip" value="true"/>
	<jsp:param name="jquery_ui_combobox" value="false"/>
	<jsp:param name="jquery_ui_sortable" value="false"/>
	<jsp:param name="jquery_cxselect" value="true"/>
	<jsp:param name="jquery_scrollTo" value="false"/>
	<jsp:param name="jquery_jcallout" value="false"/>
	<jsp:param name="jquery_validation" value="true"/>
	<jsp:param name="jquery_datePicker" value="true"/>
	<jsp:param name="jquery_fullcalendar" value="false"/>
	<jsp:param name="jquery_fngantt" value="false"/>
	<jsp:param name="jquery_fixedtableheader" value="true"/>
	<jsp:param name="jquery_placeholder" value="true"/>
	<jsp:param name="jquery_iealert" value="false"/>
</jsp:include>
<script type="text/javascript">
function updateUser(obj,userCategory,contractFlow,isSingle) {
	var operFlag = "${GlobalConstant.FLAG_Y}";
	if (!obj.checked) {
		operFlag = "${GlobalConstant.FLAG_N}";
	}
	var datas = {
			contractFlow:contractFlow,
			userFlow:"${customerUser.userFlow}",
			userCategory:userCategory,
			operFlag:operFlag,
			isSingle:isSingle
	}
	var url = "<s:url value='/erp/crm/updateUser'/>";
	jboxPost(url, datas,
		function(resp){
			if(resp == "${GlobalConstant.SAVE_SUCCESSED}"){ 
				//处理页面展示
				if (userCategory=="${userCategoryEnumUser.id}") {
					if (obj.checked) {
						$('#'+contractFlow+'_productSpan').show();
						//若只有一个产品/项目，则默认选中该产品/项目
						if (isSingle=="${GlobalConstant.FLAG_Y}") {
							$("[name='"+contractFlow+"_productFlow'] :eq(0)").attr("checked",true);	
						} 
					} else {
						$('#'+contractFlow+'_productSpan').hide();
						$("[name='"+contractFlow+"_productFlow']").each(function(){
							$(this).attr("checked",false);
						});
					}
				}
			}
	},null,false);
}

function updateUserRef(recordFlow,obj,userCategoryId,productFlow,contractFlow) {
	var operFlag = "${GlobalConstant.FLAG_Y}";
	if (!obj.checked) {
		operFlag = "${GlobalConstant.FLAG_N}";
	}
	var datas = {
			recordFlow:recordFlow,
			userCategoryId:userCategoryId,
			operFlag:operFlag,
			productFlow:productFlow,
			userFlow:"${customerUser.userFlow}",
			contractFlow:contractFlow
	}
	var url = "<s:url value='/erp/crm/updateUserRef'/>";
	jboxPost(url, datas,null,null,false);
}

function doClose(){
	window.parent.frames['jbox-message-iframe'].window.searchUserList();
	jboxClose();
}
</script>
<div class="mainright">
<div class="content">
	<div>
	姓名：<font color="red">${customerUser.userName }</font>&#12288;科室：${customerUser.deptName }&#12288;职务：${customerUser.postName }
	</div>
	<div class="title1 clearfix">
		<table class="xllist nofix">
			<colgroup>
				<col width="25%"/>
				<col width="10%"/>
				<col width="10%"/>
				<col width="55%"/>
			</colgroup>
			<thead>
			<tr>
				<th>合同名称</th>
				<th>合同类别</th>
				<th>签订日期</th>
				<th>人员类别</th>
			</tr>
			</thead>
			<tbody>
			<c:forEach items="${contractList }" var="contract">
			   <tr>
			      <c:set var="isSingle" value="${productMap[contract.contractFlow].size()<2?GlobalConstant.FLAG_Y:GlobalConstant.FLAG_N }"></c:set>
			      <td>
			        ${contract.contractName}
			       </td>
				  <td>${contract.contractCategoryName}</td>
				  <td>${contract.signDate}</td>
				  <td style="text-align: left;padding-left: 10px;">
				     <c:forEach items="${userCategoryEnumList}" var="userCategory">
				         <c:if test="${(sessionScope.userListScope==GlobalConstant.USER_LIST_LOCAL and (userCategory.id eq userCategoryEnumBusiness.id or userCategory.id eq userCategoryEnumUser.id)) or
										(sessionScope.userListScope==GlobalConstant.USER_LIST_PERSONAL and userCategory.id eq userCategoryEnumTechnical.id)}">
							<input type="checkbox" id="${contract.contractFlow}_${userCategory.id }" name="userCategoryId" value="${userCategory.id }"			
						    onchange="updateUser(this,'${userCategory.id }','${contract.contractFlow }','${isSingle }');" 
						    ${pdfn:contains(contractUserMap[contract.contractFlow].userCategoryId,userCategory.id)?'checked':'' }>
						    <label for="${contract.contractFlow}_${userCategory.id }">${userCategory.name }&nbsp;</label>
						    <c:if test="${userCategory.id eq userCategoryEnumUser.id }">
						        <span id="${contract.contractFlow}_productSpan" style="display:${pdfn:contains(contractUserMap[contract.contractFlow].userCategoryId,userCategoryEnumUser.id)?'':'none'}">
						                     （<c:forEach var="product" items="${productMap[contract.contractFlow]}" varStatus="status">
								<c:set var="refKey" value="${contractUserMap[contract.contractFlow].recordFlow }_${userCategory.id }_${product.productFlow }"></c:set>
								<c:set var="refRecordFlow" value="${userRefMap[refKey] }"></c:set>
								<input type="checkbox" id="${contract.contractFlow}_${product.productFlow }" name="${contract.contractFlow}_productFlow" value="${product.productFlow }"
								 onchange="updateUserRef('${refRecordFlow }',this,'${userCategory.id }','${product.productFlow }','${contract.contractFlow}');"
								 ${not empty refRecordFlow?'checked':''}>
								<label for="${contract.contractFlow}_${product.productFlow }">${product.productTypeName }<c:if test="${!status.last }">&nbsp;&nbsp;</c:if></label></c:forEach>）
						        </span>
						    </c:if>
						 </c:if>
				     </c:forEach>
				  </td>
			   </tr>
			</c:forEach>
			
			</tbody>
			<c:if test="${empty contractList}">
				<tr>
					<td colspan="4">无记录</td>
				</tr>
			</c:if>
		</table>
		<div class="button">
			<input class="search" type="button" value="关&#12288;闭" onclick="doClose();" />
		</div>
</div>
</div>
</div>
