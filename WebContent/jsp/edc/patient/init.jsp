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
	function initPatient(){
		var ret = testPatientCode();
		if(ret){
			jboxConfirm("确认初始化分配？",function () {
				var url = "<s:url value='/pub/patient/initProjPatient?patientType=${patientType}'/>";
				var data = $('#dataForm').serialize();
				jboxPost(url,data,function (resp){
					if(resp=="${GlobalConstant.SAVE_SUCCESSED}"){
						window.parent.frames['mainIframe'].window.location.reload();
						jboxClose();
					}
					});		
			});
		}
	}
	function testPatientCode(){
		result = true;
		var patientCode=new Array;//所有编码的集合
		$("input[name=orgFlow]").each(function(i){
			var count=0;//计算出的编码总数
			var input =$("#"+$(this).val()+"_input");
			if(input.val()!=""){
				//检查格式
				if(input.val().match(/(((,|-)[^0-9]))|([^0-9](,|-))|([^0123456789,-])|(-\d+-)|(^[^0-9])|([^0-9]$)/g)!=null){
					jboxTip("请正确填写[编码分配]\n格式为：1-20,21,22,30-40等内容.");
					input.focus();
					return false;
				}
				//解析字符串
				var temp=input.val().match(/(\d+-\d+(?=,|$))|(\d+)/g);
				if (temp==null){
					jboxTip("请正确填写[编码分配]\n格式为：1-20,21,22,30-40等内容.");
					input.focus();
					result = false;
				}
				var content="";
				for(var j=0;j<temp.length;j++){
					//分析每组数据
					ind=temp[j].indexOf("-");
					if (ind<0){
						//单个值
						var k=parseInt(temp[j]);
						//检查 重复
						if(patientCode[k]==null||patientCode[k]==0){
							//加入集合
							patientCode[k]=1;
							count++;
							content=content+","+k;
						}else{
							//有重复,警告
							jboxTip("编号 "+k+" 重复指定");
							input.focus();
							result = false;
						}
					}else{
						//范围
						var t=temp[j].split("-");
						var startn,endn;
						startn=parseInt(t[0]);
						endn=parseInt(t[1]);
						if(endn<=startn){
							jboxTip("请正确填写[编码分配]\n格式为：1-20,21,22,30-40等内容.");
							input.focus();
							result = false;
						}
						for (k=startn;k<=endn;k++){
							//检查 重复
							if(patientCode[k]==null||patientCode[k]==0){
								//加入集合
								patientCode[k]=1;
								count++;
								content=content+","+k;
							}else{
								//有重复,警告
								jboxTip("编号"+k+"重复指定");
								input.focus();
								result = false;
							}
						}
					}
				}
				content=(content).slice(-(content.length-1));
				$("#"+$(this).val()+"_patientCode").val(content);
				if ("${patientType}" == "${patientTypeEnumReal.id}") {
					$("#"+$(this).val()+"_patientCount").val(count);
					$("#"+$(this).val()+"_patientCountSpan").html(count);
				}
			}else {
				$("#"+$(this).val()+"_patientCode").val("");
				if ("${patientType}" == "${patientTypeEnumReal.id}") {
					$("#"+$(this).val()+"_patientCount").val(0);
					$("#"+$(this).val()+"_patientCountSpan").html("0");
				}
			}
		});
		return result;
	}
	
	function doClose() {
		jboxClose();			
	}
</script>
</head>
<body>
<div class="mainright">
<form id="dataForm">
	<div class="content">
		<div class="title1 clearfix">
		<table class="xllist" width="700px">
			<tr>
				<th>中心号</th>
				<th>机构名称</th>
				<th>机构承担病例数</th>
				<th>分配${patientType eq patientTypeEnumTest.id?"测试":"" }样本</th>
			</tr>
			<c:forEach items="${pdfn:filterProjOrg(pubProjOrgList)}" var="projOrg">
				<tr style="height: 20px">
					<td style="width: 100px">${projOrg.centerNo}
						<input type="hidden" name="orgFlow" value="${projOrg.orgFlow }">
					</td>
					<td style="width: 250px">${applicationScope.sysOrgMap[projOrg.orgFlow].orgName}</td> 
					<td style="width: 150px">
						<span style="text-align: center" id="${projOrg.orgFlow }_patientCountSpan">${projOrg.patientCount}</span>
						<input type="hidden" id="${projOrg.orgFlow }_patientCount" name="${projOrg.orgFlow }_patientCount" value="${projOrg.patientCount}">
					</td>
					<td style="width: 200px">
						<input type="text" id="${projOrg.orgFlow }_input" onblur="//testPatientCode();" value="${pdfn:getPatientCode(patientMap[projOrg.orgFlow]) }"/>
						<input type="hidden" name="${projOrg.orgFlow }_patientCode" id="${projOrg.orgFlow }_patientCode" >
					</td>
				</tr>
			</c:forEach>
		</table>
	
	<div class="title1 clearfix" align="center">
		<input type="button" class="search" onclick="initPatient();" value="保&#12288;存">
		<input class="search" type="button" value="关&#12288;闭" onclick="doClose();" />
	</div>
	</div></div>
	</form>
	</div>
</body>
</html>