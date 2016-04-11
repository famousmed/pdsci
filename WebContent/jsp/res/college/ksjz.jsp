<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@include file="/jsp/common/doctype.jsp"%>
<html>
<head>
<jsp:include page="/jsp/common/htmlhead.jsp">
	<jsp:param name="basic" value="true" />
	<jsp:param name="jbox" value="true" />
	<jsp:param name="jquery_form" value="false" />
	<jsp:param name="jquery_ui_tooltip" value="true" />
	<jsp:param name="jquery_ui_combobox" value="false" />
	<jsp:param name="jquery_ui_sortable" value="false" />
	<jsp:param name="jquery_cxselect" value="true" />
	<jsp:param name="jquery_scrollTo" value="false" />
	<jsp:param name="jquery_jcallout" value="false" />
	<jsp:param name="jquery_validation" value="true" />
	<jsp:param name="jquery_datePicker" value="true" />
	<jsp:param name="jquery_fullcalendar" value="false" />
	<jsp:param name="jquery_fngantt" value="false" />
	<jsp:param name="jquery_fixedtableheader" value="true" />
	<jsp:param name="jquery_placeholder" value="true" />
	<jsp:param name="jquery_iealert" value="false" />
</jsp:include>

<style type="text/css">
.infoAudit{padding:20px;height:505px;background:#fff;}
.infoAudit h1{ line-height:40px;  text-align:center; font-size:16px; color:#333;}
.infoAudit h2{line-height:40px; border-bottom:2px solid #44b549;padding-left:10px; color:#44b549; text-indend:10px;font-size:14px;}
.auditConfirm{ margin:10px 0;border-collapse: collapse;border:1px solid #e3e3e3;}
.auditConfirm caption,.auditConfirm th,.auditConfirm td{height:40px;}
.auditConfirm caption{line-height:40px;text-align:left;font-weight:bold; padding-left:10px; margin-bottom:10px;border-bottom:1px solid #ddd;color:#f60;}
.auditConfirm th{background: #f9f9f9;color: #333;height: 35px;text-align: center;}
.auditConfirm td{text-align:center; color:#999;border: 1px solid #e3e3e3;}
.auditConfirm table a{ color:#00f;}
.btn{padding-left:22px; padding-right:22px;}
.blue-btn{ background:#44b549; border: 1px solid #3ea543; color:#fff;}
.blue-btn:hover{ background:#3ea543;}
.red-btn{background:#f90; border: 1px solid #f49200; color:#fff;}
.red-btn:hover{ background:#f60;}
.h-btn{background:#eee;border: 1px solid #ddd; }
.h-btn:hover{ background:#ddd;}
textarea{ width:100%; height:150px;padding:0; resize:none; outline:none;text-indent:28px; line-height:24px; font-family:'微软雅黑'; }
</style>
<script type="text/javascript">
</script>
</head>
<body style="width:100%; min-width: inherit; height:100%;background-image:none; background:#fff;">

	<div class="infoAudit" style="padding-top: 0px;">
		<div style="margin-top: 10px;margin-bottom: -10px;">
			医院：
				<select>
					<option>第二附属医院</option>
					<option>江苏省中西医结合医院</option>
					<option>东南大学附属中大医院</option>
				</select>
			&#12288;
			专业：
				<select>
					<option>内科</option>
					<option>外科</option>
				</select>
			&#12288;
			<input type="button" value="查&#12288;询" class="search"/>
		</div>
		<table class="auditConfirm" border="0" width="100%" cellspacing="0" cellpadding="0">
			<caption>讲座评价</caption>
		</table>
		<table class="xllist">
	     	 <tr>
		     	 <th>专业</th>
		     	 <th>科室</th>
		     	 <th>讲座日期</th>
		     	 <th>开始时间</th>
		     	 <th>结束时间</th>
		     	 <th>讲座内容</th>
		     	 <th>主讲人</th>
		     	 <th>评价</th>
	     	 </tr>
	     	 <tr>
	     	 	<td>内科</td>
	     	 	<td>内科</td>
	     	 	<td>2014-12-15</td>
	     	 	<td>13:00</td>
	     	 	<td>15:00</td>
	     	 	<td>解密细胞增值</td>
	     	 	<td>保罗纳斯 </td>
	     	 	<td></td>
	     	 </tr>
	     	 <tr>
	     	 	<td>外科</td>
	     	 	<td>外科</td>
	     	 	<td>2014-12-13</td>
	     	 	<td>13:00</td>
	     	 	<td>15:00</td>
	     	 	<td>经典中成药应用浅谈</td>
	     	 	<td>郝威威  </td>
	     	 	<td></td>
	     	 </tr>
	     	 <tr>
	     	 	<td>神经内科</td>
	     	 	<td>内科</td>
	     	 	<td>2014-12-12</td>
	     	 	<td>13:00</td>
	     	 	<td>15:00</td>
	     	 	<td>明志修身，追忆韶华 </td>
	     	 	<td>欧阳颀  </td>
	     	 	<td></td>
	     	 </tr>
	     	 <tr>
	     	 	<td>麻痹科</td>
	     	 	<td>麻痹科</td>
	     	 	<td>2014-12-12</td>
	     	 	<td>13:00</td>
	     	 	<td>15:00</td>
	     	 	<td>农业科技创新与中国粮食安全</td>
	     	 	<td>黄季焜博士 </td>
	     	 	<td></td>
	     	 </tr>
	     	 <tr>
	     	 	<td>预防医学科</td>
	     	 	<td>外科</td>
	     	 	<td>2014-11-18</td>
	     	 	<td>13:00</td>
	     	 	<td>15:00</td>
	     	 	<td>牛奶——从谣言到真相</td>
	     	 	<td>张玉梅 教授 </td>
	     	 	<td></td>
	     	 </tr>
		</table>
	</div>
</body>
</html>