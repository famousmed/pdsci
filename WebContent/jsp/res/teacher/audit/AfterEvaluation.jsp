<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@include file="/jsp/common/doctype.jsp" %>
<html>
<head>
<link rel="stylesheet" type="text/css" href="<s:url value='/jsp/res/doctor/Default.css'/>"></link>
<jsp:include page="/jsp/common/htmlhead.jsp">
	<jsp:param name="basic" value="true"/>
	<jsp:param name="jbox" value="true"/>
	<jsp:param name="jquery_form" value="false"/>
	<jsp:param name="jquery_ui_tooltip" value="true"/>
	<jsp:param name="jquery_ui_combobox" value="false"/>
	<jsp:param name="jquery_ui_sortable" value="false"/>
	<jsp:param name="jquery_cxselect" value="true"/>
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
	function doback() {
		window.location.href="<s:url value='/jsp/res/doctor/main.jsp'/>";
	}
</script>
</head>
<body>	
   <div class="mainright">
      <div class="content">
        <div class="title1 clearfix">
		 <div style="padding-top: 10px;padding-left: 5px;padding-right: 5px;padding-bottom: 5px;">
					              <!--startprint-->
    <div class="width95" style="margin: 0 auto;">
        <p style="margin-top: 30px;">
            <h2 class="width100" style="font-size: 26px;">
                临床医学研究生培训出科考核评分表</h2>
            <p>
            </p>
            <br />
            <table border="0" cellpadding="0" cellspacing="0" class="width95">
                <tr>
                    <td>
                        姓名：<b><span id="UserNameLabel">莫言</span>
                        </b>
                    </td>
                    <td>
                        科室：<b><span id="HosCycleSectionNameLabel">心血管内科</span>
                        </b>
                    </td>
                    <td>
                        轮转时间：<b><span id="CycleMonthLabel">2 个月</span>
                        </b>
                    </td>
                    <td>
                        分管床位数：<b><span id="ManagerSickbedNumberLabel"></span>
                        </b>
                    </td>
                </tr>
            </table>
            <br />
            <table border="0" cellpadding="0" cellspacing="0" class="table_test width95">
                <tr>
                    <td class="width10">
                        &nbsp;
                    </td>
                    <td class="width15">
                        &nbsp;
                    </td>
                    <td class="width30 lineHeight20">
                        <b>项目</b>
                    </td>
                    <td class="width15" colspan="3">
                        <b>评分标准</b>
                    </td>
                    <td class="width10">
                        <b>得分</b>
                    </td>
                    <td class="width30">
                        <b>备注</b>
                    </td>
                </tr>
                <tr>
                    <td rowspan="20">
                        一<br />
                        日<br />
                        常<br />
                        临<br />
                        床<br />
                        能<br />
                        力<br />
                        考<br />
                        核<br />
                        (50%)<br />
                    </td>
                    <td rowspan="4">
                        医德医风
                    </td>
                    <td class="tdleft5px">
                        廉洁行医
                    </td>
                    <td>
                        &nbsp;
                        <span title="0分"><input id="Item1Record1Score1CheckBox" type="checkbox" name="Item1Record1Score1CheckBox" onclick="javascript:setTimeout('__doPostBack(\'Item1Record1Score1CheckBox\',\'\')', 0)" /><label for="Item1Record1Score1CheckBox">0</label></span>
                    </td>
                    <td>
                        &nbsp;
                        <span title="1分"><input id="Item1Record1Score2CheckBox" type="checkbox" name="Item1Record1Score2CheckBox" onclick="javascript:setTimeout('__doPostBack(\'Item1Record1Score2CheckBox\',\'\')', 0)" /><label for="Item1Record1Score2CheckBox">1</label></span>
                    </td>
                    <td>
                        &nbsp;
                        <span title="2分"><input id="Item1Record1Score3CheckBox" type="checkbox" name="Item1Record1Score3CheckBox" checked="checked" onclick="javascript:setTimeout('__doPostBack(\'Item1Record1Score3CheckBox\',\'\')', 0)" /><label for="Item1Record1Score3CheckBox">2</label></span>
                    </td>
                    <td>
                        <input name="Item1Record1TextBox" type="text" value="2" id="Item1Record1TextBox" disabled="disabled" style="width:55%;" />
                        <span id="RequiredFieldValidator1" style="color:Red;visibility:hidden;">*</span>
                        <span id="RangeValidator1" style="color:Red;visibility:hidden;">*</span>
                    </td>
                    <td class="tdleft5px">
                        无投诉
                    </td>
                </tr>
                <tr>
                    <td class="tdleft5px">
                        工作态度及责任心
                    </td>
                    <td>
                        &nbsp;
                        <span title="0分"><input id="Item1Record2Score1CheckBox" type="checkbox" name="Item1Record2Score1CheckBox" onclick="javascript:setTimeout('__doPostBack(\'Item1Record2Score1CheckBox\',\'\')', 0)" /><label for="Item1Record2Score1CheckBox">0</label></span>
                    </td>
                    <td>
                        &nbsp;
                        <span title="1分"><input id="Item1Record2Score2CheckBox" type="checkbox" name="Item1Record2Score2CheckBox" onclick="javascript:setTimeout('__doPostBack(\'Item1Record2Score2CheckBox\',\'\')', 0)" /><label for="Item1Record2Score2CheckBox">1</label></span>
                    </td>
                    <td>
                        &nbsp;
                        <span title="2分"><input id="Item1Record2Score3CheckBox" type="checkbox" name="Item1Record2Score3CheckBox" checked="checked" onclick="javascript:setTimeout('__doPostBack(\'Item1Record2Score3CheckBox\',\'\')', 0)" /><label for="Item1Record2Score3CheckBox">2</label></span>
                    </td>
                    <td>
                        <input name="Item1Record2TextBox" type="text" value="2" id="Item1Record2TextBox" disabled="disabled" style="width:55%;" />
                        <span id="RequiredFieldValidator2" style="color:Red;visibility:hidden;">*</span>
                        <span id="RangeValidator2" style="color:Red;visibility:hidden;">*</span>
                    </td>
                    <td class="tdleft5px">
                        无投诉
                    </td>
                </tr>
                <tr>
                    <td class="tdleft5px">
                        医疗差错，事故
                        <span id="Label1">备注</span>
                        <table id="RadioButtonList1" disabled="disabled" border="0">
	<tr>
		<td><span disabled="disabled"><input id="RadioButtonList1_0" type="radio" name="RadioButtonList1" value="无" checked="checked" disabled="disabled" /><label for="RadioButtonList1_0">无</label></span></td><td><span disabled="disabled"><input id="RadioButtonList1_1" type="radio" name="RadioButtonList1" value="有" disabled="disabled" /><label for="RadioButtonList1_1">有</label></span></td>
	</tr>
