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
	<div class="main_bd">
		<div class="div_search">
		  姓&nbsp;&nbsp;名：<input type="text" class="input" style="width:100px;" />
		 &nbsp;&nbsp;证件号：<input type="text" class="input" style="width:100px;" />
		 &nbsp;&nbsp;<input class="btn_green" type="button" value="查询"/>
		</div>
		<div class="search_table">
		  <table border="0" cellpadding="0" cellspacing="0" class="grid">
		    <colgroup>
		      <col width="20%"/>
		      <col width="15%"/>
		      <col width="20%"/>
		      <col width="15%"/>
		      <col width="15%"/>
		      <col width="15%"/>
		    </colgroup>
		    <tbody>
		      <tr>
		        <th>地区</th>
		        <th>姓名</th>
		        <th>证件号</th>
		        <th>锁定</th>
		        <th>删除</th>
		        <th>还原密码</th>
		      </tr>
		      <tr>
		        <td>南京市</td>
		        <td>医师九</td>
		        <td>ys009</td>
		        <td><a class="btn">锁定</a></td>
		        <td><a class="btn">删除</a></td>
		        <td><a class="btn">还原密码</a></td>
		      </tr>
		      <tr>
		        <td>南京市</td>
		        <td>医师三</td>
		        <td>ys003</td>
		        <td><a class="btn">锁定</a></td>
		        <td><a class="btn">删除</a></td>
		        <td><a class="btn">还原密码</a></td>
		      </tr>
		      <tr>
		        <td>南京市</td>
		        <td>医师四</td>
		        <td>ys004</td>
		        <td><a class="btn">锁定</a></td>
		        <td><a class="btn">删除</a></td>
		        <td><a class="btn">还原密码</a></td>
		      </tr>
		    </tbody>
		  </table>
		</div>
		<div class="page" style="padding-right:40px;">
		   <span>
		   <!-- 前一页 -->
		   <strong class="page_num">/</strong>
		   <!-- 后一页 -->
		   <input type="text" class="input" style="width:50px;"/>
		   <a class="btn">跳转</a>
		   </span>
		</div>
	</div>
</body>
</html>