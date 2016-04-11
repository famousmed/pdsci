<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@include file="/jsp/common/doctype.jsp"%>
<html>
<head>
<jsp:include page="/jsp/common/htmlhead.jsp">
	<jsp:param name="basic" value="true" />
	<jsp:param name="jbox" value="true" />
	<jsp:param name="jquery_form" value="false" />
	<jsp:param name="jquery_ui_tooltip" value="true" />
	<jsp:param name="jquery_ui_combobox" value="false" />
	<jsp:param name="jquery_ui_sortable" value="false" />
	<jsp:param name="jquery_cxselect" value="true" />
	<jsp:param name="jquery_scrollTo" value="false" />
	<jsp:param name="jquery_jcallout" value="false" />
	<jsp:param name="jquery_validation" value="true" />
	<jsp:param name="jquery_datePicker" value="true" />
	<jsp:param name="jquery_fullcalendar" value="false" />
	<jsp:param name="jquery_fngantt" value="false" />
	<jsp:param name="jquery_fixedtableheader" value="true" />
	<jsp:param name="jquery_placeholder" value="true" />
	<jsp:param name="jquery_iealert" value="false" />
</jsp:include>
<style type="text/css">
	table.xllist a{color: blue;cursor: pointer;}
	
	table [type='text']{width:150px;height: 22px;}
	table select{width: 153px;height: 27px;}
</style>
<script type="text/javascript">
	function save(absenceFlow, agreeFlag){
		var title = "同意";
		if("${GlobalConstant.FLAG_N}" == agreeFlag){
			title = "不同意";
		}
		jboxConfirm("确认"+ title +"请假? " ,  function(){
			jboxStartLoading();
			var url = "<s:url value='/res/teacher/saveAbsenceAudit'/>";
			var data = {
					absenceFlow : absenceFlow,
					<c:if test="${GlobalConstant.RES_ROLE_SCOPE_TEACHER == resRoleScope}">
						teacherAgreeFlag:agreeFlag,
					</c:if>
					<c:if test="${GlobalConstant.RES_ROLE_SCOPE_HEAD == resRoleScope}">
						headAgreeFlag:agreeFlag,
					</c:if>
					<c:if test="${GlobalConstant.RES_ROLE_SCOPE_MANAGER == resRoleScope}">
						managerAgreeFlag:agreeFlag,
						managerFlow : "${sessionScope.currUser.userFlow}",
						managerName : "${sessionScope.currUser.userName}"
					</c:if>
			};
			jboxPost(url, data,
				function(resp){
					if("${GlobalConstant.SAVE_SUCCESSED}" == resp){
						window.location.reload(true);
					}
				}, null, true);
			
		});
	}
	
	function search(){
		jboxStartLoading();
		$("#searchForm").submit();
	}
	
	function toPage(page) {
		if(page){
			$("#currentPage").val(page);			
		}
		search();
	}
</script>

