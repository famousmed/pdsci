<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<jsp:include page="/jsp/sczyres/htmlhead-sczyres.jsp">
	<jsp:param name="jquery_cxselect" value="true"/>
	<jsp:param name="jquery_scrollTo" value="true"/>
	<jsp:param name="jquery_validation" value="true"/>
	<jsp:param name="jquery_datePicker" value="true"/>
</jsp:include>
<style>
.base_info th,.base_info td{height:45px;}
</style>
<script type="text/javascript" src="<s:url value='/js/ajaxfileupload.js'/>?v=${applicationScope.sysCfgMap['sys_version']}"></script>
<script>
String.prototype.htmlFormartById = function(data){
	var html = this;
	for(var key in data){
		var reg = new RegExp('\\{'+key+'\\}','g');
		html = html.replace(reg,data[key]);
	}
	return html;
};

$(document).ready(function(){
	//单位人展示为信息
	if ("${doctor.doctorTypeId}" != "") {
		$(".active").click();
// 		doctorType("${doctor.doctorTypeId}");
	}
	//工作经历默认一条空白记录
	//<c:if test="${empty extInfo.workResumeList}">
	//	add('work');
	//</c:if>
	
	$('.datepicker').datepicker(); 
	
// 	$("#pmoremessage,#contactway,#work").toggle();
	showYszz($("input[name='doctor.doctorLicenseFlag']:checked").val()=='${GlobalConstant.FLAG_Y}');

});

