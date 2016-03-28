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
	<jsp:param name="jquery_ui_sortable" value="true"/>
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
	var fixHelper = function(e, ui) {
	     ui.children().each(function() {
	    	//在拖动时，拖动行的cell（单元格）宽度会发生改变。在这里做了处理就没问题了  
	         $(this).width($(this).width());
	     });
	     return ui;
	};
	$(function() {
	    $( "#main" ).sortable({
	    	helper: fixHelper,  
	    	create: function(e, ui){
	    	},
	    	start:function(e, ui){
	    	     //拖动时的行，要用ui.helper
	    	    ui.helper.css({"background":"#eee"});
	    	    return ui; 
	    	}, 
	    	stop: function( event, ui ) {
	    		ui.item.css({"background":"#fff"});
	    		var sortedIds = $( "#main" ).sortable( "toArray" );
	    		var postdata = "";
	    		$.each(sortedIds,function(i,sortedId){
	    			postdata = postdata+"&moduleCode="+sortedId;
	    		});
	    		var url = "<s:url value='/edc/visit/savePageModuleOrder'/>?visitFlow="+'${visit.visitFlow }';
	    		jboxPost(url, postdata, function() {
	    			},null,false);
	    	}
	    });
	    //$( "#attrDiv" ).disableSelection();
	     <c:forEach items="${projDescForm.visitModuleMap[visit.visitFlow]}" var="visitModule" >
	    $( "#eleSortable_${visitModule.moduleCode }" ).sortable({
	    	helper: fixHelper,  
	    	create: function(e, ui){
	    	},
	    	start:function(e, ui){
	    	     //拖动时的行，要用ui.helper
	    	    ui.helper.css({"background":"#eee"});
	    	    return ui; 
	    	}, 
	    	stop: function( event, ui ) {
	    		ui.item.css({"background":"#fff"});
	    		var sortedIds = $( "#eleSortable_${visitModule.moduleCode }" ).sortable( "toArray" );
	    		var postdata = "";
	    		$.each(sortedIds,function(i,sortedId){
	    			postdata = postdata+"&elementCode="+sortedId;
	    		});
	    		var url = "<s:url value='/edc/visit/savePageElementOrder'/>?visitFlow="+'${visit.visitFlow }';
	    		jboxPost(url, postdata, function() {
	    			},null,false);
	    	}
	    });
	    </c:forEach>
	    
	    <c:forEach items="${projDescForm.visitModuleMap[visit.visitFlow]}" var="visitModule" >
	    <c:set var="moduleCode" value="${visitModule.moduleCode }"></c:set>
	    <c:set var="commCode" value="${visit.visitFlow }_${visitModule.moduleCode }"></c:set>
 		<c:forEach items="${projDescForm.visitModuleElementMap[commCode]}" var="visitElement">
	    $( "#attrSortable_${ visitElement.elementCode}" ).sortable({
	    	helper: fixHelper,  
	    	create: function(e, ui){
	    	},
	    	start:function(e, ui){
	    	     //拖动时的行，要用ui.helper
	    	    ui.helper.css({"background":"#eee"});
	    	    return ui; 
	    	}, 
	    	stop: function( event, ui ) {
	    		ui.item.css({"background":"#fff"});
	    		var sortedIds = $( "#attrSortable_${ visitElement.elementCode}" ).sortable( "toArray" );
	    		var postdata = "";
	    		$.each(sortedIds,function(i,sortedId){
	    			postdata = postdata+"&attrCode="+sortedId;
	    		});
	    		var url = "<s:url value='/edc/visit/savePageAttributeOrder'/>?visitFlow="+'${visit.visitFlow }';
	    		jboxPost(url, postdata, function() {
	    			},null,false);
	    	}
	    });
	    </c:forEach>
	    </c:forEach>
	});
	function orderVisitModule(visitFlow,moduleCode,ordinal){
		if(ordinal==""){
			return;
		}
		jboxGet("<s:url value='/edc/visit/savePageModuleOrder2'/>?visitFlow="+visitFlow+"&moduleCode="+moduleCode+"&ordinal="+ordinal,null,function(){
			
		},null,false);
	}
</script>
</head>
<body> 
<form id="inputForm" style="height: 100%">
<div class="title1 clearfix" >
     	&#12288;访视名称：<b>${visit.visitName }</b>&#12288;&#12288;
     <hr />
