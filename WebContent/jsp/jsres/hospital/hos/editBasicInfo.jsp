<jsp:include page="/jsp/jsres/htmlhead-jsres.jsp">
	<jsp:param name="basic" value="true"/>
	<jsp:param name="jbox" value="true"/>
	<jsp:param name="font" value="true"/>
	<jsp:param name="jquery_validation" value="true"/>
</jsp:include>
<script type="text/javascript" src="<s:url value='/js/ajaxfileupload.js'/>?v=${applicationScope.sysCfgMap['sys_version']}"></script>
<script type="text/javascript">
	function saveBaseInfo(){
	    if(!$("#BaseInfoForm").validationEngine("validate")){
			return false;	
		} 
// 		if($("#professionLicenceUrlValue").val()==""){
// 			$("#indexBody").scrollTop("0px");
// 			return jboxTip("请上传职业许可证!");;
// 		}
// 	    if($("#hospitalLevelLicenceUrlValue").val()==""){
// 			$("#indexBody").scrollTop("0px");
// 			return jboxTip("请上传医院等级照片!");;
// 		}
		jboxPost("<s:url value='/jsres/base/saveBase'/>" , $("#BaseInfoForm").serialize() , function(resp){
			if("${GlobalConstant.SAVE_SUCCESSED}" == resp){
				$("#submitBtn").show();
				setTimeout(function(){
					loadInfo('${GlobalConstant.BASIC_INFO}','${sessionScope.currUser.orgFlow}');
				},1000);
			}
		} , null , true);
	}
	function uploadFile(type,typeName) {
		var url = "<s:url value='/jsres/doctor/uploadFile'/>?operType="+type;
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
   <form id='BaseInfoForm' style="position:relative;">
    <input type="hidden" name="resBase.orgFlow" value="${resBase.orgFlow}"/>
    <input type="hidden" name="baseFlow" value="${sessionScope.currUser.orgFlow}"/>
	<input type="hidden" name="flag" value="${GlobalConstant.BASIC_INFO}"/>
	<div class="main_bd">
		<div class="div_table">
		   <h4>基本信息</h4>
		   <table border="0" cellspacing="0" cellpadding="0" class="base_info">
		   <colgroup>
		     <col width="18%"/>
		     <col width="32%"/>
		     <col width="18%"/>
		     <col width="32%"/>
		   </colgroup>
		   <tbody>
		     <tr>
		       <th>基地名称:</th>
		       <td colspan="3"><input type="text"  class='input validate[required]'  id="orgName" style="width:200px;" name="sysOrg.orgName"value="${sysOrg.orgName}" disabled="disabled"/><span class="red">*</span></td>
		     </tr>
		     <tr>
		       <th>住院医师基地获批文号：</th>
		         <td> 
		         &nbsp;<select style="width:207px;"  class='select validate[required]' name="resBase.resApprovalNumberName"  >
		         <option  value="苏文" >苏文</option>
		         </select>&nbsp;<span class="red">*</span>
		        </td>
		       <th>全科医师基地获批文号：</th>
		       <td>&nbsp;<select  style="width:207px;" class='select validate[required]'  name="resBase.gpsApprovalNumberName"><option  value="苏科">苏科</option></select> &nbsp;<span class="red">*</span></td>
		     </tr>
		      <tr>
		       <th>邮编：</th>
		       <td><input type="text"  style="width:200px;" name="sysOrg.orgZip"  id="orgZip" class='input validate[required,custom[chinaZip]]' value="${sysOrg.orgZip}"/><span class="red">*</span></td>
		       <th>电子邮件：</th>
		       <td><input type="text" style="width:200px;"  name="resBase.email" class=" input validate[required,custom[email]]"  value="${resBase.email}"/><span class="red">*</span></td>
		     </tr>
		     <tr>
		       <th>地址：</th>
		       <td colspan="3"><input type="text"  style="width:200px;"name="sysOrg.orgAddress"  class='input validate[required]'  value="${sysOrg.orgAddress}"/><span class="red">*</span></td>
		     </tr>
		     <tr>
		      <th>职业许可证：</th>
		           <td >
			               <span id="professionLicenceUrlSpan" style="display:${!empty basicInfo.professionLicenceUrl?'':'none'} ">
			              	   &nbsp; [<a href="${sysCfgMap['upload_base_url']}/${basicInfo.professionLicenceUrl}" target="_blank">查看图片</a>]&nbsp;
			            	</span>
			             <c:if test="${resBase.baseStatusId eq baseStatusEnumNotSubmit.id or resBase.baseStatusId eq baseStatusEnumNotPassed.id or empty resBase.baseStatusId  }">
		              		<a id="professionLicenceUrl" href="javascript:uploadFile('professionLicenceUrl','医院等级证书图片');" class="btn">${empty basicInfo.professionLicenceUrl?'':'重新'}上传</a>&nbsp;
		              		<a id="professionLicenceUrlDel" href="javascript:delFile('professionLicenceUrl');" class="btn" style="${empty basicInfo.professionLicenceUrl?'display:none':''}">删除</a>&nbsp;
	              			<input type="hidden" id="professionLicenceUrlValue"  name="basicInfo.professionLicenceUrl" value="${basicInfo.professionLicenceUrl}"></input>
	            		</c:if>
		          </td>
		       <th>医院等级证书：</th>
		           <td>
		           	    <span id="hospitalLevelLicenceUrlSpan" style="display:${!empty basicInfo.hospitalLevelLicenceUrl?'':'none'} ">
		              	    &nbsp; [<a href="${sysCfgMap['upload_base_url']}/${basicInfo.hospitalLevelLicenceUrl}" target="_blank">查看图片</a>]&nbsp;
		            	</span>
		            	<c:if test="${resBase.baseStatusId eq baseStatusEnumNotSubmit.id or resBase.baseStatusId eq baseStatusEnumNotPassed.id or empty resBase.baseStatusId}">
	              		<a id="hospitalLevelLicenceUrl" href="javascript:uploadFile('hospitalLevelLicenceUrl','医院等级证书图片');" class="btn">${empty basicInfo.hospitalLevelLicenceUrl?'':'重新'}上传</a>&nbsp;
	              		<a id="hospitalLevelLicenceUrlDel" href="javascript:delFile('hospitalLevelLicenceUrl');" class="btn" style="${empty basicInfo.hospitalLevelLicenceUrl?'display:none':''}">删除</a>&nbsp;
              			<input type="hidden" id="hospitalLevelLicenceUrlValue"  name="basicInfo.hospitalLevelLicenceUrl" value="${basicInfo.hospitalLevelLicenceUrl}"></input>
		         		</c:if>
		         </td>
		     </tr>
		      <tr>	
		       <th>第一联系人：</th>
		       <td colspan="3"><input type="text"  class='input validate[required]'  name="basicInfo.contactorsList[0].contactorName" style="width:200px;" value="${basicInfo.contactorsList[0].contactorName}"/><span class="red">*</span></td>
		     </tr>
		      <tr>
		       <th>联系人科室：</th>
		       <td><input type="text"  class='input validate[required]'  style="width:200px;" name="basicInfo.contactorsList[0].dept" value="${basicInfo.contactorsList[0].dept}"/><span class="red">*</span></td>
		       <th>联系人职务：</th>
		       <td>
		       &nbsp;<select class="select validate[required]" name="basicInfo.contactorsList[0].job"  style="width:208px;">
		       			<option value="">请选择</option>
				      	<c:forEach items="${dictTypeEnumUserPostList }" var="dict">
					        	<option value="${dict.dictName}"<c:if test="${basicInfo.contactorsList[0].job==dict.dictName }">selected="selected"</c:if>>${dict.dictName}</option>
				        </c:forEach></select><span class="red"  style="margin-left: 4px;">*</span>
		       </td>
		     </tr>
		     <tr>
		       <th>联系人固定电话：</th>
		       <td>
		           <input type="text" class="input validate[required,custom[phone2]]" style="width:200px;" name="basicInfo.contactorsList[0].phone" value="${basicInfo.contactorsList[0].phone}"/><span class="red">*</span></td>
		       <th>联系人手机：</th>
		           <td><input type="text"  class='input validate[required,custom[mobile]] 'style="width:200px;" name="basicInfo.contactorsList[0].mobilephone"  value="${basicInfo.contactorsList[0].mobilephone }"/><span class="red">*</span>
		       </td>
		     </tr>
		     <tr>
		       <th>第二联系人：</th>
		       <td colspan="3">&nbsp;<input type="text" class="input1" style="width:200px;" name="basicInfo.contactorsList[1].contactorName"   value="${basicInfo.contactorsList[1].contactorName}"/> </td>
		     </tr>
		     <tr>
		       <th>联系人科室：</th>
		       <td>&nbsp;<input type="text" class="input1" style="width:200px;" name="basicInfo.contactorsList[1].dept"  value="${basicInfo.contactorsList[1].dept}"/></td>
		       <th>联系人职务：</th>
		       <td>&nbsp;<select class="select" name="basicInfo.contactorsList[1].job" style="width:208px;" >
				      	<option value="">请选择</option>
				      	<c:forEach items="${dictTypeEnumUserPostList }" var="dict">
					        	<option value="${dict.dictName}"<c:if test="${basicInfo.contactorsList[1].job==dict.dictName }">selected="selected"</c:if>>${dict.dictName}</option>
				        </c:forEach>
				    </select>
		     </tr>
		     <tr>
		       <th>联系人固定电话：</th>
		       <td>&nbsp;<input type="text" class="input1 validate[custom[phone2]]" style="width:200px;" name="basicInfo.contactorsList[1].phone"  value="${basicInfo.contactorsList[1].phone}"/></td>
		       <th>联系人手机：</th>
		       <td><input type="text" class="input validate[custom[mobile]]" style="width:200px;" name="basicInfo.contactorsList[1].mobilephone"  value="${basicInfo.contactorsList[1].mobilephone}"/></td>
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
		       <td>&nbsp;<select   class='select validate[required]' style="width:208px;" name="resBase.baseGradeName"><option  value="三级甲等">三级甲等</option></select>&nbsp;<span class="red">*</span></td>
		       <th>基地类型：</th>
		       <td>&nbsp;<select  class='select validate[required]'  style="width:208px;" name="resBase.baseTypeName"><option value="综合医院">综合医院</option></select>&nbsp;<span class="red">*</span></td>
		     </tr>
		      <tr>
		       <th>基地性质：</th>
		       <td>&nbsp;<select   class='select validate[required]' style="width:208px;" name="resBase.basePropertyName"><option value="公立医院">公立医院</option></select>&nbsp;<span class="red">*</span></td>
		       <th>宿舍床位数：</th>
		       <td><input type="text"  class='input validate[required,custom[integer]]' style="width:200px;"  name="basicInfo.bedNumber"value="${basicInfo.bedNumber }"/>张<span class="red">*</span></td>
		     </tr>
		     <tr>
		       <th>获得普通专科培训合格证：</th>
		       <td><input type="text" class='input validate[required,custom[integer]]'style="width:200px;"name="basicInfo.normalTraningNumber" value="${basicInfo.normalTraningNumber }"/>人<span class="red">*</span></td>
		       <th>获得亚专科培训合格证：</th>
		       <td><input type="text"  class='input validate[required,custom[integer]]' style="width:200px;"name="basicInfo.inferiorTrainingNumber" value="${basicInfo.inferiorTrainingNumber }"/>人<span class="red">*</span></td>
		     </tr>
		     <tr>
		       <th>获得全科培训合格证：</th>
		       <td colspan="3"><input type="text"  class='input validate[required,custom[integer]]' style="width:200px;" name="basicInfo.allTrainingNumber"value="${ basicInfo.allTrainingNumber}"/>人 <span class="red">*</span></td>
		     </tr>
		   </tbody>
		   </table>
		</div>
		
		
	</div>
		<div class="btn_info">
				<input class="btn_blue" onclick="saveBaseInfo()" type="button" value="保存"/>
		</div>
		</form>
