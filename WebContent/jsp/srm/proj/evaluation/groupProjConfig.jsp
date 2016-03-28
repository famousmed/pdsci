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

$(function(){
	prepareData();
});

function prepareData(){
	var way = $('input[name=evaluationWayId]:checked').val();
	if(way=='${evaluationWayEnumMeetingWay.id}'){
		$('#networkDateTr').hide();
		$('#meetingDateTr').show();
		$('#schemeFlow').removeClass("validate[required]");
	}
	if(way=='${evaluationWayEnumNetWorkWay.id}'){
		$('#networkDateTr').show();
		$('#meetingDateTr').hide();
		$('#schemeFlow').addClass("validate[required]");
	}
	$('#groupFlow').val("");
	$('#schemeFlow').val("");
	$('#beginDate').val("");
	$('#endDate').val("");
}

function changeEvalWay(){
	$('#content').html("");
	prepareData();
	var wayId = $('input[name="evaluationWayId"]:checked').val();
	if(wayId=='${evaluationWayEnumNetWorkWay.id}'){
		var url = "<s:url value='/srm/proj/evaluation/changeEvalWay'/>?evaluationWayId="+wayId+"&evaluationId="+$("#evaluationId").val();
		$('#content').load(url);
	}
}
function selectMeeting(){
	$('#content').html("");
	var groupFlow = $('#groupFlow').val();
	if(groupFlow){
		var url = "<s:url value='/srm/proj/evaluation/changeMeeting'/>?groupFlow="+groupFlow;
		$('#content').load(url);
	}
	
}

