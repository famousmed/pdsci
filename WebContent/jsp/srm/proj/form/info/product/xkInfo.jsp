 <%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>
<%@include file="/jsp/common/doctype.jsp" %>
<html>
<head>
<jsp:include page="/jsp/common/htmlhead.jsp">
	<jsp:param name="basic" value="true"/>
	<jsp:param name="jbox" value="true"/>
	<jsp:param name="jquery_ui_tooltip" value="true"/>
	<jsp:param name="jquery_validation" value="true"/>
	<jsp:param name="jquery_datePicker" value="true"/>
	<jsp:param name="jquery_ztree" value="true"/>
</jsp:include>

<c:if test="${param.view != GlobalConstant.FLAG_Y}">
<script type="text/javascript">
	function addPeop(tb){
		var html = $('#'+tb+'Tb'+"_model").html();
		$('#'+tb+'Tb').append(html);
	}
	
	function addCoopOrg(tb){
		var html ='<tr>'+
			'<td><input type="checkbox"/></td>'+
			'<td ><input  class="inputText"  name="projCooperationOrg_orgName" type="text" style="width:60%;"/></td>'+
		    '</tr>';
		$('#'+tb+'Tb').append(html);
	}
	
	
	function delFile(fileFlow) {
		var url = "<s:url value='/pub/file/delete?fileFlow='/>" + fileFlow;
		jboxConfirm(url , null , function(resp){
			var projFlow = $('#projFlow').val();
			jboxTip(resp);
			$('#file').load("<s:url value='/srm/proj/mine/getFileList?projFlow='/>"+projFlow);
		} , null , false);
	}
	
	function delTr(tb){
		var trs = $('#'+tb).find(':checkbox:checked');
		jboxConfirm("确认删除？" , function(){
			$.each(trs , function(i , n){
				$(n).parent('td').parent("tr").remove();
				
			});
			
		});
	}
	
	function back() {
		history.back();
	}

		var setting = {
			view: {
				dblClickExpand: false,
				showIcon: false,
				showTitle:false,
				selectedMulti:false
			},
			data: {
				simpleData: {
					enable: true
				}
			},
			callback: {
				beforeClick: beforeClick,
				onClick: onClick
			}
		};

		function beforeClick(treeId, treeNode) {
			var check = (treeNode.id!=0);
			if (!check) jboxTip('不能选择根节点');
			return check;
		}
		
		function onClick(e, treeId, treeNode) {
			var zTree = $.fn.zTree.getZTreeObj("treeDemo"),
			nodes = zTree.getSelectedNodes(),
			v = "";
			id = "";
			nodes.sort(function compare(a,b){return a.id-b.id;});
			for (var i=0, l=nodes.length; i<l; i++) {
				v += nodes[i].name + ",";
				id += nodes[i].id + ",";
			}
			if (v.length > 0 ) v = v.substring(0, v.length-1);
			if (id.length > 0 ) id = id.substring(0, id.length-1);
			var cityObj = $("#proSelect");
			$("#selectProjId").val(id);
			cityObj.attr("value", v);
		}

		function showMenu() {
			var cityObj = $("#proSelect");
			var cityOffset = $("#proSelect").offset();
			$("#menuContent").css({left:cityOffset.left + "px", top:cityOffset.top + cityObj.outerHeight() + "px"}).slideDown("fast");

			$("body").bind("mousedown", onBodyDown);
		}
		function hideMenu() {
			$("#menuContent").fadeOut("fast");
			$("body").unbind("mousedown", onBodyDown);
		}
		function onBodyDown(event) {
			if (!(event.target.id == "menuBtn" || event.target.id == "menuContent" || $(event.target).parents("#menuContent").length>0)) {
				hideMenu();
			}
		}
      
		$(document).ready(function(){
			var url = "<s:url value='/sys/subject/getAllDataJson'/>";
			jboxPostJson(url,null,function(data){
		    	if(data){
					zNodes = $.parseJSON(data);
					$.fn.zTree.init($("#treeDemo"), setting, zNodes);
				}
		    },null,false);
		});
		
		function addFile(tb){
			var html = '<tr>'+
				'<td width="50px"><input type="checkbox"/></td>'+
				'<td  style="height: 30px;text-align: left">&#12288;<input type="file" name="file"/></td>'+
			'</tr>';
			$('#'+tb).append(html);
		}
	</script>
</c:if>

