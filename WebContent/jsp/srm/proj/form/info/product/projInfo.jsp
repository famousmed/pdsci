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
		if(trs.length==0){
			jboxTip("请勾选要删除的！");
			return false;
		}
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
		
		function changeProjType(){
			var projType = $('#projType').val();
			showTable(projType);
		}

		function calculate(index,obj){
		   if($(obj).val() == null || $(obj).val() == undefined || $(obj).val() == '' || isNaN($(obj).val())){
			   $(obj).val(0);
		   }
		   $(obj).val(parseFloat(parseFloat($(obj).val()).toFixed(3)));
			//横向求和
			var sumAcross = 0;
			var sumEarly=$("#projFund_early");
			var sumAdd=$("#projFund_add");
			var sumAll=$("#projFund_sum");
			var tds = $(obj).parent().parent().find("td:not(:first)");
			
			$.each(tds , function(i , o){
				var val = $(o).children("input").val();
				if (val == null || val == undefined || val == '' || isNaN(val)){
					val = 0;
				}
				if(parseFloat(val)<0){
					return ;
				}
				sumAcross = parseFloat(sumAcross)+parseFloat(val);
			});
			if(index==1){
				sumEarly.val(parseFloat(sumAcross.toFixed(3)));
			}else if(index==2){
				sumAdd.val(parseFloat(sumAcross.toFixed(3)));
			}
		    
			var sumEarlyVal=$("#projFund_early").val();
			var sumAddVal=$("#projFund_add").val();
			if(sumEarlyVal == null || sumEarlyVal == undefined || sumEarlyVal == '' || isNaN(sumEarlyVal)){
				sumEarlyVal=0;
			}
			if(sumAddVal == null || sumAddVal == undefined || sumAddVal == '' || isNaN(sumAddVal)){
				sumAddVal=0;
			}
			sumAll.val(parseFloat(parseFloat(parseFloat(sumEarlyVal)+parseFloat(sumAddVal)).toFixed(3)));
		}
	</script>
</c:if>

<script type="text/javascript">
$(function(){
	showTable("${proj.projTypeId}");
	/* 查看禁用日期 */
	<c:if test="${param.view == GlobalConstant.FLAG_Y}">
		$(".ctime").removeAttr("onclick");
	</c:if>
	
});

function showTable(projType){
	if(projType=="szwsj.lczcbzzljs" || projType=="szwsj.qnkj" ){
		$("#zyfzr").show();
		$("#hzdw").show();
		$("#nrzb").show();
		$("#yqcg").show();
		$("#jf").show();
		$("#planTimeTr").show();
		$("#impTimeTr").hide();
	}else if(projType=="szwsj.yxxjs"){
		$("#zyfzr").hide();
		$("#hzdw").hide();
		$("#nrzb").hide();
		$("#yqcg").hide();
		$("#jf").hide();
		$("#planTimeTr").hide();
		$("#impTimeTr").show();
	}else{
		$("#zyfzr").hide();
		$("#hzdw").hide();
		$("#nrzb").hide();
		$("#yqcg").hide();
		$("#jf").hide();
		$("#planTimeTr").show();
		$("#impTimeTr").hide();
	}
}
</script>

