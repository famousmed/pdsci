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
	<jsp:param name="jquery_scrollTo" value="false" />
	<jsp:param name="jquery_jcallout" value="false" />
	<jsp:param name="jquery_validation" value="true" />
	<jsp:param name="jquery_datePicker" value="true" />
	<jsp:param name="jquery_fullcalendar" value="false" />
	<jsp:param name="jquery_fngantt" value="false" />
	<jsp:param name="jquery_fixedtableheader" value="true" />
	<jsp:param name="jquery_placeholder" value="true" />
	<jsp:param name="jquery_iealert" value="false" />
	<jsp:param name="jquery_fixedtable" value="true" />
</jsp:include>

<script type="text/javascript">
	function inStatus() {
		if ($("[name='patientStageId']:checked").val() == "${patientStageEnumExclude.id}") {
			if($("[name='in']:checked").val() == "${GlobalConstant.FLAG_N}" || $("[name='ex']:checked").val() == "${GlobalConstant.FLAG_N}"){
				$(".in").hide();
			}else{
				$("[name='patientStageId'][value='${patientStageEnumIn.id}']").attr("checked","checked");
				jboxTip("纳入/排除标准必须有一项为否!");
			}
		} else {
			if($("[name='in']:checked").val() == "${GlobalConstant.FLAG_Y}" && $("[name='ex']:checked").val() == "${GlobalConstant.FLAG_Y}"){
				$(".in").show();
			}else{
				$("[name='patientStageId'][value='${patientStageEnumExclude.id}']").attr("checked","checked");
				jboxTip("纳入/排除标准必须都为是!");
			}
		}
	}
	
	function autoSel(){
		if($("[name='in']:checked").val() == "${GlobalConstant.FLAG_N}" || $("[name='ex']:checked").val() == "${GlobalConstant.FLAG_N}"){
			$("[name='patientStageId'][value='${patientStageEnumExclude.id}']").attr("checked","checked");
			$(".in").hide();
		}else{
			$("[name='patientStageId'][value='${patientStageEnumIn.id}']").attr("checked","checked");
			$(".in").show();
		}
	}

	function savePatient() {
		
		if ($("#patient").validationEngine("validate")) {
			jboxConfirm("确认添加该受试者?",function(){
				if ($("[name='patientStageId']:checked").val() == "${patientStageEnumExclude.id}") {
					$("[name='inDate']").val("");
					$("[name='icfDate']").val("");
					$("[name='inDoctorFlow']").val("");
					$("[name='inDoctorName']").val("");
				}
				var url = "<s:url value='/gcp/researcher/savePatient'/>";
				var getdata = $('#patient').serialize();
				jboxPost(url, getdata, function(data) {
					if ('${GlobalConstant.SAVE_SUCCESSED}' == data) {
						window.parent.frames['mainIframe'].window.refresh($("[name='patientStageId']:checked").val());
						jboxClose();
					}
				});
			});
		}
	}
