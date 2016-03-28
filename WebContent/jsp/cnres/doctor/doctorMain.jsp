<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<jsp:include page="/jsp/cnres/htmlhead-cnres.jsp">
	<jsp:param name="basic" value="true"/>
	<jsp:param name="jbox" value="true"/>
	<jsp:param name="font" value="true"/>
</jsp:include>

<script type="text/javascript">
	function goScoreInfo(){
		location.href="<s:url value='/cnres/singup/doctor/scoreSearch'/>";
	}
	
	function goRotationTrain(){
		location.href="<s:url value='/cnres/doc/searchRotationList'/>";
	}
	
	function printExamTicket(){
		var url = "<s:url value='/cnres/singup/doctor/printexamticket'/>";
		jboxGet(url , null , function(resp){
			if(resp.allowPrint){
				window.location.href="<s:url value='/cnres/singup/doctor/showexamcard'/>";
			}else{
				jboxTip("当前准考证打印"+resp.msg);
			}
		} , null , false);
	}
	
</script>
</head>

<body>
  <div class="main_wrap">
  <c:if test="${empty scoreSearchMsg}">
    <div class="enter">
      <h1>准考证</h1>
      <div class="enter_bd">
         <img src="<s:url value='/jsp/cnres/images/basic/ticket.png'/>" />
         <button class="btn_blue mark" style=" width:130px;" onclick="printExamTicket();">打印准考证</button>
         <span class="enter_tip">打印准考证日期：${recruitCfg.printBeginDate }~${recruitCfg.printEndDate }</span>
      </div>
    </div>
    </c:if>
    <c:if test="${not empty scoreSearchMsg}">
    <div class="enter">
      <h1>成绩查询</h1>
      <div class="enter_bd">
         <img src="<s:url value='/jsp/cnres/images/basic/mark.png'/>" />
         <!-- <button class="btn_blue search" style=" width:130px;" onclick="goScoreInfo();">成绩查询</button> -->  
         <span class="enter_tip2">${scoreSearchMsg}</span>
      </div>
    </div>
    </c:if> 
    <div class="enter" style="display: none;">
      <h1>轮转培训</h1>
      <div class="enter_bd">
         <img src="<s:url value='/jsp/cnres/images/basic/mark.png'/>" />
    	 <button class="btn_blue" style=" width:130px;" onclick="goRotationTrain();">轮转培训</button>
         <span class="enter_tip"></span>
      </div>
    </div>  
     
  </div>
  
</body>
</html>
