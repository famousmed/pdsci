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
<script type="text/javascript">
	function apply(){
		jboxConfirm("确认新增伦理审查申请？" ,function(){
			window.location.href="<s:url value='/irb/researcher/applyMain'/>?roleScope=${roleScope}";
		});
	}
	function search(){
		jboxStartLoading();
		$("#searchForm").submit();
	}
	function toPage(page) {
		if(page!=undefined){
			$("#currentPage").val(page);			
		}
		search();
	}
	function cancleOthers(){
		$("[name='projNo']").val("");
		$("[name='projShortName']").val("");
		$("[name='applyUserName']").val("");
		$("#deptFlow").val("");
		$("[name='quickDatePickType']").attr("checked",false);
	}
	
</script>
</head>
<body>
<div class="mainright">
	<div class="content">
		<div class="title1 clearfix">
			<form id="searchForm" action="<s:url value="/irb/researcher/list/global" />"
				method="post">
				<p style="text-align: left;">
					项目名称：
					<input type="text" name="projShortName"  value="${param.projShortName}" style="width:150px" />
					承担科室：
					<select id="deptFlow" name="deptFlow" style="width: 120px;">
						<option value="">请选择</option>
						<c:forEach items="${sysDeptList }" var="dept">
							<option value="${dept.deptFlow}" <c:if test="${dept.deptFlow==param.deptFlow }">selected="selected"</c:if> >${dept.deptName }</option>
						</c:forEach>
					</select>  
					主要研究者：
					<input type="text" name="applyUserName"  value="${param.applyUserName }" style="width: 60px;"/>&#12288;
					<input type="checkbox" title="本月申报/提交送审或受理的项目" name="quickDatePickType" id="${quickDatePickEnumMonth.id }" onclick="search();" value="${quickDatePickEnumMonth.id }" <c:if test="${param.quickDatePickType==quickDatePickEnumMonth.id  }">checked</c:if>/><label for="${quickDatePickEnumMonth.id }" title="本月申报/提交送审或受理的项目">一个月内</label>&#12288;
					<input type="checkbox" title="${meetingDate }上会项目" name="lastMeeting" id="lastMeeting" onclick="cancleOthers();search();" value="lastMeeting" <c:if test="${param.lastMeeting=='lastMeeting'  }">checked</c:if>/><label for="lastMeeting" title="${meetingDate }上会项目">最近会议</label>&#12288;
					<input type="button" class="search" style="float: right" onclick="apply();" value="初始审查申请">&#12288;
					<input type="button" class="search" style="float: right" onclick="search();" value="查&#12288;询">&#12288;
				</p>
			</form>
		</div> 
		<table class="xllist">
			<thead>
				<tr>
					<th width="5%" >序号</th>
					<c:if test="${GlobalConstant.FLAG_Y eq pdfn:getSysCfg('irb_projno_flag') }">
						<th width="10%" >项目编号</th>
					</c:if>
					<th width="45%" >项目名称</th>
					<th width="15%" >项目类别</th>
					<th width="25%" >项目来源</th>
					<th width="15%" >承担科室</th>
					<th width="15%" >主要研究者</th>
					<!-- 
					<th width="10%" >批件日期</th>
					<th width="10%" >批件有效期</th>
					<th width="10%" >跟踪审查日期</th>
					 -->
					<th width="5%" >操作</th>
				</tr>
			</thead>
			<tbody>
				<c:forEach items="${projList }" var="proj" varStatus="vs">
					<tr>
						<td>${vs.count }</td>
						<c:if test="${GlobalConstant.FLAG_Y eq pdfn:getSysCfg('irb_projno_flag') }">
							<td>${proj.projNo }</td>
						</c:if>
						<td>${proj.projShortName }</td>
						<td>${proj.projSubTypeName }</td>
						<td>${proj.projShortDeclarer}</td>
						<td>${proj.applyDeptName}</td>
						<td>${proj.applyUserName}</td>
						<!-- 
						<td>${pdfn:split(irbDateMap[proj.projFlow],"_")[0] }</td>
						<td>${pdfn:split(irbDateMap[proj.projFlow],"_")[1] }${empty pdfn:split(irbDateMap[proj.projFlow],"_")[1]?"": "个月"}</td>
						<td>${pdfn:split(irbDateMap[proj.projFlow],"_")[2] }</td>
						 --><td>[<a href="<s:url value='/irb/researcher/process'/>?projFlow=${proj.projFlow}&roleScope=${roleScope}">进入</a>]</td>
					</tr>
				</c:forEach>
			</tbody>
			<c:if test="${projList == null || projList.size() == 0 }"> 
				<tr> 
					<td align="center" colspan="11">无记录</td>
				</tr>
			</c:if>
		</table>
	</div>
</div>
</body>
</html>