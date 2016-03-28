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
		<jsp:param name="jquery_ui_sortable" value="true"/>
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
</head>

<script type="text/javascript">
	//标签高亮
	function selTag1(tag,type){
		$(".selectTag").removeClass("selectTag");
		$(tag).addClass("selectTag");
		$("#patientVisitForm table.basic,.aeList").hide();
		$("."+type).show();
	}
	
	//返回
	function infoBack(){
		window.location.href = "<s:url value='/gcp/researcher/visit'/>?beforePage=${param.beforePage}&patientFlow=${param.patientFlow}";
	}
	
	function editRecipe(){
		jboxOpen("<s:url value='/gcp/researcher/editRecipe'/>?patientFlow=${patient.patientFlow}&visitFlow=${param.visitFlow}","编辑处方",600,400);
	}
	
	function editVisitInfo(infoType){
		var title = {
				"labExam":"理化检查",
				"advice":"编辑医嘱",
				"doctorExplain":"医生说明",
		};
		jboxOpen("<s:url value='/gcp/researcher/editVisitInfo'/>?recordFlow=${patientVisit.recordFlow}&infoType="+infoType,title[infoType],500,300);
	}
	
	$(function(){
		loadAeList();
		if("${param.infoType}"!=""){
			if("${param.infoType}"=="advice"){
				$("#doctorExplain").click();
			}else{
				$("#${param.infoType}").click();
			}
		}
	});
	
	function refresh(infoType){
		location.href = "<s:url value='/gcp/researcher/patientVisitInfo'/>?beforePage=${param.beforePage}&patientFlow=${param.patientFlow}&visitFlow=${param.visitFlow}&infoType="+infoType;
	}
	
	function loadAeList(){
		jboxLoad("aeList","<s:url value='/gcp/researcher/aeList'/>?beforePage=${param.beforePage}&type=GCP&patientFlow=${patient.patientFlow}&orgFlow=${patient.orgFlow}&patientCode=${patient.patientCode}&patientNamePy=${patient.patientNamePy}&visitFlow=${param.visitFlow}");
	}
	
</script>

