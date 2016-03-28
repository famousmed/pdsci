<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@include file="/jsp/common/doctype.jsp" %>
<html>
<head>
<jsp:include page="/jsp/common/htmlhead.jsp">
	<jsp:param name="basic" value="true"/>
	<jsp:param name="jbox" value="true"/>
	<jsp:param name="jquery_form" value="true"/>
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
function save() {
	if(false==$("#editForm").validationEngine("validate")){
		return ;
	}
	var form = $("#editForm");
	var requestData = form.serialize();
	var url = "<s:url value='/pub/resume/saveEdu?userFlow=${userFlow}'/>";
	jboxPost(url,requestData,function(resp){
		if(resp == '${GlobalConstant.SAVE_SUCCESSED}'){
			if ("resDoc"=="${param.source}") {
				window.parent.frames['jbox-iframe'].loadEdu();
				jboxCloseMessager();
			} else {
				window.parent.frames['mainIframe'].window.loadEdu();
				doClose();
			}
		}
	},null,true);			
}

function doClose() {
	if ("resDoc"=="${param.source}") {
		jboxCloseMessager();
	} else {
		jboxClose();
	}
}

</script>

</head>
<body>
<div class="mainright">
    <div class="content">
       <div class="title1 clearfix">
       <form id="editForm" method="post" style="position: relative;">
       <input type="hidden" name="recordId" value="${eduForm.recordId}" />
       <table width="100%" class="basic" >
       		<tr>
       			<th style="width: 35%">开始年月：</th>
       			<td style="width: 65%">
       				<input type="text" onClick="WdatePicker({dateFmt:'yyyy-MM'})"  name="startDate" value="${eduForm.startDate}" class="ctime" style="width: 160px;" readonly="readonly"/>
       			</td>
       		</tr>
       		<tr>
       			<th>结束年月：</th>
       			<td>
       				<input type="text" onClick="WdatePicker({dateFmt:'yyyy-MM'})"  name="endDate" value="${eduForm.endDate}" class="ctime" style="width: 160px;" readonly="readonly"/>
       			</td>
       		</tr>
       		<tr>
       			<th>学校名称：</th>			
       			<td>
       				<input type="text" class="validate[required] xltext"  name="college" value="${eduForm.college}" style="margin-right: 0px"/>
       				<font color="red" >*</font>
       			</td>
       		</tr>
       		<tr>
       			<th>专业：</th>
       			<td>
       				<input type="text"  class="xltext"  name="major" value="${eduForm.major}" />
       			</td>
       		</tr>
       		<tr>
       			<th>学历：</th>
       			<td>
       				<select name="education" class="xlselect" >
						<option value="">请选择</option>
						<c:forEach var="dict" items="${dictTypeEnumUserEducationList}">
							<option value="${dict.dictName}"  <c:if test="${eduForm.education eq dict.dictName}">selected="selected"</c:if>  >${dict.dictName}</option>
						</c:forEach>
					</select>
       			</td>
       		</tr>
       		<tr>
       			<th>学位：</th>
       			<td>
       				<select name="degree" class="xlselect" >
                  		<option value="">请选择</option>
                  		<c:forEach var="dict" items="${dictTypeEnumUserDegreeList}">
                  			<option value="${dict.dictName}" <c:if test="${eduForm.degree eq dict.dictName}">selected="selected"</c:if>  >${dict.dictName}</option> 
               			</c:forEach>
               		</select>
       			</td>
       		</tr>
       </table>
       </form>
       <p style="text-align: center;">
       		<input type="button" onclick="save()"  class="search" value="保&#12288;存"/>
       		<input type="button" onclick="doClose()" class="search" value="关&#12288;闭"/>
       </p>
       
       
       </div>
    </div>
</div>
</body>
</html>