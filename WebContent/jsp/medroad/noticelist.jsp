<script>
function toPage(page) {
	if(page!=undefined){
		$("#currentPage").val(page);			
	}
	var currentPage = $("#currentPage").val();		
	jboxLoad("content","<s:url value='/medroad/noticelist'/>?currentPage="+currentPage,false);
} 
$(document).ready(function(){
	jboxEndLoading();
});
</script>
</head>
<body>
<div class="content_main">
 <div class="index_form" style="margin-bottom: 10px;">
          <h3>通知公告</h3>
          	<ul class="form_main">
          <c:forEach items="${infos}" var="msg">
            <li>
            <strong><a href="<s:url value='/medroad/noticeview'/>?infoFlow=${msg.infoFlow}" target="_blank">${msg.infoTitle}</a><i class="new"></i></strong>
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
	  	     <pd:pagination-hbres toPage="toPage"/>	 
           </span>
        </div> 
</div>
</body>
</html>
