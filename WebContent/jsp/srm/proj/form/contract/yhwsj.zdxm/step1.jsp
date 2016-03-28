<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<c:if test="${param.view!=GlobalConstant.FLAG_Y}">
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
</c:if>
<style type="text/css">
	.borderNone{border-bottom-style: none;}
</style>
	<form action="<s:url value='/srm/proj/mine/saveStep'/>" method="post" style="position: relative;"
		id="projForm">
		<input type="hidden" id="pageName" name="pageName" value="step1" /> 
		<input type="hidden" id="recFlow" name="recFlow" value="${projRec.recFlow}"/>
		<input type="hidden" id="projFlow" name="projFlow" value="${proj.projFlow}"/>
		<input type="hidden" id="recTypeId" name="recTypeId" value="${param.recTypeId}"/>
		
		<font style="font-size: 14px; font-weight:bold;color: #333;">一、项目基本情况</font>
		<table class="bs_tb" style="width: 100%; margin-top: 10px;" >
			<tr>
				<td width="13%" style="text-align: right;">项目名称：</td>
				<td colspan="7" style="text-align: left;">&#12288;<input type="text" name="projName" value="${empty resultMap.projName?proj.projName:resultMap.projName}" class="inputText borderNone" style="width: 80%; text-align: left;" readonly="readonly"/></td>
			</tr>
			<tr>
				<td style="text-align: right;">技术来源：</td>
				<td colspan="7" style="text-align: left;padding-left: 1%;">
					<c:if test="${empty applyMap.technologySource}">
						<select name="technologySource" class="inputText" style="width: 40%">
							<option value="">请选择</option>
							<c:forEach items="${dictTypeEnumYhTechnologySourceList }" var="dict">
							<option value="${dict.dictName}" <c:if test="${resultMap.technologySource eq dict.dictName}">selected="selected"</c:if>>${dict.dictName}</option>
							</c:forEach>
						</select>
					</c:if>
					<c:if test="${not empty applyMap.technologySource}">
						<select name="technologySource" class="inputText" style="width: 40%">
							<option value="">请选择</option>
							<c:forEach items="${dictTypeEnumYhTechnologySourceList }" var="dict">
							<option value="${dict.dictName}" <c:if test="${applyMap.technologySource eq dict.dictName}">selected="selected"</c:if>>${dict.dictName}</option>
							</c:forEach>
						</select>
					</c:if>
				</td>
			</tr>
			<tr>
				<td style="text-align: right;">项目资助方式：</td>
				<td colspan="7" style="text-align: left;">
					&#12288;<input type="text" name="projAidingWay" value="定额补助" class="inputText" style="width: 80%; text-align: left;border-bottom-style: none;" readonly="readonly"/>
				</td>
			</tr>
			<tr>
				<td style="text-align: right;">区科技局主管科室：</td>
				<td colspan="7" style="text-align: left;">
					&#12288;<input type="text" name="chargeDeptName" value="农村与社会发展科" class="inputText" style="width: 80%; text-align: left;border-bottom-style: none;" readonly="readonly"/>
				</td>
			</tr>
			<tr>
				<td rowspan="2" style="text-align: right;">经济效益目标：</td>
				<td width="22%" colspan="2">年销售收入（万元）</td>
				<td width="22%" colspan="2">年增净利润（万元）</td>
				<td width="22%" colspan="2">年增税金（万元）</td>
				<td width="22%" colspan="2">年创汇（万美元）</td>
			</tr>
			<tr>
				<td colspan="2"><input type="text" name="nxssr" value="${resultMap.nxssr}" class="validate[custom[number]] inputText" style="width: 80%"/></td>
				<td colspan="2"><input type="text" name="nzjlr" value="${resultMap.nzjlr}" class="validate[custom[number]] inputText" style="width: 80%"/></td>
				<td colspan="2"><input type="text" name="nzsj" value="${resultMap.nzsj}" class="validate[custom[number]] inputText" style="width: 80%"/></td>
				<td colspan="2"><input type="text" name="nch" value="${resultMap.nch}" class="validate[custom[number]] inputText" style="width: 80%"/></td>
			</tr>
			<tr>
				<td rowspan="4" style="text-align: right;">成果产出指标：</td>
				<td colspan="6">专利（件）</td>
				<td rowspan="3">其他知识产权成果</td>
			</tr>
			<tr>
				<td colspan="2">发明专利</td>
				<td colspan="2">实用新型</td>
				<td colspan="2">外观设计</td>
			</tr>
			<tr>
				<td>申请</td>
				<td>授权</td>
				<td>申请</td>
				<td>授权</td>
				<td>申请</td>
				<td>授权</td>
			</tr>
			<tr>
				<td><input type="text" name="fmzlApply" value="${resultMap.fmzlApply}" class="inputText" style="width: 80%"/></td>
				<td><input type="text" name="fmzlAuthorise" value="${resultMap.fmzlAuthorise}" class="inputText" style="width: 80%"/></td>
				<td><input type="text" name="syxxApply" value="${resultMap.syxxApply}" class="inputText" style="width: 80%"/></td>
				<td><input type="text" name="syxxAuthorise" value="${resultMap.syxxAuthorise}" class="inputText" style="width: 80%"/></td>
				<td><input type="text" name="wgsjApply" value="${resultMap.wgsjApply}" class="inputText" style="width: 80%"/></td>
				<td><input type="text" name="wgsjAuthorise" value="${resultMap.wgsjAuthorise}" class="inputText" style="width: 80%"/></td>
				<td><input type="text" name="qtzscqcg" value="${resultMap.qtzscqcg}" class="inputText" style="width: 80%"/></td>
			</tr>
		</table>
	</form>
	
    <c:if test="${param.view!=GlobalConstant.FLAG_Y}">
		<div align="center" style="margin-top: 10px">
		    <input id="nxt" type="button" onclick="nextOpt('step2')" class="search" value="下一步"/>
       	</div>
    </c:if>

		