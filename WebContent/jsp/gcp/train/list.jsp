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
<style type="text/css">
</style>
<script type="text/javascript">
	var width=(window.screen.width)*0.8;
	var height=(window.screen.height)*0.7;
	
	function editTrain(recordFlow){
		var url = "<s:url value='/pub/train/editTrainSummary'/>?recordFlow=" + recordFlow;
		var flag = "新增";
		if(recordFlow){
			flag = "修改";
		}
		//jboxOpen(url, flag + "计划/总结", 900, 650);
		window.location.href=url;
	}
	
	function delTrain(recordFlow){
		jboxConfirm("确认删除？", function(){
			var url = "<s:url value='/pub/train/delTrainSummary'/>?recordFlow=" + recordFlow; 
			jboxGet(url, null, function(resp){
				if(resp == '${GlobalConstant.DELETE_SUCCESSED}'){
					window.parent.frames['mainIframe'].location.reload(true);
				}
			});
			
		});
	}
	
	function search(){
		$("#searchForm").submit();
	}
	
	function showContent(recordFlow){
		var div = $("#div_"+recordFlow);
		var content = $("#content_"+recordFlow);
		if($.trim(content.html()) == ""){
			div.slideDown("slow",function(){
				var url = "<s:url value='/pub/train/editTrainSummary'/>?recordFlow=" + recordFlow +"&viewFlag=${GlobalConstant.FLAG_Y}";
				jboxLoad("content_"+recordFlow, url, false);
		 	});
		}else{
			div.slideToggle("slow");
		}
	}
	 
</script>
</head>
<body>
<div class="mainright">
	<div class="content">
	<div class="title1 clearfix">
		<div>
		<select class="inputText"><option>${year}</option></select> 年度机构<c:forEach items="${irbTrainCategoryEnumList}" var="cEunm">${cEunm.name}：<span style="color: red">${countMap[cEunm.id] }</span>&#12288;</c:forEach>培训分类<c:forEach items="${irbTrainTypeEnumList}" var="tEunm"><span style="color: blue">${tEunm.name}</span>：${countMap[tEunm.id] }&#12288;</c:forEach>
		<input class="search" type="button" value="新&#12288;增" onclick="editTrain('')" style="float: right"/>
		</div>
		<c:if test="${empty summaryList}">
			<div class="cont_list" style="text-align: center;">
					无记录！
			</div>
		</c:if>
		<div style="padding-top: 20px;">
		<c:forEach items="${summaryList}" var="summary">
			<div class="cont_list">
				<div class="left" style="width: 900px;" onclick="showContent('${summary.recordFlow}');">标题：<span class="name">${summary.summaryTitle}</span>
					<span class="zje" style="color: black;">类别：
						<c:forEach var="summaryType" items="${trainSummaryTypeEnumList}">
						 	<c:if test="${summary.summaryTypeId eq summaryType.id}">${summaryType.name}</c:if>
						</c:forEach>
					</span>
				</div>
				<div class="right" style="width: 50px; float: right;padding-right: 25px;">
					<a onclick="editTrain('${summary.recordFlow}')"><img alt="修改" title="修改" src="<s:url value="/css/skin/Blue/images/modify.png"/>"/></a>&nbsp;
					<a onclick="delTrain('${summary.recordFlow}')"><img alt="删除" title="删除" src="<s:url value="/css/skin/Blue/images/del2.png"/>"></a>
				</div>	
			</div>
				
			<div id="div_${summary.recordFlow}" style="display: none;">
				<div class="i-trend" style="padding-top: 0px;">
			      <table class="i-trend-table" style="border: none;" cellpadding="0" cellspacing="0">
			      <tbody>
			        <tr>
			          <td>
			             <div class="selectTag" id="content_${summary.recordFlow}">
			             </div>
			          </td>
			        </tr>
			      </tbody>
			      </table>
 				 </div>
			</div>
			<div class="cont_spe"></div>
		</c:forEach>
		</div>
	</div>
	</div>
</div>
</body>
</html>