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
		
	</div>
	<div class="search_table">
        <table border="0" cellpadding="0" cellspacing="0" class="grid">
        	<colgroup>
        		<col width="50%"/>
        		<col width="50%"/>
        	</colgroup>
        	<tr>
                <th>科室名称</th>
                <th>操作</th>
            </tr>
             <tr>
                <td>病房住院医师</td>
                <td><a class="btn">编辑</a>&#12288;<a class="btn">删除</a></td>
            </tr>
            <tr>
                <td>病理科</td>
                <td><a class="btn">编辑</a>&#12288;<a class="btn">删除</a></td>
            </tr>
            <tr>
                <td>产科病房</td>
                <td><a class="btn">编辑</a>&#12288;<a class="btn">删除</a></td>
            </tr>
            <tr>
                <td>超声</td>
                <td><a class="btn">编辑</a>&#12288;<a class="btn">删除</a></td>
            </tr>
        </table>
	</div>
	<div class="page" style="padding-right: 40px;">
       	 <input id="currentPage" type="hidden" name="currentPage" value="${param.currentPage}"/>
           <c:set var="pageView" value="${pdfn:getPageView(hospitalList)}" scope="request"></c:set>
	  		 <pd:pagination-hbres toPage="toPage"/>	 
    </div>
	<div class="btn_info">
    	<input type="button" style="width:100px;" class="btn_blue" value="添加"/>
    </div>
</div>
</body>
</html>