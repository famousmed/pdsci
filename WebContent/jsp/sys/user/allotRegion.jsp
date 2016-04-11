<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>
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
<c:set var="provIds"></c:set>
<c:forEach items="${erpUserRegionPopedomList}" var="erpUserRegionPopedom" varStatus="status">
	<c:set var="provIds" value="${provIds},${erpUserRegionPopedom.provId }"></c:set>
</c:forEach>
<script type="text/javascript">
	function saveRegion() {
		if(false==$("#regionForm").validationEngine("validate")){
			return ;
		}
		var url = '<s:url value="/sys/user/saveRegion"/>';
		jboxPost(url, $('#regionForm').serialize(), function() {
			jboxStartLoading();
			window.parent.frames['jbox-message-iframe'].window.location.reload();
			jboxClose();
		});
	}
	function doCheck(obj){
		$("#"+$(obj).attr('id')+"_name").prop("checked",$("#"+$(obj).attr('id')).prop("checked"));
	}
	function doCheckAll(obj){
		$(obj).parent().next().find("input[type='checkbox']").prop("checked",obj.checked);
	}
	$(document).ready(function(){
		var url = '<s:url value="/js/provCityAreaJson.min.json"/>';
		var provIds = "${provIds}";
		jboxGet(url,null, function(json) {
			for(var i=0;i<json.length;i++){
				var provData = json[i];
				var template = $("#template").find("span").clone();
				$(template).find("input[name='provId']").attr("id",provData.v);
				$(template).find("input[name='provId']").attr("value",provData.v);
				$(template).find("input[name='provName']").attr("id",provData.v+"_name");
				$(template).find("input[name='provName']").attr("value",provData.n);
				if(provIds.indexOf(provData.v)>-1){
					$(template).find("input[name='provId']").prop("checked",true);
					$(template).find("input[name='provName']").prop("checked",true);
				}
				$(template).find("label").attr("for",provData.v);
				$(template).find("label").html(provData.n);
				
				var hdqyProvTable = $("#hdqyProvTable");
				var hnqyProvTable = $("#hnqyProvTable");
				var hbqyProvTable = $("#hbqyProvTable");
				var zxbqyProvTable = $("#zxbqyProvTable");
				
				if(provData.v=='310000'||provData.v=='320000'||provData.v=='330000'||provData.v=='340000'||provData.v=='370000'){
					hdqyProvTable.append(template);
				}else if(provData.v=='350000'||provData.v=='440000'||provData.v=='450000'||provData.v=='460000'||provData.v=='520000'||provData.v=='530000'){
					hnqyProvTable.append(template);
				}else if(provData.v=='110000'||provData.v=='120000'||provData.v=='130000'||provData.v=='140000'||provData.v=='150000'||provData.v=='210000'||provData.v=='220000'||provData.v=='230000'){
					hbqyProvTable.append(template);
				}else {
					zxbqyProvTable.append(template);
				}
			}
		},null,false);
	});
</script>
</head>
<body>
<div class="mainright">
	<div class="content">
		<div class="title1 clearfix">
<form id="regionForm">
				<table width="100%" cellpadding="0" cellspacing="0" class="basic">
					<thead>
							<input name="userFlow" type="hidden" value="${sysUser.userFlow}">
					</thead>
					<tbody>
						<tr>
							<th width="20%">
								<input id="hdqy" type="checkbox" onchange="doCheckAll(this);">&#12288;<label for="hdqy">华东区域</label>
							</th>
							<td id="hdqyProvTable">
								
							</td>
						</tr>
						<tr>
							<th width="20%">
								<input id="hnqy" type="checkbox" onchange="doCheckAll(this);">&#12288;<label for="hnqy">华南区域</label>
							</th>
							<td id="hnqyProvTable">
								
							</td>
						</tr>
						<tr>
							<th width="20%">
								<input id="hbqy" type="checkbox" onchange="doCheckAll(this);">&#12288;<label for="hbqy">华北区域</label>
							</th>
							<td id="hbqyProvTable">
								
							</td>
						</tr>
						<tr>
							<th width="20%">
								<input id="zxbqy" type="checkbox" onchange="doCheckAll(this);">&#12288;<label for="zxbqy">中西部区域</label>
							</th>
							<td id="zxbqyProvTable">
								
							</td>
						</tr>
					</tbody>
				</table>
				<div class="button" style="width: 100%;">
					<input class="search" type="button" value="保&#12288;存" onclick="saveRegion();" />
				</div>
</form>
<div id="template" style="display: none;">
	<span style="width: 180px;display:block; float:left; color:;">
		<input id="" name="provId" type="checkbox" value="" onchange="doCheck(this);">
		<input id="" name="provName" type="checkbox" style="display: none;" value="">
		<label for="" id=""></label>
	</span>
</div>
			</div>
		</div>
	</div>
</body>
</html>