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
		<jsp:param name="jquery_ui_sortable" value="true"/>
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
	//加载状态等级
	var statusLevel = [
			<c:forEach items="${gcpQcStatusEnumList}" var="qcStatus" varStatus="seq">
				${seq.first?'':','}"${qcStatus.id}"
			</c:forEach>
	];
	
	//配置提交提示
	var submitConfirm = {
			"${gcpQcTypeEnumOrg.id}${gcpQcStatusEnumSave.id}":"至研究者反馈",
			"${gcpQcTypeEnumDept.id}${gcpQcStatusEnumSave.id}":"至机构审核",
			"${gcpQcTypeEnumDept.id}${gcpQcStatusEnumSubmit.id}":"至研究者反馈",
			"${gcpQcTypeEnumOrg.id}${gcpQcStatusEnumSubmit.id}":"至机构完成报告",
			"${gcpQcTypeEnumDept.id}${gcpQcStatusEnumOrgCheck.id}":"至机构完成报告",
	};
	
	//配置文本框显示
	var afbView = {
			"${GlobalConstant.ROLE_SCOPE_GO}${gcpQcTypeEnumOrg.id}advise":statusLevel.indexOf("${gcpQcStatusEnumSave.id}"),
			"${GlobalConstant.ROLE_SCOPE_GO}${gcpQcTypeEnumOrg.id}feedback":statusLevel.indexOf("${gcpQcStatusEnumFeedback.id}"),
			"${GlobalConstant.ROLE_SCOPE_GO}${gcpQcTypeEnumDept.id}advise":statusLevel.indexOf("${gcpQcStatusEnumSubmit.id}"),
			"${GlobalConstant.ROLE_SCOPE_GO}${gcpQcTypeEnumDept.id}feedback":statusLevel.indexOf("${gcpQcStatusEnumFeedback.id}"),
			"${GlobalConstant.ROLE_SCOPE_RESEARCHER}${gcpQcTypeEnumOrg.id}advise":statusLevel.indexOf("${gcpQcStatusEnumSubmit.id}"),
			"${GlobalConstant.ROLE_SCOPE_RESEARCHER}${gcpQcTypeEnumOrg.id}feedback":statusLevel.indexOf("${gcpQcStatusEnumSubmit.id}"),
			"${GlobalConstant.ROLE_SCOPE_RESEARCHER}${gcpQcTypeEnumDept.id}advise":statusLevel.indexOf("${gcpQcStatusEnumOrgCheck.id}"),
			"${GlobalConstant.ROLE_SCOPE_RESEARCHER}${gcpQcTypeEnumDept.id}feedback":statusLevel.indexOf("${gcpQcStatusEnumOrgCheck.id}"),
	};
	
	//配置按钮显示状态
	var buttonStatus = {
						"${GlobalConstant.ROLE_SCOPE_GO}${gcpQcTypeEnumOrg.id}${gcpQcStatusEnumSave.id}":false,
	                    "${GlobalConstant.ROLE_SCOPE_RESEARCHER}${gcpQcTypeEnumOrg.id}${gcpQcStatusEnumSubmit.id}":false,
	                    "${GlobalConstant.ROLE_SCOPE_GO}${gcpQcTypeEnumDept.id}${gcpQcStatusEnumSubmit.id}":false,
	                    "${GlobalConstant.ROLE_SCOPE_RESEARCHER}${gcpQcTypeEnumDept.id}${gcpQcStatusEnumSave.id}":false,
	                    "${GlobalConstant.ROLE_SCOPE_RESEARCHER}${gcpQcTypeEnumDept.id}${gcpQcStatusEnumOrgCheck.id}":false,
	                    };
	
	//配置返回路径
	var backPath = {
			"main":"proj/main",
			"projInfo":"proj/projInfo",
			"projQcList":"qc/projQcList",
	};
	
	//配置标签
	var detailTags = {
			"${gcpQcTypeEnumOrg.id}":{
				"${gcpQcCategoryEnumFirstCaseGroup.id}":[
				                                         {"id":"${gcpRecTypeEnumOrg_First_CheckList.id}","name":"${gcpRecTypeEnumOrg_First_CheckList.name}"}
				                                         ,{"id":"${gcpRecTypeEnumInspectSummary.id}","name":"${gcpRecTypeEnumInspectSummary.name}"}
				                                         ],
				"${gcpQcCategoryEnumOneThirdGroup.id}":[
				                                        {"id":"${gcpRecTypeEnumInspectSummary.id}","name":"${gcpRecTypeEnumInspectSummary.name}"}
				                                        ],
			},
			"${gcpQcTypeEnumDept.id}":{
				"${gcpQcCategoryEnumFirstCaseGroup.id}":[
				                                         {"id":"${gcpRecTypeEnumInspectSummary.id}","name":"${gcpRecTypeEnumInspectSummary.name}"}
				                                         ],
				"${gcpQcCategoryEnumOneThirdGroup.id}":[
				                                        {"id":"${gcpRecTypeEnumFileInspect.id}","name":"${gcpRecTypeEnumFileInspect.name}"}
				                                        ,{"id":"${gcpRecTypeEnumDept_OTG_CheckList.id}","name":"${gcpRecTypeEnumDept_OTG_CheckList.name}"}
				                                        ,{"id":"${gcpRecTypeEnumInspectSummary.id}","name":"${gcpRecTypeEnumInspectSummary.name}"}
				                                        ],
			},
	};
	
	//加载状态
	var role = "${param.roleScope}";
	var qcStatus = "${qcRecord.qcStatusId}";
	var qcType = "${qcRecord.qcTypeId}";
	var qcCategory = "${qcRecord.qcCategoryId}";
	var qcStartDate = "${qcRecord.qcStartDate}";
	var qcEndDate = "${qcRecord.qcEndDate}";
	
	//加载标签
	$(function(){
		var tags = detailTags["${qcRecord.qcTypeId}"]["${qcRecord.qcCategoryId}"];
		var tagHome = $("#tags");
		for(var i in tags){
			var tag = $("<li "+(i==0?"class='selectTag'":"")+" onclick='selTag(this);'><a href=\"javascript:loadRecordRec('"+tags[i].id+"');\">"+tags[i].name+"</a></li>");
			tagHome.append(tag);
		}
		loadRecordRec(tags[0].id);
		$("#recSubmit").bind("click",function(){
			var qcStatusId = qcStatus;
			var statusIndex = statusLevel.indexOf(qcStatus);
			if(qcType=="${gcpQcTypeEnumOrg.id}" && qcStatus=="${gcpQcStatusEnumSubmit.id}"){
				statusIndex+=2;
			}else{
				statusIndex++;
			}
			qcStatusId = statusLevel[statusIndex];
			submitQc(qcStatusId);
		});
		buttonShow();
	});
	
	//加载标签内容
	function loadRecordRec(type){
		if(type != "${gcpRecTypeEnumInspectSummary.id}"){
			$("#recSubmit").hide();
		}
		jboxGet("<s:url value='/gcp/qc/recordRecDetail'/>?projFlow=${proj.projFlow}&roleScope=${param.roleScope}&qcFlow=${qcRecord.qcFlow}&recTypeId="+type+"&qcTypeId="+qcType+"&qcCategoryId="+qcCategory,null,function(resp){
			$("#recordRec").html(resp);
			buttonShow();
		},null,false);
	}
	
	//标签高亮
	function selTag(tag){
		$(".selectTag").removeClass("selectTag");
		$(tag).addClass("selectTag");
	}
	
	//按钮显示
	function buttonShow(){
		var isShow = role+qcType+qcStatus in buttonStatus;
		if(isShow){
			$("#recSave").show();
			if(role=="${GlobalConstant.ROLE_SCOPE_RESEARCHER}" && qcType=="${gcpQcTypeEnumDept.id}" && qcStatus=="${gcpQcStatusEnumSave.id}" && $("[name='recTypeId']").val() == "${gcpRecTypeEnumInspectSummary.id}"){
				$("#recSave").hide();
			}
			if(qcStatus != "${gcpQcStatusEnumSave.id}" && $("[name='recTypeId']").val() != "${gcpRecTypeEnumInspectSummary.id}"){
				$("#recSave").hide();
			}
		}
		return isShow;
	}
	
	//保存表单
	function saveRecordRec(){
		if($("#recordRecForm").validationEngine("validate")){
			var url = "<s:url value='/gcp/qc/saveQcRecordRec'/>";
			var data = $("#recordRecForm").serialize();
			jboxPost(url,data,function(resp){
				if('${GlobalConstant.SAVE_SUCCESSED}'==resp){
					if($("[name='recTypeId']").val() == "${gcpRecTypeEnumInspectSummary.id}"){
						$("#recSubmit").show();
					}else{
						location.href="#qcDetailTop";
					}
				}
			});
		}
	}
	
	//提交表单
	function submitQc(statusId){
		var info = "确认提交"+submitConfirm[qcType+qcStatus]+"?";
		if(statusId == "${gcpQcStatusEnumFinish.id}"){
			info = "确定完成本次质控?";
		}
		jboxConfirm(info,function(){
			var url = "<s:url value='/gcp/qc/submitQcRecord'/>?qcFlow=${qcRecord.qcFlow}&qcStatusId="+statusId;
			jboxPost(url,null,function(resp){
				if('${GlobalConstant.OPRE_SUCCESSED}'==resp){
					location.reload(true);
				}
			});
		});
	}
	
	//返回
	function back(){
		location.href = "<s:url value='/gcp/"+backPath["${param.beforePage}"]+"'/>?projFlow=${proj.projFlow}&roleScope=${param.roleScope}&tagId=zkjl";
	}
	
	//checkbox单选
	function singleSel(className){
		var thisSel = className.checked;
		$("[name='"+className.name+"']").attr("checked",false);
		className.checked = thisSel;
	}
	
	//读写限制
	function disableTag(){
		if(qcStatus != "${gcpQcStatusEnumSave.id}"){
			$(":text,textarea").attr("readonly",true);
			$("select,:checkbox").attr("disabled",true);
			$(":text.time").attr("onclick",null);
			if(role=="${GlobalConstant.ROLE_SCOPE_GO}" && ((qcType=="${gcpQcTypeEnumOrg.id}" && qcStatus=="${gcpQcStatusEnumSave.id}") || (qcType=="${gcpQcTypeEnumDept.id}" && qcStatus=="${gcpQcStatusEnumSubmit.id}"))){
				$(".advise").attr("readonly",false);
				$(".advise.time").attr({
					"onclick":"WdatePicker({dateFmt:'yyyy-MM-dd'})",
					"readonly":true,
				});
			}
			if(role=="${GlobalConstant.ROLE_SCOPE_RESEARCHER}" && ((qcType=="${gcpQcTypeEnumOrg.id}" && qcStatus=="${gcpQcStatusEnumSubmit.id}") || (qcType=="${gcpQcTypeEnumDept.id}" && qcStatus=="${gcpQcStatusEnumOrgCheck.id}"))){
				$(".feedback").attr("readonly",false);
				$(".feedback.time").attr({
					"onclick":"WdatePicker({dateFmt:'yyyy-MM-dd'})",
					"readonly":true,
				});
			}
		}
	}
