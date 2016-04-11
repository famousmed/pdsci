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
	<input type="hidden" name="pageName" value="step4"/>
	<input type="hidden" id="recFlow" name="recFlow" value="${projRec.recFlow}"/>
    <input type="hidden" id="projFlow" name="projFlow" value="${proj.projFlow}"/>
	<input type="hidden" id="recTypeId" name="recTypeId" value="${param.recTypeId}"/>
    <table width="100%" cellspacing="0" cellpadding="0" class="bs_tb" style="margin-top: 10px;">
        <tr>
		    <th colspan="4" class="theader">四、取得成果</th>
		</tr>
        <tr>
            <td>国家级奖项</td>
            <td><input type="text" class="inputText" name="countryPrize" value="${resultMap.countryPrize }"/></td>
            <td>省部级奖项</td>
            <td><input type="text" class="inputText" name="provincePrize" value="${resultMap.provincePrize }"/></td>
        </tr>
        <tr>
            <td>专利申请</td>
            <td><input type="text" class="inputText" name="patentApply" value="${resultMap.patentApply }"/></td>
            <td>专利授权</td>
            <td><input type="text" class="inputText" name="patentAuthorize" value="${resultMap.patentAuthorize }"/></td>
        </tr>
        <tr>
            <td>核心期刊</td>
            <td><input type="text" class="inputText" name="thesisCoreJour" value="${resultMap.thesisCoreJour }"/></td>
            <td>其中EI/SCI</td>
            <td><input type="text" class="inputText" name="eiSci" value="${resultMap.eiSci }"/></td>
        </tr>
        <tr>
            <td>技术标准</td>
            <td><input type="text" class="inputText" name="jiShu" value="${resultMap.jiShu }"/></td>
            <td>出版专著</td>
            <td><input type="text" class="inputText" name="book" value="${resultMap.book }"/></td>
        </tr>
    </table>
</form>
<div class="button" style="width: 100%;
    <c:if test="${param.view == GlobalConstant.FLAG_Y}">display:none</c:if>">
        <input onclick="nextOpt('step3')" id="prev" class="search" type="button" value="上一步"/>
        <input onclick="nextOpt('step5')" id="nxt" class="search" type="button" value="下一步"/>
</div> 
