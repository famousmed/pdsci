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
function add(typeId,typeName) {
	jboxOpen("<s:url value='/edc/visit/editIE'/>?typeId="+typeId, "新增"+typeName, 500, 400);
}

function edit(ieFlow,typeName) {
	jboxOpen("<s:url value='/edc/visit/editIE'/>?ieFlow="+ ieFlow, "编辑"+typeName, 500, 400);
}

function del(ieFlow) {
	jboxConfirm("确认删除该条记录吗？" , function(){
		doDel(ieFlow);
	});
}

function doDel(ieFlow) {
	jboxGet("<s:url value='/edc/visit/delIE'/>?ieFlow="+ieFlow,null,function(){
		window.location.reload(true);		
	},null,true);	
}

function impEdcIE() {
	jboxConfirm("确定导入?",function(){
		jboxGet("<s:url value='/edc/visit/impEdcIE'/>",null,function(){
			window.location.reload(true);
		},null,true);
	});
}
</script>
</head>
<body>
	<div class="mainright">
		<div class="content">
			<div style="margin-top: 5px;">
				<c:if test="${projParam.designLock !=  GlobalConstant.FLAG_Y && projParam.projLock !=  GlobalConstant.FLAG_Y }">
					<input type="button" value="导&#12288;入" class="search" onclick="impEdcIE();"/>
				</c:if>
				&#12288;
				<c:if test="${projParam.designLock ==  GlobalConstant.FLAG_Y || projParam.projLock ==  GlobalConstant.FLAG_Y}"> 
					<font color="red">当前项目已锁定设计，无法修改!</font>
				</c:if>
			</div>
		<div class="title1 clearfix">
			<table class="xllist" style="width: 100%">
				<tr>
					<th width="20px">序号</th>
					<th width="200px">名称</th>
					<th width="60px">变量名</th>
					<th width="60px">输入类型</th>
					<th width="60px">允许通过值</th>
					<th width="70px">允许录入最大值</th>
					<th width="70px">允许录入最小值</th>
					<th width="70px">操作</th>
				</tr>
				<tbody>
					<tr>
						<th colspan="8" style="text-align: left;">&#12288;纳入标准
						<c:if test="${projParam.designLock !=  GlobalConstant.FLAG_Y && projParam.projLock !=  GlobalConstant.FLAG_Y}">
							<span style="float: right;margin-right: 15px;"><img title="新增${edcIETypeEnumInclude.name }" onclick="add('${edcIETypeEnumInclude.id }','${edcIETypeEnumInclude.name }');" src="${ctxPath }/css/skin/${skinPath}/images/add3.png" style="cursor: pointer;"></span>
						</c:if>
						</th>
					</tr>
					<c:forEach items="${inList}" var="in">
						<tr>
							<td width="20px">${in.ordinal }</td>
							<td width="200px" style="text-align: left;padding-left:10px;">${in.ieName }</td>
							<td width="60px">${in.ieVarName }</td>
							<td width="60px">${in.inputTypeName }</td>
							<td width="60px">${in.passedValue }</td>
							<td width="70px">${in.maxValue }</td>
							<td width="70px">${in.minValue }</td>
							<td width="70px">
							 <c:if test="${projParam.designLock !=  GlobalConstant.FLAG_Y && projParam.projLock !=  GlobalConstant.FLAG_Y}">
							 [<a href="javascript:edit('${in.ieFlow}','${edcIETypeEnumInclude.name }')">编辑</a>] |
							 [<a href="javascript:del('${in.ieFlow}')">删除</a>]
							 </c:if>
							 </td>
						</tr>
					</c:forEach>
				<c:if test="${inList == null || inList.size()==0 }"> 
					<tr> 
						<td style="text-align: center;" colspan="8">无记录</td>
					</tr>
				</c:if>
				<tr>
					<th colspan="8" style="text-align: left;">&#12288;排除标准
					<c:if test="${projParam.designLock !=  GlobalConstant.FLAG_Y && projParam.projLock !=  GlobalConstant.FLAG_Y}">
						<span style="float: right;margin-right: 15px;"><img title="新增${edcIETypeEnumExclude.name }" onclick="add('${edcIETypeEnumExclude.id }','${edcIETypeEnumExclude.name }');" src="${ctxPath }/css/skin/${skinPath}/images/add3.png" style="cursor: pointer;"></span>
					</c:if>
					</th>
				</tr>
				<c:forEach items="${exList}" var="ex">
					<tr>
						<td width="20px">${ex.ordinal }</td>
						<td width="200px" style="text-align: left;padding-left:10px;">${ex.ieName }</td>
						<td width="60px">${ex.ieVarName }</td>
						<td width="60px">${ex.inputTypeName }</td>
						<td width="60px">${ex.passedValue }</td>
						<td width="70px">${ex.maxValue }</td>
						<td width="70px">${ex.minValue }</td>
						<td width="70px">
							 <c:if test="${projParam.designLock !=  GlobalConstant.FLAG_Y && projParam.projLock !=  GlobalConstant.FLAG_Y}">
							 [<a href="javascript:edit('${ex.ieFlow}','${edcIETypeEnumExclude.name }')" >编辑</a>] |
							 [<a href="javascript:del('${ex.ieFlow}')" >删除</a>]
							 </c:if>
						</td>
					</tr>
				</c:forEach>
				<c:if test="${exList == null || exList.size()==0 }"> 
					<tr> 
						<td style="text-align: center;" colspan="8">无记录</td>
					</tr>
				</c:if>
				</tbody>
			</table>
		</div>
   </div>
   </div>
</body>
</html>