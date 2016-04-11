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
	function nextOpt(step){
		if(false==$("#projForm").validationEngine("validate")){
			return false;
		}
		var form = $('#projForm');
		var action = form.attr('action');
		action+="?nextPageName="+step;
		form.attr("action" , action);
		form.submit();
	}

</script>
<style type="text/css">
 .bs_tb tbody th{background: #fff;}
 .bs_tb tbody td{text-align: left;}
 .bs_tb tbody td input{text-align: left;margin-left: 10px;}
</style>
</head>
<body>
<div id="main">
	<div class="mainright">
		<div class="content">
       <div style="margin-top: 10px;">
	<form action="<s:url value='/srm/proj/mine/saveStep'/>" method="post"
		id="projForm">
		<input type="hidden" id="pageName" name="pageName" value="step2" /> 
		<input type="hidden" id="recFlow" name="recFlow" value="${projRec.recFlow}"/>
		<input type="hidden" id="projFlow" name="projFlow" value="${proj.projFlow}"/>
		<input type="hidden" id="recTypeId" name="recTypeId" value="${param.recTypeId}"/>
		   
		<font style="font-size: 14px; font-weight:bold;color: #333; ">二、考核指标</font>
		<table  class="basic" style="width: 100%">
			<tr>
				<th style="text-align: left;padding-left: 20px;">考核指标</th>
			</tr>
			<tr>
		     	<td style="text-align:left;padding-left: 10px;padding-top: 10px;padding-bottom: 10px;" colspan="6">
		     		第一年考核指标：
		     		<textarea placeholder="" class="xltxtarea" name="indicatorsY1">${resultMap.indicatorsY1}</textarea>
		     	</td>
			</tr>
			<tr>
		     	<td style="text-align:left;padding-left: 10px;padding-top: 10px;padding-bottom: 10px;" colspan="6">
		     		第二年考核指标：
		     		<textarea placeholder="" class="xltxtarea" name="indicatorsY2">${resultMap.indicatorsY2}</textarea>
		     	</td>
			</tr>
			<tr>
		     	<td style="text-align:left;padding-left: 10px;padding-top: 10px;padding-bottom: 10px;" colspan="6">
		     		第三年考核指标：
		     		<textarea placeholder="" class="xltxtarea" name="indicatorsY3">${resultMap.indicatorsY3}</textarea>
		     	</td>
			</tr>
			<tr>
		     	<td style="text-align:left;padding-left: 10px;padding-top: 10px;padding-bottom: 10px;" colspan="6">
		     		第四年考核指标：
		     		<textarea placeholder="" class="xltxtarea" name="indicatorsY4">${resultMap.indicatorsY4}</textarea>
		     	</td>
			</tr>
			<tr>
		     	<td style="text-align:left;padding-left: 10px;padding-top: 10px;padding-bottom: 10px;" colspan="6">
		     		第五年考核指标：
		     		<textarea placeholder="" class="xltxtarea" name="indicatorsY5">${resultMap.indicatorsY5}</textarea>
		     	</td>
			</tr>
		</table>
		</form>
    <div class="button" style="width: 100%; <c:if test="${param.view == GlobalConstant.FLAG_Y}">display:none</c:if>">
	   <a href="javascript:void(0)" target="_self" class="search" onclick="nextOpt('step1')">上一步</a>
	   <a href="javascript:void(0)" target="_self" class="search" onclick="nextOpt('step3')">下一步</a>
    </div>
		</div>
		</div>
		</div>
		</div>
		</body>
		</html>
		