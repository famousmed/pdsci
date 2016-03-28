<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>国家住院医师规范化培训示范性基地招录系统</title>
<jsp:include page="/jsp/cnres/htmlhead-cnres.jsp">
	<jsp:param name="basic" value="true"/>
	<jsp:param name="jbox" value="true"/>
	<jsp:param name="font" value="true"/>
</jsp:include>
<script type="text/javascript">
	function audit(statusId,title){
		if("${regStatusEnumUnPassed.id}"==statusId){
			if($.trim($("#auditAgree").val())==""){
				jboxTip("审核意见不能为空!");
				return;
			}
		}
		jboxConfirm("确认"+title+"?",function(){
			var data = {
					doctorFlow:"${doctor.doctorFlow}",
					disactiveReason:$("#auditAgree").val(),
					<c:if test='${sysCfgMap["res_rereg"] eq "Y"}'>
					reeditFlag:$("#reeditFlag")[0].checked?"${GlobalConstant.FLAG_Y}":"${GlobalConstant.FLAG_N}",
					</c:if>
					userFlow:"${user.userFlow}",
					doctorStatusId:statusId
			};
			jboxPost("<s:url value='/cnres/singup/manage/userAudit'/>",data,
				function(resp){
					if(resp == "${GlobalConstant.OPRE_SUCCESSED}"){
						window.parent.$(".tab_select").click();
						jboxClose();
					}
				}
			,null,true);
		});
	}
</script>
</head>
<body style="width:100%; min-width: inherit; height:100%;background-image:none; background:#fff;">
	<div class="infoAudit" >
		<table border="0" width="945" cellspacing="0" cellpadding="0">
			<caption>个人信息类型</caption>
	     	 <tr>
				<th width="15%">医师类型：</th>
				<td width="25%">${doctor.doctorTypeName}</td>
				<th width="15%"></th>
				<td width="25%"></td>
				<td width="20%" colspan="4"></td>
			</tr>
			<c:if test="${doctor.doctorTypeId eq recDocTypeEnumAgency.id}">
				<tr>
					<th>工作单位名称：</th>
					<td>${doctor.workOrgName}</td>
					<th>委培单位同意证明：</th>
					<td>
						<c:if test="${!empty doctor.dispatchFile}">
							[<a href="${sysCfgMap['upload_base_url']}/${doctor.dispatchFile}" target="_blank">点击查看</a>]
						</c:if>
					</td>
				</tr>
			</c:if>
		</table>
		
		<table border="0" width="945" cellspacing="0" cellpadding="0">
			<caption>个人信息</caption>
	     	 <tr>
				<th width="15%">姓名：</th>
				<td width="25%">${user.userName}</td>
				<th width="15%">性别：</th>
				<td width="25%">${user.sexName}</td>
				<td width="20%" rowspan="6">
					<img src="${sysCfgMap['upload_base_url']}/${doctor.doctorHeadImg}"  width="140px" height="200px"/>
				</td>
			</tr>
			<tr>
				<th>证件号码：</th>
				<td>${user.idNo}</td>
				<th>出生日期：</th>
				<td>${user.userBirthday}</td>
			</tr>
			<tr>
				<th>手机号码：</th>
				<td>${user.userPhone}</td>
				<th>电子邮箱：</th>
				<td>${user.userEmail} </td>
			</tr>
			<tr>
				<th>通讯地址：</th>
				<td colspan="3">${user.userAddress}</td>
			</tr>
			<tr>
				<th width="15%" style="line-height:20px; height:50px"  >紧急联系人：</th>
				<td width="25%" style=" height:50px">${doctor.emergencyName}</td>
				<th width="15%" style="line-height:20px; height:50px">紧急联系人<br/>联系方式：</th>
				<td width="25%" style=" height:50px">${doctor.emergencyPhone}</td>
			</tr>
			<tr>
				<th>与本人关系：</th>
				<td colspan="3">${doctor.emergencyRelation}</td>
			</tr>
		</table>
		
		<table border="0" width="945" cellspacing="0" cellpadding="0" >
			<caption>学历信息登记</caption>
			
			<tr>
				<th width="15%">毕业院校：</th>
				<td width="25%">${doctor.graduatedName}</td>
				<th>毕业时间：</th>
				<td>${doctor.graduationTime}</td>
			</tr>
			<tr>
				<th width="15%">毕业专业：</th>
				<td colspan="3" >
				   <c:forEach var="dict" items="${dictTypeEnumGraduateMajorList}">
              	        <c:if test='${doctor.specialized==dict.dictId}'>${dict.dictName}${dict.dictDesc }</c:if>
              	    </c:forEach>
				</td>
			</tr>
			<tr>
				<th>学历：</th>
				<td>${user.educationName}</td>
				<th>学位：</th>
				<td>${user.degreeName}</td>
			</tr>
			<tr>
				<th>毕业证书：</th>
				<td>
					<c:if test="${!empty doctor.certificateNo}">
						[<a href="${sysCfgMap['upload_base_url']}/${doctor.certificateNo}" target="_blank">点击查看</a>]
					</c:if>
				</td>
				<th>学位证书：</th>
				<td>
					<c:if test="${!empty doctor.degreeNo}">
						[<a href="${sysCfgMap['upload_base_url']}/${doctor.degreeNo}" target="_blank">点击查看</a>]
					</c:if>
				</td>
			</tr>
			<tr>
				<th>医师资格证号：</th>
				<td>${doctor.qualifiedNo}</td>
				<th>医师资格证：</th>
				<td>
					<c:if test="${!empty doctor.qualifiedFile}">
						[<a href="${sysCfgMap['upload_base_url']}/${doctor.qualifiedFile}" target="_blank">点击查看</a>]
					</c:if>
				</td>
			</tr>
		</table>
		
		<c:if test="${doctor.doctorStatusId eq regStatusEnumPassing.id}">
			<table border="0" width="945" cellspacing="0" cellpadding="0">
				<caption>审核意见</caption>
				<tr>
					<td colspan="4" style="padding-top:10px;padding-left:0;">
						<textarea id="auditAgree"></textarea>
					</td>
				</tr>
				<c:if test='${sysCfgMap["res_rereg"] eq "Y"}'>
				<tr>
					<td colspan="4" style="padding-top:10px;padding-left:0;">
						<label><input type="checkbox" id="reeditFlag" />&nbsp;如若审核不通过，允许修改资料后重新报名</label>
					</td>
				</tr>
				</c:if>
			</table>
		</c:if>
		
		<div align="center" style="margin-top: 20px; margin-bottom:20px;">
			<c:if test="${doctor.doctorStatusId eq regStatusEnumPassing.id}">
				<input type="button" style="width:100px;" class="btn_blue" onclick="javascript:audit('${regStatusEnumPassed.id}','审核通过');" value="通过"></input>
				<input type="button" style="width:100px;" class="btn_red" onclick="javascript:audit('${regStatusEnumUnPassed.id}','审核不通过');" value="不通过"></input>
			</c:if>
			<input type="button" style="width:100px;" class="btn_grey" onclick="javascript:jboxClose();" value="关闭"></input>
		</div>
	</div>
</body>
</html>