<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>通知公告</title>
<jsp:include page="/jsp/common/htmlhead.jsp">
	<jsp:param name="basic" value="true" />
	<jsp:param name="jbox" value="true" />
	<jsp:param name="jquery_form" value="false" />
	<jsp:param name="jquery_ui_tooltip" value="true" />
	<jsp:param name="jquery_ui_combobox" value="false" />
	<jsp:param name="jquery_ui_sortable" value="false" />
	<jsp:param name="jquery_cxselect" value="true" />
	<jsp:param name="jquery_scrollTo" value="false" />
	<jsp:param name="jquery_jcallout" value="false" />
	<jsp:param name="jquery_validation" value="true" />
	<jsp:param name="jquery_datePicker" value="true" />
	<jsp:param name="jquery_fullcalendar" value="false" />
	<jsp:param name="jquery_fngantt" value="false" />
	<jsp:param name="jquery_fixedtableheader" value="true" />
	<jsp:param name="jquery_placeholder" value="true" />
	<jsp:param name="jquery_iealert" value="false" />
	<jsp:param name="ueditor" value="true"/>
</jsp:include>
<script>
//固定每页条数为10
$(function(){
	$("[name='pageSize']").val("10");
	$("[name='pageSize']").attr("disabled",true);
});

function toPage(page) {
	if(page!=undefined){
		$("#currentPage").val(page);			
	}
	var currentPage = $("#currentPage").val();		
	location.href="<s:url value='/inx/njmures/noticelist'/>?currentPage="+currentPage;
} 
</script>
</head>

<body>
<div class="header">
    <div class="top">
     <p class="tleft"><img src="<s:url value='/css/skin/${skinPath}/images/${applicationScope.sysCfgMap["sys_login_img"]}_head.png'/>" /></p>
    </div>
  </div>
  
<div class="mainright">
	<div class="content">
	<div class="title1 clearfix">
       		<table class="basic" width="1116px" style="margin:auto;margin-top: 10px;">
          		<tr>
          			<th style="padding-left:10px;text-align: left;">
	          			<div style="float: left;${param.fromSch?'margin-top: 5px;':''}">科教通知</div>
	          			<c:if test="${param.fromSch}">
		          			<input type="button" value="返&#12288;回" class="search" onclick="goBack();" style="float: right;"/>
	          			</c:if>
	          		</th>
          		</tr>
          		<c:forEach items="${infos}" var="info">
          			<tr>
          				<td>
          					<a href="<s:url value='/inx/njmures/noticeView'/>?infoFlow=${info.infoFlow}" target="_blank">${info.infoTitle}</a> 
          					<c:if test="${pdfn:signDaysBetweenTowDate(pdfn:getCurrDate(),pdfn:transDate(info.infoTime))<=7}">
	          					<img src="<s:url value='/jsp/hbres/images/new.png'/>"/>
          					</c:if>
          					<span style="float: right;margin-right: 10px;">${pdfn:transDate(info.infoTime)}</span>
          				</td>
          			</tr>
          		</c:forEach>
          	</table>
	       <div>
	           <span>
	             <input id="currentPage" type="hidden" name="currentPage" value="${param.currentPage}"/>
	             <c:set var="pageView" value="${pdfn:getPageView(infos)}" scope="request"></c:set>
		  	     <pd:pagination toPage="toPage"/>	 
	           </span>
	        </div> 
	        </div>
        </div>
    </div>
    
    <div class="footer">
  技术支持：南京品德网络信息技术有限公司
  </div>
</body>
</html>
