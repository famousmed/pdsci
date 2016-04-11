<jsp:include page="/jsp/sczyres/htmlhead-sczyres.jsp">
	<jsp:param name="basic" value="true"/>
	<jsp:param name="jbox" value="true"/>
</jsp:include>
<div class="infoAudit2" style="padding:0;">
    <jsp:include page='/jsp/sczyres/doctor/singupinfo.jsp'/>
    <div class="div_table">
		<table border="0" width="100%" cellspacing="0" cellpadding="0">
		    <caption style="text-align: left;font-weight: bolder;">审核意见</caption>
			<tr>
			    <td colspan="4" style="padding-top:10px;padding-left:0;">
				    <textarea id="auditAgree"></textarea>
				</td>
			</tr>
		</table>
    </div>
	<div align="center" style="margin-top: 20px; margin-bottom:20px;">
	    <input type="button" style="width:100px;" class="btn_blue" onclick="javascript:audit('${regStatusEnumPassed.id}','审核通过');" value="通过"></input>
		<input type="button" style="width:100px;" class="btn_red" onclick="javascript:audit('${regStatusEnumUnPassed.id}','审核不通过');" value="不通过"></input>
		<input type="button" style="width:100px;" class="btn_grey" onclick="javascript:jboxClose();" value="关闭"></input>
	</div>
</div>
<script type="text/javascript">
	function audit(statusId,title){
		if("${regStatusEnumUnPassed.id}"==statusId){
			if($.trim($("#auditAgree").val())==""){
				jboxTip("审核意见不能为空!");
				return;
			}
		}
		jboxConfirm("确认"+title+"?",function(){
			var data = {
					doctorFlow:"${doctor.doctorFlow}",
					disactiveReason:$("#auditAgree").val(),
					userFlow:"${user.userFlow}",
					doctorStatusId:statusId
			};
			jboxPost("<s:url value='/sczyres/hosptial/userAudit'/>",data,
				function(resp){
					if(resp == "${GlobalConstant.OPRE_SUCCESSED}"){
						window.parent.$(".tab_select").click();
						jboxClose();
					}
				}
			,null,true);
		});
	}
</script>