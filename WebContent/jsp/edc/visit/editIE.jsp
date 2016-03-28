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
	<jsp:param name="jquery_ui_combobox" value="true"/>
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
		if(false==$("#ieForm").validationEngine("validate")){
			return ;
		}
		jboxPost("<s:url value='/edc/visit/saveIE'/>?ieFlow=${ie.ieFlow}", $('#ieForm').serialize(), function() {
			window.parent.frames['mainIframe'].location.reload(true);
			jboxClose();
		});
	}

	function doClose() {
		jboxClose();
	}
	
	function changePassedValue(obj) {
		var inputTypeId = $(obj).val();
		if ("${appItemInputTypeEnumNumber.id}" == inputTypeId) {
			$("#passedValueTr").css("display","none");
			$("#maxValueTr").css("display","");
			$("#minValueTr").css("display","");
		} else if ("${appItemInputTypeEnumBool.id}" == inputTypeId) {
			$("#maxValueTr").css("display","none");
			$("#minValueTr").css("display","none");
			$("#passedValueTr").css("display","");
		}
	}
	
	$(document).ready(function(){
		changePassedValue($("#inputTypeId"));
	});
</script>
</head>
<body>

<form id="ieForm" style="position: relative;" style="padding-left: 10px;height: 100px;" >
<div class="content">
	<div class="title1 clearfix">
		<div id="tagContent">
			<div class="tagContent selectTag" id="tagContent0"  align="center">				
				<table width="400" cellpadding="0" cellspacing="0" class="basic">					
					<tr>
						<th>序号：</th>
						<td>
							<input class="xltext" name="ordinal" type="text" value="${ie.ordinal }" />
							<input class="xltext" name="typeId" type="hidden" value="${typeId }" />
						</td>  
					</tr>
					<tr>
						<th>${typeName }名称：</th>
						<td>
							<input class="validate[required] xltext" name="ieName" type="text" value="${ie.ieName }" />
				        </td>                                    
				    </tr>
				    <tr>
						<th>${typeName }变量名：</th>
						<td>
							<input class="validate[required] xltext" name="ieVarName" type="text" value="${ie.ieVarName }" />
				        </td>                                    
				    </tr>
					<tr>   
						<th>输入类型：</th>
						<td>
							<select class="validate[required] xlselect" id="inputTypeId" name="inputTypeId" onchange="changePassedValue(this)">
								<option value="">请选择</option>
								<c:forEach items="${appItemInputTypeEnumList}" var="itemInputType"> 
								<option value="${itemInputType.id }" <c:if test="${ie.inputTypeId == itemInputType.id }">selected</c:if>>${itemInputType.name }</option>
								</c:forEach>
							</select>
						</td> 
		            </tr>
		            <tr id="passedValueTr" style="display: none">
						<th>允许通过值：</th>
						<td>
							<select class="validate[required] xlselect" name="passedValue" onchange="changePassedValue(this)">
								<option value="true" <c:if test="${ie.passedValue == 'true' || (empty ie.passedValue && edcIETypeEnumInclude.id == typeId)}">selected</c:if>>true</option>
								<option value="false" <c:if test="${ie.passedValue == 'false' || (empty ie.passedValue && edcIETypeEnumExclude.id == typeId)}">selected</c:if>>false</option>
							</select>
				        </td>                                    
				    </tr>
				    <tr id="maxValueTr" style="display: none">
						<th>允许录入最大值：</th>
						<td>
							<input class="xltext" name="maxValue" type="text" value="${ie.maxValue }" />
				        </td>                                    
				    </tr>
				    <tr id="minValueTr" style="display: none">
						<th>允许录入最小值：</th>
						<td>
							<input class="xltext" name="minValue" type="text" value="${ie.minValue }" />
				        </td>                                    
				    </tr>
				</table>
				<div class="button" style="width: 400px;">
					<input type="button" class="search" value="保&#12288存" onclick="save();" />
					<input type="button" class="search" value="关&#12288闭" onclick="doClose();">
				</div>
			</div>
		</div>
	</div>
</div>
</form>
</body>
</html>