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
<body>

	<script type="text/javascript">
		function doSave(){
			if(false==$("#attrForm").validationEngine("validate")){
				return ;
			}
			if(false==$("#attrCodeForm").validationEngine("validate")){
				return ;
			}
			jboxGet("<s:url value='/pub/module/saveAttrConfirm'/>?elementCode=${element.elementCode}&attrCode=${attr.attrCode}"+"&attrVarName="+$("#attrVarName").val(),null,function(resp){
				if(resp != '${GlobalConstant.OPRE_FAIL}'){
					jboxCloseMessager();
					var j = $("#attrForm").serializeJson();
					var codeTab = $('#attrCodeTable');
					var trs = codeTab.children();
					var datas = [];
					$.each(trs , function(i , n){
						var codeFlow = $(n).find("input[name='codeFlow']").val();
						var ordinal = $(n).find("input[name='ordinal']").val();
						var codeValue =  $(n).find("input[name='codeValue']").val();
						var codeName =  $(n).find("input[name='codeName']").val();
						var data = {
								"codeFlow":codeFlow,
								"ordinal":ordinal,
								"codeValue":codeValue,
								"codeName":codeName
						};
						datas.push(data);
						
					});
					var t = {'attrCodeList':datas,'attr':j};
					jboxPostJson("<s:url value='/pub/module/saveAttr'/>",JSON.stringify(t),function(){
						window.parent.frames['mainIframe'].window.showAttr('${element.elementCode}','${element.elementName}','${element.elementVarName}');
						window.location.reload(true);	
					},null,true); 
				}else{
					jboxTip("属性变量名不能重复!");
				}
			},null,false);
		}
		function addTr(){
			$('#attrCodeTable').append($("#template tr:eq(0)").clone());
		}
		function addUnit(dictId,dictName){
			var tr = $("#template tr:eq(0)").clone();
			tr.find("input:text :first").val(1);
			tr.find("input:text :eq(1)").val(dictId);
			tr.find("input:text :eq(2)").val(dictName);
			$('#attrCodeTable').append(tr);
		}
		function delEmptyTr(obj){
			   var tr=obj.parentNode.parentNode;
	           tr.remove();
		}
		   function delAttrCode(codeFlow,attrCode,codeValue,obj){
			   jboxGet("<s:url value='/pub/module/delAttrCodeConfirm'/>?attrCode="+attrCode+"&codeValue="+codeValue,null,function(resp){
					if(resp != '${GlobalConstant.OPRE_FAIL}'){
						jboxConfirm("确认删除？" , function(){
							   doDel(codeFlow,obj);
						   });
					}else{
						jboxTip("该属性代码已被选入项目库，不能删除!");
					}
				},null,false);
		   }
		   function doDel(codeFlow,obj) {
			   jboxGet("<s:url value='/pub/module/deleteAttrCode?codeFlow='/>" + codeFlow,null,function(){
	    			var tr=obj.parentNode.parentNode;
	    	        tr.remove();
	    			jboxTip(data);
	    			window.parent.frames['mainIframe'].window.showAttr('${element.elementCode}');	
				});
		    }
		   function addStandardUnit(){
				var url ='<s:url value='/pub/module/addStandardUnit'/>';
				var iframe ="<iframe name='jbox-message-iframe' id='jbox-message-iframe' width='100%' height='330px' marginheight='0' marginwidth='0' frameborder='0' scrolling='auto' src='"+url+"'></iframe>";
				jboxMessager(iframe,'单位代码选择',400,300);
		   }
	</script>
	
	<div style="margin-top: 25px;height:100%;"  class="mainright"  >
	<form id="attrForm" style="padding-left: 30px;">
   		 		<table class="mation" style="width: 520px"  >
   		 					<tr>
   		 						<td style="text-align: right" width="100px">元素名称：</td>
   		 						<td>${element.elementName }</td>
   		 					</tr>
   		 					 <tr>
								<td style="text-align: right" width="100px">排序码：</td>
								<td style="text-align: left;padding-left: 5px" >
									<input   class="validate[custom[number]] " style="width: 150px" name="ordinal" type="text" value="${attr.ordinal }" />
									
								</td>
							</tr>
   		 					<tr>
								<td style="text-align: right" width="100px">属性名称：</td>
								<td style="text-align: left; padding-left: 5px" width="200px">
									<input  class="validate[required] "  style="width: 150px" name="attrName" type="text" value="${attr.attrName }" />
								</td>
							</tr>
							
   		 					<tr>
								<td style="text-align: right" width="100px">变量名：</td>
								<td style="text-align: left; padding-left: 5px" width="200px">
									<input  class="validate[required] " id="attrVarName" style="width: 150px" name="attrVarName" type="text" value="${attr.attrVarName }"/>
								</td>
							</tr>
							<tr>
								<td style="text-align: right" width="100px">数据类型：</td>
								<td style="text-align: left; padding-left: 5px"  >
									<select name="dataTypeId" style="width: 154px"  >
										<option value="${attrDataTypeEnumString.id }" <c:if test="${attrDataTypeEnumString.id eq attr.dataTypeId }">selected</c:if>>${attrDataTypeEnumString.name }</option>
										<option value="${attrDataTypeEnumInteger.id }" <c:if test="${attrDataTypeEnumInteger.id eq attr.dataTypeId }">selected</c:if>>${attrDataTypeEnumInteger.name }</option>
										<option value="${attrDataTypeEnumFloat.id }" <c:if test="${attrDataTypeEnumFloat.id eq attr.dataTypeId }">selected</c:if>>${attrDataTypeEnumFloat.name }</option>
										<option value="${attrDataTypeEnumDate.id }" <c:if test="${attrDataTypeEnumDate.id eq attr.dataTypeId }">selected</c:if>>${attrDataTypeEnumDate.name }</option>
									</select>
								</td>
							</tr>
							<tr>
								<td style="text-align: right" width="100px">数据长度：</td>
								<td style="text-align: left; padding-left: 5px" width="200px">
									<input  class="validate[required] "  style="width: 150px" name="dataLength" type="text" value="${!empty attr.dataLength ? attr.dataLength : GlobalConstant.DEFAULT_ATTR_DATA_LENGTH}"/>
								</td>
							</tr>
							<tr>
								<td style="text-align: right" width="100px">小数位长度：</td>
								<td style="text-align: left; padding-left: 5px" >
									<input  class="validate[custom[number]] "  style="width: 150px" name="dataDecimalLength" type="text" value="${attr.dataDecimalLength }"/>
									<input  type="hidden" name="moduleCode" value="${param.moduleCode}"/>
                            		<input  type="hidden" name="elementCode" value="${element.elementCode}"/>
                            		<input  type="hidden" name="attrCode" value="${attr.attrCode}"/>
									<input  type="hidden" name="attrFlow" value="${attr.attrFlow}"/>
                            		<input  type="hidden" name="elementName" value="${element.elementName}"/>
								</td>
							</tr>
							<tr>
								<td style="text-align: right" width="100px">是否显示属性名：</td>
								<td style="text-align: left; padding-left: 5px" >
				     				<select name="isViewName" style="width: 154px">
				     					<option value="${GlobalConstant.FLAG_Y }"  <c:if test="${attr.isViewName eq  GlobalConstant.FLAG_Y }">selected</c:if> >是</option>
				     					<option value="${GlobalConstant.FLAG_N }"  <c:if test="${attr.isViewName eq  GlobalConstant.FLAG_N }">selected</c:if>>否</option>
				     				</select>
				     			</td>
							</tr>
							<tr>
								<td style="text-align: right" width="100px">录入方式：</td>
								<td style="text-align: left; padding-left: 5px" >
				     				<select name="inputTypeId" style="width: 154px">
				     					<option value="${attrInputTypeEnumText.id }"  <c:if test="${attr.inputTypeId eq  attrInputTypeEnumText.id }">selected</c:if> >${attrInputTypeEnumText.name}</option>
				     					<option value="${attrInputTypeEnumRadio.id}"  <c:if test="${attr.inputTypeId eq  attrInputTypeEnumRadio.id }">selected</c:if>>${attrInputTypeEnumRadio.name}</option>
				     					<option value="${attrInputTypeEnumCheckbox.id}"  <c:if test="${attr.inputTypeId eq  attrInputTypeEnumCheckbox.id }">selected</c:if> >${attrInputTypeEnumCheckbox.name}</option>
				     					<option value="${attrInputTypeEnumSelect.id}"  <c:if test="${attr.inputTypeId eq  attrInputTypeEnumSelect.id }">selected</c:if>>${attrInputTypeEnumSelect.name}</option>
				     					<option value="${attrInputTypeEnumDate.id }"  <c:if test="${attr.inputTypeId eq attrInputTypeEnumDate.id }">selected</c:if>>${attrInputTypeEnumDate.name}</option>
				     					<option value="${attrInputTypeEnumTextarea.id }"  <c:if test="${attr.inputTypeId eq attrInputTypeEnumTextarea.id }">selected</c:if>>${attrInputTypeEnumTextarea.name}</option>
				     				</select>
				     			</td>
							</tr>
                            </table>
                            </form>
                            <form id="attrCodeForm" style="padding-left: 30px;">
							<fieldset style="width: 500px"  class="mation" >
								<legend>属性代码[<a href="javascript:addTr();">新增</a>]
								<c:if test="${module.moduleTypeId == GlobalConstant.MODULD_TYPE_LB }">
								[<a href="javascript:addStandardUnit();">单位代码</a>]
								</c:if>
								</legend>
									<table>
										<thead>
										<tr><th width="50px">序号</th><th width="100px">代码值</th><th width="200px">代码描述</th><th width="80px">操作</th></tr>
										</thead>
										<tbody  id="attrCodeTable">
											<c:forEach items="${ attrCodeList}" var="code">
												<tr>
													<td><input type="text" style="width: 30px" class="validate[custom[number]] text" name="ordinal" value="${code.ordinal }"/>
													 <input type="hidden" name="codeFlow" value="${code.codeFlow }"/>
													</td>
													<td><input type="text"  style="width: 80px" class="validate[required] text" name="codeValue" value="${code.codeValue }"/></td>
													<td><input type="text"  style="width: 180px" class="validate[required] text" name="codeName" value="${code.codeName }"/></td>
													<td> [<label onclick="delAttrCode('${code.codeFlow}','${code.attrCode}','${code.codeValue}',this)" style="color:blue" >删除</label>]</td>
												</tr>
											</c:forEach>
										</tbody>
									</table>
							</fieldset>
                            <div align="center" style="height:80px;">
									<input type="button" class="search"  value="保&#12288;存" onclick="doSave();" />
									<input type="button" class="search"  value="关&#12288;闭" onclick="jboxClose();"> 
							</div>
             </form>
   </div>
   <table style="display: none" id="template">
 <tr >
	   		<td ><input type="text" style="width: 30px" class="validate[custom[number]] text" name="ordinal" value=""/></td>	  
			<td ><input type="text"  style="width: 80px" class="validate[required] text" name="codeValue" value=""/></td>
			<td ><input type="text"  style="width: 180px" class="validate[required] text" name="codeName" value=""/></td>
			<td>	
				  [<label onclick="delEmptyTr(this)" style="color:blue" >删除</label>]
			</td>
	   </tr>
</table>
</body>
</html>