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
	function save(){
		var form = $("#editForm");
		var requestData = form.serialize();
		var url = "<s:url value='/gcp/rec/saveFinishWork'/>";
		if ($("#projStageId").length >0 && $("#projStageId").val() != "${gcpProjStageEnumSchedule.id }") {
			jboxConfirm("项目状态改变后不可修改，确认保存？", function() {
				jboxPost(url,requestData,function(resp){
					if(resp=='${GlobalConstant.SAVE_SUCCESSED}'){
						window.parent.frames['mainIframe'].window.location.href = "<s:url value='/gcp/proj/projInfo'/>?projFlow=${proj.projFlow}&roleScope=${param.roleScope}&tagId=yjjsgz";
						jboxClose();
					}
				},null,true);
			});
		} else {
			jboxPost(url,requestData,function(resp){
				if(resp=='${GlobalConstant.SAVE_SUCCESSED}'){
					window.parent.frames['mainIframe'].window.loadFinishWork();
					jboxClose();
				}
			},null,true);
		}
	}
</script>
</head>
<body>
	<div class="mainright">
      <div class="content">
        <div class="title1 clearfix">
		<form id="editForm">
   		<table class="basic" width="100%">
   			<tr>
				<th colspan="4" style="text-align: left;padding-left: 10px;">研究结束工作</th>
			</tr>
			<tr>
             <td style="text-align: right;">数据库锁定日期：</td>
             <td >
             	<input type="text" name="dbLockDate" value="${fwForm.dbLockDate }" class="xltext ctime" readonly="readonly" onClick="WdatePicker({dateFmt:'yyyy-MM-dd'})"  />
             </td>
             <td style="text-align: right;">剩余药物退还清库日期：</td>
             <td >
             	<input type="text" name="cleanDate" value="${fwForm.cleanDate }" class="xltext ctime" readonly="readonly" onClick="WdatePicker({dateFmt:'yyyy-MM-dd'})"  />
             </td>
             
            </tr>
   			<tr>
   				<td style="text-align: right;">项目信息锁定日期：</td>
                <td >
                	<input type="text" name="projLockDate" value="${fwForm.projLockDate }" class="xltext ctime" readonly="readonly" onClick="WdatePicker({dateFmt:'yyyy-MM-dd'})"  />
                </td>
                <td style="text-align: right;">审评意见答复日期：</td>
                <td>
                	<input type="text" name="replyDate" value="${fwForm.replyDate }" class="xltext ctime" readonly="readonly" onClick="WdatePicker({dateFmt:'yyyy-MM-dd'})"  />
                </td>
            </tr>
   			<tr>
   				<td style="text-align: right;">药审中心答辩日期：</td>
                <td >
                	<input type="text" name="answerDate" value="${fwForm.answerDate }" class="xltext ctime" readonly="readonly" onClick="WdatePicker({dateFmt:'yyyy-MM-dd'})"  />
                </td>
                <td style="text-align: right;">药品注册号：</td>
                <td>
                	<input type="text" name="regNumber" value="${fwForm.regNumber }" class="xltext ctime" readonly="readonly" onClick="WdatePicker({dateFmt:'yyyy-MM-dd'})" />
                </td>
            </tr>
            <tr>
   				<td style="text-align: right;">药品批准文号：</td>
                <td>
                	<input type="text" name="appNumber" value="${fwForm.appNumber }" class="xltext"  />
                </td>
                <td style="text-align: right;">获得证书复印件日期：</td>
                <td>
                	<input type="text" name="copiesDate" class="xltext ctime" readonly="readonly" onClick="WdatePicker({dateFmt:'yyyy-MM-dd'})" value="${fwForm.copiesDate }"/>
                </td>
            </tr>
            <tr>
				<td style="text-align: right;">项目状态：</td>
				<td colspan="3">
					<c:if test="${gcpProjStageEnumSchedule.id eq proj.projStageId }">
						<select id="projStageId" name="projStageId" class="xlselect">
							<option value="${gcpProjStageEnumSchedule.id }">${gcpProjStageEnumSchedule.name }</option>
							<option value="${gcpProjStageEnumComplete.id }">${gcpProjStageEnumComplete.name }</option>
							<option value="${gcpProjStageEnumTerminate.id }">${gcpProjStageEnumTerminate.name }</option>
						</select>
					</c:if>
					<c:if test="${gcpProjStageEnumSchedule.id != proj.projStageId }">${proj.projStageName }</c:if>
				</td>
			</tr>
			</table>
			<p align="center">
			    <input name="projFlow" type="hidden" value="${param.projFlow }" />
				<input class="search" type="button" value="保&#12288;存"  onclick="save();" />
				<input class="search" type="button" value="关&#12288;闭" onclick="jboxClose();" />
			</p>
		</form>
         </div>
     </div> 	
   </div>
</body>
</html>