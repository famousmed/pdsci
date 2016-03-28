<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@include file="/jsp/common/doctype.jsp" %>
<html>
<head>
<c:if test="${param.roleFlag eq GlobalConstant.RES_ROLE_SCOPE_DOCTOR}">
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
	var itemList = [
	                <c:forEach items="${appealMap}" var="appeal">
	                	"${appeal.key}",
	                </c:forEach>
	                ];

	var valueSel = "";
	
	function filterItem(recTypeId){
		$("select[name='itemId'] option").hide();
		$("."+recTypeId).show();
		$("."+recTypeId+valueSel+"[out]:first").attr("selected","selected");
		$("[name='itemId']").change();
	}
	
	function reqCount(item){
		<c:if test="${param.roleFlag eq GlobalConstant.RES_ROLE_SCOPE_DOCTOR}">
			if(${empty req.itemId} && itemList.indexOf(item.value)>=0){
				jboxTip("该对象已申述!");
				filterItem("${param.recTypeId}");
				return false;
			}
		</c:if>
		var recCount = $(item).find(':selected').attr('recCount');
		var reqNum = $(item).find(':selected').attr('reqNum');
		$('#reqNum').text(reqNum);
		$('#recCount').text(recCount);
		var appealNum = parseInt(reqNum) - parseInt(recCount);
		$(":text[name='appealNum']").attr("class","validate[required,custom[integer],max["+appealNum+"]]");
	}
	
	function saveAppeal(){
		if($("#appealForm").validationEngine("validate")){
			var url = "<s:url value='/res/rec/saveAppeal'/>";
			var getdata = $('#appealForm').serialize();
			jboxPost(url, getdata, function(data) {
				if('${GlobalConstant.SAVE_SUCCESSED}'==data){
					window.parent.frames['mainIframe'].window.$(".recTypeTag.active").click();
					jboxClose();
				}
			},null,true);
		}
	}
	
// 	function operAppeal(appeal){
// 		jboxConfirm("确认提交?",function(){
// 			jboxPost("<s:url value='/res/rec/operAppeal'/>",appeal,function(resp){
// 				if(resp=="${GlobalConstant.DELETE_SUCCESSED}" || resp=="${GlobalConstant.OPRE_SUCCESSED}"){
// 					window.parent.frames['mainIframe'].window.$(".toolkit-bar .toolkit-item-tab.active").click();
// 					jboxClose();
// 				}
// 			},null,true);
// 		},null);
// 	}
	
	<c:if test="${!(param.roleFlag eq GlobalConstant.RES_ROLE_SCOPE_DOCTOR) && empty appeal.auditStatusId}">
		function operAppeal(appeal){
			appeal.appealFlow = "${appeal.appealFlow}";
			jboxConfirm("确认审核?",function(){
				jboxPost("<s:url value='/res/rec/operAppeal'/>",appeal,function(resp){
					if(resp=="${GlobalConstant.DELETE_SUCCESSED}" || resp=="${GlobalConstant.OPRE_SUCCESSED}"){
						//window.parent.frames['mainIframe'].window.search();
						recReLoad();
						jboxClose();
					}
				},null,true);
			},null);
		}
	</c:if>
	
	$(function(){
		valueSel = "[value='"+("${appeal.itemId}" || "${req.itemId}")+"']";
		//valueSel = ${empty appeal.itemName}?(${empty param.itemName}?"":"[value='${param.itemName}']"):"[value='${appeal.itemName}']";
		$("select[name='recTypeId']").change();
		valueSel = "";
		
		<c:if test="${!(param.roleFlag eq GlobalConstant.RES_ROLE_SCOPE_DOCTOR && !(appeal.auditStatusId eq recStatusEnumTeacherAuditY.id))}">
			$(".appealContent :text,.appealContent textarea").each(function(){
				$(this).replaceWith($('<label>'+$(this).val()+'</label>'));
			});
			$(".appealContent select").each(function(){
				var text = $(this).find(":selected").text();
				$(this).replaceWith($('<label>'+text+'</label>'));
			});
			$(".appealContent font").each(function(){
				if($.trim($(this).text())=="*"){
					$(this).text("");
				}
			});
			//$("#saveButton").remove();
		</c:if>	
		
		<c:if test="${!(param.roleFlag eq GlobalConstant.RES_ROLE_SCOPE_DOCTOR) && empty appeal.auditStatusId}">
			var auditStatusId = window.parent.frames['mainIframe'].window.auditStatus;
			var auditJson = {"appealFlow":"${appeal.appealFlow}"};
			
			$("#buttonHome").prepend($('<input type="button" value="审核不通过" class="search"/>').click(function(){
				//auditJson[auditStatusId.attrName] = auditStatusId.no;
				operAppeal({auditStatusId:"${recStatusEnumTeacherAuditN.id}"});
			}));
			$("#buttonHome").prepend($('<input type="button" value="审核通过" class="search"/>').click(function(){
				//auditJson[auditStatusId.attrName] = auditStatusId.yes;
				operAppeal({auditStatusId:"${recStatusEnumTeacherAuditY.id}"});
			}));
		</c:if>
		$("select.defaultItem").each(function(){
			var text = $(this).find(":selected").text();
			$(this).replaceWith($('<label>'+text+'</label><input type="hidden" name="itemId" value="${req.itemId}"/>'));
		});
	});
