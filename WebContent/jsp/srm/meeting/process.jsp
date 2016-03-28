<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@include file="/jsp/common/doctype.jsp" %>
<html>
<head>
<jsp:include page="/jsp/common/htmlhead.jsp">
	<jsp:param name="basic" value="true"/>
	<jsp:param name="jbox" value="true"/>
	<jsp:param name="jquery_validation" value="true"/>
	<jsp:param name="jquery_datePicker" value="true"/>
	<jsp:param name="jquery_ui_tooltip" value="true"/>
	<jsp:param name="jquery_placeholder" value="true"/>
</jsp:include>
<script type="text/javascript">
	function search(){
		window.location.reload(true);
	}
	function voteDesction() {
		jboxStartLoading();
		jboxOpen("<s:url value='/irb/meeting/voteDesction'/>", "投票结果", 800, 600);
	}
	function minutes(type) {
		jboxStartLoading();
		jboxOpen("<s:url value='/irb/meeting/minutes'/>?reviewType=" + type,
				"会议记录", 800, type == "2" ? 600 : 300);
	}
	function viewIrbFile() {
		jboxStartLoading();
		jboxOpen("<s:url value='/irb/committee/viewIrbFile'/>", "送审文件", 1000,
				600);
	}
	function irbSettle() {
		jboxStartLoading();
		jboxOpen("<s:url value='/irb/meeting/irbSettle'/>", "送审文件", 900, 600);
	}

	function chwy() {
		$(".contentDiv").hide();
		$("#chwy").show();
	}

	function xmlb() {
		$('#xmlb').load('<s:url value="/srm/meeting/showEvalProj"/>?groupFlow='+$('#groupFlow').val());
		$("#xmlb").show();
	}

	function wyqd() {
		$(".contentDiv").hide();
		$("#wyqd").show();
	}

	function hyps() {
		$(".contentDiv").hide();
		$("#hyps").show();
	}

	function hyjl() {
		$(".contentDiv").hide();
		$("#hyjl").show();
	}
	
	function delExpertGroupUser(recordFlow){
		var url = '<s:url value="/srm/meeting/delEvalExpert"/>?recordFlow='+recordFlow;
		jboxConfirm("确认删除？" , function(){
			jboxStartLoading();
			jboxGet(url , null , function(){
				window.location.reload(true);
				
			} , null , true);
		});

	}
	
	function addExpertUI(groupFlow){
		var url = '<s:url value="/srm/meeting/addExpertUI"/>?groupFlow='+groupFlow;
		jboxStartLoading();
		jboxOpen(url, "向专家组添加专家信息", 800,500);
	}
	
	function sign(recordFlow){
		jboxConfirm("确认签到？" , function(){
			var url = '<s:url value="/srm/meeting/sign"/>?recordFlow='+recordFlow;
			jboxStartLoading();
			jboxGet(url , null , function(){
				//$('#wyqd').load('<s:url value="/srm/meeting/showSignUI"/>?groupFlow='+$('#groupFlow').val());
				window.location.reload(true);
			} , null , true);
		});
	}
	
	function cancelEvalSet(evalSetFlow){
		jboxConfirm("确认讲该项目移除本次会议？" , function(){
			var url = '<s:url value="/srm/meeting/cancelEvalSet"/>?evalSetFlow='+evalSetFlow;
			jboxStartLoading();
			jboxGet(url , null , function(){
				xmlb();
			} , null , true);
		});
	}
	
	function addEvalProjUI(){
		var groupFlow = $('#groupFlow').val();
		var url = '<s:url value="/srm/meeting/addEvalProjUI"/>?groupFlow='+groupFlow;
		jboxStartLoading();
		jboxOpen(url , "添加会议上需要评审的项目" , 800 , 500);
	}
	
	function emailNotify(recordFlow){
		var url ='<s:url value="/srm/meeting/emailNotify"/>?recordFlow='+recordFlow;
		jboxConfirm("确认邮件通知？" , function(){
			jboxStartLoading();
			jboxGet(url , null , function(){
				window.location.reload(true);
			} , null , true);
		});
	}
	
	function phoneNotify(recordFlow){
		var url ='<s:url value="/srm/meeting/phoneNotify"/>?recordFlow='+recordFlow;
		jboxConfirm("确认电话通知？" , function(){
			jboxStartLoading();
			jboxGet(url , null , function(){
				window.location.reload(true);
			} , null , true);
		});
	}
	$(document).ready(function(){
		xmlb();	
	});	
	function edit(groupFlow){
		jboxStartLoading();
		jboxOpen("<s:url value='/srm/meeting/edit'/>?groupFlow="+groupFlow,"修改会议信息",500,250);
	}
    function del(groupFlow){
    	var evalUserCount=$("#evalUserList").children().length;
    	var evalProjCount=$("#evalProjList").children().length;
    	if(evalUserCount>0 || evalProjCount>0){
    		jboxTip("删除会议必须先清空参会委员和会审项目！")
    		return false;
    	}
    	var url = '<s:url value="/srm/meeting/delete"/>?groupFlow='+groupFlow;
    	jboxConfirm("确认删除？" , function(){
    		jboxStartLoading();
    		jboxGet(url , null , function(){
    			 var url="<s:url value='/srm/meeting/plan'/>";
    			 window.location=url;
    		}, null , true);
    	});
	}
