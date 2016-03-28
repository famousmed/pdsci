<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>湖北省住院医师规范化培训招录系统</title>
<jsp:include page="/jsp/hbres/htmlhead-hbres.jsp">
	<jsp:param name="basic" value="true"/>
	<jsp:param name="jbox" value="true"/>
	<jsp:param name="font" value="true"/>
</jsp:include>
<script type="text/javascript">
function editFormHidden(isHidden){
	if(isHidden){
		$("#editForm").hide();
		$("#down").show();
		$("#up").hide();
	}else{
		$("#editForm").show();
		$("#up").show();
		$("#down").hide();
	}
	
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
				<td>${user.userAddress} </td>
				<th></th>
				<td></td>
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
				<th></th>
				<td></td>
				<td width="20%" colspan="4"></td>
			</tr>
			<tr>
				<th width="15%">毕业专业：</th>
				<td width="25%">
				   <c:forEach var="dict" items="${dictTypeEnumGraduateMajorList}">
              	        <c:if test='${doctor.specialized==dict.dictId}'>${dict.dictName}${dict.dictDesc }</c:if>
              	    </c:forEach>
				</td>
				<th>毕业时间：</th>
				<td>${doctor.graduationTime}</td>
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
		
		<table border="0" width="945" cellspacing="0" cellpadding="0" >
			<caption>报考信息</caption>
			
			<tr>
				<th width="15%">志愿院校：</th>
				<td width="25%">${recruit.orgName}</td>
				<th width="15%">志愿专业：</th>
				<td width="25%">${recruit.speName}</td>
			</tr>
			<tr>
				<th width="15%">是否服从专业调剂：</th>
				<td width="25%">${GlobalConstant.FLAG_Y eq recruit.swapFlag?'是':'否' }</td>
			</tr>
			<tr>
				<th>笔试成绩：</th>
				<td colspan="3">${recruit.examResult}</td>
			</tr>
		</table>
		<!-- 
		<c:if test="${GlobalConstant.FLAG_Y eq recruit.retestFlag}">
			<table border="0" width="945" cellspacing="0" cellpadding="0">
				<caption>复试通知内容</caption>
				<tr>
					<td colspan="4" style="padding-top:10px;padding-left:0;">${recruit.retestNotice }</td>
				</tr>
			</table>
		</c:if>
		<c:if test="${GlobalConstant.FLAG_Y eq recruit.recruitFlag}">
			<table border="0" width="945" cellspacing="0" cellpadding="0">
				<caption>录取通知内容</caption>
				<tr>
					<td colspan="4" style="padding-top:10px;padding-left:0;">${recruit.admitNotice }</td>
				</tr>
			</table>
		</c:if>
		 -->
		 
		 <div>
		     <p class="caption">招录记录 
		     <span class="fr">
		     <a title="收缩" id="up" onclick=""><img src="<s:url value='/jsp/hbres/images/up.png'/>"/></a>
		     <a title="展开" id="down" onclick="" style="display: none"><img src="<s:url value='/jsp/hbres/images/down.png'/>"/></a>
             </span>
             </p>
		     <table id='history' class="grid">
		         <thead>
		             <tr>
		                 <th style="text-align:center;">志愿</th>
		                 <th style="text-align:center;">专业</th>
		                 <th style="text-align:center;">类型</th>
		                 <th style="text-align:center;">笔试成绩</th>
		                 <th style="text-align:center;">操作/面试成绩</th>
		                 <th style="text-align:center;">填报(或调剂)时间</th>
		                 <th style="text-align:center;">录取结果</th>
		             </tr>
		         </thead>
		         
		             <c:forEach items="${doctorRecruits}" var="historyRec">
		                 <tr>
		                     <td style="text-align:center;">${historyRec.orgName}</td>
		                     <td style="text-align:center;">${historyRec.speName}</td>
		                     <td style="text-align:center;">${historyRec.recruitTypeName}</td>
		                     <td style="text-align:center;">${historyRec.examResult}</td>
		                     <td style="text-align:center;">${historyRec.operResult}/${historyRec.auditionResult}</td>
		                     <td style="text-align:center;">${historyRec.recruitDate}</td>
		                     <td style="text-align:center;">
		                         <c:choose>
		                             <c:when test='${historyRec.confirmFlag eq "F"}'>
		                                 <span>已过期</span>
		                             </c:when>
		                             <c:when test='${historyRec.confirmFlag eq "N"}'>
		                                 <span>放弃录取</span>
		                             </c:when>
		                             <c:when test='${historyRec.confirmFlag eq "Y"}'>
		                                 <span>已确认录取</span>
		                             </c:when>
		                             <c:when test='${historyRec.recruitFlag eq "N"}'>
		                                 <span>未录取</span>
		                             </c:when>
		                             <c:when test='${historyRec.recruitFlag eq "Y"}'>
		                                 <span>已录取(等待学员确认)</span>
		                             </c:when>
		                         </c:choose>
		                     </td>
		                 </tr>
		             </c:forEach>
		         
		     </table>
		 </div>
		 
		<div align="center" style="margin-top: 20px; margin-bottom:20px;">
			<a class="btn_grey" id="closeBtn" href="javascript:jboxClose();">&nbsp;关&nbsp;闭&nbsp;</a>
		</div>
	</div>
</body>
</html>