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
function trainSpeOperate(){
	jboxOpen("<s:url value='/jsp/jsres/hospital/doctor/trainSpeOperate.jsp'/>","变更专业",550,250);
}

function userList(){
	if ($("#applyFlag").attr("checked")=="checked") {
		$(".other").hide();
	} else {
		$(".other").show();
	}
}

function getInfo(){
	jboxOpen("<s:url value='/jsp/jsres/province/doctor/doctorMain.jsp'/>","医师信息",950,550);
}
</script>
</head>
<body>
<div class="main_bd">
      <div class="div_table">
      	<div class="div_search">
	      	医师姓名：<input type="text" class="input" style="width: 100px;"/>&#12288;
	      	 届别：
			<select class="select" style="width: 106px;">
			    <option value=""></option>
			    <option value="">2015</option>
			    <option value="">2014</option>
			    <option value="">2013</option>
			    <option value="">2012</option>
		    </select>&#12288;
	      	培训专业：
			<select class="select" style="width: 106px;">
			    <option value="">全部</option>
			    <option value="">内科</option>
			    <option value="">儿科</option>
		    </select>&#12288;
         	 <input type="checkbox" name="applyFlag" id="applyFlag" value="apply" onchange="userList();" checked/><label for="applyFlag">申请变更专业</label>
         </div>
           <table border="0" cellpadding="0" cellspacing="0" class="grid">
            <colgroup>
              <col width="15%"/>
              <col width="15%"/>
              <col width="30%"/>
              <col width="20%"/>
              <col width="20%"/>
            </colgroup>
	           <thead>
	           <tr>
	           	  <th>姓名</th>
	           	  <th>届别</th>
	           	  <th>培训专业</th>
	           	  <th>详情</th>
	              <th>操作</th>
	           </tr>
	           </thead>
	           <tbody>
	           <tr>
	           	   <td>张三</td>
	           	   <td>2013</td>
	           	   <td>神经内科</td>
	           	   <td><a class="btn" onclick="getInfo();">详情</a></td>	
	               <td>
	               	<a class="btn" onclick="trainSpeOperate();">变更</a>
	               </td>
	           </tr>
	           <tr>
	           	   <td>李四</td>
	           	   <td>2014</td>
	           	   <td>外科</td>	
	           	   <td><a class="btn" onclick="getInfo();">详情</a></td>
	               <td>
	               	<a class="btn" onclick="trainSpeOperate();">变更</a>
	               </td>
	           </tr>
	           <tr>
	           	   <td>周舟</td>
	           	   <td>2014</td>
	           	   <td>消化内科</td>	
	           	   <td><a class="btn" onclick="getInfo();">详情</a></td>
	               <td>
	               	<a class="btn" onclick="trainSpeOperate();">变更</a>
	               </td>
	           </tr>
	           <tr class="other" style="display: none;">
	           	   <td>李丽</td>
	           	   <td>2014</td>
	           	   <td>儿科</td>	
	           	   <td><a class="btn" onclick="getInfo();">详情</a></td>
	               <td>
	               	<a class="btn" onclick="trainSpeOperate();">变更</a>
	               </td>
	           </tr>
	           <tr class="other" style="display: none;">
	           	   <td>张伟</td>
	           	   <td>2014</td>
	           	   <td>神经内科</td>	
	           	   <td><a class="btn" onclick="getInfo();">详情</a></td>
	               <td>
	               	<a class="btn" onclick="trainSpeOperate();">变更</a>
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