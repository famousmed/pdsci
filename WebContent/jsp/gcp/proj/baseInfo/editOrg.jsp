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
	<jsp:param name="jquery_fixedtable" value="true"/>
</jsp:include>
<style type="text/css">
.no_boder{border:none;}
</style>
<script type="text/javascript">
	$(document).ready(function(){
		if($("#projOrgList tr").length<=0){
			add();
		}
	});
	
	function add(){
		$('#projOrgList').append($("#clong tr:eq(0)").clone());
	}
	function del(){
		var checkboxs = $("#projOrgList input[name='recordFlow']:checked");
		if(checkboxs.length == 0){
			jboxTip("请勾选要删除的！");
			return false;
		}
		jboxConfirm("确认删除？", function() {
			var recordFlow = "";
			checkboxs.each(function(){
				var rFlow = $(this).val();
				if(rFlow != ''){
					recordFlow = recordFlow + "recordFlow="+ rFlow + "&";
				}else{
					$(this).parent().parent().remove();
				}
			});
			if(recordFlow != ''){
				var url = "<s:url value='/gcp/proj/delProjOrgByRecordFlows'/>";
				var requestData = recordFlow;
				jboxPost(url,requestData,function(resp){
					if(resp=='${GlobalConstant.DELETE_SUCCESSED}'){
						window.parent.frames['mainIframe'].window.loadBaseInfo();
						jboxClose();
					}
				},null,true);
			}
			
		});
	}
	
	function chooseUser(){
	   var mainIframe = window.parent.frames["mainIframe"];
	   var width = mainIframe.document.body.scrollWidth;
	   var height = mainIframe.document.body.scrollHeight;
	   var url ='<s:url value="/gcp/proj/chooseUser"/>';
	   var iframe ="<iframe name='jbox-message-iframe' id='jbox-message-iframe' width='"+width+"px' height='"+height+"px' marginheight='0' marginwidth='0' frameborder='0' scrolling='auto' src='"+url+"'></iframe>";
	   jboxMessager(iframe,'选择用户',width,height);
	}
	function editInput(obj){
		$(obj).attr("class","inputText");
	}
	
	function save(){
		if(false==$("#projForm").validationEngine("validate")){
			return false;
		}
		var leaderOrg = $("#leaderOrg").val();
		var leaderOrgLinkMan = $("#leaderOrgLinkMan").val();
		var leaderOrgLinkManPhone = $("#leaderOrgLinkManPhone").val();
		var projOrgTab = $('#projOrgList');
		var trs = projOrgTab.children();
		var datas = [];
		$.each(trs , function(i , n){
			var recordFlow = $(n).find("input[name='recordFlow']").val();
			var centerNo = $(n).find("input[name='centerNo']").val();
			var orgName = $(n).find("input[name='orgName']").val();
			var orgTypeId =  $(n).find("select[name='orgTypeId']").val();
			var patientCount =  $(n).find("input[name='patientCount']").val();
			var researcher= $(n).find("input[name='researcher']").val();
			var data = {
					"recordFlow":recordFlow,
					"centerNo":centerNo,
					"orgName":orgName,
					"orgTypeId":orgTypeId,
					"patientCount":patientCount,
					"researcher":researcher,
			};
			datas.push(data);
		});
		var requestData = {"projOrgList":datas,"leaderOrg":leaderOrg, "leaderOrgLinkMan":leaderOrgLinkMan,"leaderOrgLinkManPhone":leaderOrgLinkManPhone};
		var url = "<s:url value='/gcp/proj/saveResearchOrg?projFlow=${param.projFlow}'/>";
		jboxPostJson(
				url,
				JSON.stringify(requestData),
				function(resp){
					window.parent.frames['mainIframe'].window.loadBaseInfo();
					jboxClose();
				},
				null,
				true
		);
	}
