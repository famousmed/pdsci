<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/jsp/common/doctype.jsp" %>
<html>
<head>
<jsp:include page="/jsp/common/htmlhead.jsp">
	<jsp:param name="basic" value="true"/>
	<jsp:param name="jbox" value="true"/>
	<jsp:param name="jquery_iealert" value="false"/>
	<jsp:param name="jquery_datePicker" value="true"/>
	<jsp:param name="jquery_ui_tooltip" value="true"/>
	<jsp:param name="jquery_validation" value="true"/>
</jsp:include>
<script type="text/javascript">
	$(document).ready(function(){
		if('${empty rotationDeptMap}'=='true'){
			$(".groupInfo").hide();
			$(".data").hide();
		}else{
			$("#deptNum").attr("class","validate[required,custom[number,max["+$(".box:checked").length+"],min[1]]]");
			if($("[name='isRequired']:checked").val()=='${GlobalConstant.FLAG_Y}'){
				$(".groupInfo").hide();
			}else{
				$(".groupInfo").show();
			}
			$(".data").hide();
			var selDepts = $(".box:checked");
			selDepts.each(function(){
				$(".data."+$(this).val()).show();
			});
		}
	});
	
	function groupInfoView(){
		$(".box").attr("checked",false);
		$(".data").hide();
		if($("[name='isRequired']:checked").val()=='${GlobalConstant.FLAG_Y}'){
			//$(".groupInfo").hide();
			location.href = "<s:url value='/sch/template/deptcfg_edit'/>?rotationFlow=${param.rotationFlow}&isAdd=${GlobalConstant.FLAG_Y}";
		}else{
			$(".groupInfo").show();
			$(":hidden[id^='recordFlow']").val("");
		}
	}
	
	function dataView(deptFlow){
		$("#deptNum").attr("class","validate[required,custom[number,max["+$(".box:checked").length+"],min[1]]]");
		if($(".data."+deptFlow).is(":hidden")){
			$(".data."+deptFlow).show();
		}else{
			$(".data."+deptFlow).hide();
		}
	}
	
	function parse(year){
		var integer = parseInt(year);
		return isNaN(integer)?0:integer;
	}
	
	function saveRotationDept(){
		if($(".box:checked").length==0){
			jboxTip("必须选择一个科室!");
			return;
		}
		if(!$("#schRotationDept").validationEngine("validate")){
			return ;
		} 
		var url = "<s:url value='/sch/template/saveRotationDept'/>";
		var selDepts = $(".box:checked");
		var rotationDepts = [];
		selDepts.each(function(){
			value = this.value;
			var obj = {
					"recordFlow":$("#recordFlow"+value).val(),
					"schDeptFlow":value,
					"schDeptName":$("#schDeptName"+value).val(),
					"schMonth":schMonth,
					'rotationFlow':'${param.rotationFlow}',
					"schMonth":$("#schMonth"+value).val(),
					"isRequired":$("[name='isRequired']:checked").val(),
					"deptNote":$("#deptNote"+value).val(),
					};
			rotationDepts.push(obj);
		});
		var requestData= {
				"rotationDeptList":rotationDepts,
				"rotationGroup":{
					"groupFlow":$("#groupFlow").val(),
					"rotationFlow":"${param.rotationFlow}",
					"groupName":$("#groupName").val(),
					"groupNote":$("#groupNote").val(),
					"schMonth":$("#schMonth").val(),
					"deptNum":$("#deptNum").val(),
				}
				};
		jboxPostJson(url,JSON.stringify(requestData),function(resp){
			if(resp=='${GlobalConstant.SAVE_SUCCESSED}'){
				window.parent.frames["mainIframe"].window.refresh('${param.rotationFlow}');
				jboxClose();
			}
		},null,true);
	}