<style type="text/css">
.readInputText{border:0; border-bottom:0px solid #ccc;text-align: center;}
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
		            <!-- 项目概况开始 -->
		            <div id="xmgk">
		                <table width="100%" cellspacing="0" cellpadding="0" class="basic">
						        <tr>
						            <th colspan="4" style="text-align: left;padding-left: 15px">基本信息</th>
						        </tr>
						       <tbody>
				                    <tr>
				                       <td width="20%" style="text-align: right;">
				                       		<c:choose>
												<c:when test="${sessionScope.projCateScope==projCategroyEnumXk.id}">学科名称：</c:when>
												<c:when test="${sessionScope.projCateScope==projCategroyEnumRc.id}">人才名称：</c:when>
												<c:otherwise>项目名称：</c:otherwise>
											</c:choose>
				                       </td>
				                       <td colspan="3" width="80%">
				                       	<input name="projName"  type="text" value="${projInfoMap.projName}" class="validate[required]  inputText validate[maxSize[200]]"  style="width: 450px; text-align: left;"/>
				                       </td>
				                     </tr>
				                     <tr>
				                    	<td width="20%" style="text-align: right;">
				                    		<c:choose>
												<c:when test="${sessionScope.projCateScope==projCategroyEnumXk.id}">学科类型：</c:when>
												<c:when test="${sessionScope.projCateScope==projCategroyEnumRc.id}">人才类型：</c:when>
												<c:otherwise>项目类型：</c:otherwise>
											</c:choose>
				                    	</td>
				                        <td width="30%" <c:if test="${sessionScope.projCateScope==projCategroyEnumRc.id}">colspan="3"</c:if>>
				                           <select name="projType" id="projType"  class="validate[required] inputText" onchange="changeProjType();">
				                           	<option value="">请选择</option>
				                           	<c:choose>
				                           		<c:when test="${sessionScope.projCateScope==projCategroyEnumKy.id}">
						                           	<c:forEach var="dictEnuProjType" items="${dictTypeEnumProjTypeList}">
						                           		<option value="${dictEnuProjType.dictId}" <c:if test='${proj.projTypeId==dictEnuProjType.dictId}'>selected="selected"</c:if>>${dictEnuProjType.dictName}</option>
						                           	</c:forEach>
				                           		</c:when>
				                           		<c:when test="${sessionScope.projCateScope==projCategroyEnumXk.id}">
						                           	<c:forEach var="dictEnuSubjType" items="${dictTypeEnumSubjTypeList}">
						                           		<option value="${dictEnuSubjType.dictId}" <c:if test='${proj.projTypeId==dictEnuSubjType.dictId}'>selected="selected"</c:if>>${dictEnuSubjType.dictName}</option>
						                           	</c:forEach>
				                           		</c:when>
				                           		<c:when test="${sessionScope.projCateScope==projCategroyEnumRc.id}">
						                           	<c:forEach var="dictEnuTalentType" items="${dictTypeEnumTalentTypeList}">
						                           		<option value="${dictEnuTalentType.dictId}" <c:if test='${proj.projTypeId==dictEnuTalentType.dictId}'>selected="selected"</c:if>>${dictEnuTalentType.dictName}</option>
						                           	</c:forEach>
				                           		</c:when>
				                   
				                           	</c:choose>
										   </select>
				                      </td>
				                      <c:if test="${sessionScope.projCateScope!=projCategroyEnumRc.id}">
					                      <td width="20%" style="text-align: right;">学科代码：</td>
					                      <td width="30%">
					                        <input type="hidden" id="selectProjId" name='subjectCode' value='${projInfoMap.subjectCode}'> 
											<input id="proSelect" name="subjectName" class="inputText" value="${projInfoMap.subjectName}" readonly="readonly" class="" style="width: 180px;text-align: left" onclick="showMenu(); return false;"/>
											<!-- <a id="menuBtn" href="javascript:void(0)" onclick="showMenu(); return false;">选择</a> -->
					                      </td>
				                      </c:if>
				                    </tr>
				                    <tr id="planTimeTr">
				                       <td width="20%" style="text-align: right;">计划开始时间：</td>
				                       <td width="30%">
				                       	<input name="projStartTime"  type="text" value="<c:if test='${empty projInfoMap.projStartTime}'>${applicationScope.sysCfgMap['srm_projInfo_start_time']}</c:if><c:if test='${! empty projInfoMap.projStartTime}'>${projInfoMap.projStartTime}</c:if>" class="inputText ctime" style="width: 160px;"  readonly="readonly" <c:if test="${empty applicationScope.sysCfgMap['srm_projInfo_start_time']}">onClick="WdatePicker({dateFmt:'yyyy-MM-dd'})"</c:if>/>
				                       </td>
				                       <td width="20%" style="text-align: right;">计划结束时间：</td>
				                       <td width="30%">
				                       	<input name="projEndTime"  type="text" value="<c:if test='${empty projInfoMap.projEndTime}'>${applicationScope.sysCfgMap['srm_projInfo_end_time']}</c:if><c:if test='${! empty projInfoMap.projEndTime}'>${projInfoMap.projEndTime}</c:if>" class="inputText ctime" style="width: 160px;"  readonly="readonly" <c:if test="${empty applicationScope.sysCfgMap['srm_projInfo_end_time']}">onClick="WdatePicker({dateFmt:'yyyy-MM-dd'})"</c:if>/>
				                       </td>
				                    </tr>
				                    <tr id="impTimeTr" style="display: none;">
				                       <td width="20%" style="text-align: right;">本单位引进时间：</td>
				                       <td colspan="3" width="80%">
				                       	<input name="impTime"  type="text" value="${projInfoMap.impTime}" class="inputText" style="width: 160px;"  readonly="readonly" onClick="WdatePicker({dateFmt:'yyyy-MM-dd'})" />
				                       </td>
				                    </tr>
						       </tbody>
						   </table>
		            </div>
		            <!-- 项目概况结束-->
		            <!-- 主要负责人开始 -->
		            <div id="zyfzr" style="margin-top: 10px; display: none;">
		                <table id="table1" width="100%" cellspacing="0" cellpadding="0" class="bs_tb">
					           <tr>
					               <th colspan="11" class="theader">主要负责人    
					               	<c:if test='${param.view != GlobalConstant.FLAG_Y}'><span style="float: right;padding-right: 10px"><a href="javascript:void(0)"><img title="新增" src="<s:url value="/css/skin/${skinPath}/images/add3.png" />" style="cursor: pointer;" onclick="addPeop('projMainPeop');"></img></a>&#12288;<a href="javascript:void(0)"><img title="删除"  style="cursor: pointer;" src="<s:url value='/css/skin/${skinPath}/images/del1.png'/>" onclick="delTr('projMainPeopTb')"></img></a></span></c:if>
					               </th>
					           </tr>
					           <tr>
					                <td width="5%">序号</td>
					                <td width="15%">姓名</td>
					                <td width="5%">性别</td>
					                <td width="20%">出生日期</td>
					                <td width="10%">学位</td>
					                <td width="10%">学历</td>
					                <td width="10%">职务</td>
					                <td width="10%">职称</td>
					                <td width="15%">电话</td>
					           </tr>
					           <tbody id="projMainPeopTb">
					           		<c:if test="${empty projInfoMap.projMainPeop and param.view != GlobalConstant.FLAG_Y}">
					           			<c:set var="currUser" value="${sessionScope.currUser}"></c:set>
					           			<tr>
					           			<!-- 序号 -->
										<td><input type="checkbox"/></td>
										<!-- 姓名 -->
										<td><input class="inputText validate[maxSize[50]]" name="projMainPeop_name" type="text" value="${currUser.userName}" style="width:85%;"/></td>
										<!-- 性别 -->
										<td>
											<select name="projMainPeop_sex"  class="inputText">
												<option value="">请选择</option>
											  <c:forEach items="${userSexEnumList }" var="sex">
											  		<c:if test="${sex.id != userSexEnumUnknown.id }">
											       <option value="${sex.id }" <c:if test='${currUser.sexId eq sex.id}'>selected="selected"</c:if>>${sex.name }</option>     
												</c:if>
											  </c:forEach>
											</select>
									    </td>
									    <!-- 出生日期 -->
										<td><input class="inputText" name="projMainPeop_birthday" type="text" value="${currUser.userBirthday}" style="width: 85%;" readonly="readonly" onClick="WdatePicker({dateFmt:'yyyy-MM-dd'})"/></td>
									    <!-- 学位 -->
										<td>
											<select name="projMainPeop_degree"  class="inputText">
												<option value="">请选择</option>
												<c:forEach items="${dictTypeEnumUserDegreeList}" var="degree">
		        									<option value="${degree.dictId}" <c:if test='${currUser.degreeId==degree.dictId}'>selected="selected"</c:if>>${degree.dictName}</option>
		        								</c:forEach>
											</select>
										</td>
										<!-- 学历 -->
										<td>
											<select class="inputText" name="projMainPeop_education" >
												<option value="">请选择</option>
												<c:forEach var="dict" items="${dictTypeEnumUserEducationList }">
					                   				<option value="${dict.dictId }" <c:if test="${currUser.educationId eq dict.dictId }">selected="selected"</c:if>>${dict.dictName }</option> 
					                   			</c:forEach>
											</select>
										</td>
										<!-- 职务 -->
										<td>
										    <select class="inputText" name="projMainPeop_post" >
													<option value="">请选择</option>
													<c:forEach items="${dictTypeEnumUserPostList}" var="post">
		        										<option value="${post.dictId}" <c:if test='${currUser.postId==post.dictId}'>selected="selected"</c:if>>${post.dictName}</option>
		        									</c:forEach>
											</select>
										</td>
										<!-- 电子邮件
										<td ><input name="projMainPeop_email" type="text" value="${currUser.userEmail}" style="width: 80%;"/></td>
										 -->
										 <!-- 职称 -->
										<td>
											<select class="inputText" name="projMainPeop_professional" >
													<option value="">请选择</option>
													<c:forEach items="${dictTypeEnumUserTitleList}" var="title">
		        										<option value="${title.dictId}" <c:if test='${currUser.titleId==title.dictId}'>selected="selected"</c:if>>${title.dictName}</option>
		        									</c:forEach>
											</select>
										</td>
										
										<!-- 电话 -->
										<td><input class="inputText validate[maxSize[11]]" name="projMainPeop_phone" type="text" value="${currUser.userPhone}" style="width: 80%;"/></td>
										<!-- 工作单位
										<td><input name="projMainPeop_workOrg" type="text" value="${currUser.orgName}" style="width: 80%;"/></td>
										 -->
									</tr>
					           		</c:if>
									<c:forEach var="mainPeop" items="${projInfoMap.projMainPeop}">
									<tr>
										<td><input type="checkbox"/></td>
										<td><input class="inputText validate[maxSize[50]]" name="projMainPeop_name" type="text" value="${mainPeop.objMap.projMainPeop_name}" style="width: 80%;"/></td>
										<td>
											<select class="inputText" name="projMainPeop_sex" >
												<option value="">请选择</option>
												<c:forEach items="${userSexEnumList}" var="sex">
													 <c:if test="${sex.id != userSexEnumUnknown.id}">
											       		<option value="${sex.id}" <c:if test='${mainPeop.objMap.projMainPeop_sex eq sex.id}'>selected="selected"</c:if>>${sex.name}</option>     
											  		</c:if>
											  </c:forEach>
											</select></td>
										<td><input class="inputText" name="projMainPeop_birthday" type="text" value="${mainPeop.objMap.projMainPeop_birthday}" style="width: 80%;"  readonly="readonly" onClick="WdatePicker({dateFmt:'yyyy-MM-dd'})"/></td>
										<td>
											<select class="inputText" name="projMainPeop_degree"  >
												<option value="">请选择</option>
												<c:forEach items="${dictTypeEnumUserDegreeList}" var="degree">
		        									<option value="${degree.dictId}" <c:if test='${mainPeop.objMap.projMainPeop_degree eq degree.dictId}'>selected="selected"</c:if>>${degree.dictName}</option>
		        								</c:forEach>
											</select>
										</td>
										<td>
											<select class="inputText" name="projMainPeop_education"  >
												<option value="">请选择</option>
												<c:forEach var="dict" items="${dictTypeEnumUserEducationList }">
					                   				<option value="${dict.dictId }" <c:if test="${mainPeop.objMap.projMainPeop_education eq dict.dictId }">selected="selected"</c:if>>${dict.dictName }</option> 
					                   			</c:forEach>
											</select>
										</td>
										
										
										<td>
											<select class="inputText" name="projMainPeop_post" >
													<option value="">请选择</option>
													<c:forEach items="${dictTypeEnumUserPostList}" var="post">
		        										<option value="${post.dictId}" <c:if test='${mainPeop.objMap.projMainPeop_post eq post.dictId}'>selected="selected"</c:if>>${post.dictName}</option>
		        									</c:forEach>
											</select>
										</td>
										<td>
											<select class="inputText" name="projMainPeop_professional" >
													<option value="">请选择</option>
													<c:forEach items="${dictTypeEnumUserTitleList}" var="title">
		        										<option value="${title.dictId}" <c:if test='${mainPeop.objMap.projMainPeop_professional eq title.dictId}'>selected="selected"</c:if>>${title.dictName}</option>
		        									</c:forEach>
											</select>
										</td>
										<td><input class="inputText validate[maxSize[11]]" name="projMainPeop_phone" type="text" value="${mainPeop.objMap.projMainPeop_phone}" style="width: 80%;"/></td>
										
									</tr>
									</c:forEach>
							</tbody>
					      </table>
		            </div>
		            <!-- 主要负责人结束-->
		            <!-- 合作单位开始 -->
		            <div id="hzdw" style="margin-top: 10px; display: none;">
		                <table width="100%" cellspacing="0" cellpadding="0" class="bs_tb">
					           <tr>
					                <th width="5%" class="theader">序号</th>
					                <th class="theader">合作单位名称
					                	<c:if test='${param.view != GlobalConstant.FLAG_Y}'><span style="float: right;padding-right: 10px"><a href="javascript:void(0)"><img title="新增" src="<s:url value="/css/skin/${skinPath}/images/add3.png" />" style="cursor: pointer;" onclick="addCoopOrg('projCoopOrg');"></img></a>&#12288;<a href="javascript:void(0)"><img title="删除"  style="cursor: pointer;" src="<s:url value='/css/skin/${skinPath}/images/del1.png'/>" onclick="delTr('projCoopOrgTb');"></img></a></span></c:if>
					                </th>
					           </tr>
					          
					           <tbody id="projCoopOrgTb">
					                <c:if test="${param.view != GlobalConstant.FLAG_Y}">
					                    <c:forEach var="coopOrg" items="${projInfoMap.projCooperationOrg}">
										<tr>
											<td><input type="checkbox"/></td>
											<td style="text-align: center;"><input class="inputText" name="projCooperationOrg_orgName" type="text" value="${coopOrg.objMap.projCooperationOrg_orgName}"   style="width: 60%;text-align: left"/></td>
										</tr>
									    </c:forEach>
					                </c:if>
					                
					                 <c:if test="${param.view == GlobalConstant.FLAG_Y}">
					                    <c:forEach var="coopOrg" items="${projInfoMap.projCooperationOrg}">
										<tr>
											<td><input type="checkbox"/></td>
											<td style="text-align: left;padding-left: 5px;">${coopOrg.objMap.projCooperationOrg_orgName}</td>
										</tr>
									    </c:forEach>
					                </c:if>
									
								</tbody>
					      </table>
		            </div>
		            <!-- 合作单位结束 -->
		            <!-- 内容指标开始 -->
		            <div id="nrzb" style="margin-top: 10px; display: none;">
		                <table  class="basic" style="width: 100%">
					           <tbody>
					           <tr>
					                <th width="100%" style="text-align: left;padding-left: 15px">项目概况</th>
					           </tr>
					           <tr>
					           	<td><textarea placeholder="此处填写项目情况综述" class="xltxtarea" style="height: 300px" name="projContentInfo">${projInfoMap.projContentInfo}</textarea></td>
					           </tr>
					           <tr>
					                <th width="100%" style="text-align: left;padding-left: 15px">主要研究内容</th>
					           </tr>
					           <tr>
					                <td><textarea placeholder="此处填写项目主要研究内容" class="xltxtarea" style="height: 300px" name="projContentContent">${projInfoMap.projContentContent}</textarea></td>
					           </tr>
					            <tr>
					                <th width="100%" style="text-align: left;padding-left: 15px">考核指标</th>
					           </tr>
					           <tr>
					                <td><textarea placeholder="此处填写项目主要考核指标" class="xltxtarea" style="height: 300px" name="projContentTarget">${projInfoMap.projContentTarget}</textarea></td>
					           </tr>
					           </tbody>
					      </table>
		            </div>
		            <!-- 内容指标结束 -->
		            <!-- 预期成果开始 -->
		            <div id="yqcg" style="margin-top: 10px; display: none;">
		                <table style="width: 100%" class="bs_tb">
					           <tr>
					               <th colspan="7" class="theader">预期成果</th>
					           </tr>
					           <tr>
					           	<c:forEach items="${achTypeEnumList}" var="achType">
					           		<c:if test='${achType.id != achTypeEnumAppraisal.id}'>
					                	<td>
					                    	<input type="checkbox" class="srmAch" name="ach" id="achType_${achType.id }" <c:forEach items='${projInfoMap.ach}' var='ach'><c:if test='${ach eq achType.id}'>checked="checked"</c:if></c:forEach> value="${achType.id }" /><label for="achType_${achType.id }">${achType.name }</label>
					                	</td>
					                </c:if>
                                </c:forEach>
					           </tr>
					          </table>
		            </div>
		            <!-- 预期成果结束 -->
		            <!-- 经费开始 -->
		            <div id="jf" style="margin-top: 10px; display: none;">
		                <table width="100%" cellspacing="0" cellpadding="0"  class="bs_tb">
					    <c:set var="projFundMap" value="${projInfoMap.projFund[0].objMap}"></c:set> 
					    	<tr>
					        	<th colspan="5" class="theader">项目经费</th>
					        </tr>
							  <tr>
							    <td style="height: 50px;text-align: right;">
							    	项目总投入(万元)&nbsp;&nbsp;<br/>
							    <input type="text" name="projFund_sum" id="projFund_sum" class="readInputText" readonly="readonly" style="text-align: center;"  value="${projFundMap.projFund_sum}" />=&nbsp;&nbsp;</td>
								<td>
									前期已投入(万元)<br/>
								<input type="text" name="projFund_early" id="projFund_early" class="readInputText" readonly="readonly" style="text-align: center;"  value="${projFundMap.projFund_early}" />+</td>
								<td>
									新增投入(万元)<br/>
								<input type="text" name="projFund_add" id="projFund_add" class="readInputText" readonly="readonly" style="text-align: center;"  value="${projFundMap.projFund_add}" /></td>
				                <td>
				                	</td>
				                <td></td>
							  </tr>
							  
							  <tr>
							    <td style="height: 50px;text-align: right;">前期已投入=&nbsp;&nbsp;</td>
											<td>
												单位自筹(万元)<br/>
											<input type="text" name="projFund_self" class="inputText" style="text-align: center;"  value="${projFundMap.projFund_self}" onchange="calculate(1,this);" />+</td>
											<td>
												政府拨款(万元)<br/>
											<input type="text" name="projFund_gov" class="inputText" style="text-align: center;"  value="${projFundMap.projFund_gov}" onchange="calculate(1,this);"/>+</td>
											<td>
												其他<br/>
											<input type="text" name="projFund_other2" class="inputText" style="text-align: center;"  value="${projFundMap.projFund_other2}" onchange="calculate(1,this);"/></td>
							    <td></td>
							  </tr>
							  <tr>
							    <td  style="height: 50px;text-align: right">新增投入=&nbsp;&nbsp;</td>
											<td>
												市财政拨款(万元)<br/>
											<input type="text" name="projFund_finance" class="inputText" style="text-align: center;" value="${projFundMap.projFund_finance}" onchange="calculate(2,this);"/>+ </td>
											<td>
												主管部门配套(万元)<br/>
											<input type="text" name="projFund_charge" class="inputText" style="text-align: center;" value="${projFundMap.projFund_charge}" onchange="calculate(2,this);"/>+ </td>
											<td>
												承担单位自筹(万元)<br/>
											<input type="text" name="projFund_selfOrg" class="inputText" style="text-align: center;"  value="${projFundMap.projFund_selfOrg}" onchange="calculate(2,this);"/>+ </td>
											<td>
												其他(万元)<br/>
											<input type="text" name="projFund_other" class="inputText"  style="text-align: center;" value="${projFundMap.projFund_other}" onchange="calculate(2,this);"/> </td>
							  </tr>
							  <tr><td style="height: 50px;text-align: right;">项目总投入中银行贷款（万元）&nbsp;&nbsp;<br/>
				                <input type="text" name="projFund_blank" class="inputText" style="text-align: center;"  value="${projFundMap.projFund_blank}" />&nbsp;&nbsp;</td>
				                <td></td><td></td><td></td><td></td>
				                </tr>
					      </table>
		            </div>
		            <!-- 经费结束 -->
				<c:if test="${param.view != GlobalConstant.FLAG_Y}">
				<div class="button" style="width:100%;">
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
	<ul id="treeDemo" class="ztree" style="margin-top:0; width:190px;"></ul>
</div>
<c:if test="${param.view != GlobalConstant.FLAG_Y}">
<div style="display: none;">
	<table>
		<tbody id="projMainPeopTb_model">
			<tr>
				<td><input type="checkbox"/></td>
				<td><input class="inputText" style="width:85%;" name="projMainPeop_name" type="text"/></td>
				<td>
					<select class="inputText" name="projMainPeop_sex">
			  			<option value="">请选择</option>
			  			<c:forEach items="${userSexEnumList}" var="sex">
			  				<c:if test="${ sex.id != userSexEnumUnknown.id}">
			   					<option value="${sex.id}">${sex.name}</option>
			  				</c:if>
			  			</c:forEach> 
					</select></td>
				<td><input class="inputText" style="width:85%;" name="projMainPeop_birthday" type="text"  onClick="WdatePicker({dateFmt:'yyyy-MM-dd'})" readonly="readonly"/></td>
				<td>
					<select class="inputText" name="projMainPeop_degree"  >
						<option value="">请选择</option>
						<c:forEach items="${dictTypeEnumUserDegreeList}" var="degree">
							<option value="${degree.dictId}">${degree.dictName}</option>
						</c:forEach>
					</select></td>
				<td>
					<select class="inputText" name="projMainPeop_education"  >
						<option value="">请选择</option>
						<c:forEach var="dict" items="${dictTypeEnumUserEducationList }">
							<option value="${dict.dictId }">${dict.dictName }</option> 
						</c:forEach>
					</select></td>
				<td>
					<select class="inputText" name="projMainPeop_post"  >  
			    		<option value="">请选择</option>
			    		<c:forEach items="${dictTypeEnumUserPostList}" var="post">
			   				<option value="${post.dictId}">${post.dictName}</option>
		        		</c:forEach>
			 		</select> 
				</td>
				<td>
					<select class="inputText" name="projMainPeop_professional" >
						<option value="">请选择</option>
						<c:forEach items="${dictTypeEnumUserTitleList}" var="title">
							<option value="${title.dictId}">${title.dictName}</option>
						</c:forEach>
					</select></td>
				<td><input class="inputText" style="width:85%;" name="projMainPeop_phone" type="text"/></td>
			</tr>
		</tbody>
	</table>
</div>
</c:if>
</body>
</html>