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
	table.xllist a{color: blue;}
</style>
<script type="text/javascript">
function editAbsence(absenceFlow){
	var title = "新增";
	if(absenceFlow){
		title = "修改";
	}
	var url = "<s:url value='/res/doc/editAbsence'/>?resRoleScope=${GlobalConstant.RES_ROLE_SCOPE_DOCTOR}&absenceFlow=" + absenceFlow;
	jboxOpen(url, title+"请假", 800, 400);
}

function delAbsence(absenceFlow){
	jboxConfirm("确认删除请假? " ,  function(){
		jboxStartLoading();
		var url = "<s:url value='/res/doc/delAbsence'/>?absenceFlow=" + absenceFlow;
		jboxPost(url, null,
			function(resp){
				if("${GlobalConstant.DELETE_SUCCESSED}" == resp){
					window.location.reload(true);
				}
			}, null, true);
	});
}

function repealAbsence(absenceFlow){
	jboxConfirm("确认销假?",  function(){
		jboxStartLoading();
		var url = "<s:url value='/res/doc/repealAbsence'/>?absenceFlow=" + absenceFlow;
		jboxPost(url, null,
			function(resp){
				if("${GlobalConstant.OPRE_SUCCESSED}" == resp){
					window.location.reload(true);
				}
			}, null, true);
	});
}

function toPage(page){
	var form = $("#searchForm");
	$("#currentPage").val(page);
	jboxStartLoading();
	form.submit();
}
</script>

