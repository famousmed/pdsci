<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>æ±èçä½é¢å»å¸è§èåå¹è®­ç®¡çå¹³å°</title>
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
		地&#12288;区：<select class="select" style="width: 134px;">
		    <option selected="selected" value="0">全部</option>
	    </select>&#12288;
	    基地名称：<input type="text" class="input" style="width: 130px;"/>&#12288;
	    基地级别：<select class="select" style="width: 134px;">
		    <option selected="selected" value="0">全部</option>
	    </select>&#12288;
	    基地性质：<select class="select" style="width: 106px;">
		    <option selected="selected" value="0">全部</option>
	    </select><br>
	   床位数：<input type="text" class="input" style="width: 40px;"/>至<input type="text" class="input" style="width: 40px;"/>张&#12288;
	   门 诊 量：<input type="text" class="input" style="width: 40px;"/>至<input type="text" class="input" style="width: 40px;"/>张&#12288;&#12288; 
	   出院人数：<input type="text" class="input" style="width: 40px;"/>至<input type="text" class="input" style="width: 40px;"/>张&#12288;  
	    <input class="btn_green" type="button" value="查询"/>
	</div>
	<div class="search_table">
        <table border="0" cellpadding="0" cellspacing="0" class="grid">
        	<colgroup>
        		<col style="text-align: left;padding-left: 40px;"/>
        		<col style="text-align: left;padding-left: 40px;"/>
        		<col style="text-align: left;padding-left: 40px;"/>
        		<col style="text-align: left;padding-left: 40px;"/>
        		<col style="text-align: left;padding-left: 40px;"/>
        		<col style="text-align: left;padding-left: 40px;"/>
        		<col style="text-align: left;padding-left: 40px;"/>
        		<col style="text-align: left;padding-left: 40px;"/>
        	</colgroup>
        	<tr>
                <th>地区</th>
                <th>基地名称</th>
                <th>基地性质</th>
                <th>基地级别</th>
                <th>床位数</th>
                <th>门诊量</th>
                <th>出院人数</th>
                <th>培训专业数</th>
            </tr>
             <tr>
                <td>南京市</td>
                <td>东南大学附属医院</td>
                <td>公立医院</td>
                <td>三级甲等</td>
                <td>1800</td>
                <td>90.1</td>
                <td>4.2</td>
                <td>69</td>
            </tr>
            <tr>
                <td>南京市</td>
                <td>江苏省人民医院</td>
                <td>公立医院</td>
                <td>三级甲等</td>
                <td>2500</td>
                <td>325.1</td>
                <td>9.4</td>
                <td>72</td>
            </tr>
            <tr>
                <td>南京市</td>
                <td>南京大学医学院附属鼓楼医院</td>
                <td>公立医院</td>
                <td>三级甲等</td>
                <td>2500</td>
                <td>241.2</td>
                <td>7.2</td>
                <td>75</td>
            </tr>
            <tr>
                <td>南京市</td>
                <td>南京市六合区人民医院</td>
                <td>公立医院</td>
                <td>二级甲等</td>
                <td>610</td>
                <td>60.0</td>
                <td>2.6</td>
                <td>43</td>
            </tr>
            <tr>
                <td>南京市</td>
                <td>南京市高淳人民医院</td>
                <td>公立医院</td>
                <td>二级甲等</td>
                <td>820</td>
                <td>65.0</td>
                <td>3.5</td>
                <td>46</td>
            </tr>
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