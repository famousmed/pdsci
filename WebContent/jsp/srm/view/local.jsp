<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
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
	<jsp:param name="jquery_cxselect" value="false"/>
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
<script type="text/javascript" defer="defer">
</script>
<script type="text/javascript">
function changeTb(){
	  var type = $("#items").val();
	  $("#"+type).show();
	  if(type=="ky"){
	    $("#xk").hide();
	    $("#rc").hide();
	  }else if(type=="xk"){
		$("#ky").hide();
		$("#rc").hide();  
	  }else if(type=="rc"){
		$("#ky").hide();
	    $("#xk").hide();   
	  }
 }
</script>
</head>
<body>
<div class="mainright">
	<div class="content">
		<div class="title1 clearfix">
			<div style="width: 100%;">
						<table  class="xllist nofix" style="width: 100%">
							<tr>
								<th  colspan="3" style="text-align: left;">&#12288;常用操作</th>
							</tr>
							<tbody>								
								<tr>
									<td class="bs_mod viewTd" align="left" >
										<div style="float: left;padding-top:10px;padding-bottom: 10px;">
											<div align="left" style="padding-left: 10px;float: left;cursor: pointer;">
												<img  src="<s:url value="/css/skin/${skinPath}/images/index_proj_city.png" />" onclick="window.location.href='<s:url value='/srm/proj/apply/list/local/ky?recTypeId=Apply'/>'">
											</div>
											<div align="left" style=";margin-top: 5px;width: 220px">
												<b style="font-size: 16px;"><a href="javascript:window.location.href='<s:url value='/srm/proj/apply/list/local/ky?recTypeId=Apply'/>'">项目审核</a></b><br/>
												申报项目审核
											</div>
										</div>
										<div style="float: left;padding-top:10px;padding-bottom: 10px;">
											<div align="left" style="padding-left: 10px;float: left;cursor: pointer;">
												<img  src="<s:url value="/css/skin/${skinPath}/images/index_contract.png" />" onclick="window.location.href='<s:url value='/srm/proj/contract/list/local/ky?recTypeId=Contract'/>'"> 
											</div>
											<div align="left" style=";margin-top: 5px;width: 220px">
												<b style="font-size: 16px;"><a href="javascript:window.location.href='<s:url value='/srm/proj/contract/list/local/ky?recTypeId=Contract'/>'">合同审核</a></b><br/>
												申报项目合同审核
											</div>
										</div>
										<div style="float: left;padding-top:10px;padding-bottom: 10px;">
											<div align="left" style="padding-left: 10px;float: left;cursor: pointer;">
												<img  src="<s:url value="/css/skin/${skinPath}/images/index_user.png" />" onclick="window.location.href='<s:url value='/sys/user/list/local?statusId=${userStatusEnumReged.id }'/>'">
											</div>
											<div align="left" style=";margin-top: 5px;width: 220px">
												<b style="font-size: 16px;"><a href="<s:url value='/sys/user/list/local?statusId=${userStatusEnumReged.id }'/>">人员激活</a></b><br/>
												注册人员审核、激活
											</div>
										</div>
										<div style="float: left;padding-top:10px;padding-bottom: 10px;">
											<div align="left" style="padding-left: 10px;float: left;cursor: pointer;">
												<img  src="<s:url value="/css/skin/${skinPath}/images/index_talent.png" />" onclick="window.location.href='<s:url value='/srm/aid/talents/list/local'/>'">
											</div>
											<div align="left" style=";margin-top: 5px;width: 220px">
												<b style="font-size: 16px;"><a href="<s:url value='/srm/aid/talents/list/local'/>">人才专项<br>资金审批</a></b><br/>
												人才专项资金申请审批
											</div>
										</div>
										<div style="float: left;padding-top:10px;padding-bottom: 10px;">
											<div align="left" style="padding-left: 10px;float: left;cursor: pointer;">
												<img  src="<s:url value="/css/skin/${skinPath}/images/index_org.png" />" onclick="window.location.href='<s:url value='/sys/org/info'/>'">
											</div>
											<div align="left" style=";margin-top: 5px;width: 220px">
												<b style="font-size: 16px;"><a href="javascript:window.location.href='<s:url value='/sys/org/info'/>'">机构信息</a></b><br/>
												填写机构详细信息
											</div>
										</div>
									</td>
								</tr>		
							</tbody>													
						</table>
					</div>
			<div style="width:100%; margin-top: 10px;margin-bottom: 10px;">
					<div style="width:59%;float: left;margin-bottom: 10px;" align="left">
						<table width="100%"  class="xllist">
							<tr>
							<th colspan="3" style="text-align: left;">&#12288;待办事项
							  <select id="items" onchange="changeTb()">
								    <option value="ky" selected="selected">科研项目</option>
								    <option value="xk">重点学科</option>
								    <option value="rc">重点人才</option> 
								 </select>
							</th>
							</tr>
							<tbody id="ky">								
								           <c:if test="${empty resultMap_ky}">
								           <tr>
											 <td style="text-align: left;padding-left: 30px;color: red;" >
												科研项目目前没有待办理的业务!
											 </td>
										   </tr>	
									       </c:if>
									       <c:if test="${not empty resultMap_ky.apply}">
										     <tr>
										       <td style="text-align: left;padding-left: 20px;"> 
										                                 您有<font color="red">${resultMap_ky.apply }</font>个项目申请报告待处理，请点击 <a href="<s:url value='/srm/proj/apply/list/local/ky?recTypeId=Apply'/>" style="color: red;">这里</a>&#12288;进入,如需查询更多项目，请点击"项目查询"功能!
										       </td>
										     </tr>
										   </c:if>
										   
										    <c:if test="${not empty resultMap_ky.contract}">
										     <tr>
										       <td style="text-align: left;padding-left: 20px">
										                                 您有<font color="red">${resultMap_ky.contract }</font>个项目合同待处理，请点击 <a href="<s:url value='/srm/proj/contract/list/local/ky?recTypeId=Contract'/>" style="color: red;">这里</a>&#12288;进入！
										        </td>
										     </tr>
										   </c:if>
										   <c:if test="${not empty resultMap_ky.scheduleReport}">
										     <tr>
										       <td style="text-align: left;padding-left: 20px">
										                                  您有<font color="red">${resultMap_ky.scheduleReport }</font>个项目进展报告待处理，请点击 <a href="<s:url value='/srm/proj/schedule/list/local/ky?recTypeId=ScheduleReport'/>" style="color: red;">这里</a>&#12288;进入！
										       </td>
										     </tr>
										   </c:if>
										   <c:if test="${not empty resultMap_ky.changeReport}">
										       <tr>
										         <td style="text-align: left;padding-left: 20px">               
										                                     您有<font color="red">${resultMap_ky.changeReport }</font>个项目变更报告待处理，请点击 <a href="<s:url value='/srm/proj/schedule/list/local/ky?recTypeId=ChangeReport'/>" style="color: red;">这里</a>&#12288;进入！
										         </td>
										       </tr>
										   </c:if>
										   <c:if test="${not empty resultMap_ky.completeReport}">
										        <tr>
										          <td style="text-align: left;padding-left: 20px">
										                                        您有<font color="red">${resultMap_ky.completeReport }</font>个项目验收报告待处理，请点击 <a href="<s:url value='/srm/proj/complete/list/local/ky?recTypeId=CompleteReport'/>" style="color: red;">这里</a>&#12288;进入！
										          </td>
										         </tr>
										   </c:if>
										   <c:if test="${not empty resultMap_ky.terminateReport}">
										       <tr>
										         <td style="text-align: left;padding-left: 20px">
										                                        您有<font color="red">${resultMap_ky.terminateReport }</font>个项目中止报告待处理，请点击 <a href="<s:url value='/srm/proj/terminate/list/local/ky?recTypeId=TerminateReport'/>" style="color: red;">这里</a>&#12288;进入！
									              </td>
									            </tr>
									       </c:if>
										   <!-- 如果当前是医院版本 -->
										  <c:if test="${applicationScope.sysCfgMap['srm_for_use']=='local' }">
										  
										  <c:if test="${not empty resultMap_ky.approveEva}">
										     <tr>
										       <td style="text-align: left;padding-left: 20px">
										                                  您有<font color="red">${resultMap_ky.approveEva}</font>个项目立项评审待处理，请点击 <a href="<s:url value='/srm/proj/evaluation/approveList/local/ky'/>" style="color: red;">这里</a>&#12288;进入！
										       </td>
										     </tr>
										   </c:if>
										   
										    <c:if test="${not empty resultMap_ky.approve}">
										     <tr>
										       <td style="text-align: left;padding-left: 20px">
										                                您有<font color="red">${resultMap_ky.approve }</font>个项目立项审批待处理，请点击 <a href="<s:url value='/srm/proj/approve/list/local/ky'/>" style="color: red;">这里</a>&#12288;进入！
										       </td>
										     </tr>
										   </c:if>
										   
										   <c:if test="${not empty resultMap_ky.dealBudgetAuditCount}">
										     <tr>
										       <td style="text-align: left;padding-left: 20px">
										                                您有<font color="red">${resultMap_ky.dealBudgetAuditCount }</font>个预算审核待处理，请点击 <a href="<s:url value='/srm/fund/scheme/auditList/local'/>" style="color: red;">这里</a>&#12288;进入！
										       </td>
										     </tr>
										   </c:if>
										   
										   <c:if test="${not empty resultMap_ky.dealPaymentAuditCount}">
										     <tr>
										       <td style="text-align: left;padding-left: 20px">
										                                您有<font color="red">${resultMap_ky.dealPaymentAuditCount }</font>个报销审核待处理，请点击 <a href="<s:url value='/srm/payment/auditList'/>" style="color: red;">这里</a>&#12288;进入！
										       </td>
										     </tr>
										   </c:if>
										   
										   
										     <c:if test="${not empty resultMap_ky.completeEva}">
										     <tr>
										       <td style="text-align: left;padding-left: 20px">
										                                您有<font color="red">${resultMap_ky.completeEva }</font>个项目验收评审待处理，请点击 <a href="<s:url value='/srm/proj/evaluation/completeList/local/ky'/>" style="color: red;">这里</a>&#12288;进入！
										       </td>
										     </tr>
										   </c:if>
										   
										   <c:if test="${not empty resultMap_ky.archive}">   
										      <tr>
										       <td style="text-align: left;padding-left: 20px">
										                                您有<font color="red">${resultMap_ky.archive }</font>个项目验收审批待处理，请点击 <a href="<s:url value='/srm/proj/archive/list/local/ky'/>" style="color: red;">这里</a>&#12288;进入！
										       </td>
										      </tr>
										   </c:if>
										  </c:if>
										  <!-- 医院版本特殊功能结束 -->
							</tbody>
							 <!-- 重点学科待办事项 -->
								<tbody id="xk" style="display: none;">
								     <c:if test="${empty resultMap_xk}">							
										<tr>
											<td style="text-align: left;padding-left: 30px; color: red;" >
												重点学科目前没有待办理的业务!
											</td>
										</tr>	
									</c:if>
									<!-- 医院版特殊功能 -->
									 <c:if test="${applicationScope.sysCfgMap['srm_for_use']=='local' }">
									      <c:if test="${not empty resultMap_xk.approveEva}">
										     <tr>
										       <td style="text-align: left;padding-left: 20px">
										                                  您有<font color="red">${resultMap_xk.approveEva}</font>个项目立项评审待处理，请点击 <a href="<s:url value='/srm/proj/evaluation/approveList/local/xk'/>" style="color: red;">这里</a>&#12288;进入！
										       </td>
										     </tr>
										   </c:if>
										   
										    <c:if test="${not empty resultMap_xk.approve}">
										     <tr>
										       <td style="text-align: left;padding-left: 20px">
										                                您有<font color="red">${resultMap_xk.approve }</font>个项目立项审批待处理，请点击 <a href="<s:url value='/srm/proj/approve/list/local/xk'/>" style="color: red;">这里</a>&#12288;进入！
										       </td>
										     </tr>
										   </c:if>
										   
										   <c:if test="${not empty resultMap_xk.fundInfo}">
										     <tr>
										       <td style="text-align: left;padding-left: 20px">
										                                您有<font color="red" >${resultMap_xk.fundInfo }</font>个项目预算申请待处理，请点击 <a href="<s:url value='/srm/fund/scheme/auditList/local/xk'/>" style="color: red;">这里</a>&#12288;进入！
										       </td>
										     </tr>
										   </c:if>
										   
										     <c:if test="${not empty resultMap_xk.completeEva}">
										     <tr>
										       <td style="text-align: left;padding-left: 20px">
										                                您有<font color="red">${resultMap_xk.completeEva }</font>个项目验收评审待处理，请点击 <a href="<s:url value='/srm/proj/evaluation/completeList/local/xk'/>" style="color: red;">这里</a>&#12288;进入！
										       </td>
										     </tr>
										   </c:if>
										   
										   <c:if test="${not empty resultMap_xk.archive}">   
										      <tr>
										       <td style="text-align: left;padding-left: 20px">
										                                您有<font color="red">${resultMap_xk.archive }</font>个项目验收审批待处理，请点击 <a href="<s:url value='/srm/proj/archive/list/local/xk'/>" style="color: red;">这里</a>&#12288;进入！
										       </td>
										      </tr>
										   </c:if>
										  </c:if>
										 <!-- 医院版特殊功能结束 -->
									     <c:if test="${not empty resultMap_xk.apply}">
										     <tr>
										       <td style="text-align: left;padding-left: 20px;"> 
										                                 您有<font color="red">${resultMap_xk.apply }</font>个项目申请报告待处理，请点击 <a href="<s:url value='/srm/proj/apply/list/local/xk?recTypeId=Apply'/>" style="color: red;">这里</a>&#12288;进入,如需查询更多项目，请点击"项目查询"功能!
										       </td>
										     </tr>
										   </c:if>
										   
										    <c:if test="${not empty resultMap_xk.contract}">
										     <tr>
										       <td style="text-align: left;padding-left: 20px">
										                                 您有<font color="red">${resultMap_xk.contract }</font>个项目合同待处理，请点击 <a href="<s:url value='/srm/proj/contract/list/local/xk?recTypeId=Contract'/>" style="color: red;">这里</a>&#12288;进入！
										        </td>
										     </tr>
										   </c:if>
										   <c:if test="${not empty resultMap_xk.scheduleReport}">
										     <tr>
										       <td style="text-align: left;padding-left: 20px">
										                                  您有<font color="red">${resultMap_xk.scheduleReport }</font>个项目进展报告待处理，请点击 <a href="<s:url value='/srm/proj/schedule/list/local/xk?recTypeId=ScheduleReport'/>" style="color: red;">这里</a>&#12288;进入！
										       </td>
										     </tr>
										   </c:if>
										   <c:if test="${not empty resultMap_xk.changeReport}">
										       <tr>
										         <td style="text-align: left;padding-left: 20px">               
										                                     您有<font color="red">${resultMap_xk.changeReport }</font>个项目变更报告待处理，请点击 <a href="<s:url value='/srm/proj/schedule/list/local/xk?recTypeId=ChangeReport'/>" style="color: red;">这里</a>&#12288;进入！
										         </td>
										       </tr>
										   </c:if>
										   <c:if test="${not empty resultMap_xk.completeReport}">
										        <tr>
										          <td style="text-align: left;padding-left: 20px">
										                                    您有<font color="red">${resultMap_xk.completeReport }</font>个项目验收报告待处理，请点击 <a href="<s:url value='/srm/proj/complete/list/local/xk?recTypeId=CompleteReport'/>" style="color: red;">这里</a>&#12288;进入！
										          </td>
										         </tr>
										   </c:if>
										   <c:if test="${not empty resultMap_xk.terminateReport}">
										       <tr>
										         <td style="text-align: left;padding-left: 20px">
										                                        您有<font color="red">${resultMap_xk.terminateReport }</font>个项目中止报告待处理，请点击 <a href="<s:url value='/srm/proj/terminate/list/local/xk?recTypeId=TerminateReport'/>" style="color: red;">这里</a>&#12288;进入！
									              </td>
									            </tr>
									       </c:if>
								</tbody>
								<!-- 重点人才待办事项 -->
								<tbody id="rc" style="display: none;">
								     <c:if test="${empty resultMap_rc}">							
										<tr>
											<td style="text-align: left;padding-left: 30px;color: red;" >
												重点人才目前没有待办理的业务!
											</td>
										</tr>	
									</c:if>
									<!-- 医院版特殊功能 -->
									 <c:if test="${applicationScope.sysCfgMap['srm_for_use']=='local' }">
									      <c:if test="${not empty resultMap_rc.approveEva}">
										     <tr>
										       <td style="text-align: left;padding-left: 20px">
										                                  您有<font color="red">${resultMap_rc.approveEva}</font>个项目立项评审待处理，请点击 <a href="<s:url value='/srm/proj/evaluation/approveList/local/rc'/>" style="color: red;">这里</a>&#12288;进入！
										       </td>
										     </tr>
										   </c:if>
										   
										    <c:if test="${not empty resultMap_rc.approve}">
										     <tr>
										       <td style="text-align: left;padding-left: 20px">
										                                您有<font color="red">${resultMap_rc.approve }</font>个项目立项审批待处理，请点击 <a href="<s:url value='/srm/proj/approve/list/local/rc'/>" style="color: red;">这里</a>&#12288;进入！
										       </td>
										     </tr>
										   </c:if>
										   
										   <c:if test="${not empty resultMap_rc.fundInfo}">
										     <tr>
										       <td style="text-align: left;padding-left: 20px">
										                                您有<font color="red" >${resultMap_rc.fundInfo }</font>个项目预算申请待处理，请点击 <a href="<s:url value='/srm/fund/scheme/auditList/local/rc'/>" style="color: red;">这里</a>&#12288;进入！
										       </td>
										     </tr>
										   </c:if>
										   
										     <c:if test="${not empty resultMap_rc.completeEva}">
										     <tr>
										       <td style="text-align: left;padding-left: 20px">
										                                您有<font color="red">${resultMap_rc.completeEva }</font>个项目验收评审待处理，请点击 <a href="<s:url value='/srm/proj/evaluation/completeList/local/rc'/>" style="color: red;">这里</a>&#12288;进入！
										       </td>
										     </tr>
										   </c:if>
										   
										   <c:if test="${not empty resultMap_rc.archive}">   
										      <tr>
										       <td style="text-align: left;padding-left: 20px">
										                                您有<font color="red">${resultMap_rc.archive }</font>个项目验收审批待处理，请点击 <a href="<s:url value='/srm/proj/archive/list/local/rc'/>" style="color: red;">这里</a>&#12288;进入！
										       </td>
										      </tr>
										   </c:if>
										  </c:if>
										 <!-- 医院版特殊功能结束 -->
									     <c:if test="${not empty resultMap_rc.apply}">
										     <tr>
										       <td style="text-align: left;padding-left: 20px;"> 
										                                 您有<font color="red">${resultMap_rc.apply }</font>个项目申请报告待处理，请点击 <a href="<s:url value='/srm/proj/apply/list/local/rc?recTypeId=Apply'/>" style="color: red;">这里</a>&#12288;进入,如需查询更多项目，请点击"项目查询"功能!
										       </td>
										     </tr>
										   </c:if>
										   
										    <c:if test="${not empty resultMap_rc.contract}">
										     <tr>
										       <td style="text-align: left;padding-left: 20px">
										                                 您有<font color="red">${resultMap_rc.contract }</font>个项目合同待处理，请点击 <a href="<s:url value='/srm/proj/contract/list/local/rc?recTypeId=Contract'/>" style="color: red;">这里</a>&#12288;进入！
										        </td>
										     </tr>
										   </c:if>
										   <c:if test="${not empty resultMap_rc.scheduleReport}">
										     <tr>
										       <td style="text-align: left;padding-left: 20px">
										                                  您有<font color="red">${resultMap_rc.scheduleReport }</font>个项目进展报告待处理，请点击 <a href="<s:url value='/srm/proj/schedule/list/local/rc?recTypeId=ScheduleReport'/>" style="color: red;">这里</a>&#12288;进入！
										       </td>
										     </tr>
										   </c:if>
										   <c:if test="${not empty resultMap_rc.changeReport}">
										       <tr>
										         <td style="text-align: left;padding-left: 20px">               
										                                     您有<font color="red">${resultMap_rc.changeReport }</font>个项目变更报告待处理，请点击 <a href="<s:url value='/srm/proj/schedule/list/local/rc?recTypeId=ChangeReport'/>" style="color: red;">这里</a>&#12288;进入！
										         </td>
										       </tr>
										   </c:if>
										   <c:if test="${not empty resultMap_rc.completeReport}">
										        <tr>
										          <td style="text-align: left;padding-left: 20px">
										                                        您有<font color="red">${resultMap_rc.completeReport }</font>个项目验收报告待处理，请点击 <a href="<s:url value='/srm/proj/complete/list/local/rc?recTypeId=CompleteReport'/>" style="color: red;">这里</a>&#12288;进入！
										          </td>
										         </tr>
										   </c:if>
										   <c:if test="${not empty resultMap_rc.terminateReport}">
										       <tr>
										         <td style="text-align: left;padding-left: 20px">
										                                        您有<font color="red">${resultMap_rc.terminateReport }</font>个项目中止报告待处理，请点击 <a href="<s:url value='/srm/proj/terminate/list/local/rc?recTypeId=TerminateReport'/>" style="color: red;">这里</a>&#12288;进入！
									              </td>
									            </tr>
									       </c:if> 
									         <c:if test="${not empty resultMap_rc.aidTalentsCount}">
										       <tr>
										         <td style="text-align: left;padding-left: 20px">
										                                        您有<font color="red">${resultMap_rc.aidTalentsCount }</font>个专项资金申请待处理，请点击 <a href="<s:url value='/srm/aid/talents/list/local'/>" style="color: red;">这里</a>&#12288;进入！
									              </td>
									            </tr>
									       </c:if>
								</tbody>				
										  <tbody>
									       
									       <!-- 成果待办事项 -->
									       <c:forEach items="${achTypeEnumList}" var="achType">
					                           <c:set var='on_off_achTypeId' value="srm_useAchType_${achType.id}"></c:set>
					                           <c:set var='achTypeId' value="${achType.id}"></c:set>
									           <c:if test="${sysCfgMap[on_off_achTypeId] eq 'Y'}">
									             <c:if test="${not empty srmAchMap[achTypeId]}">
									             <tr>
									               <td style="text-align: left;padding-left: 20px">                       
									                                                  您有<font color="red">${srmAchMap[achTypeId] }</font>篇${achType.name }待处理， 请点击 <a href="<s:url value='/srm/ach/${lowerAchTypeMap[achTypeId]}/auditList/local'/>" style="color: red;">这里</a>&#12288;进入！
									              </td>
									            </tr>
									           </c:if>
									           </c:if>
									       </c:forEach>
									       <!-- 注册待审核 -->
									       <c:if test="${not empty resultMap.regedUserCount}">
										       <tr>
										         <td style="text-align: left;padding-left: 20px">
										                                        您有<font color="red">${resultMap.regedUserCount }</font>个注册人员待处理，请点击 <a href="<s:url value='/sys/user/list/local?statusId=${userStatusEnumReged.id }'/>" style="color: red;">这里</a>&#12288;进入！
									              </td>
									            </tr>
									    </c:if>
					                   
							       </tbody>	
						  </table>
					</div>
				<div style="width:39%; ;float: right;margin-left: 10px;margin-bottom: 10px;">
						<div style="width: 100%">
			<table width="100%" class="xllist">
							        <thead>
							        <tr>
							          <th  colspan="5"  style="text-align: left;">&#12288;评审和立项情况</th>
							        </tr>
							        </thead>
							        <tbody>
							        	<tr>
							        		<td width="60%"><b>市级项目</b></td><td><b>其他</b></td>
							        	</tr>
							          <c:forEach var="item" items="${projCountInfoMap }" varStatus="vs"> 
					       	 			<tr>
								             <td style="text-align: left;padding-left: 30px;">
								               ${item.key } ：&#12288;<font color='red'>${item.value }<c:if test="${vs.count eq 4}">%</c:if></font>
								             </td>
								             <td style="text-align: left;padding-left: 30px;">
								             	<c:if test="${vs.count == 1}">省级：<font color="red">${aidProjProvinceCount }</font></c:if>
								             	<c:if test="${vs.count == 2}">国家级：<font color="red">${aidProjCountryCount }</font></c:if>
								                <c:if test="${vs.count == 3}">市厅级：<font color="red">${aidProjCityCount }</font></c:if>
								             </td>
								        </tr>
							          </c:forEach>
							        </tbody>
							  </table>
				  </div>
				   <div style="width: 100%;margin-top: 10px;">
				 <table width="100%" class="xllist">
								        <thead>
								          <tr>
								          <th  colspan="7" style="text-align: left;">&#12288;成果情况</th>
								        </tr>
								        </thead>
								        <tbody>
								         <tr>
								          <c:forEach var="item" items="${srmAchCountMap }" > 
								             <td width="14%">
								               ${item.key }
								             </td>
								          </c:forEach>
								        </tr>
								         <tr>
								          <c:forEach var="item" items="${srmAchCountMap }" > 
								             <td>
								               ${item.value }
								             </td>
								          </c:forEach>
								        </tr>
								        </tbody>
								     </table>
		</div>
	</div>
</div></div></div></div>
</body>
</html>