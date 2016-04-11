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
var width=(window.screen.width)*0.5;
var height=(window.screen.height)*0.5;
	/* function addRegulation(regTypeId){
		//alert(regTypeId);
		var html = 
			'<tr>'+
				'<td>' +
					'制度名称：<input type="text" class="validate[required] xltext" name="regName"/>' +
					'<input type="file" name="file"/>' +
					'序号：<input type="text" class="validate[custom[integer]] validate[maxSize[5]] xltext" name="ordinal" style="width: 50px;"/>' +
					'<input type="button" class="search" value="上&#12288;传" onclick="saveRegulation();" />' +
					'<input type="button" class="search" value="关&#12288;闭" onclick="closeRegulationTr(this);" />' +
					'<input type="hidden" name="regTypeId" value="'+regTypeId+'" />' +
				'</td>' +
			'</tr>'; 
		$('#'+regTypeId+'Tb').append(html);
	} */
	
	/* function closeRegulationTr(obj){
		obj.parentNode.parentNode.remove();
	} */
	
	function addRegulation(regTypeId){
		jboxOpen("<s:url value='/irb/office/editRegulation?regTypeId='/>"+ regTypeId,"新增", width,height); 
	}
	
	function editRegulation(regFlow){
		jboxOpen("<s:url value='/irb/office/editRegulation?regFlow='/>" + regFlow ,"新增", width,height); 
	}
	
	function delRegulation(regFlow){
		var url = "<s:url value='/irb/office/delRegulation?regFlow='/>"+regFlow;
		jboxConfirm("确认删除？" , function(){
			jboxGet(url , null , function(){
				window.parent.frames['mainIframe'].location.reload(true);
			}, null , true);
		});
	}
</script>
</head>
<body>
<div class="mainright">
	<div class="content">
	<div class="title1 clearfix">
	
		<form id="regulationForm" action="<s:url value='/irb/office/saveRegulation'/>" method="POST" enctype="multipart/form-data">
		<c:forEach items="${regulationMap}" var="entry">
			<table class="xllist" style="margin-top: 5px" id="${entry.key}Tb">
				<tr>
					<th style="text-align: left;padding-left: 20px;">
						<c:forEach items="${irbRegulationTypeEnumList}" var="dict">
							<c:if test="${entry.key eq dict.id}">
								${dict.name}
							</c:if>
						</c:forEach>
						<a href="javascript:void(0)">
							<img style="float: right;margin-right: 20px;" title="添加制度或SOP" src="${ctxPath}/css/skin/${skinPath}/images/add.png" onclick="addRegulation('${entry.key}');">
						</a>
					</th>
				</tr>
				
				<c:forEach items="${entry.value}" var="regulation">
					<tr>
						<td style="text-align: left;padding-left: 30px;">
							&#12288;<a href="<s:url value='/pub/file/down'/>?fileFlow=${regulation.fileFlow}">${regulation.regName}</a>
							<%-- <input type="hidden" name="regFlow" value="${regulation.regFlow}"/> --%>
							<a href="javascript:void(0);" onclick="delRegulation('${regulation.regFlow}')" style="cursor: pointer;float: right;margin-right: 20px;">[删除]</a>
							<a href="javascript:void(0);" onclick="editRegulation('${regulation.regFlow}')" style="cursor: pointer;float: right;margin-right: 20px;">[编辑]</a>
						</td>
					</tr>
				</c:forEach>
			</table>
		</c:forEach>
		</form>
		
	</div>
	</div>
</div>
</body>
</html>