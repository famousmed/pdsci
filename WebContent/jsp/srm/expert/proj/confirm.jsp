<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="/jsp/common/doctype.jsp" %>
<html>
<head>
<jsp:include page="/jsp/common/htmlhead.jsp">
	<jsp:param name="basic" value="true"/>
	<jsp:param name="jbox" value="true"/>
</jsp:include>
<script type="text/javascript">
function save(expertProjFlow,flag){
	datas = {
			"expertProjFlow":expertProjFlow,
		    "flag":flag
	};
	var tip =  flag=="${GlobalConstant.FLAG_N}"?"忽略":"审批";
	jboxConfirm("确认"+tip+"该项目？" , function(){
		var url =  "<s:url value='/srm/expert/proj/saveConfirm'/>";
		jboxStartLoading();
		jboxPost(url , datas , function(){
			window.location.reload();
		} , null , true);
	});
}
function hide(expertProjFlow){
	datas = {
			"recordFlow":expertProjFlow
	};
	jboxConfirm("隐藏该项目？" , function(){
		var url = "<s:url value='/srm/expert/proj/hide'/>";
		jboxStartLoading();
		jboxPost(url , datas , function(){
			window.location.reload();
		} , null , true);
	});
}

function checkFinishInfo(){
	var finishInfoFlag = "${expert.finishInfoFlag}";
	if(finishInfoFlag == "" || finishInfoFlag =="N"){
		var url = "<s:url value='/srm/expert/proj/finishInfo?userFlow=${sessionScope.currUser.userFlow}'/>";
		jboxOpen(url, "完善个人信息", 900, 500, false);
	}
}

$(function(){
	<c:if test='${sysCfgMap["srm_expert_need_finish_info"] eq "Y"}'>
	    checkFinishInfo();
	</c:if>
	
});
</script>
<body>
<div class="mainright">
	<div class="content">
		<div class="title1 clearfix">
			<c:set var="currDate" value="${pdfn:getCurrDate() }"/>
            <c:set value="0" var="i" scope="page"/>
			<table width="100%" cellspacing="0" cellpadding="0">
					<tr>
						<td valign="top">					
							<table width="100%" cellspacing="0" cellpadding="0" class="xllist">
								<tr>
									<th class="bs_name" colspan="3">待办事项</th>
								</tr>
								<tbody id="eleSortable">								
									<tr>
										<td class="bs_mod viewTd" align="left" colspan="2">
											待评审：</span>您有<a  href="#" style="color:red" id="count"></a>个项目可以评审
										</td>
									</tr>	
									<c:forEach items="${expertProjList}" var="expertProj"> 
										<c:if test="${expertProj.srmExpertGroupProjExt.evaluationWayId eq evaluationWayEnumNetWorkWay.id }">
				              			<tr>
											<td class="bs_mod viewTd" align="left" colspan="2">
												专家【<font color="red">${sessionScope.currUser.userName}</font>】您好！
												&nbsp;&nbsp;请您于&#12288;
												  <font color="red">${expertProj.srmExpertGroupProjExt.beginDate}</font>
												  &#12288;至&#12288; <font color="red">${expertProj.srmExpertGroupProjExt.endDate}</font>
												
												参加 【<font color="red">${expertProj.projName}</font>】 项目【<font color="red">${expertProj.srmExpertGroupProjExt.srmGradeScheme.evaluationName}</font>】评分  ，请确认是否参加！
												<c:if test="${currDate gt expertProj.srmExpertGroupProjExt.endDate}">
						              				<span style="float: right;color: red;width:150px" >
						              					<img src="<s:url value="/css/skin/${skinPath}/images/hurn.png"/>"/>已过期 | <a href="javascript:hide('${expertProj.expertProjFlow}');" >隐藏</a>
					              					</span>
				              					</c:if>
				              					<c:if test="${currDate le expertProj.srmExpertGroupProjExt.endDate}">
					            					<c:set value="${pageScope.i + 1}" var="i" scope="page"/> 
							            			<input type="button" value="同&#12288;意" class="dingdan-d" onclick="save('${expertProj.expertProjFlow}','${GlobalConstant.FLAG_Y}');"/>
							            			<input type="button" class="dingdan-d" value="不同意" onclick="save('${expertProj.expertProjFlow}','${GlobalConstant.FLAG_N}');"/>
					    						</c:if>
											</td>
										</tr>
										</c:if>
			              		</c:forEach>	
								</tbody>													
							</table>
						</td>
					</tr>
				</table>	
		</div>
	</div>
</div>
</body>
<script defer="defer">
$(document).ready(function(){
	$("#count").html('${i}');
});
</script>
</html>
