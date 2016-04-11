<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@include file="/jsp/common/doctype.jsp"%>
<html>
<head>
<jsp:include page="/jsp/common/htmlhead.jsp">
	<jsp:param name="basic" value="true" />
	<jsp:param name="jbox" value="true" />
	<jsp:param name="jquery_form" value="false" />
	<jsp:param name="jquery_ui_tooltip" value="true" />
	<jsp:param name="jquery_ui_combobox" value="false" />
	<jsp:param name="jquery_ui_sortable" value="false" />
	<jsp:param name="jquery_cxselect" value="false" />
	<jsp:param name="jquery_scrollTo" value="true" />
	<jsp:param name="jquery_jcallout" value="false" />
	<jsp:param name="jquery_validation" value="true" />
	<jsp:param name="jquery_datePicker" value="true" />
	<jsp:param name="jquery_fullcalendar" value="false" />
	<jsp:param name="jquery_fngantt" value="false" />
	<jsp:param name="jquery_fixedtableheader" value="true" />
	<jsp:param name="jquery_placeholder" value="true" />
	<jsp:param name="jquery_iealert" value="false" />
</jsp:include>
<style type="text/css">
.cont_list .left .zje {
	color: red;
	display: inline-block;
	width: 60px;
}
</style>
<script type="text/javascript">
	function search(projFlow) {
		$('#projFlow').val(projFlow);
		$("#searchForm").submit();

	}
	function add(projFlow) {
		var url = "<s:url value ='/gcp/fin/editFund'/>?projFlow=" + projFlow;
		jboxOpen(url, "新增经费记录", 700, 380);
	}
	function showDetail(projFlow) {
		var contentDiv = $("#cont_div_" + projFlow);
		contentDiv.slideToggle("slow");

	}
	function editFund(fundFlow, projFlow) {
		var url = "<s:url value ='/gcp/fin/editFund'/>?fundFlow=" + fundFlow
				+ "&projFlow=" + projFlow;
		jboxOpen(url, "编辑经费记录", 700, 380);
	}
	function reload() {
		window.location.reload();
	}
	function delFund(fundFlow, projFlow) {
		jboxConfirm("确认删除该经费信息？", function() {
			var url = "<s:url value='/gcp/fin/delFund'/>?fundFlow=" + fundFlow;
			jboxPost(url, null, function(resp) {
				if (resp == '${GlobalConstant.DELETE_SUCCESSED}') {
					search(projFlow);
				}
			}, null, true);
		}, null);
	}
	$(document)
			.ready(
					function() {
						var projFlow = $("#projFlow").val();
						var contdivs = $(".cont_div");
						if (projFlow == ""
								&& ('${param.projNo}' != "" || '${param.projName}' != "")) {
							$.each(contdivs,
									function(i, n) {
										if (("cont_div_" + projFlow) != $(n)
												.attr("id"))
											$(n).slideToggle("slow");
									});
						}
						if (projFlow != "") {
							showDetail(projFlow);
						}
					});
