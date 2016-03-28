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
		function show(moduleCode) {
			window.location.href="<s:url value='show?moduleCode='/>"+moduleCode;
		}
		
		function doDel(msgFlow){
			jboxGet("<s:url value='/pub/msg/delete?msgFlow='/>" + msgFlow,null,function(){
				jboxTip(data);
				window.location.href="<s:url value='list'/>";
			});
		}
		function doClose(){
			jboxClose();
		}
		function delEmptyTr(obj){
		   var tr=obj.parentNode.parentNode;
           tr.remove();
		}
		function addTr(){
			$('#eleTable').append($("#template tr:eq(0)").clone());
		}
		function edit(eleCode){
			
		}
	</script>
             <div class="title1 clearfix" style="overflow: auto;">
 <form id="searchForm" action="<s:url value="/pub/moudle/list" />" method="post" > 
     	模块名称：${module.moduleName }
</form>
	<table class="xllist" id="eleTable"> 
		<tr>
			<th width="50px">序号</th>
			<th width="200px">名称</th>
			<th width="100px">变量名</th>
			<th width="100px">操作</th>
		</tr>
		<c:forEach items="${elements}" var="element" >
		<tr  id="${element.elementCode }.list" style="display: ">
			<td width="50px">${element.ordinal}
				<input type="hidden" name="elementFlow" value="${element.elementFlow }"/>
			</td>	  
			<td width="200px">${element.elementName}</td>
			<td width="100px">${element.elementVarName}</td>
			<td width="100px">
				 [<a href="javascript:edit('${element.elementCode }');" >编辑</a>]
				 [<a href="javascript:delElement('${element.elementCode }');" >废止</a>] 
			</td>
		</tr>
		<tr style="display: none " id="${element.elementCode }.edit" >
			<td ><input type="text" style="width: 30px" name="ordinal" value="${element.ordinal}"/>
				<input type="hidden" name="elementFlow" value="${element.elementFlow }"/>
			</td>	  
			<td><input type="text" style="width: 150px" name="elementName" value=" ${element.elementName}"/></td>
			<td><input type="text" style="width: 100px" name="elementVarName" value=" ${element.elementVarName}"/></td>
			<td>
				 [<a href="javascript:delElement('${moudle.moduleFlow}');" >保存</a>]
				 [<a href="javascript:delElement('${moudle.moduleFlow}');" >废止</a>] 
			</td>
		</tr>
	   </c:forEach>
</table>
<table style="display: none" id="template">
 <tr >
	   		<td ><input type="text" style="width: 30px" name="ordinal" value=""/></td>	  
			<td><input type="text" style="width: 150px" name="elementName" value=""/></td>
			<td><input type="text" style="width: 100px" name="elementVarName" value=""/></td>
			<td>	
				 [<a href="javascript:delEmptyTr(this)">保存</a>]
				  [<label onclick="delEmptyTr(this)" style="color:blue" >废止</label>]
			</td>
	   </tr>
</table>
 <div align="center">
 <input type="button" class="dingdan-d" onclick="addTr();" value="新增" >
 <input type="button" class="dingdan-d" onclick="edit('');" value="保存">
 <input type="button" value="关闭" onclick="doClose();" class="dingdan-d"/>
                </div>
</div>
</body>
</html>