function doctorType(doctorTypeId,active){
	$(".active").removeClass();
	$(active).addClass("active");
	$("#doctorTypeId").val(doctorTypeId);
	$("#agencyDiv").toggle("${sczyRecDocTypeEnumAgency.id}" == doctorTypeId);
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

function add(tb){
	$("#add_a").remove();
	var cloneTr = $("#"+tb+"Template tr:eq(0)").clone();
	var index = $("#"+tb+"Tb tr").length;
	cloneTr.html(cloneTr.html().htmlFormartById({"index":index}));
 	$("#"+tb+"Tb").append(cloneTr);
 	$('.datepicker').datepicker();
}

function delTr(tb){
	var checkboxs = $("input[name='"+tb+"Ids']:checked");
	if(checkboxs.length==0){
		jboxTip("请勾选要删除的！");
		return false;
	}
	jboxConfirm("确认删除?",function () {
		var trs = $('#'+tb+'Tb').find(':checkbox:checked');
		$.each(trs , function(i , n){
			$(n).parent('td').parent("tr").remove();
		});
		
		var reg = new RegExp('\\[\\d+\\]','g');
		$("#"+tb+"Tb tr").each(function(i){
			$("[name]",this).each(function(){
				this.name = this.name.replace(reg,"["+i+"]");
			});
		});
	});
}

function uploadFile(type,typeName) {
	jboxOpen("<s:url value='/inx/sczyres/uploadFile'/>?operType="+type,"上传"+typeName,450,150);
}

function delFile(type) {
	jboxConfirm("确认删除？" , function(){
		$("#"+type+"Del").hide();
		$("#"+type+"Span").hide();
		$("#"+type).text("上传");
		$("#"+type+"Value").val("");
	});
	
}

function getRecruit(){
	jboxLoad("content" , "<s:url value='/sczyres/doctor/getrecruit'/>" , true);
	$("#indexBody").scrollTo('.bd_bg',500, { offset:{ top:0} } );
}

function submitSingup(){
	if(!$("#doctorTypeId").val()){
		$("#indexBody").scrollTop("0px");
		return jboxTip("请选择人员类型！");
	}
	if(!$("#doctorForm").validationEngine("validate")){
		return false;
	}
	if($('${user.userHeadImg}'=="" &&"#headimgurl").val()==""){
		jboxTip("请上传头像照片!");
		return false;
	}
	if(!$("#idNoUriValue").val()){
		jboxTip("请上传身份证图片");
		return false;
	}
	if(!$("#certificateUriValue").val()){
		jboxTip("请上传毕业证书");
		return false;
	}
	if($("input[name='doctor.doctorLicenseFlag']:checked").val()=="Y" && !$("#qualifiedUriValue").val()){
		jboxTip("请上传医师资格证书编号");
		return false;
	}
	if($("input[name='doctor.doctorLicenseFlag']:checked").val()=="Y" && !$("#regUriValue").val()){
		jboxTip("请上传医师执业证书");
		return false;
	}
	$("#birthProvName").val($("#birthProvId :selected").text());
	$("#birthCityName").val($("#birthCityId :selected").text());
	$("#birthAreaName").val($("#birthAreaId :selected").text());
	if($("#doctorTypeId").val() != "${sczyRecDocTypeEnumAgency.id}"){
		$("#dispatchFileFValue,[name='doctor.workOrgName']").val("");
	}else {
		if(!$("#dispatchFileFValue").val()){
			//jboxTip("请上传委培单位同意证明!");
			//return false;
		}
	}
	jboxPost("<s:url value='/sczyres/doctor/submitSingup'/>" , $("#doctorForm").serialize() , function(resp){
		if(resp=="1"){
			getRecruit();
		}else{
			jboxTip(resp);
		}
	} , null , false);
}

function saveSingup(){
	if(!$("#doctorTypeId").val()){
		$("#indexBody").scrollTop("0px");
		return jboxTip("请选择人员类型！");
	}
	if($("#userName").validationEngine("validate")){
		$("#indexBody").scrollTop("0px");
		return false;
	}
	$("#birthProvName").val($("#birthProvId :selected").text());
	$("#birthCityName").val($("#birthCityId :selected").text());
	$("#birthAreaName").val($("#birthAreaId :selected").text());
	if($("#doctorTypeId").val() != "${sczyRecDocTypeEnumAgency.id}"){
		$("#dispatchFileFValue,[name='doctor.workOrgName']").val("");
	}
	jboxPost("<s:url value='/sczyres/doctor/submitSingup'/>" , $("#doctorForm").serialize() , function(resp){
		if(resp=="1"){
			jboxTip("保存成功");
		}else{
			jboxTip(resp);
		}
	} , null , false);
}

function toggleDetailInfo(){
	$("#pmoremessage,#contactway,#work").toggle();
}
function showYszz(isShow){
	if(isShow){
		$(".yszz").show();
		$("#zgzs").html("*");
		$("#qualifiedNo").addClass("validate[required]"); 
	}else {
		$(".yszz").hide();
		$("#zgzs").html("");
		$("#qualifiedNo").removeClass("validate[required]"); 
	}
}
</script>
<div id="singupContent">
<div id='docTypeForm'>
    <p id="errorMsg" style="color: red;"></p>
    <div class="main_hd"><h2 class="underline">网上报名</h2></div>
    <form id='doctorForm' style="position:relative;">
    <input type="hidden" name="user.userFlow" value="${user.userFlow}"/>
    <input id="doctorTypeId" type="hidden" name="doctor.doctorTypeId" value="${doctor.doctorTypeId}"/>
    <div class="main_bd">
       <div class="div_table">
          <div class="score_frame">
            
            <h1>信息填写<!-- <span class="fr writemore"><a id="writeopen" onclick="toggleDetailInfo();">填写详细信息</a></span> --></h1>
            
            <div class="sub_menu">
              <h3>人员类型选择：</h3>
              <ul class="ryxz">
              	<c:forEach items="${sczyRecDocTypeEnumList}" var="doctorType">
              		<li 
              			<c:if test="${doctorType.id eq doctor.doctorTypeId}">class="active"</c:if>
              		  onclick="doctorType('${doctorType.id}',this);"><a>${doctorType.name}</a></li>
			   </c:forEach>
              </ul>
            </div>
            
            <div class="div_table">
                <h4>基本信息</h4>
                <table border="0" cellpadding="0" cellspacing="0" class="base_info">
            <colgroup>
              <col width="12%"/>
              <col width="22%"/>
              <col width="12%"/>
              <col width="22%"/>
              <col width="12%"/>
              <col width="20%"/>
            </colgroup>
	           <tbody>
	               <tr>
	                   <th><font color="red">*</font>姓名：</th>
	                   <td><input type='text' class='input validate[required]' id="userName" name="user.userName" value="${user.userName}"/></td>
	                   <th><font color="red">*</font>出生日期：</th>
	                   <td colspan="2"><input type='text' class='input validate[required] datepicker' name="user.userBirthday" value="${user.userBirthday}" readonly="readonly"/></td>
	                   <td rowspan="3" style="text-align: center;padding-top:5px;">
							<img src="${sysCfgMap['upload_base_url']}/${user.userHeadImg}" id="showImg" width="110px" height="130px" onerror="this.src='<s:url value="/jsp/edu/css/images/up-pic.jpg"/>'"/>
							<span style="cursor: pointer; display:block;">
								[<a onclick="$('#imageFile').click();">${empty user.userHeadImg?'上传头像':'重新上传'}</a>]
							</span>
							<input type="file" id="imageFile" name="headImg" style="display: none" onchange="uploadImage();"/>
							<input type="hidden" id="headimgurl" value=""/>
	                   </td>
	               </tr>	               
	               <tr>
	                   <th><font color="red">*</font>性别：</th>
	                   <td style="padding-left: 10px;">
	                   	<label>
	                       <input type="radio" class='validate[required]' style="width:auto;" name="user.sexId" value='${userSexEnumMan.id}' ${user.sexId eq userSexEnumMan.id?'checked':''}/>${userSexEnumMan.name}
	                   	</label>
                           &nbsp;
                           <label>
                           <input type="radio" class='validate[required]' style="width:auto;" name="user.sexId" value='${userSexEnumWoman.id}' ${user.sexId eq userSexEnumWoman.id?'checked':''}/>${userSexEnumWoman.name}
                           </label>
	                   </td>
	                   <th>籍贯：</th>
	                   <td colspan="2"><input type='text' class='input ' name="extInfo.nativePlace" value="${extInfo.nativePlace}"/></td>
	               </tr>	               
	               <tr>
	                   <th>民族：</th>
	                   <td><input type='text' class='input ' name="user.nationName" value="${user.nationName}"/></td>
	                   <th>健康状况：</th>
	                   <td colspan="2"><input type='text' class='input ' name="extInfo.healthStatus" value="${extInfo.healthStatus}"/></td>
	               </tr>
	             </tbody>
	             <tbody ID="pmoremessage">               
	               <tr>
	                   <th>政治面貌：</th>
	                   <td><input type='text' class='input ' name="extInfo.political" value="${extInfo.political}"/></td>
	                   <th>婚姻状况：</th>
	                   <td><input type='text' class='input ' name="extInfo.maritalStatus" value="${extInfo.maritalStatus}"/></td>
	                   <th>既往病史：</th>
	                   <td><input type='text' class='input ' name="extInfo.beforeCase" value="${extInfo.beforeCase}"/></td>
	               </tr>               
	               <tr>
	                   <th>外语水平：</th>
	                   <td><input type='text' class='input ' name="doctor.foreignSkills" value="${doctor.foreignSkills}"/></td>
	                   <th><font color="red">*</font>最高学历：</th>
	                   <td>
	                  	   <select name="user.educationId" class="select validate[required]" style="width: 160px;margin-left: 5px;">
						       <option></option>
						       <c:forEach items="${dictTypeEnumUserEducationList}" var="dict">
							       <option value="${dict.dictId}" ${user.educationId eq dict.dictId?'selected':''}>${dict.dictName}</option>
						       </c:forEach>
					       </select>
	                   </td>
	                   <th>现工作单位：</th>
	                   <td><input type='text' class='input ' name="extInfo.societyWork" value="${extInfo.societyWork}"/></td>
	               </tr>	               
	               <tr>
	                   <th><font color="red">*</font>毕业专业：</th>
	                   <td><input type='text' class='input validate[required]' name="doctor.specialized" value="${doctor.specialized}"/></td>
	                   <th><font color="red">*</font>学位：</th>
	                   <td>
	                  	   <select name="user.degreeId" class='select validate[required]' style="width: 160px;margin-left: 5px;">
						       <option></option>
						       <c:forEach items="${dictTypeEnumUserDegreeList}" var="dict">
							       <option value="${dict.dictId}" ${user.degreeId eq dict.dictId?'selected':''}>${dict.dictName}</option>
						       </c:forEach>
					       </select>
	                   </td>
	                   <th><font color="red">*</font>有无医师执照：</th>
	                   <td style="padding-left: 10px;">
	                   	   <label><input type="radio" class='validate[required]' name="doctor.doctorLicenseFlag" onclick="showYszz(true);" value="${GlobalConstant.FLAG_Y}" 
	                   	   	<c:if test="${doctor.doctorLicenseFlag eq GlobalConstant.FLAG_Y}">checked</c:if>
	                   	   />有</label>
                           &nbsp;
                           <label><input type="radio" class='validate[required]' name="doctor.doctorLicenseFlag" onclick="showYszz(false);" value="${GlobalConstant.FLAG_N}" 
                           	<c:if test="${doctor.doctorLicenseFlag eq GlobalConstant.FLAG_N}">checked</c:if>
                           />无</label>
	                   </td>
	               </tr>	               
	               <tr>
	               	   <th><font color="red">*</font>毕业院校：</th>
	                   <td colspan="3"><input type='text' class='input validate[required]' style="width: 300px;"  name="doctor.graduatedName" value="${doctor.graduatedName}"/></td>
	               	   <th><font color="red">*</font>最高学历毕业时间：</th>
	                   <td><input type='text' class='input validate[required] datepicker'   name="doctor.graduationTime" value="${doctor.graduationTime}"/></td>
	               </tr>	               
	               <tr>
	               	   <th><font color="red">*</font>身份证号：</th>
	                   <td colspan="3"><input type='text' class='input validate[required]' style="width: 300px;" name="user.idNo" value="${user.idNo}"/></td>
	                   <th><font color="red">*</font>是否应届生：</th>
	                   <td style="padding-left: 10px;">
	                   	    <label><input type="radio" class='validate[required]' name="extInfo.yearGraduateFlag" value="${GlobalConstant.FLAG_Y}" 
	                   	   	<c:if test="${extInfo.yearGraduateFlag eq GlobalConstant.FLAG_Y}">checked</c:if>
	                   	   />是</label>
                           &nbsp;
                           <label><input type="radio" class='validate[required]' name="extInfo.yearGraduateFlag" value="${GlobalConstant.FLAG_N}" 
                           	<c:if test="${extInfo.yearGraduateFlag eq GlobalConstant.FLAG_N}">checked</c:if>
                           />否</label>
	                   </td>
	               </tr>	               
	               <tr>
	               	   <th><font color="red">*</font>规培生源地：</th>
	                   <td colspan="5">
							<div id="provCityAreaId" style="padding-left: 5px;">
								<select id="birthProvId" name="extInfo.birthProvId" style="width: 159px" class="province select validate[required]" data-value="${extInfo.birthProvId}" data-first-title="选择省"></select>
								<select id="birthCityId" name="extInfo.birthCityId" class="city select validate[required]" data-value="${extInfo.birthCityId}" data-first-title="选择市"></select>
								<select id="birthAreaId" name="extInfo.birthAreaId" class="area select validate[required]" data-value="${extInfo.birthAreaId}" data-first-title="选择地区"></select>
							</div>
							<input id="birthProvName" name="extInfo.birthProvName" type="hidden" value="${extInfo.birthProvName}">
							<input id="birthCityName" name="extInfo.birthCityName" type="hidden" value="${extInfo.birthCityName}">
							<input id="birthAreaName" name="extInfo.birthAreaName" type="hidden" value="${extInfo.birthAreaName}">
							<script type="text/javascript">
								// 提示：如果服务器不支持 .json 类型文件，请将文件改为 .js 文件 
								$.cxSelect.defaults.url = "<s:url value='/js/provCityAreaJson.min.json'/>"; 
								$.cxSelect.defaults.nodata = "none"; 
	
								$("#provCityAreaId").cxSelect({ 
								    selects : ["province", "city", "area"], 
								    nodata : "none",
									firstValue : ""
								}); 
							</script>
	                   </td>
	               </tr>	               		
	               <tr>
	               	   <th><font color="red">*</font>家庭住址 ：</th>
	                   <td><input type='text' class='input validate[required]' name="extInfo.homeAddress" value="${extInfo.homeAddress}"/></td>
	                   <th><font color="red">*</font>家庭电话 ：</th>
	                   <td><input type='text' class='input validate[required]' name="extInfo.homePhome" value="${extInfo.homePhome}"/></td>
	                   <th><font color="red">*</font>邮编 ：</th>
	                   <td><input type='text' class='input validate[required]' name="extInfo.zipCode" value="${extInfo.zipCode}"/></td>
	               </tr>
	           </tbody>
              </table>
              </div>
              
            <div class="div_table" ID="contactway">
			<h4>本人联系方式</h4>
	        <table border="0" cellpadding="0" cellspacing="0" class="base_info">
	            <colgroup>
	              <col width="12%"/>
	              <col width="22%"/>
	              <col width="12%"/>
	              <col width="54%"/>
	            </colgroup>
		           <tbody>
		               <tr>
		                   <th><font color="red">*</font>手机号码：</th>
	                   	   <td><input type='text' class='input validate[required]' name="user.userPhone" value="${user.userPhone}" /></td>
		                   <th><font color="red">*</font>通讯地址：</th>
	                   	   <td><input type='text' class='input validate[required]' name="user.userAddress" value="${user.userAddress}" style="width: 400px;"/></td>
		               </tr>
		               <tr>
		                   <th><font color="red">*</font>E-mail：</th>
	                   	   <td><input type='text' class='input' name="user.userEmail" value="${user.userEmail}" readonly="readonly"/></td>
		                   <th>其它方式：</th>
	                   	   <td><input type='text' class='input' name="extInfo.otherWay" value="${extInfo.otherWay}" style="width: 400px;"/></td>
		               </tr>
		           </tbody>
		       </table>
		      </div>
              
            <div class="div_table" ID="work">
			<h4>工作（实习）经历</h4>
	         <table border="0" cellpadding="0" cellspacing="0" class="grid">
	         	<colgroup>
	         		<col width="5%"/>
					<col width="15%"/>
					<col width="10%"/>
					<col width="10%"/>
					<col width="10%"/>
					<col width="10%"/>
					<col width="10%"/>
					<col width="10%"/>
					<col width="10%"/>
					<col width="10%"/>
					</colgroup>
					<tr>
						<th colspan="10" style="text-align: left;">
							<span style="float: right;padding-right: 20px">
								<img class="opBtn" title="新增" src="<s:url value="/css/skin/${skinPath}/images/add3.png" />" style="cursor: pointer;" onclick="add('work')"></img>&#12288;
								<img class="opBtn" title="删除"  style="cursor: pointer;" src="<s:url value='/css/skin/${skinPath}/images/del1.png'/>" onclick="delTr('work');"></img>
							</span>
						</th>
					</tr>
					<tr style="font-weight: bold;">
					  <td></td>
		              <td><font color="red">*</font>临床工作<br/>起止时间</td>
		              <td>时间长度</td>
		              <td><font color="red">*</font>医院名称</td>
		              <td>医院级别</td>
		              <td>科室</td>
		              <td>职务</td>
		              <td>证明人</td>
		              <td>证明人<br/>现任何职</td>
		              <td>证明人<br/>联系电话</td>
		           </tr>
					<tbody id="workTb">
					    <c:if test='${empty extInfo.workResumeList}'>
					        <tr id="add_a">
					            <td colspan="10" >点击<a href="javascript:add('work')">此处</a>或右上角新增图标添加记录</td>
					        </tr>
					    </c:if>
				      	<c:forEach var="resume" items="${extInfo.workResumeList}" varStatus="status">
							<tr>
								<td><input type="checkbox" name="workIds"/></td> 
								<td>
									<input type='text' class='validate[required] input' name="extInfo.workResumeList[${status.index}].clinicalRoundDate" placeholder="开始-结束时间" value="${resume.clinicalRoundDate}" style="width: 100px;" />
								</td>
								<td>
									<input type='text' class='input' name="extInfo.workResumeList[${status.index}].dateLength" value="${resume.dateLength}" style="width: 50px;"/>
								</td>
								<td>
									<input type='text' class='validate[required] input' name="extInfo.workResumeList[${status.index}].hospitalName" value="${resume.hospitalName}" style="width: 110px;"/>
								</td>
								<td>
									<input type='text' class='input' name="extInfo.workResumeList[${status.index}].hospitalLevel" value="${resume.hospitalLevel}" style="width: 50px;"/>
								</td>
								<td>
									<input type='text' class='input' name="extInfo.workResumeList[${status.index}].deptName" value="${resume.deptName}" style="width: 80px;"/>
								</td>
								<td>
									<input type='text' class='input' name="extInfo.workResumeList[${status.index}].postName" value="${resume.postName}" style="width: 50px;"/>
								</td>
								<td>
									<input type='text' class='input' name="extInfo.workResumeList[${status.index}].witness" value="${resume.witness}" style="width: 50px;"/>
								</td>
								<td>
									<input type='text' class='input' name="extInfo.workResumeList[${status.index}].witnessPost" value="${resume.witnessPost}" style="width: 50px;"/>
								</td>
								<td>
									<input type='text' class='input' name="extInfo.workResumeList[${status.index}].witnessPhone" value="${resume.witnessPhone}" style="width: 80px;"/>
								</td>
							</tr>
				      	</c:forEach>
				      </tbody>
	        </table>
	        </div>
             
             
           <div class="div_table">
				<h4>证书及文件</h4>
		        <table border="0" cellpadding="0" cellspacing="0" class="base_info">
		        
		           <tr>
			          <th  width="20%"><font color="red">*</font>身份证图片：</th>
			          <td colspan="3">
			          	<span id="idNoUriSpan" style="display:${!empty extInfo.idNoUri?'':'none'} ">
		              	      [<a href="${sysCfgMap['upload_base_url']}/${extInfo.idNoUri}" target="_blank">查看图片</a>]&#12288;
		            	  </span>
	              		  <a id="idNoUri" href="javascript:uploadFile('idNoUri','身份证图片');" class="btn">${empty extInfo.idNoUri?'':'重新'}上传</a>&#12288;
	              		  <a id="idNoUriDel" href="javascript:delFile('idNoUri');" class="btn" style="${empty extInfo.idNoUri?'display:none':''}">删除</a>&#12288;
              			  <input type="hidden" id="idNoUriValue" name="extInfo.idNoUri" value="${extInfo.idNoUri}">
			          </td>
			       </tr> 
			       <tr>
			          <th><font color="red">*</font>毕业证编号：</th>
			          <td colspan="3">
			          	<input type="text" class="input validate[required]" placeholder="请填写毕业证编号" style="width: 300px;" name="doctor.certificateNo" value='${doctor.certificateNo}'/>
			          
			              <span id="certificateUriSpan" style="display:${!empty extInfo.certificateUri?'':'none'} ">
		              	      [<a href="${sysCfgMap['upload_base_url']}/${extInfo.certificateUri}" target="_blank">查看图片</a>]&#12288;
		            	  </span>
	              		  <a id="certificateUri" href="javascript:uploadFile('certificateUri','毕业证书');" class="btn">${empty extInfo.certificateUri?'':'重新'}上传扫描件</a>&#12288;
	              		  <a id="certificateUriDel" href="javascript:delFile('certificateUri');" class="btn" style="${empty extInfo.certificateUri?'display:none':''}">删除</a>&#12288;
              			  <input type="hidden" id="certificateUriValue" name="extInfo.certificateUri" value="${extInfo.certificateUri}">
			          </td>
			       </tr> 
			       <tr>
			          <th>学位证编号：</th>
			          <td colspan="3"><input type='text' placeholder="请填写学位证编号" style="width: 300px;" class="input" name="doctor.degreeNo" value='${doctor.degreeNo}'/>
			              <span id="degreeUriSpan" style="display:${!empty extInfo.degreeUri?'':'none'} ">
		              	      [<a href="${sysCfgMap['upload_base_url']}/${extInfo.degreeUri}" target="_blank">查看图片</a>]&#12288;
		            	  </span>
	              		  <a id="degreeUri" href="javascript:uploadFile('degreeUri','学位证书');" class="btn">${empty extInfo.degreeUri?'':'重新'}上传扫描件</a>&#12288;
	              		  <a id="degreeUriDel" href="javascript:delFile('degreeUri');" class="btn" style="${empty extInfo.degreeUri?'display:none':''}">删除</a>&#12288;
              			  <input type="hidden" id="degreeUriValue" name="extInfo.degreeUri" value="${extInfo.degreeUri}">
			          </td>
			       </tr> 
			       <tr>
			          <th><font color="red" id="zgzs"></font>医师资格证书编号：</th>
			          <td colspan="3"><input type='text'  placeholder="请填写医师资格证书编号" style="width: 300px;" class="input " id="qualifiedNo" name='doctor.qualifiedNo' value='${doctor.qualifiedNo}'/>
			              <span id="qualifiedUriSpan" style="display:${!empty extInfo.qualifiedUri?'':'none'} ">
		              	      [<a href="${sysCfgMap['upload_base_url']}/${extInfo.qualifiedUri}" target="_blank">查看图片</a>]&#12288;
		            	  </span>
	              		  <a id="qualifiedUri" href="javascript:uploadFile('qualifiedUri','医师资格证');" class="btn">${empty extInfo.qualifiedUri?'':'重新'}上传扫描件</a>&#12288;
	              		  <a id="qualifiedUriDel" href="javascript:delFile('qualifiedUri');" class="btn" style="${empty extInfo.qualifiedUri?'display:none':''}">删除</a>&#12288;
              			  <input type="hidden" id="qualifiedUriValue" name="extInfo.qualifiedUri" value="${extInfo.qualifiedUri}">
			          </td>
			       </tr>     
			       <tr class="yszz">
			          <th><font color="red">*</font>医师执业证书编号：</th>
			          <td colspan="3"><input type='text' placeholder="请填写医师执业证书编号" style="width: 300px;" class="input validate[required]" name="doctor.regNo" value='${doctor.regNo}'/>
			              <span id="regUriSpan" style="display:${!empty extInfo.regUri?'':'none'} ">
		              	      [<a href="${sysCfgMap['upload_base_url']}/${extInfo.regUri}" target="_blank">查看图片</a>]&#12288;
		            	  </span>
	              		  <a id="regUri" href="javascript:uploadFile('regUri','医师执业证');" class="btn">${empty extInfo.regUri?'':'重新'}上传扫描件</a>&#12288;
	              		  <a id="regUriDel" href="javascript:delFile('regUri');" class="btn" style="${empty extInfo.regUri?'display:none':''}">删除</a>&#12288;
              			  <input type="hidden" id="regUriValue" name="extInfo.regUri" value="${extInfo.regUri}">
			          </td>
			       </tr>   
			    </table>
			</div>
             
            <div class="div_table" style="display: none;" id="agencyDiv">
				<h4>单位信息</h4>
		        <table border="0" cellpadding="0" cellspacing="0" class="base_info">
			       <tr>
			          <th width="34%"><font color="red">*</font>工作单位：</th>
			          <td width="66%">
			          	<input type="text" name="doctor.workOrgName" class="input validate[required]" value="${doctor.workOrgName}" style="width: 293px;"/>
			          </td>
			       </tr> 
			       <tr>
			          <th>委培单位同意证明(图片)：</th>
			          <td style="padding-left: 10px;">
			          	<span id="dispatchFileFSpan" style="display:${!empty doctor.dispatchFile?'':'none'} ">
		              	[<a href="${sysCfgMap['upload_base_url']}/${doctor.dispatchFile}" target="_blank">查看图片</a>]&#12288;
		            	</span>
	              		<a id="dispatchFileF" href="javascript:uploadFile('dispatchFileF','委培单位同意证明');" class="btn">${empty doctor.dispatchFile?'':'重新'}上传</a>&#12288;
	              		<a id="dispatchFileFDel" href="javascript:delFile('dispatchFileF');" class="btn" style="${empty doctor.dispatchFile?'display:none':''}">删除</a>&#12288;
              			<input type="hidden" id="dispatchFileFValue" name="doctor.dispatchFile" value="${doctor.dispatchFile }">
			          </td>
			       </tr>        
			    </table>
			</div>
              
          </div>
       </div>
    </div>
        
	<div id="nextPage" class="button" style="margin: 30px;">
	    <input class="btn_blue" type="button" onclick="saveSingup();" value="暂&#12288;存"/>
        <input class="btn_blue" type="button" onclick="submitSingup();" value="下一步"/>
    </div>
    </form>
</div>
<div style="display: none">
		<!-- 工作经历模板 -->
		<table id="workTemplate">
       		<tr>
				<td><input type="checkbox" name="workIds"/></td>
				<td>
					<input type='text' class='validate[required] input ' placeholder="开始-结束时间" name="extInfo.workResumeList[{index}].clinicalRoundDate" value="" style="width: 100px;"/>
				</td>
				<td>
					<input type='text' class='input' name="extInfo.workResumeList[{index}].dateLength" value="" style="width: 50px;"/>
				</td>
				<td>
					<input type='text' class='validate[required] input' name="extInfo.workResumeList[{index}].hospitalName" value="" style="width: 100px;"/>
				</td>
				<td>
					<input type='text' class='input' name="extInfo.workResumeList[{index}].hospitalLevel" value="" style="width: 80px;"/>
				</td>
				<td>
					<input type='text' class='input' name="extInfo.workResumeList[{index}].deptName" value="" style="width: 80px;"/>
				</td>
				<td>
					<input type='text' class='input' name="extInfo.workResumeList[{index}].postName" value="" style="width: 50px;"/>
				</td>
				<td>
					<input type='text' class='input' name="extInfo.workResumeList[{index}].witness" value="" style="width: 50px;"/>
				</td>
				<td>
					<input type='text' class='input' name="extInfo.workResumeList[{index}].witnessPost" value="" style="width: 80px;"/>
				</td>
				<td>
					<input type='text' class='input' name="extInfo.workResumeList[{index}].witnessPhone" value="" style="width: 80px;"/>
				</td>
			</tr>
		</table>
	</div>
</div>
