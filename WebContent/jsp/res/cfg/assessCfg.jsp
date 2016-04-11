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
	<jsp:param name="jquery_cxselect" value="true"/>
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
<style type="text/css">
	.edit3{text-align: center;border:none;}
	.cont_list{
		background:none;
		background-color: #f8f8f8;
		border:1px solid #e3e3e3;
		border-bottom-style: none;
	}
	.cont_list .left .name{
		color: #333;
	}
	[type='text']{width:150px;height: 22px;}
	select{width: 153px;height: 27px;}
</style>
<script type="text/javascript">
function addAssessTitle(){
	var cfgCodeId = $("select[name='cfgCodeId']").val();
	if(cfgCodeId ==""){
		jboxTip("请选择评分类型！");
		return false;
	}
	$("#addTitleButton").prev().show();
	$("#addTitleButton").hide();
	$("#saveTitleButton").show();
}

function modifyAssessTitle(titleId){
	$("#assessTitle_"+titleId).prev().hide();
	$("#assessTitle_"+titleId).show();
}

function saveAssessTitle(titleId){
	var data = "";
	var saveFlag = true;
	if(titleId!=""){//修改名称
		if($("#assessTitle_"+titleId).val().trim()==""){
			saveFlag = false;
			return false;
		}
		data = {
			id : titleId,
			name : $("#assessTitle_"+titleId).val()
		}
	}else{//新增名称
		if(false == $("#assessTitleForm").validationEngine("validate")){
			saveFlag = false;
			return false;
		}
		data = $("#assessTitleForm").serialize();
		$("#saveTitleButton").attr("disabled",true);
	}
	if(!saveFlag){
		return false;
	}
	var cfgCodeId = $("select[name='cfgCodeId'] option:selected").val();
	var url = "<s:url value='/res/cfg/saveAssessTitle'/>?cfgFlow=${assessCfg.cfgFlow}&cfgCodeId="+cfgCodeId;
	jboxPost(url, data,
			function(resp){
				if(resp == "${GlobalConstant.SAVE_SUCCESSED}"){
					search();
				}
			}, null, true);
}

function search(){
	var cfgCodeId = $("select[name='cfgCodeId'] option:selected").val();
	var url = "<s:url value='/res/cfg/assessCfg'/>?cfgCodeId=" + cfgCodeId;
	window.location.href = url;
}

function deleteTitle(id){
	jboxConfirm("确认删除？", function() {
		var cfgFlow = $("input[name='cfgFlow']").val();
		var url = "<s:url value='/res/cfg/deleteTitle'/>?cfgFlow="+cfgFlow +"&id=" +id;
		jboxPost(url, null,
				function(resp){
					if("${GlobalConstant.DELETE_SUCCESSED}" == resp){
						search();
					}
				}, 
				null,true);
	});
}

function addItem(titleId){
	$("#"+titleId+"Td").append($("#clone tr:eq(0)").clone());
	$addLastTr = $("#"+titleId+"Td").children("tr:last");
	$addLastTr.find("input[name='titleId']").val(titleId);
	$addLastTr.find("input[name='score']").attr("onblur","scoreCount('"+titleId+"')");
	$("#saveButton").show();
	$("#"+titleId+"noRecoredTd").hide();
	$addLastTr.children("td:last").children().attr("onclick","removeItemTr(this,'"+titleId+"')");
}

function removeItemTr(obj, titleId){
	$(obj).parent().parent().remove();
	var trs = $(".itemTd .addTr");
	if(trs.length<=0){
		$("#saveButton").hide();
	}
	scoreCount(titleId);
	var addTrs = $(".itemTd .addTr");
	if(trs.length<=0){
		$("#"+titleId+"noRecoredTd").show();
	}
}

