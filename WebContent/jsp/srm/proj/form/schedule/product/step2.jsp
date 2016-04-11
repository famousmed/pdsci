<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<c:if test="${param.view != GlobalConstant.FLAG_Y}">
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
    <form action="<s:url value='/srm/proj/mine/saveStep'/>" method="post" id="projForm" style="position: relative;">
	    <input type="hidden" name="pageName" value="step2"/>
		<input type="hidden" id="recFlow" name="recFlow" value="${projRec.recFlow}"/>
		<input type="hidden" id="projFlow" name="projFlow" value="${proj.projFlow}"/>
		<input type="hidden" name="recTypeId" value="${param.recTypeId}"/>
		<table width="100%" cellspacing="0" cellpadding="0" class="bs_tb" style="margin-top: 10px;">
		    <tbody>
			    <tr>
				    <th colspan="5" class="theader">二、人员情况</th>
				</tr>
				<tr>
				    <td rowspan="2">项目总人数:</td>
				    <td colspan="2" align="center" class="xlming">其中</td>
				    <td colspan="2" align="center" class="xlming">其中</td>
				</tr>
				<tr>
				    <td>高级职称</td>
				    <td>中级职称</td>
				    <td>博士</td>
				    <td>硕士</td>
				</tr>
				<tr>
				    <td><input type="text" class="inputText" name="memberCount" value="${resultMap.memberCount} "/></td>
				    <td><input type="text" class="inputText" name="highZc" value="${resultMap.highZc} "/></td>
				    <td><input type="text" class="inputText"name="middleZc" value="${resultMap.middleZc} "/></td>
				    <td><input type="text" class="inputText" name="boShi" value="${resultMap.boShi} "/></td>
				    <td><input type="text" class="inputText" name="shuoShi" value="${resultMap.shuoShi} "/></td>
				</tr>
            </tbody>
		</table>
		<div style="margin-top: 15px;padding-left: 15px;">
		     项目负责人全年为项目工作时间：<input type="text" class="inputText" style="width:100px;" name="timeCount" value="${resultMap.timeCount}">&#12288;月
		</div>
    </form>
	<div class="button" style="width: 100%;
	<c:if test="${param.view == GlobalConstant.FLAG_Y}">display:none</c:if>">
	    <input onclick="nextOpt('step1')" id="prev" class="search" type="button" value="上一步"/>
	    <input onclick="nextOpt('step3')" id="nxt" class="search" type="button" value="下一步"/>
	</div>

