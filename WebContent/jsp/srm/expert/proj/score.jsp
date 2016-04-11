<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="/jsp/common/doctype.jsp" %>
<html>
<head>
<jsp:include page="/jsp/common/htmlhead.jsp">
	<jsp:param name="basic" value="true"/>
	<jsp:param name="jbox" value="true"/>
	<jsp:param name="jquery_validation" value="true"/>
</jsp:include>
<script type="text/javascript">
function doBack(){
	window.location.href="<s:url value='/srm/expert/proj/list'/>";
}
function saveScore(status){
	if(false==$("#itemForm").validationEngine("validate")){
		return;
	}
	var gradeFlag = $("#gradeFlag").val();
	if("${GlobalConstant.FLAG_N}" == gradeFlag){
		jboxInfo("输入的分数不能小于0且不能超过设置的评分值！");
		return false;
	}
	var url = "<s:url value='/srm/expert/proj/saveScore?status='/>"+status;
	jboxStartLoading();
	jboxPost(url , $('#itemForm').serialize() , function(){
		window.location.reload(true);
	} , null , true);
}
function sumScore(obj){
	var grade = $(obj).val();
	var gradeVal = parseInt($(obj).parent().prev().prev().prev().text().trim());
	if(grade < 0 || grade > gradeVal){
		$("#gradeFlag").val("${GlobalConstant.FLAG_N}");
		jboxInfo("输入的分数不能小于0且不能超过设置的评分值！");
		return false;
	}else{
		$("#gradeFlag").val("${GlobalConstant.FLAG_Y}");
	}
	var scoreSum=0 ;
	$(".item").each(function(){
		if(!isNaN(parseFloat($(this).val()))){
			scoreSum += parseFloat($(this).val());
		}
	});
	$("#scoreTotal").val(parseFloat(scoreSum.toFixed(3)));
}
</script>
<body>
	<input type="hidden" id="gradeFlag" name="gradeFlag"/>
   	<div class="mainright">
		<b class="click" id="closeleft" onclick="closed('closeleft')"></b>
            <form id="itemForm">
           <div class="content" >
           <p  style=" color:#c00; line-height:25px; background:url('<s:url value='/css/skin/${skinPath}/images/tb.png'/>') no-repeat 20px -11px; padding:18px 0 6px 40px;">评分细则</p>
               <table class="xllist">
                   <thead>
                       <tr>
                           <th width="20%">评分内容</th>
                           <th width="10%">评分值</th>
                           <th width="20%">评分标准</th>
                           <th width="40%">评分要点</th>
                           <th width="10%">评分</th>
                       </tr>
                   </thead>
                   <tbody>
                   <c:forEach items="${gradeItem }" var="item">
                        <tr> 
                           <td style="vertical-align:middle;">${item.itemName }</td>
                           <td style="vertical-align:middle;">${item.itemScore}</td>
                           <td class="xlming">${item.itemScoreTip }</td>
                           <td style="vertical-align:middle;">${item.itemDesc }</td>
                           <td style="vertical-align:middle;">&#12288;&#12288;&#12288;<input class="item validate[required,custom[number]]" type="text" name="${item.itemFlow }" onblur="sumScore(this);" value="${scoreItemMap[item.itemFlow] }" style="width: 50px"/></td>
                       </tr>
                   </c:forEach>
                        <tr>
                           <td>专家意见</td>
                           <td colspan="3" class="xlming">
                           <input type="radio" name="scoreResultId" id="scoreResultIdY" value="${expertScoreResultEnumAgree.id}" class="validate[required]" <c:if test="${expertScoreResultEnumAgree.id eq expertProj.scoreResultId}">checked</c:if>/><label for="scoreResultIdY">同&#12288;意</label>
                           <input type="radio" name="scoreResultId"  id="scoreResultIdN" value="${expertScoreResultEnumNotAgree.id}" class="validate[required]" <c:if test="${expertScoreResultEnumNotAgree.id eq expertProj.scoreResultId}">checked</c:if> /><label for="scoreResultIdN">不同意</label>&#12288;
                           <textarea style="width:80%" class="validate[maxSize[100]] xltxtarea" name="expertOpinion">${expertProj.expertOpinion}</textarea></td>
                           <td style="color:red">总分：<input type="text" name="scoreTotal" id="scoreTotal" class="validate[required,custom[number]]" value="${expertProj.scoreTotal}" style="width: 50px"/>
                           	<input type="hidden" name="expertProjFlow" value="${expertProj.expertProjFlow}">
                           </td>
                       </tr>
                   </tbody>
               </table>
           </div>	
            </form>
           <div align="center">
	           <input type="button" value="返回" class="dingdan-d" onclick="doBack();"/>
	           <c:if test='${evaluationStatusEnumSave.id eq expertProj.evalStatusId || empty expertProj.evalStatusId}'>
	           <input type="button" value="保存" class="dingdan-d" onclick="saveScore('${evaluationStatusEnumSave.id}');"/>
	           <input type="button" value="提交" class="dingdan-d" onclick="saveScore('${evaluationStatusEnumSubmit.id}');"/>
	           </c:if>
           </div>
	</div>
</body>
</html>
