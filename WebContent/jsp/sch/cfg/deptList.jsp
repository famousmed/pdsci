<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/jsp/common/doctype.jsp" %>
<html>
<head>
<script type="text/javascript">
	function addDept(){
		jboxOpen("<s:url value='/sch/cfg/editDept?deptFlow=${sysDept.deptFlow}'/>", "新增部门", 500, 350);
	}
	function editDept(schDeptFlow){
		jboxOpen("<s:url value='/sch/cfg/editDept?deptFlow=${sysDept.deptFlow}&schDeptFlow='/>"+schDeptFlow, "编辑部门信息", 500, 350);
	}
	
	function delDept(schDeptFlow){
		jboxConfirm("确认删除?",function () {
			var url = "<s:url value='/sch/cfg/delDept?schDeptFlow='/>" + schDeptFlow;
			jboxPost(url,null,function(resp){
				if(resp == '${GlobalConstant.DELETE_SUCCESSED}'){
					window.parent.frames['mainIframe'].window.viewDept("${sysDept.deptFlow}");
					doClose();
				}
			},null,true);
		});
	}
	
	$(document).ready(function(){
		$("#${param.deptFlow}").text("${schDeptList.size()}");
	});
</script>
</head>
<body>
		<table class="xllist" > 
			<thead>
			<tr>
				<th colspan="6" style="text-align: left;padding-left: 10px;">轮转科室:&#12288;${sysDept.deptName }
					<a style="float: right; padding-right: 10px;" href="javascript:addDept()"><img title="新增" src="<s:url value='/css/skin/${skinPath}/images/add.png'/>"></a>
				</th>
			</tr>
			<tr>
				<th width="200px">科室名称</th>
				<th width="100px" >容纳人数</th>
				<th width="100px" >对外</th>
				<th width="200px" >医院科室</th>
				<th width="100px" >操作</th>
			</tr>
			</thead>
			<c:forEach items="${schDeptList}" var="schDept">
				<tr>
					<td>${schDept.schDeptName}</td>
					<td>${schDept.deptNum}</td>
					<td>${schDept.external eq GlobalConstant.FLAG_N?'否':'是'}</td>
					<td>${sysDept.deptName}</td>
					<td>
						<a href="javascript:editDept('${schDept.schDeptFlow}')" style="color: blue">编辑</a>&#12288;|&#12288;<a href="javascript:delDept('${schDept.schDeptFlow}')" style="color: blue">删除</a>
					</td>
				</tr>
			</c:forEach>
			<c:if test="${empty schDeptList}">
				<tr><td align="center" colspan="6">无记录</td></tr>
			</c:if>
		</table>
</body>
</html>