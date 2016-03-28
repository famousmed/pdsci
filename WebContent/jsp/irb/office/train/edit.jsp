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
function saveTrainUser(){
	if(false==$("#editForm").validationEngine("validate")){
		return false;
	}
	var url = "<s:url value='/irb/office/saveTrainUser'/>";
	var requestData = $("#editForm").serialize();
	jboxPost(url,requestData,function(resp){
		if(resp=='${GlobalConstant.SAVE_SUCCESSED}'){
			window.parent.frames['mainIframe'].location.reload(true);
			jboxClose();
		}
	},null,true);
}

function doClose(){
	var flag = "y";
	$(".operTd").each(function(){
		if ($(this).html() == "") {
			flag = "n";
		}
	});
	if (flag == "y") {
		jboxClose();
	} else {
		jboxConfirm("参培人员未保存，确认关闭吗？" , function(){
			jboxClose();
		});
	}
}

function submit(){
	$("#editForm").submit();
}

function userMain(){
	var url = "<s:url value='/irb/office/userMain'/>";
	//var mainIframe = window.parent.frames["mainIframe"];
	//var width = mainIframe.document.body.scrollWidth;
	//var height = mainIframe.document.body.scrollHeight;
	var iframe ="<iframe name='jbox-message-iframe' id='jbox-message-iframe' width='100%' height='800px' marginheight='0' marginwidth='0' frameborder='0' scrolling='auto' src='"+url+"'></iframe>";
	jboxMessager(iframe,'选择参培人员',800,600);	
}

function delTrainUser(recordFlow,status) {
		jboxConfirm("确认删除该条记录吗？" , function(){
			if(status == 'N'){
				$("#"+recordFlow+"_Tr").remove();
			}else{
				jboxGet("<s:url value='/irb/office/delTrainUser'/>?recordFlow="+recordFlow,null,function(){
					$("#"+recordFlow).remove();	
				},null,false);
			}
		});
}

</script>
</head>
<body>
<div class="mainright">
	<div class="content">
		<div class="title1 clearfix">
		<form id="editForm" action="<s:url value='/irb/office/editTrain'/>" method="post">
		<table class="basic" width="100%">
				<tr>
					<th>主办单位：</th>
					<td style="text-align: left;" colspan="3">
						<input type="text" class="xltext" name="trainOrg" value="${train.trainOrg}" style="width:90%;margin-right: 10px"/>
						<input type="hidden" name="trainCategoryId" value="${trainCategoryId}"/>
						<input type="hidden" name="trainFlow" value="${train.trainFlow}"/>
					</td>
				</tr>
				<tr>
					<th>培训名称：</th>
					<td style="text-align: left;"  <c:if test="${trainCategoryId eq irbTrainCategoryEnumOut.id}">colspan="3"</c:if>>
						<input type="text" class="validate[required] xltext" name="trainName" value="${train.trainName}"style="width: 300px;margin-right: 10px"/><font color="red" >*</font>
					</td>
					<c:if test="${trainCategoryId eq irbTrainCategoryEnumInner.id}">
						<th>培训讲师：</th>
						<td>
							<input type="text" name="trainLecturer" class="validate[maxSize[20]] xltext" value="${train.trainLecturer}" style="width: 300px"/>
						</td>
					</c:if>
				</tr>
				<tr>
					<th>培训类别：</th>
					<td style="text-align: left;">
						<select name="trainTypeId" class="validate[required] xlselect" style="width: 308px;margin-right: 7px">
							<option value="">请选择</option>
							<c:forEach items="${irbTrainTypeEnumList}" var="dict">
								<option value="${dict.id}" <c:if test="${train.trainTypeId eq dict.id}">selected="selected"</c:if> >${dict.name}</option>
							</c:forEach>
						</select>
						<font color="red" >*</font>
					</td>
					<th>地点：</th>
					<td style="text-align: left;">
						<input type="text" name="trainAddress" class="xltext" value="${train.trainAddress}"style="width: 300px"/>
					</td>
				</tr>
				<tr>
					<th>培训日期：</th>
					<td style="text-align: left;">
						<input type="text" name="trainDate" readonly="readonly" onClick="WdatePicker({dateFmt:'yyyy-MM-dd'})" class="ctime" value="${train.trainDate}" style="width: 300px" />
					</td>
					<th>培训天数：</th>
					<td style="text-align: left;">
						<input type="text" name="trainDays" class="validate[custom[number]] validate[maxSize[5]] xltext" value="${train.trainDays}" style="width: 300px"/>
					</td>
				</tr>
		</table>
		<br/>
		<table class="xllist" width="100%">
			<thead>
				<tr>
					<th colspan="8" style="text-align: left;">
					&#12288;参培人员&#12288;<img title="选择参培人员" src="<s:url value="/css/skin/${skinPath}/images/add_user.png" />" style="cursor: pointer;" onclick="userMain();" />
					</th>
				</tr>
				<tr>
					<th width="10%">姓名</th>
					<th width="7%">性别</th>
					<th width="15%">部门</th>
					<th width="12%">职务</th>
					<th width="12%">职称</th>
					<th width="14%">手机</th>
					<th width="21%">邮箱</th>
					<th width="8%">操作</th>
				</tr>
			</thead>
			<tbody id="trainUsers">
				<c:forEach items="${trainUserList}" var="user" varStatus="status">
					<tr id="${user.recordFlow}">
						<td width="10%">
							${trainUserMap[user.userFlow].userName}
						<input type="hidden" id="${user.userFlow }" value="${user.userFlow }">
						</td>
						<td width="7%">${trainUserMap[user.userFlow].sexName}</td>
						<td width="15%">${trainUserMap[user.userFlow].deptName}</td>
						<td width="12%">${trainUserMap[user.userFlow].postName}</td>
						<td width="12%">${trainUserMap[user.userFlow].titleName}</td>
						<td width="14%">${trainUserMap[user.userFlow].userPhone}</td>
						<td width="21%">${trainUserMap[user.userFlow].userEmail}</td>
						<td width="8%" class="operTd">
							[<label onclick="delTrainUser('${user.recordFlow}','')" style="color:blue;cursor: pointer;" >删除</label>]
						</td>
					</tr>
				</c:forEach>
			</tbody>
		</table>
		</form>
		</div>
		<div align="center">
			<input type="button" class="search" value="保&#12288;存" onclick="saveTrainUser();" />
			<input type="button" class="search" value="关&#12288;闭" onclick="doClose();" >
		</div>
	</div>
	</div>
</body>
</html>