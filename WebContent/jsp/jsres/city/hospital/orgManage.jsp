<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>江苏省住院医师规范化培训管理平台</title>
<jsp:include page="/jsp/jsres/htmlhead-jsres.jsp">
	<jsp:param name="basic" value="true"/>
	<jsp:param name="jbox" value="true"/>
	<jsp:param name="font" value="true"/>
</jsp:include>
<script type="text/javascript">
function auditStatus(baseFlow,status){
	var s="通过";
	if(status=='${GlobalConstant.FLAG_N}'){
		s="不通过";
	}
	jboxConfirm("确认"+s+"？",function(){
		var data={
				"baseFlow":baseFlow,
				"status":status
			};
		jboxPost("<s:url value='/jsres/base/baseAudit'/>" , data , function(resp){
			if("${GlobalConstant.OPRE_SUCCESSED}"==resp){
				setTimeout(function(){
					window.parent.auditHospitals();
					loadInfo('${GlobalConstant.ORG_MANAGE}','${param.baseFlow}');
				},1000);
			}
		} , null , true);
	});
}
</script>
</head>
<body>
	<div class="infoAudit"   <c:if test="${param.openType != 'open'}">style="height: auto;"</c:if>>
		<div class="div_table">
		  <h4>组织管理（住院医师培训组织管理机构成员及职责）</h4>
		   <table border="0" cellspacing="0" cellpadding="0" class="grid">
		   <colgroup>
		     <col width="10%"/>
		     <col width="10%"/>
		     <col width="10%"/>
		     <col width="10%"/>
		     <col width="10%"/>
		     <col width="20%"/>
		     <col width="10%"/>
		     <col width="10%"/>
		     <col width="10%"/>
		   </colgroup>
		      <tr>
		       <th>姓名</th>
		       <th>性别</th>
		       <th>年龄</th>
		       <th>专业</th>
		       <th>最高学位</th>
		       <th>科室</th>
		       <th>职务</th>
		       <th>专职/兼职</th>
		       <th>联系电话</th>
		     </tr>
		      <c:forEach var="person" items="${organizationManage.organizationPersonList}" varStatus="status">
		     <tr>
		    	<td>${person.name }</td>
		    	<td>${person.sex }</td>
		    	<td>${person.age }</td>
		    	<td>${person.profession }</td>
		    	<td>${person.tallStudy }</td>
		    	<td>${person.dept }</td>
		    	<td>${person.job }</td>
		    	<td>${person.partOrAllJob }</td>
		    	<td>${person.telephone }</td>
		     </tr>
		     </c:forEach>
		      <c:if test="${ empty organizationManage.organizationPersonList}">
		      <tr>
		      	<td colspan="10">无记录</td>
		      </tr>
		      </c:if>
		     <tr>
		       <td colspan="9" style="text-align:left;">现有住院医师培训相关规章制度、培训实施计划、考试考核等（请列出具体名称）：</td>
		     </tr>
		      <tr>
		        <td colspan="10" ><textarea readonly="readonly">${organizationManage.info}</textarea></td>
		      </tr>
 			</table>
		</div>
		<div class="btn_info">
		 	<jsp:include page='/jsp/jsres/province/hospital/passBtn.jsp'/>
	    </div>
	</div>
  </body>
</html>