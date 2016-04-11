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
function setScores(){
	jboxConfirm("确认设定该分数线？",function(){
		jboxTip("设定成功！");
		jboxClose();
	},function(){
	});
}
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
	               <th>考试类别：</th>
	               <td>
		               	<c:if test="${param.source=='city' }">
		               	公共科目或全科医学相关理论知识成绩
		                </c:if>
		                <c:if test="${param.source=='province' }">
		                <label><input type="radio" name="examType" value="" />理论考试</label>
		                <label><input type="radio" name="examType" value="" />技能考试</label>
		                </c:if>
	               </td>
	           </tr>
	           <tr>
	               <th>合格率：</th>
	               <td>
					    <input type="text" class="input" style="width: 100px;"/>%<font color="red">&#12288;合格人数：</font>
				   </td>
	           </tr>
	           <tr>
	               <th>分数线：</th>
	               <td>
					    <input type="text" class="input" style="width: 100px;"/>
				   </td>
	           </tr>
	           </tbody>
           </table>
          <div align="center" style="margin-top: 20px; margin-bottom:20px;">
			<input type="button" style="width:100px;" class="btn_blue"  onclick="setScores();" value="设定"></input>
		 </div>
 </div>
</body>
</html>