<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
	
<%@include file="/jsp/common/doctype.jsp" %>

<html>
<head>
	<c:if test="${!param.noHead}">
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
	</c:if>

	<script type="text/javascript">
		//通用js功能配置
		var includeCfg = {
				useCommonInputCtrl:{//使用读写限制功能
					use:true,//是否使用
					ctrlInput:"ctrlInput",//要控制的input类
				},
		};
		
		//保存表单
		//[callback]:回调函数,可获取保存后的返回值
		function saveForm(callback){
			if($("#formForm").validationEngine("validate")){
				jboxPost("<s:url value='/res/rec/saveRegistryForm'/>",$('#formForm').serialize(),function(resp){
					if(callback)
						callback(resp);
				},null,true);
			}
		}
		
		//提交表单
		//rec:json格式ResRec对象,状态,但必须存在recFlow
		//[callback]:回调函数,可获取保存后的返回值
		function recSubmit(rec,callback){
			jboxConfirm("确认提交?",function(){
				jboxPost("<s:url value='/res/rec/opreResRec'/>",rec,function(resp){
					if(callback)
						callback(resp);
				},null,true);
			},null);
		}
		
		//表单初始化
		$(function(){
			//input读写权限控制
			if(includeCfg.useCommonInputCtrl.use)
				inputCtrl();
		});
		
		/*****通用表单功能STRAT*****/
		
		//input读写权限控制
		//所有input的初始状态都是禁用或是label状态
		//所有拥有ctrlInput类的元素都是需要权限控制的元素
		//为元素添加可操作的角色类:manager,admin....
		function inputCtrl(){
			$("."+includeCfg.useCommonInputCtrl.ctrlInput+"(:text,textarea)").attr("readonly",true);
		}
		
		/*****通用表单功能END*****/
	</script>
</head>

<body>
	<form id="formForm">
		<jsp:include page="/jsp/${jspPath}.jsp"></jsp:include>
	</form>
</body>
</html>