</head>
<body>
	<div class="mainright">
		<div class="content">
			<div class="title1 clearfix">
				<form id="searchForm" action="<s:url value='/res/teacher/absenceAudit/${resRoleScope}'/>" method="post">
					<input id="currentPage" type="hidden" name="currentPage" value="${param.currentPage}"/>
					<table class="basic" width="100%" style="margin-bottom: 10px;">
						<tr>
							<td style="text-align: left;">
								&#12288;姓&#12288;&#12288;名：<input type="text"  name="doctorName" value="${param.doctorName}" onchange="search();" style="width: 90px;"/>
								&#12288;&#12288;状态：
								<select name="repealAbsence" onchange="search();" style="width: 90px;">
										<option value="">请选择</option>
										<option value="${GlobalConstant.FLAG_N}" <c:if test="${param.repealAbsence eq GlobalConstant.FLAG_N}">selected="selected"</c:if>>未销假</option>
										<option value="${GlobalConstant.FLAG_Y}" <c:if test="${param.repealAbsence eq GlobalConstant.FLAG_Y}">selected="selected"</c:if>>已销假</option>
								</select>
								<c:if test="${GlobalConstant.RES_ROLE_SCOPE_MANAGER==resRoleScope || GlobalConstant.RES_ROLE_SCOPE_CHARGE== resRoleScope}">
									&#12288;&#12288;轮转科室：
									<select name="schDeptFlow" onchange="search();">
										<option value="">请选择</option>
										<c:forEach items="${schDeptList}" var="schDetp">
											<option value="${schDetp.schDeptFlow}" <c:if test="${param.schDeptFlow eq schDetp.schDeptFlow}">selected="selected"</c:if>>${schDetp.schDeptName}</option>
										</c:forEach>
									</select>
								</c:if>
								&#12288;&#12288;请假时间：<input type="text" name="startDate" value="${param.startDate}" onchange="search();" onclick="WdatePicker({dateFmt:'yyyy-MM-dd'})" style="margin-right: 0px; width: 90px;" readonly="readonly"/>
								~ <input type="text" name="endDate" value="${param.endDate}" onchange="search();" onclick="WdatePicker({dateFmt:'yyyy-MM-dd'})" style="margin-right: 0px; width: 90px;" readonly="readonly"/>
							</td>
						</tr>
					</table>
				</form>
				<table class="xllist">
					<tr>
						<th width="4%">姓名</th>
						<c:if test="${GlobalConstant.RES_ROLE_SCOPE_CHARGE eq resRoleScope}">
							<td width="13%">实习医院</td>
						</c:if>
						<th width="5%">请假类型</th>
						<th width="15%">请假事由</th>
						<th width="12%">请假时间</th>
						<th width="10%">轮转科室</th>
						<th width="9%">请假材料</th>
						<th width="8%">带教老师</th>
						<th width="8%">科室主任</th>
						<c:if test="${sysCfgMap['res_absence_manage_audit'] eq GlobalConstant.FLAG_Y}">
						<th width="8%">医教部门</th>
						</c:if>
					</tr>
					<c:set var="emptyRecord" value="true"/>
					<c:forEach items="${doctorAbsenceList}" var="doctorAbsence">
						<c:set var="isDue" value="${doctorAbsence.endDate.compareTo(pdfn:getCurrDate())}"/>
						<c:set var="disagreeFlag" value="false"/>
						<c:if test="${GlobalConstant.FLAG_N eq doctorAbsence.teacherAgreeFlag or 
							GlobalConstant.FLAG_N eq doctorAbsence.headAgreeFlag or 
							GlobalConstant.FLAG_N eq doctorAbsence.managerAgreeFlag
							}">
							<c:set var="disagreeFlag" value="true"/>
						</c:if>
