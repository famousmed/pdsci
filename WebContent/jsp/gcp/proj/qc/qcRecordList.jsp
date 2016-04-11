<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@include file="/jsp/common/doctype.jsp"%>
<style type="text/css">
.ui-recent-footer {
	padding: 12px 9px;
	height: 16px;
	line-height: 16px;
	text-align: right;
}
</style>
<script type="text/javascript">
	function add(remindRecordFlow){
		jboxOpen("<s:url value='/gcp/qc/editQcRecord'/>?projFlow=${param.projFlow}&roleScope=${param.roleScope}&remindRecordFlow="+remindRecordFlow,"新增质控记录",550,450);
	}
	
	function checkEdit(){
		if(("${param.roleScope}" == "${GlobalConstant.ROLE_SCOPE_RESEARCHER}") && !($("#"+$(".qcRecord:checked").val()).val() == "${gcpQcTypeEnumDept.id}")){
			jboxTip("对不起,您只能操作专业组类型的质控记录!");
			return false;
		}else if(("${param.roleScope}" == "${GlobalConstant.ROLE_SCOPE_GO}") && !($("#"+$(".qcRecord:checked").val()).val() == "${gcpQcTypeEnumOrg.id}") && !($("#"+$(".qcRecord:checked").val()).val() == "${gcpQcTypeEnumInspection.id}")){
			jboxTip("对不起,您不能操作专业组类型的质控记录!");
			return false;
		}
		return true;
	}
	
	function edit(){
		if($(".qcRecord:checked").length>0){
			if(checkEdit()){
				jboxOpen("<s:url value='/gcp/qc/editQcRecord'/>?projFlow=${param.projFlow}&qcFlow="+$(".qcRecord:checked").val(),"编辑质控记录",550,450);
			}
		}else{
			jboxTip("请选择一条质控记录!");
		}
	}
	
	function del(){
		if($(".qcRecord:checked").length>0){
			if(checkEdit()){
				jboxConfirm("确认删除该记录？",function(){
					var url = "<s:url value='/gcp/qc/delQcRecord'/>?qcFlow="+$(".qcRecord:checked").val();
					jboxPost(url, null, function(data) {
						if('${GlobalConstant.DELETE_SUCCESSED}'==data){
							window.parent.frames['mainIframe'].window.loadQualityControl(); 
						}
					});
				},null);
			}
		}else{
			jboxTip("请选择一条质控记录!");
		}
	}
	
	function goDetail(qcFlow){
		location.href = "<s:url value='/gcp/qc/qcDetail'/>?beforePage=projInfo&projFlow=${param.projFlow}&qcFlow="+qcFlow+"&roleScope=${param.roleScope}";
	}
	
	function nextRemind(){
		var remindCount = $(".remind").length;
		var showRemind = $(".remind").not(":hidden");
		var cuurIndex = $(".remind").index(showRemind);
		var nextIndex = cuurIndex+1;
		if(nextIndex == remindCount){
			nextIndex = 0 ;
		}
		$(showRemind).slideToggle("slow",function(){
			$($(".remind").get(nextIndex)).slideToggle("slow");
		});
	}
