<jsp:include page="/jsp/hbres/htmlhead-hbres.jsp">
	<jsp:param name="jquery_datePicker" value="true"/>
</jsp:include>
<script type="text/javascript">
$(document).ready(function(){
	$('#graduationTime').datepicker();
});	

function readUser() {
	var url ="<s:url value='/hbres/singup/adminMod'/>";
	var data = "key="+$('#key').val();
	jboxPostLoad("content", url, data, true);
} 

function saveInfo(){
	jboxPost("<s:url value='/hbres/singup/saveAdminMod'/>",$("#userForm").serialize(),null,null,true);
}

function resetDoctorRecruit(doctorFlow){
	jboxConfirm("重置后数据不可恢复，确认重置？" , function(){
		jboxPost("<s:url value='/hbres/singup/resetDoctorRecruit'/>?doctorFlow="+doctorFlow,null,function(res){
			if ("${GlobalConstant.OPRE_SUCCESSED}"==res) {
				readUser();
			}
		},null,true);
	});	 
}
</script>
<style>
</style>
<div class="main_hd">
    <form id="recruitResultForm">
		<h2 class="underline">人员信息修改&#12288;&#12288;
			<input type="text" placeholder="姓名/邮件/身份证/手机号" value="${param.key }" id="key" class="input" style="width: 200px;" onblur="readUser();"/> 
		</h2> 
	</form>
</div>
<div class="main_bd" id="div_table_0" >
<c:if test="${!empty user }">
<form id="userForm">
	<input type="hidden" value="${user.userFlow }" name="userFlow"/>
	<input type="hidden" value="${user.userFlow }" name="doctorFlow"/>
    <div class="infoAudit" style="height: 100%;overflow-y:hidden;">
		<table border="0" width="945" cellspacing="0" cellpadding="0">
			<caption>个人信息类型</caption>
	     	 <tr>
				<th width="15%">医师类型：</th>
				<td width="25%">
					<select name="doctorTypeId" class="select" onchange="saveInfo();">
						<c:forEach items="${recDocTypeEnumList }" var="docType">
							<option value="${docType.id }" <c:if test="${doctor.doctorTypeId==docType.id}">selected</c:if>>${docType.name}</option>
						</c:forEach>
					</select> 
				</td>
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
				<td width="25%">
					 <select class="validate[required,maxSize[20]] select" id="graduatedId"  name="graduatedId" style="width:250px;" onchange="saveInfo();">
					    <c:forEach var="dict" items="${dictTypeEnumGraduateSchoolList}">
							<option value="${dict.dictId}" <c:if test='${dict.dictId==doctor.graduatedId}'>selected="selected"</c:if>>${dict.dictName}</option>
						</c:forEach>
						<c:if test="${doctor.graduatedId=='00'}">
						    <option value="${doctor.graduatedName}" selected="selected">${doctor.graduatedName}</option>
						</c:if>
				</select>
				</td>
				<th>毕业时间：</th>
				<td><input type="text"  name="graduationTime" id="graduationTime" value="${doctor.graduationTime}" class="validate[required] input" onchange="saveInfo();" /></td>
			</tr>
			<tr>
				<th width="15%">毕业专业：</th>
				<td colspan="3" >
				   <select name="specialized" id="specialized" style="width: 250px;" class="validate[required] select" onchange="saveInfo();">
              	    <c:forEach var="dict" items="${dictTypeEnumGraduateMajorList}">
              	        <option value="${dict.dictId}" <c:if test='${doctor.specialized==dict.dictId}'>selected="selected"</c:if>>${dict.dictName}${dict.dictDesc}</option>
              	    </c:forEach>
              	</select>
				</td>
			</tr>
			<tr>
				<th>学历：</th>
				<td><select name="educationId" class="validate[required] select" onchange="saveInfo();">
						<option></option>
						<c:forEach items="${dictTypeEnumUserEducationList}" var="dict">
							<option value="${dict.dictId}" ${user.educationId eq dict.dictId?'selected':''}>${dict.dictName}</option>
						</c:forEach>
					</select></td>
				<th>学位：</th>
				<td><select name="degreeId" class="select" onchange="saveInfo();">
						<option></option>
						<c:forEach items="${dictTypeEnumUserDegreeList}" var="dict">
							<option value="${dict.dictId}" ${user.degreeId eq dict.dictId?'selected':''}>${dict.dictName}</option>
						</c:forEach>
					</select></td>
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
		 <div>
		     <p class="caption">招录记录 
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
		                 <th style="text-align:center;">操作</th>
		             </tr>
		         </thead>
		         	 <c:set var="confirmFlag" value="false"/>
		             <c:forEach items="${doctorRecruits}" var="historyRec" varStatus="status">
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
		                                 <c:set var="confirmFlag" value="true"/>
		                             </c:when>
		                             <c:when test='${historyRec.recruitFlag eq "N"}'>
		                                 <span>未录取</span>
		                             </c:when>
		                             <c:when test='${historyRec.recruitFlag eq "Y"}'>
		                                 <span>已录取(等待学员确认)</span>
		                             </c:when>
		                         </c:choose>
		                     </td>
		                     <td style="text-align:center;">
			                     <c:if test="${status.last && !confirmFlag}">
			                     	<a class="btn" onclick="resetDoctorRecruit('${doctor.doctorFlow}');">重置</a>
			                     </c:if>
		                     </td>
		                 </tr>
		             </c:forEach>
		         
		     </table>
		 </div>
	</div>
	</form>
	</c:if>
    </div>
    
      
