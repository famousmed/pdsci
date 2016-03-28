<jsp:include page="/jsp/jsres/htmlhead-jsres.jsp">
	<jsp:param name="jquery_datePicker" value="true"/>
	<jsp:param name="jquery_validation" value="true"/>
</jsp:include>
<script type="text/javascript" src="<s:url value='/js/ajaxfileupload.js'/>?v=${applicationScope.sysCfgMap['sys_version']}"></script>
<script type="text/javascript">
$(function(){
	$('.datepicker').datepicker();
});

function saveDoctorInfo(){
	if(false==$("#doctorForm").validationEngine("validate")){
		return false;
	}
	var url = "<s:url value='/jsres/doctor/saveDoctorInfo'/>";
	jboxPost(url, $("#doctorForm").serialize(), function(resp){
			if("${param.openType}" == "open"){
				setTimeout(function(){
					doClose();
				},1000);
			}
			doctorInfo('${user.userFlow}');
		}, null , true);
}

function uploadImage(){
	$.ajaxFileUpload({
		url:"<s:url value='/sys/user/userHeadImgUpload'/>?userFlow=${user.userFlow}",
		secureuri:false,
		fileElementId:'imageFile',
		dataType: 'json',
		success: function (data, status){
			if(data.indexOf("success")==-1){
				jboxTip(data);
			}else{
				jboxTip('${GlobalConstant.UPLOAD_SUCCESSED}');
				var arr = new Array();
				arr = data.split(":");
				$("#userImg").val(arr[1]);
				var url = "${sysCfgMap['upload_base_url']}/"+ arr[1];
				$("#showImg").attr("src",url);
				$("#headimgurl").val(arr[1]);
			}
		},
		error: function (data, status, e){
			jboxTip('${GlobalConstant.UPLOAD_FAIL}');
		},
		complete:function(){
			$("#imageFile").val("");
		}
	});
}

function uploadFile(type,typeName) {
	var url = "<s:url value='/jsres/doctor/uploadFile'/>?userFlow=${user.userFlow}&operType="+type;
	jboxOpen(url, "上传"+typeName, 450, 150);
}

