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
		<h2>江苏省2015届中医在培医师统计表</h2><span>统计单位：人</span></br>
		届别：<input name="" type="checkbox" value="" />2011&#12288;
			<input name="" type="checkbox" value="" />2012&#12288;
			<input name="" type="checkbox" value="" />2013&#12288;
			<input name="" type="checkbox" value="" />2014&#12288;
			<input name="" type="checkbox" value="" />2015
		
	</div>
	<div class="search_table">
        <table border="0" cellpadding="0" cellspacing="0" class="grid">
        	<colgroup>
        		<col style="text-align: left;padding-left: 40px;"/>
        		<col style="text-align: left;padding-left: 40px;"/>
        		<col style="text-align: left;padding-left: 40px;"/>
        		<col style="text-align: left;padding-left: 40px;"/>
        		<col style="text-align: left;padding-left: 40px;"/>
        	</colgroup>
        	<tr>
                <th>专业</th>
                <th>南京市</th>
                <th>无锡市</th>
                <th>徐州市</th>
                <th>常州市</th>
                <th>苏州市</th>
                <th>南通市</th>
                <th>连云港市</th>
                <th>淮安市</th>
                <th>盐城市</th>
                <th>扬州市</th>
                <th>镇江市</th>
                <th>泰州市</th>
                <th>宿迁市</th>
                <th>合计</th>
            </tr>
            <c:forEach items="${dictTypeEnumTCMList }" var="dict">
		     <tr>
			    <td>${dict.dictName }</td>
			    <td>1</td>
                <td>0</td>
                <td>0</td>
                <td>0</td>
                <td>0</td>
                <td>0</td>
                <td>0</td>
                <td>0</td>
                <td>0</td>
                <td>0</td>
                <td>0</td>
                <td>0</td>
                <td>0</td>
                <td>1</td>
			  </tr>
			</c:forEach>
        </table>
	</div>
    <div style="text-align:center;margin:20px 0;">
    	<input type="button" style="width:100px;" class="btn_blue" value="打印"/>
    	<input type="button" style="width:100px;" class="btn_blue" value="导出Excel"/>
    </div>
</div>
</body>
</html>