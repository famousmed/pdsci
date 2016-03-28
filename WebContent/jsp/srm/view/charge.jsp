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
												<img  src="<s:url value="/css/skin/${skinPath}/images/index_proj_city.png" />" onclick="window.location.href='<s:url value='/srm/proj/apply/list/charge/ky?recTypeId=Apply'/>'">
											</div>
											<div align="left" style=";margin-top: 5px;width: 220px">
												<b style="font-size: 16px;"><a href="javascript:window.location.href='<s:url value='/srm/proj/apply/list/charge/ky?recTypeId=Apply'/>'">项目审核</a></b><br/>
												申报项目审核
											</div>
										</div>
									<div style="float: left;padding-top:10px;padding-bottom: 10px;">
											<div align="left" style="padding-left: 10px;float: left;cursor: pointer;">
												<img  src="<s:url value="/css/skin/${skinPath}/images/index_contract.png" />" onclick="window.location.href='<s:url value='/srm/proj/contract/list/charge/ky?recTypeId=Contract'/>'"> 
											</div>
											<div align="left" style=";margin-top: 5px;width: 220px">
												<b style="font-size: 16px;"><a href="javascript:window.location.href='<s:url value='/srm/proj/contract/list/charge/ky?recTypeId=Contract'/>'">合同审核</a></b><br/>
												申报项目合同审核
											</div>
										</div>
									</td>
								</tr>		
							</tbody>													
						</table>
					</div>
		
		
			<div style="width:100%; margin-top: 10px;margin-bottom: 10px;">
				<div  style="width:59%;float: left;">
					<div style="width:100%;float: left;margin-bottom: 10px;" align="left">
		
			<table width="100%" class="xllist" style="font-size: 14px">
							<tr>
								<th colspan="3"style="text-align: left;">&#12288;待办事项
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
											     <td style="text-align:left; padding-left:20px;color: red;" >
												            科研项目目前没有待办理的业务!
											     </td>
										       </tr>	
									       </c:if>
									       <c:if test="${not empty resultMap_ky.apply}">
									       <tr>
										       <td style="text-align: left;padding-left: 20px"> 
										                     您有<font color="red">${resultMap_ky.apply }</font>个项目申请报告待处理，请点击 <a href="<s:url value='/srm/proj/apply/list/charge/ky?recTypeId=Apply'/>" style="color: red;">这里</a>进入,如需查询更多项目，请点击"项目查询"功能!
										       </td>
										    </tr>
										   </c:if>
										   <c:if test="${applicationScope.sysCfgMap['srm_for_use']=='global' }">
										   <c:if test="${not empty resultMap_ky.approve}">
										     <tr>
										       <td style="text-align: left;padding-left: 20px">
										                                您有<font color="red">${resultMap_ky.approve }</font>个项目立项审批待处理，请点击 <a href="<s:url value='/srm/proj/approve/list/charge/ky'/>" style="color: red;">这里</a>进入！
										       </td>
										     </tr>
										   </c:if>
										   
										   <c:if test="${not empty resultMap_ky.archive}">   
										      <tr>
										       <td style="text-align: left;padding-left: 20px">
										                                您有<font color="red">${resultMap_ky.archive }</font>个项目验收审批待处理，请点击 <a href="<s:url value='/srm/proj/archive/list/charge/ky'/>" style="color: red;">这里</a>进入！
										       </td>
										      </tr>
										   </c:if>
										   </c:if>
										   <c:if test="${not empty resultMap_ky.contract}">
										       <tr>
										       <td style="text-align: left;padding-left: 20px">
										                                 您有<font color="red">${resultMap_ky.contract }</font>个项目合同待处理，请点击 <a href="<s:url value='/srm/proj/contract/list/charge/ky?recTypeId=Contract'/>" style="color: red;">这里</a>进入！
										        </td>
										     </tr>
										   </c:if>
										   <c:if test="${not empty resultMap_ky.scheduleReport}">
										     <tr>
										       <td style="text-align: left;padding-left: 20px">
										                                  您有<font color="red">${resultMap_ky.scheduleReport }</font>个项目进展报告待处理，请点击 <a href="<s:url value='/srm/proj/schedule/list/charge/ky?recTypeId=ScheduleReport'/>" style="color: red;">这里</a>进入！
										       </td>
										     </tr>
										   </c:if>
										   <c:if test="${not empty resultMap_ky.changeReport}">
										      <tr>
										         <td style="text-align: left;padding-left: 20px">               
										                                     您有<font color="red">${resultMap_ky.changeReport }</font>个项目变更报告待处理，请点击 <a href="<s:url value='/srm/proj/schedule/list/charge/ky?recTypeId=ChangeReport'/>" style="color: red;">这里</a>进入！
										         </td>
										       </tr>
										   </c:if>
										   <c:if test="${not empty resultMap_ky.completeReport}">
										     <tr>
										          <td style="text-align: left;padding-left: 20px">
										                                        您有<font color="red">${resultMap_ky.completeReport }</font>个项目验收报告待处理，请点击 <a href="<s:url value='/srm/proj/complete/list/charge/ky?recTypeId=CompleteReport'/>" style="color: red;">这里</a>进入！
										          </td>
										     </tr>
										   </c:if>
										   <c:if test="${not empty resultMap_ky.terminateReport}">
										      <tr>
										         <td style="text-align: left;padding-left: 20px">
										                                        您有<font color="red">${resultMap_ky.terminateReport }</font>个项目中止报告待处理，请点击 <a href="<s:url value='/srm/proj/terminate/list/charge/ky?recTypeId=TerminateReport'/>" style="color: red;">这里</a>进入！
									              </td>
									          </tr>
									       </c:if>
												
							</tbody>
							<tbody id="xk" style="display: none;">								
									      <c:if test="${empty resultMap_xk}">
									           <tr>
											     <td style="text-align:left; padding-left:20px;color: red;" >
												            重点学科目前没有待办理的业务!
											     </td>
										       </tr>	
									       </c:if>
									       <c:if test="${not empty resultMap_xk.apply}">
									       <tr>
										       <td style="text-align: left;padding-left: 20px"> 
										                     您有<font color="red">${resultMap_xk.apply }</font>个项目申请报告待处理，请点击 <a href="<s:url value='/srm/proj/apply/list/charge/xk?recTypeId=Apply'/>" style="color: red;">这里</a>进入,如需查询更多项目，请点击"项目查询"功能!
										       </td>
										    </tr>
										   </c:if>
										   <c:if test="${applicationScope.sysCfgMap['srm_for_use']=='global' }">
										   <c:if test="${not empty resultMap_xk.approve}">
										     <tr>
										       <td style="text-align: left;padding-left: 20px">
										                                您有<font color="red">${resultMap_xk.approve }</font>个项目立项审批待处理，请点击 <a href="<s:url value='/srm/proj/approve/list/charge/xk'/>" style="color: red;">这里</a>进入！
										       </td>
										     </tr>
										   </c:if>
										   
										   <c:if test="${not empty resultMap_xk.archive}">   
										      <tr>
										       <td style="text-align: left;padding-left: 20px">
										                                您有<font color="red">${resultMap_xk.archive }</font>个项目验收审批待处理，请点击 <a href="<s:url value='/srm/proj/archive/list/charge/xk'/>" style="color: red;">这里</a>进入！
										       </td>
										      </tr>
										   </c:if>
										   </c:if>
										   <c:if test="${not empty resultMap_xk.contract}">
										       <tr>
										       <td style="text-align: left;padding-left: 20px">
										                                 您有<font color="red">${resultMap_xk.contract }</font>个项目合同待处理，请点击 <a href="<s:url value='/srm/proj/contract/list/charge/xk?recTypeId=Contract'/>" style="color: red;">这里</a>进入！
										        </td>
										     </tr>
										   </c:if>
										   <c:if test="${not empty resultMap_xk.scheduleReport}">
										     <tr>
										       <td style="text-align: left;padding-left: 20px">
										                                  您有<font color="red">${resultMap_xk.scheduleReport }</font>个项目进展报告待处理，请点击 <a href="<s:url value='/srm/proj/schedule/list/charge/xk?recTypeId=ScheduleReport'/>" style="color: red;">这里</a>进入！
										       </td>
										     </tr>
										   </c:if>
										   <c:if test="${not empty resultMap_xk.changeReport}">
										      <tr>
										         <td style="text-align: left;padding-left: 20px">               
										                                     您有<font color="red">${resultMap_xk.changeReport }</font>个项目变更报告待处理，请点击 <a href="<s:url value='/srm/proj/schedule/list/charge/xk?recTypeId=ChangeReport'/>" style="color: red;">这里</a>进入！
										         </td>
										       </tr>
										   </c:if>
										   <c:if test="${not empty resultMap_xk.completeReport}">
										     <tr>
										          <td style="text-align: left;padding-left: 20px">
										                                        您有<font color="red">${resultMap_xk.completeReport }</font>个项目验收报告待处理，请点击 <a href="<s:url value='/srm/proj/complete/list/charge/xk?recTypeId=CompleteReport'/>" style="color: red;">这里</a>进入！
										          </td>
										     </tr>
										   </c:if>
										   <c:if test="${not empty resultMap_xk.terminateReport}">
										      <tr>
										         <td style="text-align: left;padding-left: 20px">
										                                        您有<font color="red">${resultMap_xk.terminateReport }</font>个项目中止报告待处理，请点击 <a href="<s:url value='/srm/proj/terminate/list/charge/xk?recTypeId=TerminateReport'/>" style="color: red;">这里</a>进入！
									              </td>
									          </tr>
									       </c:if>				
							</tbody>
							<tbody id="rc" style="display: none;">								
									      <c:if test="${empty resultMap_rc}">
									           <tr>
											     <td style="text-align:left; padding-left:20px;color: red;" >
												            重点人才目前没有待办理的业务!
											     </td>
										       </tr>	
									       </c:if>
									       <c:if test="${not empty resultMap_rc.apply}">
									       <tr>
										       <td style="text-align: left;padding-left: 20px"> 
										                     您有<font color="red">${resultMap_rc.apply }</font>个项目申请报告待处理，请点击 <a href="<s:url value='/srm/proj/apply/list/charge/rc?recTypeId=Apply'/>" style="color: red;">这里</a>进入,如需查询更多项目，请点击"项目查询"功能!
										       </td>
										    </tr>
										   </c:if>
										   <c:if test="${applicationScope.sysCfgMap['srm_for_use']=='global' }">
										   <c:if test="${not empty resultMap_rc.approve}">
										     <tr>
										       <td style="text-align: left;padding-left: 20px">
										                                您有<font color="red">${resultMap_rc.approve }</font>个项目立项审批待处理，请点击 <a href="<s:url value='/srm/proj/approve/list/charge/rc'/>" style="color: red;">这里</a>进入！
										       </td>
										     </tr>
										   </c:if>
										   
										   <c:if test="${not empty resultMap_rc.archive}">   
										      <tr>
										       <td style="text-align: left;padding-left: 20px">
										                                您有<font color="red">${resultMap_rc.archive }</font>个项目验收审批待处理，请点击 <a href="<s:url value='/srm/proj/archive/list/charge/rc'/>" style="color: red;">这里</a>进入！
										       </td>
										      </tr>
										   </c:if>
										   </c:if>
										   <c:if test="${not empty resultMap_rc.contract}">
										       <tr>
										       <td style="text-align: left;padding-left: 20px">
										                                 您有<font color="red">${resultMap_rc.contract }</font>个项目合同待处理，请点击 <a href="<s:url value='/srm/proj/contract/list/charge/rc?recTypeId=Contract'/>" style="color: red;">这里</a>进入！
										        </td>
										     </tr>
										   </c:if>
										   <c:if test="${not empty resultMap_rc.scheduleReport}">
										     <tr>
										       <td style="text-align: left;padding-left: 20px">
										                                  您有<font color="red">${resultMap_rc.scheduleReport }</font>个项目进展报告待处理，请点击 <a href="<s:url value='/srm/proj/schedule/list/charge/rc?recTypeId=ScheduleReport'/>" style="color: red;">这里</a>进入！
										       </td>
										     </tr>
										   </c:if>
										   <c:if test="${not empty resultMap_rc.changeReport}">
										      <tr>
										         <td style="text-align: left;padding-left: 20px">               
										                                     您有<font color="red">${resultMap_rc.changeReport }</font>个项目变更报告待处理，请点击 <a href="<s:url value='/srm/proj/schedule/list/charge/rc?recTypeId=ChangeReport'/>" style="color: red;">这里</a>进入！
										         </td>
										       </tr>
										   </c:if>
										   <c:if test="${not empty resultMap_rc.completeReport}">
										     <tr>
										          <td style="text-align: left;padding-left: 20px">
										                                        您有<font color="red">${resultMap_rc.completeReport }</font>个项目验收报告待处理，请点击 <a href="<s:url value='/srm/proj/complete/list/charge/rc?recTypeId=CompleteReport'/>" style="color: red;">这里</a>进入！
										          </td>
										     </tr>
										   </c:if>
										   <c:if test="${not empty resultMap_rc.terminateReport}">
										      <tr>
										         <td style="text-align: left;padding-left: 20px">
										                                        您有<font color="red">${resultMap_rc.terminateReport }</font>个项目中止报告待处理，请点击 <a href="<s:url value='/srm/proj/terminate/list/charge/rc?recTypeId=TerminateReport'/>" style="color: red;">这里</a>进入！
									              </td>
									          </tr>
									       </c:if>
							</tbody>		
							<tbody>
							<c:if test="${not empty resultMap.regedUserCount}">
										       <tr>
										         <td style="text-align: left;padding-left: 20px">
										                                        您有<font color="red">${resultMap.regedUserCount }</font>个注册人员待处理，请点击 <a href="<s:url value='/sys/user/list/charge?statusId=${userStatusEnumReged.id}'/>" style="color: red;">这里</a>&#12288;进入！
									              </td>
									            </tr>
									    </c:if>
							</tbody>									
						</table>
					</div>
					<div style="width: 100%">
							<table width="100%" class="xllist">
				        <tr>
				          <th  colspan="4" style="text-align: left;">&#12288;各医院承担项目情况</th>
				        </tr>
				         <tr>
				            <td style="text-align: left;padding-left: 30px;">
				             <ul>
				             <c:forEach var="item" items="${orgCountInfoMap }" >
				              <li style="float: left;width: 33%;"> 
				               ${item.key }：  ${item.value }
				              </li>
				             </c:forEach>
				             </ul>
				             </td>
				             </tr>
				  </table>
					</div>
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
						</div></div>
		</div>
	</div>
</div>
</body>
</html>