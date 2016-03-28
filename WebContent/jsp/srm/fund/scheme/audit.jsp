<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="/jsp/common/doctype.jsp" %>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<jsp:include page="/jsp/common/htmlhead.jsp">
	<jsp:param name="basic" value="true"/>
	<jsp:param name="jbox" value="true"/>
	<jsp:param name="jquery_form" value="false"/>
	<jsp:param name="jquery_ui_tooltip" value="true"/>
	<jsp:param name="jquery_ui_combobox" value="false"/>
	<jsp:param name="jquery_ui_sortable" value="false"/>
	<jsp:param name="jquery_cxselect" value="false"/>
	<jsp:param name="jquery_scrollTo" value="false"/>
	<jsp:param name="jquery_jcallout" value="false"/>
	<jsp:param name="jquery_validation" value="true"/>
	<jsp:param name="jquery_datePicker" value="true"/>
	<jsp:param name="jquery_fullcalendar" value="false"/>
	<jsp:param name="jquery_fngantt" value="false"/>
	<jsp:param name="jquery_fixedtableheader" value="true"/>
	<jsp:param name="jquery_placeholder" value="true"/>
	<jsp:param name="jquery_iealert" value="false"/>
</jsp:include>
<script type="text/javascript">
function saveAudit(agreeFlag,fundFlow){
	var tip =  agreeFlag=="${GlobalConstant.FLAG_Y}"?"审核通过":"退回";
	var url = "<s:url value='/srm/fund/scheme/saveAudit'/>?agreeFlag="+agreeFlag+"&fundFlow="+fundFlow;
	jboxConfirm("确认"+tip+"?" ,  function(){
		jboxStartLoading();
		jboxPost(url , $('#auditForm').serialize() , function(resp){
			$("#budgetList",window.parent.frames['mainIframe'].document).submit(); 
			jboxClose();} , null , true);
		
	});
}
function doClose() {
	jboxClose();
}

</script>
</head>
<body>
<div class="mainright" id="mainright">
   <div class="content">
   <br>
   <p style="font-weight: bold;color:red;">预算总经费(万元)：${fundInfo.budgetAmount}</p>
    <br>
 <table class="xllist">
  <tr>
       <th style="width: 30px;">预算项</th>
       <th style="width: 25px;">预算金额(万元)</th>
       <th style="width: 30px;">最高比例(单位：%)</th>
       <th>预算内容</th>
    </tr>
<c:forEach var="fundDtl" items="${fundDtlList }">
    <tr>
       <td>${schemeMap[fundDtl.itemFlow].itemName }</td> 
       <td>${fundDtl.money }</td>     
       <td>${schemeMap[fundDtl.itemFlow].maxLimit }</td>
       <td>${fundDtl.content }</td>     
    </tr>
</c:forEach>
    
</table>

<h2 style="margin-top: 15px;">审核意见：</h2>
<hr/>

<form action="<s:url value="/srm/fund/scheme/applyList"/>" method="post" id="auditForm">
<div>
	<textarea id="content" name="content" cols="25" rows="3" style="margin-top: 10px; width:100%; height:150px; border:1px solid #D0E3F2" ></textarea>
	<p style="text-align:center;">
	 <input class='search' onclick="saveAudit('${GlobalConstant.FLAG_N}','${fundFlow }')" type='button' value='退&#12288回'/>&#12288;
     <input class='search' onclick="saveAudit('${GlobalConstant.FLAG_Y}','${fundFlow }')" type='button'  value='同&#12288意' />&#12288; 
     <input class='search' onclick="jboxClose()" type='button'  value='关&#12288闭' />    
	</p>
</div>
</form>
</div>
</div>
</body>
</html>