</head>
<body>
	<div class="mainright">
		<div class="content">
			<div class="title1 clearfix">
			<div style="margin-bottom: 15px;">
				<span>
				<img src="<s:url value='/css/skin/${skinPath}/images/query.gif'/>"/>&nbsp;待审核&#12288;
				<img src="<s:url value='/css/skin/${skinPath}/images/gou.png'/>"/>&nbsp;审核通过&#12288;
				<img src="<s:url value='/css/skin/${skinPath}/images/del3.png'/>"/>&nbsp;审核不通过&#12288;
				</span>
				<input type="button" class="search" value="新&#12288;增" onclick="editAbsence('');" style="float: right;"/>
			</div>
			<form id="searchForm" action="<s:url value="/res/doc/absenceList"/>" method="post">
			<input type="hidden" id="currentPage" name="currentPage" value=""/>
			<table class="xllist">
				<tr>
					<th width="7%">姓名</th>
					<th width="7%">请假类型</th>
					<th width="18%">请假事由</th>
					<th width="17%">请假时间</th>
					<th width="11%">轮转科室</th>
					<th width="9%">带教老师</th>
					<th width="9%">科室主任</th>
					<c:if test="${sysCfgMap['res_absence_manage_audit'] eq GlobalConstant.FLAG_Y}">
					<th width="9%">医教部门</th>
					</c:if>
					<th width="5%">状态</th>
					<th width="7%">操作</th>
				</tr>
				<c:forEach items="${doctorAbsenceList}" var="doctorAbsence">
					<c:set var="isDue" value="${doctorAbsence.endDate.compareTo(pdfn:getCurrDate())}"/>
					<c:set var="disagreeFlag" value="false"/>
					<c:if test="${GlobalConstant.FLAG_N eq doctorAbsence.teacherAgreeFlag or 
						GlobalConstant.FLAG_N eq doctorAbsence.headAgreeFlag or 
						GlobalConstant.FLAG_N eq doctorAbsence.managerAgreeFlag
						}">
						<c:set var="disagreeFlag" value="true"/>
					</c:if>
					<c:set var="repealFlag" value="false"/>
					<c:if test="${GlobalConstant.FLAG_Y != doctorAbsence.repealAbsence 
						and !((doctorAbsence.intervalDay >= sysCfgMap['res_absence_teacher_day'] and empty doctorAbsence.teacherAgreeFlag) or
							(doctorAbsence.intervalDay >= sysCfgMap['res_absence_head_day'] and empty doctorAbsence.headAgreeFlag) or
							(doctorAbsence.intervalDay >= sysCfgMap['res_absence_manage_day'] and empty doctorAbsence.managerAgreeFlag))
						and	!disagreeFlag}">
						<c:set var="repealFlag" value="true"/>
					</c:if>
					<tr>
						<td>${doctorAbsence.doctorName}</td>
						<td>${doctorAbsence.absenceTypeName}</td>
						<td>${doctorAbsence.absenceReson}</td>
						<td>
							${doctorAbsence.startDate}~${doctorAbsence.endDate}<br/>
							<font style="font-weight: bold;">
								(${doctorAbsence.intervalDay}天)
							</font>
						</td>
						<td style="text-align: center; ">${doctorAbsence.schDeptName}</td>
						<td>
							<c:if test="${not empty doctorAbsence.teacherAgreeFlag}">
								<c:if test="${GlobalConstant.FLAG_N eq doctorAbsence.teacherAgreeFlag}">
									<img src="<s:url value='/css/skin/${skinPath}/images/del3.png'/>"/>
								</c:if>
								<c:if test="${GlobalConstant.FLAG_Y eq doctorAbsence.teacherAgreeFlag}">
									<img src="<s:url value='/css/skin/${skinPath}/images/gou.png'/>"/>
								</c:if>
								${doctorAbsence.teacherName}
							</c:if>
							<c:if test="${empty doctorAbsence.teacherAgreeFlag and
							 		doctorAbsence.intervalDay >= sysCfgMap['res_absence_teacher_day'] and
							 		!disagreeFlag}">
							 	<c:choose>
									<c:when test="${isDue < 0 }">已过期</c:when>
									<c:otherwise><img src="<s:url value='/css/skin/${skinPath}/images/query.gif'/>"/>&nbsp;${doctorAbsence.teacherName}</c:otherwise>
								</c:choose>
							</c:if>
						</td>
						<td>
							<c:if test="${not empty doctorAbsence.headAgreeFlag}">
								<c:if test="${GlobalConstant.FLAG_N eq doctorAbsence.headAgreeFlag}">
									<img src="<s:url value='/css/skin/${skinPath}/images/del3.png'/>" />
								</c:if>
								<c:if test="${GlobalConstant.FLAG_Y eq doctorAbsence.headAgreeFlag}">
									<img src="<s:url value='/css/skin/${skinPath}/images/gou.png'/>" />
								</c:if>
								${doctorAbsence.headName}
							</c:if>
							<c:if test="${empty doctorAbsence.headAgreeFlag and
										 doctorAbsence.intervalDay >= sysCfgMap['res_absence_head_day'] and
										 !disagreeFlag}">
								<c:choose>
									<c:when test="${isDue < 0 }">已过期</c:when>
									<c:otherwise><img src="<s:url value='/css/skin/${skinPath}/images/query.gif'/>"/>&nbsp;${doctorAbsence.headName}</c:otherwise>
								</c:choose>
							</c:if>
						</td>
						<c:if test="${sysCfgMap['res_absence_manage_audit'] eq GlobalConstant.FLAG_Y}">
						<td>
							<c:if test="${not empty doctorAbsence.managerAgreeFlag}">
								<c:if test="${GlobalConstant.FLAG_N eq doctorAbsence.managerAgreeFlag}">
									<img src="<s:url value='/css/skin/${skinPath}/images/del3.png'/>" />
								</c:if>
								<c:if test="${GlobalConstant.FLAG_Y eq doctorAbsence.managerAgreeFlag}">
									<img src="<s:url value='/css/skin/${skinPath}/images/gou.png'/>" />
								</c:if>
								${doctorAbsence.managerName}
							</c:if>
							<c:if test="${empty doctorAbsence.managerAgreeFlag and
										 doctorAbsence.intervalDay >= sysCfgMap['res_absence_manage_day'] and
										 !disagreeFlag}">
								<c:choose>
									<c:when test="${isDue < 0 }">已过期</c:when>
									<c:otherwise><img src="<s:url value='/css/skin/${skinPath}/images/query.gif'/>"/></c:otherwise>
								</c:choose>
							</c:if>
						</td>
						</c:if>
						<td>
							<c:if test="${GlobalConstant.FLAG_Y eq doctorAbsence.repealAbsence}">
								已销假	
							</c:if>
							<c:if test="${repealFlag}">
								未销假	
							</c:if>
						</td>
						<td>
						<c:if test="${repealFlag}">
							<a href="javascript:repealAbsence('${doctorAbsence.absenceFlow}');">销假</a>
						</c:if>
						<c:if test="${(empty doctorAbsence.teacherAgreeFlag) and (empty doctorAbsence.headAgreeFlag) and (empty doctorAbsence.managerAgreeFlag)}">
							<a href="javascript:editAbsence('${doctorAbsence.absenceFlow}');">编辑</a> |
							<a href="javascript:delAbsence('${doctorAbsence.absenceFlow}');">删除</a>
						</c:if>
						</td>
					</tr>
				</c:forEach>
				
				<c:if test="${empty doctorAbsenceList}">
					<tr>
						<td colspan="10">无记录</td>
					</tr>
				</c:if>
			</table>
			</form>
			<p>
			   	<c:set var="pageView" value="${pdfn:getPageView2(doctorAbsenceList, 10)}" scope="request"/> 
				<pd:pagination toPage="toPage"/>
			</p>
			
			
			<!-- 				
			<table class="basic" width="100%">
				<tr>
					<th colspan="10" style="text-align: left;">&#12288;补实习记录</th>
				</tr>
				<tr style="font-weight: bold;">
					<td width="200px">科室</td>
					<td width="250px;">时间</td>
					<td width="100px;">带教老师</td>
					<td width="100px;">科室主任</td>
					<td width="100px;">医教部门</td>
				</tr>

				<tr>
					<td style="text-align: center; ">内科</td>
					<td>2014-03-12 ~ 2014-03-15&#12288;</td>
					<td>
					
					张茜</td>
					<td>
					
					李凯</td>
					<td>
					
					王军</td>
				</tr>
			</table>
			<div style="float: right;margin-top: 10px;">
				<table style="line-height: 30px;">
					<tr><td>备注：</td><td>1、病假事假连续或累计超过一周后的假期必须补实习</td></tr>
					<tr><td></td><td>2、补实习一般就地利用休息日进行。单科联系假期超过一周者，原则上实习结束后回校补实习</td></tr>
					<tr><td></td><td>3、假期后应及时补实习，由医教科安排，实习生找指定老师补实习</td></tr>
					<tr><td></td><td>4、对于课程考核不及格者，需重修(补实习)，重修合格者方可毕业。</td></tr>
				</table>
			</div>
			 -->
			 </div>
		</div>
	</div>
</body>
</html>