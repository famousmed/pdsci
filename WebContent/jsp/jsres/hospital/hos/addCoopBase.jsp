<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>江苏省住院医师规范化培训管理平台</title>
<jsp:include page="/jsp/jsres/htmlhead-jsres.jsp">
	<jsp:param name="basic" value="true"/>
	<jsp:param name="jbox" value="true"/>
	<jsp:param name="font" value="true"/>
	<jsp:param name="jquery_datePicker" value="true"/>
</jsp:include>
<script type="text/javascript">
function saveCoopBase(){
	jboxPost("<s:url value='/jsres/Base/saveCoopBase'/>" , $("#coopBaseForm").serialize() , function(resp){
	} , null , false);
}
</script>
</head>
<body>
<div class="div_search">
<form id="coopBaseForm">
	<table border="0" cellpadding="0" cellspacing="0" class="base_info">
            <colgroup>
              <col width="30%"/>
              <col width="70%"/>
            </colgroup>
	           <tbody>
	           <tr>
	               <th>协同培训基地：</th>
	               <td>
	               		<select class="select" style="width: 250px;" name="orgFlow">
	               			<option value="">请选择</option>
						    <option value="">江苏省第二中医院</option>
						    <option value="">江苏省人民医院</option>
						    <option value="">江苏省省级机关医院</option>
						    <option value="">江苏省中西医结合医院</option>
						    <option value="">江苏省中医院</option>
						    <option value="">江苏省肿瘤医院</option>
						    <option value="">解放军第81医院</option>
						    <option value="">解放军第四五四医院</option>
						    <option value="">苏州大学附属第二医院 </option>
					    </select>
					</td>
	           </tr>
	           </tbody>
           </table>
           </form>
          <div align="center" style="margin-top: 20px; margin-bottom:20px;">
			<input type="button" style="width:100px;" class="btn_blue"  onclick="saveCoopBase();" value="保存"></input>
			<input type="button" style="width:100px;" class="btn_grey" onclick="javascript:jboxClose();" value="关闭"></input>
		 </div>
 </div>
</body>
</html>