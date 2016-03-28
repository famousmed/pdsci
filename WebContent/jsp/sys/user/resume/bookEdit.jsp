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
	function save(){
		var form = $("#editForm");
		if(false==form.validationEngine("validate")){
			return ;
		}
		var requestData = form.serialize();
		var url = "<s:url value='/pub/resume/saveBook?userFlow=${param.userFlow}'/>";
		jboxPost(url,requestData,function(resp){
			if(resp == '${GlobalConstant.SAVE_SUCCESSED}'){
				window.parent.frames['mainIframe'].window.loadBook();
				doClose();
			}
		},null,true);
	}
	
	function doClose(){
		jboxClose();
	}
</script>

</head>
<body>
	<div class="mainright">
		<div class="content">
			<div class="title1 clearfix">
			<form id="editForm" method="post" style="position: relative;">
				<input type="hidden" name="bookFlow" value="${srmAchBook.bookFlow}" />
				<table width="100%" class="basic" >
					<tr>
						<th style="width: 35%">著作名称：</th>
						<td style="width: 65%">
							<input type="text"  class="validate[required] xltext"  name="bookName" value="${srmAchBook.bookName}" style="margin-right: 0px"/>
							<font color="red" >*</font>
						</td>
					</tr>
					<tr>
						<th>出版日期：</th>
						<td>
							<input type="text" onClick="WdatePicker({dateFmt:'yyyy-MM'})"  name="publishDate" value="${srmAchBook.publishDate}" class="ctime" style="width: 160px;" readonly="readonly"/>
						</td>
					</tr>
					<tr>
						<th>出版单位：</th>
						<td>
							<input type="text"  class="xltext"  name="publishOrg" value="${srmAchBook.publishOrg}" />
						</td>
					</tr>
					<tr>
						<th>著作类别：</th>
						<td>
							<select name="typeId" class="xlselect" >
								<option value="">请选择</option>
								<c:forEach var="dict" items="${dictTypeEnumAchBookTypeList}">
									<option value="${dict.dictId}"  <c:if test="${dict.dictName eq srmAchBook.typeName}">selected="selected"</c:if>  >${dict.dictName}</option>
								</c:forEach>
							</select>
						</td>
					</tr>
					<tr>
						<th>出版地：</th>
						<td>
							<select name="pubPlaceId" class="xlselect" >
								<option value="">请选择</option>
								<c:forEach var="dict" items="${dictTypeEnumPlaceNameTypeList}">
									<option value="${dict.dictId}"  <c:if test="${dict.dictName eq srmAchBook.pubPlaceName}">selected="selected"</c:if>  >${dict.dictName}</option>
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

	

		
