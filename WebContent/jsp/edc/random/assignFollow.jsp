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
	function assign() {
		if(false==$("#assignForm").validationEngine("validate")){
			return ;
		}
		jboxConfirm("确认申请?",function(){
			jboxPost("<s:url value='/edc/random/assignFollow'/>?assignLabel=${edcRandomAssignLabelEnumFollow.id}",$("#assignForm").serialize(),function(resp){
				if(resp.indexOf("${GlobalConstant.RANDOM_SUCCESSED}")>-1){
					window.parent.frames['mainIframe'].location.reload(true);
					jboxInfo(resp);
					doClose();
				}else {
					jboxInfo(resp);
				}
			},null,false);
		});
	}
	function doClose(){
		jboxClose();
	}
	
	function includeExclude(){
		var url = "<s:url value='/edc/random/includeExclude'/>?patientFlow=${randomInfo.patient.patientFlow }";
		var mainIframe = window.parent.frames["mainIframe"];
		var width = mainIframe.document.body.scrollWidth;
		var height = mainIframe.document.body.scrollHeight;
		var iframe ="<iframe name='jbox-message-iframe' id='jbox-message-iframe' width='100%' height='800px' marginheight='0' marginwidth='0' frameborder='0' scrolling='auto' src='"+url+"'></iframe>";
		jboxMessager(iframe,'纳入/排除标准',width,height);	
	}
</script>
<style type="text/css">
.none {
	border-collapse: collapse;
	table-layout: fixed;
}

.none td {
	border: 0 none;
	border-collapse: collapse;
	padding-bottom: 3px;
	padding-top: 3px;
}
</style>
</head>
<body>
<div class="content" style="height: 100%;overflow: auto;">
	<div class="title1 clearfix">
		<div id="tagContent">
			<div class="tagContent selectTag" id="tagContent0">	
			<form id="assignForm" style="height: 100%" >
			<input type="hidden" name="patientFlow" value="${randomInfo.patient.patientFlow }"/>			
				<table width="100%" cellpadding="0" cellspacing="0" class="basic">	
					<tr>
						<th width="25%">受试者拼音缩写：</th>
						<td>
							${randomInfo.patient.patientNamePy }
							<c:if test="${edcRandomAssignLabelEnumFollow.id == randomInfo.randomRec.assignLabelId && GlobalConstant.FLAG_Y == sysCfgMap['edc_include_exclude'] }">
								<span style="float: right">
									<input type="button" class="search" value="纳入/排除" onclick="includeExclude();" />&#12288;
								</span>
							</c:if>
						</td>  
					</tr>
					<tr>
						<th width="25%">受试者性别：</th>
						<td>
							${randomInfo.patient.sexName }
						</td>  
					</tr>				
					<tr>
						<th width="25%">受试者出生日期：</th>
						<td>
							${randomInfo.patient.patientBirthday }
						</td>  
					</tr>
					<tr>
						<th width="25%">申请过程：</th>
						<td>
						<c:forEach items="${randomInfo.drugRecList }" var="rec">
							${pdfn:transDateTime(rec.assignTime) }&#12288;${rec.assignLabelName }&#12288;药物编码：${rec.drugPack }
							<br/>
						</c:forEach>
						</td>
					</tr>
					<c:if test="${!empty factors }">
					<tr>
						<td colspan="2" width="100%">
							<fieldset>
								<legend>预后因素</legend>
								<table width="100%" class="none">
									<c:forEach items="${factors }" var="factor">
										<c:forEach items="${factor.itemMap }" var="item">
										<tr>
											<td><input type="radio" class="validate[required] " name="factor_${factor.index }" value="${item.key }" id="${factor.index }_${item.key}"/><label for="${factor.index }_${item.key}">&#12288;${item.value }</label></td>
										</tr>
										</c:forEach>
										<tr><td><hr/>
										</td></tr></c:forEach>
								</table>
							</fieldset>
					    </td> 
					</tr>
					</c:if>
				</table>
				</form>
				<div class="button" style="width: 100%;">
					<input type="button" class="search" value="申&#12288;请" onclick="assign();" />
					<input type="button" class="search" onclick="doClose();" value="关&#12288;闭">
				</div>
			</div>
		</div>
	</div>
</div>
</body>
</html>