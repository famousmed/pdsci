<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>江苏省住院医师规范化培训管理平台</title>
<jsp:include page="/jsp/jsres/htmlhead-jsres.jsp">
	<jsp:param name="basic" value="true"/>
	<jsp:param name="jbox" value="true"/>
	<jsp:param name="font" value="true"/>
	<jsp:param name="jquery_validation" value="true"/>
	<jsp:param name="jquery_datePicker" value="true"/>
</jsp:include>
<script type="text/javascript">
$(function(){
	$('#trainDate').datepicker();
	showVal();
});

function showVal(){
	var catSpeId = "${doctorRecruit.catSpeId}"
	if(""!= catSpeId){
		changeTrainCategoryType();
	}
	searchResBaseSpeList();
	<c:if test="${jsResDoctorAuditStatusEnumNotSubmit.id eq doctorRecruit.auditStatusId}">
		$("#submitBtn").show();
	</c:if>
}

function changeTrainCategoryType(){
	//$('#trainDate').click(function(e){e.preventDefault();});
	var trainDate = $("#trainDate").val();
	var trainCategoryType = "";
	if (trainDate<'2013-11-01') {
		trainCategoryType = "${trainCategoryTypeEnumBefore2014.id}";
	} else if (trainDate>='2013-11-01') {
		trainCategoryType = "${trainCategoryTypeEnumAfter2014.id}";
	}
	$("#trainCategoryTd").html($("#clone_"+trainCategoryType).html());
	//$('#trainCategoryTd').append($("#clone_"+trainCategoryType).clone());
	var $checked = $("#trainCategoryTd").find("[name='catSpeId'][value='${doctorRecruit.catSpeId}']");
	$checked.attr("checked","checked");
}
/**
 * 关联专业
 */
function searchResBaseSpeList(){
	var catSpeId = $("#editForm input[name='catSpeId']:checked").val();
	//清空原来专业！！！
	$("select[name=speId] option[value != '']").remove();
	if(""==catSpeId){
		return false;
	}
	var orgFlow = "${sessionScope.currUser.orgFlow}";
	var url = "<s:url value='/jsres/doctor/searchResBaseSpeList?orgFlow='/>" + orgFlow +"&speTypeId="+catSpeId;
	jboxPost(url, null, function(resp){
			if("" != resp){
		   		var dataObj = resp;
			    for(var i = 0; i<dataObj.length; i++){
			     	var speId = dataObj[i].speId;
			     	var speName = dataObj[i].speName;
			     	$option =$("<option></option>");
			     	$option.attr("value",speId);
			     	$option.text(speName);
			     	$("select[name=speId]").append($option);
			   }
			   if(""!="${doctorRecruit.speId}"){
				   $("select[name=speId] option[value='${doctorRecruit.speId}']").attr("selected",true);
			   }
			}
		}, null , false);
}


function saveRecruit(auditFlag){
	if(false==$("#editForm").validationEngine("validate")){
		return false;
	}
	var catSpeId = $("input[name=catSpeId]:checked").val();
	var catSpeName = $("input[name=catSpeId]:checked").next().text();
	$("#catSpeName").val(catSpeName);
	var speName = $("select[name=speId] :selected").text();
	$("#speName").val(speName);
	var url = "<s:url value='/jsres/doctor/saveResDoctorRecruit'/>?auditFlag="+auditFlag;
	var data = $("#editForm").serialize();
	if(auditFlag){//提交
		jboxConfirm("确认提交？提交后培训信息将不可修改",  function(){
			jboxPost(url, data, function(resp){
				    if("${GlobalConstant.OPRE_SUCCESSED}" == resp){
				    	window.parent.$(".tab_select").children().text(catSpeName);//更改tag名称
				    	window.parent.viewTrainInfo("${doctorRecruit.recruitFlow}");
				    	setTimeout(function(){
							jboxClose();
						},1000);
				    }
				}, null, true);
		});
	}else{//保存
		jboxPost(url, data, function(resp){
			    if("${GlobalConstant.SAVE_SUCCESSED}" == resp){
		    		window.parent.$(".tab_select").children().text(catSpeName);//更改tag名称
		    		window.parent.viewTrainInfo("${doctorRecruit.recruitFlow}");
			    	$("#submitBtn").show();
			    	/* setTimeout(function(){
						jboxClose();
					},1000); */
			    }
			}, null, true);
	}
}