</table>
                        <table id="IatricAccidentTable" border="0">

</table>
                    </td>
                    <td>
                        &nbsp;
                        <span title="0分"><input id="Item1Record5Score1CheckBox" type="checkbox" name="Item1Record5Score1CheckBox" onclick="javascript:setTimeout('__doPostBack(\'Item1Record5Score1CheckBox\',\'\')', 0)" /><label for="Item1Record5Score1CheckBox">0</label></span>
                    </td>
                    <td>
                        &nbsp;
                        <span title="1分"><input id="Item1Record5Score2CheckBox" type="checkbox" name="Item1Record5Score2CheckBox" onclick="javascript:setTimeout('__doPostBack(\'Item1Record5Score2CheckBox\',\'\')', 0)" /><label for="Item1Record5Score2CheckBox">1</label></span>
                    </td>
                    <td>
                        &nbsp;
                        <span title="2分"><input id="Item1Record5Score3CheckBox" type="checkbox" name="Item1Record5Score3CheckBox" checked="checked" onclick="javascript:setTimeout('__doPostBack(\'Item1Record5Score3CheckBox\',\'\')', 0)" /><label for="Item1Record5Score3CheckBox">2</label></span>
                    </td>
                    <td>
                        <input name="Item1Record5TextBox" type="text" value="2" id="Item1Record5TextBox" disabled="disabled" style="width:55%;" />
                        <span id="RequiredFieldValidator5" style="color:Red;visibility:hidden;">*</span>
                        <span id="RangeValidator5" style="color:Red;visibility:hidden;">*</span>
                    </td>
                    <td class="tdleft5px">
                        大于等于1次为不合格
                    </td>
                </tr>
                <tr>
                    <td class="tdleft5px">
                        医患沟通能力
                    </td>
                    <td>
                        &nbsp;
                        <span title="0分"><input id="Item1Record4Score1CheckBox" type="checkbox" name="Item1Record4Score1CheckBox" checked="checked" onclick="javascript:setTimeout('__doPostBack(\'Item1Record4Score1CheckBox\',\'\')', 0)" /><label for="Item1Record4Score1CheckBox">0</label></span>
                    </td>
                    <td>
                        &nbsp;
                        <span title="1分"><input id="Item1Record4Score2CheckBox" type="checkbox" name="Item1Record4Score2CheckBox" onclick="javascript:setTimeout('__doPostBack(\'Item1Record4Score2CheckBox\',\'\')', 0)" /><label for="Item1Record4Score2CheckBox">1</label></span>
                    </td>
                    <td>
                        &nbsp;
                        <span title="2分"><input id="Item1Record4Score3CheckBox" type="checkbox" name="Item1Record4Score3CheckBox" onclick="javascript:setTimeout('__doPostBack(\'Item1Record4Score3CheckBox\',\'\')', 0)" /><label for="Item1Record4Score3CheckBox">2</label></span>
                    </td>
                    <td>
                        <input name="Item1Record4TextBox" type="text" value="0" id="Item1Record4TextBox" disabled="disabled" style="width:55%;" />
                        <span id="RequiredFieldValidator4" style="color:Red;visibility:hidden;">*</span>
                        <span id="RangeValidator4" style="color:Red;visibility:hidden;">*</span>
                    </td>
                    <td class="tdleft5px">
                        无投诉
                    </td>
                </tr>
                <tr>
                    <td>
                        实践时间
                    </td>
                    <td class="tdleft5px">
                        <span id="AttendCircumstances">病假 0天 事假 0天</span>
                    </td>
                    <td>
                        &nbsp;
                        <span title="0分"><input id="Item2Record1Score1CheckBox" type="checkbox" name="Item2Record1Score1CheckBox" checked="checked" onclick="javascript:setTimeout('__doPostBack(\'Item2Record1Score1CheckBox\',\'\')', 0)" /><label for="Item2Record1Score1CheckBox">0</label></span>
                    </td>
                    <td>
                        &nbsp;
                        <span title="1分"><input id="Item2Record1Score2CheckBox" type="checkbox" name="Item2Record1Score2CheckBox" onclick="javascript:setTimeout('__doPostBack(\'Item2Record1Score2CheckBox\',\'\')', 0)" /><label for="Item2Record1Score2CheckBox">1</label></span>
                    </td>
                    <td>
                        &nbsp;
                        <span title="2分"><input id="Item2Record1Score3CheckBox" type="checkbox" name="Item2Record1Score3CheckBox" onclick="javascript:setTimeout('__doPostBack(\'Item2Record1Score3CheckBox\',\'\')', 0)" /><label for="Item2Record1Score3CheckBox">2</label></span>
                    </td>
                    <td>
                        <input name="Item2Record1TextBox" type="text" value="0" id="Item2Record1TextBox" disabled="disabled" style="width:55%;" />
                        <span id="RequiredFieldValidator6" style="color:Red;visibility:hidden;">*</span>
                        <span id="RangeValidator6" style="color:Red;visibility:hidden;">*</span>
                    </td>
                    <td class="tdleft5px">
                        在轮转科室病事假平均小于等于 2天/月
                    </td>
                </tr>
                <tr>
                    <td rowspan="5">
                        临床实践指标完成情况
                    </td>
                    <td class="tdleft5px">
                        病史质量<span id="MedicalRecordDisqualification">无丙级病历</span>
                    </td>
                    <td>
                        &nbsp;
                        <span title="0分"><input id="Item3Record1Score1CheckBox" type="checkbox" name="Item3Record1Score1CheckBox" onclick="javascript:setTimeout('__doPostBack(\'Item3Record1Score1CheckBox\',\'\')', 0)" /><label for="Item3Record1Score1CheckBox">0</label></span>
                    </td>
                    <td>
                        &nbsp;
                        <span title="2分"><input id="Item3Record1Score2CheckBox" type="checkbox" name="Item3Record1Score2CheckBox" onclick="javascript:setTimeout('__doPostBack(\'Item3Record1Score2CheckBox\',\'\')', 0)" /><label for="Item3Record1Score2CheckBox">2</label></span>
                    </td>
                    <td>
                        &nbsp;
                        <span title="4分"><input id="Item3Record1Score3CheckBox" type="checkbox" name="Item3Record1Score3CheckBox" checked="checked" onclick="javascript:setTimeout('__doPostBack(\'Item3Record1Score3CheckBox\',\'\')', 0)" /><label for="Item3Record1Score3CheckBox">4</label></span>
                    </td>
                    <td>
                        <input name="Item3Record1TextBox" type="text" value="4" id="Item3Record1TextBox" disabled="disabled" style="width:55%;" />
                        <span id="RequiredFieldValidator7" style="color:Red;visibility:hidden;">*</span>
                        <span id="RangeValidator7" style="color:Red;visibility:hidden;">*</span>
                    </td>
                    <td class="tdleft5px">
                        完成数量100%；有丙级病历则不能通过
                    </td>
                </tr>
                <tr>
                    <td class="tdleft5px">
                        带教质量
                    </td>
                    <td>
                        &nbsp;
                        <span title="0分"><input id="Item3Record2Score1CheckBox" type="checkbox" name="Item3Record2Score1CheckBox" onclick="javascript:setTimeout('__doPostBack(\'Item3Record2Score1CheckBox\',\'\')', 0)" /><label for="Item3Record2Score1CheckBox">0</label></span>
                    </td>
                    <td>
                        &nbsp;
                        <span title="2分"><input id="Item3Record2Score2CheckBox" type="checkbox" name="Item3Record2Score2CheckBox" onclick="javascript:setTimeout('__doPostBack(\'Item3Record2Score2CheckBox\',\'\')', 0)" /><label for="Item3Record2Score2CheckBox">2</label></span>
                    </td>
                    <td>
                        &nbsp;
                        <span title="4分"><input id="Item3Record2Score3CheckBox" type="checkbox" name="Item3Record2Score3CheckBox" checked="checked" onclick="javascript:setTimeout('__doPostBack(\'Item3Record2Score3CheckBox\',\'\')', 0)" /><label for="Item3Record2Score3CheckBox">4</label></span>
                    </td>
                    <td>
                        <input name="Item3Record2TextBox" type="text" value="4" id="Item3Record2TextBox" disabled="disabled" style="width:55%;" />
                        <span id="RequiredFieldValidator8" style="color:Red;visibility:hidden;">*</span>
                        <span id="RangeValidator8" style="color:Red;visibility:hidden;">*</span>
                    </td>
                    <td class="tdleft5px">
                        带教实习生，无下级医生投诉
                    </td>
                </tr>
                <tr>
                    <td class="tdleft5px">
                        管理病种数<span id="DiseaseKinds">应完成<font color='red'>40</font>例 已完成 <font color='red'>45</font>例 
 完成比例 <font color='red'>112.50%</font></span>
                    </td>
                    <td>
                        &nbsp;
                        <span title="0分"><input id="Item3Record3Score1CheckBox" type="checkbox" name="Item3Record3Score1CheckBox" onclick="javascript:setTimeout('__doPostBack(\'Item3Record3Score1CheckBox\',\'\')', 0)" /><label for="Item3Record3Score1CheckBox">0</label></span>
                    </td>
                    <td>
                        &nbsp;
                        <span title="2分"><input id="Item3Record3Score2CheckBox" type="checkbox" name="Item3Record3Score2CheckBox" onclick="javascript:setTimeout('__doPostBack(\'Item3Record3Score2CheckBox\',\'\')', 0)" /><label for="Item3Record3Score2CheckBox">2</label></span>
                    </td>
                    <td>
                        &nbsp;
                        <span title="4分"><input id="Item3Record3Score3CheckBox" type="checkbox" name="Item3Record3Score3CheckBox" checked="checked" onclick="javascript:setTimeout('__doPostBack(\'Item3Record3Score3CheckBox\',\'\')', 0)" /><label for="Item3Record3Score3CheckBox">4</label></span>
                    </td>
                    <td>
                        <input name="Item3Record3TextBox" type="text" value="4" id="Item3Record3TextBox" disabled="disabled" style="width:55%;" />
                        <span id="RequiredFieldValidator9" style="color:Red;visibility:hidden;">*</span>
                        <span id="RangeValidator9" style="color:Red;visibility:hidden;">*</span>
                    </td>
                    <td class="tdleft5px">
                        管理病种数应完成大于等于80%，否则不能通过
                    </td>
                </tr>
                <tr>
                    <td class="tdleft5px">
                        管理病例数<span id="SickPersonNumber">应完成<font color='red'>5</font>例 已完成 <font color='red'>6</font>例 
 完成比例 <font color='red'>120.00%</font></span>
                    </td>
                    <td>
                        &nbsp;
                        <span title="0分"><input id="Item3Record4Score1CheckBox" type="checkbox" name="Item3Record4Score1CheckBox" onclick="javascript:setTimeout('__doPostBack(\'Item3Record4Score1CheckBox\',\'\')', 0)" /><label for="Item3Record4Score1CheckBox">0</label></span>
                    </td>
                    <td>
                        &nbsp;
                        <span title="2分"><input id="Item3Record4Score2CheckBox" type="checkbox" name="Item3Record4Score2CheckBox" onclick="javascript:setTimeout('__doPostBack(\'Item3Record4Score2CheckBox\',\'\')', 0)" /><label for="Item3Record4Score2CheckBox">2</label></span>
                    </td>
                    <td>
                        &nbsp;
                        <span title="4分"><input id="Item3Record4Score3CheckBox" type="checkbox" name="Item3Record4Score3CheckBox" checked="checked" onclick="javascript:setTimeout('__doPostBack(\'Item3Record4Score3CheckBox\',\'\')', 0)" /><label for="Item3Record4Score3CheckBox">4</label></span>
                    </td>
                    <td>
                        <input name="Item3Record4TextBox" type="text" value="4" id="Item3Record4TextBox" disabled="disabled" style="width:55%;" />
                        <span id="RequiredFieldValidator10" style="color:Red;visibility:hidden;">*</span>
                        <span id="RangeValidator10" style="color:Red;visibility:hidden;">*</span>
                    </td>
                    <td class="tdleft5px">
                        管理病例数应完成大于等于80%，否则不能通过
                    </td>
                </tr>
                <tr>
                    <td class="tdleft5px">
                        操作或手术<span id="OperaterSkill">应完成<font color='red'>25</font>例 已完成 <font color='red'>27</font>例 
 完成比例 <font color='red'>108.00%</font></span>
                        <span id="OperationSkill">应完成<font color='red'>1</font>例 已完成 <font color='red'>1</font>例 
 完成比例 <font color='red'>100.00%</font></span>
                    </td>
                    <td>
                        &nbsp;
                        <span title="0分"><input id="Item3Record5Score1CheckBox" type="checkbox" name="Item3Record5Score1CheckBox" onclick="javascript:setTimeout('__doPostBack(\'Item3Record5Score1CheckBox\',\'\')', 0)" /><label for="Item3Record5Score1CheckBox">0</label></span>
                    </td>
                    <td>
                        &nbsp;
                        <span title="2分"><input id="Item3Record5Score2CheckBox" type="checkbox" name="Item3Record5Score2CheckBox" onclick="javascript:setTimeout('__doPostBack(\'Item3Record5Score2CheckBox\',\'\')', 0)" /><label for="Item3Record5Score2CheckBox">2</label></span>
                    </td>
                    <td>
                        &nbsp;
                        <span title="4分"><input id="Item3Record5Score3CheckBox" type="checkbox" name="Item3Record5Score3CheckBox" checked="checked" onclick="javascript:setTimeout('__doPostBack(\'Item3Record5Score3CheckBox\',\'\')', 0)" /><label for="Item3Record5Score3CheckBox">4</label></span>
                    </td>
                    <td>
                        <input name="Item3Record5TextBox" type="text" value="4" id="Item3Record5TextBox" disabled="disabled" style="width:55%;" />
                        <span id="RequiredFieldValidator11" style="color:Red;visibility:hidden;">*</span>
                        <span id="RangeValidator11" style="color:Red;visibility:hidden;">*</span>
                    </td>
                    <td class="tdleft5px">
                        操作（手术）规范并能完成大于等于80%，否则不能通过
                    </td>
                </tr>
                <tr>
                    <td rowspan="3">
                        “三基”掌握情况
                    </td>
                    <td class="tdleft5px">
                        基本理论
                    </td>
                    <td>
                        &nbsp;
                        <span title="0分"><input id="Item4Record1Score1CheckBox" type="checkbox" name="Item4Record1Score1CheckBox" onclick="javascript:setTimeout('__doPostBack(\'Item4Record1Score1CheckBox\',\'\')', 0)" /><label for="Item4Record1Score1CheckBox">0</label></span>
                    </td>
                    <td>
                        &nbsp;
                        <span title="1分"><input id="Item4Record1Score2CheckBox" type="checkbox" name="Item4Record1Score2CheckBox" onclick="javascript:setTimeout('__doPostBack(\'Item4Record1Score2CheckBox\',\'\')', 0)" /><label for="Item4Record1Score2CheckBox">1</label></span>
                    </td>
                    <td>
                        &nbsp;
                        <span title="2分"><input id="Item4Record1Score3CheckBox" type="checkbox" name="Item4Record1Score3CheckBox" checked="checked" onclick="javascript:setTimeout('__doPostBack(\'Item4Record1Score3CheckBox\',\'\')', 0)" /><label for="Item4Record1Score3CheckBox">2</label></span>
                    </td>
                    <td>
                        <input name="Item4Record1TextBox" type="text" value="2" id="Item4Record1TextBox" disabled="disabled" style="width:55%;" />
                        <span id="RequiredFieldValidator12" style="color:Red;visibility:hidden;">*</span>
                        <span id="RangeValidator12" style="color:Red;visibility:hidden;">*</span>
                    </td>
                    <td>
                        &nbsp;
                    </td>
                </tr>
                <tr>
                    <td class="tdleft5px">
                        基本技能
                    </td>
                    <td>
                        &nbsp;
                        <span title="0分"><input id="Item4Record2Score1CheckBox" type="checkbox" name="Item4Record2Score1CheckBox" onclick="javascript:setTimeout('__doPostBack(\'Item4Record2Score1CheckBox\',\'\')', 0)" /><label for="Item4Record2Score1CheckBox">0</label></span>
                    </td>
                    <td>
                        &nbsp;
                        <span title="1分"><input id="Item4Record2Score2CheckBox" type="checkbox" name="Item4Record2Score2CheckBox" onclick="javascript:setTimeout('__doPostBack(\'Item4Record2Score2CheckBox\',\'\')', 0)" /><label for="Item4Record2Score2CheckBox">1</label></span>
                    </td>
                    <td>
                        &nbsp;
                        <span title="2分"><input id="Item4Record2Score3CheckBox" type="checkbox" name="Item4Record2Score3CheckBox" checked="checked" onclick="javascript:setTimeout('__doPostBack(\'Item4Record2Score3CheckBox\',\'\')', 0)" /><label for="Item4Record2Score3CheckBox">2</label></span>
                    </td>
                    <td>
                        <input name="Item4Record2TextBox" type="text" value="2" id="Item4Record2TextBox" disabled="disabled" style="width:55%;" />
                        <span id="RequiredFieldValidator13" style="color:Red;visibility:hidden;">*</span>
                        <span id="RangeValidator13" style="color:Red;visibility:hidden;">*</span>
                    </td>
                    <td>
                        &nbsp;
                    </td>
                </tr>
                <tr>
                    <td class="tdleft5px">
                        基本操作
                    </td>
                    <td>
                        &nbsp;
                        <span title="0分"><input id="Item4Record3Score1CheckBox" type="checkbox" name="Item4Record3Score1CheckBox" onclick="javascript:setTimeout('__doPostBack(\'Item4Record3Score1CheckBox\',\'\')', 0)" /><label for="Item4Record3Score1CheckBox">0</label></span>
                    </td>
                    <td>
                        &nbsp;
                        <span title="1分"><input id="Item4Record3Score2CheckBox" type="checkbox" name="Item4Record3Score2CheckBox" onclick="javascript:setTimeout('__doPostBack(\'Item4Record3Score2CheckBox\',\'\')', 0)" /><label for="Item4Record3Score2CheckBox">1</label></span>
                    </td>
                    <td>
                        &nbsp;
                        <span title="2分"><input id="Item4Record3Score3CheckBox" type="checkbox" name="Item4Record3Score3CheckBox" checked="checked" onclick="javascript:setTimeout('__doPostBack(\'Item4Record3Score3CheckBox\',\'\')', 0)" /><label for="Item4Record3Score3CheckBox">2</label></span>
                    </td>
                    <td>
                        <input name="Item4Record3TextBox" type="text" value="2" id="Item4Record3TextBox" disabled="disabled" style="width:55%;" />
                        <span id="RequiredFieldValidator14" style="color:Red;visibility:hidden;">*</span>
                        <span id="RangeValidator14" style="color:Red;visibility:hidden;">*</span>
                    </td>
                    <td>
                        &nbsp;
                    </td>
                </tr>
                <tr>
                    <td rowspan="6">
                        临床综合能力
                    </td>
                    <td class="tdleft5px">
                        体格检查
                    </td>
                    <td>
                        &nbsp;
                        <span title="0分"><input id="Item5Record1Score1CheckBox" type="checkbox" name="Item5Record1Score1CheckBox" onclick="javascript:setTimeout('__doPostBack(\'Item5Record1Score1CheckBox\',\'\')', 0)" /><label for="Item5Record1Score1CheckBox">0</label></span>
                    </td>
                    <td>
                        &nbsp;
                        <span title="1分"><input id="Item5Record1Score2CheckBox" type="checkbox" name="Item5Record1Score2CheckBox" onclick="javascript:setTimeout('__doPostBack(\'Item5Record1Score2CheckBox\',\'\')', 0)" /><label for="Item5Record1Score2CheckBox">1</label></span>
                    </td>
                    <td>
                        &nbsp;
                        <span title="2分"><input id="Item5Record1Score3CheckBox" type="checkbox" name="Item5Record1Score3CheckBox" checked="checked" onclick="javascript:setTimeout('__doPostBack(\'Item5Record1Score3CheckBox\',\'\')', 0)" /><label for="Item5Record1Score3CheckBox">2</label></span>
                    </td>
                    <td>
                        <input name="Item5Record1TextBox" type="text" value="2" id="Item5Record1TextBox" disabled="disabled" style="width:55%;" />
                        <span id="RequiredFieldValidator15" style="color:Red;visibility:hidden;">*</span>
                        <span id="RangeValidator15" style="color:Red;visibility:hidden;">*</span>
                    </td>
                    <td class="tdleft5px">
                        体检手法规范，按顺序进行，重要体征无遗漏（有一项不符合，则扣1分）
                    </td>
                </tr>
                <tr>
                    <td class="tdleft5px">
                        专业理论
                    </td>
                    <td>
                        &nbsp;
                        <span title="0分"><input id="Item5Record2Score1CheckBox" type="checkbox" name="Item5Record2Score1CheckBox" onclick="javascript:setTimeout('__doPostBack(\'Item5Record2Score1CheckBox\',\'\')', 0)" /><label for="Item5Record2Score1CheckBox">0</label></span>
                    </td>
                    <td>
                        &nbsp;
                        <span title="1分"><input id="Item5Record2Score2CheckBox" type="checkbox" name="Item5Record2Score2CheckBox" onclick="javascript:setTimeout('__doPostBack(\'Item5Record2Score2CheckBox\',\'\')', 0)" /><label for="Item5Record2Score2CheckBox">1</label></span>
                    </td>
                    <td>
                        &nbsp;
                        <span title="2分"><input id="Item5Record2Score3CheckBox" type="checkbox" name="Item5Record2Score3CheckBox" checked="checked" onclick="javascript:setTimeout('__doPostBack(\'Item5Record2Score3CheckBox\',\'\')', 0)" /><label for="Item5Record2Score3CheckBox">2</label></span>
                    </td>
                    <td>
                        <input name="Item5Record2TextBox" type="text" value="2" id="Item5Record2TextBox" disabled="disabled" style="width:55%;" />
                        <span id="RequiredFieldValidator16" style="color:Red;visibility:hidden;">*</span>
                        <span id="RangeValidator16" style="color:Red;visibility:hidden;">*</span>
                    </td>
                    <td class="tdleft5px">
                        临床基础理论、专业知识、科学发展动向的了解与掌握 注明：平时
                    </td>
                </tr>
                <tr>
                    <td class="tdleft5px">
                        处理常见病人的能力
                    </td>
                    <td>
                        &nbsp;
                        <span title="0分"><input id="Item5Record3Score1CheckBox" type="checkbox" name="Item5Record3Score1CheckBox" onclick="javascript:setTimeout('__doPostBack(\'Item5Record3Score1CheckBox\',\'\')', 0)" /><label for="Item5Record3Score1CheckBox">0</label></span>
                    </td>
                    <td>
                        &nbsp;
                        <span title="1分"><input id="Item5Record3Score2CheckBox" type="checkbox" name="Item5Record3Score2CheckBox" onclick="javascript:setTimeout('__doPostBack(\'Item5Record3Score2CheckBox\',\'\')', 0)" /><label for="Item5Record3Score2CheckBox">1</label></span>
                    </td>
                    <td>
                        &nbsp;
                        <span title="2分"><input id="Item5Record3Score3CheckBox" type="checkbox" name="Item5Record3Score3CheckBox" checked="checked" onclick="javascript:setTimeout('__doPostBack(\'Item5Record3Score3CheckBox\',\'\')', 0)" /><label for="Item5Record3Score3CheckBox">2</label></span>
                    </td>
                    <td>
                        <input name="Item5Record3TextBox" type="text" value="2" id="Item5Record3TextBox" disabled="disabled" style="width:55%;" />
                        <span id="RequiredFieldValidator17" style="color:Red;visibility:hidden;">*</span>
                        <span id="RangeValidator17" style="color:Red;visibility:hidden;">*</span>
                    </td>
                    <td class="tdleft5px">
                        临床资料的分析，反应能力，表达能力（有一项不符合，则扣1分）
                    </td>
                </tr>
                <tr>
                    <td class="tdleft5px">
                        处理危重疑难病人的能力
                    </td>
                    <td>
                        &nbsp;
                        <span title="0分"><input id="Item5Record4Score1CheckBox" type="checkbox" name="Item5Record4Score1CheckBox" onclick="javascript:setTimeout('__doPostBack(\'Item5Record4Score1CheckBox\',\'\')', 0)" /><label for="Item5Record4Score1CheckBox">0</label></span>
                    </td>
                    <td>
                        &nbsp;
                        <span title="1分"><input id="Item5Record4Score2CheckBox" type="checkbox" name="Item5Record4Score2CheckBox" checked="checked" onclick="javascript:setTimeout('__doPostBack(\'Item5Record4Score2CheckBox\',\'\')', 0)" /><label for="Item5Record4Score2CheckBox">1</label></span>
                    </td>
                    <td>
                        &nbsp;
                        <span title="2分"><input id="Item5Record4Score3CheckBox" type="checkbox" name="Item5Record4Score3CheckBox" onclick="javascript:setTimeout('__doPostBack(\'Item5Record4Score3CheckBox\',\'\')', 0)" /><label for="Item5Record4Score3CheckBox">2</label></span>
                    </td>
                    <td>
                        <input name="Item5Record4TextBox" type="text" value="1" id="Item5Record4TextBox" disabled="disabled" style="width:55%;" />
                        <span id="RequiredFieldValidator18" style="color:Red;visibility:hidden;">*</span>
                        <span id="RangeValidator18" style="color:Red;visibility:hidden;">*</span>
                    </td>
                    <td class="tdleft5px">
                        综合能力，反应能力，表达能力（有一项不符合，则扣1分）
                    </td>
                </tr>
                <tr>
                    <td class="tdleft5px">
                        实验检查
                    </td>
                    <td>
                        &nbsp;
                        <span title="0分"><input id="Item5Record5Score1CheckBox" type="checkbox" name="Item5Record5Score1CheckBox" onclick="javascript:setTimeout('__doPostBack(\'Item5Record5Score1CheckBox\',\'\')', 0)" /><label for="Item5Record5Score1CheckBox">0</label></span>
                    </td>
                    <td>
                        &nbsp;
                        <span title="1分"><input id="Item5Record5Score2CheckBox" type="checkbox" name="Item5Record5Score2CheckBox" onclick="javascript:setTimeout('__doPostBack(\'Item5Record5Score2CheckBox\',\'\')', 0)" /><label for="Item5Record5Score2CheckBox">1</label></span>
                    </td>
                    <td>
                        &nbsp;
                        <span title="2分"><input id="Item5Record5Score3CheckBox" type="checkbox" name="Item5Record5Score3CheckBox" checked="checked" onclick="javascript:setTimeout('__doPostBack(\'Item5Record5Score3CheckBox\',\'\')', 0)" /><label for="Item5Record5Score3CheckBox">2</label></span>
                    </td>
                    <td>
                        <input name="Item5Record5TextBox" type="text" value="2" id="Item5Record5TextBox" disabled="disabled" style="width:55%;" />
                        <span id="RequiredFieldValidator19" style="color:Red;visibility:hidden;">*</span>
                        <span id="RangeValidator19" style="color:Red;visibility:hidden;">*</span>
                    </td>
                    <td class="tdleft5px">
                        实验室及辅助检查的选择合理，结果分析，判断正确（有一项不符合，则扣1分）
                    </td>
                </tr>
                <tr>
                    <td class="tdleft5px">
                        临床思维和表达能力
                    </td>
                    <td>
                        &nbsp;
                        <span title="0分"><input id="Item5Record6Score1CheckBox" type="checkbox" name="Item5Record6Score1CheckBox" onclick="javascript:setTimeout('__doPostBack(\'Item5Record6Score1CheckBox\',\'\')', 0)" /><label for="Item5Record6Score1CheckBox">0</label></span>
                    </td>
                    <td>
                        &nbsp;
                        <span title="1分"><input id="Item5Record6Score2CheckBox" type="checkbox" name="Item5Record6Score2CheckBox" onclick="javascript:setTimeout('__doPostBack(\'Item5Record6Score2CheckBox\',\'\')', 0)" /><label for="Item5Record6Score2CheckBox">1</label></span>
                    </td>
                    <td>
                        &nbsp;
                        <span title="2分"><input id="Item5Record6Score3CheckBox" type="checkbox" name="Item5Record6Score3CheckBox" checked="checked" onclick="javascript:setTimeout('__doPostBack(\'Item5Record6Score3CheckBox\',\'\')', 0)" /><label for="Item5Record6Score3CheckBox">2</label></span>
                    </td>
                    <td>
                        <input name="Item5Record6TextBox" type="text" value="2" id="Item5Record6TextBox" disabled="disabled" style="width:55%;" />
                        <span id="RequiredFieldValidator20" style="color:Red;visibility:hidden;">*</span>
                        <span id="RangeValidator20" style="color:Red;visibility:hidden;">*</span>
                    </td>
                    <td class="tdleft5px">
                        临床资料的分析与综合能力，反应能力及表达能力（有一项不符合， 则扣1分）
                    </td>
                </tr>
                <tr>
                    <td>
                        业务学习
                    </td>
                    <td class="tdleft5px">
                        学术会议、学术讲座、病例讨论等<span id="AttendAllKindsStudyLabel">共计：8 次</span>
                    </td>
                    <td>
                        &nbsp;
                        <span title="0分"><input id="Item6Record1Score1CheckBox" type="checkbox" name="Item6Record1Score1CheckBox" onclick="javascript:setTimeout('__doPostBack(\'Item6Record1Score1CheckBox\',\'\')', 0)" /><label for="Item6Record1Score1CheckBox">0</label></span>
                    </td>
                    <td>
                        &nbsp;
                        <span title="1分"><input id="Item6Record1Score2CheckBox" type="checkbox" name="Item6Record1Score2CheckBox" onclick="javascript:setTimeout('__doPostBack(\'Item6Record1Score2CheckBox\',\'\')', 0)" /><label for="Item6Record1Score2CheckBox">1</label></span>
                    </td>
                    <td>
                        &nbsp;
                        <span title="2分"><input id="Item6Record1Score3CheckBox" type="checkbox" name="Item6Record1Score3CheckBox" checked="checked" onclick="javascript:setTimeout('__doPostBack(\'Item6Record1Score3CheckBox\',\'\')', 0)" /><label for="Item6Record1Score3CheckBox">2</label></span>
                    </td>
                    <td>
                        <input name="Item6Record1TextBox" type="text" value="2" id="Item6Record1TextBox" disabled="disabled" style="width:55%;" />
                        <span id="RequiredFieldValidator21" style="color:Red;visibility:hidden;">*</span>
                        <span id="RangeValidator21" style="color:Red;visibility:hidden;">*</span>
                    </td>
                    <td class="tdleft5px">
                        依据研究生培训手册情况记录（大于等与4次/月，为合格），不合格则不能通过
                    </td>
                </tr>
                <tr>
                    <td rowspan="2">
                        二、出科<br />
                        考核(50%)
                    </td>
                    <td colspan="2">
                        理论考试（10分）
                    </td>
                    <td colspan="3">
                        根据实际分数折算
                    </td>
                    <td>
                        <input name="Item7Record1TextBox" type="text" value="9" id="Item7Record1TextBox" style="width:55%;" />
                        <span id="RequiredFieldValidator22" style="color:Red;visibility:hidden;">*</span>
                        <span id="RangeValidator22" style="color:Red;visibility:hidden;">*</span>
                    </td>
                    <td class="tdleft5px">
                        &nbsp;
                    </td>
                </tr>
                <tr>
                    <td colspan="2">
                        技能考核（40分）
                    </td>
                    <td colspan="3">
                        根据实际分数折算
                    </td>
                    <td>
                        <input name="Item7Record2TextBox" type="text" value="39" id="Item7Record2TextBox" style="width:55%;" />
                        <span id="RequiredFieldValidator23" style="color:Red;visibility:hidden;">*</span>
                        <span id="RangeValidator23" style="color:Red;visibility:hidden;">*</span>
                    </td>
                    <td>
                        病史采集、体格检查、辅助检查、临床操作、诊断、鉴别诊断、治疗原则等方面评估
                    </td>
                </tr>
                <tr>
                    <td>
                        综合成绩
                    </td>
                    <td colspan="5">
                        满分100
                    </td>
                    <td>
                        <input name="Item8Record1TextBox" type="text" value="93" id="Item8Record1TextBox" disabled="disabled" style="width:55%;" />
                        
                        
                        
                    </td>
                    <td>
                        &nbsp;
                    </td>
                </tr>
            </table>
            <p class="tdleft5px width95">
                注：（1）请在您认为合适的分数项打“√”</p>
            <p class="tdleft5px width95">
                （2）带教质量：根据实习生和研究生反映住院医师带教情况给予评分。</p>
            <p class="tdleft5px width95">
                （3）业务学习是指科室组织的各种形式的业务学习。</p>
            <p class="tdleft5px width95">
                科主任（签名）：<b><span id="SectionManagerNameLabel"></span></b>
                时间：<b><span id="lblCheckDate">2012-11-10</span></b>
            </p>
            <p>
            </p>
        </p>
    </div>

					            <div style="text-align: center;margin-top: 5px;">
					            	<input type="button" value="计算总分" class="search"/>
					            	<input type="button" value="打印考核表" class="search"/>
					            	<input type="button" value="返&#12288;回" class="search" onclick="doback();"/>
					            </div>
					          </div>
     </div> 	
   </div>	
</body>
</html>