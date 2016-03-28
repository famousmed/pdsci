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
</head>
</head>
<body>

	<script type="text/javascript">
		function doSave(){
			if(false==$("#eleForm").validationEngine("validate")){
				return ;
			}
			
			jboxGet("<s:url value='/pub/module/saveElementConfirm'/>?elementCode=${pubElement.elementCode}&elementVarName="+$("#elementVarName").val(),null,function(resp){
				if(resp != '${GlobalConstant.OPRE_FAIL}'){
					jboxPost("<s:url value='/pub/module/saveElement'/>?moduleCode=${module.moduleCode}", $('#eleForm').serialize(),function(){
						window.parent.frames['mainIframe'].window.showElement('${module.moduleCode}');
						window.location.reload(true);
					},null,true);
				}else{
					jboxTip("系统已存在该变量名,请修改!");
				}
			},null,false);
		}
	</script>
	
	<div style="margin-top: 25px;"   > 
	<form id="eleForm" style="padding-left: 33px;height: 100px;" >
   		 		<table class="mation" style="width: 400px"  >
   		 					 <tr>
								<td style="text-align: right" width="100px">排序码：</td>
								<td style="text-align: left;padding-left: 5px" width="200px">
									<!-- 原先的value为:${sysDept.ordinal } -->
									<input type="hidden" name="elementFlow" value="${pubElement.elementFlow}"/>
									<input class="text validate[custom[number]] validate[required]"   class="text" name="ordinal" type="text" value="${pubElement.ordinal }" />
									
								</td>
							</tr>
   		 					<tr>
								<td style="text-align: right" width="100px">元素名：</td>
								<td style="text-align: left; padding-left: 5px" width="200px">
									<input class="validate[required] text" value="${pubElement.elementName}"  class="validate[required] text"  name="elementName" type="text"  />
								</td>
							</tr>
							
   		 					<tr>
								<td style="text-align: right" width="100px">变量名：</td>
								<td style="text-align: left; padding-left: 5px" width="200px">
									<input class="validate[required] text" value="${pubElement.elementVarName}"  class="validate[required] text" id="elementVarName"  name="elementVarName" type="text"/>
								</td>
							</tr>
   		 					<tr>
								<td style="text-align: right" width="100px">多次录入：</td>
								<td style="text-align: left; padding-left: 5px" width="200px">
									<select name="elementSerial"  class="text">
										<option value="${GlobalConstant.FLAG_N }"  <c:if test="${pubElement.elementSerial eq  GlobalConstant.FLAG_N }">selected</c:if>>否</option>
										<option value="${GlobalConstant.FLAG_Y }"  <c:if test="${pubElement.elementSerial eq  GlobalConstant.FLAG_Y}">selected</c:if>  >是</option>
									</select>
								</td>
							</tr>
							<tr>
								<td style="text-align: right" width="100px">默认属性：</td>
								<td >
								<input type="checkbox" name="${GlobalConstant.DEFAULT_ATTR_VALUE_VAR_NAME }" value="${GlobalConstant.FLAG_Y }" checked="checked" id="val" 
								<c:if test="${!empty pubElement.elementFlow}"> disabled</c:if>/><label for="val">录入值&#12288;</label>
								<c:if test="${module.moduleTypeId == GlobalConstant.MODULD_TYPE_LB }">
									<input type="checkbox" name="${GlobalConstant.DEFAULT_ATTR_UNIT_VAR_NAME }"  value="${GlobalConstant.FLAG_Y }" checked="checked" id="unit"
									<c:if test="${!empty pubElement.elementFlow}"> disabled</c:if>/><label for="unit">单位&#12288;</label>
									<input type="checkbox" name="${GlobalConstant.DEFAULT_ATTR_ABNORMAL_VAR_NAME }" value="${GlobalConstant.FLAG_Y }"  checked="checked" id="abnormal"
									<c:if test="${!empty pubElement.elementFlow}"> disabled</c:if>/><label for="abnormal">是否异常&#12288;</label>
								</c:if>
								</td>
							</tr>
							<tr>
								<td style="text-align: right" width="100px">属性显示数：</td>
								<td style="text-align: left; padding-left: 5px" width="200px">
									<select name="columnCount"  class="text" style="width: 140px;" >
										<option <c:if test="${pubElement.columnCount eq  '' }">selected</c:if> value=""></option>
										<option <c:if test="${pubElement.columnCount eq  '1' }">selected</c:if> value="1">1</option>
										<option <c:if test="${pubElement.columnCount eq  '2' }">selected</c:if> value="2">2</option>
										<option <c:if test="${pubElement.columnCount eq  '3' }">selected</c:if> value="3">3</option>
										<option <c:if test="${pubElement.columnCount eq  '4' }">selected</c:if> value="4">4</option>
									</select>
								</td>
							</tr>
                            </table>
                            <div align="center">
									<input type="button" value="保&#12288;存" class="search"  onclick="doSave();" />
									<input type="button" class="search" onclick="jboxClose();" value="关&#12288;闭">
									<input type="hidden" name="moduleTypeId" value="${module.moduleTypeId}">
							</div>
             </form>
   </div>
</body>
</html>