<%-- 					<c:if test="${isDue >= 0 and !disagreeFlag and  --%>
<%-- 								((doctorAbsence.intervalDay >= sysCfgMap['res_absence_teacher_day'] and GlobalConstant.RES_ROLE_SCOPE_TEACHER == resRoleScope) or --%>
<%-- 								(doctorAbsence.intervalDay >= sysCfgMap['res_absence_head_day'] and GlobalConstant.RES_ROLE_SCOPE_HEAD == resRoleScope) or --%>
<%-- 								(doctorAbsence.intervalDay >= sysCfgMap['res_absence_manage_day'] and GlobalConstant.RES_ROLE_SCOPE_MANAGER == resRoleScope))}"> --%>
						<c:set var="emptyRecord" value="false"/>
						<c:set var="repealFlag" value="false"/>
						<tr>
							<td>${doctorAbsence.doctorName}</td>
							<c:if test="${GlobalConstant.RES_ROLE_SCOPE_CHARGE eq resRoleScope}">
								<td>${doctorAbsence.orgName}</td>
							</c:if>
							<td>${doctorAbsence.absenceTypeName}</td>
							<td>${doctorAbsence.absenceReson}</td>
							<td>
								${doctorAbsence.startDate}~${doctorAbsence.endDate}<br/>
								<font style="font-weight: bold;">
									(${doctorAbsence.intervalDay}天)
								</font>
							</td>
							<td>${doctorAbsence.schDeptName}</td>
							<td><a id="down" href='<s:url value="/pub/file/down?fileFlow=${doctorAbsence.makingFile}"/>'>${fileMap[doctorAbsence.makingFile].fileName}</a></td>
							<td>
								<c:if test="${not empty doctorAbsence.teacherAgreeFlag}">
									<c:if test="${GlobalConstant.FLAG_N eq doctorAbsence.teacherAgreeFlag}">
										<img src="<s:url value='/css/skin/${skinPath}/images/del3.png' />" title="审核不通过"/>
									</c:if>
									<c:if test="${GlobalConstant.FLAG_Y eq doctorAbsence.teacherAgreeFlag}">
										<img src="<s:url value='/css/skin/${skinPath}/images/gou.png'/>" title="审核通过"/>
									</c:if>
									${doctorAbsence.teacherName}
								</c:if>
								<c:if test="${isDue >= 0 && empty doctorAbsence.teacherAgreeFlag and 
											doctorAbsence.intervalDay >= sysCfgMap['res_absence_teacher_day'] and 
											GlobalConstant.RES_ROLE_SCOPE_TEACHER == resRoleScope}">
									<a href="javascript:save('${doctorAbsence.absenceFlow}','${GlobalConstant.FLAG_Y}');">同意</a> |
									<a href="javascript:save('${doctorAbsence.absenceFlow}','${GlobalConstant.FLAG_N}');">不同意</a>
								</c:if>
							</td>
							<td>
								<c:if test="${not empty doctorAbsence.headAgreeFlag}">
									<c:if test="${GlobalConstant.FLAG_N eq doctorAbsence.headAgreeFlag}">
										<img src="<s:url value='/css/skin/${skinPath}/images/del3.png'/>" title="审核不通过"/>
									</c:if>
									<c:if test="${GlobalConstant.FLAG_Y eq doctorAbsence.headAgreeFlag}">
										<img src="<s:url value='/css/skin/${skinPath}/images/gou.png'/>" title="审核通过"/>
									</c:if>
									${doctorAbsence.headName}
								</c:if>
								<c:if test="${isDue >= 0 && empty doctorAbsence.headAgreeFlag and 
											doctorAbsence.intervalDay >= sysCfgMap['res_absence_head_day'] and 
											GlobalConstant.RES_ROLE_SCOPE_HEAD == resRoleScope}">
									<a href="javascript:save('${doctorAbsence.absenceFlow}','${GlobalConstant.FLAG_Y}');">同意</a> |
									<a href="javascript:save('${doctorAbsence.absenceFlow}','${GlobalConstant.FLAG_N}');">不同意</a>
								</c:if>
							</td>
							<c:if test="${sysCfgMap['res_absence_manage_audit'] eq GlobalConstant.FLAG_Y}">
							<td>
								<c:if test="${not empty doctorAbsence.managerAgreeFlag}">
									<c:if test="${GlobalConstant.FLAG_N eq doctorAbsence.managerAgreeFlag}">
										<img src="<s:url value='/css/skin/${skinPath}/images/del3.png'/>" title="审核不通过"/>
									</c:if>
									<c:if test="${GlobalConstant.FLAG_Y eq doctorAbsence.managerAgreeFlag}">
										<img src="<s:url value='/css/skin/${skinPath}/images/gou.png'/>" title="审核通过"/>
									</c:if>
									${doctorAbsence.managerName}
								</c:if>
								<c:if test="${isDue >= 0 && empty doctorAbsence.managerAgreeFlag and 
											doctorAbsence.intervalDay >= sysCfgMap['res_absence_manage_day'] and 
											GlobalConstant.RES_ROLE_SCOPE_MANAGER == resRoleScope}">
									<a href="javascript:save('${doctorAbsence.absenceFlow}','${GlobalConstant.FLAG_Y}');">同意</a> |
									<a href="javascript:save('${doctorAbsence.absenceFlow}','${GlobalConstant.FLAG_N}');">不同意</a>
								</c:if>
							</td>
							</c:if>
						</tr>
<%-- 					</c:if> --%>
					</c:forEach>
					
					<c:if test="${emptyRecord}">
						<tr>
							<td colspan="10">无记录</td>
						</tr>
					</c:if>
				</table>
				<div>
		           <span>
		             <c:set var="pageView" value="${pdfn:getPageView(doctorAbsenceList)}" scope="request"/>
					<pd:pagination toPage="toPage"/>
<%-- 		             <c:set var="pageView" value="${pdfn:getPageView2(doctorAbsenceList, 10)}" scope="request"/>  --%>
<%-- 					 <pd:pagination toPage="toPage"/>	  --%>
		           </span>
		        </div> 
			</div>
		</div>
	</div>
</body>
</html>