</script>

<body>
<div id="main">
   <div class="mainright">
      <div class="content">
        <div class="title1 clearfix">
        <div style="margin-bottom: 10px">
        	<a name="qcDetailTop"></a>
        	<table class="basic" width="100%">
        		<tr>
        			<td colspan="5">
        				<font style="font-weight: bold;">项目名称：</font>&nbsp;${proj.projName}
			        	&#12288;
			        	${proj.projSubTypeName}
			        	&#12288;
			        	${proj.projDeclarer}
			        	&#12288;&#12288;
        				<font style="font-weight: bold;">质控类型：</font>&nbsp;${qcRecord.qcTypeName}
        				&#12288;&#12288;&#12288;
        				<font style="font-weight: bold;">质控节点：</font>&nbsp;${qcRecord.qcCategoryName}
        				&#12288;&#12288;&#12288;
        				<c:if test="${(gcpQcStatusEnumFeedback.id eq qcRecord.qcStatusId) && (param.roleScope eq GlobalConstant.ROLE_SCOPE_GO)}">
        					<input class="search" type="button" value="完&#12288;成" onclick="submitQc('${gcpQcStatusEnumFinish.id}');" />
        				</c:if>
        				<input class="search" type="button" value="返&#12288;回" onclick="back();" />
        			</td>
        		</tr>
        		<tr>
        			<td width="20%">检查开始日期：${qcRecord.qcStartDate}</td>
        			<td width="20%">检查结束日期：${qcRecord.qcEndDate}</td>
        			<td width="15%">检查人：${qcRecord.qcOperator}</td>
        			<td width="25%">检查病历/CRF编码：${qcRecord.qcPatientCodes}</td>
        			<td width="20%">质控状态：${qcRecord.qcStatusName}</td>
        		</tr>
        	</table>
        </div>
        <ul id="tags">
        	
        </ul>
        <div id="tagContent">
        	<form id="recordRecForm">
        		<input type="hidden" name="qcFlow" value="${qcRecord.qcFlow}"/>
        		<input type="hidden" name="projFlow" value="${proj.projFlow}"/>
	            <div class="tagContent selectTag i-trend-main-div" id="recordRec">
	            	
	            </div>
            </form>
            <div style="width: 100%;margin-bottom: 10px" align="center" id="buttonHome">
				<input class="search" type="button" id="recSave" value="保&#12288;存" onclick="saveRecordRec();" style="display: none;"/>
				<input class="search" type="button" id="recSubmit" value="提&#12288;交" style="display: none;"/>
			</div>
   		</div>
        <p>
    	</p>
      </div>
   	 </div>
	</div>
</div>
</body></html>