</script>
</head>
<body>
	<div class="mainright">
		<div class="content">
			<div class="title1 clearfix">
					<input id="groupFlow" name="groupFlow" value="${meeting.groupFlow}" type="hidden"/>
				<table class="xllist">
	    			<tr>
	    			    <th colspan="5" style="text-align: left;">&#12288;会议信息&#12288;&#12288;
	    			       <input type="button" class="search" onclick="edit('${meeting.groupFlow}')" value="修改"/>&#12288;
	    			       <input type="button" class="search" onclick="del('${meeting.groupFlow}')" value="删除"/>
	    			    </th>
	    			</tr>
		             <tr>
		             		<td style="text-align: left" >&#12288;<b>会议名称：</b>${meeting.groupName}</td>
	                        <td  style="text-align: left" >&#12288;<b>会议日期：</b>${meeting.meetingDate}</td>
	                         <td  style="text-align: left">&#12288;<b>开始时间：</b> ${meeting.meetingStartTime}</td>
	                         <td style="text-align: left" >&#12288;<b>结束时间：</b>${meeting.meetingEndTime}</td>
	                         <td width="5%" align="right" rowspan="2"><img
								src="<s:url value='/css/skin/${skinPath}/images/meeting.png'/>"
								onclick="jboxInfo('下载会议记录');"
								style="width: 80px; height: 80px; cursor: pointer;" title="会议记录" />
							</td>
                 	</tr>
					<tr>
                        <td width="400px" style="text-align: left" colspan="4">&#12288;<b>会议地点：</b> ${meeting.meetingAddress}</td>
                    </tr>
		     	</table>
			</div>
			<div class="flow_list" id="icn" style="display: none;">
				<ul>
			    	<li  class="list_1" ><a href="javascript:void(0);" onclick="chwy();"><span>1</span>参会委员</a></li>
			        <li  class="list_1" ><a href="javascript:void(0);" onclick="xmlb();"><span>2</span>会评项目</a></li>
			    </ul>
			</div> 
			<div id="chwy" class="contentDiv">
				<p><b style="font-size: 15px">一、会评专家</b>&nbsp;<img title="新增" src="<s:url value="/css/skin/${skinPath}/images/add_user.png" />" style="cursor: pointer;" onclick="addExpertUI('${param.groupFlow}')" ></img></p>
				<table class="xllist" align="center" style="margin-top: 10px;margin-bottom: 10px;">
					<thead>
						<tr>
							<th width="80px">姓名</th> 
		                   <th width="80px">性别</th>
		                    <th width="100px">职称</th>
	                    	 <th width="100px">职务</th>
		                   <th width="100px">专业</th>
		                   <th width="100px">学历</th>
						   <th width="150px">工作单位</th>
						   <th width="100px">手机</th>
						   <th width="100px">邮箱</th>
						   <th width="80px">操作</th>
						</tr>
					</thead>
					<tbody id="evalUserList">
						<c:forEach items="${expertInfoList}" var="expert">
							<tr>
								<td>${expert.user.userName}</td>
								<td>${expert.user.sexName}</td>
								<td>${expert.user.titleName}</td>
								<td>${expert.user.postName}</td>
								<td>${expert.expert.majorName}</td>
								<td>${expert.expert.education}</td>
								<td>${expert.user.orgName}</td>
								<td>
								<!-- 
								<input type="checkbox" onchange="phoneNotify('${expert.expertGroupUser.recordFlow}');" <c:if test='${expert.expertGroupUser.phoneNotifyFlag=="Y"}'>checked="checked" disabled="disabled"</c:if>>
								-->
								${expert.user.userPhone}</td>
								<td>
								<!-- 
								<input type="checkbox" onchange="emailNotify('${expert.expertGroupUser.recordFlow}');"  <c:if test='${expert.expertGroupUser.emailNotifyFlag=="Y"}'>checked="checked" disabled="disabled"</c:if>>
								-->
								${expert.user.userEmail}</td>
								<td>
									<c:if test='${expert.expertGroupUser.signFlag==GlobalConstant.FLAG_N ||empty expert.expertGroupUser.signFlag}'><a href="javascript:void(0);" onclick="sign('${expert.expertGroupUser.recordFlow}')">[签到]</a></c:if>
									<c:if test='${expert.expertGroupUser.signFlag==GlobalConstant.FLAG_Y}'>[已签到]</c:if>
									<c:if test='${expert.expertGroupUser.signFlag!=GlobalConstant.FLAG_Y}'> 
									[<a href="javascript:delExpertGroupUser('${expert.expertGroupUser.recordFlow}');" >删除</a>]
									</c:if>
								</td>
							</tr>
						</c:forEach>
						
					</tbody>
				</table>
			</div>
			<div id="xmlb" class="contentDiv" style="display: none">
				
			</div>
		</div>
		</div>
</body>
</html>