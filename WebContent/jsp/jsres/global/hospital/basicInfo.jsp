<jsp:include page="/jsp/jsres/htmlhead-jsres.jsp">
	<jsp:param name="basic" value="true"/>
	<jsp:param name="jbox" value="true"/>
	<jsp:param name="font" value="true"/>
</jsp:include>
<script type="text/javascript">
function auditStatus(baseFlow,status){
	var s="通过";
	if(status=='${GlobalConstant.FLAG_N}'){
		s="不通过";
	}
	jboxConfirm("确认"+s+"？",function(){
		var data={
				"baseFlow":baseFlow,
				"status":status
			};
	jboxPost("<s:url value='/jsres/base/baseAudit'/>" , data , function(resp){
			if("${GlobalConstant.OPRE_SUCCESSED}"==resp){
				window.parent.auditHospitals();
				setTimeout(function(){
					loadInfo('${GlobalConstant.BASIC_INFO}','${param.baseFlow}');
				},1000);
			}
		} , null , true);
	});
	}
</script>
</head>
<body>
	<div class="infoAudit"  <c:if test="${param.openType != 'open'}">style="height: auto;"</c:if>>
	    <div class="div_table">
		   <h4>基本信息</h4>
		   <table border="0" cellspacing="0" cellpadding="0" class="base_info">
		   <colgroup>
		     <col width="20%"/>
		     <col width="30%"/>
		     <col width="20%"/>
		     <col width="30%"/>
		   </colgroup>
		   <tbody>
		     <tr>
		       <th>基地名称：</th>
		       <td colspan="3">${sysOrg.orgName}</td>
		     </tr>
		     <tr>
		       <th>住院医师基地获批文号：</th>
		       <td>${resBase.resApprovalNumberName}</td>
		       <th>全科医师基地获批文号：</th>
		       <td>${resBase.gpsApprovalNumberName}</td>
		     </tr>
		      <tr>
		       <th>邮编：</th>
		       <td>${sysOrg.orgZip}</td>
		       <th>电子邮件：</th>
		       <td>${resBase.email}</td>
		     </tr>
		     <tr>
		       <th>地址：</th>
		       <td colspan="3">${sysOrg.orgAddress}</td>
		     </tr>
		     <tr>
		       <th>职业许可证:</th>
		       <td>
		       		<span  style="display:${!empty basicInfo.professionLicenceUrl?'':'none'} ">
		              	    [<a href="${sysCfgMap['upload_base_url']}/${basicInfo.professionLicenceUrl}" target="_blank">查看图片</a>]&#12288;
		            	</span>
		       </td>
		       <th>医院等级证书:</th>
		       <td>
		       		<span style="display:${!empty basicInfo.hospitalLevelLicenceUrl?'':'none'} ">
		              	    [<a href="${sysCfgMap['upload_base_url']}/${basicInfo.hospitalLevelLicenceUrl}" target="_blank">查看图片</a>]&#12288;
		            	</span>
		       </td>
		     </tr>
		     <tr>
		       <th>第一联系人:</th>
		       <td colspan="3">${basicInfo.contactorsList[0].contactorName }</td>
		     </tr>
		      <tr>
		       <th>联系人科室:</th>
		       <td>${basicInfo.contactorsList[0].dept}</td>
		       <th>联系人职务:</th>
		       <td>${basicInfo.contactorsList[0].job }</td>
		     </tr>
		     <tr>
		       <th>联系人固定电话:</th>
		       <td>${basicInfo.contactorsList[0].phone }</td>
		       <th>联系人手机:</th>
		       <td>${basicInfo.contactorsList[0].mobilephone}</td>
		     </tr>
		     <tr>
		       <th>第二联系人:</th>
		       <td colspan="3">${basicInfo.contactorsList[1].contactorName }</td>
		     </tr>
		     <tr>
		       <th>联系人科室:</th>
		       <td>${basicInfo.contactorsList[1].dept}</td>
		       <th>联系人职务:</th>
		       <td>${basicInfo.contactorsList[1].job}</td>
		     </tr>
		     <tr>
		       <th>联系人固定电话:</th>
		       <td>${basicInfo.contactorsList[1].phone }</td>
		       <th>联系人手机:</th>
		       <td>${basicInfo.contactorsList[1].mobilephone}</td>
		     </tr>
		   </tbody>
		   </table>
		</div>
		<div class="div_table">
		  <h4>医院资质</h4>
		  <table border="0" cellspacing="0" cellpadding="0" class="base_info">
		   <colgroup>
		     <col width="20%"/>
		     <col width="30%"/>
		     <col width="20%"/>
		     <col width="30%"/>
		   </colgroup>
		   <tbody>
		     <tr>
		       <th>基地级别：</th>
		       <td>${resBase.baseGradeName}</td>
		       <th>基地类型：</th>
		       <td>${resBase.baseTypeName}</td>
		     </tr>
		      <tr>
		       <th>基地性质：</th>
		       <td>${resBase.basePropertyName}</td>
		       <th>宿舍床位数：</th>
		       <td>${basicInfo.bedNumber}</td>
		     </tr>
		     <tr>
		       <th>获得普通专科培训合格证：</th>
		       <td>${basicInfo.normalTraningNumber}</td>
		       <th>获得亚专科培训合格证：</th>
		       <td>${basicInfo.inferiorTrainingNumber}</td>
		     </tr>
		     <tr>
		       <th>获得全科培训合格证：</th>
		       <td colspan="3">${basicInfo.allTrainingNumber} </td>
		     </tr>
		   </tbody>
		   </table>
		</div>
		<div class="btn_info">
		 <jsp:include page='/jsp/jsres/province/hospital/passBtn.jsp'/>
	    </div>
	</div>
</body>
</html>