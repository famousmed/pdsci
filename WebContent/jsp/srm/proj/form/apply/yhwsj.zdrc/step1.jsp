<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>
<script type="text/javascript" src="<s:url value='/js/ajaxfileupload.js'/>"></script>
<c:if test="${param.view != GlobalConstant.FLAG_Y}">
<script type="text/javascript">
	function nextOpt(step){
		if(false==$("#projForm").validationEngine("validate")){
			return false;
		}
		var form = $('#projForm');
		var action = form.attr('action');
		action+="?nextPageName="+step;
		form.attr("action" , action);
		form.submit();
	}

	function selectSingle(obj) {
		var value = $(obj).val();
		var name = $(obj).attr("name");
		$("input[name="+name+"][value!="+value+"]:checked").attr("checked",false);
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

</script>
</c:if>

	<form action="<s:url value='/srm/proj/mine/saveStep'/>" method="post" style="position: relative;"
		id="projForm">
		<input type="hidden" id="pageName" name="pageName" value="step1" /> 
		<input type="hidden" id="recFlow" name="recFlow" value="${projRec.recFlow}"/>
		<input type="hidden" id="projFlow" name="projFlow" value="${proj.projFlow}"/>
		<input type="hidden" id="recTypeId" name="recTypeId" value="${param.recTypeId}"/>
		
		<input type="hidden" id="userImg" name="userHeadImg" value="${resultMap.userHeadImg}"/>
		
		<font style="font-size: 14px; font-weight:bold;color: #333;">一、个人基本情况</font>
		<table class="basic" style="width: 100%; margin-top: 10px;">
			<tr>
           		<td style="text-align: right;">姓名：</td>
				<td><input type="text" name="userName" value="${resultMap.userName}" class="inputText" style="width: 90%"/></td>
           		<td style="text-align: right;">性别：</td>
				<td>
					<select name="gender" class="inputText" style="width: 90%;">
	                   <option value="">请选择</option>
	                   <c:forEach var="dict" items="${userSexEnumList}">
	                   		<c:if test="${dict.id != userSexEnumUnknown.id}">
	                   			<option value="${dict.name}" <c:if test="${resultMap.gender eq dict.name}">selected="selected"</c:if>>${dict.name}</option>
	                   		</c:if>	 
	                   </c:forEach>
	                </select>
				</td>
           		<td style="text-align: right;">身份证号：</td>
				<td><input type="text" name="idNo" value="${resultMap.idNo}" class="validate[custom[chinaIdLoose]] inputText" style="width: 90%"/></td>
				<td rowspan="5">
					<div style="width: 110px;height: 130px;margin: 5px auto 0px;">
						<img src="${sysCfgMap['upload_base_url']}/${resultMap.userHeadImg}" id="showImg" width="100%" height="100%" onerror="this.src='<s:url value="/jsp/edu/css/images/up-pic.jpg"/>'"/>
					</div>
					<div>
						<span style="cursor: pointer;float: right;">
							[<a onclick="$('#imageFile').click();">${empty resultMap.userHeadImg?'上传头像':'重新上传'}</a>]
						</span>
						<input type="file" id="imageFile" name="headImg" style="display: none" onchange="uploadImage();"/>
					</div>
				</td>
			</tr>
			<tr>
           		<td style="text-align: right;">年龄：</td>
				<td><input type="text" name="age" value="${resultMap.age}" class="validate[custom[integer]] inputText" style="width: 90%"/></td>
           		<td style="text-align: right;">学历：</td>
				<td>
					<select name="education" class="inputText" style="width: 90%;">
	                   <option value="">请选择</option>
	                   <c:forEach var="dict" items="${dictTypeEnumUserEducationList }">
	                   <option value="${dict.dictName}" <c:if test="${resultMap.education eq dict.dictName}">selected="selected"</c:if>>${dict.dictName }</option> 
	                   </c:forEach>
	                </select>
				</td>
           		<td style="text-align: right;">技术职称：</td>
				<td>
					<select name="title" class="inputText" style="width: 90%;">
						<option value="">请选择</option>
						<c:forEach var="dict" items="${dictTypeEnumUserTitleList }">
						<option value="${dict.dictName}" <c:if test="${resultMap.title eq dict.dictName}">selected="selected"</c:if>>${dict.dictName }</option> 
						</c:forEach>
					</select>
				</td>
			</tr>
			<tr>
           		<td style="text-align: right;">学位：</td>
				<td>
					<select name="degree" class="inputText" style="width: 90%;">
						<option value="">请选择</option>
						<c:forEach var="dict" items="${dictTypeEnumUserDegreeList }">
						<option value="${dict.dictName}" <c:if test="${resultMap.degree eq dict.dictName}">selected="selected"</c:if>>${dict.dictName }</option> 
						</c:forEach>
					</select> 
				</td>
           		<td style="text-align: right;">所学专业：</td>
				<td><input type="text" name="major" value="${resultMap.major}" class="inputText" style="width: 90%"/></td>
           		<td style="text-align: right;">行政职务：</td>
				<td><input type="text" name="administrativePost" value="${resultMap.administrativePost}" class="inputText" style="width: 90%"/></td>
			</tr>
			<tr>
				<td style="text-align: right;">出生地：</td>
				<td><input type="text" name="birthAddress" value="${resultMap.birthAddress}" class="inputText" style="width: 90%"/></td>
           		<td style="text-align: right;">政治面貌：</td>
				<td><input type="text" name="political" value="${resultMap.political}" class="inputText" style="width: 90%"/></td>
           		<td style="text-align: right;">从事专业及科室：</td>
				<td><input type="text" name="majorDept" value="${resultMap.majorDept}" class="inputText" style="width: 90%"/></td>
			</tr>
			<tr>
           		<td style="text-align: right;">毕业学校：</td>
				<td colspan="3"><input type="text" name="graduateSchool" value="${resultMap.graduateSchool}" class="inputText" style="width: 90%"/></td>
           		<td style="text-align: right;">毕业时间：</td>
				<td><input type="text" name="graduateTime" value="${resultMap.graduateTime}" onclick="WdatePicker({dateFmt:'yyyy-MM'})" class="inputText ctime" style="width: 120px;"/></td>
			</tr>
			<tr>
           		<td style="text-align: right;">工作单位：</td>
				<td colspan="3"><input type="text" name="orgName" value="${resultMap.orgName}" class="inputText" style="width: 90%"/></td>
           		<td style="text-align: right;">工作时间：</td>
				<td colspan="2"><input type="text" name="workTime" value="${resultMap.workTime}" onclick="WdatePicker({dateFmt:'yyyy-MM'})" class="inputText ctime" style="width: 120px;"/></td>
			</tr>
			<tr>
           		<td style="text-align: right;">通讯地址：</td>
				<td colspan="3"><input type="text" name="address" value="${resultMap.address}" class="inputText" style="width: 90%"/></td>
           		<td style="text-align: right;">邮政编码：</td>
				<td colspan="2"><input type="text" name="zipCode" value="${resultMap.zipCode}" class="validate[custom[chinaZip]] inputText" style="width: 90%"/></td>
			</tr>
			<tr>
           		<td style="text-align: right;">联系电话（手机）：</td>
				<td colspan="3"><input type="text" name="telephone" value="${resultMap.telephone}" class="inputText" style="width: 90%"/></td>
           		<td style="text-align: right;">Email：</td>
				<td colspan="2"><input type="text" name="email" value="${resultMap.email}" class="validate[custom[email]] inputText" style="width: 90%"/></td>
			</tr>
			<tr>
           		<td style="text-align: right;">推荐培养人选：</td>
				<td colspan="6">
					第一梯队人才&nbsp;<input type="checkbox" name="personSelected" value="第一梯队人才" <c:if test="${resultMap.personSelected eq '第一梯队人才'}">checked="checked"</c:if> onchange="selectSingle(this)"/>
					&#12288;第二梯队人才&nbsp;<input type="checkbox" name="personSelected" value="第二梯队人才" <c:if test="${resultMap.personSelected eq '第二梯队人才'}">checked="checked"</c:if> onchange="selectSingle(this)"/>
				</td>
			</tr>
			<tr>
           		<td style="text-align: right;">类别：</td>
				<td colspan="6">
					医疗（
						临床&nbsp;<input type="checkbox" name="category" value="临床" <c:if test="${resultMap.category eq '临床'}">checked="checked"</c:if> onchange="selectSingle(this)"/>
						&#12288;护理&nbsp;<input type="checkbox" name="category" value="护理" <c:if test="${resultMap.category eq '护理'}">checked="checked"</c:if> onchange="selectSingle(this)"/>
						&#12288;医技&nbsp;<input type="checkbox" name="category" value="医技" <c:if test="${resultMap.category eq '医技'}">checked="checked"</c:if> onchange="selectSingle(this)"/>
					）
					&#12288;公卫&nbsp;<input type="checkbox" name="category" value="公卫" <c:if test="${resultMap.category eq '公卫'}">checked="checked"</c:if> onchange="selectSingle(this)"/>
					&#12288;教学&nbsp;<input type="checkbox" name="category" value="教学" <c:if test="${resultMap.category eq '教学'}">checked="checked"</c:if> onchange="selectSingle(this)"/>
					&#12288;管理&nbsp;<input type="checkbox" name="category" value="管理" <c:if test="${resultMap.category eq '管理'}">checked="checked"</c:if> onchange="selectSingle(this)"/>
				</td>
			</tr>
		</table>
	</form>
	
    <c:if test="${param.view!=GlobalConstant.FLAG_Y}">
		<div align="center" style="margin-top: 10px">
		    <input id="nxt" type="button" onclick="nextOpt('step2')" class="search" value="下一步"/>
       	</div>
    </c:if>
   
		