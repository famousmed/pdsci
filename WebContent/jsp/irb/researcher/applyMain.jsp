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
	function uploadFile(){
		jboxOpen("<s:url value='/irb/researcher/applyFile'/>", "上传文件", 700,300);
	}
	function doBack(){
		if('${param.projFlow}' == "" || '${backType}' == 'list'){
			if ("${sessionScope.currWsId}" == "${GlobalConstant.GCP_WS_ID}") {
				window.location.href="<s:url value='/gcp/proj/projInfo'/>?roleScope=${param.roleScope}&projFlow=${param.projFlow}";
			} else {
				window.location.href="<s:url value='/irb/researcher/list/${param.roleScope}'/>?quickDatePickType=Month";
			}
		}else{
			window.location.href="<s:url value='/irb/researcher/process'/>?projFlow=${param.projFlow}&roleScope=${param.roleScope}&irbFlow=${param.irbFlow}";
		}
	}
	function showProjInfo(){
		$("li").removeClass("selectTag");
		$("#projInfo").parent().addClass("selectTag");
		jboxLoad("tagContent",'<s:url value='/irb/researcher/projInfo'/>?roleScope=${param.roleScope }&operType=${param.operType}&projFlow='+$("#projFlow").val(),true);
	}
	
	function showApplyFile(){
		if($("#projFlow").val() == ""){
			jboxTip("请先保存项目信息!");
			return;
		}
		$("li").removeClass("selectTag");
		$("#applyFile").parent().addClass("selectTag");
		jboxLoad("tagContent",'<s:url value='/irb/researcher/applyFileList'/>?projFlow='+$("#projFlow").val()+"&roleScope=${param.roleScope}&operType=${param.operType}&backType=${backType}",true);
	}
	function irbApplication(){
		if($("#projFlow").val() == ""){
			jboxTip("请先保存项目信息!");
			return;
		}
		$("li").removeClass("selectTag");
		$("#applyTable").parent().addClass("selectTag");
		jboxLoad("tagContent",'<s:url value='/irb/researcher/irbApplication'/>?operType=${param.operType}',true);
	}
	$(document).ready(function(){
		//showProjInfo();
		if('${param.from}'=='view'){ 
			//视图文件撤回修改提醒链接
			$("#applyFileTag").find("a").stop().click();
		}else {
			$("li a:first").click();
		}
	});
	function showProjUser(){
		if($("#projFlow").val() == ""){
			jboxTip("请先保存项目信息!");
			return;
		}
		$("li").removeClass("selectTag");
		$("#projUser").parent().addClass("selectTag");
		jboxLoad("tagContent",'<s:url value='/irb/researcher/projUserList'/>?projFlow='+$("#projFlow").val()+"&roleScope=${param.roleScope}&operType=${param.operType}",true);
	}
	function submitApply(){
		if($("#projFlow").val() == ""){
			jboxTip("请先保存项目信息!");
			return;
		}
		jboxGet("<s:url value="/irb/researcher/confirmApplyFile"/>",null,function(resp){
			if(resp == '${GlobalConstant.OPRE_SUCCESSED}'){ 
				jboxConfirm("确认提交送审?送审后无法修改送审信息!",function(){
					jboxGet("<s:url value="/irb/researcher/submitApply"/>",null,function(){
						window.location.href="<s:url value='/irb/researcher/process'/>?roleScope=${param.roleScope }&projFlow="+$("#projFlow").val();
					},null,true);
				});
			}else {
				jboxTip("送审文件不能为空!");
				return;
			}
		},null,false);
	}
	
	function showVitae(){
		$("li").removeClass("selectTag");
		$("#vitae").parent().addClass("selectTag");
		jboxLoad("tagContent",'<s:url value='/irb/researcher/mainResearchVitae'/>?projFlow='+$("#projFlow").val()+"&editFlag=${GlobalConstant.FLAG_N}",true);
	}
</script>
<body>
	<div id="main">
		<div class="mainright">
			<div class="content">
				<div class="title1 clearfix">
					<ul id="tags">
					<c:if test="${empty sessionScope.currIrb || sessionScope.currIrb.irbTypeId == irbTypeEnumInit.id }">
						<li class="selectTag" >
							<a id="projInfo" onclick="showProjInfo();" href="javascript:void(0)">项目基本信息</a>
						</li>
					</c:if>
						<li class="selectTag" >
							<a id="applyTable" onclick="irbApplication();" href="javascript:void(0)">审查申请表</a>
						</li>
						<li id="applyFileTag">
							<a id="applyFile" onclick="showApplyFile();" href="javascript:void(0)">送审文件清单</a>
						</li>
						<c:if test="${empty sessionScope.currIrb || sessionScope.currIrb.irbTypeId == irbTypeEnumInit.id }">
						<li >
							<a id="projUser" onclick="showProjUser();" href="javascript:void(0)">研究人员名单及职责</a>
						</li>
						<li >
							<a id="vitae" onclick="showVitae();" href="javascript:void(0)">主要研究者履历</a>
						</li>
						</c:if>
						<c:if test="${empty sessionScope.currIrb || sessionScope.currIrb.irbStageId == irbStageEnumApply.id }">
						<input type="button"  class="search" onclick="submitApply();" value="提交送审"/>
						</c:if>
						<input type="button"  class="search" value="返&#12288;回" onclick="doBack();"/> 
						<input type="hidden" id="projFlow" value="${param.projFlow }"/>
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