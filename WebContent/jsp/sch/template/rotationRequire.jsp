<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@include file="/jsp/common/doctype.jsp" %>
<html>
	<head>
<%-- 		<jsp:include page="/jsp/common/htmlhead.jsp"> --%>
<%-- 			<jsp:param name="basic" value="true"/> --%>
<%-- 			<jsp:param name="jbox" value="true"/> --%>
<%-- 			<jsp:param name="jquery_form" value="false"/> --%>
<%-- 			<jsp:param name="jquery_ui_tooltip" value="true"/> --%>
<%-- 			<jsp:param name="jquery_ui_combobox" value="false"/> --%>
<%-- 			<jsp:param name="jquery_ui_sortable" value="false"/> --%>
<%-- 			<jsp:param name="jquery_cxselect" value="false"/> --%>
<%-- 			<jsp:param name="jquery_scrollTo" value="false"/> --%>
<%-- 			<jsp:param name="jquery_jcallout" value="false"/> --%>
<%-- 			<jsp:param name="jquery_validation" value="true"/> --%>
<%-- 			<jsp:param name="jquery_datePicker" value="true"/> --%>
<%-- 			<jsp:param name="jquery_fullcalendar" value="false"/> --%>
<%-- 			<jsp:param name="jquery_fngantt" value="false"/> --%>
<%-- 			<jsp:param name="jquery_fixedtableheader" value="true"/> --%>
<%-- 			<jsp:param name="jquery_placeholder" value="true"/> --%>
<%-- 			<jsp:param name="jquery_iealert" value="false"/> --%>
<%-- 		</jsp:include> --%>
		
		<script type="text/javascript">
			function loadRequire(recTypeId,selTab){
				jboxLoad("tagContent","<s:url value='/sch/template/requireList'/>?roleFlag=${param.roleFlag}&relRecordFlow=${rotationDept.recordFlow}&recTypeId="+recTypeId,true);
				if(selTab){
					$("#"+recTypeId).click();
				}
			}
			
			//标签高亮
			function selTag(tag){
				$(".selectTag").removeClass("selectTag");
				$(tag).addClass("selectTag");
			}
			
			$(function(){
				if($("#tags li").length){
					<c:if test="${empty param.recTypeId}">
						$("#tags li:eq(0)").click();
						location.href = $(".selectTag a").attr("href");
					</c:if>
					<c:if test="${!empty param.recTypeId}">
						selTag($("#${param.recTypeId}"));
						location.href = $(".selectTag a").attr("href");
					</c:if>
				}
				
// 				$("#rotationDetailTitle").on("mouseenter mouseleave",function(){
// 					$("#rotationDetail").toggle();
// 				});
			});
			
			function back(){
				$("#reqCfg").rightSlideClose();
				//location.href = "<s:url value='/sch/template/rule'/>?roleFlag=${param.roleFlag}&speId=${param.speId}&sessionNumber=${param.sessionNumber}&rotationFlow=${rotation.rotationFlow}";
			}
			
			function editDeptReq(reqFlow){
				var title = "新增";
				if(reqFlow!=null && reqFlow!=''){
					title = "编辑";
				}
				jboxOpen("<s:url value='/sch/template/editDeptReq'/>?rotationFlow=${rotation.rotationFlow}&relRecordFlow=${rotationDept.recordFlow}&reqFlow="+reqFlow+"&recTypeId="+$(".selectTag").prop("id"),title+"轮转要求",500,350);
			}
			
			function delDeptReq(reqFlow,recTypeId){
				jboxConfirm("确认删除该记录?",function(){
					jboxPost("<s:url value='/sch/template/saveDeptReq'/>",{"reqFlow":reqFlow,"recordStatus":"${GlobalConstant.RECORD_STATUS_N}"},function(resp){
						if(resp=="${GlobalConstant.DELETE_SUCCESSED}"){
							loadRequire(recTypeId,true);
						}
					},null,true);
				},null);
			}
			
			function selRotationDept(recordFlow){
				var url = "<s:url value='/sch/template/rotationRequire'/>?roleFlag=${param.roleFlag}&rotationFlow=${rotation.rotationFlow}&recordFlow="+recordFlow+"&recTypeId="+$(".selectTag")[0].id;
				reqReload(url);
			}
		</script>
	</head>