function save(evalStatusId){
	if(false==$("#expertForm").validationEngine("validate")){
		return ;
	}
	if(evalStatusId == '${evaluationStatusEnumSubmit.id}'){
		jboxConfirm("确认提交?提交后数据无法修改!",function(){
			doSubmit(evalStatusId);
		});
	}else {
		doSubmit(evalStatusId);
	}
}
function doSubmit(evalStatusId){
	if($("#schemeFlow").val()){
		$("#schemeName").val($("#schemeFlow option:selected").text());	
	}
	var url = "<s:url value='/srm/proj/evaluation/saveEvalSet'/>";
	$('#evalStatusId').val(evalStatusId);
	jboxStartLoading();
	jboxPost(url , $('#expertForm').serialize() , function(resp){
		window.location.reload(true);
	} , null , true);
}
function doClose(){
	window.parent.frames['mainIframe'].window.searchProj();
	jboxClose();
}
</script>
<style type="text/css">
	.xllist td,.xllist th{text-align: left;padding-left: 15px;}
	.xllist td span{font-weight: bold;color:#333;font-size: 13px;}
	table{margin-bottom: 10px;}
</style>
</head>
<body>
<div id="main">
   <div class="mainright">
      <div class="content">
        <div class="title1 clearfix">
        	<div>
			   	<table class="xllist nofix">
			   		<tr><th colspan="4" style="font-size: 14px;">项目信息</th></tr>
					<tr>
			        	<td width="400px"><span>项目名称：</span>${proj.projName}</td>
			            <td width="200px" ><span>年&#12288;份：</span>${proj.projYear}</td>
			            <td width="200px"  colspan="2"><span>项目类型：</span>${proj.projTypeName}</td>
			        </tr>
					<tr>
			        	<td width="400px" ><span>承担单位：</span>${proj.applyOrgName}</td>
			            <td width="200px" ><span>负责人：</span>${proj.applyUserName}</td>
			            <td width="200px" colspan="2"><span>起止日期：</span>${proj.projStartTime}~${proj.projEndTime}</td>
			        </tr>
				</table>
	   		</div>
        
        <form id="expertForm" method="post">
           <input type="hidden" id="schemeName" name="schemeName" value=""/>	
           <input type="hidden" id="projFlow" name="projFlow" value="${param.projFlow}"/>
		   <input type="hidden" id="evaluationId" name="evaluationId" value="${param.evaluationId}"/>
		   <input type="hidden" id="evalSetFlow" name="evalSetFlow" value="${groupProj.evalSetFlow}"/>
		   <input type="hidden" id="evalStatusId" name="evalStatusId" value="${groupProj.evalStatusId}"/>
		   <table class="xllist nofix">
		   	<tr>
	            <td width="100px"><span>评审形式：</span></td>
	            <td>
		            <c:choose>
	             		<c:when test="${groupProj.evalStatusId eq evaluationStatusEnumSubmit.id}">
	             			${groupProj.evaluationWayName} 
	             		</c:when>
	             		<c:otherwise>
	             			<input type="radio" value="${evaluationWayEnumMeetingWay.id }" name="evaluationWayId" id="evaluationWayId_2" onchange="changeEvalWay();" <c:if test='${groupProj.evaluationWayId==evaluationWayEnumMeetingWay.id || empty groupProj.evaluationWayId}'>checked </c:if> /><label for="evaluationWayId_2">${evaluationWayEnumMeetingWay.name }</label>
	               &#12288;<input type="radio" value="${evaluationWayEnumNetWorkWay.id }" name="evaluationWayId" id="evaluationWayId_1" onchange="changeEvalWay();" <c:if test='${groupProj.evaluationWayId==evaluationWayEnumNetWorkWay.id}'>checked</c:if>/><label for="evaluationWayId_1">${evaluationWayEnumNetWorkWay.name }</label>
	             		</c:otherwise>
	             	</c:choose>
             	</td>
     		</tr>
     		<c:if test="${empty groupProj || groupProj.evaluationWayId eq evaluationWayEnumMeetingWay.id}">
     		<tr id="meetingDateTr">
     			<td width="100px"><span>会议日期：</span></td>
     			<td>
     				<c:choose>
                   		<c:when test="${groupProj.evalStatusId!=evaluationStatusEnumSubmit.id}">
                   			<select name="groupFlow" onchange="selectMeeting();" class="validate[required]" id="groupFlow" style="width:120px;">
                  					<option value="">--请选择--</option>
                   				<c:forEach items="${groupList}" var="group">
                   					<option value="${group.groupFlow }" <c:if test="${(empty param.groupFlow && group.groupFlow == groupProj.groupFlow )||  param.groupFlow == group.groupFlow}">selected</c:if>>${group.meetingDate }</option>
                   				</c:forEach>
                   			</select>
                   		</c:when>
                   		<c:otherwise>
                   			${group.meetingDate}
                   		</c:otherwise>
                   	</c:choose><c:if test="${empty groupProj.groupFlow }">&#12288;<font color="red" style="font-size:13px;">(该项目还未安排审查会议,您可以选择会议日期进行上会操作，也可以于"评审管理-会议评审"功能进行批量操作)</font></c:if>
     			</td>
     		</tr>
     		</c:if>
     		
     		<c:if test="${empty groupProj || groupProj.evaluationWayId eq evaluationWayEnumNetWorkWay.id}">
     		<tr id="networkDateTr">
     			<td width="100px"><span>评审时间：</span></td>
     			<td>
     				<c:choose>
						<c:when test="${groupProj.evalStatusId eq evaluationStatusEnumSubmit.id}">
							${groupProj.beginDate}&#12288;<label >-</label>&#12288;${groupProj.endDate}
						</c:when>
						<c:otherwise>
							<input type="text" name="beginDate" id="beginDate" class="validate[required] ctime" type="text" readonly="readonly" value="${groupProj.beginDate}" onClick="WdatePicker({dateFmt:'yyyy-MM-dd'})" />
       					<label>-</label>&#12288;
        					<input  type="text" class="validate[required] ctime" readonly="readonly" id="endDate"  onClick="WdatePicker({dateFmt:'yyyy-MM-dd'})" name="endDate" type="text" value="${groupProj.endDate}"  /> 
						</c:otherwise>
					</c:choose>
     			</td>
     		</tr>
     		</c:if>
     		
     		<tr>
     			<td width="100px"><span>评审方案：</span></td>
     			<td>
     				<c:choose>
   						<c:when test="${groupProj.evalStatusId eq evaluationStatusEnumSubmit.id}">
   							${groupProj.schemeName}
   						</c:when>
   						<c:otherwise>
   							<select name="schemeFlow" id="schemeFlow" class="" style="width: 240px">
               				<option value="">--请选择--</option>
							<c:forEach items="${schemes}" var="scheme">
	            				<option value="${scheme.schemeFlow}" <c:if test="${groupProj.schemeFlow eq scheme.schemeFlow}">selected</c:if> >${scheme.schemeName }</option>
	            			</c:forEach>	
							</select>   
   						</c:otherwise>
   					</c:choose>
     			</td>
     		</tr>
			</table>
			
			<div id="content" style="width: 100%;margin-top: 10px;">
	     	<!-- 会审显示内容 --> 
		    <c:if test='${groupProj.evaluationWayId==evaluationWayEnumMeetingWay.id and groupProj.evalStatusId eq evaluationStatusEnumSubmit.id}'> 
		    	<jsp:include page="meetingConfig.jsp"></jsp:include>
		    </c:if>
         	<!-- 网评显示内容 --> 
           <c:if test='${groupProj.evaluationWayId==evaluationWayEnumNetWorkWay.id and groupProj.evalStatusId eq evaluationStatusEnumSubmit.id}'>
           		<jsp:include page="netWorkConfig.jsp"></jsp:include>
           </c:if>
           </div>
        </form>
       </div>
          <table style="width:150px;margin:10px auto;" align="center">
          	  <c:if test='${groupProj.evalStatusId!=evaluationStatusEnumSubmit.id}'>
          	 <tbody>
          	 <tr>
          	 	<!-- 
          	 	  <td id="chooseBtnTd" >	
         		<input  class="search" type="button" id="chooseBtn" onclick="chooseExpert();" value="选择评审委员"/>
	           </td> -->
          	   <!-- 
          	   <td>
         		<input class="search" type="button" onclick="save('${evaluationStatusEnumSave.id}');" value="保&#12288;存"/>
         	   </td>
         	    -->
         	   <td>	
         		<input class="search" type="button" onclick="save('${evaluationStatusEnumSubmit.id}');" value="提&#12288;交"/>
         	   </td>
	           <!-- 
	           <td id="removeBtnTd" >
	            <input  class="search" type="button" id="removeBtn" onclick="removeExpert();" value="删除评审委员"/>
         	   </td>
         	    -->
         	 </tr>
         	</tbody>
         	</c:if>
         	
        </table>
     </div> 	
   </div>
</div>



</body>

</html>
