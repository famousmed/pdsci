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
</head>
<script type="text/javascript">
	function showProjInfo(){
		$("li").removeClass("selectTag");
		$("#projInfo").parent().addClass("selectTag");
		jboxGet('<s:url value='/irb/researcher/projInfo'/>?roleScope=${param.roleScope }&projFlow='+$("#projFlow").val()+"&type=show",null,function(resp){
			$("#tagContent").html(resp);
			$("#tagContent").hide();
			$("#tagContent").slideDown(500);
			$(document).ready(function(){
				hideButton();
			});
		},null,false);
	}
	
	function showApplyFile(){
		if($("#projFlow").val() == ""){
			jboxTip("请先保存项目信息!");
			return;
		}
		$("li").removeClass("selectTag");
		$("#applyFile").parent().addClass("selectTag");
		jboxGet('<s:url value='/irb/researcher/applyFileList'/>?projFlow='+$("#projFlow").val()+"&type=show",null,function(resp){
			$("#tagContent").html(resp);
			$("#tagContent").hide();
			$("#tagContent").slideDown(500);
			$(document).ready(function(){
				hideButton();
			});
		},null,false);
	}
	
	function irbApplication(){
		if($("#projFlow").val() == ""){
			jboxTip("请先保存项目信息!");
			return;
		}
		$("li").removeClass("selectTag");
		$("#applyTable").parent().addClass("selectTag");
		jboxGet("<s:url value='/irb/researcher/irbApplication'/>?type=show",null,function(resp){
			$("#tagContent").html(resp);
			$("#tagContent").hide();
			$("#tagContent").slideDown(500);
			$(document).ready(function(){
				hideButton();
			});
		},null,false);
	}
	
	function showProjUser(){
		if($("#projFlow").val() == ""){
			jboxTip("请先保存项目信息!");
			return;
		}
		$("li").removeClass("selectTag");
		$("#projUser").parent().addClass("selectTag");
		jboxGet("<s:url value='/irb/researcher/projUserList'/>?projFlow="+$("#projFlow").val()+"&type=show",null,function(resp){
			$("#tagContent").html(resp);
			$("#tagContent").hide();
			$("#tagContent").slideDown(500);
			$(document).ready(function(){
				hideButton();
			});
		},null,false);
	}
	
	function showModifyNotice(){
		if($("#projFlow").val() == ""){
			jboxTip("请先保存项目信息!");
			return;
		}
		$("li").removeClass("selectTag");
		$("#modifyNotice").parent().addClass("selectTag");
		jboxGet("<s:url value='/irb/researcher/showModifyNotice'/>?projFlow="+$("#projFlow").val()+"&type=show",null,function(resp){
			$("#tagContent").html(resp);
			$("#tagContent").hide();
			$("#tagContent").slideDown(500);
			$(document).ready(function(){
				hideButton();
			});
		},null,false);
	}
	
	function showAccptNotice(){
		var url = "<s:url value='/irb/secretary/checkAllConfirmJson'/>";
		var requestData = {"irbFlow":$("#irbFlow").val()};
		jboxPost(url,requestData,function(resp){
			if(resp=='${GlobalConstant.FLAG_Y}'){
				$("li").removeClass("selectTag");
				$("#accptNotice").parent().addClass("selectTag");
				jboxGet("<s:url value='/irb/secretary/receiptNotice'/>?irbFlow="+$("#irbFlow").val()+"&type=show",null,function(resp){
					$("#tagContent").html(resp);
					$("#tagContent").hide();
					$("#tagContent").slideDown(500);
					$(document).ready(function(){
						hideButton();
					});
				},null,false);
			}else{
				jboxTip('${GlobalConstant.NOTICE_OPER_ERROR}');
			}
		},null,false);
	}
	
	function showReviewWay(){
		var irbNo = $("#i_irbNo").val();
		if(!irbNo){
			jboxTip('${GlobalConstant.CHECKWAY_OPER_ERROR}');
			return false;
		}
		$("li").removeClass("selectTag");
		$("#reviewWay").parent().addClass("selectTag");
		jboxGet("<s:url value='/irb/secretary/showCheckWay'/>?irbFlow="+$("#irbFlow").val()+"&type=show",null,function(resp){
			$("#tagContent").html(resp);
			$("#tagContent").hide();
			$("#tagContent").slideDown(500);
			$(document).ready(function(){
				hideButton();
			});
		},null,false);
	}
	
	function showCommittee(){
		var checkWay = $("#i_checkWay").val();
		if(!checkWay){
			jboxTip('${GlobalConstant.CHOOSE_MEMBER_OPER_ERROR}');
			return false;
		}
		$("li").removeClass("selectTag");
		$("#committee").parent().addClass("selectTag");
		jboxGet("<s:url value='/irb/secretary/chooseMember'/>?irbFlow="+$("#irbFlow").val()+"&type=show",null,function(resp){
			$("#tagContent").html(resp);
			$("#tagContent").hide();
			$("#tagContent").slideDown(500);
			$(document).ready(function(){
				hideButton();
			});
		},null,false);
	}
	
	function showWorksheet(authId,irbUserFlow){
		$("li").removeClass("selectTag");
		$("#"+authId+"_"+irbUserFlow).parent().addClass("selectTag");
		jboxGet("<s:url value='/irb/committee/irbWorksheet'/>?irbFlow="+$("#irbFlow").val()+
				"&irbAuthTypeId="+authId+"&irbUserFlow="+irbUserFlow+"&type=show",null,function(resp){
			$("#tagContent").html(resp);
			$("#tagContent").hide();
			$("#tagContent").slideDown(500);
			$(document).ready(function(){
				hideButton();
			});
		},null,false);
	}
	
	function showQuickOpinion(){
		$("li").removeClass("selectTag");
		$("#quickOpinion").parent().addClass("selectTag");
		jboxGet("<s:url value='/irb/secretary/quickOpinion'/>?irbFlow="+$("#irbFlow").val()+"&type=show",null,function(resp){
			$("#tagContent").html(resp);
			$("#tagContent").hide();
			$("#tagContent").slideDown(500);
			$(document).ready(function(){
				hideButton();
			});
		},null,false);
	}
	
	function showMeetingRecord(){
		$("li").removeClass("selectTag");
		$("#meetingRecord").parent().addClass("selectTag");
		jboxGet("<s:url value='/irb/meeting/minutes'/>?irbFlow="+$("#irbFlow").val()+
				"&meetingArrange="+$("#meetingArrange").val()+"&type=show",null,function(resp){
			$("#tagContent").html(resp);
			$("#tagContent").hide();
			$("#tagContent").slideDown(500);
			$(document).ready(function(){
				hideButton();
			});
		},null,false);
	}
	
	function showMeetingDecision(){
		$("li").removeClass("selectTag");
		$("#meetingDecision").parent().addClass("selectTag");
		jboxGet("<s:url value='/irb/meeting/voteDesction'/>?irbFlow="+$("#irbFlow").val()+
				"&closeButton=${GlobalConstant.FLAG_N}"+"&type=show",null,function(resp){
			$("#tagContent").html(resp);
			$("#tagContent").hide();
			$("#tagContent").slideDown(500);
			$(document).ready(function(){
				hideButton();
			});
		},null,false);
	}
	
	function showApproveFile(){
		$("li").removeClass("selectTag");
		$("#approveFile").parent().addClass("selectTag");
		jboxGet("<s:url value='/irb/secretary/decisionDetail'/>?irbFlow="+$("#irbFlow").val()+
				"&type=view",null,function(resp){
			$("#tagContent").html(resp);
			$("#tagContent").hide();
			$("#tagContent").slideDown(500);
			$(document).ready(function(){
				hideButton();
			});
		},null,false);
	}
	
	function showIrbUsers(){
		$("li").removeClass("selectTag");
		$("#irbUsers").parent().addClass("selectTag");
		jboxGet("<s:url value='/irb/cfg/info'/>?recordFlow="+$("#irbInfoFlow").val()+
				"&desction=${GlobalConstant.FLAG_Y }"+"&type=show",null,function(resp){
			$("#tagContent").html(resp);
			$("#tagContent").hide();
			$("#tagContent").slideDown(500);
			$(document).ready(function(){
				hideButton();
			});
		},null,false);
	}
	
	function showArchiveFile(){
		$("li").removeClass("selectTag");
		$("#archiveFile").parent().addClass("selectTag");
		jboxGet("<s:url value='/irb/secretary/archive'/>?irbFlow="+$("#irbFlow").val()+
				"&type=show",null,function(resp){
			$("#tagContent").html(resp);
			$("#tagContent").hide();
			$("#tagContent").slideDown(500);
			$(document).ready(function(){
				hideButton();
			});
		},null,false);
	}
	
	$(document).ready(function(){
		if ('${param.id}' != '') {
			$("#${param.id}").click();
		} else {
			$("li a:first").click();
		}
	});
	
	$(document).ready(function(){
		hideButton();
	});
	
	
	function hideButton() {
		$(":input[type='button'][showFlag!='${GlobalConstant.FLAG_Y }']").each(function(){
			$(this).hide();
		});
		$('input').attr("readonly","readonly");
		$('textarea').attr("readonly","readonly");
		$("select").attr("disabled", "disabled");
		$(":checkbox").attr("disabled", "disabled");
		$(":radio").attr("disabled", "disabled");
	}
