<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@include file="/jsp/common/doctype.jsp" %>
<html>
<head>
<jsp:include page="/jsp/common/htmlhead.jsp">
	<jsp:param name="basic" value="true"/>
	<jsp:param name="jbox" value="true"/>
	<jsp:param name="jquery_form" value="false"/>
	<jsp:param name="jquery_ui_tooltip" value="true"/>
	<jsp:param name="jquery_ui_combobox" value="false"/>
	<jsp:param name="jquery_ui_sortable" value="false"/>
	<jsp:param name="jquery_cxselect" value="true"/>
	<jsp:param name="jquery_scrollTo" value="false"/>
	<jsp:param name="jquery_jcallout" value="false"/>
	<jsp:param name="jquery_validation" value="true"/>
	<jsp:param name="jquery_datePicker" value="true"/>
	<jsp:param name="jquery_fullcalendar" value="false"/>
	<jsp:param name="jquery_fngantt" value="false"/>
	<jsp:param name="jquery_fixedtableheader" value="true"/>
	<jsp:param name="jquery_placeholder" value="true"/>
	<jsp:param name="jquery_iealert" value="false"/>
</jsp:include>

<script type="text/javascript">
	
</script>
</head>
<body style="overflow: auto;">
   <div style="width: 100%;">
   	<table style="margin-top: 80px;width: 600px;margin-left: auto;margin-right: auto;text-align: center;">
   		<tr>
   			<td style="font-size: 30px;" colspan="2">临床与口腔医学硕士专业学位研究生临床技能训练与考核登记手册</td>
   		</tr>
   		<tr>
   			<td style="font-size: 30px;"  colspan="2">(试行)</td>
   		</tr>
   		<tr><td style="height: 100px;"  colspan="2"></td></tr>
   		<tr>
	   		<td style="font-size: 20px;height: 40px;width: 40%;text-align: right;">培训医院:</td>
	   		<td width="60%">${doctor.orgName}</td>
   		</tr>
   		<tr>
   			<td style="font-size: 20px;height: 40px;width: 40%;text-align: right;">姓&#12288;名:</td>
   			<td>${user.userName}</td>
   		</tr>
   		<tr>
   			<td style="font-size: 20px;height: 40px;width: 40%;text-align: right;">学&#12288;号:</td>
   			<td>xx</td>
   		</tr>
   		<tr>
   			<td style="font-size: 20px;height: 40px;width: 40%;text-align: right;">培训时间:</td>
   			<td>xx</td>
   		</tr>
   		<tr>
   			<td height="200px;" colspan="2"></td>
   		</tr>
   		<tr>
   			<td colspan="2" style="font-size: 17px;font-weight: bold;">南医大</td>
   		</tr>
   	</table>
   </div>
   <div>
   	<table style="margin-top: 100px;width: 80%;text-align: center;margin-left: auto;margin-right: auto;">
   		<tr>
   			<td style="font-size: 30px;">
   				关于《临床学专业学位研究生临床培训登记手册》的编制说明
   			</td>
   		</tr>
   		<tr>
   			<td height="40px;" style="font-size: 15px;text-align: left;">
   				&#12288;&#12288;严格实施《临床学专业学位研究生临床培训登记手册》登记制度是规范培训过程的重要措施。手册所记载内容既是评估研究生培训质量的量化指标，也是培训考核的重要依据。
   			</td>
   		</tr>
   		<tr>
   			<td height="150px;"></td>
   		</tr>
   		<tr>
   			<td style="font-size: 30px;">
   				填写和使用说明
   			</td>
   		</tr>
   		<tr>
   			<td height="40px;" style="font-size: 15px;text-align: left;">
   				一、使用者应按时认真填写手册内所规定的内容。
   			</td>
   		</tr>
   		<tr>
   			<td height="40px;" style="font-size: 15px;text-align: left;">
   				 二、使用者必须及时、客观、详细填写培训内容，严禁弄虚作假，检查或抽查中一旦发现有弄虚作假行为，将按有关规定给予相应处理。

   			</td>
   		</tr>
   		<tr>
   			<td height="40px;" style="font-size: 15px;text-align: left;">
   				三、每一个轮转科室结束时，使用者应先进行个人小结，再由科室负责人按培训细则要求的内容进行检查并签字。
   			</td>
   		</tr>
   		<tr>
   			<td height="40px;" style="font-size: 15px;text-align: left;">
   				四、本手册在培训期间应妥善保存，作为接受培训经历的原始数据资料。
   			</td>
   		</tr>
   		<tr>
   			<td height="40px;" style="font-size: 15px;text-align: left;">
   				五、培训结束时，使用者应如期将此手册交至医院主管部门进行审核再递送学校，登记存档
   			</td>
   		</tr>
   		<tr>
   			<td height="150px;"></td>
   		</tr>
   		<tr style="margin-bottom: 20px;">
   			<td style="font-size: 30px;">
   				培训内容和要求
   			</td>
   		</tr>
   		<tr>
   			<td height="40px;" style="font-size: 17px;text-align: left;font-weight: bold;">
   				一、轮转科室和时间
   			</td>
   		</tr>
   	</table>
   	<table style="width: 80%;margin-left: auto;margin-right: auto;" class="xllist">
   		<tr>
   			<th>
   				序号
   			</th>
   			<th>
   				轮转科室
   			</th>
   			<th>
   				时间(月)
   			</th>
   			<th>
   				年&nbsp;月&nbsp;日&nbsp;-&nbsp;年&nbsp;月&nbsp;日
   			</th>
   			<th>
   				科主任签名
   			</th>
   		</tr>
   		<c:forEach items="${arrResultList }" var="result" varStatus="status">
   			<tr>
   				<td>${status.count}</td>
   				<td>${result.schDeptName}</td>
   				<td>${pdfn:signDaysBetweenTowDate(result.schEndDate,result.schStartDate)}</td>
   				<td>${result.schStartDate} - ${result.schEndDate}</td>
   				<td>${processMap[result.resultFlow].headUserName}</td>
   			</tr>
   		</c:forEach>
   	</table>
   	<table style="width: 80%;text-align: center;margin-left: auto;margin-right: auto;">
   		<tr>
   			<td height="60px;" style="font-size: 17px;text-align: left;font-weight: bold;">
   				二、书写大病例
   			</td>
   		</tr>
   	</table>
   	<table style="width: 80%;margin-left: auto;margin-right: auto;" class="xllist">
   		<tr>
   			<th>
   				病人姓名
   			</th>
   			<th>
   				病例号
   			</th>
   			<th>
   				主要诊断
   			</th>
   			<th>
   				次要诊断
   			</th>
   			<th>
   				轮转科室
   			</th>
   			<th>
   				上级医师签名
   			</th>
   		</tr>
   		<c:forEach items="${recMap[resRecTypeEnumCaseRegistry.id]}" var="rec">
			<tr>
				<td>${recContentMap[rec.recFlow]['patientName']}</td>
				<td>${recContentMap[rec.recFlow]['hospitalNumbers']}</td>
				<td>
					<c:if test="${recContentMap[rec.recFlow]['diagnoseType'] eq '主要诊断'}">
						<img src="<s:url value='/css/skin/${skinPath}/images/gou.gif'/>"/>
					</c:if>
				</td>
				<td>
					<c:if test="${recContentMap[rec.recFlow]['diagnoseType'] eq '次要诊断'}">
						<img src="<s:url value='/css/skin/${skinPath}/images/gou.gif'/>"/>
					</c:if>
				</td>
				<td>${rec.schDeptName}</td>
				<td></td>
			</tr>
   		</c:forEach>
   	</table>
   	<table style="width: 80%;text-align: center;margin-left: auto;margin-right: auto;">
   		<tr>
   			<td height="60px;" style="font-size: 17px;text-align: left;font-weight: bold;">
   				三、各专业病种和基本技能要求
   			</td>
   		</tr>
   	</table>
   	<table style="width: 80%;text-align: center;margin-left: auto;margin-right: auto;">
   		<tr>
   			<td height="60px;" style="font-size: 17px;text-align: left;font-weight: bold;">
   				${dept.schDeptName}
   			</td>
   		</tr>
   	</table>
   	<table style="width: 80%;text-align: center;margin-left: auto;margin-right: auto;">
   		<tr>
   			<td height="60px;" style="font-size: 17px;text-align: left;font-weight: bold;">
   				${dept.schDeptName}手术和操作技能的要求与实际完成情况
   			</td>
   		</tr>
   	</table>
   	<table style="width: 80%;margin-left: auto;margin-right: auto;" class="xllist">
   		<tr>
   			<th>操作及手术</th>
   			<th>职务</th>
   			<th>要求例数</th>
   			<th>完成数量</th>
   			<th>审核数量</th>
   		</tr>
   		<c:forEach items="${reqMap[resRecTypeEnumOperationRegistry.id]}" var="req">
   			<tr>
   				<td>
   					${req.itemName}
   				</td>
   				<td></td>
   				<c:set value="${req.recTypeId}${req.itemId}req" var="reqKey"/>
   				<c:set value="${req.recTypeId}${req.itemId}finish" var="finishKey"/>
   				<c:set value="${req.recTypeId}${req.itemId}audit" var="auditKey"/>
   				<td>${countMap[reqKey]+0}</td>
   				<td>${countMap[finishKey]+0}</td>
   				<td>${countMap[auditKey]+0}</td>
   			</tr>
   		</c:forEach>
   		<c:forEach items="${reqMap[resRecTypeEnumSkillRegistry.id]}" var="req">
   			<tr>
   				<td>
   					${req.itemName}
   				</td>
   				<td></td>
   				<c:set value="${req.recTypeId}${req.itemId}req" var="reqKey"/>
   				<c:set value="${req.recTypeId}${req.itemId}finish" var="finishKey"/>
   				<c:set value="${req.recTypeId}${req.itemId}audit" var="auditKey"/>
   				<td>${countMap[reqKey]+0}</td>
   				<td>${countMap[finishKey]+0}</td>
   				<td>${countMap[auditKey]+0}</td>
   			</tr>
   		</c:forEach>
   	</table>
   	<table style="width: 80%;text-align: center;margin-left: auto;margin-right: auto;">
   		<tr>
   			<td height="60px;" style="font-size: 17px;text-align: left;font-weight: bold;">
   				${dept.schDeptName}基本技能操作记录
   			</td>
   		</tr>
   	</table>
   	<table style="width: 80%;margin-left: auto;margin-right: auto;" class="xllist">
   		<tr>
   			<th>序号</th>
   			<th>操作日期</th>
   			<th>病人姓名</th>
   			<th>病例号</th>
   			<th>操作名称</th>
   			<th>成功/失败</th>
   			<th>备注</th>
   		</tr>
   		<c:forEach items="${recMap[resRecTypeEnumSkillRegistry.id]}" var="rec" varStatus="status">
   			<tr>
   				<td>${status.count}</td>
   				<td>${recContentMap[rec.recFlow]['operateDate']}</td>
   				<td>${recContentMap[rec.recFlow]['patientName']}</td>
   				<td>${recContentMap[rec.recFlow]['caseNo']}</td>
   				<td>${rec.itemName}</td>
   				<td>${recContentMap[rec.recFlow]['failReason']}</td>
   				<td>${recContentMap[rec.recFlow]['remark']}</td>
   			</tr>
   		</c:forEach>
   	</table>
   		<table style="width: 80%;text-align: center;margin-left: auto;margin-right: auto;">
   		<tr>
   			<td height="60px;" style="font-size: 17px;text-align: left;font-weight: bold;">
   				参加${dept.schDeptName}培训教学活动登记表(病例讨论、主任查房、专题讲座等)
   			</td>
   		</tr>
   	</table>
   	<table style="width: 80%;margin-left: auto;margin-right: auto;" class="xllist">
   		<tr>
   			<th>序号</th>
   			<th>日期</th>
   			<th>活动形式</th>
   			<th>学时</th>
   			<th>主讲人</th>
   			<th>主持人签字</th>
   		</tr>
   		<c:forEach items="${recMap[resRecTypeEnumCampaignRegistry.id]}" var="rec" varStatus="status">
   			<tr>
   				<td rowspan="2">${status.count}</td>
   				<td>${recContentMap[rec.recFlow]['activeDate']}</td>
   				<td>${recContentMap[rec.recFlow]['activeType']}</td>
   				<td>${recContentMap[rec.recFlow]['classHour']}</td>
   				<td>${recContentMap[rec.recFlow]['lecturer']}</td>
   				<td></td>
   			</tr>
   			<tr>
   				<td>内容</td>
   				<td colspan="4">${recContentMap[rec.recFlow]['activeDetail']}</td>
   			</tr>
   		</c:forEach>
   	</table>
   	<table style="width: 80%;text-align: center;margin-left: auto;margin-right: auto;">
   		<tr>
   			<td height="60px;" style="font-size: 17px;text-align: left;font-weight: bold;">
   				${dept.schDeptName}出科鉴定
   			</td>
   		</tr>
   	</table>
   	<table style="width: 80%;text-align: center;margin-left: auto;margin-right: auto;">
   		<tr>
   			<td height="60px;" style="font-size: 17px;text-align: left;font-weight: bold;">
   				综合科
   			</td>
   		</tr>
   	</table>
   	<table style="width: 80%;text-align: center;margin-left: auto;margin-right: auto;">
   		<tr>
   			<td colspan="2" style="text-align: left;border: solid black 1px;">
   				${recContentMap[recMap[resRecTypeEnumAfterSummary.id][0].recFlow]['personalSummary']}
   			</td>
   		</tr>
   		<tr>
   			<td style="width: 50%;height: 60px;border: solid black 1px;">
   				科室评语
   			</td>
   			<td width="50%" style="border: solid black 1px;">
   				${recContentMap[recMap[resRecTypeEnumAfterSummary.id][0].recFlow]['deptAppraise']}
   			</td>
   		</tr>
   		<tr>
   			<td style="width: 50%;height: 60px;border: solid black 1px;">
   				科主任签名
   			</td>
   			<td style="border: solid black 1px;">
   				${recContentMap[recMap[resRecTypeEnumAfterSummary.id][0].recFlow]['deptHeadAutograth']}
   			</td>
   		</tr>
   	</table>
   </div>
   <div style="height: 100px;"></div>
</body>
</html>