</div>
<div class="main_fix">
		<div id="main" >
 <c:forEach items="${projDescForm.visitModuleMap[visit.visitFlow]}" var="visitModule" >
 <c:set var="moduleCode" value="${visitModule.moduleCode }"></c:set>
 <c:set var="commCode" value="${visit.visitFlow }_${moduleCode }"></c:set>
 <div class="company-js martop" id="${moduleCode }">
 <fieldset>
 	<legend><input type="text" name="ordinal_${ moduleCode}" value='${visitModule.ordinal }' onblur="orderVisitModule('${visit.visitFlow }','${moduleCode}',this.value);" class="validate[maxSize[5] , custom[integer]] " style="width: 30px;text-align: center;" title="排序码"/>${visitModule.moduleName}</legend>
 	<div id="attrDiv" >
 		<table class="basic" width="100%">
	 			<tbody id="eleSortable_${moduleCode }">
	 		<c:forEach items="${projDescForm.visitModuleElementMap[commCode]}" var="visitElement">
	 		<!-- 设置moduleCode -->
	 		<c:if test="${!empty visitElement.placeholdModuleCode }">
	 			<c:set var="moduleCode" value="${visitElement.moduleCode }"></c:set>
	 		</c:if>
	 		<c:if test="${empty visitElement.placeholdModuleCode }">
	 			<c:set var="moduleCode" value="${visitModule.moduleCode }"></c:set>
	 		</c:if>
	 		<c:set var="commAttrCode" value="${visit.visitFlow }_${moduleCode }_${ visitElement.elementCode}"></c:set>
	 			<c:if test="${empty projDescForm.moduleMap[visitModule.moduleCode].moduleStyleId || moduleStyleEnumSingle.id eq projDescForm.moduleMap[visitModule.moduleCode].moduleStyleId}">
	 			<tr id="${ visitElement.elementCode}">
		 			<th style="width: 15%;padding-left: 10px;text-align: left">${projDescForm.elementMap[visitElement.elementCode].elementName }&#12288;</th>
		 			<td width="400px" id="attrSortable_${ visitElement.elementCode}">
		 			<c:set var="columnCount" value="${projDescForm.elementMap[visitElement.elementCode].columnCount }"></c:set>	
					<!-- 设置宽度 -->
					<c:set  var="attrWidth" value="120px"/>
					<c:set  var="attrCodeWidth" value="150px"/>
					<c:if test="${ empty columnCount || (columnCount == '1')}">
						<c:set  var="attrWidth" value=""/>
						<c:set  var="attrCodeWidth" value=""/>
					</c:if>
		 			<table>
					<c:forEach items="${projDescForm.visitElementAttributeMap[commAttrCode] }"  varStatus="status">
						<c:if test="${empty columnCount}">
							<c:set var="columnCount" value="${projDescForm.visitElementAttributeMap[commAttrCode].size() }"/>
						</c:if>
						<c:if test="${status.index % columnCount eq 0}">
							<tr>
				 			<c:forEach items="${projDescForm.visitElementAttributeMap[commAttrCode] }" var="attr" begin='${status.index}' end="${status.index+columnCount-1}">
				 			<c:set var="commCodeFlow" value="${visit.visitFlow }_${moduleCode }_${ visitElement.elementCode}_${ attr.attrCode}"></c:set>
			 					<!-- 标准单位 -->
			 					<c:set var="value" value=""/>
								<c:if test="${projDescForm.attrMap[attr.attrCode].attrVarName == GlobalConstant.DEFAULT_ATTR_UNIT_VAR_NAME}">
									<c:set var="value" value="${projDescForm.elementStandardUnitMap[visitElement.elementCode] }"/>
								</c:if>
								<span style="float: left;" id="${attr.attrCode }">
			 					<c:if test="${projDescForm.attrMap[attr.attrCode].isViewName eq GlobalConstant.FLAG_Y}">
			 						<span style="width:${attrWidth};float: left;text-align: right ;border: none;">
			 						${projDescForm.attrMap[attr.attrCode].attrName }：
			 						</span>
			 					</c:if>
			 					<span style="width:${attrCodeWidth};float: left;text-align: left ;border: none;">
			 					<!-- 文本/日期 -->
								<c:if test="${ projDescForm.attrMap[attr.attrCode].inputTypeId == '' or projDescForm.attrMap[attr.attrCode].inputTypeId == attrInputTypeEnumText.id or  projDescForm.attrMap[attr.attrCode].inputTypeId == attrInputTypeEnumDate.id }">
									<c:set var="codeTitle" value=""/>
									<!-- 组织代码 -->
									<c:forEach items="${projDescForm.visitAttrCodeMap[commCodeFlow] }" var="code">	
										<c:set var="edcAttrCode" value="${projDescForm.codeMap[code.codeFlow]}"/> 
										<c:set var="codeAndName" value="${edcAttrCode.codeValue }&#12288;${edcAttrCode.codeName }</br>"/>
										<c:set var="codeTitle" value="${codeTitle }${codeAndName }"/>
									</c:forEach>
									<!-- 单位不显示代码 -->
									<c:if test="${projDescForm.attrMap[attr.attrCode].attrVarName == GlobalConstant.DEFAULT_ATTR_UNIT_VAR_NAME}">
										<c:set var="codeTitle" value=""/>
										<c:set var="codeValues" value=""/>
									</c:if>
									<input type="text" class="input mer_input" value="${value }"  title="${codeTitle }"
										<c:if test="${projDescForm.attrMap[attr.attrCode].inputTypeId == attrInputTypeEnumDate.id }">
										  onClick="WdatePicker({dateFmt:'yyyy-MM-dd'})"
										</c:if>
									     />&#12288; 
								</c:if>
				 					<!-- 单选/复选 -->
		 						<c:if test="${projDescForm.attrMap[attr.attrCode].inputTypeId == attrInputTypeEnumRadio.id or projDescForm.attrMap[attr.attrCode].inputTypeId == attrInputTypeEnumCheckbox.id}">
							 		<c:set var="inputTypeId" value="${projDescForm.attrMap[attr.attrCode].inputTypeId }"/>
		 							<c:forEach items="${projDescForm.visitAttrCodeMap[commCodeFlow]}" var="code">
		 								<c:set var="edcAttrCode" value="${projDescForm.codeMap[code.codeFlow]}"/>	 
		 								<input type="${inputTypeId }" id="${attr.attrCode }_${edcAttrCode.codeValue}" name="${attr.attrCode }_1"/> <label for="${attr.attrCode }_${edcAttrCode.codeValue}">${edcAttrCode.codeName }&#12288;</label> 
		 							</c:forEach>
		 						</c:if>
		 						<!-- 下拉-->
		 						<c:if test="${projDescForm.attrMap[attr.attrCode].inputTypeId == attrInputTypeEnumSelect.id }">
		 							<select class="input preview_select">
			 							<option value=""></option>
			 							<c:forEach items="${projDescForm.visitAttrCodeMap[commCodeFlow]}" var="code">	
			 								<c:set var="edcAttrCode" value="${projDescForm.codeMap[code.codeFlow]}"/> 
			 								<option value="${edcAttrCode.codeValue }" >${edcAttrCode.codeName }</option>
			 							</c:forEach>
		 							</select>
		 						</c:if>
		 						</span>
		 						</span>
			 				</c:forEach>
	 					</tr><br>
	 					</c:if>
	 				</c:forEach>
	 				</table>
	 			</td>
	 			</tr>
	 			</c:if>
	 			<c:if test="${moduleStyleEnumDouble.id eq projDescForm.moduleMap[visitModule.moduleCode].moduleStyleId}">
	 			<tr id="${ visitElement.elementCode}">
		 			<th style="text-align: left;padding-left: 10px;">${projDescForm.elementMap[visitElement.elementCode].elementName }&#12288;</th>
		 		</tr>
	 			<tr>
	 			<td id="attrSortable_${ visitElement.elementCode}">
		 			<c:set var="columnCount" value="${projDescForm.elementMap[visitElement.elementCode].columnCount }"></c:set>	
					<!-- 设置宽度 -->
					<c:set  var="attrWidth" value="120px"/>
					<c:set  var="attrCodeWidth" value="150px"/>
					<c:if test="${ empty columnCount || (columnCount == '1')}">
						<c:set  var="attrWidth" value=""/>
						<c:set  var="attrCodeWidth" value=""/>
					</c:if>
		 			<table>
					<c:forEach items="${projDescForm.visitElementAttributeMap[commAttrCode] }"  varStatus="status">
						<c:if test="${empty columnCount}">
							<c:set var="columnCount" value="${projDescForm.visitElementAttributeMap[commAttrCode].size() }"/>
						</c:if>
						<c:if test="${status.index % columnCount eq 0}">
							<tr>
				 			<c:forEach items="${projDescForm.visitElementAttributeMap[commAttrCode] }" var="attr" begin='${status.index}' end="${status.index+columnCount-1}">
				 			<c:set var="commCodeFlow" value="${visit.visitFlow }_${moduleCode }_${ visitElement.elementCode}_${ attr.attrCode}"></c:set>
			 					<!-- 标准单位 -->
			 					<c:set var="value" value=""/>
								<c:if test="${projDescForm.attrMap[attr.attrCode].attrVarName == GlobalConstant.DEFAULT_ATTR_UNIT_VAR_NAME}">
									<c:set var="value" value="${projDescForm.elementStandardUnitMap[visitElement.elementCode] }"/>
								</c:if>
								<span style="float: left;" id="${attr.attrCode }">
			 					<c:if test="${projDescForm.attrMap[attr.attrCode].isViewName eq GlobalConstant.FLAG_Y}">
			 						<span style="width:${attrWidth};float: left;text-align: right ;border: none;">
			 						${projDescForm.attrMap[attr.attrCode].attrName }：
			 						</span>
			 					</c:if>
			 					<span style="width:${attrCodeWidth};float: left;text-align: left ;border: none;">
			 					<!-- 文本/日期 -->
								<c:if test="${ projDescForm.attrMap[attr.attrCode].inputTypeId == '' or projDescForm.attrMap[attr.attrCode].inputTypeId == attrInputTypeEnumText.id or  projDescForm.attrMap[attr.attrCode].inputTypeId == attrInputTypeEnumDate.id }">
									<c:set var="codeTitle" value=""/>
									<!-- 组织代码 -->
									<c:forEach items="${projDescForm.visitAttrCodeMap[commCodeFlow] }" var="code">	
										<c:set var="edcAttrCode" value="${projDescForm.codeMap[code.codeFlow]}"/> 
										<c:set var="codeAndName" value="${edcAttrCode.codeValue }&#12288;${edcAttrCode.codeName }</br>"/>
										<c:set var="codeTitle" value="${codeTitle }${codeAndName }"/>
									</c:forEach>
									<!-- 单位不显示代码 -->
									<c:if test="${projDescForm.attrMap[attr.attrCode].attrVarName == GlobalConstant.DEFAULT_ATTR_UNIT_VAR_NAME}">
										<c:set var="codeTitle" value=""/>
										<c:set var="codeValues" value=""/>
									</c:if>
									<input type="text" class="input mer_input" value="${value }"  title="${codeTitle }"
										<c:if test="${projDescForm.attrMap[attr.attrCode].inputTypeId == attrInputTypeEnumDate.id }">
										  onClick="WdatePicker({dateFmt:'yyyy-MM-dd'})"
										</c:if>
									     />&#12288; 
								</c:if>
				 					<!-- 单选/复选 -->
		 						<c:if test="${projDescForm.attrMap[attr.attrCode].inputTypeId == attrInputTypeEnumRadio.id or projDescForm.attrMap[attr.attrCode].inputTypeId == attrInputTypeEnumCheckbox.id}">
							 		<c:set var="inputTypeId" value="${projDescForm.attrMap[attr.attrCode].inputTypeId }"/>
		 							<c:forEach items="${projDescForm.visitAttrCodeMap[commCodeFlow]}" var="code">
		 								<c:set var="edcAttrCode" value="${projDescForm.codeMap[code.codeFlow]}"/>	 
		 								<input type="${inputTypeId }" id="${attr.attrCode }_${edcAttrCode.codeValue}" name="${attr.attrCode }_1"/> <label for="${attr.attrCode }_${edcAttrCode.codeValue}">${edcAttrCode.codeName }&#12288;</label> 
		 							</c:forEach>
		 						</c:if>
		 						<!-- 下拉-->
		 						<c:if test="${projDescForm.attrMap[attr.attrCode].inputTypeId == attrInputTypeEnumSelect.id }">
		 							<select class="input preview_select">
			 							<option value=""></option>
			 							<c:forEach items="${projDescForm.visitAttrCodeMap[commCodeFlow]}" var="code">	
			 								<c:set var="edcAttrCode" value="${projDescForm.codeMap[code.codeFlow]}"/> 
			 								<option value="${edcAttrCode.codeValue }" >${edcAttrCode.codeName }</option>
			 							</c:forEach>
		 							</select>
		 						</c:if>
		 						</span>
		 						</span>
			 				</c:forEach>
	 					</tr><br>
	 					</c:if>
	 				</c:forEach>
	 				</table>
	 			</td>
	 			</tr>
	 			</c:if>
	 		</c:forEach>
	 			</tbody>
 		</table>
 	</div>
 	</fieldset>
 </div>
 </c:forEach>
 </div></div>
 <input type="hidden" name="inputStatus" id="inputStatus" value="${param.inputStatusId}"/>
 </form>
</body>
</html>