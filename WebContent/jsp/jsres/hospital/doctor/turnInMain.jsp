<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>江苏省住院医师规范化培训管理平台</title>
<jsp:include page="/jsp/jsres/htmlhead-jsres.jsp">
	<jsp:param name="basic" value="true"/>
	<jsp:param name="jbox" value="true"/>
	<jsp:param name="font" value="true"/>
</jsp:include>
<script type="text/javascript">
function turnInAudit(){
	jboxOpen("<s:url value='/jsp/jsres/hospital/doctor/turnInAudit.jsp'/>","转入审核",650,280);
}
</script>
</head>
<body>
	<div class="main_bd">
      <div class="div_table">
           <table border="0" cellpadding="0" cellspacing="0" class="grid">
            <colgroup>
              <col width="12%"/>
              <col width="12%"/>
              <col width="22%"/>
              <col width="22%"/>
              <col width="12%"/>
              <col width="17%"/>
            </colgroup>
	           <thead>
	           <tr>
	           	  <th>姓名</th>
	           	  <th>届别</th>
	              <th>原培训基地</th>
	           	  <th>培训专业</th>
	              <th>详情</th>
	              <th>操作</th>
	           </tr>
	           </thead>
	           <tbody>
	           <tr>
	           	   <td>艾静惠</td>
	           	   <td>2013</td>
	               <td>苏州市广济医院</td>
	           	   <td>神经内科</td>	
	               <td><a class="btn" onclick="getInfo();">详情</a></td>
	               <td>
	               	<a class="btn" onclick="turnInAudit();">审核</a>
	               </td>
	           </tr>
	           <tr>
	           	   <td>汪洋</td>
	           	   <td>2014</td>
	               <td>江苏省中医院</td>
	           	   <td>外科</td>	
	               <td><a class="btn" onclick="getInfo();">详情</a></td>
	               <td>
	               	<a class="btn" onclick="turnInAudit();">审核</a>
	               </td>
	           </tr>
	           <tr>
	           	   <td>李丽</td>
	           	   <td>2014</td>
	               <td>苏州市人民医院</td>
	           	   <td>消化内科</td>	
	               <td><a class="btn" onclick="getInfo();">详情</a></td>
	               <td>
	               	<a class="btn" onclick="turnInAudit();">审核</a>
	               </td>
	           </tr>
	           </tbody>
           </table>
          </div>
          <div class="page" style="padding-right: 40px;">
       	 <input id="currentPage" type="hidden" name="currentPage" value="${param.currentPage}"/>
           <c:set var="pageView" value="${pdfn:getPageView(hospitalList)}" scope="request"></c:set>
	  		 <pd:pagination-hbres toPage="toPage"/>	 
        </div>
</div>
</body>
</html>