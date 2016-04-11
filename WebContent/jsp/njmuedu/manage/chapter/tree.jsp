<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>
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
	<jsp:param name="jquery_ztree" value="true"/>
</jsp:include>
<SCRIPT type="text/javascript">
		var setting = {
			view: {
				//鼠标移动到节点上时触发事件
				addHoverDom: addHoverDom,
				//鼠标离开节点时触发事件
				removeHoverDom: removeHoverDom,
				//是否允许同时选中多个节点
				selectedMulti: false,
				//双击节点时是否自动展开父节点标识
				dblClickExpand: dblClickExpand,
			},
			edit: {
				enable: true,
				showRemoveBtn: showRemoveBtn,
				showRenameBtn: showRenameBtn,
				renameTitle:"",
				removeTitle:""
			},
			data: {
				simpleData: {
					enable: true
				},
				
			},
			callback: {
				beforeEditName: beforeEditName,
				beforeRemove: beforeRemove,
			}
		};
		
		//节点编辑按钮的 click 事件
		function beforeEditName(treeId, treeNode) {
			var id = treeNode.id;
			var level=treeNode.level;
			var url = "<s:url value='/njmuedu/manage/course/editChapter'/>?chapterFlow="+id+"&level="+level+"&courseFlow=${param.courseFlow}";
			jboxLoad("contentDiv",url,true);
			$("#currExpandChapterFlow").val(id);
			return false;
		}
		
		
		function beforeRemove(treeId, treeNode) {
			jboxConfirm("确认删除 " + treeNode.name + " 吗？" , function(){
				var ids = "";
				if(treeNode.children){
					$.each(treeNode.children,function(i,obj){
						ids= ids + obj.id+",";
					});
				}
				ids = ids+treeNode.id;
				var requestData = {"listString":ids};
				var url = "<s:url value='/edu/manage/course/deleteJson'/>";
				jboxPost(url , requestData , function(resp){
					if(resp == "${GlobalConstant.DELETE_SUCCESSED}"){
						var zTree = $.fn.zTree.getZTreeObj("treeDemo");
						zTree.removeChildNodes(treeNode);//删除下级
						zTree.removeNode(treeNode);
						jboxTip('删除成功');
						if($("#currExpandChapterFlow").val()!="" && ids.indexOf($("#currExpandChapterFlow").val())>-1){
							$("#contentDiv").html("");
						}
					}
				} , null , false);
			});
			return false;
		}
		
		function showRemoveBtn(treeId, treeNode) {
			return treeNode.id!=0;
		}
		function showRenameBtn(treeId, treeNode) {
			return treeNode.id!=0;
		}
		
		//当鼠标移动到节点上时显示按钮
		function addHoverDom(treeId, treeNode) {
			var sObj = $("#" + treeNode.tId + "_span");
			//绑定添加按钮
			if ($("#addBtn_"+treeNode.tId).length>0) return;
			if(treeNode.level<2){
				var addStr = "<span class='button add' id='addBtn_" + treeNode.tId + "' title='' style='padding-left:0px' onfocus='this.blur();'></span>";
				sObj.after(addStr);
			}
			var id=treeNode.id;
			var level=treeNode.level;
			var addBtn = $("#addBtn_"+treeNode.tId);
			if (addBtn) addBtn.bind("click", function(){
				var url = "<s:url value='/njmuedu/manage/course/addChapter'/>?level="+level+"&courseFlow=${param.courseFlow}&chapterFlow="+id;
				jboxLoad("contentDiv",url,true);
			});
		};
		function removeHoverDom(treeId, treeNode) {
			$("#addBtn_"+treeNode.tId).unbind().remove();
		};
		function selectAll() {
			var zTree = $.fn.zTree.getZTreeObj("treeDemo");
			zTree.setting.edit.editNameSelectAll =  $("#selectAll").attr("checked");
		}
		
		function dblClickExpand(treeId, treeNode) {
			return treeNode.level > 0;
		}
	
		//加载章节zTree
		function getAllDataJson(){
			var url = "<s:url value='/njmuedu/manage/course/getAllDataJson'/>?courseFlow=${param.courseFlow}";
			jboxPostJson(url,null,function(data){
		    	if(data){
					zNodes = $.parseJSON(data);
					$.fn.zTree.init($("#treeDemo"), setting, zNodes);
				}
		    },null,false);
			$("#selectAll").bind("click", selectAll);
		}
		
		$(document).ready(function(){
			getAllDataJson();
		});
	</SCRIPT>
<style type="text/css">
	.ztree li span.button.add {margin-left:2px; margin-right: -1px; background-position:-144px 0; vertical-align:top; *vertical-align:middle}
	.ztree li span.button.switch.level0 {visibility:hidden; width:1px;}
	.ztree li ul.level0 {padding:0; background:none;}
	.line {border: none;}
	.ztree *{font-size: 13px; font-family: 微软雅黑;}
	#eleSortable { list-style-type: none; margin: 0; padding: 0; width: 60%; }
 	#eleSortable li { margin: 0 3px 3px 3px; padding: 0.4em; padding-left: 1.5em; font-size: 1.4em; height: 18px; }
 	#eleSortable li tr td span { position: absolute; margin-left: -1.3em; }
 	
 	#ueditor{
		width: 62%;
		margin: 30px 0px 30px 0px;
	}
</style>
</head>
<body>
<div id="main">
<div class="mainright">
<div class="content">
<div class="title1 clearfix">
<c:if test="${empty sysCfgMap['upload_base_url']}">请联系系统管理员先在系统配置中配置上传图片的路径</c:if>
<c:if test="${not empty sysCfgMap['upload_base_url']}">
<p style="margin: 0px;">
	&#12288;课程名称：<b>${course.courseName}</b>&#12288;&#12288;课程类别：<b>${course.courseTypeName}</b>&#12288;&#12288;总学时：<b>${course.coursePeriod}</b>
</p>
<table width="100%" cellspacing="0" cellpadding="0" style="margin-top: 10px;">
	<tr>
		<td valign="top" style="width:200px;">
			<table cellspacing="0" cellpadding="0" class="bs_tb" >
				<tr>
					<th class="bs_name">课程章节维护</th>
				</tr>
				<tbody>
					<tr>
						<td>
							<div>
								<ul id="treeDemo" class="ztree" style="width: 240px;height: 610px;margin: 0px;padding: 0px;"></ul>
							</div>	
						</td>
					</tr>			
				</tbody>													
			</table>
		</td>
		<td width="10px;">
		</td>
		<td valign="top">
		    <input type="hidden" id="currExpandChapterFlow"/>
			<div id="contentDiv"></div>
		</td>
	</tr>
</table>
</c:if>
</div>
</div>
</div>
</div>
</body>
</html>