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
				<table width="1000" class="basic">
                 <thead>
                    <tr>
                        <th colspan="4" class="bs_name">专家注册审核</th>
                    </tr>
                 </thead>
                 <tbody>
                      <tr>
                         <th width="20%">用户名：</th>
                         <td width="30%">
                         	${user.userCode}
                         </td>
                         <th width="20%">性别：</th>
                         <td width="30%">
                         	${user.sexName}
                         </td>
                      </tr>
                      <tr>
                         <th width="20%">身份证号：</th>
                         <td width="30%">
                         	${user.idNo}
                         </td>
                         <th width="20%">手机号：</th>
                         <td width="30%">
                         	${user.userPhone}
                         </td>
                      </tr>
                      <tr>
                         <th width="20%">电子邮件：</th>
                         <td width="30%">
                         	${user.userEmail}
                         </td>
                         <th width="20%">所在机构：</th>
                         <td width="30%">
                         	${user.orgName}
                         </td>
                      </tr>
                      <tr>
                         <th width="20%">毕业院校：</th>
                         <td width="30%">
                         	${expert.graduateSchool}
                         </td>
                         <th width="20%">工作年份：</th>
                         <td width="30%">
                         	${expert.beginWorkYear}
                         </td>
                      </tr>
                      <tr>
                         <th width="20%">传真：</th>
                         <td width="30%">
                         	${expert.fax}
                         </td>
                         <th width="20%">专业：</th>
                         <td width="30%">
                         	${expert.majorName}
                         </td>
                      </tr>
                      <tr>
                         <th width="20%">学历：</th>
                         <td width="30%">
                         	${user.educationName}
                         </td>
                         <th width="20%">单位职务：</th>
                         <td width="30%">
                         	${expert.post}
                         </td>
                      </tr>
                      <tr>
                         <th width="20%">联系地址：</th>
                         <td width="30%">
                         	${expert.address}
                         </td>
                         <th width="20%">邮政编码：</th>
                         <td width="30%">
                         	${expert.postcode}
                         </td>
                      </tr>
                      <tr>
                         <th width="20%">研究领域：</th>
                         <td width="30%">
                         	${expert.techAreaName}
                         </td>
                         <th width="20%">取得奖项：</th>
                         <td width="30%">
                         	${expert.award}
                         </td>
                      </tr>
                      <tr>
                         <th width="20%">劳务支付方式：</th>
                         <td width="30%">
                         	<c:if test='${expert.laborPayId=="1"}'>银行汇款方式支付</c:if>
		        			<c:if test='${expert.laborPayId=="2"}'>邮政汇款地址支付</c:if>
                         </td>
                         <th width="20%">开户银行：</th>
                         <td width="30%">
                         	${expert.accountBank}
                         </td>
                      </tr>
                      <tr>
                         <th width="20%">开户名：</th>
                         <td width="30%">
                         	${expert.accountName}
                         </td>
                         <th width="20%">银行卡号：</th>
                         <td width="30%">
                         	${expert.accountNo}
                         </td>
                      </tr>
                      <tr>
                         <th width="20%">收款人：</th>
                         <td width="30%">
                         	${expert.recipient}
                         </td>
                         <th width="20%">收款人地址：</th>
                         <td width="30%">
                         	${expert.recipientAddress}
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