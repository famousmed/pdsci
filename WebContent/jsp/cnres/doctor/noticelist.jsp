<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>国家住院医师规范化培训示范性基地招录系统</title>
<jsp:include page="/jsp/cnres/htmlhead-cnres.jsp">
	<jsp:param name="basic" value="true"/>
	<jsp:param name="jbox" value="true"/>
	<jsp:param name="font" value="true"/>
</jsp:include>
<script>
function toPage(page) {
	if(page!=undefined){
		$("#currentPage").val(page);			
	}
	var currentPage = $("#currentPage").val();		
	location.href="<s:url value='/cnres/singup/doctor/noticelist'/>?currentPage="+currentPage;
} 
</script>
</head>

<body>
  <div class="main_wrap" > 
    <div class="news_contain">
       <div class="index_form">
          <h3>系统公告</h3>
          <ul class="form_main">
          <c:forEach items="${infos}" var="msg">
            <li>
            <strong><a href="<s:url value='/cnres/notice/view'/>?infoFlow=${msg.infoFlow}" target="_blank">${msg.infoTitle}</a><i class="new"></i></strong>
            <span>${pdfn:transDate(msg.createTime)}</span>
            </li>
          </c:forEach>
          <c:if test="${empty infos}">
		     <li>
			    <strong>无记录!</strong>
			 </li>
		 </c:if>
          </ul>
        </div>
       <div class="page">
           <span>
             <input id="currentPage" type="hidden" name="currentPage" value="${param.currentPage}"/>
             <c:set var="pageView" value="${pdfn:getPageView(infos)}" scope="request"></c:set>
	  	     <pd:pagination-cnres toPage="toPage"/>	 
           </span>
        </div> 
    </div>
  </div>

</body>
</html>
