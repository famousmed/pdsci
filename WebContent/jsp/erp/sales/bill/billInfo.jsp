<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@include file="/jsp/common/doctype.jsp" %>
<html>
<head>
<jsp:include page="/jsp/common/htmlhead.jsp">
	<jsp:param name="basic" value="true"/>
	<jsp:param name="jbox" value="true"/>
	<jsp:param name="jquery_form" value="true"/>
	<jsp:param name="jquery_ui_tooltip" value="true"/>
	<jsp:param name="jquery_ui_combobox" value="true"/>
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
</script>
</head>
<body>
<div class="mainright">
<div class="content">
	<div class="title1 clearfix">
				<table width="100%" cellpadding="0" cellspacing="0" class="basic">
					<colgroup>
						<col width="15%"/>
						<col width="35%"/>
						<col width="15%"/>
						<col width="35%"/>
					</colgroup>
					<tr>
						<th colspan="4" style="text-align: left;padding-left: 10px">发票单信息</th>
					</tr>
					<c:if test="${sessionScope[GlobalConstant.USER_LIST_SCOPE] eq GlobalConstant.USER_LIST_CHARGE }">
					<tr>
					    <td style="text-align: right;padding-right: 10px;">发票单号：</td>
						<td>
						<c:if test="${param.type!='pay' }">
						   <input type="text" class="inputText validate[required]" name="billNo"/>
						</c:if>
						<c:if test="${param.type=='pay' }">
						   4325654767
						</c:if>
						</td>
					</tr>
					</c:if>
					<tr>
						<td style="text-align: right;padding-right: 10px;">申请日期：</td>
						<td>2014-10-10</td>
						<td style="text-align: right;padding-right: 10px;">客户名称：</td>
						<td>苏州卫生局</td>
					</tr>
					<tr>
						<td style="text-align: right;padding-right: 10px;">客户联系人：</td>
						<td>周州</td>
						<td style="text-align: right;padding-right: 10px;">电&#12288;&#12288;话：</td>
						<td>13888888888</td>
					</tr>
					<tr>
						<td style="text-align: right;padding-right: 10px;">开票内容：</td>
						<td colspan="3">住院医师系统第一笔回款</td>
					</tr>
					<tr>
						<td style="text-align: right;padding-right: 10px;">我司开票抬头：</td>
						<td colspan="3">南京品德网络信息技术有限公司</td>
					</tr>
					<tr>
						<td style="text-align: right;padding-right: 10px;">开票金额：</td>
						<td>8元</td>
						<td style="text-align: right;padding-right: 10px;">开票申请人：</td>
						<td>李丽</td>
					</tr>
					<tr>
						<td style="text-align: right;padding-right: 10px;">备&#12288;&#12288;注：</td>
						<td colspan="3">无</td>
					</tr>
					<c:if test="${param.type=='pay' }">
					<tr>
					    <td style="text-align: right;padding-right: 10px;">汇款银行卡号：</td>
						<td >
						   <input type="text" class="inputText validate[required]" name="cardNo"/>
						</td>
						<td style="text-align: right;padding-right: 10px;">到账时间：</td>
						<td >
						   <input type="text" class="inputText validate[required]" name="payTime"/>
						</td>
					</tr>
					</c:if>
					<c:if test="${sessionScope[GlobalConstant.USER_LIST_SCOPE] eq GlobalConstant.USER_LIST_CHARGE and param.type!='pay'}">
					 <tr>
                      <td style="padding-right: 10px;text-align: right;">商务审核意见：</td>
                      <td colspan="3">lalalalalallalalalalalalla</td>
                     </tr>
                    </c:if>
				</table>
				<c:if test="${'audit' != param.type and 'pay' != param.type}">
					<div class="button" style="width: 100%;">
						<input class="search" type="button" value="关&#12288;闭" onclick="jboxClose();" />
					</div>
				</c:if>
			</div>
		</div>
	</div>
</body>
</html>