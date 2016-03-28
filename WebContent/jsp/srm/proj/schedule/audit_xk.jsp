<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@include file="/jsp/common/doctype.jsp" %>
<html>
<head>
<jsp:include page="/jsp/common/htmlhead.jsp">
	<jsp:param name="basic" value="true"/>
	<jsp:param name="jbox" value="true"/>
	<jsp:param name="jquery_validation" value="true"/>
	<jsp:param name="jquery_placeholder" value="true"/>
</jsp:include>
</head>
<script type="text/javascript">
function saveAudit(agreeFlag){
	if(agreeFlag=="${GlobalConstant.FLAG_Y}"){
		$('#auditContent').removeClass("validate[required,maxSize[200]]");
	}else{
		$('#auditContent').addClass("validate[required,maxSize[200]]");
	}
	if(false==$("#auditForm").validationEngine("validate")){
		return;
	}
	var tip =  agreeFlag=="${GlobalConstant.FLAG_N}"?"退回":"审核通过";
	var url = "<s:url value='/srm/proj/schedule/saveAudit/${sessionScope.projListScope}/${sessionScope.projCateScope}'/>?agreeFlag="+agreeFlag;
	jboxConfirm("确认"+tip+"?" , function(){
		jboxStartLoading();
		jboxPost(url , $('#auditForm').serialize() , function(){
			window.location.reload();
			 } , null , true);
	});
}
</script>
<body>
   <form id="auditForm">
    <table cellpadding="0" cellspacing="0" style="width: 100%">
        <tr>
            <td style="text-align: center">
                <table cellpadding="0" cellspacing="0" style="width: 100%">
                    <tr>
                        <td colspan="2" style="width: 100%; text-align: left">
                            &#12288;&#12288;&#12288;<span style="font-weight: bold">学科审核信息：<font color="red"> 学科被退回时必须填写“审核意见”(最多200个字)</font></span>
                        </td>
                    </tr>
                    <tr>
                        <td colspan="2" style="height: 10px">
                        </td>
                    </tr>
                    <tr>
                        <td style="width: 15%; text-align: right; vertical-align: top; padding-top: 3px">
                            &#12288;审核意见：&#12288;
                        </td>
                        <td style="width: 85%; text-align: left">
                            <textarea id="auditContent" name="auditContent" class="validate[maxSize[200]] textbox"  rows="6" cols="20"  style="width:90%;" placeholder="请填写审核意见..."></textarea>
                        </td>
                    </tr>
                    <tr>
                        <td colspan="2" style="height: 10px">
                        	<input type="hidden" name="recFlow" value="${param.recFlow }"/>
                        </td>
                    </tr>
                      <tr>
                    	<td></td>
                    	<td  style="text-align:left;padding-top:5px;">
                    		 <input class='search' onclick="saveAudit('${GlobalConstant.FLAG_Y}')" type='button' value='同&#12288;意'/>&#12288;
                     		 <input class='search' onclick="saveAudit('${GlobalConstant.FLAG_N}')" type='button' value='不同意'/>&#12288;
                    	</td>
                    </tr>
                </table>
            </td>
        </tr>
    </table>
    </form>
          
<script type="text/javascript">
function showWizardInfo()
{
    var varWizardInf=$("wizardInfo");
    if(varWizardInf.style.display=="")
        varWizardInf.style.display="none";
    else
        varWizardInf.style.display="";
    return false;
}
</script>
</body>
</html>