<body>
<div id="main">
   <div class="mainright">
      <div class="content">
      <div style="float: left;width: 70%">
        <ul id="tags">
        	<li id="recipeInfo" class="selectTag" onclick="selTag1(this,'recipeInfo');"><a href="javascript:void(0);">处方</a></li>
        	<li id="labExam" onclick="selTag1(this,'labExam');"><a href="javascript:void(0);">理化检查</a></li>
        	<li id="doctorExplain" onclick="selTag1(this,'doctorExplain');"><a href="javascript:void(0);">医生说明</a></li>
        	<li id="ae" onclick="selTag1(this,'aeList');">
        		<a href="javascript:void(0);">不良事件</a>
        		<img title="新增AE" onclick="ae();" src="${ctxPath }/css/skin/${skinPath}/images/add.png" style="cursor: pointer;margin-top: 5px">
        	</li>
        </ul>
        	<form id="patientVisitForm">
        		<input type="hidden" name="recordFlow" value="${patientVisit.recordFlow}"/>
        <div id="tagContent">
        <div style="margin-left: 20px;margin-right: 20px;margin-top: 20px;">
		           	<table class="basic recipeInfo" style="width: 100%;margin-bottom: 10px">
						<tbody>
							<tr>
								<th colspan="10" style="text-align: left;">
									&#12288;处方信息
									<c:if test="${empty patientRecipe}">
										<i class="i-trend-main-back">
										<a onclick="editRecipe();" href="javascript:void(0);" style="margin-top: 0px"></a>
										</i>
									</c:if>
								</th>
							</tr>
							<c:if test="${!empty patientRecipe}">
							<c:forEach items="${drugList}" var="drug">
								<tr>
									<td style="text-align: left;">
										&#12288;&#12288;${drug.drugName}（${drug.spec}）
									</td>
								</tr>
								<tr>
									<td style="text-align: left;padding-left: 40px;">用法：${drug.recipeUsage}</td>
								</tr>
							</c:forEach>
							<tr>
								<td style="text-align: right;padding-right: 20px;">
									<font style="font-weight: bolder;">处方医生：</font>${patientRecipe.recipeDoctorName}&#12288;&#12288;
									<font style="font-weight: bolder;">处方时间：</font>${pdfn:transDateTime(patientRecipe.recipeDate)}
								</td>
							</tr>
							</c:if>
						</tbody>
						<c:if test="${empty patientRecipe}">
							<tr><td style="text-align: center">无记录</td></tr>
						</c:if>
					</table>
					
					<table class="basic labExam" id="123456" style="width: 100%;margin-bottom: 10px;display: none">
						<tr>
							<th style="text-align: left;padding-left: 10px">
								理化检查
								<i class="i-trend-main-back">
								<a onclick="editVisitInfo('labExam');" href="javascript:void(0);" style="margin-top: 0px"></a>
								</i>
							</th>
						</tr>
						<tr>
							<td>
								<pre style="font-family: Microsoft Yahei;line-height:25px;margin-top: 0px">${visitInfoMap['labExam']}</pre>
							</td>
						</tr>
					</table>
					
					<table class="basic doctorExplain" style="width: 100%;margin-bottom: 10px;display: none">
						<tr>
							<th style="text-align: left;padding-left: 10px">
								医嘱
								<i class="i-trend-main-back">
								<a onclick="editVisitInfo('advice');" href="javascript:void(0);" style="margin-top: 0px"></a>
								</i>
							</th>
						</tr>
						<tr>
							<td>
								<pre style="font-family: Microsoft Yahei;line-height:25px;margin-top: 0px">${visitInfoMap['advice']}</pre>
							</td>
						</tr>
					</table>
					
					<table class="basic doctorExplain" style="width: 100%;margin-bottom: 10px;display: none">
						<tr>
							<th style="text-align: left;padding-left: 10px">
								医生说明
								<i class="i-trend-main-back">
								<a onclick="editVisitInfo('doctorExplain');" href="javascript:void(0);" style="margin-top: 0px"></a>
								</i>
							</th>
						</tr>
						<tr>
							<td>
								<pre style="font-family: Microsoft Yahei;line-height:25px;margin-top: 0px">${visitInfoMap['doctorExplain']}</pre>
							</td>
						</tr>
					</table>
					
					<div id="aeList" class="aeList" style="display:none;">
					
					</div>
					</div>
   		</div>
            </form>
   		</div>
   		<input type="button" value="返&#12288;回" class="search" onclick="infoBack();" style="float: right"/>
   		 <table class="basic" style="float:right;width: 29.5%;margin-top: 3px;margin-bottom: 30px">
						<tr><th style="text-align: left;padding-left:10px" colspan="2">受试者信息</th></tr>
						<tr>
							<td style="text-align: center">受试者编号</td>
							<td>${patient.patientCode}</td>
						</tr>
						<tr>
							<td style="text-align: center">姓名缩写</td>
							<td>${patient.patientNamePy}</td>
						</tr>
						<tr>
							<td style="text-align: center">性别</td>
							<td>${patient.sexName}</td>
						</tr>
						<tr>
							<td style="text-align: center">年龄</td>
							<td>${patient.patientAge}</td>
						</tr>
						<tr>
							<td style="text-align: center">联系方式</td>
							<td>${patient.patientPhone}</td>
						</tr>
						<tr>
							<td style="text-align: center">入组日期</td>
							<td>${pdfn:transDate(patient.inDate)}</td>
						</tr>
						<tr>
							<td style="text-align: center">入组医生</td>
							<td>${patient.inDoctorName}</td>
						</tr>
						<tr><th style="text-align: left;padding-left:10px" colspan="2">本次访视信息</th></tr>
						<tr>
							<td style="text-align: center">访视名称</td>
							<td>${patientVisit.visitName}</td>
						</tr>
						<tr>
							<td style="text-align: center">访视日期</td>
							<td style="color: red">${patientVisit.visitDate}</td>
						</tr>
						<tr>
							<td style="text-align: center">访视窗</td>
							<td>${window.windowVisitLeft}&nbsp;~&nbsp;${window.windowVisitRight}</td>
						</tr>
						<tr>
							<td style="text-align: center">是否超窗</td>
							<td>
								${empty window.outWindowTypeName?'否':window.outWindowTypeName}
								<c:if test="${!empty window.outWindowTypeName}">
									(${window.outWindowDays})
								</c:if>
							</td>
						</tr>
					</table>
   	 </div>
	</div>
</div>
</body></html>