</script>
</head>
<body>
	<div class="mainright">
		<div class="content">
			<div class="title1 clearfix">
				<div style="margin-top: 5px;">
					<form id="patient">
						<table class="xllist">
							<tbody>
								<tr>
									<th colspan="10" style="text-align: left;padding-left: 10px">受试者信息</th>
								</tr>
								<tr>
									<td style="text-align: left;padding-left: 25px">
										姓&#12288;&#12288;名：
										<input type="text" class="validate[required]" name="patientName" style="width: 100px" />
										<font color="red" style="margin-left: 5px">*</font>
										<font style="margin-left: 20px">性别：</font>
										<label>
											<input type="radio" value="${userSexEnumMan.id}" checked="checked" name="sexId" />${userSexEnumMan.name}
										</label>
										&nbsp;
										<label>
											<input type="radio" value="${userSexEnumWoman.id}" name="sexId" />${userSexEnumWoman.name}
										</label>
										<font color="red" style="margin-left: 5px">*</font>
										<font style="margin-left: 80px">年龄：</font>
										<input type="text" class="validate[required,custom[number]]" name="patientAge" style="width: 100px" />
										<font color="red" style="margin-left: 5px">*</font>
									</td>
								</tr>
								<tr>
									<td style="text-align: left;padding-left: 25px">
										联系方式：
										<input type="text" class="validate[custom[mobile]]" name="patientPhone" style="width: 100px" />
										<font style="margin-left: 35px">来源：</font>
										<label>
											<input type="radio" value="${patientSourceEnumOutPatient.id}" name="patientSourceId" />${patientSourceEnumOutPatient.name}
										</label>
										&nbsp;
										<label>
											<input type="radio" value="${patientSourceEnumInPatient.id}" name="patientSourceId" />${patientSourceEnumInPatient.name}
										</label>
										<font style="margin-left: 25px">门诊/住院号：</font>
										<input type="text" name="patientNo" style="width: 100px" />
									</td>
								</tr>
								<tr>
									<th colspan="10" style="text-align: left;padding-left: 10px">纳入/排除</th>
								</tr>
								<tr>
									<td style="text-align: left;padding-left: 25px">
										符合纳入标准&#12288;&#12288;
										<label><input type="radio" onclick="autoSel();" name="in" checked="checked" value="${GlobalConstant.FLAG_Y}">是</label>&nbsp;
										<label><input type="radio" onclick="autoSel();" name="in" value="${GlobalConstant.FLAG_N}">否</label>
										<!-- <span style="float: right; color: blue">>>详情&#12288;&#12288;</span> -->
									</td>
								</tr>
								<tr>
									<td style="text-align: left;padding-left: 25px">
										不符合排除标准&#12288;
										<label><input type="radio" name="ex" onclick="autoSel();"  checked="checked" value="${GlobalConstant.FLAG_Y}">是</label>&nbsp;
										<label><input type="radio" name="ex" onclick="autoSel();" value="${GlobalConstant.FLAG_N}">否</label>
										<!-- <span style="float: right; color: blue">>>详情&#12288;&#12288;</span> -->
									</td>
								</tr>
								<tr>
									<th colspan="10" style="text-align: left;padding-left: 10px">筛选信息</th>
								</tr>

								<tr>
									<td style="text-align: left;padding-left: 25px">
										<label>
											<input onclick="inStatus();" type="radio" name="patientStageId" checked="checked" value="${patientStageEnumIn.id}" />${patientStageEnumIn.name}
										</label>
										&nbsp;
										<label>
											<input onclick="inStatus();" type="radio" name="patientStageId" value="${patientStageEnumExclude.id}" />${patientStageEnumExclude.name}
										</label>
									</td>
								</tr>
								<tr class="in">
									<td style="text-align: left;padding-left: 25px">
										知情同意日期：
										<input type="text" style="margin-right: 0px" readonly="readonly" onclick="WdatePicker({dateFmt:'yyyy-MM-dd'})" name="icfDate" class="ctime validate[required]">
										<font color="red">*</font>
									</td>
								</tr>
								<tr class="in">
									<td style="text-align: left;padding-left: 25px">
										<font style="margin-left: 25px">入组日期：</font>
										<input style="margin-right: 0px" type="text" name="inDate" readonly="readonly" onclick="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss'})" class="ctime validate[required]" value="${pdfn:getCurrDateTime('yyyy-MM-dd HH:mm:ss')}">
										<font color="red">*</font>
										<span style="margin-left: 100px">
											入组医师：
											<input type="hidden" name="inDoctorFlow" value="${sessionScope.currUser.userFlow}" />
											<input type="hidden" name="inDoctorName" value="${sessionScope.currUser.userName}" />
											${sessionScope.currUser.userName}
										</span>
									</td>
								</tr>
							</tbody>
						</table>
					</form>
				</div>
				<div style="text-align: center; margin-top: 10px;">
					<input type="button" class="search" value="保&#12288;存" onclick="savePatient();" />
					<input type="button" class="search" value="关&#12288;闭" onclick="jboxClose();" />
				</div>
			</div>
		</div>
	</div>
</body>
</html>