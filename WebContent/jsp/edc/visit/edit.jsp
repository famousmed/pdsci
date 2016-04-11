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
	<jsp:param name="tag" value="true"/>
</jsp:include>
<style type="text/css">
.moduleDiv{color:#fff;line-height:35px;float:left;height:35px;background-color:#1CA1E2;text-align: center;vertical-align: middle;padding-left:20px;padding-right:20px;margin-left: 20px;margin-top: 10px;cursor: pointer; }
</style>
</head>
<script type="text/javascript">
function addVisit(){
	if($("#proj").val()==""){
		 jboxTip("请选择项目");
		return;
	}
	var url = "<s:url value='/edc/visit/addVisit'/>";
	jboxConfirm("确认新增访视？" , function(){
		jboxGet(url , null , function(){showVisit();} , null , true);
	});
	
}
function showVisit(){
	jboxGet("<s:url value='/edc/visit/showVisit'/>",null,function(resp){
		$("#visitDiv").html(resp);				
	},null,false);	
}
function save(){
	if(false==$("#visitForm").validationEngine("validate")){
		return ;
	}
	jboxPost("<s:url value='/edc/visit/save?visitFlow=${visit.visitFlow}'/>", $('#visitForm').serialize(), function() {
		window.parent.frames['mainIframe'].window.search();
		jboxClose();
	});
}
function doBack(){
	window.location.href="<s:url value='/edc/visit/list'/>";
}

</script>
<body>
<form id="visitForm">
<div class="title1 clearfix" >
		<p style="display: none">
			访视序号：<input type="text" name="ordinal" class="show" value="${visit.ordinal }" /> 
			访视类别：<select name="visitTypeId" class="validate[required] show" style="width: 150px">
						<option value=""></option>
						<c:forEach var="dict" items="${dictTypeEnumVisitTypeList}">
							<option value="${dict.dictId}" <c:if test="${visit.visitTypeId==dict.dictId}">selected="selected"</c:if>>${dict.dictName}</option>
						</c:forEach>

					</select>
		</p>
		<p style="display: none">
			访视名称：<input type="text" name="visitName" class="xlname" value="${visit.visitName }" style="width: 310px"/>
			访视窗：<input type="text" name="visitWindow" value="${pdfn:split(visit.visitWindow,',')[0] }"
				class="show " style="text-align: center;width: 30px"  />- <input type="text" name="visitWindow" value="${pdfn:split(visit.visitWindow,',')[1] }"
				class="show" style="text-align: center;width: 30px"/>+ <input type="text" name="visitWindow" value="${pdfn:split(visit.visitWindow,',')[2] }"
				class="show" style="text-align: center;width: 30px"/>
				<input type="button"
				class="dingdan-d" onclick="save();" value="保存"><input type="button"
				class="dingdan-d" onclick="doBack();" value="返回">
		</p>
		<div>
		<div id="tags_1_tagsinput" class="tagsinput" style="width: auto;">
		
		<div class="tags_clear"></div></div>
		</div>
		<div style="float: left;padding-left: 10px;">常用模块：<br/><br/>
		<a href="#">添加模块</a>
		</div>
		<div id="tags_1_tagsinput"  class="tagsinput" style="width: auto;border: 0px;">
			<span class="tag"><span>人口统计学(DM)&nbsp;&nbsp;</span><span onclick="alert(123);" style="cursor: pointer;">x</span></span>
		</div>
		<span class="tag"><span>生命体征(VS)&nbsp;&nbsp;</span><span onclick="alert(123);" style="cursor: pointer;">x</span></span>
		<span class="tag"><span>体格检查(DM)&nbsp;&nbsp;</span><span onclick="alert(123);" style="cursor: pointer;">x</span></span>
		<span class="tag"><span>人口统计学(DM)&nbsp;&nbsp;</span><span onclick="alert(123);" style="cursor: pointer;">x</span></span>
		<span class="tag"><span>生命体征(VS)&nbsp;&nbsp;</span><span onclick="alert(123);" style="cursor: pointer;">x</span></span>
		<span class="tag"><span>血常规(RBC)&nbsp;&nbsp;</span><span onclick="alert(123);" style="cursor: pointer;">x</span></span>
		<span class="tag"><span>尿常规(DM)&nbsp;&nbsp;</span><span onclick="alert(123);" style="cursor: pointer;">x</span></span>
		<span class="tag"><span>不良事件(AE)&nbsp;&nbsp;</span><span onclick="alert(123);" style="cursor: pointer;">x</span></span>
</div>
<div>
<hr/>
</div>
</form>
<div id="visitDiv" style="width: 100%;height: 100%;">
            	
</div>
</body>
</html>