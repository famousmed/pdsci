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
	<jsp:param name="jquery_validation" value="false"/>
	<jsp:param name="jquery_datePicker" value="false"/>
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
	    async: {    
            enable: true,    
               url:"<s:url value='/exam/manage/book/tree'/>",    
               autoParam:["id"]  
        },
        callback:{
        	onDblClick: loadStat,
        	beforeEditName: beforeEditName,
        	beforeRemove:beforeRemove,
        	beforeDrop:beforeDrop,
        	onDrop:onDrop
        },
        view: {
       		showLine: true,
       		addHoverDom: addHoverDom,
       		removeHoverDom: removeHoverDom
       	},
       	edit:{
       		enable: true,
			editNameSelectAll: true,
			showRemoveBtn: true,
			showRenameBtn: true,
			renameTitle:"修改",
			removeTitle:"删除",
			drag: {
			    isCopy: false,
			    isMove: true,
			    prev: true,
			    next: true,
			    inner: true
			}
       	}
	};
	
	function addHoverDom(treeId, treeNode) {
		var sObj = $("#" + treeNode.tId + "_span");
		if (treeNode.editNameFlag || $("#addBtn_"+treeNode.tId).length>0) return;
		var addStr = "<span class='button add' id='addBtn_" + treeNode.tId
			+ "' title='添加科目' onfocus='this.blur();'></span>";
		sObj.after(addStr);
		var btn = $("#addBtn_"+treeNode.tId);
		if (btn) btn.bind("click", function(){
			doAdd();
		});
	};
	function removeHoverDom(treeId, treeNode) {
		$("#addBtn_"+treeNode.tId).unbind().remove();
	};
	
	$(document).ready(function(){
		jboxStartLoading();
		loadTree();
	});
	
	function loadTree(){
		var bookNum = $("#bookNum").val();
		var url = "<s:url value='/exam/manage/book/tree'/>?bookNum="+bookNum;
		jboxGet(url , null , function(data){
			jboxStartLoading();
			$.fn.zTree.init($("#bookTree"), setting , data);
			var treeObj = $.fn.zTree.getZTreeObj("bookTree");
			var rootNode = treeObj.getNodeByParam("id", 0, null);
			treeObj.expandNode(rootNode, true, false, true);
			jboxEndLoading();
		} , null , false);
	}
	
	function loadStat(event, treeId, treeNode){
		jboxCloseMessager();
		var treeObj = $.fn.zTree.getZTreeObj("bookTree");
		var nodes = treeObj.getSelectedNodes();
		var id = "";
		if(nodes!=null&&nodes.length>0){
			id = nodes[0].id;
		}
		var url = "<s:url value='/exam/manage/book/stat'/>?bookFlow="+id;
		jboxLoad("rightDiv",url,true);
	}
	
	function refreshStat(){
		var treeObj = $.fn.zTree.getZTreeObj("bookTree");
		var nodes = treeObj.getSelectedNodes();
		var id = "";
		if(nodes!=null&&nodes.length>0){
			id = nodes[0].id;
		}
		var url = "<s:url value='/exam/manage/book/stat'/>?bookFlow="+id;
		jboxLoad("rightDiv",url,true);
	}
	
	function doAdd(){
		var treeObj = $.fn.zTree.getZTreeObj("bookTree");
		var nodes = treeObj.getSelectedNodes();
		var id = "";
		if(nodes!=null&&nodes.length>0){
			id = nodes[0].id;
		}else{
			jboxTip("请选择父节点！");
			return;
		}
		var url = "<s:url value='/exam/manage/book/add'/>?bookParentFlow="+id;
		jboxOpen(url,"新增科目", 900, 500);
	}
	
	function beforeEditName(treeId, treeNode){
		doMod(treeId, treeNode);
		return false;
	}

	function doMod(treeId, treeNode){
		if(treeNode==null){
			jboxTip("请选择节点！");
			return;
		}
		if(treeNode.id=='0'){
			jboxTip("该节点不能编辑");
			return;
		}
		var url = "<s:url value='/exam/manage/book/mod'/>?bookFlow="+treeNode.id+"&bookParentFlow="+treeNode.getParentNode().id;
		jboxOpen(url,"修改科目", 900, 500);
	}

	function doMod2(){
		var treeObj = $.fn.zTree.getZTreeObj("bookTree");
		var nodes = treeObj.getSelectedNodes();
		if(nodes!=null&&nodes.length>0){
			doMod(treeObj,nodes[0]);
		}else{
			jboxTip("请选择节点！");
			return;
		}
	}
	
	function beforeRemove(treeId, treeNode){
		doDel(treeId, treeNode);
		return false;
	}

	function doDel(treeId, treeNode){
		if(treeNode.id=='0'){
			jboxTip("该节点不能删除");
			return;
		}
		jboxConfirm("确认删除该 节点吗？，请慎重操作！",function () {
			var url = "<s:url value='/exam/manage/book/del'/>?bookFlow="+treeNode.id+"&bookParentFlow="+treeNode.getParentNode().id;
			jboxGet(url, null , function() {
				refreshParent();
				jboxClose();
			});
		});
	}

	function doDel2(){
		var treeObj = $.fn.zTree.getZTreeObj("bookTree");
		var nodes = treeObj.getSelectedNodes();
		if(nodes!=null&&nodes.length>0){
			doDel(treeObj,nodes[0]);
		}else{
			jboxTip("请选择节点！");
			return;
		}
	}
	
	function beforeDrop(treeId, treeNodes, targetNode, moveType, isCopy) {
		if(isCopy){
			jboxTip("该节点不能复制到此处");
			return false;
		}
		if(moveType=='prev' || moveType =='next'){
			jboxTip("该节点不能移动到此处");
			return false;
		}
		if(targetNode!=null&&(targetNode.pid!='-1' || targetNode.id=='0')){
			return true;
		}
		jboxTip("该节点不能移动到此处");
		return false;
	}
	
	function onDrop(event, treeId, nodes, targetNode, moveType, isCopy) {
		if(nodes!=null&&nodes.length>0){
			var id = nodes[0].id;
			var pid = targetNode.id;
			
			var url = "<s:url value='/exam/manage/book/move'/>?bookFlow="+id+"&bookParentFlow="+pid;
			jboxGet(url,null,function(){
				treeObj.reAsyncChildNodes(targetNode, "refresh");
			});	
		}
	}

	function doMerge(){
		var treeObj = $.fn.zTree.getZTreeObj("bookTree");
		var nodes = treeObj.getSelectedNodes();
		var param = "";
		if(nodes!=null&&nodes.length>1){
			for(var i=0;i<nodes.length;i++){
				param = param+"&bookFlow="+nodes[i].id;
			}
		}else{
			jboxTip("请选择1个以上的节点进行合并");
			return;
		}
		jboxConfirm("确认合并"+nodes.length+"节点吗？，请慎重操作！",function () {
			var url = "<s:url value='/exam/manage/book/merge'/>";
			jboxPost(url,param,function(){
				treeObj.reAsyncChildNodes(nodes[0].getParentNode(), "refresh");
			},null,false);		
		});
	}

	function doUnRel(){
		var treeObj = $.fn.zTree.getZTreeObj("bookTree");
		var nodes = treeObj.getSelectedNodes();
		var id = "";
		if(nodes!=null&&nodes.length>0){
			id = nodes[0].id;
			if(nodes[0].id=='0'){
				jboxTip("该节点不能解除关系");
				return;
			}
			var isParent = nodes[0].isParent;
			if(isParent==false){
				jboxTip("该节点不能解除关系");
				return;
			}
			jboxConfirm("确认解除该 "+nodes[0].name+" 的关系吗？，请慎重操作！",function () {
				var url = "<s:url value='/exam/manage/book/unRel'/>?bookFlow="+id;
				jboxGet(url,null,function(){
					treeObj.reAsyncChildNodes(nodes[0].getParentNode(), "refresh");
					window.setTimeout(function () {
						treeObj = $.fn.zTree.getZTreeObj("bookTree");
						var node = treeObj.getNodeByParam("id",id);
						treeObj.selectNode(node);
						loadStat();
					},1000);
				});		
			});
			
		}
	}
	
	function doOrder(){
		var treeObj = $.fn.zTree.getZTreeObj("bookTree");
		var nodes = treeObj.getSelectedNodes();
		var id = "";
		if(nodes!=null&&nodes.length>0){
			id = nodes[0].id;
		}
		var url = "<s:url value='/exam/manage/book/order'/>?bookParentFlow="+id;
		jboxLoad("rightDiv",url,true);
	}
	
	function refreshParent(){
		var treeObj = $.fn.zTree.getZTreeObj("bookTree");
		var nodes = treeObj.getSelectedNodes();
		if(nodes!=null&&nodes.length>0){
			id = nodes[0].id;
			var isParent = nodes[0].isParent;
			if(id!="0"){
				treeObj.reAsyncChildNodes(nodes[0].getParentNode(), "refresh");
			}else{
				treeObj.reAsyncChildNodes(nodes[0], "refresh");
			}
			window.setTimeout(function () {
				treeObj = $.fn.zTree.getZTreeObj("bookTree");
				var node = treeObj.getNodeByParam("id",id);
				treeObj.selectNode(node);
				//treeObj.expandNode(node, true, false, true);
				loadStat();
			},2000);
		}
	}
	$(function() { 
		$(".content").scroll(function() { 
		var top = $(document.body).scrollTop()+200; 
		var left= $(document.body).scrollLeft()+320; 
		$("#rightDiv").css({ left:left + "px", top: top + "px" }); 
		}); 
	}); 
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
		 		<table class="xllist">
					<tr>
						<th style="text-align: left;height: 35px;" colspan="2">&#12288;书目树结构
							&#12288;[<a href="javascript:doAdd();">新增</a>]
							&#12288;[<a href="javascript:doMod2();">修改</a>]
							&#12288;[<a href="javascript:doDel2();">删除</a>]
							&#12288;[<a href="javascript:doMerge();">合并</a>]
							&#12288;[<a href="javascript:doOrder();">排序</a>]
							&#12288;[<a href="javascript:doUnRel();">解除关系</a>]
						</th>
					</tr>
					<tr>
						<th style="text-align: left;" colspan="2">&#12288;书号：<input id="bookNum" name="bookNum" type="text" class="xltext">[<a href="javascript:loadTree()">查询</a>] </th>
					</tr>
			    	<tr style="height: 100%;" height="100%">
						<td width="400px" style="text-align: left;height: 100%;" height="100%" valign="top">
			    			<ul id="bookTree" class="ztree" style="background: white;overflow:hidden; height: 100%;"></ul>
			    		</td>
			    		<td>
						 	<div id="rightDiv" style="float:none;" valign="top">
							</div>
			    		</td>
					</tr>
				</table>
		 	</div>
	</div> 
</div>
</body>
</html>