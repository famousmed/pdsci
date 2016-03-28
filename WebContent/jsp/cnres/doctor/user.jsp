<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>国家住院医师规范化培训示范性基地招录系统</title>
<jsp:include page="/jsp/cnres/htmlhead-cnres.jsp">
	<jsp:param name="basic" value="true"/>
	<jsp:param name="jbox" value="true"/>
	<jsp:param name="font" value="true"/>
	<jsp:param name="jquery_validation" value="true"/>
</jsp:include>

<script type="text/javascript">
function modPasswd(userFlow){
	var url = "<s:url value='/cnres/singup/modPasswd'/>?userFlow="+userFlow;
	jboxOpen(url , "修改密码" , 500 , 300 , true);
}

function modUserCode(userFlow){
	if($("#userCode").validationEngine("validate")){
		return false;
	}
	if('${user.userEmail}'==$("#userCode").val()){
		jboxTip("登录名与邮箱重复，无法修改!");
		return;
	}
	jboxConfirm("确认修改?修改后无法再次修改登录名!"  , function(){
		jboxPost("<c:url value='/cnres/singup/modusercode'/>" , {"userFlow":userFlow , "userCode":$("#userCode").val()} , function(resp){
			if(resp=="1"){
				location.href="<s:url value='/cnres/singup/doctor/userInfo'/>";
			}else{
				jboxTip(resp);
			}
			
		} , null , false);
	});
	
}

</script>
</head>

<body>
  <div class="main_wrap">
    <div class="user-contain">
      <h1>个人信息</h1>
      <p style="font-size: 14px;float: right;"><a href='javascript:modPasswd("${user.userFlow}")'>修改密码</a></p>
      <div class="user-bd">
        <h2>个人信息类型</h2>
        
        
        <table cellpadding="0" cellspacing="0" border="0" class="form_tab">
          <colgroup>
            <col width="20%" />
            <col width="20%" />
            <col width="20%" />
            <col width="20%" />
            <col width="20%" />
          </colgroup>
          <tr class="odd">
            <th>医师类型：</th>
            <td>${doctor.doctorTypeName}</td>
            <th>&nbsp;</th>
            <td>&nbsp;</td>
            <th>&nbsp;</th>
          </tr>
          <c:if test="${doctor.doctorTypeId eq recDocTypeEnumAgency.id}">
            <tr class="even">
            <th>工作单位名称：</th>
            <td>${doctor.workOrgName}</td>
            <th>委培单位同意证明：</th>
            <td>
                <c:if test="${!empty doctor.dispatchFile}">
                    [<a href="${sysCfgMap['upload_base_url']}/${doctor.dispatchFile}" target="_blank">点击查看</a>]
				</c:if>
            </td>
            <th>&nbsp;</th>
            </tr>
          </c:if>
        </table>
      </div>
      <div class="user-bd">
        <h2>个人信息</h2>
        <table cellpadding="0" cellspacing="0" border="0" class="form_tab">
          <colgroup>
            <col width="20%" />
            <col width="20%" />
            <col width="20%" />
            <col width="20%" />
            <col width="20%" />
          </colgroup>
          <tr class="even">
                 <c:if test='${user.userCode eq user.userEmail}'>
                    <th>
                                                           登录名：
                    </th>
                    <td colspan="4"> 
                      <input type="text" class="validate[required,custom[userCode]] input" style="vertical-align: initial;" id="userCode" value="${user.userCode}"></input><a href="javascript:void(0);" onclick="modUserCode('${user.userFlow}');">修改</a>
                   	&#12288;<font color='red'>您只可以修改一次用户名(不同于邮箱)，修改后可使用用户名登录系统.</font>
                    </td>
                  </c:if>
                  <c:if test='${user.userCode!=user.userEmail}'>
                     <th>
                                                           登录名：
                    </th>
                    <td colspan="4"> 
                      ${user.userCode}
                    </td>
                  </c:if>
          </tr>
          <tr class="odd">
            <th>姓名：</th>
            <td>${user.userName}</td>
            <th>性别：</th>
            <td>${user.sexName}</td>
            <td rowspan="6" style="padding-left: 20px;">
            	<img src="${sysCfgMap['upload_base_url']}/${doctor.doctorHeadImg}" width="140px" height="200px"/>
			</td>
          </tr>
          <tr class="even">
				<th>证件号码：</th>
				<td>${user.idNo}</td>
				<th>出生日期：</th>
				<td>${user.userBirthday}</td>
			</tr>
			<tr class="odd">
				<th>手机号码：</th>
				<td>${user.userPhone}</td>
				<th>电子邮箱：</th>
				<td>${user.userEmail} </td>
			</tr>
			<tr class="even">
				<th>通讯地址：</th>
				<td colspan="3">${user.userAddress} </td>
			</tr>
			<tr class="odd">
				<th style="line-height:20px; height:50px"  >紧急联系人：</th>
				<td style=" height:50px">${doctor.emergencyName}</td>
				<th style="line-height:20px; height:50px">紧急联系人<br/>联系方式：</th>
				<td style=" height:50px">${doctor.emergencyPhone}</td>
			</tr>
			<tr class="even">
				<th>与本人关系：</th>
				<td colspan="3">${doctor.emergencyRelation}</td>
			</tr>
        </table>
      </div>
      <div class="user-bd">
        <h2>学历信息登记</h2>
        <table cellpadding="0" cellspacing="0" border="0" class="form_tab">
          <colgroup>
            <col width="20%" />
            <col width="20%" />
            <col width="20%" />
            <col width="20%" />
            <col width="20%" />
          </colgroup>
          <tr class="odd">
          	<th>毕业院校：</th>
            <td>${doctor.graduatedName}</td>
            <th>毕业时间：</th>
            <td>${doctor.graduationTime}</td>
            <td></td>
          </tr>
          <tr class="even">
            <th>毕业专业：</th>
            <td colspan="4">
                 <c:forEach var="dict" items="${dictTypeEnumGraduateMajorList}">
              	     <c:if test='${doctor.specialized==dict.dictId}'>${dict.dictName}${dict.dictDesc }</c:if>
              	 </c:forEach>
            </td>
          </tr>
          <tr class="odd">
            <th>学历：</th>
            <td>${user.educationName}</td>
            <th>学位：</th>
            <td>${user.degreeName}</td>
            <td></td>
          </tr>
          <tr class="even">
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
            <td></td>
          </tr>
          <tr class="odd">
            <th>医师资格证号：</th>
			<td>${doctor.qualifiedNo}</td>
            <th>医师资格证书：</th>
            <td>
                <c:if test="${!empty doctor.qualifiedFile}">
				    [<a href="${sysCfgMap['upload_base_url']}/${doctor.qualifiedFile}" target="_blank">点击查看</a>]
				</c:if>
            </td>
            <td></td>
          </tr>
        </table>
      </div>
    </div>
  </div>
</body>
</html>
