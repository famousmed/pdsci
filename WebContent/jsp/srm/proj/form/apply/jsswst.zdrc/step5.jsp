<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@include file="/jsp/common/doctype.jsp" %>
<html>
<head>
<jsp:include page="/jsp/common/htmlhead.jsp">
	<jsp:param name="basic" value="true"/>
	<jsp:param name="jbox" value="true"/>
	<jsp:param name="jquery_form" value="true"/>
	<jsp:param name="jquery_ui_tooltip" value="true"/>
	<jsp:param name="jquery_ui_combobox" value="true"/>
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
	function nextOpt(step){
		if(false==$("#projForm").validationEngine("validate")){
			return false;
		}
		var form = $('#projForm');
		var action = form.attr('action');
		action+="?nextPageName="+step;
		form.attr("action" , action);
		form.submit();
	}
	
	function add(tb){
	 	$("#"+tb+"Tb").append($("#"+tb+"Template tr:eq(0)").clone());
	 	
	 	var length = $("#"+tb+"Tb").children().length;
	 	//序号
		$("#"+tb+"Tb").children("tr").last().children("td").eq(1).text(length);
	}
	
	
	function delTr(tb){
		//alert("input[name="+tb+"Ids]:checked");
		var checkboxs = $("input[name='"+tb+"Ids']:checked");
		if(checkboxs.length==0){
			jboxTip("请勾选要删除的！");
			return false;
		}
		jboxConfirm("确认删除?",function () {
			var trs = $('#'+tb+'Tb').find(':checkbox:checked');
			$.each(trs , function(i , n){
				$(n).parent('td').parent("tr").remove();
			});
			//删除后序号
			var serial = 0;
			$("."+tb+"Serial").each(function(){
				serial += 1;
				$(this).text(serial);
			});
		});
	}


</script>
<style type="text/css">
 .bs_tb tbody td input{text-align: left;margin-left: 10px;}
