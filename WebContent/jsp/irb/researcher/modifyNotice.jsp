<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<%@ page import="org.dom4j.Document" %>
<%@ page import="org.dom4j.DocumentHelper" %>
<%@ page import="org.dom4j.Node" %>
<jsp:useBean id="modifyNoticeRec" class="com.pinde.sci.model.mo.IrbRec" scope="request"/>
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
</script>
<%
List<Node> nodeList = null;
String content = "";
if (modifyNoticeRec != null) {
	content = modifyNoticeRec.getRecContent();
}
if (content != null && content != "") {
	Document dom = DocumentHelper.parseText(content);
	String xpath = "/notices/notice";
	nodeList = dom.selectNodes(xpath);
}

%>
</head>
<body>
	<div class="mainright">
	<div class="content">
		<div class="title1 clearfix">
			<table class="basic" style="width: 80%;">
				<%
				if (nodeList != null && nodeList.size()>0) {
					for (int i=0;i<nodeList.size();i++) {
						Node noticeNode = nodeList.get(i);
				%>
					<tr>
						<th colspan="4" style="text-align: left;">&nbsp;补充修改通知&nbsp;<%=i+1 %>.</th>
					</tr>
				<%	
						List<Node> applyNodes = noticeNode.selectNodes("applyFile/file");
						if (applyNodes != null && applyNodes.size()>0) {
				%>
					<tr>
						<td style="border-right: 0;" width="5px">&nbsp;</td>
						<td colspan="3" style="text-align: left;border-left: 0;">
							<font style="font-weight: bold;">1.未提交的文件：</font>
						</td>
					</tr>
				<%			
							for (int j=0;j<applyNodes.size();j++) {
								Node applyNode = applyNodes.get(j);
								String fileName = applyNode.selectSingleNode("fileName").getText();
				%>
					<tr>
						<td style="border-right: 0;" width="5px">&nbsp;</td>
						<td style="border-left: 0;border-right: 0;" width="5px">&#12288;</td>
						<td style="text-align: left;border-left: 0;border-right: 0;" width="30%"><%=fileName %></td>
						<td style="text-align: left;border-left: 0;">[<font color="red">未提交,请补充！</font>]</td>
					</tr>
				<%		
							}
						}
				%>
				<%	
						List<Node> modifyNodes = noticeNode.selectNodes("modifyFile/file");
						if (modifyNodes != null && modifyNodes.size()>0) {
							String num = "1";
							if (applyNodes != null && applyNodes.size()>0) {
								num = "2";
							}
				%>
					<tr>
						<td style="border-right: 0;" width="5px">&nbsp;</td>
						<td colspan="3" style="text-align: left;border-left: 0;">
							<font style="font-weight: bold;"><%=num %>.需要修改的文件：</font>
						</td>
					</tr>
				<%
							for (int j=0;j<modifyNodes.size();j++) {
								Node modifyNode = modifyNodes.get(j);
								String fileName = modifyNode.selectSingleNode("fileName").getText();
								String suggest = modifyNode.selectSingleNode("suggest").getText();
				%> 
					<tr>
						<td style="border-right: 0;" width="5px">&nbsp;</td>
						<td style="border-left: 0;border-right: 0;" width="5px">&nbsp;</td>
						<td style="text-align: left;border-left: 0;border-right: 0;" width="30%"><%=fileName %></td>
						<td style="text-align: left;border-left: 0;">[<font color="red"><%=suggest %></font>]</td>
					</tr>
				<%		
							}
						}
				%>
				<%		
					}
				}
				%>
			</table>
		</div>
	</div>
	</div>
</body>
</html>