function save(){
	if(false == $("#assessCfgForm").validationEngine("validate")){
		return false;
	}
	var trs = $(".itemTd .addTr");
	if(trs.length<=0){
		jboxTip("请添加考核指标！");
		return false;
	}
	var datas = [];
	$.each(trs, function(i,n){
		var titleId = $(n).find("input[name='titleId']").val();
		var name = $(n).find("input[name='name']").val();
		var score = $(n).find("input[name='score']").val();
		var data={
			"titleId":titleId, 
			"name":name, 
			"score":score
		};
		datas.push(data);
	});
	var cfgFlow = $("input[name='cfgFlow']").val();
	var requestData = {"itemFormList":datas, "cfgFlow":cfgFlow};
	var url = "<s:url value='/res/cfg/saveAssessItemList'/>";
	$("#saveButton").attr("disabled",true);
	jboxPostJson(
			url,
			JSON.stringify(requestData),
			function(resp){
				if("${GlobalConstant.SAVE_SUCCESSED}" == resp){
					search();
				}
			}, null, true);
}

function changeStyle(obj,stylename){
	$scoreTd = $(obj).parent().parent().prev();
	$score = $scoreTd.children();
	$name = $scoreTd.prev().children();
	$score.removeClass(stylename);
	$name.removeClass(stylename);
	$score.removeAttr("readonly");
	$name.removeAttr("readonly");
	$(obj).parent().hide();
	$(obj).parent().next().show();
}

function modifyItem(obj, itemId, titleId){
	if(false == $("#assessCfgForm").validationEngine("validate")){
		return false;
	}
	$scoreTd = $(obj).parent().parent().prev();
	$score =$scoreTd.children();
	$name = $scoreTd.prev().children();
	$score.addClass("edit3");
	$name.addClass("edit3");
	$score.attr("readonly","readonly");
	$name.attr("readonly","readonly");
	$(obj).parent().hide();
	$(obj).parent().prev().show();
	if($name.val()==$name.attr("oldvalue") && $score.val()==$score.attr("oldvalue")){
		jboxTip("没有修改！");
		return;
	}
	var cfgFlow = $("input[name='cfgFlow']").val();
	var data = {
			cfgFlow:cfgFlow,
			id:itemId,
			name:$name.val(),
			score:$score.val()
	};
	jboxPost("<s:url value='/res/cfg/modifyItem'/>",data,
			function(resp){
				if("${GlobalConstant.SAVE_SUCCESSED}" == resp){
					scoreCount(titleId);
					$name.attr("oldvalue",$name.val());
					$score.attr("oldvalue",$score.val());
				}
			}
			,null,true);
}

function deleteItem(id){
	jboxConfirm("确认删除？", function() {
		var cfgFlow = $("input[name='cfgFlow']").val();
		var url = "<s:url value='/res/cfg/deleteItem'/>?cfgFlow="+cfgFlow +"&id=" +id;
		jboxPost(url, null,
				function(resp){
					if("${GlobalConstant.DELETE_SUCCESSED}" == resp){
						search();
					}
				}, 
				null,true);
	});
}

function scoreCount(titleId){
	var trs = $("#"+titleId+"Td").children();
	var scoreCount = 0;
	$.each(trs, function(i,n){
		var score = $(n).find("input[name='score']").val();
		if (score == null || score == undefined || score == '' || isNaN(score)){
			score = 0;
		}
		scoreCount += parseFloat(score);
	});
	$("#scoreCount_"+titleId).text(scoreCount);
}

