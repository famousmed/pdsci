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
	//var width=(window.screen.width)*0.8;
	//var height=(window.screen.height)*0.7;
	function add(){
		var url = "<s:url value ='/gcp/workFile/editWorkpaper'/>?workpaperTypeId=${param.workpaperTypeId}";
		window.location.href=url;
	}
	function editWorkpaper(recordFlow){
		var url = "<s:url value ='/gcp/workFile/editWorkpaper'/>?workpaperTypeId=${param.workpaperTypeId}&recordFlow=" + recordFlow;
		window.location.href=url;
	}
	function showDetail(recordFlow){
		var div = $("#div_"+recordFlow);
		var content = $("#content_"+recordFlow);
		if($.trim(content.html()) == ""){
			div.slideDown("slow",function(){
				var url = "<s:url value='/gcp/workFile/editWorkpaper'/>?recordFlow=" + recordFlow + "&viewFlag=${GlobalConstant.FLAG_Y}";
				jboxLoad("content_"+recordFlow, url, false);
		 	});
		}else{
			div.slideToggle("slow");
		}
	}
	
	function delWorkpaper(recordFlow){
		jboxConfirm("删除工作文件？",function(){
			var url = "<s:url value='/gcp/workFile/delWorkpaper'/>?recordFlow="+recordFlow;
			jboxPost(url,null,function(resp){
				if(resp=='${GlobalConstant.DELETE_SUCCESSED}'){
					window.location.reload();
				}
			},null,true);
		},null);
	}
	function search(){
		$("#searchForm").submit();
	}
	
</script>
</head>
<body>
<div class="mainright">
	<div class="content">
		<form id="searchForm" action="<s:url value='/gcp/workFile/workpaperList?workpaperTypeId=${param.workpaperTypeId}'/>" method="post">
		<p style="margin: 10px;">
			文件名称：<input type="text" name="workpaperName" value="${param.workpaperName}" class="xltext"/>
			报告人：<input type="text" name="reportUserName" value="${param.reportUserName}" class="xltext"/>
			报告日期：<input type="text" name="reportTime" value="${param.reportTime}" onclick="WdatePicker({dateFmt:'yyyy-MM-dd'})" class="ctime xltext"/>
			<input type="button" value="查&#12288;询" class="search" onclick="search();"/>
			<input type="button" value="新&#12288;增" class="search" onclick="add();"/>
		</p>
		</form>
		<c:forEach items="${workpaperList}" var="workpaper">
			<div class="cont_list" >
				<div class="left" style="width: 900px;" onclick="showDetail('${workpaper.recordFlow}')">文件名称：<span class="name">${workpaper.workpaperName}</span>报告人：<span class="zje" style="color: black;">${workpaper.reportUserName}</span>报告日期：<span class="zls" style="color: black;">${workpaper.reportTime}</span></div>
				<div class="right" style="width: 50px;float:right;padding-right: 25px;">
					<a style="cursor: pointer;" onclick="editWorkpaper('${workpaper.recordFlow}')"><img alt="修改" title="修改" src="<s:url value="/css/skin/Blue/images/modify.png"/>"/></a>&nbsp;
					<a style="cursor: pointer;" onclick="delWorkpaper('${workpaper.recordFlow}')"><img alt="删除" title="删除" src="<s:url value="/css/skin/Blue/images/del2.png"/>"></a>
				</div>
			</div>
			<div id="div_${workpaper.recordFlow}" style="display: none;">
				 <div class="i-trend" style="padding-top: 0px;">
			      <table class="i-trend-table" style="border: none;" cellpadding="0" cellspacing="0">
			      <tbody>
			        <tr>
			          <td>
			             <div class="selectTag" id="content_${workpaper.recordFlow}">
			             </div>
			          </td>
			        </tr>
			      </tbody>
			      </table>
 				 </div>
			</div>
			<div class="cont_spe"></div>
		</c:forEach>
		<c:if test="${empty workpaperList}">
		  <div class="cont_list" >
		  	<div class="left" style="text-align: center;">无记录！</div>
		  </div>
		</c:if>
	</div> 
</div>
</body>
</html>