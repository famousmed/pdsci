<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<script type="text/javascript">
	String.prototype.htmlFormart = function(){
		var html = this;
		for(var index in arguments){
			var reg = new RegExp('\\{'+index+'\\}','g');
			html = html.replace(reg,arguments[index]);
		}
		return html;
	};
	
	function toOut(historyData,sexName,userPhone,orgFlow,speName){
		var data = eval('('+historyData+')');
		var doctorName = data.doctorName;
		jboxOpenContent($("#toOutConfirm").html().htmlFormart(doctorName,historyData,sexName,userPhone,orgFlow,speName),"转出医师",700,300);
	}
	
	function turnOut(historyData,orgFlow,orgName,trainingSpeId,turnOutDate){
		if(historyData){
			jboxConfirm("确认将<font color='red'>"+historyData.doctorName+"</font>转至<font color='red'>"+orgName+"</font>？",function(){
				historyData.orgFlow = orgFlow;
				historyData.orgName = orgName;
				historyData.trainingSpeId = trainingSpeId;
				historyData.turnOutDate = turnOutDate;
				historyData.changeStatusId = "${schStatusEnumSubmit.id}";
				historyData.changeStatusName = "${schStatusEnumSubmit.name}";
				historyData.outDate = "${pdfn:getCurrDate()}";
				jboxPost("<s:url value='/res/manager/docOrgHisEdit'/>",historyData,function(resp){
					if(resp=="${GlobalConstant.OPRE_SUCCESSED_FLAG}"){
						jboxTip("${GlobalConstant.OPRE_SUCCESSED}");
						search();
						jboxContentClose();
					}
				},null,false);
			},null);
		}
	}
	
	function cancelTurnOut(recordFlow,doctorName){
		jboxConfirm("确认取消<font color='red'>"+doctorName+"</font>的培训变更？",function(){
			jboxPost("<s:url value='/res/manager/docOrgHisEdit'/>",{recordFlow:recordFlow,recordStatus:"${GlobalConstant.RECORD_STATUS_N}"},function(resp){
				if(resp=="${GlobalConstant.OPRE_SUCCESSED_FLAG}"){
					jboxTip("${GlobalConstant.OPRE_SUCCESSED}");
					search();
				}
			},null,false);
		},null);
	}
	
	function auditTurnIn(doctorFlow,doctorName,recordFlow,orgFlow,historyOrgName,historyTrainingSpeName,trainingSpeName,outDate,
			sessionNumber,sexName,orgName,inOrgName,idNo,doctorLicense,educationName,trainingYears,userPhone){
		jboxGet("<s:url value='/res/manager/rotationList'/>",{orgFlow:orgFlow},function(resp){
			var willInConfirmHtml = $($("#willInConfirm").html().htmlFormart(doctorName,doctorFlow,recordFlow,historyOrgName,historyTrainingSpeName,trainingSpeName,outDate,sessionNumber,sexName,orgName,inOrgName,idNo,doctorLicense,educationName,trainingYears,userPhone));
			if(resp.length){
				for(var index in resp){
					var option = '<option value="'+resp[index].rotationFlow+'">'+resp[index].rotationName+'</option>';
					willInConfirmHtml.find("#newRotation").append(option);
				} 
			}else{
				willInConfirmHtml.find("#newRotation").append('<option/>');
			}
			jboxOpenContent(willInConfirmHtml,"转入审核",800,400);
		},null,false);
	}
	
	function agreeTurnIn(doctorFlow,recordFlow,rotationFlow){
		jboxConfirm("同意转入该医师？",function(){
			jboxGet("<s:url value='/res/manager/agreeTurnIn'/>",{doctorFlow:doctorFlow,recordFlow:recordFlow,rotationFlow:rotationFlow},function(resp){
				if(resp=="${GlobalConstant.OPRE_SUCCESSED_FLAG}"){
					jboxTip("${GlobalConstant.OPRE_SUCCESSED}");
					search();
					jboxContentClose();
				}
			},null,false);
		},null);
	}
</script>
<style>
	table.basic th,table.basic td{padding: 0px;text-align: center;}
	table.basic a{color: blue;cursor: pointer;}
