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
	var meetingUsers = {};
	function userMain(){
		var url = "<s:url value='/pub/meeting/userMain'/>?meetingFlow="+$("[name='meetingFlow']");
		var iframe ="<iframe name='jbox-message-iframe' id='jbox-message-iframe' width='100%' height='800px' marginheight='0' marginwidth='0' frameborder='0' scrolling='auto' src='"+url+"'></iframe>";
		jboxMessager(iframe,'选择参会人员',800,600);	
	}
	
	function addUserTr(user){
		if($("#"+user.userFlow).length>0){
			if(user.userFlow in meetingUsers){
				delete meetingUsers[user.userFlow];
				$("#"+user.userFlow).remove();
			}
		}else{
			meetingUsers[user.userFlow] = user;
			$("#meetingUsers").append("<tr id='"+user.userFlow+"'><td>"+user.userName+"<input type='hidden' name='userFlow' value='"+user.userFlow+"'/></td><td>"+user.sexName+"</td><td>"+user.deptName+"</td><td>"+user.postName+"</td><td>"+user.titleName+"</td><td>"+user.userPhone+"</td><td>"+user.userEmail+"</td><td>[<label onclick='delMeetingUser(\"\",\""+user.userFlow+"\");' style='color:blue;cursor: pointer;' >删除</label>]</td></tr>");
		}
	}
	
	function saveMeeting(){
		if($("#fileForm").validationEngine("validate")){
			var url = "<s:url value='/pub/meeting/saveMeeting'/>";
			jboxSubmit($("#fileForm"),url,function(resp){
						window.parent.frames["mainIframe"].window.search();
						jboxClose();				
					},function(resp){
						jboxTip("${GlobalConstant.SAVE_FAIL}");
					});
		}
	}
	
	function delMeetingUser(recordFlow,userFlow){
			jboxConfirm("确认删除?",function () {
				if(recordFlow == ''){
					$("#"+userFlow).remove();
				}else{
					var url = "<s:url value='/pub/meeting/delMeetingUser'/>?recordFlow="+recordFlow;
					jboxPost(url,null,function(resp){
						if(resp == '${GlobalConstant.DELETE_SUCCESSED}'){
							$("#"+userFlow).remove();
						}
					},null,false);
				}
			});
	}
	
	function addFileInput(){
		$("#fileList").append("<tr><td style='width:5%'><input type='checkbox' value='' class='delFiles'/></td><td><input type='file' class='validate[required]' name='file' style='float: left;margin-left: 10px'/></td></tr>");
	}
	
	function delFiles(){
		if($(".delFiles:checked").length > 0){
			jboxConfirm("确认删除?",function () {
				var fileFlows = "";
				$(".delFiles:checked").each(function(){
					var value = $(this).val();
					if(value != null && value != ''){
						if(fileFlows != ''){
							fileFlows+="&";
						}
						fileFlows += ("fileFlows="+value);
					}else{
						$(this).parent().parent().remove();
					}
				});
				if(fileFlows != ''){
					var url = "<s:url value='/pub/meeting/delMeetingFiles'/>";
					jboxPost(url,fileFlows,function(resp){
						if(resp == '${GlobalConstant.DELETE_SUCCESSED}'){
							$(".delFiles:checked").each(function(){
								$(this).parent().parent().remove();
							});
						}
					},null,true);
				}
			});
		}else{
			jboxTip("请选择要删除的文件!");
		}
	}
	
	function doClose(){
		if($("#meetingUsers tr").length > $(".operTd").length){
			jboxConfirm("有未保存参会人员,确认关闭?",function () {
				jboxClose();
			});
		}else{
			jboxClose();
		}
		
	}
	
	$(function(){
		if($("#fileList").find("tr").length<2){
			addFileInput();
		}
	});