</script>
</head>
<body>
	<div class="div_table">
        <h4>
        	培训信息
        </h4>
        	<form id="editForm">
        	<input type="hidden" name="recruitFlow" value="${doctorRecruit.recruitFlow}"/>
        	<input type="hidden" name="doctorFlow" value="${sessionScope.currUser.userFlow}"/>
        	<input type="hidden" id="catSpeName" name="catSpeName" value="${doctorRecruit.catSpeName}"/>
        	<input type="hidden" id="speName" name="speName" value="${doctorRecruit.speName}"/>
			<table border="0" cellpadding="0" cellspacing="0" class="base_info">
            <colgroup>
              <col width="15%"/>
              <col width="30%"/>
              <col width="15%"/>
              <col width="40%"/>
            </colgroup>
	           <tbody>
	           <tr>
	               <th>规培起始日期：</th>
	               <td><input type="text" id="trainDate" name="recruitDate" value="${doctorRecruit.recruitDate}" class="validate[required] input" onblur="changeTrainCategoryType();" readonly="readonly" style="margin: 0;"/></td>
	               <th>培训类别：</th>
	               <td id="trainCategoryTd"></td>
	           </tr>
	           <tr>
	               <th>所在地区：</th>
	               <td colspan="3">
		               	<select name="placeId" class="select" style="width: 160px;">
				                <option value="">请选择</option>
				                <c:forEach var="dict" items="${dictTypeEnumDoctorPlaceList}">
				           	 		<option value="${dict.dictId }" ${doctorRecruit.placeId eq dict.dictId?'selected':''}>${dict.dictName }</option> 
				                </c:forEach>
		                </select>
               		</td>
	           </tr>
	           <tr>
	               <th>培训基地：</th>
	               <td>
		               	<select name="orgFlow" class="validate[required] select" style="width: 160px;"onchange="searchResBaseSpeList();">
		               		<option value="">请选择</option>
		               		<c:forEach items="${orgList}" var="org">
		               			<option value="${org.orgFlow}" ${doctorRecruit.orgFlow eq org.orgFlow?'selected':''}>${org.orgName}</option>
		               		</c:forEach>
					    </select>
	               </td>
	               <th class="trainSpe">培训专业：</th>
	               <td>
	               		<select name="speId" class="validate[required] select" style="width: 160px;">
		               		<option value="">请选择</option>
					    </select>
	               </td>
	           </tr>
	           <tr>
	               <th>培养年限：</th>
	               <td>
		               	<select name="trainYear" class="select" style="width: 160px;"  >
		               		<option value="">请选择</option>
						    <option value="一年" ${doctorRecruit.trainYear eq '一年'?'selected':''}>一年</option>
						    <option value="两年" ${doctorRecruit.trainYear eq '两年'?'selected':''}>两年</option>
						    <option value="三年" ${doctorRecruit.trainYear eq '三年'?'selected':''}>三年</option>
					    </select>
	               </td>
	               <th>已培养年限：</th>
	               <td>
	               		<select name="yetTrainYear" class="select" style="width: 160px;" >
	               			<option value="">请选择</option>
		               		<option value="不满一年" ${doctorRecruit.yetTrainYear eq '不满一年'?'selected':''}>不满一年</option>
						    <option value="一年" ${doctorRecruit.yetTrainYear eq '一年'?'selected':''}>一年</option>
						    <option value="两年" ${doctorRecruit.yetTrainYear eq '两年'?'selected':''}>两年</option>
						    <option value="三年" ${doctorRecruit.yetTrainYear eq '三年'?'selected':''}>三年</option>
						    <option value="四年" ${doctorRecruit.yetTrainYear eq '四年'?'selected':''}>四年</option>
						    <option value="五年" ${doctorRecruit.yetTrainYear eq '五年'?'selected':''}>五年</option>
						    <option value="六年" ${doctorRecruit.yetTrainYear eq '六年'?'selected':''}>六年</option>
					    </select>
	               </td>
	           </tr>
	           <tr>
	               <th>医师状态：</th>
	               <td>
	               		<select name="doctorStatusId" class="select" style="width: 160px;">
			                <option value="">请选择</option>
			                <c:forEach var="dict" items="${dictTypeEnumDoctorStatusList}">
			           	 	<option value="${dict.dictId}" ${doctorRecruit.doctorStatusId eq dict.dictId?'selected':''}>${dict.dictName}</option> 
			                </c:forEach>
		                </select>	
				   </td>
	               <th>医师走向：</th>
	               <td>
	               		<select name="doctorStrikeId" class="select" style="width: 160px;">
			                <option value="">请选择</option>
			                <c:forEach var="dict" items="${dictTypeEnumDoctorStrikeList}">
			           	 	<option value="${dict.dictId}" ${doctorRecruit.doctorStrikeId eq dict.dictId?'selected':''}>${dict.dictName}</option> 
			                </c:forEach>
		                </select>
	               </td>
	           </tr>
	           <tr id="graduateTr" style="display: none;">
	               <th>结业时间：</th>
	               <td><input class="validate[required] input" type="text"  id="graduateDate" readonly="readonly" style="margin: 0;"/></td>
	               <th>结业证书编号：</th>
	               <td><input type="text" class="input" style="width: 154px;margin-left: 0;" value=""/></td>
	           </tr>
	           <!-- <tr>
	               <th>备&#12288;&#12288;注：</th>
	               <td colspan="3"><textarea style="width: 568px;height: 100px;border: 1px solid #e7e7eb;margin: 4px 0;"></textarea></td>
	           </tr> -->
	           </tbody>
           </table>
           </form>
		</div>
		
		<div align="center" style="margin-top: 20px; margin-bottom:20px;">
			<c:if test="${empty doctorRecruit.auditStatusId or jsResDoctorAuditStatusEnumNotSubmit.id eq  doctorRecruit.auditStatusId}">
				<input type="button" class="btn_blue" onclick="saveRecruit();" value="保存"/>&nbsp;
				<input type="button" id="submitBtn" class="btn_red" onclick="saveRecruit('${GlobalConstant.FLAG_Y}');" value="提交" style="display: none;"/>&nbsp;
			</c:if>
			<c:if test="${param.openType eq 'open'}">
				<input type="button" class="btn_blue" onclick="jboxClose();" value="关闭"/>&nbsp;
			</c:if>
			<!-- <input type="button" class="btn_blue" onclick="" value="打印"></input> -->
		</div>

		<c:forEach items="${trainCategoryTypeEnumList }" var="trainCategoryType">	
			<span id="clone_${trainCategoryType.id }" style="display: none;">
			<c:forEach items="${trainCategoryEnumList }" var="trainCategory">
			<c:if test="${trainCategory.typeId eq trainCategoryType.id }">
				<label><input type="radio" name="catSpeId" class="validate[required]" value="${trainCategory.id}" onchange="searchResBaseSpeList();"/><span>${trainCategory.name}</span></label>
			</c:if>
			</c:forEach>
			</span>
		</c:forEach>
		
		<c:forEach items="${trainCategoryEnumList }" var="trainCategory">	
			<span id="cloneSpe_${trainCategory.id }" style="display:none ;">
		    <select class="select" name="trainSpe" style="width: 160px;">
		       <option value="">请选择</option>
		       <c:set var="dictName" value="dictTypeEnum${trainCategory.id}List" />
			   <c:forEach items="${applicationScope[dictName]}" var="trainSpe">
			       <option value="${trainSpe.dictId }">${trainSpe.dictName }</option>
			   </c:forEach>
		    </select>
			</span>
		</c:forEach>
</body>
</html>