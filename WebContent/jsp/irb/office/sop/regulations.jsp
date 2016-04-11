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
	function editSeal(){
		jboxOpen("<s:url value='/irb/office/editSeal'/>","盖章登记", 600,300);
	}
</script>
</head>
<body>
<div class="mainright">
	<div class="content">
	<div class="title1 clearfix">
		<table class="xllist">
			<tr>
				<th  align="left" colspan="2">&#12288;研究伦理</th>
			</tr>
			<tr>
				<td style="text-align: left">&#12288;&#12288;&#12288;卫生部 涉及人的生物医学研究伦理审查办法（试行）2007 </td>
			</tr>
			<tr>
				<td style="text-align: left">&#12288;&#12288;&#12288;SFDA GCP 2003  </td>
			</tr>
			<tr>
				<td style="text-align: left">&#12288;&#12288;&#12288;SFDA 药物临床试验伦理审查工作指导原则2010  </td>
			</tr>
			<tr>
				<td style="text-align: left">&#12288;&#12288;&#12288;国家中医局 中医药临床研究伦理审查管理规范 20100914  </td>
			</tr>
			<tr>
				<td style="text-align: left">&#12288;&#12288;&#12288;世中联 中医药临床研究伦理审查平台评估标准 20121212提交出版  </td>
			</tr>
			<tr>
				<td style="text-align: left">&#12288;&#12288;&#12288;赫尔辛基宣言2008 中文  </td>
			</tr>
			<tr>
				<th  align="left" colspan="2">&#12288;医疗技术临床应用 </th>
			</tr>
			<tr>
				<td style="text-align: left">&#12288;&#12288;&#12288;卫生部 医疗技术临床应用管理办法2009  </td>
			</tr>
			<tr>
				<td style="text-align: left">&#12288;&#12288;&#12288;卫生部 器官移植技术临床应用管理暂行规定2006  </td>
			</tr>
			<tr>
				<td style="text-align: left">&#12288;&#12288;&#12288;国务院 人体器官移植条例 2007  </td>
			</tr>
			<tr>
				<td style="text-align: left">&#12288;&#12288;&#12288;卫生部关于规范活体器官移植的若干规定2009  </td>
			</tr>
			<tr>
				<td style="text-align: left">&#12288;&#12288;&#12288;卫生部 人类辅助生殖技术管理办法2001  </td>
			</tr>
			<tr>
				<td style="text-align: left">&#12288;&#12288;&#12288;卫生部 人类精子库管理办法   </td>
			</tr>
			<tr>
				<td style="text-align: left">&#12288;&#12288;&#12288;卫生部 人类辅助生殖技术与人类精子库   </td>
			</tr>
			<tr>
				<td style="text-align: left">&#12288;&#12288;&#12288;卫生部关于印发《非血缘造血干细胞移植技术管理规范》和《非血缘造血干细胞采集技术管理规范》的通知 </td>
			</tr>
		</table>
	</div>
	</div>
</div>
</body>
</html>