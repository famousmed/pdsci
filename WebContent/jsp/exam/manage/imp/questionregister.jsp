<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/jsp/common/doctype.jsp" %>
<html>
<head>
<jsp:include page="/jsp/common/htmlhead.jsp">
	<jsp:param name="basic" value="true"/>
	<jsp:param name="jbox" value="true"/>
	<jsp:param name="jquery_form" value="false"/>
	<jsp:param name="jquery_ui_tooltip" value="false"/>
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
	<jsp:param name="jquery_placeholder" value="false"/>
	<jsp:param name="jquery_iealert" value="false"/>
	<jsp:param name="jquery_ztree" value="true"/>
</jsp:include>
<script type="text/javascript">
	var setting = {
		data: {
			simpleData: {
				enable: true,
				pIdKey:"pid",
				rootPId:"-1"
			}
		},
        callback:{
        	onClick: showRegisterInfo
        },
        view: {
       		showLine: true
       	}
	};
	
	function showRegisterInfo(e, treeId, treeNode){
		var bookFlow = treeNode.id;
		var url = "<s:url value='/exam/manage/imp/getregisterinfo'/>?bookFlow="+bookFlow;
		jboxGet(url , null , function(data){
			$('#rightDiv').html(data);
		} , null , false);
	}
	
	function refreshRegistInfo(){
		var treeObj = $.fn.zTree.getZTreeObj("bookTree");
		var nodes = treeObj.getSelectedNodes();
		var id = "";
		if(nodes!=null&&nodes.length>0){
			id = nodes[0].id;
		}else{
			jboxTip("请选择父节点！");
			return;
		}
		var url = "<s:url value='/exam/manage/imp/getregisterinfo'/>?bookFlow="+id;
		jboxGet(url , null , function(data){
			$('#rightDiv').html(data);
		} , null , false);
	}
	
	$(document).ready(function(){
		jboxStartLoading();
		loadTree();
	});
	
	function loadTree(){
		var bookNum = $("#bookNum").val();
		var url = "<s:url value='/exam/manage/imp/tree'/>?bookNum="+bookNum;
		jboxGet(url , null , function(data){
			jboxStartLoading();
			$.fn.zTree.init($("#bookTree"), setting , data);
			var treeObj = $.fn.zTree.getZTreeObj("bookTree");
			var rootNode = treeObj.getNodeByParam("id", 0, null);
			treeObj.expandNode(rootNode, true, false, true);
			jboxEndLoading();
		} , null , false);
	}
	
</script>
<style type="text/css">
.ztree li span.button.add {margin-left:2px; margin-right: -2px; background-position:-144px 0; vertical-align:top; *vertical-align:middle}
.ztree *{font-size: 14px; font-family: 微软雅黑;}
</style>
</head>
<body>
<div class="mainright">
	<div class="content">
		 <div class="title1 clearfix">
		     <input type="hidden" value="${param.currentPage}" id="currentPage"/>
		 		<table class="xllist">
					<tr>
						<th style="text-align: left;" colspan="2">&#12288;书号：<input id="bookNum" name="bookNum" type="text" class="xltext">[<a href="javascript:loadTree()">查询</a>] </th>
					</tr>
			    	<tr style="height: 100%;" height="100%">
						<td width="400px" style="text-align: left;height: 100%;" height="100%" valign="top">
			    			<ul id="bookTree" class="ztree" style="background: white;overflow:hidden; height: 100%;"></ul>
			    		</td>
			    		<td valign="top">
						 	<div id="rightDiv" style="float:none;text-align: left;">
						 	    
							</div>
			    		</td>
					</tr>
				</table>
		 	</div>
	</div> 
</div>
</body>
</html>