</script>
</head>
<body>
	<div class="mainright">
	<div class="content">
		<div class="title1 clearfix">
			<div class="title1 clearfix">
			<form id="projForm" method="post" style="position: relative;">
				<table class="xllist"  id="append">
					<tr>
						<th colspan="6">
							<font style="float: left;margin-left: 10px">临床研究机构</font>
							<img title="删除" src="<s:url value="/css/skin/${skinPath}/images/del1.png" />" style="float: right;margin-right: 20px;cursor: pointer;" onclick="del();"/>
							<img title="新增" src="<s:url value="/css/skin/${skinPath}/images/add3.png" />" style="float: right;margin-right: 10px;cursor: pointer;" onclick="add();"/>
						</th>
					</tr>
					<tr>
					    <th style="width:5%">选择</th>
					    <th style="width:10%">序号</th>
						<th style="width:40%">机构名称</th>
						<th style="width:15%">机构角色</th>
						<th style="width:15%">承担例数</th>		
						<th style="width:15%">主要研究者</th>		
					</tr>
					<tbody id="projOrgList">
					<c:forEach items="${projOrgForm.projOrgList}" var="org">
					<tr>
						<td><input type="checkbox" name="recordFlow" value="${org.recordFlow}"/></td>
						<td><input type="text" name="centerNo" value="${org.centerNo}" class="validate[custom[number]] inputText"  style="width:90%;"/></td>	 
						<td><input type="text" name="orgName" value="${org.orgName}" class="inputText validate[required]" style="width:90%;"/></td>
						<td>
							<select class="inputText validate[required]" name="orgTypeId" class="inputText" >
								<option value="">请选择</option>
		          		  		<option value="${projOrgTypeEnumLeader.id}" <c:if test="${org.orgTypeId eq projOrgTypeEnumLeader.id}">selected="selected"</c:if>>${projOrgTypeEnumLeader.name }</option>
		          		  		<option value="${projOrgTypeEnumParti.id}" <c:if test="${org.orgTypeId eq projOrgTypeEnumParti.id}">selected="selected"</c:if>>${projOrgTypeEnumParti.name }</option>
	          		  		</select>
						</td>
						<td><input type="text" name="patientCount" value="${org.patientCount}" class="inputText validate[custom[integer]]" style="width:90%;"/></td>
						<td><input type="text" name="researcher" value="${org.researcher}" class="inputText" style="width:90%;"/></td>
					</tr>
					</c:forEach>
					</tbody>
				</table>
					
				<div id="projInfoForm" style="margin-top: 10px;text-align: right;">
					临床试验负责单位：
					<input type="text" class="inputText" id="leaderOrg" name="leaderOrg" value="${projOrgForm.leaderOrg}">
					&#12288;联系人：
					<input type="text" class="inputText validate[required]" id="leaderOrgLinkMan"  name="leaderOrgLinkMan" value="${projOrgForm.leaderOrgLinkMan}" style="width:100px;" >
					&#12288;联系电话：
					<input type="text" class="inputText validate[custom[phone]]" id="leaderOrgLinkManPhone" name="leaderOrgLinkManPhone" value="${projOrgForm.leaderOrgLinkManPhone}" style="width:120px;margin: 0;" >
				</div>
			</form>
		</div>
		
		<div style="width: 100%;margin-top: 10px;" align="center" >
			<input class="search" type="button" value="保&#12288;存" onclick="save()" />
			<input class="search" type="button" value="关&#12288;闭" onclick="jboxClose();" />
		</div>
		
		
</div></div></div>
<table style="display: none; width: 100%;" id="clong">
	<tr id="cloneTr">
		<td style="width:5%"><input type="checkbox" name="recordFlow" value=""/></td>
		<td style="width:10%"><input type="text"  name="centerNo" class="validate[custom[number]] inputText" style="width:90%;"/></td>	 
		<td style="width:40%"><input type="text" name="orgName" class="inputText validate[required]" style="width:90%;"/></td>
		<td style="width:15%">
			<select class="inputText validate[required]" name="orgTypeId">
				<option value="">请选择</option>
				<option value="${projOrgTypeEnumParti.id }">${projOrgTypeEnumParti.name }</option>
				<option value="${projOrgTypeEnumLeader.id }">${projOrgTypeEnumLeader.name }</option>
			</select>
		</td>
		<td style="width:15%"><input type="text" name="patientCount" class="inputText validate[custom[integer]]" style="width:90%;"/></td>
		<td style="width:15%"><input type="text" name="researcher" class="inputText" style="width:90%;"/></td>
	</tr>
</table>
</body>
</html>