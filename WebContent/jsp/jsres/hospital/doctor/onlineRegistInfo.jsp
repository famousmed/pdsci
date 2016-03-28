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
</script>
</head>
<body>
	<div style="overflow-y: auto;height: 505px;">
	<div class="div_table">
		<table border="0" cellpadding="0" cellspacing="0" class="base_info">
			<tr>
	           <th style="text-align: left;padding-left: 10px;">文件名</th>
	        </tr>
	       <tbody>
	           <tr>
	               <td><a>1、报名表</a></td>
	           </tr>
	           <tr>
	               <td>2、报名人员信息</td>
	           </tr>
	           <tr>
	               <td>3、公共科目成绩：合格（成绩：82，分数线：65）</td>
	           </tr>
	           <tr>
	               <td><a>4、学历证书复印件</a></td>
	           </tr>
	           <tr>
	               <td>5、规培登记手册原件</td>
	           </tr>
	           <tr>
	               <td>6、规培理论考试资格表原件</td>
	           </tr>
	           <tr>
	               <td><a>7、医师执业证书/医师资格证书/执业证书成绩单</a></td>
	           </tr>
	       </tbody>
       </table>  	
    </div>
          <div class="btn_info">
          	<c:if test="${'audit'==param.type }">
				<input type="button" style="width:100px;" class="btn_blue" onclick="" value="通过"></input>
				<input type="button" style="width:100px;" class="btn_red" onclick="" value="不通过"></input>
			</c:if>
			<input type="button" style="width:100px;" class="btn_grey" onclick="javascript:jboxClose();" value="关闭"></input>
		  </div>
    </div>
</body>
</html>