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
	<jsp:param name="jquery_fixedtable" value="true"/>
</jsp:include>
<script type="text/javascript">
	$(document).ready(function(){
		if($("#monitorTb tr").length<=0){
			add();
		}
	});
	
	function add(){
		$('#monitorTb').append($("#clone tr:eq(0)").clone());
	}
	function del(){
		var mIds = $("#monitorTb input[name='id']:checked");
		if(mIds.length == 0){
			jboxTip("请勾选要删除的！");
			return false;
		}
		jboxConfirm("确认删除？", function() {
			var ids = "";
			mIds.each(function(){
				var id = $(this).val();
				if(id != ''){
					ids = ids + "id="+ id + "&";
				}else{
					$(this).parent().parent().remove();
				}
			});
			if(ids != ''){
				var url = "<s:url value='/gcp/proj/delMonitor?projFlow=${param.projFlow}'/>";
				var requestData = ids;
				jboxPost(url,requestData,function(resp){
					if(resp=='${GlobalConstant.DELETE_SUCCESSED}'){
						window.parent.frames['mainIframe'].window.loadResearchUser();
						jboxClose();
					}
				},null,true);
			}
			
		});
	}
	
	function save(){
		if(false==$("#projForm").validationEngine("validate")){
			return false;
		}
		var monitorTb = $('#monitorTb');
		var trs = monitorTb.children();
		var datas = [];
		$.each(trs , function(i , n){
			var id = $(n).find("input[name='id']").val();
			var name = $(n).find("input[name='name']").val();
			var identityCardNo = $(n).find("input[name='identityCardNo']").val();
			var phone =  $(n).find("input[name='phone']").val();
			var email =  $(n).find("input[name='email']").val();
			var isGCPTrain= $(n).find("select[name='isGCPTrain']").val();
			var data = {
					"id":id,
					"name":name,
					"identityCardNo":identityCardNo,
					"phone":phone,
					"email":email,
					"isGCPTrain":isGCPTrain
			};
			datas.push(data);
		});
		if(datas == ""){
			jboxTip("请添加监督者！");
			return false;
		}
		var url = "<s:url value='/gcp/proj/saveMonitor?projFlow=${param.projFlow}'/>";
		jboxPostJson(
				url,
				JSON.stringify(datas),
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
			<form id="projForm" style="position: relative;"> 
				<table class="xllist" id="append" style="width: 100%;">
					<tr>
						<th colspan="6">
							<font style="float: left;margin-left: 10px">监查员</font>
							<img title="删除" src="<s:url value="/css/skin/${skinPath}/images/del1.png" />" style="float: right;margin-right: 20px;cursor: pointer;" onclick="del();"/>
							<img title="新增" src="<s:url value="/css/skin/${skinPath}/images/add3.png" />" style="float: right;margin-right: 10px;cursor: pointer;" onclick="add();"/>
						</th>
					</tr>
					<tr>
					    <th width="5%;">选择</th>
						<th width="15%;">姓名</th>
						<th width="20%;">身份证号</th>
						<th width="15%;">手机</th>		
						<th width="30%;">邮箱</th>		
						<th width="15%;">是否GCP培训</th>		
					</tr>
					<tbody id="monitorTb">
					<c:forEach items="${monitorFormList}" var="monitor">
					<tr>
						<td><input type="checkbox" name="id" value="${monitor.id}"/></td>
						<td width="15%;"><input type="text" class="inputText validate[required]" name="name" value="${monitor.name}" style="width:90%;"/></td>
						<td><input type="text" class="inputText validate[custom[chinaIdLoose]]" name="identityCardNo" value="${monitor.identityCardNo}"  style="width:90%;"/></td>
						<td><input type="text" class="inputText validate[custom[phone]]" name="phone" value="${monitor.phone}" style="width:90%;"/></td>
						<td><input type="text" class="inputText validate[custom[email]]" name="email" value="${monitor.email}" style="width:90%;"/></td>
						<td width="15%;">
							<select class="inputText" name="isGCPTrain">
								<option value="">请选择</option>
								<option value="${GlobalConstant.FLAG_Y}" <c:if test="${monitor.isGCPTrain eq GlobalConstant.FLAG_Y}">selected="selected"</c:if>>是</option>
								<option value="${GlobalConstant.FLAG_N}" <c:if test="${monitor.isGCPTrain eq GlobalConstant.FLAG_N}">selected="selected"</c:if>>否</option>
							</select>
						</td>
					</tr>
					</c:forEach>
					</tbody>
				</table>
			</form>
		</div>
		<div style="width: 100%;margin-top: 10px;" align="center" >
			<input class="search" type="button" value="保&#12288;存" onclick="save();" />
			<input class="search" type="button" value="关&#12288;闭" onclick="jboxClose();" />
		</div>
</div></div></div>
<table  style="display: none;" id="clone">
	<tr>
		<td><input type="checkbox" name="id" value=""/></td>
		<td width="15%;"><input type="text" class="inputText validate[required]" name="name" style="width:90%;"/></td>
		<td><input type="text" class="inputText validate[custom[chinaIdLoose]]" name="identityCardNo" style="width:90%;"/></td>
		<td><input type="text" class="inputText validate[custom[phone]]" name="phone" style="width:90%;"/></td>
		<td><input type="text" class="inputText validate[custom[email]]" name="email" style="width:90%;"/></td>
		<td width="15%;">
			<select class="inputText" name="isGCPTrain">
				<option value="">请选择</option>
				<option value="${GlobalConstant.FLAG_Y}">是</option>
				<option value="${GlobalConstant.FLAG_N}">否</option>
			</select>
		</td>
	</tr>
</table>
</body>
</html>