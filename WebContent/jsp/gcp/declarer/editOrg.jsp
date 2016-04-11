<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@include file="/jsp/common/doctype.jsp" %>
<html>
<head>
<jsp:include page="/jsp/common/htmlhead.jsp">
	<jsp:param name="basic" value="true"/>
	<jsp:param name="jbox" value="true"/>
	<jsp:param name="jquery_form" value="false"/>
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
	function save(){
		var orgProvNameText = $("[name='orgProvId'] option:selected").text();
		if(orgProvNameText=="选择省"){
			orgProvNameText = "";
		}
		var orgCityNameText = $("[name='orgCityId'] option:selected").text();
		if(orgCityNameText=="选择市"){
			orgCityNameText = "";
		}
		var orgAreaNameText = $("[name='orgAreaId'] option:selected").text();
		if(orgAreaNameText=="选择地区"){
			orgAreaNameText = "";
		}
		$("[name='orgProvName']").val(orgProvNameText);
		$("[name='orgCityName']").val(orgCityNameText);
		$("[name='orgAreaName']").val(orgAreaNameText);
		if($("#orgForm").validationEngine("validate")){
			var url = "<s:url value='/gcp/declarer/saveOrg'/>";
			var getdata = $('#orgForm').serialize();
			jboxPost(url, getdata, function(data) {
				if('${GlobalConstant.SAVE_SUCCESSED}'==data){
					window.parent.frames['mainIframe'].window.search(); 
					jboxClose();	
				}
			});
		}
	}
</script>
</head>
	<body>
		<div class="mainright">
			<div class="content">
				<div class="title1 clearfix">
					<form id="orgForm" method="post" >
						<input type="hidden" name="userFlow" value="${user.userFlow}" />
						<input type="hidden" name="orgFlow" value="${org.orgFlow}" />
						<input type="hidden" name="orgProvName" />
						<input type="hidden" name="orgCityName" />
						<input type="hidden" name="orgAreaName" />
						<table class="basic" style="width: 100%"> 
							<tr>
								<th colspan="4" style="text-align: left;padding-left: 10px">申办方信息</th>
							</tr>
							<tr>
								<td width="100px" style="text-align: right">申办方名称：</td>
								<td colspan="3">
									<input type="text" name="orgName" value="${org.orgName}" class="xltext validate[required]" style="width: 400px;"/>
									<font color="red">*</font>
								</td>
							</tr>
							<tr>
								<td style="text-align: right">所属地区：</td>
								<td colspan="3">
									<span id="provCityAreaId">
										<select id="orgProvId" name="orgProvId" class="province xlselect" data-value="${org.orgProvId}" data-first-title="选择省" style="width: 120px;"></select>
										<select id="orgCityId" name="orgCityId" class="city xlselect" data-value="${org.orgCityId}" data-first-title="选择市" style="width: 120px;"></select>
										<select id="orgAreaId" name="orgAreaId" class="area xlselect" data-value="${org.orgAreaId}" data-first-title="选择地区" style="width: 120px;"></select>
									</span>
									<script type="text/javascript">
										$.cxSelect.defaults.url = "<s:url value='/js/provCityAreaJson.min.json'/>"; 
										$.cxSelect.defaults.nodata = "none"; 
										$("#provCityAreaId").cxSelect({ 
										    selects : ["province", "city", "area"],
										    nodata : "none",
											firstValue : ""
										}); 
									</script>
								</td>
							</tr>
							<tr>
								<td style="text-align: right">地址：</td>
								<td colspan="3"><input type="text" name="orgAddress" value="${org.orgAddress}" class="xltext" style="width: 400px;"/></td>
							</tr>
							<tr><th colspan="4" style="text-align: left;padding-left: 10px">单位负责人</th></tr>
							<tr>
								<td style="text-align: right">姓名：</td>
								<td>
									<input type="text" name="orgInfo.name" value="${orgInfoMap['orgInfo.name']}" class="xltext validate[required]" style="margin-right: 0px"/>
									<font color="red">*</font>
								</td>
								<td width="100px" style="text-align: right">电话：</td>
								<td>
									<input type="text" name="orgInfo.phone" value="${orgInfoMap['orgInfo.phone']}" class="xltext validate[required]" style="margin-right: 0px"/>
									<font color="red">*</font>
								</td>
							</tr>
							<tr><th colspan="4" style="text-align: left;padding-left: 10px">机构帐户信息</th></tr>
							<tr>
								<td style="text-align: right">登录名：</td>
								<td>
									<c:if test="${empty user.userFlow}">
										<input type="text" name="userCode" class="<c:if test="${!(sysCfgMap['sys_user_check_user_code'] eq GlobalConstant.FLAG_N)}">validate[required,custom[userCode]]</c:if> xltext" style="margin-right: 0px"/>
										<font color="red">*</font>
									</c:if>
									<c:if test="${!empty user.userFlow}">
										<font>${user.userCode}</font>
									</c:if>
								</td>
								<td style="text-align: right">姓名：</td>
								<td>
									<input type="text" name="userName" value="${user.userName}" class="validate[required,custom[chinese]] xltext" style="margin-right: 0px"/>
									<font color="red">*</font>
								</td>
							</tr>
							<tr>
								<td style="text-align: right">电话：</td>
								<td>
									<input type="text" name="userPhone" value="${user.userPhone}" class="validate[required,custom[mobile]] xltext" style="margin-right: 0px"/>
									<font color="red">*</font>
								</td>
								<td style="text-align: right">邮箱：</td>
								<td>
									<input type="text" name="userEmail" value="${user.userEmail}" class="validate[required,custom[email]] xltext" style="margin-right: 0px"/>
									<font color="red">*</font>
								</td>
							</tr>
						</table>
					</form>
					<div align="center" style="margin-top: 10px">
						<input type="button" class="search" onclick="save();" value="保&#12288;存">
						<input type="button" class="search" onclick="jboxClose();" value="关&#12288;闭">
					</div>
				</div>
			</div>
		</div>
	</body>
</html>