</script>
</head>
<body>
	<div class="main_fix" style="overflow: hidden;margin-top: -45px">
		<div class="" id="main">
		<form id="schRotationDept" style="position: relative;">
			<input type="hidden" id="groupFlow" value="${rotationGroup.groupFlow}"/>
			<div style="width: 30%;float: left;overflow: auto;height: 500px;" class="side">
				<table class="basic" style="width: 100%">
					<tr>
						<th style="text-align: left;">&#12288;轮转科室</th>
					</tr>
					<tr>
						<td valign="top">
							<div style="overflow: auto;">
								<c:forEach items="${deptList}" var="dept">
									&#12288;<label><input onclick="dataView(this.value);" type="checkbox" class="box ${dept.schDeptFlow}" value="${dept.schDeptFlow}" ${!empty rotationDeptMap[dept.schDeptFlow]?'checked="checked"':''} />${dept.schDeptName}</label><br/>
									<input type="hidden" id="schDeptName${dept.schDeptFlow}" value="${dept.schDeptName}"/>
								</c:forEach>
							</div>
						</td>
					</tr>
				</table>
			</div>
			<div id="dept" style="width:65%;margin-bottom: 10px;float: left;overflow: auto;height: 500px;" class="side">
				<table width="100%" class="basic" style="font-size: 14px">
						<tr>
							<th style="text-align: left;width: 100px;" colspan="3">&#12288;轮转科室配置</th>
						</tr>
						<tr>
							<td style="text-align: right;width: 20%">必轮科室：</td>
							<td colspan="2">
								<input type="radio" value="${GlobalConstant.FLAG_Y}" name="isRequired" id="yes" ${empty rotationDeptMap || empty rotationGroup?'checked="checked"':''} onclick="groupInfoView();" ${!empty rotationDeptMap && empty param.isAdd?'disabled="disabled"':''}><label for="yes">是</label>
								&#12288;
								<input type="radio" value="${GlobalConstant.FLAG_N}" ${!empty rotationGroup?'checked="checked"':''} name="isRequired" id="no" onclick="groupInfoView();" ${!empty rotationDeptMap && empty param.isAdd?'disabled="disabled"':''}><label for="no">否</label>
							</td>
						</tr>
						
						<tr>
							<th style="text-align: center;">科室名称</th>
							<th style="text-align: center; width: 150px;">轮转时间</th>
							<th style="text-align: center;">备注</th>
						</tr>
						<c:forEach items="${deptList}" var="dept">
							<input type="hidden" id="recordFlow${dept.schDeptFlow}" value="${rotationDeptMap[dept.schDeptFlow].recordFlow}"/>
							<tr class="data ${dept.schDeptFlow}">
								<td style="text-align: center;width: 150px;">${dept.schDeptName}</td>
								<td style="text-align: center">
									<input type="text" value="${rotationDeptMap[dept.schDeptFlow].schMonth}" id="schMonth${dept.schDeptFlow}" style="width: 25px;text-align: center;" class="validate[required,custom[number]]"/>
									<font color="red" >*</font>
								</td>
								<td><input type="text" value="${rotationDeptMap[dept.schDeptFlow].deptNote}" style="width: 90%" id="deptNote${dept.schDeptFlow}"/></td>
							</tr>
						</c:forEach>
						<tr class="groupInfo">
							<th colspan="3" style="text-align: left;">&#12288;组合信息</th>
						</tr>
						<tr class="groupInfo">
							<td style="text-align: right;">组合名称：</td>
							<td colspan="2">
								<input id="groupName" type="text" value="${rotationGroup.groupName}" style="width: 93%" class="validate[required]"/>
								<font color="red" >*</font>
							</td>
						</tr>
						<tr class="groupInfo">
							<td style="text-align: right;">轮转时间：</td>
							<td colspan="2">
								<input id="schMonth" type="text" class="validate[required,custom[number]]" value="${rotationGroup.schMonth}" style="width: 30px"/>
								<font color="red" >*</font>
							</td>
						</tr>
						<tr class="groupInfo">
							<td style="text-align: right;">科室选择数：</td>
							<td colspan="2">
								<input id="deptNum" type="text" value="${rotationGroup.deptNum}" style="width: 30px" />
								<font color="red" >*</font>
							</td>
						</tr>
						<tr class="groupInfo">
							<td style="text-align: right;">组合备注：</td>
							<td colspan="2"><input id="groupNote" type="text" value="${rotationGroup.groupNote}" style="width: 93%"/></td>
						</tr>
					</table>
					<div style="padding-top: 5px;text-align: center;">
						<input type="button" value="保&#12288;存" class="search" onclick="saveRotationDept();"/>
						<input type="button" value="关&#12288;闭" class="search" onclick="jboxClose();"/>
						<ul style="font-size: 15px;padding-top: 20px;">
							<li style="margin-bottom: 10px;">1.必轮科室默认组合科室为"否"，只需在左侧点击需要轮转的科室即可</li>
							<li style="margin-bottom: 10px;">2.若为组合科室，可在左侧多个勾选后编辑相应科室轮转时间 </li>
							<li style="margin-bottom: 10px;">3.住院医师选科操作只选择该方案中组合科室</li>
						</ul>
					</div>
		</div>
		</form>
	</div>
</div>
</body>
</html>