</style>
<div style="width: 100%;height: 100%;">
	<table class="basic" style="width:100%;">
		<tr>
			<th>姓名</th>
			<th>届数</th>
			<th>性别</th>
			<c:if test="${param.type eq 'toOut'}">
				<th style="width: 150px;">学员单位</th>
				<th style="width: 150px;">培训基地</th>
			</c:if>
			<th style="width: 150px;">身份证</th>
			<th style="line-height: 20px;">类型<br/>(中医、西医)</th>
			<th>学历</th>
			<c:if test="${param.type eq 'toOut'}">
				<th>专业</th>
			</c:if>
			<c:if test="${param.type eq 'willIn' || param.type eq 'isIn'}">
				<th>转出医院</th>
				<th>转入专业</th>
			</c:if>
			<c:if test="${param.type eq 'outing' || param.type eq 'isOut'}">
				<th>转出专业</th>
				<th>转入医院</th>
			</c:if>
			<th>培训年限</th>
			<th style="line-height: 20px;">是否<br/>执业医师</th>
			<th style="width: 100px;">手机</th>
			<th>操作</th>
		</tr>
		<c:forEach items="${doctorList}" var="doctor">
			<tr>
				<td>${doctor.doctorName}</td>
				<td>${doctor.sessionNumber}</td>
				<td>${userMap[doctor.doctorFlow].sexName}</td>
				<c:if test="${param.type eq 'toOut'}">
					<td>${userMap[doctor.doctorFlow].orgName}</td>
					<td>${doctor.orgName}</td>
				</c:if>
				<td>${userMap[doctor.doctorFlow].idNo}</td>
				<td></td>
				<td>${userMap[doctor.doctorFlow].educationName}</td>
				<c:if test="${param.type eq 'toOut'}">
					<td>${doctor.trainingSpeName}</td>
				</c:if>
				<c:set var="key" value="${doctor.doctorFlow}${doctor.orgFlow}"/>