</style>
</head>
<body>
<div id="main">
	<div class="mainright">
		<div class="content">
       <div style="margin-top: 10px;">
	<form action="<s:url value='/srm/proj/mine/saveStep'/>" method="post" style="position: relative;"
		id="projForm">
		<input type="hidden" id="pageName" name="pageName" value="step5" /> 
		<input type="hidden" id="recFlow" name="recFlow" value="${projRec.recFlow}"/>
		<input type="hidden" id="projFlow" name="projFlow" value="${proj.projFlow}"/>
		<input type="hidden" id="recTypeId" name="recTypeId" value="${param.recTypeId}"/>
		   
		<font style="font-size: 14px; font-weight:bold;color: #333; ">五、其他指标</font>
		<!-- 1.中心所具有杂志编委情况 -->
		<table class="bs_tb" style="width: 100%;margin-top: 10px;">
			<tr>
				<th colspan="10" class="theader">1.中心所具有杂志编委情况
					<c:if test="${param.view!=GlobalConstant.FLAG_Y }">
					<span style="float: right;padding-right: 10px">
					<img title="新增" src="<s:url value="/css/skin/${skinPath}/images/add3.png" />" style="cursor: pointer;" onclick="add('magazine')"></img>&#12288;
					<img title="删除"  style="cursor: pointer;" src="<s:url value='/css/skin/${skinPath}/images/del1.png'/>" onclick="delTr('magazine');"></img></span>
					</c:if>
				</th>
			</tr>
			<tr>
				<td width="50px" style="font-weight:bold;"></td>
				<td width="50px" style="font-weight:bold;">序号</td>
				<td style="font-weight:bold;">杂志名称</td>
				<td style="font-weight:bold;">杂志类型</td>
				<td style="font-weight:bold;">担任职务</td>
			</tr>
			<tbody id="magazineTb">
			<c:if test="${! empty resultMap.magazine}">
				<c:forEach var="magazine" items="${resultMap.magazine}" varStatus="status">
				<tr>
		             <td width="50px" style="text-align: center;"><input name="magazineIds" type="checkbox"/></td>
		             <td width="50px" style="text-align: center;" class="magazineSerial">${status.count}</td>
		             <td><input type="text" name="magazine_name" value="${magazine.objMap.magazine_name}" class="inputText" style="width: 80%"/></td>
		             <td><input type="text" name="magazine_typeName" value="${magazine.objMap.magazine_typeName}"  class="inputText" style="width: 80%"/></td>
		             <td><input type="text" name="magazine_officeHolding" value="${magazine.objMap.magazine_officeHolding}"  class="inputText" style="width: 80%"/></td>
				</tr>
			    </c:forEach>
	    	</c:if>
			</tbody>
		</table>
		
		<!-- 2.继续医学教育情况 -->
		<table class="bs_tb" style="width: 100%;margin-top: 10px;">
			<tr>
				<th colspan="10" class="theader">2.继续医学教育情况
					<c:if test="${param.view!=GlobalConstant.FLAG_Y }">
					<span style="float: right;padding-right: 10px">
					<img title="新增" src="<s:url value="/css/skin/${skinPath}/images/add3.png" />" style="cursor: pointer;" onclick="add('medicalEdu')"></img>&#12288;
					<img title="删除"  style="cursor: pointer;" src="<s:url value='/css/skin/${skinPath}/images/del1.png'/>" onclick="delTr('medicalEdu');"></img></span>
					</c:if>
				</th>
			</tr>
			<tr>
				<td width="50px" style="font-weight:bold;"></td>
				<td width="50px" style="font-weight:bold;">序号</td>
				<td style="font-weight:bold;">项目名称</td>
				<td style="font-weight:bold;">项目类型</td>
				<td style="font-weight:bold;">承担工作类型</td>
				<td style="font-weight:bold;">起止时间</td>
			</tr>
			<tbody id="medicalEduTb">
			<c:if test="${! empty resultMap.medicalEdu}">
				<c:forEach var="medicalEdu" items="${resultMap.medicalEdu}" varStatus="status">
				<tr>
		             <td width="50px" style="text-align: center;"><input name="medicalEduIds" type="checkbox"/></td>
		             <td width="50px" style="text-align: center;" class="medicalEduSerial">${status.count}</td>
		             <td><input type="text" name="medicalEdu_projname" value="${medicalEdu.objMap.medicalEdu_projname}" class="inputText" style="width: 80%"/></td>
		             <td><input type="text" name="medicalEdu_projTypeName" value="${medicalEdu.objMap.medicalEdu_projTypeName}"  class="inputText" style="width: 80%"/></td>
		             <td><input type="text" name="medicalEdu_jobTypeName" value="${medicalEdu.objMap.medicalEdu_jobTypeName}"  class="inputText" style="width: 80%"/></td>
		             <td style="text-align: center;">
		             	<input class="inputText ctime" type="text" name="medicalEdu_startDate" value="${medicalEdu.objMap.medicalEdu_startDate}" onClick="WdatePicker({dateFmt:'yyyy-MM-dd'})" readonly="readonly" style="margin-right: 0px;"/>
		             	~<input class="inputText ctime" type="text" name="medicalEdu_endDate" value="${medicalEdu.objMap.medicalEdu_endDate}" onClick="WdatePicker({dateFmt:'yyyy-MM-dd'})" readonly="readonly"/>
		             </td>
				</tr>
			    </c:forEach>
	    	</c:if>
			</tbody>
		</table>
		
		
		<!-- 3.国外进修 -->
		<table class="bs_tb" style="width: 100%;margin-top: 10px;">
			<tr>
				<th colspan="10" class="theader">3.国外进修
					<c:if test="${param.view!=GlobalConstant.FLAG_Y }">
					<span style="float: right;padding-right: 10px">
					<img title="新增" src="<s:url value="/css/skin/${skinPath}/images/add3.png" />" style="cursor: pointer;" onclick="add('furtherEdu')"></img>&#12288;
					<img title="删除"  style="cursor: pointer;" src="<s:url value='/css/skin/${skinPath}/images/del1.png'/>" onclick="delTr('furtherEdu');"></img></span>
					</c:if>
				</th>
			</tr>
			<tr>
				<td style="font-weight:bold;" width="50px"></td>
				<td style="font-weight:bold;" width="50px">序号</td>
				<td style="font-weight:bold;">国家</td>
				<td style="font-weight:bold;">起止时间</td>
			</tr>
			<tbody id="furtherEduTb">
			<c:if test="${! empty resultMap.furtherEdu}">
				<c:forEach var="furtherEdu" items="${resultMap.furtherEdu}" varStatus="status">
				<tr>
		             <td width="50px" style="text-align: center;"><input name="furtherEduIds" type="checkbox"/></td>
		             <td width="50px" style="text-align: center;" class="furtherEduSerial">${status.count}</td>
		             <td><input type="text" name="furtherEdu_country" value="${furtherEdu.objMap.furtherEdu_country}" class="inputText" style="width: 80%"/></td>
		             <td style="text-align: center;">
		             	<input class="inputText ctime" type="text" name="furtherEdu_startDate" value="${furtherEdu.objMap.furtherEdu_startDate}" onClick="WdatePicker({dateFmt:'yyyy-MM-dd'})" readonly="readonly" style="margin-right: 0px;"/>
		             	~<input class="inputText ctime" type="text" name="furtherEdu_endDate" value="${furtherEdu.objMap.furtherEdu_endDate}" onClick="WdatePicker({dateFmt:'yyyy-MM-dd'})" readonly="readonly"/>
		             </td>
				</tr>
			    </c:forEach>
	    	</c:if>
			</tbody>
		</table>
		
		<!-- 4.学术交流 -->
		<table class="bs_tb" style="width: 100%;margin-top: 10px;">
			<tr>
				<th colspan="10" class="theader">4.学术交流
					<c:if test="${param.view!=GlobalConstant.FLAG_Y }">
					<span style="float: right;padding-right: 10px">
					<img title="新增" src="<s:url value="/css/skin/${skinPath}/images/add3.png" />" style="cursor: pointer;" onclick="add('exchange')"></img>&#12288;
					<img title="删除"  style="cursor: pointer;" src="<s:url value='/css/skin/${skinPath}/images/del1.png'/>" onclick="delTr('exchange');"></img></span>
					</c:if>
				</th>
			</tr>
			<tr>
				<td style="font-weight:bold;" width="50px"></td>
				<td style="font-weight:bold;" width="50px">序号</td>
				<td style="font-weight:bold;">会议名称</td>
				<td style="font-weight:bold;">会议性质</td>
				<td style="font-weight:bold;">地点</td>
				<td style="font-weight:bold;">时间</td>
				<td style="font-weight:bold;">参会方式</td>
			</tr>
			<tbody id="exchangeTb">
			<c:if test="${! empty resultMap.exchange}">
				<c:forEach var="exchange" items="${resultMap.exchange}" varStatus="status">
				<tr>
		             <td width="50px" style="text-align: center;"><input name="exchangeIds" type="checkbox"/></td>
		             <td width="50px" style="text-align: center;" class="exchangeSerial">${status.count}</td>
		             <td><input type="text" name="exchange_conferenceName" value="${exchange.objMap.exchange_conferenceName}" class="inputText" style="width: 80%"/></td>
		             <td><input type="text" name="exchange_conferenceNature" value="${exchange.objMap.exchange_conferenceNature}" class="inputText" style="width: 80%"/></td>
		             <td><input type="text" name="exchange_place" value="${exchange.objMap.exchange_place}" class="inputText" style="width: 80%"/></td>
		             <td>
		             	 <input class="inputText ctime" type="text" name="exchange_time" value="${exchange.objMap.exchange_time}" onClick="WdatePicker({dateFmt:'yyyy-MM-dd'})" readonly="readonly" style="margin-right: 0px;width: 80%"/>
		             </td>
		             <td><input type="text" name="exchange_joinWay" value="${exchange.objMap.exchange_joinWay}" class="inputText" style="width: 80%"/></td>
				</tr>
			    </c:forEach>
	    	</c:if>
			</tbody>
		</table>
		</form>
		
		<div style="display: none">	
		<!-- 4.学术交流模板 -->
		<table class="bs_tb" id="exchangeTemplate" style="width: 100%">
            <tr>
	             <td width="50px" style="text-align: center;"><input name="exchangeIds" type="checkbox"/></td>
	             <td width="50px" style="text-align: center;" class="exchangeSerial"></td>
	             <td><input type="text" name="exchange_conferenceName"  class="inputText" style="width: 80%"/></td>
	             <td><input type="text" name="exchange_conferenceNature"  class="inputText" style="width: 80%"/></td>
	             <td><input type="text" name="exchange_place"  class="inputText" style="width: 80%"/></td>
	             <td>
	             	 <input class="inputText ctime" type="text" name="exchange_time" value="${exchange.objMap.exchange_time}" onClick="WdatePicker({dateFmt:'yyyy-MM-dd'})" readonly="readonly" style="margin-right: 0px;width: 80%"/>
	             </td>
	             <td><input type="text" name="exchange_joinWay"  class="inputText" style="width: 80%"/></td>
			</tr>
		</table>
		
		<!-- 3.国外进修模板 -->
		<table class="bs_tb" id="furtherEduTemplate" style="width: 100%">
            <tr>
	             <td width="50px" style="text-align: center;"><input name="furtherEduIds" type="checkbox"/></td>
	             <td width="50px" style="text-align: center;" class="furtherEduSerial"></td>
	             <td><input type="text" name="furtherEdu_country" value="${furtherEdu.objMap.furtherEdu_country}" class="inputText" style="width: 80%"/></td>
	             <td style="text-align: center;">
	             	<input class="inputText ctime" type="text" name="furtherEdu_startDate"  onClick="WdatePicker({dateFmt:'yyyy-MM-dd'})" readonly="readonly" style="margin-right: 0px;"/>
	             	~<input class="inputText ctime" type="text" name="furtherEdu_endDate"  onClick="WdatePicker({dateFmt:'yyyy-MM-dd'})" readonly="readonly"/>
	             </td>
			</tr>
		</table>
		
		<!-- 2.继续医学教育模板 -->
		<table class="bs_tb" id="medicalEduTemplate" style="width: 100%">
        <tr>
             <td width="50px" style="text-align: center;"><input name="medicalEduIds" type="checkbox"/></td>
             <td width="50px" style="text-align: center;" class="medicalEduSerial"></td>
             <td><input type="text" name="medicalEdu_projname" class="inputText" style="width: 80%"/></td>
             <td><input type="text" name="medicalEdu_projTypeName" class="inputText" style="width: 80%"/></td>
             <td><input type="text" name="medicalEdu_jobTypeName" class="inputText" style="width: 80%"/></td>
             <td style="text-align: center;">
             	<input class="inputText ctime" type="text" name="medicalEdu_startDate" onClick="WdatePicker({dateFmt:'yyyy-MM-dd'})" readonly="readonly" style="margin-right: 0px;"/>
             	~<input class="inputText ctime" type="text" name="medicalEdu_endDate" onClick="WdatePicker({dateFmt:'yyyy-MM-dd'})" readonly="readonly"/>
             </td>
		</tr>
		</table>
		
		<!-- 杂志编委模板 -->
		<table class="bs_tb" id="magazineTemplate" style="width: 100%">
        <tr>
             <td width="50px" style="text-align: center;"><input name="magazineIds" type="checkbox"/></td>
             <td width="50px" style="text-align: center;" class="magazineSerial"></td>
             <td><input type="text" name="magazine_name" class="inputText" style="width: 80%"/></td>
             <td><input type="text" name="magazine_typeName" class="inputText" style="width: 80%"/></td>
             <td><input type="text" name="magazine_officeHolding" class="inputText" style="width: 80%"/></td>
		</tr>
		</table>
		</div>	
    <div class="button" style="width: 100%; <c:if test="${param.view == GlobalConstant.FLAG_Y}">display:none</c:if>">
	    <a href="javascript:void(0)" target="_self" class="search" onclick="nextOpt('step4')">上一步</a>
	   <a href="javascript:void(0)" target="_self" class="search" onclick="nextOpt('step6')">下一步</a>
    </div>
		</div>
		</div>
		</div>
		</div>
		</body>
		</html>
		