</script>
</head>
<body>
<div class="mainright">
	<div class="content">
		<div class="title1 clearfix">
		<form id="fileForm" style="position: relative;" enctype="multipart/form-data" method="post" >
		<table class="basic" width="100%">
				<tr>
					<th>主办单位：</th>
					<td style="text-align: left;" colspan="3">
						<input type="text" class="xltext" name="meetingHost" value="${meeting.meetingHost}" style="width: 90%"/>
						<input type="hidden" name="meetingFlow" value="${meeting.meetingFlow}"/>
						<input type="hidden" name="meetingTypeId" value="${meetingType}"/>
					</td>
				</tr>
				<tr>
					<th>会议名称：</th>
					<td style="text-align: left;">
						<input type="text" class="validate[required] xltext" name="meetingName" value="${meeting.meetingName}" style="width: 75%;margin-right: 10px"/><font color="red" >*</font>
					</td>
					<th>会议日期：</th>
					<td style="text-align: left;">
						<input type="text" name="meetingDate" readonly="readonly" onClick="WdatePicker({dateFmt:'yyyy-MM-dd'})" class="validate[required] ctime" value="${meeting.meetingDate}" style="width: 75%;margin-right: 10px"/><font color="red" >*</font>
					</td>
				</tr>
				<tr>
					<th>会议地点：</th>
					<td colspan="3">
						<input type="text" name="meetingAddress" class="validate[required] xltext" value="${meeting.meetingAddress}" style="width: 90%;margin-right: 10px"/><font color="red" >*</font>
					</td>
				</tr>
				<tr>
					<th>会议简介：</th>
					<td colspan="3">
						<textarea name="meetingSummary" class="xltxtarea" style="margin-left: 0px;width: 91%">${meeting.meetingSummary}</textarea>
					</td>
				</tr>
		</table>
		<br/>
		<table class="xllist" width="100%">
			<thead>
				<tr>
					<th colspan="8" style="text-align: left;">
					&#12288;参培人员&#12288;<img title="选择参会人员" src="<s:url value="/css/skin/${skinPath}/images/add_user.png" />" style="cursor: pointer;" onclick="userMain();" />
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
			<tbody id="meetingUsers">
				<c:forEach items="${meetingUserList}" var="user" varStatus="status">
					<tr id="${user.userFlow}">
						<td width="10%">
							${sysUserMap[user.userFlow].userName}
						</td>
						<td width="7%">${sysUserMap[user.userFlow].sexName}</td>
						<td width="15%">${sysUserMap[user.userFlow].deptName}</td>
						<td width="12%">${sysUserMap[user.userFlow].postName}</td>
						<td width="12%">${sysUserMap[user.userFlow].titleName}</td>
						<td width="14%">${sysUserMap[user.userFlow].userPhone}</td>
						<td width="21%">${sysUserMap[user.userFlow].userEmail}</td>
						<td width="8%" class="operTd">
							[<label onclick="delMeetingUser('${user.recordFlow}','${user.userFlow}')" style="color:blue;cursor: pointer;" >删除</label>]
						</td>
					</tr>
				</c:forEach>
			</tbody>
		</table>
			<table id="fileList" class="xllist" width="100%" style="margin-top: 10px">
				<tr><th colspan="2">
					<font style="float: left;margin-left: 10px">会议文件</font>
					<img title="删除" src="<s:url value="/css/skin/${skinPath}/images/del1.png" />" style="float: right;margin-right: 20px;cursor: pointer;" onclick="delFiles();"/>
					<img title="新增" src="<s:url value="/css/skin/${skinPath}/images/add3.png" />" style="float: right;margin-right: 10px;cursor: pointer;" onclick="addFileInput();"/>
				</th></tr>
				<c:forEach items="${meetingFileList}" var="file">
					<tr>
					<td style="width: 5%">
						<input type="checkbox" class="delFiles" value="${file.fileFlow}"/>
					</td>
					<td>
						<a title="下载" style="color: blue;float: left;margin-left: 10px" href="<s:url value='/pub/file/down'/>?fileFlow=${file.fileFlow}">${file.fileName}</a>
						<!-- <input type='file' id="file${file.fileFlow}" name='file' style='display: none;'/> -->
					</td>
					</tr>
				</c:forEach>
			</table>
		</form>
		</div>
		<div align="center">
			<input type="button" class="search" value="保&#12288;存" onclick="saveMeeting();" />
			<input type="button" class="search" value="关&#12288;闭" onclick="doClose();" >
		</div>
	</div>
	</div>
</body>
</html>