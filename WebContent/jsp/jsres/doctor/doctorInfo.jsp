<jsp:include page="/jsp/jsres/htmlhead-jsres.jsp">
	<jsp:param name="basic" value="true"/>
	<jsp:param name="jbox" value="true"/>
	<jsp:param name="font" value="true"/>
	<jsp:param name="jquery_datePicker" value="true"/>
</jsp:include>
<script type="text/javascript">
/* function editDoctorInfo(userFlow){
	var url = "<s:url value='/jsres/doctor/doctorInfo'/>?openType=open&userFlow="+userFlow;
	jboxLoad("doctorContent", url, true);
} */
</script>

<div class="infoAudit">
	<div class="${'open' eq param.type?'infoAudit2':'main_bd' }">
		<div class="${'open' eq param.type?'search_table':'div_table' }">
			<h4>基本信息</h4>
			<table border="0" cellpadding="0" cellspacing="0" class="base_info">
			<colgroup>
				<col width="15%"/>
				<col width="30%"/>
				<col width="15%"/>
				<col width="21%"/>
				<col width="19%"/>
			</colgroup>
			<tbody>
			    <tr>
			    	<th>姓&#12288;&#12288;名：</th>
			        <td>${user.userName}</td>
			        <th>性&#12288;&#12288;别：</th>
			        <td class="fontc" style="padding-left:10px;">${user.sexName}</td>
			        <td rowspan="5" style="text-align: center;">
			        	<img src="${sysCfgMap['upload_base_url']}/${user.userHeadImg}" id="showImg" width="110px" height="130px" onerror="this.src='<s:url value="/jsp/edu/css/images/up-pic.jpg"/>'"/>
			        </td>
			    </tr>
			    <tr>
			    	<th>证件类型：</th>
			        <td>${userResumeExt.certificateType}</td>
			        <th>证件号：</th>
			        <td>${user.idNo}</td>
				</tr>
			    <tr>
			    	<th>民&#12288;&#12288;族：</th>
			        <td>${user.nationName}</td>
			        <th>生&#12288;&#12288;日：</th>
			        <td>${user.userBirthday}</td>
			        
			    </tr>
			    <tr>
			    	<th>手&#12288;&#12288;机：</th>
			        <td>${user.userPhone}</td>
			        <th>固定电话：</th>
			        <td>${userResumeExt.telephone}</td>
               </tr>
			    <tr>
			    	<th>计算机能力：</th>
			        <td>${doctor.computerSkills}</td>
			        <th>外语能力：</th>
			        <td>${doctor.foreignSkills}</td>
			    </tr>
			    <tr>
			    	<th>电子邮箱：</th>
			        <td colspan="4">${user.userEmail}</td>
			    </tr>
			    <tr>
			    	<th>人员类型：</th>
			        <td>${userResumeExt.personnelType}</td>
			        <th>工作单位：</th>
			        <td colspan="2">${user.orgName}</td>
			    </tr>
			    <tr>
			    	<th>本人通讯地址：</th>
			        <td colspan="4">${user.userAddress}</td>
			    </tr>
			    <tr>
			    	<th>紧急联系人：</th>
			        <td>${doctor.emergencyName}</td>
			        <th>联系人手机：</th>
			        <td colspan="2">${doctor.emergencyPhone}</td>
			    </tr>
			    <tr>
			    	<th>紧急联系人地址：</th>
			        <td colspan="4">${userResumeExt.emergencyAddress}</td>
			    </tr>
			 </tbody>
		</table>
	</div>
	<div class="div_table">
		<h4>教育情况</h4>		
		<table border="0" cellpadding="0" cellspacing="0" class="base_info">
			<colgroup>
				<col width="15%"></col>
				<col width="30%"></col>
				<col width="15%"></col>
				<col width="40%"></col>
			</colgroup>
			<tbody>
			     <tr>
			    	<th>毕业院校：</th>
			        <td colspan="4">${doctor.graduatedName}</td>
			    </tr>
			     <tr>
			    	<th>毕业专业：</th>
			        <td>${doctor.specialized}</td>
			        <th>毕业时间：</th>
			        <td colspan="2">${doctor.graduationTime}</td>
			    </tr>
			    <tr>
			    	<th>最高学历：</th>
			        <td>${user.educationName}</td>
			        <th>毕业证书编号：</th>
			        <td colspan="2">
			        	${doctor.certificateNo}
			        	<span id="certificateUriSpan" style="display:${!empty userResumeExt.certificateUri?'':'none'} ">
							[<a href="${sysCfgMap['upload_base_url']}/${userResumeExt.certificateUri}" target="_blank">查看毕业证书</a>]
						</span>
					</td>			       
			    </tr>
			    <tr>
			    	<th>最高学位：</th>
			        <td>${user.degreeName}</td>
			        <th>学院证书编号：</th>
			        <td colspan="2">
			        	${userResumeExt.collegeCertificateNo}
			        	<a style="color:#459ae9;float:right;margin-right:30px;"></a>
			        	<span id="degreeUriSpan" style="display:${!empty userResumeExt.degreeUri?'':'none'} ">
							[<a href="${sysCfgMap['upload_base_url']}/${userResumeExt.degreeUri}" target="_blank">查看学位证书</a>]
						</span>
			        </td>	      
			    </tr>
			 </tbody>
		</table></div>
		<div class="div_table">	
		<h4>现有资格信息</h4>
		<table border="0" align="center" cellpadding="0" cellspacing="0" class="base_info">
		<colgroup>
				<col width="15%"></col>
				<col width="30%"></col>
				<col width="15%"></col>
				<col width="40%"></col>
			</colgroup>
			<tbody>
			    <tr>
			    	<th>专业技术资格：</th>
			        <td>${userResumeExt.technologyQualification}</td>
			        <th>取得日期：</th>
			        <td colspan="2">${userResumeExt.getTechnologyQualificationDate}</td>
			    </tr>
			     <tr>
			    	<th>执业资格材料：</th>
			        <td>${userResumeExt.qualificationMaterial}</td>
			        <th>资格材料编码：</th>
			        <td colspan="2">${userResumeExt.qualificationMaterialCode}</td>
			    </tr>
			     <tr>
			    	<th>执业类别：</th>
			        <td>${userResumeExt.practicingCategory}</td>
			        <th>执业范围：</th>
		         	<td colspan="2">${userResumeExt.practicingScope}</td>
			    </tr>
			  </tbody>
			</table>
		</div>	
		<div class="btn_info">
			<input type="button" style="width:100px;" class="btn_blue" onclick="" value="通过"></input>
			<input type="button" style="width:100px;" class="btn_red" onclick="" value="不通过"></input>
			<c:if test="${'open' eq param.openType}">
				<input type="button" style="width:100px;" class="btn_blue" onclick="jboxClose();" value="关闭"></input>
			</c:if>
		</div>
	</div>
</div>