function delFile(type) {
	jboxConfirm("确认删除？" , function(){
		$("#"+type+"Del").hide();
		$("#"+type+"Span").hide();
		$("#"+type).text("上传");
		$("#"+type+"Value").val("");
	});
	
}
</script>
<div class="infoAudit" <c:if test="${empty param.openType}">style="height: 1000px;"</c:if>>	
	<form id="doctorForm" style="position:relative;">
		<input type="hidden" name="user.userFlow" value="${user.userFlow}"/>
		<input type="hidden" name="doctor.doctorFlow" value="${doctor.doctorFlow}"/>
		<div class="search_table">
		<h4>基本信息</h4>
		<table border="0" cellpadding="0" cellspacing="0" class="base_info" >
			<colgroup>
				<col width="14%"/>
				<col width="30%"/>
				<col width="14%"/>
				<col width="26%"/>
				<col width="16%"/>
			</colgroup>
			<tbody>
			    <tr>
			    	<th>姓&#12288;&#12288;名：</th>
			        <td><input name="user.userName" value="${user.userName}" class="validate[required] input"/>&#12288;<span style="color: red;">*</span></td>
			        <th>性&#12288;&#12288;别：</th>
			        <td>
			        	&nbsp;<label><input type="radio" class='validate[required]' style="width:auto;" name="user.sexId" value='${userSexEnumMan.id}' ${user.sexId eq userSexEnumMan.id?'checked':''}/>&nbsp;${userSexEnumMan.name}</label>&#12288;
                        <label><input type="radio" class='validate[required]' style="width:auto;" name="user.sexId" value='${userSexEnumWoman.id}' ${user.sexId eq userSexEnumWoman.id?'checked':''}/>&nbsp;${userSexEnumWoman.name}</label>&#12288;<span style="color: red;">*</span>
			        </td>
			        <td rowspan="5" style="text-align: center;">
			        	<img src="${sysCfgMap['upload_base_url']}/${user.userHeadImg}" id="showImg" width="110px" height="130px" onerror="this.src='<s:url value="/jsp/edu/css/images/up-pic.jpg"/>'"/>
							<span style="cursor: pointer; display:block;">
								[<a onclick="$('#imageFile').click();">${empty user.userHeadImg?'上传头像':'重新上传'}</a>]
							</span>
							<input type="file" id="imageFile" name="headImg" style="display: none" onchange="uploadImage();"/>
							<input type="hidden" id="headimgurl" value=""/>
			        </td>
			    </tr>
			    <tr>
			    	<th>证件类型：</th>
			        <td style="padding-left:10px;">
			        	<select name="userResumeExt.certificateType" class="validate[required] select" style="width: 160px;">
						    <option value="">请选择</option>	
						    <option value="身份证" ${(userResumeExt.certificateType eq '身份证') or (empty userResumeExt.certificateType)?'selected':''}>身份证</option>						 
    					</select>&#12288;&nbsp;<span style="color: red;">*</span>
    				</td>
			        <th>证件号：</th>
			        <td><input name="user.idNo" value="${user.idNo}" class="validate[custom[chinaIdLoose]] input"/></td>     
			    </tr>
			    <tr>
			    	<th>民&#12288;&#12288;族：</th>
			        <td style="padding-left:10px;">
			        	<select name="user.nationName" name="${user.nationName}" class="validate[required] select" style="width: 160px;">
						    <option value="">请选择</option>	
						    <option value="汉族" ${user.nationName eq '汉族'?'selected':''}>汉族</option>
						    <option value="蒙古族" ${user.nationName eq '蒙古族'?'selected':''}>蒙古族</option>
						    <option value="满族" ${user.nationName eq '满族'?'selected':''}>满族</option>
						    <option value="朝鲜族" ${user.nationName eq '朝鲜族'?'selected':''}>朝鲜族</option>
						    <option value="赫哲族" ${user.nationName eq '赫哲族'?'selected':''}>赫哲族</option>
						    <option value="达斡尔族" ${user.nationName eq '达斡尔族'?'selected':''}>达斡尔族</option>
						    <option value="鄂温克族" ${user.nationName eq '鄂温克族'?'selected':''}>鄂温克族</option>
						    <option value="鄂伦春族" ${user.nationName eq '鄂伦春族'?'selected':''}>鄂伦春族</option>
						    <option value="回族" ${user.nationName eq '回族'?'selected':''}>回族</option>
						    <option value="东乡族" ${user.nationName eq '东乡族'?'selected':''}>东乡族</option>
						    <option value="土族" ${user.nationName eq '土族'?'selected':''}>土族</option>
						    <option value="撒拉族" ${user.nationName eq '撒拉族'?'selected':''}>撒拉族</option>
						    <option value="保安族" ${user.nationName eq '保安族'?'selected':''}>保安族</option>
						    <option value="裕固族" ${user.nationName eq '裕固族'?'selected':''}>裕固族</option>
						    <option value="维吾尔族" ${user.nationName eq '维吾尔族'?'selected':''}>维吾尔族</option>
						    <option value="哈萨克族" ${user.nationName eq '哈萨克族'?'selected':''}>哈萨克族</option>
						    <option value="柯尔克孜族" ${user.nationName eq '柯尔克孜族'?'selected':''}>柯尔克孜族</option>
						    <option value="锡伯族" ${user.nationName eq '锡伯族'?'selected':''}>锡伯族</option>
						    <option value="塔吉克族" ${user.nationName eq '塔吉克族'?'selected':''}>塔吉克族</option>
						    <option value="乌孜别克族" ${user.nationName eq '乌孜别克族'?'selected':''}>乌孜别克族</option>
						    <option value="俄罗斯族" ${user.nationName eq '俄罗斯族'?'selected':''}>俄罗斯族</option>
						    <option value="水族" ${user.nationName eq '水族'?'selected':''}>水族</option>
						    <option value="白族" ${user.nationName eq '白族'?'selected':''}>白族</option>
						    <option value="土家族" ${user.nationName eq '土家族'?'selected':''}>土家族</option>							 
    					</select>&nbsp;&#12288;<span style="color: red;">*</span>
    				</td>
			        <th>生&#12288;&#12288;日：</th>
			        <td><input name="user.userBirthday" value="${user.userBirthday}"  class="validate[required] input datepicker" style="width: 149px;"/>&#12288;<span style="color: red;">*</span></td>			        
			    </tr>
			    <tr>
			    	<th>手&#12288;&#12288;机：</th>
			        <td><input name="user.userPhone" value="${user.userPhone}" class="validate[required,custom[mobile]] input"/>&#12288;<span style="color: red;">*</span></td>
			        <th>固定电话：</th>
			        <td><input name="userResumeExt.telephone" value="${userResumeExt.telephone}" class="validate[required,custom[phone2]] input"/>&#12288;<span style="color: red;">*</span></td>			        
			    </tr>
			    <tr>
			    	<th>计算机能力：</th>
			        <td style="padding-left:10px;">
			        	<select name="doctor.computerSkills" class="validate[required] select" style="width: 160px;">
						    <option value="">请选择</option>
						    <option value="一级" ${doctor.computerSkills eq '一级'?'selected':''}>一级</option>							 
						    <option value="二级" ${doctor.computerSkills eq '二级'?'selected':''}>二级</option>							 
						    <option value="三级" ${doctor.computerSkills eq '三级'?'selected':''}>三级</option>							 
						    <option value="其它" ${doctor.computerSkills eq '其它'?'selected':''}>其它</option>							 
    					</select>&nbsp;&#12288;<span style="color: red;">*</span>
    				</td>
			        <th>外语能力：</th>
			        <td style="padding-left:10px;">
			        	<select name="doctor.foreignSkills" class="validate[required] select" style="width: 160px;">
						    <option value="">请选择</option>
						    <option value="四级" ${doctor.foreignSkills eq '四级'?'selected':''}>四级</option>
						    <option value="六级" ${doctor.foreignSkills eq '六级'?'selected':''}>六级</option>
						    <option value="八级" ${doctor.foreignSkills eq '八级'?'selected':''}>八级</option>						 
    					</select>&nbsp;&#12288;<span style="color: red;">*</span>
    				</td>			        
			    </tr>
			    <tr>
			    	<th>电子邮箱：</th>
			        <td colspan="4"><input name="user.userEmail" value="${user.userEmail}" class="validate[required,custom[email]] input" style="width:500px;"/>&#12288;<span style="color: red;">*</span></td>
			    </tr>
			    <tr>
			    	<th>人员类型：</th>
			        <td style="padding-left:10px;">
			        	<select name="userResumeExt.personnelType" class="validate[required] select" style="width: 160px;">
			        		<option value="">请选择</option>	
						    <option value="单位人" ${userResumeExt.personnelType eq '单位人'?'selected':''}>单位人</option>						 
    					</select>&nbsp;&#12288;<span style="color: red;">*</span>
			        </td>
			        <th>工作单位：</th>
			        <td colspan="2"><input name="userResumeExt.workUnit" value="${userResumeExt.workUnit}" class="validate[required] input"/>&#12288;<span style="color: red;">*</span></td>
			    </tr>
			    <tr>
			    	<th>本人通讯地址：</th>
			        <td colspan="4"><input name="user.userAddress" value="${user.userAddress}" class="validate[required] input"  style="width:500px;"/>&#12288;<span style="color: red;">*</span></td>
			    </tr>
			    <tr>
			    	<th>紧急联系人：</th>
			        <td><input name="doctor.emergencyName" value="${doctor.emergencyName}" class="validate[required] input"/>&#12288;<span style="color: red;">*</span></td>
			        <th>紧急联系人手机：</th>
			        <td colspan="2"><input name="doctor.emergencyPhone" value="${doctor.emergencyPhone}" class="validate[required,custom[mobile]] input"/>&#12288;<span style="color: red;">*</span></td>
			    </tr>
			    <tr>
			    	<th>紧急联系人地址：</th>
			        <td colspan="4"><input name="userResumeExt.emergencyAddress" value="${userResumeExt.emergencyAddress}" class="validate[required] input"  style="width:500px;"/>&#12288;<span style="color: red;">*</span></td>
			    </tr>
			 </tbody>
		</table>
	</div>
	<div class="div_table">
		<h4>教育情况</h4>
		<table border="0" cellpadding="0" cellspacing="0" class="base_info">
			<colgroup>
				<col width="14%"></col>
				<col width="36%"></col>
				<col width="14%"></col>
				<col width="36%"></col>
			</colgroup>
			<tbody>
			     <tr>
			    	<th>毕业院校：</th>
			        <td colspan="4"><input name="doctor.graduatedName" value="${doctor.graduatedName}" class="validate[required] input" style="width:500px;"/>&#12288;<span style="color: red;">*</span></td>
			    </tr>
			     <tr>
			    	<th>毕业专业：</th>
			        <td><input name="doctor.specialized" value="${doctor.specialized}" class="validate[required] input"/>&#12288;<span style="color: red;">*</span></td>
			        <th>毕业时间：</th>			    
			        <td colspan="2"><input name="doctor.graduationTime" value="${doctor.graduationTime}" class="validate[required] input datepicker" style="width: 149px;"/>&#12288;<span style="color: red;">*</span></td>
			    </tr>
			    <tr>
			    	<th>最高学历：</th>
			        <td style="padding-left:10px;">
			        	<select name="user.educationId" class="validate[required] select" style="width: 160px;">
						<option value="">请选择</option>
						<c:forEach items="${dictTypeEnumUserEducationList}" var="dict">
							<option value="${dict.dictId}" ${user.educationId eq dict.dictId?'selected':''}>${dict.dictName}</option>
						</c:forEach>
			       		</select>&nbsp;&#12288;<span style="color: red;">*</span>
    				</td>
			        <th>毕业证书编号：</th>
			        <td colspan="2"><input name="doctor.certificateNo" value="${doctor.certificateNo}" class="ivalidate[required] input"/>&#12288;<span style="color: red;">*</span></td>			       
			    </tr>
			    <tr>
			    	<th>最高学位：</th>
			        <td style="padding-left:10px;">
    					<select name="user.degreeId" class="validate[required] select" style="width: 160px;">
							<option value="">请选择</option>
							<c:forEach items="${dictTypeEnumUserDegreeList}" var="dict">
							 <option value="${dict.dictId}" ${user.degreeId eq dict.dictId?'selected':''}>${dict.dictName}</option>
							</c:forEach>
				       	</select>&nbsp;&#12288;<span style="color: red;">*</span>
    				</td>
			        <th>学院证书编号：</th>
			        <td colspan="2"><input name="userResumeExt.collegeCertificateNo" value="${userResumeExt.collegeCertificateNo}" class="validate[required] input"/>&#12288;<span style="color: red;">*</span></td>	      
			    </tr>
			    <tr>
			    	<th>毕业证书：</th>
			        <td>
						<span id="certificateUriSpan" style="display:${!empty userResumeExt.certificateUri?'':'none'} ">
							[<a href="${sysCfgMap['upload_base_url']}/${userResumeExt.certificateUri}" target="_blank">查看图片</a>]&nbsp;
						</span>
						<a id="certificateUri" href="javascript:uploadFile('certificateUri','毕业证书');" class="btn">${empty userResumeExt.certificateUri?'':'重新'}上传</a>&nbsp;
						<a id="certificateUriDel" href="javascript:delFile('certificateUri');" class="btn" style="${empty userResumeExt.certificateUri?'display:none':''}">删除</a>&nbsp;
						<input type="hidden" id="certificateUriValue" name="userResumeExt.certificateUri" value="${userResumeExt.certificateUri}">			        	
    				</td>
			        <th>学位证书：</th>
			        <td colspan="2">
						<span id="degreeUriSpan" style="display:${!empty userResumeExt.degreeUri?'':'none'} ">
							[<a href="${sysCfgMap['upload_base_url']}/${userResumeExt.degreeUri}" target="_blank">查看图片</a>]&nbsp;
						</span>
						<a id="degreeUri" href="javascript:uploadFile('degreeUri','学位证书');" class="btn">${empty userResumeExt.degreeUri?'':'重新'}上传</a>&nbsp;
						<a id="degreeUriDel" href="javascript:delFile('degreeUri');" class="btn" style="${empty userResumeExt.degreeUri?'display:none':''}">删除</a>&nbsp;
						<input type="hidden" id="degreeUriValue" name="userResumeExt.degreeUri" value="${userResumeExt.degreeUri}">			        
			        </td>	      
			    </tr>
			 </tbody>
		</table>
	</div>
	<div class="div_table">	
		<h4>现有资格信息</h4>
		<table border="0" align="center" cellpadding="0" cellspacing="0" class="base_info">
		<colgroup>
				<col width="14%"></col>
				<col width="36%"></col>
				<col width="14%"></col>
				<col width="36%"></col>
			</colgroup>
			<tbody>
			    <tr>
			    	<th>专业技术资格：</th>
			        <td style="padding-left:10px;">
			        	<select name="userResumeExt.technologyQualification" class="validate[required] select" style="width: 160px;">
			        		<option value="">请选择</option>
						    <option value="无" ${userResumeExt.technologyQualification eq '无'?'selected':''}>无</option>							 
						    <option value="有" ${userResumeExt.technologyQualification eq '有'?'selected':''}>有</option>							 
    					</select>&#12288;<span style="color: red;">*</span>
    				</td>
			        <th>取得日期：</th>
			        <td colspan="2">
			        	<input name="userResumeExt.getTechnologyQualificationDate" value="${userResumeExt.getTechnologyQualificationDate}" class="validate[required] input datepicker" style="width: 149px;"/>&#12288;<span style="color: red;">*</span>
    				</td>
			    </tr>
			     <tr>
			    	<th>执业资格材料：</th>
			        <td style="padding-left:10px;">
			        	<select name="userResumeExt.qualificationMaterial" class="validate[required] select" style="width: 160px;">
			        		<option value="">请选择</option>
						    <option value="无" ${userResumeExt.qualificationMaterial eq '无'?'selected':''}>无</option>							 
						    <option value="有" ${userResumeExt.qualificationMaterial eq '有'?'selected':''}>有</option>							 
    					</select>&#12288;<span style="color: red;">*</span>
    				</td>
			        <th>资格材料编码：</th>
			        <td colspan="2"><input name="userResumeExt.qualificationMaterialCode" value="${userResumeExt.qualificationMaterialCode}" class="validate[required] input"/>&#12288;<span style="color: red;">*</span></td>
			    </tr>
			     <tr>
			    	<th>执业类别：</th>
		         	<td style="padding-left:10px;">
			        	<select name="userResumeExt.practicingCategory" class="validate[required] select" style="width: 160px;">
						    <option value="">请选择</option>
						    <option value="无" ${userResumeExt.practicingCategory eq '无'?'selected':''}>无</option>							 
						    <option value="有" ${userResumeExt.practicingCategory eq '有'?'selected':''}>有</option>							 
    					</select>&#12288;<span style="color: red;">*</span>
    				</td>
			    	<th>执业范围：</th>
		         	<td><input name="userResumeExt.practicingScope" value="${userResumeExt.practicingScope}" class="validate[required] input"/>&#12288;<span style="color: red;">*</span></td>
			    </tr>
			  </tbody>
			</table>
		</div>
		</form>
		<div class="btn_info">
			<input type="button" style="width:100px;" class="btn_blue" onclick="saveDoctorInfo();" value="保&#12288;存"></input>
			<c:if test="${param.openType eq 'open'}">
				<input type="button" style="width:100px;" class="btn_blue" onclick="jboxClose();" value="关&#12288;闭"></input>
			</c:if>
		</div>
</div>