<c:if test="${param.view == GlobalConstant.FLAG_Y}">
<script type="text/javascript">
$(function(){
	$('input').attr("readonly","readonly");
	$("select").attr("disabled", "disabled");
	$(".ctime").removeAttr("onclick");
});
</script>
</c:if>
<style type="text/css">
.line {border: none;}
#table1 th{background: #fff;}
#table2 th{background: #fff;text-align: center;padding: 0px;margin: 0px;}
#table2 td{text-align: center;padding: 0px;margin: 0px;}
</style>
</head>
<body>
<div id="main" >
	<div class="mainright">
    	<div class="content"  >
        	<form action="<s:url value='/srm/proj/mine/saveProjInfo'/>" method="post"
			id="projForm" enctype="multipart/form-data" style="position: relative;">
				<input type="hidden" id="projFlow" name="projFlow" value="${proj.projFlow}"/>
				<input type="hidden" id="pageName" name="pageName" value="step1"/>
		        <div class="title1 clearfix">
		            <table width="100%" cellspacing="0" cellpadding="0">
		            	<!-- 学科概况开始 -->
						<tr>
						  <td> 
						    <table width="100%" cellspacing="0" cellpadding="0" class="basic">
						        <tr>
						            <th colspan="4" style="text-align: left;padding-left: 15px">基本信息</th>
						        </tr>
						       <tbody>
				                    <tr>
				                       <td width="20%" style="text-align: right;">学科名称：</td>
				                       <td colspan="3" width="80%">
				                       	<input name="projName" s type="text" value="${projInfoMap.projName}" class="validate[required]  inputText"  style="width: 450px; text-align: left;"/>
				                       </td>
				                     </tr>
				                     <tr>
				                    	<td width="20%" style="text-align: right;">学科类型：</td>
				                       <td colspan="3" width="80%">
				                           <select name="projType"  class="validate[required] inputText" >
				                           	<option value="">请选择</option>
				                           	<c:choose>
				                           		<c:when test="${sessionScope.projCateScope==projCategroyEnumKy.id}">
						                           	<c:forEach var="dictEnuProjType" items="${dictTypeEnumProjTypeList}">
						                           		<option value="${dictEnuProjType.dictId}" <c:if test='${projInfoMap.projType==dictEnuProjType.dictId}'>selected="selected"</c:if>>${dictEnuProjType.dictName}</option>
						                           	</c:forEach>
				                           		</c:when>
				                           		<c:when test="${sessionScope.projCateScope==projCategroyEnumXk.id}">
						                           	<c:forEach var="dictEnuSubjType" items="${dictTypeEnumSubjTypeList}">
						                           		<option value="${dictEnuSubjType.dictId}" <c:if test='${projInfoMap.projType==dictEnuSubjType.dictId}'>selected="selected"</c:if>>${dictEnuSubjType.dictName}</option>
						                           	</c:forEach>
				                           		</c:when>
				                           		<c:when test="${sessionScope.projCateScope==projCategroyEnumRc.id}">
						                           	<c:forEach var="dictEnuTalentType" items="${dictTypeEnumTalentTypeList}">
						                           		<option value="${dictEnuTalentType.dictId}" <c:if test='${projInfoMap.projType==dictEnuTalentType.dictId}'>selected="selected"</c:if>>${dictEnuTalentType.dictName}</option>
						                           	</c:forEach>
				                           		</c:when>
				                           		<c:otherwise>
				                           			<option value="">错误了！！！</option>
				                           		</c:otherwise>
				                           	</c:choose>
										   </select>
				                      </td>
				                    </tr>
				                    <tr>
				                       <td width="20%" style="text-align: right;">学科代码：</td>
				                       <td colspan="3" width="80%">
				                        <input type="hidden" id="selectProjId" name='subjectCode' value='${projInfoMap.subjectCode}'> 
										<input id="proSelect" name="subjectName" class="inputText" value="${projInfoMap.subjectName}" readonly="readonly" class="" style="width: 180px;text-align: left;" onclick="showMenu(); return false;"/>
										<!-- <a id="menuBtn" href="javascript:void(0)" onclick="showMenu(); return false;">选择</a> -->
				                       </td>
				                    </tr>
						       </tbody>
						   </table>
						  </td>
						</tr>
						<!-- 学科概况结束 -->
				</table>
				<c:if test="${param.view != GlobalConstant.FLAG_Y}">
				<div class="button" style="width:1000px;">
		             <input class="search" type="submit" value="保存"/>
		             <input class="close" type="button" value="返回" onclick="back();"/>
		     	</div>
		     	</c:if>
		      </div>
	  		</form>
    </div>  	
  </div>   
</div>
<div id="menuContent" class="menuContent" style="display:none; position:absolute;">
	<ul id="treeDemo" class="ztree" style="margin-top:0; width:159px;"></ul>
</div>
</body>
</html>