<body>
<c:set value="schUnitEnum${sysCfgMap['res_rotation_unit']}" var="unitKey"/>
<div class="mainright" align="center" style="height: 100%;background-color: white;">
	<div class="content">
		<div class="title1 clearfix" align="left">
			<table style="width: 100%;margin-bottom: 10px;" class="basic">
				<tr>
					<td style="text-align: left;padding-left: 10px;">
						<select style="height: 27px;width: 148px;" onchange="selRotationDept(this.value);">
							<c:forEach items="${rotationDeptList}" var="rotationDeptTemp">
								<option 
								value="${rotationDeptTemp.recordFlow}"
								<c:if test="${rotationDeptTemp.recordFlow eq rotationDept.recordFlow}">selected</c:if>
								>
								（${groupMap[rotationDeptTemp.groupFlow].groupName}）
								${rotationDeptTemp.standardDeptName}
								</option>
							</c:forEach>
						</select>
						&#12288;
						<input type="button" value="关&#12288;闭" class="search" onclick="back();"/>
					</td>
				</tr>
			</table>
			
			<table class="basic" width="100%" style="margin-bottom: 10px;">
				<tr>
					<td width="45%" style="text-align: left;padding-left: 10px;"><font style="font-weight: bolder;">培训方案名称 ：</font>${rotation.rotationName}</td>
					<td width="25%" style="text-align: left;padding-left: 10px;"><font style="font-weight: bolder;">培训专业：</font>${rotation.speName}</td>
					<td width="30%" style="text-align: left;padding-left: 10px;" colspan="2"><font style="font-weight: bolder;">年限：</font>${rotation.rotationYear}</td>
				</tr>
				<tr>
					<td width="45%" style="text-align: left;padding-left: 10px;"><font style="font-weight: bolder;">标准科室 ：</font>${rotationDept.standardDeptName}</td>
					<td width="25%" style="text-align: left;padding-left: 10px;"><font style="font-weight: bolder;">轮转时间(${applicationScope[unitKey].name})：</font>${rotationDept.schMonth}</td>
					<td style="text-align: left;padding-left: 10px;"><font style="font-weight: bolder;">是否必轮：</font>${rotationDept.isRequired eq GlobalConstant.FLAG_Y?'是':'否'}</td>
					<c:if test="${rotationDept.isRequired eq GlobalConstant.FLAG_N}">
						<td style="text-align: left;padding-left: 10px;"><font style="font-weight: bolder;">组合名称：</font>${groupMap[rotationDept.groupFlow].groupName}</td>
					</c:if>
				</tr>
			</table>
			
			<div style="float: left;width: 100%;">
				<input id="reqAddBtn" type="button" value="新&#12288;增" class="search" onclick="editDeptReq('');" style="float: right;margin-right: 10px;"/>
				<ul id="tags" style="width: 80%;">
					<c:forEach items="${registryTypeEnumList}" var="registryType">
						<c:set value="res_registry_type_${registryType.id}" var="viewCfgKey"/>
						<c:if test="${sysCfgMap[viewCfgKey] eq GlobalConstant.FLAG_Y && GlobalConstant.FLAG_Y eq registryType.haveReq}">
		        			<li id="${registryType.id}" onclick="selTag(this);"><a style="cursor: pointer;" href="javascript:loadRequire('${registryType.id}',false);">${registryType.name}</a></li>
		        		</c:if>
					</c:forEach>
		        </ul>
		        
		        <div id="tagContent">
		        	
		        </div>
			</div>
		</div>
	</div>
</div>
</body>
</html>