<%-- 				<c:if test="${!(param.type eq 'toOut')}"> --%>
<%-- 					<td><c:out value="${okDocOrgHisMap[key].trainingSpeName}" default="${nkDocOrgHisMap[key].trainingSpeName}"/></td> --%>
<%-- 					<td><c:out value="${okDocOrgHisMap[key].historyTrainingSpeName}" default="${nkDocOrgHisMap[key].historyTrainingSpeName}"/></td> --%>
<%-- 				</c:if> --%>
				<c:if test="${param.type eq 'willIn' || param.type eq 'isIn'}">
					<td style="line-height: 20px;">${okDocOrgHisMap[key].historyOrgName}<br/>${okDocOrgHisMap[key].historyTrainingSpeName}</td>
					<td>${okDocOrgHisMap[key].trainingSpeName}</td>
				</c:if>
				<c:if test="${param.type eq 'outing' || param.type eq 'isOut'}">
					<td>${nkDocOrgHisMap[key].historyTrainingSpeName}</td>
					<td style="line-height: 20px;">${nkDocOrgHisMap[key].orgName}<br/>${nkDocOrgHisMap[key].trainingSpeName}</td>
				</c:if>
				<td>${doctor.trainingYears}</td>
				<td>${(doctor.doctorLicenseFlag eq GlobalConstant.FLAG_Y)?'是':'否'}</td>
				<td>${userMap[doctor.doctorFlow].userPhone}</td>
				<td>
					<c:if test="${param.type eq 'toOut'}">
						<a onclick="toOut('{doctorFlow:\'${doctor.doctorFlow}\',doctorName:\'${doctor.doctorName}\',historyOrgFlow:\'${doctor.orgFlow}\',historyOrgName:\'${doctor.orgName}\',historyTrainingSpeId:\'${doctor.trainingSpeId}\',historyTrainingSpeName:\'${doctor.trainingSpeName}\'}','${userMap[doctor.doctorFlow].sexName}','${userMap[doctor.doctorFlow].userPhone}','${doctor.orgName}','${doctor.trainingSpeName}');">转出</a>
					</c:if>
					<c:if test="${param.type eq 'outing'}">
						<a onclick="cancelTurnOut('${okDocOrgHisMap[key].recordFlow}','${doctor.doctorName}');">取消变更</a>
					</c:if>
					<c:if test="${param.type eq 'willIn'}">
						<a onclick="auditTurnIn('${doctor.doctorFlow}','${doctor.doctorName}','${okDocOrgHisMap[key].recordFlow}','${okDocOrgHisMap[key].orgFlow}','${okDocOrgHisMap[key].historyOrgName}','${okDocOrgHisMap[key].historyTrainingSpeName}','${okDocOrgHisMap[key].trainingSpeName}','${okDocOrgHisMap[key].outDate}','${doctor.sessionNumber}','${userMap[doctor.doctorFlow].sexName}','${doctor.orgName}','${okDocOrgHisMap[key].orgName}','${userMap[doctor.doctorFlow].idNo}','${(doctor.doctorLicenseFlag eq GlobalConstant.FLAG_Y)?'是':'否'}','${userMap[doctor.doctorFlow].educationName}','${doctor.trainingYears}','${userMap[doctor.doctorFlow].userPhone}');">审核</a>
					</c:if>
					<c:if test="${param.type eq 'isIn'|| param.type eq 'isOut'}">
						<a>查看</a>
					</c:if>
				</td>
			</tr>
		</c:forEach>
		<c:if test="${empty doctorList}">
			<tr>
				<td colspan="99">无记录</td>
			</tr>
		</c:if>
	</table>
	
	<div id="toOutConfirm" style="display: none;">
		<table class="basic" style="width: 100%;margin-bottom: 10px;">
			<tr>
				<th style="width: 20%;">姓名：</th>
				<td style="width: 30%;">{0}</td>
				<th style="width: 20%;">性别：</th>
				<td style="width: 30%;">{2}</td>
			</tr>
			<tr>
				<th>联系方式：</th>
				<td colspan="3">{3}</td>
			</tr>
			<tr>
				<th>原机构：</th>
				<td>{4}</td>
				<th>转入机构：</th>
				<td>
					<select id="targetOrg" style="width: 150px;">
						<c:forEach items="${applicationScope.sysOrgList}" var="org">
							<c:if test="${!(sessionScope.currUser.orgFlow eq org.orgFlow)}">
								<option value="${org.orgFlow}">${org.orgName}</option>
							</c:if>
						</c:forEach>
					</select>
				</td>
			</tr>
			<tr>
				<th>原专业：</th>
				<td>{5}</td>
				<th>转入专业：</th>
				<td>
					<select id="newSpeId" style="width: 150px;">
						<option/>
						<c:forEach items="${dictTypeEnumDoctorTrainingSpeList}" var="dict">
							<option value="${dict.dictId}">${dict.dictName}</option>
						</c:forEach>
					</select>
				</td>
			</tr>
			<tr>
				<th>转出日期：</th>
				<td colspan="3">
					<input id="turnOutDate" type="text" readonly="readonly" onclick="WdatePicker('yyyy-MM-dd');" style="width: 145px;"/>
				</td>
			</tr>
		</table>
		<div style="width: 100%;" align="center">
			<input type="button" value="转出" class="search" onclick="window.parent.document.mainIframe.turnOut({1},$('#targetOrg').val(),$('#targetOrg :selected').text(),$('#newSpeId').val(),$('#turnOutDate').val());"/>
			<input type="button" value="关闭" class="search" onclick="jboxContentClose();"/>
		</div>
	</div>
	<div id="willInConfirm" style="display: none;">
		<table class="basic" style="width: 100%;margin-bottom: 10px;">
			<tr>
				<th style="width: 20%;">姓名：</th>
				<td style="width: 30%;">{0}</td>
				<th style="width: 20%;">届数：</th>
				<td style="width: 30%;">{7}</td>
			</tr>
			<tr>
				<th>性别：</th>
				<td>{8}</td>
				<th>学员机构：</th>
				<td>{9}</td>
			</tr>
			<tr>
				<th>原机构：</th>
				<td>{3}</td>
				<th>转入机构：</th>
				<td>{10}</td>
			</tr>
			<tr>
				<th>身份证：</th>
				<td>{11}</td>
				<th>是否执业医师：</th>
				<td>{12}</td>
			</tr>
			<tr>
				<th>类型：</th>
				<td></td>
				<th>学历：</th>
				<td>{13}</td>
			</tr>
			<tr>
				<th>原专业：</th>
				<td>{4}</td>
				<th>转入专业：</th>
				<td>{5}</td>
			</tr>
			<tr>
				<th>培训年限：</th>
				<td>{14}</td>
				<th>联系方式：</th>
				<td>{15}</td>
			</tr>
			<tr>
				<th>转出时间：</th>
				<td>{6}</td>
				<th>转入时间：</th>
				<td><input type="text" value="${pdfn:getCurrDate()}" style="width: 150px;" readonly="readonly" onclick="WdatePicker({dateFmt:'yyyy-MM-dd'});"/></td>
			</tr>
			<tr>
				<th>轮转方案：</th>
				<td colspan="3">
					<select id="newRotation" style="width: 150px;"></select>
				</td>
			</tr>
		</table>
		<div style="width: 100%;" align="center">
			<input type="button" value="同意转入" class="search" onclick="window.parent.document.mainIframe.agreeTurnIn('{1}','{2}',$('#newRotation').val());"/>
			<input type="button" value="关闭" class="search" onclick="jboxContentClose();"/>
		</div>
	</div>
</div>
