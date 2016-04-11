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
	function saveFactor() {
		if(false==$("#factorForm").validationEngine("validate")){
			return ;
		}
		jboxPost("<s:url value='/edc/random/saveFactor'/>",$('#factorForm').serialize(),function(){
			window.parent.frames['mainIframe'].location.reload(true);
			window.location.reload(true);
		},null,true);
	}
	function doClose() 
	{
		jboxClose();
	}
</script>
</head>
<body>

<form id="factorForm" style="padding-left: 30px;height: 100%;" >
<div class="content">
	<div class="title1 clearfix">
		<div id="tagContent">
			<div class="tagContent selectTag" id="tagContent0">				
				<table width="400" cellpadding="0" cellspacing="0" class="basic">					
					<tr>
						<th>分层：</th>
						<td>
							<input class="validate[custom[number] required] xltext" name="index" type="text"  />
						</td>  
					</tr>
					<tr>
						<th>权重：</th>
						<td>
							<select name="weight" class="validate[required] xlselect" >
								<option></option>
								<c:forEach var="weight"  begin="1" end="10">
								<option value="${weight }" >${weight }</option>
								</c:forEach>
							</select>
				        </td>                                    
				    </tr>
					<tr>   
					
						<th>因素代码：</th>
						<td>
							<input class="validate[custom[number] required] xltext" name="code" type="text" />
						</td> 
		            </tr>
					<tr>
						<th>因素名称：</th>
						<td >
							<input class="validate[required] xltext" name="name" type="text"  />
					    </td> 
					</tr>
				</table>
				<div class="button" style="width: 400px;">
					<input type="button" class="search" value="保&#12288;存" onclick="saveFactor();" />
					<input type="button" class="search" onclick="doClose();" value="关&#12288;闭">
				</div>
			</div>
		</div>
	</div>
</div>
</form>
</body>
</html>