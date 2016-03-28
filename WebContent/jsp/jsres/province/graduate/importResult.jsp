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
</script>
</head>
<body>
<div class="div_search">
	<table border="0" cellpadding="0" cellspacing="0" class="base_info">
            <colgroup>
              <col width="30%"/>
              <col width="70%"/>
            </colgroup>
	           <tbody>
	           <c:if test="${param.type=='double' }">
	           <tr>
	               <th>年份：</th>
	               <td>
					<select class="select" style="width: 106px;">
					    <option value=""></option>
					    <option value="" selected>2015</option>
					    <option value="">2014</option>
					    <option value="">2013</option>
					    <option value="">2012</option>
				    </select>
	               </td>
	           </tr>
	           <tr>
	               <th>导入成绩类型：</th>
	               <td>
	               <c:if test="${param.source=='city' }">
	               	公共科目或全科医学相关理论知识成绩
	               </c:if>
	               <c:if test="${param.source=='province' }">
	               <label><input type="radio" name="resultType" value="" />&nbsp;理论成绩&nbsp;</label>
	               <label><input type="radio" name="resultType" value="" />&nbsp;技能成绩&nbsp;</label>
	               </c:if>
	               </td>
	           </tr>
	           </c:if>
	           <tr>
	               <th>Excel文件：</th>
	               <td>
					    <input type="hidden" name="examFlow" value="${param.examFlow}"/>
						<input id="file" type="file" name="file" onchange="checkFile(this);" class="validate[required]"/>
				   </td>
	           </tr>
	           </tbody>
           </table>
          <div align="center" style="margin-top: 20px; margin-bottom:20px;">
			<input type="button" style="width:100px;" class="btn_blue"  onclick="javascript:;" value="${param.type=='graduate'?'导入':'导入成绩' }"></input>
		 </div>
 </div>
</body>
</html>