</script>
<body>
	<div id="main">
		<input type="hidden" id="projFlow" value="${param.projFlow }"/>
		<input type="hidden" id="irbFlow" value="${sessionScope.currIrb.irbFlow }"/>
		<input type="hidden" id="i_irbNo" value="${sessionScope.currIrb.irbNo }"/>
		<input type="hidden" id="i_checkWay" value="${sessionScope.currIrb.reviewWayName }"/>
		<input type="hidden" id="meetingArrange" value="${sessionScope.currIrb.meetingArrange }"/>
		<input type="hidden" id="irbInfoFlow" value="${sessionScope.currIrb.irbInfoFlow }"/>
		<div class="mainright">
			<div class="content">
				<div style="margin-top: 5px">
					&#12288;项目名称：<b>${proj.projShortName} </b>
					<span style="margin-left: 40px;">项目类别：</span><b>${proj.projSubTypeName}</b>
					<span style="margin-left: 40px;">伦理审查类别：</span><b>${sessionScope.currIrb.irbTypeName}</b>
					<span style="margin-left: 40px;">审查方式：</span><b>${sessionScope.currIrb.reviewWayName}</b>
					<span style="margin-left: 40px;">受理号：</span><b>${sessionScope.currIrb.irbNo}</b>
				</div>
				<div class="title1 clearfix">
					<ul id="tags">
					<c:if test="${param.type == 'apply' || param.stype == 'meeting' || param.vtype == 'view' }">
						<li class="selectTag" >
							<a id="projInfo" onclick="showProjInfo();" href="javascript:void(0)">项目基本信息</a>
						</li>
					</c:if>
					<c:if test="${param.type == 'apply' || param.stype == 'meeting'|| param.vtype == 'view'}">
						<li class="selectTag" >
							<a id="applyTable" onclick="irbApplication();" href="javascript:void(0)">审查申请表</a>
						</li>
					</c:if>
					<c:if test="${param.type == 'apply' || param.stype == 'meeting'|| param.vtype == 'view'}">
						<li >
							<a id="applyFile" onclick="showApplyFile();" href="javascript:void(0)">送审文件</a>
						</li>
					</c:if>
					<c:if test="${param.type == 'apply' || param.stype == 'meeting' || param.vtype == 'view' }">
						<li >
							<a id="projUser" onclick="showProjUser();" href="javascript:void(0)">研究团队</a>
						</li>
					</c:if>
					<c:if test="${param.type == 'apply' && noticeFlag}">
						<li class="selectTag">
							<a id="modifyNotice" onclick="showModifyNotice();" href="javascript:void(0)">补充修改通知</a>
						</li>
					</c:if>
					
					
					<c:if test="${param.type == 'accept' }">
						<li class="selectTag" >
							<a id="accptNotice" onclick="showAccptNotice();" href="javascript:void(0)" >受理通知</a>
						</li>
					</c:if>
					<c:if test="${param.type == 'accept' }">
						<li class="selectTag" >
							<a id="reviewWay" onclick="showReviewWay();" href="javascript:void(0)">审查方式</a>
						</li>
					</c:if>
					<c:if test="${param.type == 'accept' }">
						<li class="selectTag">
							<a id="committee" onclick="showCommittee();" href="javascript:void(0)">主审委员/独立顾问</a>
						</li>
					</c:if>
					
					<c:forEach items="${irbUserList}" var="irbUser">
					<c:if test="${param.type == 'review' }">
						<li class="selectTag">
						<a id="${irbUser.authId }_${irbUser.recordFlow}" onclick="showWorksheet('${irbUser.authId }','${irbUser.recordFlow}');" href="javascript:void(0)">
							<c:if test="${irbUser.authId==irbAuthTypeEnumCommitteePRO.id }">方案审查表_${irbUser.userName }</c:if>
							<c:if test="${irbUser.authId==irbAuthTypeEnumCommitteeICF.id }">知情同意书审查表_${irbUser.userName }</c:if>
							<c:if test="${irbUser.authId==irbAuthTypeEnumCommittee.id }">审查工作表_${irbUser.userName }</c:if>
							<c:if test="${irbUser.authId==irbAuthTypeEnumConsultant.id }">独立顾问咨询表_${irbUser.userName }</c:if>
						</a>
						</li>
					</c:if>
					</c:forEach>
					<c:if test="${param.type == 'review' }">
						<c:if test="${sessionScope.currIrb.reviewWayId == irbReviewTypeEnumFast.id || param.vtype == 'view'}">
							<li class="selectTag">
								<a id="quickOpinion" onclick="showQuickOpinion();" href="javascript:void(0)">快速主审综合意见</a>
							</li>
						</c:if>
					</c:if>
					<c:if test="${param.type == 'review' || param.vtype == 'view' }">
						<c:if test="${sessionScope.currIrb.meetingArrange==irbReviewTypeEnumMeeting.id }" >
							<li class="selectTag">
								<a id="meetingDecision" onclick="showMeetingDecision();" href="javascript:void(0)">会议审查决定表</a>
							</li>
						</c:if>
					</c:if>
					<c:if test="${param.type == 'review' || param.vtype == 'view'}">
						<li class="selectTag" >
							<a id="meetingRecord" onclick="showMeetingRecord();" href="javascript:void(0)">会议记录</a>
						</li>
					</c:if>
					
					<c:if test="${param.type == 'decision' || param.vtype == 'view' ||param.stype == 'meeting'}">
						<li class="selectTag">
							<a id="approveFile" onclick="showApproveFile();" href="javascript:void(0)">
							<c:if test="${irbRecTypeEnumOpinionFile.id == fileType}">${irbRecTypeEnumOpinionFile.name}</c:if>
							<c:if test="${irbRecTypeEnumApproveFile.id == fileType}">${irbRecTypeEnumApproveFile.name}</c:if>
							</a>
						</li>
					</c:if>
					<c:if test="${param.type == 'decision' }">
						<li class="selectTag">
							<a id="irbUsers" onclick="showIrbUsers();" href="javascript:void(0)">IRB成员名单</a>
						</li>
					</c:if>
					
					<c:if test="${param.type == 'archive' }">
						<li class="selectTag">
							<a id="archiveFile" onclick="showArchiveFile();" href="javascript:void(0)">文件存档</a>
						</li>
					</c:if>
					
					</ul>
				<div id="tagContent">
					<div class="tagContent selectTag" id="tagContent" style="margin-top: 5px">
					</div>
				</div>
			</div>
		</div>
		</div></div>
	</body>
</html>