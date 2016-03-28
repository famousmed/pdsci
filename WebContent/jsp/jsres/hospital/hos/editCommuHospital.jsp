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
	<div class="infoAudit2">
		<div class="search_table">
		  <h4>基本信息（单位荣誉称号及颁发部门）</h4>
          <table border="0" cellspacing="0" cellpadding="0" class="base_info">
		   <colgroup>
		     <col width="15%"/>
		     <col width="35%"/>
		     <col width="15%"/>
		     <col width="35%"/>
		   </colgroup>
		   <tbody>
		     <tr>
		       <th>单位名称：</th>
		       <td><input type="text" class="input1" style="width:200px;" value=""/>&nbsp;<span class="red">*</span></td>
		       <th>邮政邮编：</th>
		       <td><input type="text" class="input1" style="width:200px;" value=""/>&nbsp;<span class="red">*</span></td>
		     </tr>
		     <tr>
		       <th>单位地址：</th>
		       <td><input type="text" class="input1" style="width:200px;" value=""/>&nbsp;<span class="red">*</span></td>
		       <th>联系电话：</th>
		       <td><input type="text" class="input1" style="width:200px;" value=""/>&nbsp;<span class="red">*</span></td>
		     </tr>
		     <tr>
		       <th>单位类型：</th>
		       <td><input type="radio" name="1" value="乡镇卫生院"/>乡镇卫生院&nbsp;<input type="radio" name="1" value="社区服务院"/>社区服务院&nbsp;<input type="radio" name="1" value="公共卫生机构"/>公共卫生机构&nbsp;<span class="red">*</span></td>
		       <th>签订培养协议时间：</th>
		       <td><input type="text" class="input1" style="width:200px;" value=""/>&nbsp;<span class="red">*</span></td>
		     </tr>
		   </tbody>
		   </table>
            <table border="0" cellpadding="0" cellspacing="0" class="grid">
		    <colgroup>
		      <col width="20%"/>
		      <col width="20%"/>
		      <col width="20%"/>
		      <col width="20%"/>
		      <col width="20%"/>
		    </colgroup>
		    <tbody>
		      <tr>
		        <th>单位荣誉称号</th>
		        <th>授予时间</th>
		        <th>颁发部门</th>
		        <th>备注</th>
		        <th>删除</th>
		      </tr>
		      <tr>
		        <td><input type="text" class="input1" style="width:150px;" value=""/></td>
		        <td><input type="text" class="input1" style="width:150px;" value=""/></td>
		        <td><input type="text" class="input1" style="width:150px;" value=""/></td>
		        <td><input type="text" class="input1" style="width:150px;" value=""/></td>
		        <td><a class="btn">删除</a></td>
		      </tr>
		       <tr>
		        <td><input type="text" class="input1" style="width:150px;" value=""/></td>
		        <td><input type="text" class="input1" style="width:150px;" value=""/></td>
		        <td><input type="text" class="input1" style="width:150px;" value=""/></td>
		        <td><input type="text" class="input1" style="width:150px;" value=""/></td>
		        <td><a class="btn">删除</a></td>
		      </tr>
		      <tr>
		        <td colspan="5"><input type="button" class="btn_blue" value="添加"/></td>
		      </tr>
		    </tbody>
		  </table>
		</div>
		<div class="div_table">
		  <h4>教学条件</h4>
          <table border="0" cellspacing="0" cellpadding="0" class="base_info">
		   <colgroup>
		     <col width="15%"/>
		     <col width="35%"/>
		     <col width="15%"/>
		     <col width="35%"/>
		   </colgroup>
		   <tbody>
		     <tr>
		       <th>年门诊量：</th>
		       <td><input type="text" class="input1" style="width:100px;" value=""/>&nbsp;万余人次&nbsp;<span class="red">*</span></td>
		       <th>年出院病人数：</th>
		       <td><input type="text" class="input1" style="width:100px;" value=""/>&nbsp;人次&nbsp;<span class="red">*</span></td>
		     </tr>
		     <tr>
		       <th>辐射社区人口数：</th>
		       <td><input type="text" class="input1" style="width:100px;" value=""/>&nbsp;万余人&nbsp;<span class="red">*</span></td>
		       <th>编制总床位数：</th>
		       <td><input type="text" class="input1" style="width:100px;" value=""/>&nbsp;张&nbsp;<span class="red">*</span></td>
		     </tr>
		   </tbody>
		   </table>
            <table border="0" cellpadding="0" cellspacing="0" class="grid">
		    <colgroup>
		      <col width="40%"/>
		      <col width="40%"/>
		      <col width="20%"/>
		    </colgroup>
		    <tbody>
		      <tr>
		        <th>科室名称</th>
		        <th>床位数（张）</th>
		        <th>删除</th>
		      </tr>
		      <tr>
		        <td><input type="text" class="input1" style="width:150px;" value=""/></td>
		        <td><input type="text" class="input1" style="width:150px;" value=""/></td>
		        <td><a class="btn">删除</a></td>
		      </tr>
		       <tr>
		        <td><input type="text" class="input1" style="width:150px;" value=""/></td>
		        <td><input type="text" class="input1" style="width:150px;" value=""/></td>
		        <td><a class="btn">删除</a></td>
		      </tr>
		      <tr>
		        <td colspan="3"><input type="button" class="btn_blue" value="添加"/></td>
		      </tr>
		      <tr>
		        <td colspan="3" style="text-align:left;">门诊科室设置情况</td>
		      </tr>
		      <tr>
		        <td colspan="3"><textarea></textarea></td>
		      </tr>
		    </tbody>
		  </table>
		</div>		
		<div class="div_table">
		  <h4>组织管理（全科医师规范化培训组织管理机构成员及职责）</h4>
          <table border="0" cellspacing="0" cellpadding="0" class="base_info">
		   <colgroup>
		     <col width="15%"/>
		     <col width="35%"/>
		     <col width="15%"/>
		     <col width="35%"/>
		   </colgroup>
		   <tbody>
		     <tr>
		       <th>分管领导姓名：</th>
		       <td><input type="text" class="input1" style="width:200px;" value=""/></td>
		       <th>联系电话：</th>
		       <td><input type="text" class="input1" style="width:200px;" value=""/></td>
		     </tr>
		     <tr>
		       <th>管理机构名称：</th>
		       <td><input type="text" class="input1" style="width:200px;" value=""/></td>
		       <th>机构地址：</th>
		       <td><input type="text" class="input1" style="width:200px;" value=""/></td>
		     </tr>
		     <tr>
		       <th>电子邮箱：</th>
		       <td colspan="3"><input type="text" class="input1" style="width:200px;" value=""/></td>
		     </tr>
		   </tbody>
		   </table>
            <table border="0" cellpadding="0" cellspacing="0" class="grid">
		    <colgroup>
		      <col width="10%"/>
		      <col width="10%"/>
		      <col width="10%"/>
		      <col width="15%"/>
		      <col width="15%"/>
		      <col width="15%"/>
		      <col width="15%"/>
		    </colgroup>
		    <tbody>
		      <tr>
		        <th>姓名</th>
		        <th>性别</th>
		        <th>年龄</th>
		        <th>专业/最高学历</th>
		        <th>职务</th>
		        <th>联系电话</th>
		        <th>删除</th>
		      </tr>
		      <tr>
		        <td><input type="text" class="input1" style="width:150px;" value=""/></td>
		        <td><select  class="select" style="width:80px;"><option>男</option><option>女</option></select></td>
		        <td><input type="text" class="input1" style="width:80px;" value=""/></td>
		        <td><input type="text" class="input1" style="width:150px;" value=""/></td>
		        <td><input type="text" class="input1" style="width:150px;" value=""/></td>
		        <td><input type="text" class="input1" style="width:150px;" value=""/></td>
		        <td><a class="btn">删除</a></td>
		      </tr>
		      <tr>
		        <td colspan="7"><input type="button" class="btn_blue" value="添加"/></td>
		      </tr>
		      <tr>
		        <td colspan="7" style="text-align:left;">现有培训相关规章制度、培训实施计划、考试考核等（具体名称）：</td>
		      </tr>
		      <tr>
		        <td colspan="7"><textarea></textarea></td>
		      </tr>
		    </tbody>
		  </table>
		</div>
		
		<div class="btn_info">
			<input class="btn_blue" style="width:100px;" onclick="" type="button" value="保存"/>
			<input type="button" style="width:100px;" class="btn_grey" onclick="javascript:jboxClose();" value="关闭"></input>
		</div>
   </div>
</body>
</html>