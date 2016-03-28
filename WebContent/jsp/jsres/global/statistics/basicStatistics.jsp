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
		<h2>江苏省2015届在培医师统计表</h2><span>统计单位：人</span></br>
		地区：<select class="select" style="width: 106px;">
		    	<option selected="selected" value="0">全部</option>
	    	</select>&#12288;
	    基地名称：<input type="text" class="input" style="width:130px;" />
		届别：<input name="" type="checkbox" value="" />2011&#12288;
			<input name="" type="checkbox" value="" />2012&#12288;
			<input name="" type="checkbox" value="" />2013&#12288;
			<input name="" type="checkbox" value="" />2014&#12288;
			<input name="" type="checkbox" value="" />2015&#12288;
		<input class="btn_green" type="button" value="查询"/>
		
	</div>
	<div class="search_table">
        <table border="0" cellpadding="0" cellspacing="0" class="grid">
        	<colgroup>
        		<col style="text-align: left;padding-left: 40px;"/>
        		<col style="text-align: left;padding-left: 40px;"/>
        	</colgroup>
        	<tr>
                <th>基地名称</th>
                <th>在培医师数</th>
            </tr>
             <tr>
                <td>jd001</td>
                <td>0</td>
            </tr>
            <tr>
                <td>jd002</td>
                <td>1</td>
            </tr>
            <tr>
                <td>宝应县人民医院</td>
                <td>1</td>
            </tr>
            <tr>
                <td>滨海县人民医院</td>
                <td>1</td>
            </tr>
        </table>
	</div>
    <div style="text-align:center;margin:20px 0;">
    	<input type="button" style="width:100px;" class="btn_blue" value="打印"/>
    	<input type="button" style="width:100px;" class="btn_blue" value="导出Excel"/>
    </div>
</div>
</body>
</html>