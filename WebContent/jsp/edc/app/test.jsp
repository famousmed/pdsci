<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@include file="/jsp/common/doctype.jsp" %>
<html>
<head>
<jsp:include page="/jsp/common/htmlhead.jsp">
<jsp:param name="basic" value="true"/>
	<jsp:param name="jbox" value="true"/>
</jsp:include>
<script type="text/javascript" src="<s:url value='/js/math/sha1.js'/>?v=${applicationScope.sysCfgMap['sys_version']}"></script>
<script type="text/javascript">

function test(){
	$("#reqParam").text($("#reqParam").val());
	var sign = hex_sha1($("#reqCode option:selected").val()+$("#reqParam").val()+$("#keyStr").val());
	$("#sign").val(sign)
	jboxPost("<s:url value='/edc/app/reqFunction'/>",$('#appForm').serialize(),function(resp){
		$("#rsp").html(resp);
	},null,false);
}
function change(divid){
	$("#reqParam").text($("#"+divid+" textarea").val());
}
$(document).ready(function(){
	change("login");
});
</script>
</head>

<body>
<form id="appForm">
<div style="width: 60%;float: left">
<br/>
<div style="margin-left: 100px">
	keyStr：<input class="xltext" id="keyStr" type="text" name="keyStr" value="www.wcare.cn" style="width: 300px;">
</div>
<div style="margin-top: 20px;margin-bottom: 20px;margin-left: 100px">
	reqCode：<select id="reqCode" name="reqCode" onchange="change(this.value);">
						<option value="login">登录(login)</option>
						<option value="projList">项目列表(projList)</option>
						<option value="applyParam">申请参数(applyParam)</option>
						<option value="apply">入组申请(apply)</option>
						<option value="visit">随访申请(visit)</option>
						<option value="patientList">申请记录(patientList)</option>
						<option value="patientDetail">申请记录详情(patientDetail)</option>
						<option value="update">系统更新(update)</option>
				</select>
</div>
<div style="margin-top: 20px;margin-bottom: 20px;margin-left: 100px">			
	reqParam：<textarea id="reqParam" style="width: 600px;height: 200px;" name="reqParam" wrap="soft"></textarea>
</div>
<div style="margin-left: 100px">
	sign：<input class="xltext" id="sign" type="text" name="sign" style="width: 300px;">
</div>
<br/>
<div style="margin-left: 100px">
	response：<textarea style="width: 600px;height: 300px;"  id="rsp" readonly="readonly"></textarea>
</div>
<div style="margin-top: 20px;margin-left: 400px;">
<input type="button" value="测试" class="search" onclick="test();">
</div>
</div>
</form>
<div style="float: left ;margin-top: 20px;" style="display: none">
<div id="login" class="reqParam" style="display: none">
<textarea style="width: 350px;height: 400px" readonly="readonly"><request>
	   	<userPhone>13913957836</userPhone>
	 	<userPasswd>123456</userPasswd> 
	</request></textarea>
</div>
<div class="reqParam" id="projList" style="display: none">
<textarea style="width: 350px;height: 400px" readonly="readonly">
	<request>
   		<userFlow></userFlow>
	</request>
</textarea>
</div>
<div id="applyParam" class="reqParam" style="display: none">
<textarea style="width: 350px;height: 400px" readonly="readonly">
	<request>
		<userFlow></userFlow>
	    <projFlow></projFlow>
	</request>
</textarea>
</div>
<div id="apply" class="reqParam" style="display: none">
<textarea style="width: 350px;height: 400px" readonly="readonly">
	<request>
  		 <userFlow></userFlow>
  		 <projFlow></projFlow>
   		<patientInfo>
			<item id="namePy">test</item>
			<item id="birthday">19770707</item>
			<item id="sex">Man/Woman</item>
	    </patientInfo>
	    <factor>
			<item id="1">1</item>
			<item id="2">2</item>
	    </factor>
	    <include>
	    	<item id="xt">45</item>
			<item id="nr1">true</item>
			<item id="nr2">true</item>
			<item id="nr3">true</item>
		</include>
		<exclude>
			<item id="pc1">true</item>
			<item id="pc2">true</item>
			<item id="pc3">true</item>
		</exclude>
	</request>
</textarea>
</div>
<div id="visit" class="reqParam" style="display: none">
<textarea style="width: 350px;height: 400px" readonly="readonly">
	<request>
	   <userFlow></userFlow>
	   <projFlow></projFlow>
	   <patientFlow></patientFlow>
	   <factor>
		<item id="1">1</item>
		<item id="2">2</item>
	   </factor>
	</request>
</textarea>
</div>
<div id="patientList" class="reqParam" style="display: none">
<textarea style="width: 350px;height: 400px" readonly="readonly">
	<request>
   		<projFlow></projFlow>
   		<userFlow></userFlow>
	</request>
</textarea>
</div>
<div id="patientDetail" class="reqParam" style="display: none">
<textarea style="width: 350px;height: 400px" readonly="readonly">
	<request>
	   <projFlow></projFlow>
	   <userFlow></userFlow>
		<patientFlow></patientFlow>
	</request>
</textarea>
</div>
<div id="update" class="reqParam" style="display: none">
<textarea style="width: 350px;height: 400px" readonly="readonly">
<request>
   		<appType></appType>
	</request>	
</textarea>
</div>
</div>

</body></html>
	
</div>