</script>
</head>
<body>	
   <div class="mainright">
      <div class="content appealContent">
        <div class="title1 clearfix">
		<form id="appealForm">
		<input type="hidden" name="appealFlow" value="${appeal.appealFlow}"/>
		<input type="hidden" name="schDeptFlow" value="${empty appeal?param.schDeptFlow:appeal.schDeptFlow}"/>
   		<table class="basic" width="100%">
   			<tr>
                <th colspan="6" style="text-align: left;">&#12288;申述信息</th>
            </tr>
      		<tr>
             	<td style="width: 100px;">申述类别：</td>
                <td colspan="3">
                   	<select style="width: 156px;" class="validate[required]" name="recTypeId" onchange="filterItem(this.value);" ${!empty param.recTypeId?'disabled':''}>
                   		<c:forEach items="${registryTypeEnumList}" var="registryType">
	                   		<c:set value="res_registry_type_${registryType.id}" var="viewCfgKey"/>
                   			<c:if test="${sysCfgMap[viewCfgKey] eq GlobalConstant.FLAG_Y && GlobalConstant.FLAG_Y eq registryType.haveAppeal}">
	                   			<option value="${registryType.id}" ${registryType.id eq param.recTypeId || registryType.id eq appeal.recTypeId?'selected':''}>${registryType.name}</option>
	                   		</c:if>
                   		</c:forEach>
                   	</select>
                   	<font color="red">*</font>
                   	<c:if test="${!empty param.recTypeId}">
                   		<input type="hidden" name="recTypeId" value="${param.recTypeId}"/>
                   	</c:if>
				</td>
             </tr>
             <tr>
             	<td style="width: 100px;">申述对象：</td>
                <td colspan="3">
                    <select style="width: 156px;" class="validate[required] ${!empty req.itemId?'defaultItem':''}" name="itemId" onchange="reqCount(this);$('#itemNameContainer').val($(':selected',this).text());">
                    	<c:forEach items="${deptReqList}" var="deptReq">
                    		<c:set value="${deptReq.recTypeId}${deptReq.itemId}" var="key"></c:set>
                    		<option reqNum="${reqCountMap[deptReq.reqFlow]+0}" recCount="${reqCountMap[key]+0}" value="${deptReq.itemId}" class="${deptReq.recTypeId}" ${(deptReq.itemId eq req.itemId || deptReq.itemId eq appeal.itemId)?'selected':''} style="${!empty appealMap[deptReq.itemId]?'color:red;':''}" ${!empty appealMap[deptReq.itemId]?'in':'out'}>${deptReq.itemName}</option>
                    	</c:forEach>
                    </select>
                    <font color="red">*</font>
              		<input type="hidden" id="itemNameContainer" name="itemName" value="${req.itemName}"/>
				</td>
				</tr>
				<tr>
				<td style="width: 100px;">申述数量：</td>
                <td colspan="3">
                    <input name="appealNum" type="text" value="${appeal.appealNum}" />
                    <font color="red">*</font>
                    &nbsp;(完成情况：<font id="recCount" color="red">0</font>/<font id="reqNum">0</font>)
				</td>
             </tr>
             	
            <tr>
             	<td style="width: 100px;">申述理由：</td>
                <td colspan="3">
                    	<textarea style="width:487px;border:1px solid #bdbebe;height:100px;margin:5px 5px 5px 0px" name="appealReason">${appeal.appealReason}</textarea>
				</td>
             	</tr>
             	<tr>
             	<td style="width: 100px;">申述人：</td>
                <td colspan="">
                    	<span>${empty appeal?sessionScope.currUser.userName:appeal.operUserName}</span>
                    	<input type="hidden" name="operUserFlow" value="${empty appeal?sessionScope.currUser.userFlow:appeal.operUserFlow}"/>
                    	<input type="hidden" name="operUserName" value="${empty appeal?sessionScope.currUser.userName:appeal.operUserName}"/>
				</td>
				<td style="width: 100px;">申述时间：</td>
                <td colspan="">
                    	<input type="text" name="operTime" value="${empty appeal?(pdfn:getCurrDate()):appeal.operTime}" readonly="readonly" onclick="WdatePicker({dateFmt:'yyyy-MM-dd'});"/>
				</td>
             	</tr>
             	<!-- 
             	<c:if test="${appeal.statusId eq recStatusEnumSubmit.id}">
             		<tr class="ith">
             			<td style="width: 100px;">审核结果：</td>
             			<td  colspan="3">${empty appeal.auditStatusId?'待审核':appeal.auditStatusName}</td>
             		</tr>
             	</c:if>
             	 -->
              </table>
			<p align="center" id="buttonHome">
				<c:if test="${param.roleFlag eq GlobalConstant.RES_ROLE_SCOPE_DOCTOR && !(appeal.auditStatusId eq recStatusEnumTeacherAuditY.id)}">
					<input id="saveButton" class="search" type="button" value="保&#12288;存"  onclick="saveAppeal();" style="${appeal.statusId eq recStatusEnumSubmit.id?'display: none;':''}"/>
					<input class="search" type="button" value="关&#12288;闭"  onclick="jboxClose();" />
				</c:if>
				<!--<c:if test="${!empty appeal && !(appeal.statusId eq recStatusEnumSubmit.id)}">
					<input type="button" value="提&#12288;交" class="search" onclick="operAppeal({'appealFlow':'${appeal.appealFlow}','statusId':'${recStatusEnumSubmit.id}'});"/>
				</c:if>-->
			</p>
		</form>
         </div>
        
     </div> 	
   </div>	
</body>
</html>