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
function orgChangeRecord(){
	var url = "<s:url value='/jsp/jsres/doctor/orgChangeRecord.jsp'/>?open=messager";
	var iframe ="<iframe name='jbox-message-iframe' id='jbox-message-iframe' width='100%' height='300px' marginheight='0' marginwidth='0' frameborder='0' scrolling='auto' src='"+url+"'></iframe>";
	jboxMessager(iframe,"基地变更记录", 800,300);
}
</script>
</head>
<body>
	<div class="infoAudit">
	<div class="div_table">
        <h4>
        	培训信息
        </h4>
		<table border="0" cellpadding="0" cellspacing="0" class="base_info">
            <colgroup>
              <col width="15%"/>
              <col width="35%"/>
              <col width="15%"/>
              <col width="35%"/>
            </colgroup>
	           <tbody>
	           <tr>
	               <th>姓名：</th>
	               <td colspan="3">艾静惠</td>
	           </tr>
	           <tr>
	               <th>培训基地：</th>
	               <td>
	               	苏州市九龙医院（三级甲等）&#12288;<a class="btn" id="orgChangeRecordBtn" onclick="orgChangeRecord();">变更记录</a>
	               	</td>
	               <th>培训专业：</th>
	               <td> 麻醉科</td>
	           </tr>
	           <tr>
	               <th>规培起始日期：</th>
	               <td>2013-09-01</td>
	               <th>届&#12288;&#12288;别： </th>
	               <td>2013</td>
	           </tr>
	           <tr>
	               <th>培养年限：</th>
	               <td>三年</td>
	               <th>已培养年限： </th>
	               <td>
	               		<span id="trainedYearsSpan">一年</span>
	               		<select class="select" id="trainedYearsSelect" style="width: 106px;display: none;" >
						    <option value="">不满一年</option>
						    <option value="" selected>一年</option>
						    <option value="">两年</option>
						    <option value="">三年</option>
						    <option value="">四年</option>
						    <option value="">五年</option>
						    <option value="">六年</option>
					    </select>
	               </td>
	           </tr>
	           <tr>
	               <th>医师状态：</th>
	               <td>在培</td>
	               <th>医师走向： </th>
	               <td>留院</td>
	           </tr>
	           <tr>
	               <th>是否结业：</th>
	               <td>
	               		未结业 &#12288;<span id="applyGraduateMessage" style="color: red;">等待结业考核中...</span>
	               </td>
	               <th>结业证书编号： </th>
	               <td></td>
	           </tr>
	           <tr>
	               <th>培训号：</th>
	               <td colspan="3">133SZ1BL123</td>
	           </tr>
	           </tbody>
           </table>  	
    </div>
         
          <div class="div_table">
             <h4>轮转培训</h4>
           <table border="0" cellpadding="0" cellspacing="0" class="grid">
            <colgroup>
              <col width="20%"/>
              <col width="15%"/>
              <col width="20%"/>
              <col width="10%"/>
              <col width="10%"/>
            </colgroup>
	           <thead>
	           <tr>
	              <th>培训基地</th>
	              <th>轮转科室</th>
	              <th>轮转时间</th>
	              <th>带教老师</th>
	              <th>科主任</th>
	           </tr>
	           </thead>
	           <tbody>
	           <tr>
	               <td>苏州市广济医院</td>
	               <td>消化内科</td>
	               <td>2013-04-01 ~ 2013-06-16</td>
	               <td>周舟</td>
	               <td>李丽</td>
	           </tr>
	           <tr>
	               <td>苏州市九龙医院</td>
	               <td>儿科</td>
	               <td>2013-06-20 ~ 2013-08-18</td>
	               <td>张三</td>
	               <td>李四</td>
	           </tr>
	           <tr>
	               <td>苏州市九龙医院</td>
	               <td>神经内科</td>
	               <td>2013-08-18 ~ 2013-10-22</td>
	               <td>汪洋</td>
	               <td>王凯</td>
	           </tr>
	           </tbody>
           </table>
          </div>
          <div  class="btn_info">
          	<c:if test="${'audit'==param.type }">
				<input type="button" style="width:100px;" class="btn_blue" onclick="" value="通过"></input>
				<input type="button" style="width:100px;" class="btn_red" onclick="" value="不通过"></input>
			</c:if>
			<input type="button" style="width:100px;" class="btn_grey" onclick="javascript:jboxClose();" value="关闭"></input>
		  </div>
    </div>
</body>
</html>