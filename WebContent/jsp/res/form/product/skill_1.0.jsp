<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@include file="/jsp/common/doctype.jsp" %>
<html>
<head>
<c:if test="${!param.noHead}">
<jsp:include page="/jsp/common/htmlhead.jsp">
	<jsp:param name="basic" value="true"/>
	<jsp:param name="jbox" value="true"/>
	<jsp:param name="jquery_form" value="true"/>
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
<style type="text/css">
	.itemDiv {background: white;}
	.itemDiv:HOVER{background: #ccc;}
</style>
<script type="text/javascript">
	function saveForm(){
		if(!$.trim($("#inputMain").val())){
			return jboxTip("请填写技能名称！");
		}
		if($("#skillForm").validationEngine("validate")){
			jboxSubmit($("#skillForm"),"<s:url value='/res/rec/saveRegistryForm'/>",function(resp){
				parentRefresh();
				jboxClose();				
			},function(resp){
				jboxTip("${GlobalConstant.SAVE_FAIL}");
			},true);
		}
	}
	
	$(function(){
		$("[name='operateName']").change();
		
		<c:if test="${rec.auditStatusId eq recStatusEnumTeacherAuditY.id || !(param.roleFlag eq GlobalConstant.RES_ROLE_SCOPE_DOCTOR) || param.isRead}">
			$("#skillForm :input:not(:hidden,:button,:checkbox,:radio)").each(function(){
				$(this).replaceWith($('<label>'+this.value+'</label>'));
			});
// 			$("#skillForm").find(":text,textarea").each(function(){
// 				$(this).replaceWith($('<label>'+$(this).val()+'</label>'));
// 			});
// 			$("#skillForm select").each(function(){
// 				var text = $(this).find(":selected").text();
// 				$(this).replaceWith($('<label>'+text+'</label>'));
// 			});
			$("#skillForm").find(":checkbox,:radio").attr("disabled",true);
			$(":file").remove();
		</c:if>
		
		<c:if test="${!empty param.reqFlow}">
			$(".itemList").change();
		</c:if>
		
	});

	function recSubmit(rec){
		jboxConfirm("确认提交?",function(){
			jboxPost("<s:url value='/res/rec/opreResRec'/>",rec,function(resp){
				if(resp=="${GlobalConstant.DELETE_SUCCESSED}" || resp=="${GlobalConstant.OPRE_SUCCESSED}"){
					parentRefresh();
					jboxClose();
				}
			},null,true);
		},null);
	}

	function parentRefresh(){
		//window.parent.frames['mainIframe'].window.$(".recTypeTag.active").click();
		window.parent.frames['mainIframe'].window.loadProcess();
	}
</script>
</head>
<body>	
   <div class="mainright">
      <div class="content">
        <div class="title1 clearfix">
		<form id="skillForm" enctype="multipart/form-data" method="post">
		<input type="hidden" name="formFileName" value="${formFileName}"/>
		<input type="hidden" name="schDeptFlow" value="${param.schDeptFlow}"/>
		<input type="hidden" name="recFlow" value="${rec.recFlow}"/>
		<input type="hidden" name="processFlow" value="${currRegProcess.processFlow}"/>
   		<table class="basic" width="100%">
   			<tr>
                <th colspan="6" style="text-align: left;">&#12288;登记信息</th>
            </tr>
      		<tr>
             	<td style="width: 100px;"><font color="red">*</font>操作名称：</td>
                <td  colspan="3">
                	<script>
	                	$(function(){
	                		$("[onclick]").click(function(e){
	                			e.stopPropagation();
	                		});
	                		$(".itemDiv").on("mouseenter mouseleave",function(){
	                			$(this).toggleClass("on");
	                		});
	                		$(document).click(function(){
	                			$("#reqHome").toggle(!!$(".itemDiv.on").length);
	                		});
	                		<c:if test="${!empty rec}">
	                			$("[name='itemId']").change();
	                		</c:if>
	                	});
	                	
	                	function viewReqs(){
	                		$("#reqHome").toggle();
	                	}
	                	
	                	function selCheckboxByDiv(div){
	                		var box = $(":checkbox",div)[0];
	                		box.checked = !box.checked;
	                		$("#otherName").toggle($("[name='itemId'][value='${GlobalConstant.RES_REQ_OTHER_ITEM_ID}']")[0].checked);
	                	}
	                	
	                	function viewSelReqs(){
	                		var result = "";
	                		var hidden = "";
	                		$(".itemCheckbox:checked+font").each(function(){
	                			var currName = $(this).text();
	                			if(!result){
	                				result+=currName;
	                			}else{
	                				result+=(","+currName);
	                			}
	                			hidden+=('<input type="hidden" name="itemName" value="'+currName+'"/>');
	                		});
	                		$("#itemNameHome").html(hidden);
	                		$("#viewContainer").val(result);
	                	}
	                	
	                	function loadOther(box){
	                		box.checked=!box.checked;
	                	}
	                	
	                	function itemNameVal(sel){
	                		$("#itemNameInput").val($(":selected",sel).text());
	                		$("#otherName").toggle(sel.value=="${GlobalConstant.RES_REQ_OTHER_ITEM_ID}");
	                	}
                	</script>
      	 			<input type="hidden" name="skillName" value="${formDataMap['skillName']}"/>
      	 			<input type="hidden" name="xmlItemName" value="skillName"/>
      	 			<c:if test="${empty rec}">
	                	<div style="width: 160px;float: left;">
	                		<div style="height: 0px;overflow: visible;position: relative;right: -150px;top: 6px;">
			      	 			<img src="<s:url value='/css/skin/${skinPath}/images/blackDown.png'/>" style="width: 8px;height: 8px;" onclick="viewReqs();">
	                		</div>
		      	 			<input id="viewContainer" type="text" value="${rec.itemName}" style="width: 100%;" readonly="readonly" onclick="viewReqs();"/>
		      	 			<div id="reqHome" style="height: 0px;width: 100%;position: relative;display: none;">
		      	 				<c:forEach items="${deptReqList}" var="req">
		      	 					<div class="itemDiv" style="width: 100%;height: 30px;border-bottom: 1px #bbb solid;border-left: 1px #bbb solid;border-right: 1px #bbb solid;padding-left: 2px;"
		      	 						onclick="selCheckboxByDiv(this);viewSelReqs();">
	      	 							<input class="itemCheckbox" style="margin-left: 8px;" type="checkbox" name="itemId" value="${req.itemId}" onchange="loadOther(this);" <c:if test="${rec.itemId eq req.itemId}">checked</c:if>/>
		      	 						<font style="cursor: default;">${req.itemName}</font>
		      	 					</div>
		      	 				</c:forEach>
		      	 				<div id="itemNameHome"></div>
		      	 			</div>
	                	</div>
      	 			</c:if>
      	 			<c:if test="${!empty rec}">
      	 				<div style="width: 160px;float: left;">
      	 					<select class="validate[required]" name="itemId" onchange="itemNameVal(this);" style="width: 164px;">
      	 						<c:forEach items="${deptReqList}" var="req">
      	 							<option value="${req.itemId}" <c:if test="${rec.itemId eq req.itemId}">selected</c:if>>${req.itemName}</option>
      	 						</c:forEach>
      	 					</select>
	                	</div>
	                	<input type="hidden" id="itemNameInput" name="itemName" value="${rec.itemName}"/>
      	 			</c:if>
      	 			<div id="otherName" style="float: left;display: none;margin-left: 20px;height: 0px;overflow: visible;margin-top: -9px;">
      	 				名称：
	      	 			<input type="text" name="regItem" value="${formDataMap['skillName']}" style="width: 160px;" class="validate[required]"/>
      	 			</div>
      	 			<c:if test="${rec.auditStatusId eq recStatusEnumTeacherAuditY.id || !(param.roleFlag eq GlobalConstant.RES_ROLE_SCOPE_DOCTOR) || param.isRead}">
      	 				${formDataMap['skillName']}
      	 			</c:if>
				</td>
             </tr>
             <tr>
             	<td style="width: 100px;"><font color="red">*</font>操作日期：</td>
                <td >
                    <input style="width: 160px;" class="validate[required]" name="operateDate" type="text" value="${formDataMap['operateDate']}" readonly="readonly" onclick="WdatePicker({dateFmt:'yyyy-MM-dd'});"/>
				</td>
				<td style="width: 100px;"><font color="red">*</font>操作时机：</td>
                <td >
                    <input style="width: 160px;" class="validate[required]" name="operateTime" type="text" value="${formDataMap['operateTime']}" />
				</td>
             </tr>
              <tr>
             	<td style="width: 100px;"><font color="red">*</font>病人姓名：</td>
                <td >
                    <input style="width: 160px;" class="validate[required]" name="patientName" type="text" value="${formDataMap['patientName']}" />
				</td>
				<td style="width: 100px;">病历号：</td>
                <td >
                    <input style="width: 160px;" name="caseNo" type="text" value="${formDataMap['caseNo']}" />
				</td>
             </tr>
              <tr>
             	<td style="width: 100px;">目的：</td>
                <td >
                    <input style="width: 160px;" name="objective" type="text" value="${formDataMap['objective']}" />
				</td>
				<td style="width: 100px;">状态：</td>
                <td >
                   <label><input type="checkbox" name="status" value="执行者" ${(fn:indexOf(formDataMap['status'],'执行者')>-1)?'checked="true"':''}/>执行者</label>
                   &#12288;
                   <label><input type="checkbox" name="status" value="助手" ${(fn:indexOf(formDataMap['status'],'助手')>-1)?'checked="true"':''}/>助手</label>
                   &#12288;
                   <label><input type="checkbox" name="status" value="成功" ${(fn:indexOf(formDataMap['status'],'成功')>-1)?'checked="true"':''}/>成功</label>
				</td>
				
             </tr>
             <tr>
             	<td style="width: 100px;">操作类别：</td>
                <td>
                    <select style="width: 163px;" name="operateType">
	                    <option value="气管插管" ${formDataMap['operateType'] eq '气管插管'?'selected':''}>气管插管</option>
	                    <option value="脚外按压" ${formDataMap['operateType'] eq '脚外按压'?'selected':''}>脚外按压</option>
	                    <option value="其他" ${formDataMap['operateType'] eq '其他'?'selected':''}>其他</option>
                    </select>
				</td>
				<td style="width: 100px;">诊断类型：</td>
                <td>
                    <select style="width: 163px;" name="diagnosisType">
	                    <option value="主要诊断" ${formDataMap['diagnosisType'] eq '主要诊断'?'selected':''}>主要诊断</option>
	                    <option value="次要诊断" ${formDataMap['diagnosisType'] eq '次要诊断'?'selected':''}>次要诊断</option>
	                    <option value="并行诊断" ${formDataMap['diagnosisType'] eq '并行诊断'?'selected':''}>并行诊断</option>
                    </select>
				</td>
				</tr>
             	<tr>
             	<td style="width: 100px;">失败原因：</td>
                <td colspan="3">
                    <input style="width: 493px;" name="failReason" type="text" value="${formDataMap['failReason']}" />
				</td>
             	</tr>
				<tr>
				<td style="width: 100px;">备注：</td>
                <td colspan="3">
                    <input style="width: 493px;" name="remark" type="text" value="${formDataMap['remark']}" />
				</td>
             	</tr>
             	<tr>
             	<td style="width: 100px;">记录：</td>
                <td colspan="3">
                    <textarea style="width:495px;	border:1px solid #bdbebe;	height:100px;	margin:5px 5px 5px 0px" name="record">${formDataMap['record']}</textarea>
				</td>
             	</tr>
             	<tr>
             	<td style="width: 100px;">附件：</td>
                <td colspan="3">
                    <input type="file"/>
				</td>
             	</tr>
              </table>
			<p align="center">
				<c:if test="${!(rec.auditStatusId eq recStatusEnumTeacherAuditY.id) && !param.isRead}">
					<input class="search" type="button" value="保&#12288;存"  onclick="saveForm();"/>
				</c:if>
				<input class="search" type="button" value="关&#12288;闭"  onclick="jboxClose();"/>
			</p>
		</form>
         </div>
        
     </div> 	
   </div>	
</body>
</html>