</script>
</head>
<body>
	<div class="mainright">
		<div class="content" style="padding-top: 10px;">
			<div style="margin-bottom: 10px;">
				<form id="searchForm"
					action="<s:url value='/gcp/fin/projFundList'/>?deptFlag=y"
					method="post" style="position: relative;">
					<input type="hidden" id="projFlow" name="projFlow"
						value="${param.projFlow }" /> 项目名称： <input type="text"
						name="projName" value="${param.projName }" class="xltext" /> 专业组：

					<select name="applyDeptFlow" class="xlselect" style="width: 100px">
						<option value="">请选择</option>
						<c:forEach items="${deptList}" var="dept">
							<option value="${dept.deptFlow }"
								<c:if test="${dept.deptFlow eq param.applyDeptFlow}">selected="selected"</c:if>>${dept.deptName}</option>
						</c:forEach>
					</select> <input type="button" onclick="search('');" value="查&#12288;询"
						class="search"> &#12288;&#12288; <font style="font-weight: bolder;">未到账：</font><font id="unInSumTotal" color="red"></font>&#12288;
						<font style="font-weight: bolder;">总到账：</font><font id="inSum" color="red"></font>
					&#12288;<font style="font-weight: bolder;">总支出：</font><font
						id="outSum" color="red"></font> &#12288; <font style="font-weight: bolder;">总结余：</font><font
						id="remainSum" color="red"></font>
				</form>
			</div>
			<c:if test="${empty projList }">
				<div class="cont_list" style="margin-top: 10px;">
					<div style="text-align: center;">无记录！</div>
				</div>
			</c:if>
			<c:set value="0" var="inSum"></c:set>
			<c:set value="0" var="outSum"></c:set>
			<c:set value="0" var="remainSum"></c:set>
			<c:forEach items="${projList }" var="proj" varStatus="sumCount">
				<div class="cont_list" id="cont_list_${proj.projFlow }">
					<div class="left" onclick="showDetail('${proj.projFlow}')">
					<c:set value="${(contractFundMap[proj.projFlow]+0-(countMap[proj.projFlow]['fundInTotal']+0))<0?0:contractFundMap[proj.projFlow]+0-(countMap[proj.projFlow]['fundInTotal']+0) }" var="unInSum" />
						项目名称：<span class="name">${proj.projShortName }</span> 
						未到账：<span class="zje">${unInSum }</span>
						累计到账：<span
							class="zje"><c:out
								value="${countMap[proj.projFlow]['fundInTotal'] }" default="0" /></span>
						累计支出：<span class="zje"><c:out
								value="${countMap[proj.projFlow]['fundOutTotal'] }" default="0" /></span>
						结余金额：<span class="zls"><c:out
								value="${countMap[proj.projFlow]['fundRemainTotal'] }"
								default="0" /></span>
						<c:set value="${unInSumTotal+unInSum}"
							var="unInSumTotal"></c:set>
						<c:set value="${inSum+countMap[proj.projFlow]['fundInTotal']}"
							var="inSum"></c:set>
						<c:set value="${outSum+countMap[proj.projFlow]['fundOutTotal']}"
							var="outSum"></c:set>
						<c:set
							value="${remainSum+countMap[proj.projFlow]['fundRemainTotal']}"
							var="remainSum"></c:set>
						<c:if test="${sumCount.last}">
							<script type="text/javascript">
								$("#unInSumTotal").text("${unInSumTotal}");
								$("#inSum").text("${inSum}");
								$("#outSum").text("${outSum}");
								$("#remainSum").text("${remainSum}");
							</script>
						</c:if>
					</div>
					<div class="right">
						<a href="javascript:void(0)" onclick="add('${proj.projFlow}')"><img
							alt="新增经费" title="新增经费"
							src="<s:url value='/css/skin/Blue/images/add5.png'/>"></a>
					</div>
				</div>
				<div class="cont_div" style="display: none;"
					id="cont_div_${proj.projFlow }">
					<div class="i-trend" style="padding-top: 0px;">
						<table class="i-trend-table" style="border-top: none;" border="1"
							cellpadding="0" cellspacing="0">
							<tbody>
								<tr>
									<td>
										<dl class="selectTag" id="${proj.projFlow }">
											<c:if test="${empty fundMap[proj.projFlow] }">
												<center>
													<span style="margin-left: 20px;">无记录！</span>
												</center>
											</c:if>
											<c:forEach items="${fundMap[proj.projFlow]}" var="fund">
												<c:choose>
													<c:when test="${fund.fundTypeId eq gcpFundTypeEnumIn.id}">
														<dt id="${fund.fundFlow }"
															style="cursor: pointer;width: 149px;height:195px;height:;background-image:url('${ctxPath}/css/skin/${skinPath}/images/fund_in.png');
				              float: left;margin-top: 5px;margin-right: 10px;margin-left: 10px;"
															onclick="editFund('${fund.fundFlow}','${proj.projFlow}');">
															<font style="float: left;position: relative;left: 35px;top: 0px">${fund.fundTypeName}</font>
															<ul>
																<li
																	style="padding-right: 15px; margin-top: 5px; position: relative; display: block;"><span
																	style="padding-left: 55px; line-height: 25px;"></span><span
																	style="float: right; padding-top: 5px;"><img
																		onclick="event.cancelBubble=true;delFund('${fund.fundFlow}','${proj.projFlow }');"
																		src="<s:url value='/css/skin/${skinPath}/images/fund_delete.png'/>"></span></li>
																<li style="height: 10px;"></li>
																<c:if test="${fund.fundTypeId eq gcpFundTypeEnumIn.id }">
																	<li
																		style="padding-left: 10px; height: 25px; display: inline-block; position: relative;">票号：${fund.fundNo
																		}</li>
																</c:if>
																<li style="padding-left: 10px; height: 25px;">金额：${fund.fundAmount
																	}元</li>
																<li style="padding-left: 10px; height: 25px;">日期：${fund.fundDate
																	}</li>
																<li title="${fund.fundNote}" style="padding-left: 10px; height: 25px;">内容：${pdfn:cutString(fund.fundNote,5,true,3
																	)}</li>
																<c:if
																	test="${fund.fundTypeId eq gcpFundTypeEnumOut.id }">
																	<li style="padding-left: 10px; height: 25px;">用途：${fund.fundUsesName
																		}</li>
																	<c:if test="${! empty fund.fundUsesOther }">
																		<li style="padding-left: 10px; height: 25px;">其它用途：${pdfn:cutString(fund.fundUsesOther,3,true,3
																			)}</li>
																	</c:if>
																</c:if>
															</ul>
														</dt>
													</c:when>
													<c:when test="${fund.fundTypeId eq gcpFundTypeEnumOut.id}">
														<dt id="${fund.fundFlow }"
															style="cursor: pointer;width: 149px;height:195px;height:;background-image:url('${ctxPath}/css/skin/${skinPath}/images/fund_out.png');
				           float: left;margin-top: 5px;margin-right: 10px;margin-left: 10px;"
															onclick="editFund('${fund.fundFlow}','${proj.projFlow}');">
															<font style="float: left;position: relative;left: 35px;top: 0px">${fund.fundTypeName}</font>
															<ul>
																<li
																	style="padding-right: 15px; margin-top: 5px; position: relative; display: block;">
																	
																	<span
																	style="padding-left: 55px; line-height: 25px;"></span><span
																	style="float: right; padding-top: 5px;"><img
																		onclick="event.cancelBubble=true;
				                delFund('${fund.fundFlow}','${proj.projFlow }');"
																		src="<s:url value='/css/skin/${skinPath}/images/fund_delete.png'/>"></span></li>
																<li style="height: 10px;"></li>
																<c:if test="${fund.fundTypeId eq gcpFundTypeEnumIn.id }">
																	<li
																		style="padding-left: 10px; height: 25px; display: inline-block; position: relative;">票号：${fund.fundNo
																		}</li>
																</c:if>
																<li style="padding-left: 10px; height: 25px;">金额：${fund.fundAmount
																	}元</li>
																<li style="padding-left: 10px; height: 25px;">日期：${fund.fundDate
																	}</li>
																<li title="${fund.fundNote}" style="padding-left: 10px; height: 25px;">内容：${pdfn:cutString(fund.fundNote,5,true,3
																	)}</li>
																<c:if
																	test="${fund.fundTypeId eq gcpFundTypeEnumOut.id }">
																	<li style="padding-left: 10px; height: 25px;">用途：${fund.fundUsesName
																		}</li>
																	<c:if test="${! empty fund.fundUsesOther }">
																		<li style="padding-left: 10px; height: 25px;">其它用途：${pdfn:cutString(fund.fundUsesOther,3,true,3
																			)}</li>
																	</c:if>
																</c:if>
															</ul>
														</dt>
													</c:when>
												</c:choose>
											</c:forEach>
										</dl>
									</td>
								</tr>
							</tbody>
						</table>
					</div>
				</div>
				<div class="cont_spe"></div>
			</c:forEach>
		</div>
	</div>



</body>
</html>