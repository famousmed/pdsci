<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<c:if test="${param.view!=GlobalConstant.FLAG_Y }">
<script type="text/javascript">
function nextOpt(step){
	if(false==$("#projForm").validationEngine("validate")){
		return false;
	}
	var form = $('#projForm');
	form.append('<input type="hidden" name="nextPageName" value="'+step+'"/>');
	$('#nxt').attr({"disabled":"disabled"});
	$('#prev').attr({"disabled":"disabled"});
	jboxStartLoading();
	form.submit();
}
</script>
</c:if>
<style type="text/css">
.inputText{width: 70%;}
</style>
    <form action="<s:url value='/srm/proj/mine/saveStep'/>" method="post" id="projForm" style="position: relative;">
        <input type="hidden" id="pageName" name="pageName" value="step6"/>
		<input type="hidden" id="recFlow" name="recFlow" value="${projRec.recFlow}"/>
		<input type="hidden" id="projFlow" name="projFlow" value="${proj.projFlow}"/>
		<input type="hidden" id="recTypeId" name="recTypeId" value="${param.recTypeId}"/>
		<table width="100%" cellspacing="0" cellpadding="0" class="bs_tb">
		    <tbody>
			    <tr>
				    <th colspan="7" class="theader">五、获奖情况</th>
				</tr>
				<tr style="font-weight: bold;">
				    <td>单位/个</td>
					<td>特等奖</td>
					<td>一等奖</td>
					<td>二等奖</td>
					<td>三等奖</td>
				</tr>
				<tr>
				    <td>国家自然科学奖</td>
					<td><input class="inputText"  type="text" name="gjzrkxjTe" value="${resultMap.gjzrkxjTe}"/></td>
					<td><input class="inputText"  type="text" name="gjzrkxjYi" value="${resultMap.gjzrkxjYi}"/></td>
					<td><input class="inputText"  type="text" name="gjzrkxjEr" value="${resultMap.gjzrkxjEr}"/></td>
					<td><input class="inputText"  type="text" name="gjzrkxjSan" value="${resultMap.gjzrkxjSan}"/></td>
				</tr>
				<tr>
				    <td>国家发明奖</td>
					<td><input class="inputText"  type="text" name="gjfmjTe" value="${resultMap.gjfmjTe}"/></td>
					<td><input class="inputText"  type="text" name="gjfmjYi" value="${resultMap.gjfmjYi}"/></td>
					<td><input class="inputText"  type="text" name="gjfmjEr" value="${resultMap.gjfmjEr}"/></td>
					<td><input class="inputText"  type="text" name="gjfmjSan" value="${resultMap.gjfmjSan}"/></td>
				</tr>
				<tr>
				    <td>国家科技进步奖</td>
					<td><input class="inputText"  type="text" name="gjkjjbjTe" value="${resultMap.gjkjjbjTe}"/></td>
					<td><input class="inputText"  type="text" name="gjkjjbjYi" value="${resultMap.gjkjjbjYi}"/></td>
					<td><input class="inputText"  type="text" name="gjkjjbjEr" value="${resultMap.gjkjjbjEr}"/></td>
					<td><input class="inputText"  type="text" name="gjkjjbjSan" value="${resultMap.gjkjjbjSan}"/></td>
				</tr>
				<tr>
				    <td>国家部门科技进步奖</td>
					<td><input class="inputText"  type="text" name="gjbmkjjbjTe" value="${resultMap.gjbmkjjbjTe}"/></td>
					<td><input class="inputText"  type="text" name="gjbmkjjbjYi" value="${resultMap.gjbmkjjbjYi}"/></td>
					<td><input class="inputText"  type="text" name="gjbmkjjbjEr" value="${resultMap.gjbmkjjbjEr}"/></td>
					<td><input class="inputText"  type="text" name="gjbmkjjbjSan" value="${resultMap.gjbmkjjbjSan}"/></td>
				</tr>
				<tr>
				    <td>省科技进步奖</td>
					<td><input class="inputText"  type="text" name="skjjbjTe" value="${resultMap.skjjbjTe}"/></td>
					<td><input class="inputText"  type="text" name="skjjbjYi" value="${resultMap.skjjbjYi}"/></td>
					<td><input class="inputText"  type="text" name="skjjbjEr" value="${resultMap.skjjbjEr}"/></td>
					<td><input class="inputText"  type="text" name="skjjbjSan" value="${resultMap.skjjbjSan}"/></td>
				</tr>
			</tbody>
		</table>
	</form>
	<c:if test="${param.view!=GlobalConstant.FLAG_Y }">
	<div class="button" style="width: 100%;">
	    <input onclick="nextOpt('step5')" id="prev" class="search" type="button" value="上一步"/>
	    <input onclick="nextOpt('file')" id="nxt" class="search" type="button" value="下一步"/>
	</div>
	</c:if>
	
