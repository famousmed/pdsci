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

<script type="text/javascript" src="<s:url value='/js/ajaxfileupload.js'/>?v=${applicationScope.sysCfgMap['sys_version']}"></script>

<script type="text/javascript">
function edit(userFlow) {
	jboxOpen("<s:url value='/sys/user/edit/${GlobalConstant.USER_LIST_PERSONAL}?userFlow='/>"
			+ userFlow, "修改个人信息", 900, 400);
}

$(document).ready(function(){
	<c:if test="${GlobalConstant.FLAG_Y eq sysCfgMap['sys_user_show_resum']}">
		loadEdu();
	 	loadWork();
		loadAcademic();
		loadProj();
		loadTrain();
		loadThesis();
		loadBook();
		loadPatent();
		loadSat();
	</c:if>
});

function loadEdu(){
	jboxLoad("edu","<s:url value='/pub/resume/loadView?type=education&userFlow=${user.userFlow}&editFlag=${param.editFlag}'/>");
}

function loadWork(){
	jboxLoad("work","<s:url value='/pub/resume/loadView?type=work&userFlow=${user.userFlow}&editFlag=${param.editFlag}'/>");
}

function loadAcademic(){
	jboxLoad("academic","<s:url value='/pub/resume/loadView?type=academic&userFlow=${user.userFlow}&editFlag=${param.editFlag}'/>");
}

function loadProj(){
	jboxLoad("proj","<s:url value='/pub/resume/loadView?type=proj&userFlow=${user.userFlow}'/>");
}

function loadTrain(){
	jboxLoad("train","<s:url value='/pub/resume/loadView?type=train&userFlow=${user.userFlow}'/>");
}


function loadThesis(){
	var url = "<s:url value='/pub/resume/loadView'/>?type=thesis&userFlow=${user.userFlow}";
	jboxLoad("thesis",url+achievementFlag());
}

function loadBook(){
	var url = "<s:url value='/pub/resume/loadView'/>?type=book&userFlow=${user.userFlow}";
	jboxLoad("book",url+achievementFlag());
}

function loadPatent(){
	var url = "<s:url value='/pub/resume/loadView'/>?type=patent&userFlow=${user.userFlow}";
	jboxLoad("patent",url+achievementFlag());
}

function loadSat(){
	var url = "<s:url value='/pub/resume/loadView'/>?type=sat&userFlow=${user.userFlow}";
	jboxLoad("sat",url+achievementFlag());
}

function searchUser(){
	window.location.reload();
}

function slideToggle(obj){
	$("."+obj).slideToggle("fast");
}

function print(){
	var url ="<s:url value='/irb/printOther'/>?watermarkFlag=${GlobalConstant.FLAG_N}&userFlow=${user.userFlow}&recTypeId=researcherResume";
	window.location.href= url;
}

function achievementFlag(){
	if("${sessionScope.currWsId}" != "${GlobalConstant.SRM_WS_ID}"){
		return "&editFlag=${param.editFlag}";
	}
}

