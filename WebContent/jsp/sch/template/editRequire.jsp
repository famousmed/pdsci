<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@include file="/jsp/common/doctype.jsp" %>
<html>
	<head>
		<jsp:include page="/jsp/common/htmlhead.jsp">
			<jsp:param name="basic" value="true"/>
			<jsp:param name="jbox" value="true"/>
			<jsp:param name="jquery_form" value="true"/>
			<jsp:param name="jquery_ui_tooltip" value="true"/>
			<jsp:param name="jquery_ui_combobox" value="false"/>
			<jsp:param name="jquery_ui_sortable" value="false"/>
			<jsp:param name="jquery_cxselect" value="false"/>
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
			var itemMap = {
					<c:forEach items="${registryTypeEnumList}" var="reg">
						${reg.id}:"${reg.haveItem}",
					</c:forEach>
			};
		
			function saveDeptReq(){
				if($("#deptReqForm").validationEngine("validate")){
					$("#saveButton").attr("disabled",true);
					jboxSubmit($("#deptReqForm"),"<s:url value='/sch/template/saveDeptReq'/>",function(resp){
						if(resp=="${GlobalConstant.SAVE_SUCCESSED}"){
							var typeId = $("[name='recTypeId']").val();
							window.parent.frames['mainIframe'].loadRequire($("[name='recTypeId']").val(),true);
							if(itemMap[typeId] == "${GlobalConstant.FLAG_N}" || "true"=="${deptReq.itemId eq GlobalConstant.RES_REQ_OTHER_ITEM_ID}"){
								jboxClose();
							}
							if(!(itemMap[typeId] == "${GlobalConstant.FLAG_N}" || "true"=="${deptReq.itemId eq GlobalConstant.RES_REQ_OTHER_ITEM_ID}")){
								$("[name='itemName'],[name='reqNum'],[name='reqNote']").val("");
							}
						}
						$("#saveButton").attr("disabled",false);
					},function(resp){
						$("#saveButton").attr("disabled",false);
					},true);
				}
			}
			
			function checkReqType(){
				var typeId = $("[name='recTypeId']").val();
				if(itemMap[typeId] == "${GlobalConstant.FLAG_N}"){
					$("[name='itemName']").val("");
					$("[name='itemName']").closest("tr").hide();
					<c:if test="${empty deptReq}">
					jboxGet("<s:url value='/sch/template/readCaseReq'/>",{relRecordFlow:"${param.relRecordFlow}",recTypeId:typeId},function(resp){
						reSerialize(resp);
					},null,false);
					</c:if>
				}else{
					<c:if test="${empty deptReq.reqFlow}">
						$("[name='reqFlow']").val("");
					</c:if>
					$("[name='itemName']").closest("tr").show();
				}
			}
			
			function reSerialize(data){
				if(data){
					$("#deptReqForm :input").each(function(){
						//var tagName = this.tagName;
						var name = this.name;
						//if(tagName=="SELECT"){this.value=data[name];
							//$(this).find("[value='"+data[name]+"']").attr("selected",true);
						//}else{
							this.value=data[name];
						//}
					});
				}
			}
			
			$(function(){
				<c:if test="${!empty deptReq}">
					$("[name='recTypeId']").attr("disabled",true);;
				</c:if>
				checkReqType();
				<c:if test="${empty deptReq}">
				</c:if>
			});
		</script>
	</head>
<body>
<div class="mainright" align="center">
	<div class="content">
		<div class="title1 clearfix" align="left">
			<form method="post" id="deptReqForm">
			<input type="hidden" name="reqFlow" value="${deptReq.reqFlow}">
			<input type="hidden" name="relRecordFlow" value="${param.relRecordFlow}">
			<input type="hidden" name="rotationFlow" value="${param.rotationFlow}">
			<table class="basic" width="100%">
				<tr>
					<th width="40%">要求类别</th>
					<td>
						<select name="recTypeId" class="xlselect validate[required]" style="margin-right: 0px" onchange="checkReqType();">
							<c:forEach items="${registryTypeEnumList}" var="regType">
								<c:set value="res_registry_type_${regType.id}" var="viewCfgKey"/>
								<c:if test="${sysCfgMap[viewCfgKey] eq GlobalConstant.FLAG_Y && GlobalConstant.FLAG_Y eq regType.haveReq}">
									<option value="${regType.id}" ${(regType.id eq param.recTypeId || regType.id eq deptReq.recTypeId)?'selected':''}>${regType.name}</option>
								</c:if>
							</c:forEach>
						</select>
						<font color="red">*</font>
					</td>
				</tr>
				<tr>
					<th width="40%">子项名称</th>
					<td>
						<c:if test="${deptReq.itemId eq GlobalConstant.RES_REQ_OTHER_ITEM_ID}">
							<label>${deptReq.itemName}</label>
						</c:if>
						<c:if test="${!(deptReq.itemId eq GlobalConstant.RES_REQ_OTHER_ITEM_ID)}">
							<input type="text" name="itemName" value="${deptReq.itemName}" class="xltext validate[required]" style="margin-right: 0px"/>
							<font color="red">*</font>
						</c:if>
					</td>
				</tr>
				<tr>
					<th width="40%">要求例数</th>
					<td>
						<input type="text" name="reqNum" value="${deptReq.reqNum}" class="xltext validate[required,custom[integer]]" style="margin-right: 0px"/>
						<font color="red">*</font>
					</td>
				</tr>
				<tr>
					<th width="40%">要求说明</th>
					<td>
						<textarea name="reqNote" class="xltxtarea" style="margin-left: 0px;resize:none;">${deptReq.reqNote}</textarea>
					</td>
				</tr>
			</table>
			</form>
			<div align="center" style="margin-top: 10px;">
					<input id="saveButton" type="button" value="保&#12288;存" class="search" onclick="saveDeptReq();"/>
					<input type="button" value="关&#12288;闭" class="search" onclick="jboxClose();"/>
				</div>
		</div>
	</div>
</div>
</body>
</html>