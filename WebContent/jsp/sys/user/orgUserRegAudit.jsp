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
function audit(userFlow){
	var url = "<s:url value='/sys/user/activate?userFlow='/>"+userFlow;
	jboxGet(url,null,function(){
		window.parent.frames['mainIframe'].window.searchUser();
		jboxClose();
	});
}
</script>
</head>
<body>

<div class="mainright">
		<div class="content">
			<div class="title1 clearfix">
				<table width="100%" class="basic">
                 <thead>
                    <tr>
                        <th colspan="4" class="bs_name">承担单位用户注册审核</th>
                    </tr>
                 </thead>
                 <tbody>
                      <tr>
                         <th width="20%">用户名：</th>
                         <td width="30%">${user.userCode}</td>
                        
                         <th width="20%">姓名：</th>
                         <td width="30%">${user.userName}</td>
                         
                      </tr>
                      <tr>
                         <th width="20%">性别：</th>
                         <td width="30%">
                         	${user.sexName}
                         </td>
                          <th width="20%">身份证号：</th>
                         <td width="30%">
							${user.idNo}	
						 </td>
                      </tr>
                      <tr>
                         <th width="20%">手机号：</th>
                         <td width="30%">
                         	${user.userPhone}
                         </td>
                          <th width="20%">电子邮件：</th>
                         <td width="30%">
							${user.userEmail}	
						 </td>
                      </tr>
                      <tr>
                         <th width="20%">所在机构：</th>
                         <td width="30%">
                         	${user.orgName}
                         </td>
                          <th width="20%">主管部门：</th>
                         <td width="30%">
							${org.chargeOrgName}
						 </td>
                      </tr>
                      <tr>
                         <th width="20%">机构组织代码：</th>
                         <td width="30%">
                         	${org.orgCode}
                         </td>
                          <th width="20%">单位地址：</th>
                         <td width="30%">
							${org.orgAddress}
						 </td>
                      </tr>
                      <tr>
                         <th width="20%">组织机构代码附件：</th>
                         <td width="30%">
                         	<c:if test="${empty orgFileFlow}">无附件</c:if>
			            	<c:if test="${!empty orgFileFlow}">
			            		<a href="<s:url value='/pub/file/down?fileFlow=${orgFileFlow}'/>">下载</a>
			            	</c:if>
                         </td>
                          <th width="20%">工商营业执照附件：</th>
                         <td width="30%">
							<c:if test="${empty licenseFileFlow}">无附件</c:if>
			            	<c:if test="${!empty licenseFileFlow}">
			            		<a href="<s:url value='/pub/file/down?fileFlow=${licenseFileFlow}'/>">下载</a>
			            	</c:if>
						 </td>
                      </tr>
                 </tbody>
           </table>
			</div>
				<div style="text-align: center;">
				 <input type="button" class="search" onclick="audit('${user.userFlow}')" value="审核通过"/>
				</div>
				
		</div>
</div>
</body>
</html>