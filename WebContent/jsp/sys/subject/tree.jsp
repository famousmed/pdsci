<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>
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
	<jsp:param name="jquery_ztree" value="true"/>
</jsp:include>

<SCRIPT type="text/javascript">
		<!--
		var setting = {
			view: {
				addHoverDom: addHoverDom,
				removeHoverDom: removeHoverDom,
				selectedMulti: false,
				dblClickExpand: dblClickExpand,
				showIcon: false,
				showTitle:true
				
			},
			edit: {
				enable: true,
				editNameSelectAll: true,
				showRemoveBtn: showRemoveBtn,
				showRenameBtn: showRenameBtn,
				renameTitle:"修改",
				removeTitle:"删除"
			},
			data: {
				simpleData: {
					enable: true
				},
				key: {
					title:"t"
				}
			},
			callback: {
				beforeDrag: beforeDrag,
				beforeEditName: beforeEditName,
				beforeRemove: beforeRemove,
				beforeRename: beforeRename,
				onRemove: onRemove,
				onRename: onRename
			}
		};

		
		var log, className = "dark";
		var myTreeNode;
		function beforeDrag(treeId, treeNodes) {
			return false;
		}
		function beforeEditName(treeId, treeNode) {
			className = (className === "dark" ? "":"dark");
			showLog("[ "+getTime()+" beforeEditName ]&nbsp;&nbsp;&nbsp;&nbsp; " + treeNode.name);
			var zTree = $.fn.zTree.getZTreeObj("treeDemo");
			zTree.selectNode(treeNode);
			var id = treeNode.id;
			//alert(id);
			var requestData = {"id":id};
			var url = "<s:url value='/sys/subject/getByIdJson'/>";
			jboxPost(url,requestData,function(data){
				if(data){
					$("#edit_subj_id").val(data.subjId);
					$("#edit_subj_id_base").val(data.subjId);
					$("#edit_subj_name").val(data.subjName);
					$("#edit_ordinal").val(data.ordinal);
					$("#edit_subj_flow").val(data.subjFlow);
					myTreeNode = treeNode;
					$("#addTable").hide();
					$("#operation").html("一修改学科代码");
					$("#editTable").show();
				}
			},null,false);
			return false;
		}
		function beforeRemove(treeId, treeNode) {
			className = (className === "dark" ? "":"dark");
			showLog("[ "+getTime()+" beforeRemove ]&nbsp;&nbsp;&nbsp;&nbsp; " + treeNode.name);
			var zTree = $.fn.zTree.getZTreeObj("treeDemo");
			zTree.selectNode(treeNode);
			jboxConfirm("确认删除 " + treeNode.name + " 吗？" , function(){
				var ids = "";
				if(treeNode.children){
					$.each(treeNode.children,function(i,obj){
						ids= ids + obj.id+",";
					});
				}
				ids = ids+treeNode.id;
				var requestData = {"listString":ids};
				var url = "${ctxPath}/sys/subject/deleteJson";
				jboxPost(url , requestData , function(resp){
					if(resp>0){
						var zTree = $.fn.zTree.getZTreeObj("treeDemo");
						zTree.removeChildNodes(treeNode);
						zTree.removeNode(treeNode);
						jboxTip('删除成功');
					}
				} , null , false);
			});
			return false;
		}
		function onRemove(e, treeId, treeNode) {
			showLog("[ "+getTime()+" onRemove ]&nbsp;&nbsp;&nbsp;&nbsp; " + treeNode.name);
		}
		function beforeRename(treeId, treeNode, newName, isCancel) {
			className = (className === "dark" ? "":"dark");
			showLog((isCancel ? "<span style='color:red'>":"") + "[ "+getTime()+" beforeRename ]&nbsp;&nbsp;&nbsp;&nbsp; " + treeNode.name + (isCancel ? "</span>":""));
			if (newName.length == 0) {
				alert("节点名称不能为空.");
				var zTree = $.fn.zTree.getZTreeObj("treeDemo");
				setTimeout(function(){zTree.editName(treeNode)}, 10);
				return false;
			}
			return true;
		}
		function onRename(e, treeId, treeNode, isCancel) {
			showLog((isCancel ? "<span style='color:red'>":"") + "[ "+getTime()+" onRename ]&nbsp;&nbsp;&nbsp;&nbsp; " + treeNode.name + (isCancel ? "</span>":""));
		}
		function showRemoveBtn(treeId, treeNode) {
			return treeNode.id!=0;
		}
		function showRenameBtn(treeId, treeNode) {
			return treeNode.id!=0;
		}
		function showLog(str) {
			if (!log) log = $("#log");
			log.append("<li class='"+className+"'>"+str+"</li>");
			if(log.children("li").length > 8) {
				log.get(0).removeChild(log.children("li")[0]);
			}
		}
		function getTime() {
			var now= new Date(),
			h=now.getHours(),
			m=now.getMinutes(),
			s=now.getSeconds(),
			ms=now.getMilliseconds();
			return (h+":"+m+":"+s+ " " +ms);
		}

		function addHoverDom(treeId, treeNode) {
			var sObj = $("#" + treeNode.tId + "_span");
			if (treeNode.editNameFlag || $("#addBtn_"+treeNode.tId).length>0) return;
			var addStr = "<span class='button add' id='addBtn_" + treeNode.tId
				+ "' title='添加下级' style='padding-left:0px' onfocus='this.blur();'></span>";
			sObj.after(addStr);
			
			myTreeNode = treeNode;
			var btn = $("#addBtn_"+treeNode.tId);
			if (btn) btn.bind("click", function(){
				var subjNameObj = $("#subj_name");
				var subjIdObj = $("#subj_id");
				var ordinalObj = $("#ordinal");
				var parSubjIdObj = $("#par_subj_id");
				var addTable = $("#addTable");
				subjIdObj.val("");
				subjNameObj.val("");
				ordinalObj.val("");
				parSubjIdObj.val(treeNode.id);
				$("#operation").html("一添加学科代码");
				$("#editTable").hide();
				addTable.show();
				return false;
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
		function hideObj(objName){
			$(objName).hide();
			$("#operation").html("");
		}
		function submitAddForm(){
			var addForm = $("#addForm");
			if(addForm.validationEngine("validate")){
				var subjName = $.trim($("#subj_name").val());
				var subjId =  $.trim($("#subj_id").val());
				var ordinal =  $.trim($("#ordinal").val());
				var parSubjId = $("#par_subj_id").val();
				//alert(parSubjId);
				var requestData ={"subjName":subjName,"subjId":subjId,"parSubjId":parSubjId,"ordinal":ordinal};
				var url = "${ctxPath}/sys/subject/addJson";
				jboxPost(url , requestData , function(resp){
					if(resp==1){
						var zTree = $.fn.zTree.getZTreeObj("treeDemo");
						zTree.addNodes(myTreeNode, {id:subjId, pId:parSubjId, name:subjName});
						jboxTip('添加成功');
						hideObj('#addTable');
					}
				} , null , false);
			}
		}
		function submitEditForm(){
			var editForm = $("#editForm");
			if(editForm.validationEngine("validate")){
				var subjName = $.trim($("#edit_subj_name").val());
				var subjId =  $.trim($("#edit_subj_id").val());
				var ordinal =  $.trim($("#edit_ordinal").val());
				var subjFlow = $("#edit_subj_flow").val();
				var requestData ={"subjName":subjName,"subjId":subjId,"subjFlow":subjFlow,"ordinal":ordinal};
				
				var url = "${ctxPath}/sys/subject/updateJson";
				jboxPost(url , requestData , function(resp){
					if(resp==1){
						var zTree = $.fn.zTree.getZTreeObj("treeDemo");
						zTree.editName(myTreeNode);
						zTree.cancelEditName(subjName);
						jboxTip('修改成功');
						hideObj('#editTable');
					}
				} , null , false);
			}
		}
		function checkSubjId(field, rules, i, options){
			var subj_id = field.val();
			var requestData = {"subjId":subj_id};
			var result = "";
			var url ="<s:url value='/sys/subject/checkSubjIdJson'/>";
			jboxPost(url,requestData,function(data){
				if(data==1){
					result = "* 该学科代码已存在";
				}
			},null,false);
			if(result!=""){
				return result;
			}
		}
		function checkEditSubjId(field, rules, i, options){
			var subj_id = field.val();
			var subj_id_base = $("#edit_subj_id_base").val();
			var requestData = {"subjId":subj_id};
			var result = "";
			if(subj_id!=subj_id_base){
				var url = "<s:url value='/sys/subject/checkSubjIdJson'/>";
				jboxPost(url,requestData,function(data){
					if(data==1){
						result = "* 该学科代码已存在";
					}
				},null,false);
			}
			if(result!=""){
				return result;
			}
		}
		$(document).ready(function(){
			var url = "<s:url value='/sys/subject/getAllDataJson'/>"
				jboxPostJson(url,null,function(data){
			    	if(data){
						zNodes = $.parseJSON(data);
						$.fn.zTree.init($("#treeDemo"), setting, zNodes);
					}
			    },null,false);
			$("#selectAll").bind("click", selectAll);
		});
		//-->
	</SCRIPT>
<style type="text/css">
	.ztree li span.button.add {margin-left:2px; margin-right: -1px; background-position:-144px 0; vertical-align:top; *vertical-align:middle}
	.ztree li span.button.switch.level0 {visibility:hidden; width:1px;}
	.ztree li ul.level0 {padding:0; background:none;}
	.line {border: none;}
	.ztree { padding: 10px 0 0 20px; }
	.ztree *{font-size: 13px; font-family: 微软雅黑;}
	#eleSortable { list-style-type: none; margin: 0; padding: 0; width: 60%; }
 	#eleSortable li { margin: 0 3px 3px 3px; padding: 0.4em; padding-left: 1.5em; font-size: 1.4em; height: 18px; }
 	#eleSortable li tr td span { position: absolute; margin-left: -1.3em; }
</style>
</head>
<body>
	<div id="main">
		<div class="mainright">
			<div class="content">
				<div class="title1 clearfix">
					<table width="100%" cellspacing="0" cellpadding="0">
						<tr>
							<td valign="top" width="450">
								<table width="450" cellspacing="0" cellpadding="0" class="bs_tb" >
									<tr>
										<th class="bs_name">学科代码维护</th>
									</tr>
									<tbody>
										<tr>
											<td>
												<div>
													<ul id="treeDemo" class="ztree"></ul>
												</div>	
											</td>
										</tr>			
									</tbody>													
								</table>
							</td>
							<td width="10">
							</td>
							<td valign="top">
								<table width="450" cellspacing="0"
									cellpadding="0" class="bs_tb">
									<tr>
										<th colspan="11" class="bs_name">相关操作<span id="operation"></span></th>
									</tr>
									<tr>
										<td>
											<form id="addForm">
											<input type="hidden" id="par_subj_id">
											<table class="basic" style="display: none;" id="addTable"> 
													<tr>
														<th>学科代码：</th>
														<td><input type="text" id="subj_id" class="validate[required,funcCall[checkSubjId]] text-input xltext"></td>
													</tr>
													<tr>
														<th>学科名称：</th>
														<td><input type="text" id="subj_name" class="validate[required] text-input xltext"></td>
													</tr>
													<tr>
														<th>排&#12288;&#12288;序：</th>
														<td><input type="text" id="ordinal" class="validate[required,custom[integer],min[1]] xltext"></td>
													</tr>
													<tr>
														<td colspan="2"><input type="button" class="search" value="提 交" onclick="submitAddForm()">&#12288;&#12288;<input type="button" value="取 消" class="search"  onclick="hideObj('#addTable')"></td>
													</tr>
											</table>
											</form>
											<form id="editForm">
											<input type="hidden" id="edit_subj_flow">
											<input type="hidden" id="edit_subj_id_base">
											<table class="basic" style="display: none;" id="editTable"> 
													<tr>
														<th>学科代码：</th>
														<td><input type="text" id="edit_subj_id" class="validate[required,funcCall[checkEditSubjId]] text-input xltext"></td>
													</tr>
													<tr>
														<th>学科名称：</th>
														<td><input type="text" id="edit_subj_name" class="validate[required] text-input xltext"></td>
													</tr>
													<tr>
														<th>排&#12288;&#12288;序：</th>
														<td><input type="text" id="edit_ordinal" class="validate[required,custom[integer],min[1]] xltext"></td>
													</tr>
													<tr>
														<td colspan="2"><input type="button" class="search" value="提 交" onclick="submitEditForm()">&#12288;&#12288;<input type="button" value="取 消" class="search"  onclick="hideObj('#editTable')"></td>
													</tr>
											</table>
											</form>
										</td>
									</tr>
								</table>
							</td>
						</tr>
					</table>
				</div>
			</div>
		</div>
	</div>
</body>
</html>