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
	<jsp:param name="ueditor" value="true"/>
</jsp:include>
<SCRIPT type="text/javascript">
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
				renameTitle:"",
				removeTitle:""
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
		
		//节点编辑按钮的 click 事件
		function beforeEditName(treeId, treeNode) {
			className = (className === "dark" ? "":"dark");
			showLog("[ "+getTime()+" beforeEditName ]&nbsp;&nbsp;&nbsp;&nbsp; " + treeNode.name);
			var zTree = $.fn.zTree.getZTreeObj("treeDemo");
			zTree.selectNode(treeNode);
			var id = treeNode.id;
			var requestData = {"id":id};
			var url = "<s:url value='/edu/manage/course/getByIdJson'/>";
			jboxPost(url,requestData,function(data){
				if(data){
					var chapterFlow = data.chapter.chapterFlow;
					$("#chapterFlow").val(chapterFlow);
					$("#parentChapterFlow").val(data.chapter.parentChapterFlow);
					$("#chapterOrder").val(data.chapter.chapterOrder);
					$("#chapterName").val(data.chapter.chapterName);
					$("#chapterNo").val(data.chapter.chapterNo);
					$("#chapterFile").val(data.chapter.chapterFile);
					var chapterImg = data.chapter.chapterImg;
					isShowChapterImg(chapterImg, chapterFlow);
					
					var orgFlow = data.orgFlow;
					if(orgFlow != ""){
						$("#orgFlow").val(orgFlow);
						//清空原先教师！！
						$("select[name='teacherId'] option[value != '']").remove();
					    var dataObj = data.userList;
					    if(dataObj != null){
						    for(var i = 0; i < dataObj.length; i++){
						    	var uFlow = dataObj[i].userFlow;
						     	var uName = dataObj[i].userName;
						     	$option =$("<option></option>");
						     	$option.attr("value",uFlow);
						     	$option.text(uName);
						     	$("select[name=teacherId]").append($option);
						    }
					    }
						$("#teacherId").val(data.chapter.teacherId);
					}
					$("#chapterTime").val(data.chapter.chapterTime);
					var chapterIntro = data.chapter.chapterIntro;
					if(chapterIntro == null){
						UE.getEditor('ueditor').setContent("");
					}else{
						UE.getEditor('ueditor').setContent(chapterIntro);
					}
					$("#editTable").show();
					myTreeNode = treeNode;
					$("#operation").html("一修改章节");
					if(treeNode.level<2){
						var trs = $("#editTable tr:not(:eq(0),:last)").each(function(){
							$(this).css("display","none");
						});
					}else{
						var trs = $("#editTable tr:not(:eq(0)),:last").each(function(){
							$(this).show();
						});
					}
				}
			},null,false);
			return false;
		}
		
		//章节图片显示
		function isShowChapterImg(chapterImg, chapterFlow){
			if(chapterImg == null || chapterImg ==""){
				reuploadImg();
			}else{
				$("#chapterImg").val(chapterImg);
				$("#file").hide();
				$("#viewImgLink").attr("href","${sysCfgMap['upload_base_url']}"+chapterImg);
				$("#img").attr("src","${sysCfgMap['upload_base_url']}"+chapterImg);
				$("#delImgLink").attr("onclick","delImg('"+chapterFlow+"')");
				
				$("#viewImgLink").show();
				$("#delImgLink").show();
				$("#reuploadImgLink").show();
			}
		}
		
		//删除图片
		function delImg(chapterFlow){
			jboxConfirm("确认删除图片？", function(){
				var url = "<s:url value='/edu/manage/course/deleteChapterImg'/>?chapterFlow=" + chapterFlow;
				jboxPost(url,null,function(resp){
					if(resp=='${GlobalConstant.DELETE_SUCCESSED}'){
						reuploadImg();
						$("#chapterImg").val("");
						$("#file").val("");
						jboxTip("删除图片成功！");
					}
				},null,true);
			});
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
				var url = "<s:url value='/edu/manage/course/deleteJson'/>";
				jboxPost(url , requestData , function(resp){
					if(resp == "${GlobalConstant.DELETE_SUCCESSED}"){
						var zTree = $.fn.zTree.getZTreeObj("treeDemo");
						zTree.removeChildNodes(treeNode);//删除下级
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
		//添加下级添加下级
		function addHoverDom(treeId, treeNode) {
			var sObj = $("#" + treeNode.tId + "_span");
			if (treeNode.editNameFlag || $("#addBtn_"+treeNode.tId).length>0) return;
			if(treeNode.level<2){//不再添加子节点
				var addStr = "<span class='button add' id='addBtn_" + treeNode.tId + "' title='' style='padding-left:0px' onfocus='this.blur();'></span>";
			}
			sObj.after(addStr);
			myTreeNode = treeNode;
			var btn = $("#addBtn_"+treeNode.tId);
			if (btn) btn.bind("click", function(){
				$("#chapterFlow").val("");
				var parentChapterFlow = treeNode.id;
				if(parentChapterFlow == 0){
					parentChapterFlow = null//章的所属父章节为null，不为0
				}
				$("#parentChapterFlow").val(parentChapterFlow);
				$("#chapterOrder").val("");
				$("#chapterName").val("");
				$("#chapterNo").val("");
				$("#chapterFile").val("");
				$("#teacherId").val("");
				$("#chapterTime").val("");
				UE.getEditor('ueditor').setContent("");
				reuploadImg();
				$("#operation").html("一添加章节");
				$("#editTable").show();
				//alert(treeNode.level);
				if(treeNode.level<1){
					var trs = $("#editTable tr:not(:eq(0),:last)").each(function(){
						$(this).css("display","none");
					});
				}else{
					var trs = $("#editTable tr:not(:eq(0)),:last").each(function(){
						$(this).show();
					});
				}
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
		
		function submitEditForm(){
			if(false == $("#editForm").validationEngine("validate")){
				return false;
			}
			/* if($.trim($("#file").val())==""){
				jboxTip("请选择图片！");
				return false;
			} */
			var url = "<s:url value='/edu/manage/course/saveChapter'/>?courseFlow=${param.courseFlow}";
			jboxSubmit($('#editForm'), url, function(resp){
							var chapterFlow = $("#chapterFlow").val();
							if(resp != "${GlobalConstant.SAVE_FAIL}"){
								isShowChapterImg(resp, chapterFlow);
							}
							getAllDataJson();
							jboxTip("${GlobalConstant.SAVE_SUCCESSED}");
						},
						function(resp){
							jboxTip(resp);
						},false);
		}
		
		//重新上传图片
		function reuploadImg(){
			$("#file").show();
			$("#viewImgLink").hide();
			$("#delImgLink").hide();
			$("#reuploadImgLink").hide();
		}
		
		function searchTeacher(){
			var orgFlow = $("select[name='orgFlow']").val();
			if(orgFlow != ""){
				var url = "<s:url value='/edu/manage/course/searchTeacher'/>?orgFlow=" + orgFlow ;
				jboxPost(url,null,
						function(data){
							//清空原先教师！！
							$("select[name='teacherId'] option[value != '']").remove();
						    var dataObj = data;
						    if(dataObj != null){
							    for(var i = 0; i < dataObj.length; i++){
							    	var uFlow = dataObj[i].userFlow;
							     	var uName = dataObj[i].userName;
							     	$option =$("<option></option>");
							     	$option.attr("value",uFlow);
							     	$option.text(uName);
							     	$("select[name=teacherId]").append($option);
							    }
						    }
						},
						function(data){},false);
			}
		}
		
		//加载章节zTree
		function getAllDataJson(){
			var url = "<s:url value='/edu/manage/course/getAllDataJson'/>?courseFlow=${param.courseFlow}";
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
			//UEditor
			var ue = UE.getEditor('ueditor', {
			    autoHeight: false,
			    imagePath: '${sysCfgMap['upload_base_url']}/',
			    imageManagerPath: '${sysCfgMap['upload_base_url']}/',
			    filePath: '${sysCfgMap['upload_base_url']}/',
			    videoPath: '${sysCfgMap['upload_base_url']}/',
			    wordImagePath: '${sysCfgMap['upload_base_url']}/',
			    snapscreenPath: '${sysCfgMap['upload_base_url']}/',
			    catcherPath: '${sysCfgMap['upload_base_url']}/',
			    scrawlPath: '${sysCfgMap['upload_base_url']}/',
			    toolbars:[
			                [/* 'fullscreen' */, /*'source',*/ '|', 'undo', 'redo', '|','lineheight',
			                    'bold', 'italic', 'underline', 'fontborder', /* 'strikethrough', */ /*'superscript', 'subscript', 'removeformat', 'formatmatch', 'autotypeset', 'blockquote', 'pasteplain', '|', 'forecolor', 'backcolor', 'insertorderedlist', 'insertunorderedlist', 'selectall', 'cleardoc', '|',*/
			                    /* 'rowspacingtop', 'rowspacingbottom', 'lineheight', '|',
			                    'customstyle', 'paragraph', */ 'fontfamily', 'fontsize', '|',
			                    /* 'directionalityltr', 'directionalityrtl', 'indent', '|',*/ 
			                    'justifyleft', 'justifycenter', 'justifyright', 'justifyjustify', '|', 'touppercase', 'tolowercase', '|',
			                    /* 'link', 'unlink', 'anchor', '|', 'imagenone', 'imageleft', 'imageright', 'imagecenter', '|', */
			                    'insertimage', /* 'emotion','scrawl', 'insertvideo', 'music', 'attachment'*/, /*'map', 'gmap', 'insertframe','insertcode', 'webapp', 'pagebreak',*/ /*'template', 'background'*/, '|',
			                    /* 'horizontal', 'date', 'time', 'spechars', 'snapscreen',  'wordimage', '|',*/
			                    /*'inserttable', 'deletetable', 'insertparagraphbeforetable', 'insertrow', 'deleterow', 'insertcol', 'deletecol', 'mergecells', 'mergeright', 'mergedown', 'splittocells', 'splittorows', 'splittocols', 'charts', '|'*/,
			                    /*'print'*/,  'preview', /*'searchreplace', 'help' */, /*'drafts'*/'wordimage']
			            ]
			});
		});
		
		function checkTime(field, rules, i, options){
			var time = field.val();
			var regxString = /^[1-9][0-9]*:[0-9]{2}$/;
			if (time!="") {
				if(!regxString.test(time)){
					return "* 请输入指定格式的时间";
					}
			}
		}
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
			<table width="100%" cellspacing="0" cellpadding="0" class="bs_tb">
				<tr>
					<th colspan="4" class="bs_name">相关操作<span id="operation"></span></th>
				</tr>
				<tr>
					<td>
						<form id="editForm" style="position: relative;" enctype="multipart/form-data" method="post">
						<input type="hidden" id="chapterFlow" name="chapterFlow">
						<input type="hidden" id="parentChapterFlow" name="parentChapterFlow">
						<input type="hidden" id="chapterOrder" name="chapterOrder">
						<table class="basic" style="display: none; border-style: hidden;" id="editTable"> 
							<tr>
								<th width="14%" id="chapterType"><span style="color: red">*</span>&nbsp;名称：</th>
								<td style="text-align: left;"><input type="text" id="chapterName" name="chapterName" class="validate[required] xltext"></td>
								<th width="14%">序号：</th>
								<td style="text-align: left;"><input type="text" id="chapterNo" name="chapterNo" class="xltext"></td>
							</tr>
							<tr>
								<th>文件路径：</th>
								<td colspan="3" style="text-align: left;"><input type="text" id="chapterFile" name="chapterFile" class="xltext" style="width: 90%"/></td>
							</tr>
							<tr>
								<th>封面图片：</th>
								<td style="text-align: left;">
									<input id="file" type="file" name="file"/>
									<input type="hidden" id="chapterImg" name="chapterImg"/>
									
				                	<a id="viewImgLink" href="" target="_blank" title="点击查看大图" style="display: none;">
				                		<img id="img" src="" width="150px" height="150px"/>
				                	</a>&#12288;
				                	<a id="delImgLink" href="javascript:void(0)" onclick="delImg('${''}')" style="display: none;">[删除图片]</a>
				                	<a id="reuploadImgLink" href="javascript:void(0)" onclick="reuploadImg()" style="display: none;">[重新上传图片]</a>
								</td>
								<th><span style="color: red">*</span>&nbsp;时长：</th>
								<td style="text-align: left;"><input type="text" id="chapterTime" name="chapterTime" class="xltext validate[required,funcCall[checkTime]]"><span style="color: red">(格式 分钟数:秒数)</span></td>
							</tr>
							<tr>
								<th><span style="color: red">*</span>&nbsp;学校名称：</th>
					            <td style="text-align: left;">
						           <select name="orgFlow" id="orgFlow" class="xlselect validate[required]" onchange="searchTeacher();">
							       		<option value="">请选择</option>
							       		<c:forEach items="${orgList}" var="org">
							       			<option value="${org.orgFlow}" <c:if test="${param.orgFlow eq org.orgFlow}">selected="selected"</c:if> >${org.orgName}</option>
							       		</c:forEach>
							       	</select>
					        	</td>
								<th><span style="color: red">*</span>&nbsp;教师：</th>
								<td style="text-align: left;">
									<select class="xlselect validate[required]" name="teacherId" id="teacherId">
										<option value="">请选择</option>
										<c:forEach items="${teacherList}" var="teacher">
											<option value="${teacher.userFlow}" <c:if test="${param.teacherId eq teacher.userFlow}">selected="selected"</c:if> >${teacher.userName}</option>
										</c:forEach>
									</select>
								</td>
							</tr>
							<tr>
								<th>介绍：</th>
								<td colspan="3">
									<script id="ueditor" name="chapterIntro" type="text/plain" style="height:300px;"></script>
								</td>
							</tr>
							<tr>
								<td colspan="4">
									
									<input type="button" value="保&#12288;存" class="search" onclick="submitEditForm()">
									<!-- <input type="button" value="取&#12288;消" class="search" onclick="hideObj('#editTable')"> -->
								</td>
							</tr>
						</table>
						</form>
					</td>
				</tr>
			</table>
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