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
<script type="text/javascript">
	function uploadFile(){
		jboxOpen("<s:url value='/irb/researcher/applyFile'/>", "上传文件", 700,300);
	}
</script>
<body>
	
							<p align="center"><strong>研究者责任声明</strong></p>
xx医院医学伦理委员会：<br/>
本人作为临床研究项目负责人，根据伦理委员会要求，同意严格遵守我国《药物临床试验质量管理规范》及相关法律法规和国际伦理准则，遵照《涉及人的生物医学研究伦理审查办法（试行）》的通知精神，开展临床研究工作。现做如下声明：<br/>
(一)	开展临床研究前向伦理委员会提交伦理审查申请，获得其书面批复同意后方可实施。<br/>
(二)	根据要求履行临床研究者职责，避免利益冲突的情况发生。<br/>
(三)	接受伦理委员会的指导及建议，及时报告临床研究中发生的严重不良事件。<br/>
(四)	及时向伦理委员会报告临床研究终止或其他伦理委员会的重要决定。<br/>
(五)	向伦理委员会提交研究年度进展报告。<br/>
(六)	研究过程中对临床研究方案、招募材料、向受试者提供的研究简介和知情同意书内容的修改均应及时报告伦理委员会审批。<br/>
(七)	随时接受伦理委员会的督查，应伦理委员会的要求，提交督查资料，报告研究中的有关信息及总结报告等。<br/>
<p align="right">签名：</p>
<p align="right">日期：         年    月    日</p>

</body>
</html>