</script>
<div class="i-trend-main-div" >								
			<div>
				<table cellpadding="0" class="i-trend-main-table i-trend-main-div-table" cellspacing="0" border="0" style="width: 100%">
					<colgroup>
						<col width="5%" />
						<col width="5%" />
						<col width="10%" />
						<col width="10%" />
						<col width="10%" />
						<col width="10%" />
						<col width="10%" />
						<col width="10%" />
						<col width="12%" />
						<col width="10%" />
						<col width="8%" />
					</colgroup>
					<tr>
						<th class="ith" colspan="11">
							<span style="float: left;">质控记录</span>
							<c:if test="${!empty qcRemindList}">
								<div style="float: left;margin-left: 40px;width: 65%">
									<img src="<s:url value='/css/skin/${skinPath}/images/thir.png'/>" style="margin-top: 16px;float: left;margin-right: 5px">
									<font style="float: left;color: #FF8400">质控提醒：</font>
									<c:forEach items="${qcRemindList}" var="qcRemind" varStatus="seq">
										<span class="remind" style="${seq.first?'':'display: none;'}">
											<c:if test="${seq.first}">
												<img src="<s:url value='/css/skin/${skinPath}/images/new.gif'/>">
											</c:if>
											<font style="font-weight: normal;color: #000;">
												${qcRemind.remindContent}
												&nbsp;
												<a href="javascript:add('${qcRemind.recordFlow}');" style="color: blue;">点击操作</a>	
											</font>
										</span>
									</c:forEach>
									<img title="下一条" src="<s:url value='/css/skin/${skinPath}/images/blackDown.png'/>" onclick="nextRemind();" style="margin-top: 18px;margin-left: 10px;cursor: pointer;width: 8px;height: 8px;float: right">
								</div>
							</c:if>
							<c:if test="${(param.roleScope eq GlobalConstant.ROLE_SCOPE_GO) || (param.roleScope eq GlobalConstant.ROLE_SCOPE_RESEARCHER)}">
								<div style="float: right;margin-right: 20px;">
									<a href="javascript:add()" style="font-weight: normal;">新增</a>
									 | 
									<a href="javascript:edit()" style="font-weight: normal;">修改</a>
									 | 
									<a href="javascript:del()" style="font-weight: normal;">删除</a>
								</div>
							</c:if>
						</th>
					</tr>
				 	<tr>
				 		<th>选择</th>
				 		<th>序号</th>
				 		<th>质控类型</th>
				 		<th>质控节点</th>
				 		<th>检查开始日期</th>
				 		<th>检查结束日期</th>
				 		<th>检查部门</th>
				 		<th>检查人</th>
				 		<th>检查病历/CRF编码</th>
				 		<th>质控状态</th>
				 		<th>详情</th>
				 	</tr>
				 	<tbody>
				 		<c:forEach items="${qcRecordList}" var="qcRecord" varStatus="seq">
				 			<tr>
				 				<td onclick="$(this).find('.qcRecord').attr('checked',true);">
					 				<input type="radio" class="qcRecord" name="qcFlow" value="${qcRecord.qcFlow}"/>
					 				<input type="hidden" id="${qcRecord.qcFlow}" value="${qcRecord.qcTypeId}"/>
				 				</td>
				 				<td>${seq.count}</td>
				 				<td>${qcRecord.qcTypeName}</td>
				 				<td>${qcRecord.qcCategoryName}</td>
					 			<td>${qcRecord.qcStartDate}</td>
					 			<td>${qcRecord.qcEndDate}</td>
					 			<td>${qcRecord.qcDepartment}</td>
					 			<td>${qcRecord.qcOperator}</td>
					 			<td>${qcRecord.qcPatientCodes}</td>
					 			<td>${qcRecord.qcStatusName}</td>
					 			<td>
					 				<c:if test="${!(gcpQcTypeEnumInspection.id eq qcRecord.qcTypeId)}">
					 					<c:if test="${(gcpQcStatusEnumSave.id eq qcRecord.qcStatusId && ((gcpQcTypeEnumOrg.id eq qcRecord.qcTypeId && param.roleScope eq GlobalConstant.ROLE_SCOPE_GO) || (gcpQcTypeEnumDept.id eq qcRecord.qcTypeId && param.roleScope eq GlobalConstant.ROLE_SCOPE_RESEARCHER))) || (!(gcpQcStatusEnumSave.id eq qcRecord.qcStatusId) && !(param.roleScope eq GlobalConstant.ROLE_SCOPE_DECLARER) || (gcpQcStatusEnumFinish.id eq qcRecord.qcStatusId) && param.roleScope eq GlobalConstant.ROLE_SCOPE_DECLARER)}">
					 						[<a href="javascript:goDetail('${qcRecord.qcFlow}');">报告</a>]
					 					</c:if>
					 				</c:if>
					 			</td>
					 		</tr>
				 		</c:forEach>
				 	</tbody>
				</table>
			</div>									
		<!-- <div class="ui-recent-footer">
			
		</div> -->
	</div>