$(document).ready(function(){
	<c:forEach items="${titleFormList}" var="title">
		scoreCount("${title.id}");
	</c:forEach>
});
</script>
</head>
<body>
<div class="mainright">
<div class="content">
	<div class="title1 clearfix">
		评分类型：
		<select name="cfgCodeId" onchange="search();" class="validate[required]">
			<option value="">请选择</option>
           	<c:forEach var="cfgCode" items="${resAssessTypeEnumList}">
	            <option value="${cfgCode.id}" <c:if test="${param.cfgCodeId eq cfgCode.id}">selected="selected"</c:if>>${cfgCode.name}</option>
	        </c:forEach>
		</select>
		<div style="float: right;">
		<form id="assessTitleForm">
			<input type="hidden" name="id" id="titleId"/>
			<span style="display:none;">
				名&#12288;称：
				<input type="text" name="name" id="titleName" class="validate[required,maxSize[50]]" />
			</span>
			<input class="search" type="button" id="addTitleButton" value="新&#12288;增" onclick="addAssessTitle();"/>
			<input class="search" type="button" id="saveTitleButton" value="保&#12288;存" onclick="saveAssessTitle('');" style="display: none;"/>
		</form>
		</div>
		
		
		<form id="assessCfgForm" method="post" style="position: relative;margin-top: 10px;">
			<input type="hidden" name="cfgFlow" value="${assessCfg.cfgFlow}"/>
			<!-- 标题 -->
			<c:forEach items="${titleFormList}" var="title">
				<div class="cont_list" style="margin-top: 15px;">
					<div class="left" style="width: 880px;">
						名&#12288;称：<span class="name" style="width: 720px;">
						<font>${title.name}</font>
						<input id="assessTitle_${title.id}" type="text" class="validate[required,maxSize[50]]" style="display: none;" onblur="saveAssessTitle('${title.id}');" value="${title.name}"/>
						</span>
						总&#12288;分：<font id="scoreCount_${title.id}"></font>
					</div>
					<div class="right" style="width: 100px;float:right;padding-right: 15px;">
						<a style="cursor: pointer;" onclick="addItem('${title.id}')"><img alt="新增" title="新增" src="<s:url value="/css/skin/Blue/images/add.png"/>"/></a>&nbsp;&nbsp;
						<a style="cursor: pointer;" onclick="modifyAssessTitle('${title.id}')"><img alt="修改" title="修改" src="<s:url value="/css/skin/Blue/images/modify.png"/>"/></a>&nbsp;
						<a style="cursor: pointer;" onclick="deleteTitle('${title.id}')"><img alt="删除" title="删除" src="<s:url value="/css/skin/Blue/images/del2.png"/>"></a>
					</div>
				</div>
				<div style="padding-top: 0px;">
					<table class="xllist"  cellpadding="0" cellspacing="0" style="width: 100%">
						<colgroup>
							<col width="80%"/>
							<col width="10%"/>
							<col width="10%"/>
						</colgroup>
						<tr>
							<th style="text-align: center;">考核指标</th>
							<th style="text-align: center;">分数</th>
							<th style="text-align: center;">操作</th>
						</tr>
						<!-- item -->
						<tbody id="${title.id}Td" class="itemTd">
						<c:forEach items="${title.itemList}" var="item" varStatus="status">
						  <tr>
						    <td>
					   		 	<input type="text" class="validate[required,maxSize[50]] edit3" style="text-align: left;width: 90%;text-align: center;" oldvalue="${item.name}" value="${item.name}" readonly="readonly"/>
						    </td>
						    <td>
						    	<input type="text" name="score" class="validate[required,custom[number]] edit3" style="text-align: left;width: 90%;text-align: center;" oldvalue="${item.score}" value="${item.score}" readonly="readonly"/>
						    </td>
						    <td>
								<span>[<a href="javascript:void(0)" onclick="changeStyle(this,'edit3');">编辑</a>]</span>
							    <span style="display: none;">[<a href="javascript:void(0)" onclick="modifyItem(this,'${item.id}','${title.id}')">保存</a>]</span>
							    | [<a href="javascript:void(0)" onclick="deleteItem('${item.id}')">删除</a>]
							</td>
						  </tr>
						</c:forEach>
						</tbody>
						<c:if test="${empty title.itemList}">
						<tr  id="${title.id}noRecoredTd">
						    <td colspan="3">无记录！</td>
						</tr>
						</c:if>
					</table>
				</div>
			</c:forEach>
		</form>
		<c:if test="${empty titleFormList}">
		  	<table width="100%" class="basic">
				<tr>
					<th style="text-align: center;">无记录！</th>
				</tr>
			</table>
		</c:if>
		<div class="button" style="width: 100%;">
			<input class="search" type="button" id="saveButton" style="display: none;" value="保&#12288;存" onclick="save();" />
		</div>
	</div>
</div>
</div>

<table style="display: none;" id="clone">
	<tr class="addTr">
		<td>
			<input type="hidden" name="titleId"/>
			<input type="text" name="name" class="validate[required,maxSize[50]]" style="width:90%;"/>
		</td>
		<td><input type="text" name="score" class="validate[required,custom[number]]" style="width:90%;"/></td>
		<td>
			[<a href="javascript:void(0)" >删除</a>]
		</td>
	</tr>
</table>
</body>
</html>