function uploadImage(){
	$.ajaxFileUpload({
		url:"<s:url value='/sys/user/userHeadImgUpload'/>?userFlow=${user.userFlow}",
		secureuri:false,
		fileElementId:'imageFile',
		dataType: 'json',
		success: function (data, status){
			if(data.indexOf("success")==-1){
				jboxTip(data);
			}else{
				jboxTip('${GlobalConstant.UPLOAD_SUCCESSED}');
				var arr = new Array();
				arr = data.split(":");
				$("#userImg").val(arr[1]);
				var url = "${sysCfgMap['upload_base_url']}/"+ arr[1];
				$("#showImg").attr("src",url);
				
			}
		},
		error: function (data, status, e){
			jboxTip('${GlobalConstant.UPLOAD_FAIL}');
		},
		complete:function(){
			$("#imageFile").val("");
		}
	});
}
</script>
</head>
<body>
<div class="mainright">
		<div class="content">
	<div class="title1 clearfix">
		<div style="margin-bottom: 10px;" align="right">
		<!-- 
		<input type="checkbox" title="全选"/>类型：<input type="checkbox"/>教育经历&#12288;<input type="checkbox"/>工作经历&#12288;<input type="checkbox"/>学会任职&#12288;
		<input type="checkbox"/>课题情况&#12288;<input type="checkbox"/>培训情况&#12288;<input type="checkbox"/>论文&#12288;<input type="checkbox"/>著作&#12288;
		<input type="checkbox"/>专利&#12288;<input type="checkbox"/>获奖&#12288;
		 -->
		 <input type="button" value="下&#12288;载" class="search" onclick="print();"/>
		 </div>
		<!-- 基本信息 -->
		<div id="base">
			<table  class="xllist">
				<tr>
					<th colspan="4" style="text-align: left;padding-left: 20px;">基本信息
						<c:if test="${param.editFlag == GlobalConstant.FLAG_Y && sessionScope.currWsId !=GlobalConstant.ERP_WS_ID}">
							<a style="float: right;padding-right: 10px;" href="javascript:edit('${ user.userFlow}')">[修改]</a>
						</c:if>
					</th>
				</tr>
				<tr>
					<td style="text-align: left;padding-left: 30px;width: 25%">姓&#12288;名：${user.userName}</td>
					<td style="text-align: left;padding-left: 30px;width: 25%">性&#12288;别：${user.sexName }</td>
					<td style="text-align: left;padding-left: 30px;">登录名：${user.userCode}</td>
					<td style="text-align: left;;width:200px" rowspan="5">
						<div style="width: 110px;height: 130px;margin: 5px auto 0px;">
							<img src="${sysCfgMap['upload_base_url']}/${user.userHeadImg}" id="showImg" width="100%" height="100%" onerror="this.src='<s:url value="/jsp/edu/css/images/up-pic.jpg"/>'"/>
						</div>
						<div>
							<span style="cursor: pointer;float: right;">
								[<a onclick="$('#imageFile').click();">${empty user.userHeadImg?'上传头像':'重新上传'}</a>]
							</span>
							<input type="file" id="imageFile" name="headImg" style="display: none" onchange="uploadImage();"/>
						</div>
					</td>
				</tr>
				<tr>
					<td style="text-align: left;padding-left: 30px;width: 25%">出生日期：${user.userBirthday }</td>
					<td style="text-align: left;padding-left: 30px;">年&#12288;龄：${pdfn:calculateAge(user.userBirthday)}岁</td>
					<td style="text-align: left;padding-left: 30px;">身份证号：${user.idNo}</td>
				</tr>
				<tr>
					<td style="text-align: left;padding-left: 30px;">学&#12288;历：${user.educationName }</td>
					<td style="text-align: left;padding-left: 30px;">学&#12288;位：${user.degreeName}</td>
					<td style="text-align: left;padding-left: 30px;">工作单位：${user.orgName }</td>
				</tr>
				<tr>
					<td style="text-align: left;padding-left: 30px;">部&#12288;门：${user.deptName }</td>
					<td style="text-align: left;padding-left: 30px;">职&#12288;务：${user.postName }</td>
					<td style="text-align: left;padding-left: 30px;">职&#12288;称：${user.titleName }</td>
				</tr>
				<tr>
					<td style="text-align: left;padding-left: 30px;">手&#12288;机：${user.userPhone }</td>
					<td style="text-align: left;padding-left: 30px;">邮&#12288;件：${user.userEmail }</td>
					<td style="text-align: left;padding-left: 30px;"></td>
				</tr>
			</table>
		</div>
		
		<!-- 教育经历 -->
		<div id="edu" style="padding-top: 10px;"></div>
		
		<!-- 工作经历 -->
		<div id="work" style="padding-top: 10px;"></div>
		
		<!-- 学会任职 -->
		<div id="academic" style="padding-top: 10px;"></div>
		
		<!-- 课题情况 -->
		<div id="proj" style="padding-top: 10px;"></div>
		
		<!-- 培训情况 -->
		<div id="train" style="padding-top: 10px;"></div>
		
		<!-- 论文 -->
		<div id="thesis" style="padding-top: 10px;"></div>
		<!-- 著作 -->
		<div id="book" style="padding-top: 10px;"></div>
		<!-- 专利 -->
		<div id="patent" style="padding-top: 10px;"></div>
		<!-- 论文 -->
		<div id="sat" style="padding-top: 10px;"></div>
		
	</div>
</div>
</div>
</body>
</html>