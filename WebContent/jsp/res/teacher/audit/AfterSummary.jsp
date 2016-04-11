 <%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/jsp/common/doctype.jsp"%>
<html>
<head>
<jsp:include page="/jsp/common/htmlhead.jsp">
	<jsp:param name="basic" value="true" />
	<jsp:param name="jbox" value="true" />
	<jsp:param name="jquery_validation" value="true"/>
	<jsp:param name="jquery_datePicker" value="true"/>
</jsp:include>
<style type="text/css">
.ith{height: 40px;line-height: 40px;padding-left: 10px;}
</style>
<script type="text/javascript">
	function saveAudit(auditResult){
		var $form = $("#auditForm");
		if($form.validationEngine("validate")){
			var url = "<s:url value='/res/teacher/audit'/>?auditResult="+auditResult;
			var requestData = $form.serialize();
			jboxPost(url,requestData,function(resp){
				if(resp=="${GlobalConstant.OPRE_SUCCESSED}"){
					window.parent.frames["mainIframe"].window.location.reload(true);
				}
			},null,true);
		}
	}
</script>
</head>
<body>
<div class="mainright">
	<div class="content" style="padding:0 10px 10px 0;">
<div class="ui-container">
  <div class="i-content" style="width:100%">
  <form id="auditForm">
    <div class="i-trend">
      <table class="i-trend-table" border="0" cellpadding="0" cellspacing="0" style="width:100%;">
      <tbody>
        <tr>
          <td class="ith_t" style="padding-left:10px;">
            <div class="i-trend-header" style="font-weight: bold;">
              轮转科室：${rec.schDeptName }
            </div>
          </td>
        </tr>
          <tr>
	<th class="ith">
	<span>个人小结</span>
	</th>
  </tr>
  <tr>
    <td>
    <fieldset style="border:none;margin:0 5px;">
    ${form.personalSummary }
    </fieldset>
    </td>
  </tr>
  <tr>
	<th class="ith" style="border-top:1px solid #e1e1e1;">
	<span>带教老师评价</span>
	</th>
  </tr>
  <tr>
    <td>
    <c:choose>
    	<c:when test="${param.roleFlag==GlobalConstant.RES_ROLE_SCOPE_TEACHER }">
    	<textarea name="deptAppraise" class="validate[required]" style="width:98%;height: 120px;border: none;padding:0 1%;" placeholder="请填写评价" ></textarea>
    	</c:when>
    	<c:otherwise>
    	<fieldset style="border:none;margin:0 5px;">
    	${form.deptAppraise}
    	</fieldset>
    	</c:otherwise>
    </c:choose>
    </td>
  </tr>
  <c:if test="${param.roleFlag==GlobalConstant.RES_ROLE_SCOPE_HEAD }">
  <tr>
	<th class="ith" style="border-top:1px solid #e1e1e1;">
	<span>科主任评价<label><input type="checkbox" name="isAgaree" value="${GlobalConstant.FLAG_Y}" />同意出科</label>
						         		<font color="red">(如同意出科请选中)</font></span>
	</th>
  </tr>
  <tr>
    <td>
	   	<textarea name="deptHeadAutograth" class="validate[required]" style="width:98%;height: 120px;border: none;padding:0 1%;" placeholder="请填写评价" ></textarea>
    </td>
  </tr>
  </c:if>
</table>
	<input type="hidden" name="roleFlag" value="${param.roleFlag }">
	<input type="hidden" name="recTypeId" value="${param.recTypeId }">
	<input type="hidden" name="recFlow" value="${param.recFlow }">
	<input type="hidden" name="processFlow" value="${param.processFlow }">
<div style="text-align:center;margin-top: 20px;"><input type="button" value="审核通过"  class="search" onclick="saveAudit('${recStatusEnumTeacherAuditY.id}');"/>&#12288;<input type="button" value="审核不通过"  class="search" onclick="saveAudit('${recStatusEnumTeacherAuditN.id}');"/></div>
  </div>
  </form>
 </div>
  </div>
  </div>
</div>


</body>
</html>