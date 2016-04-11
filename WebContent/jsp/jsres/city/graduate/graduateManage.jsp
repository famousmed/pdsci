<jsp:include page="/jsp/jsres/htmlhead-jsres.jsp">
	<jsp:param name="font" value="true"/>
</jsp:include>
<script type="text/javascript">
	function toPage(page) {
		if(page!=undefined){
			$("#currentPage").val(page);			
		}
		var currentPage = $("#currentPage").val();
		if(!currentPage){
			currentPage = 1;
		}
		/* gradeInput(currentPage); */
	} 
	
	function openImport(){
		var width = (window.screen.width)*0.5; 
		var height = (window.screen.height)*0.2;
		var url = "<s:url value='/jsp/jsres/province/graduate/importResult.jsp'/>?type=graduate";
		jboxOpen(url, "结业人员导入", width, height);
	}
	
	function graduate(){
		jboxOpen("<s:url value='/jsp/jsres/province/graduate/graduate.jsp'/>","结业",500,250);
	}
</script>
<div class="main_hd">
    <h2 class="underline">结业管理
    <span style="float:right; margin-right:40px; *margin-top:-76px;">
	    <a href="javascript:;" style="font-size: 14px;">[&nbsp;结业人员导入模板&nbsp;]</a>
	    <input type="button" value="结业人员导入" class="btn_green" onclick="openImport();"/>
	</span>
	</h2> 
</div>
<div class="main_bd">
	<div class="div_search">
		地&#12288;&#12288;区：
      	<select class="select" style="width: 106px;">
		    <option value="">全部</option>
		    <option value="">南京市</option>
		    <option value="">无锡市</option>
	    </select>&#12288;&#12288;
	   	 培训基地：
		<select class="select" style="width: 106px;">
		    <option value=""></option>
		    <option value="">南京医科大学</option>
		    <option value="">镇江市中医院</option>
	    </select>&#12288;&#12288;
	           培训类别：
		<select class="select" style="width: 106px;">
		    <option value="">全部</option>
		    <option value="">西医</option>
		    <option value="">中医</option>
	    </select>&#12288;&#12288;
	     培训专业：
		<select class="select" style="width: 106px;">
		    <option value="">全部</option>
		    <option value="">内科</option>
		    <option value="">儿科</option>
	    </select>
	    <br/>
	     届&#12288;&#12288;别：
		<select class="select" style="width: 106px;">
		    <option value=""></option>
		    <option value="">2015</option>
		    <option value="">2014</option>
		    <option value="">2013</option>
		    <option value="">2012</option>
	    </select>&#12288;&#12288;
	    姓&#12288;&#12288;名：<input type="text" class="input" style="width: 100px;"/>&#12288;&nbsp;&nbsp;&nbsp;
		证&nbsp;件&nbsp;号：<input type="text" class="input" style="width: 100px;"/>&#12288;&nbsp;&nbsp;
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
        		<col style="text-align: left;padding-left: 40px;"/>
        		<col style="text-align: left;padding-left: 40px;"/>
        	</colgroup>
            <tr>
                <th>姓名</th>
                <th>证件号</th>
                <th>培训基地</th>
                <th>培训类别</th>
                <th>培训专业</th>
                <th>届别</th>
                <th>理论成绩</th>
                <th>技能成绩</th>
                <th>结业证书编号</th>
                <th>操作</th>
            </tr>
             <tr>
                <td>林燕</td>
                <td>320586199006285426</td>
                <td>苏州市立医院</td>
                <td>西医</td>
                <td>内科</td>
                <td>2013</td>
                <td title="2015-02-21">81</td>
                <td title="2015-03-15">85</td>
                <td>JYZSBH43770</td>
                <td></td>
            </tr>
            <tr>
                <td>刘强</td>
                <td>320586199006285426</td>
                <td>苏州市立医院</td>
                <td>西医</td>
                <td>内科</td>
                <td>2013</td>
                <td title="2015-02-21">73</td>
                <td title="2015-03-15">82</td>
                <td></td>
                <td><a class="btn" onclick="graduate();">结业</a></td>
            </tr>
        </table>
    </div>
     <div class="page" style="padding-right: 40px;">
       	 <input id="currentPage" type="hidden" name="currentPage" value="${param.currentPage}"/>
           <c:set var="pageView" value="${pdfn:getPageView(hospitalList)}" scope="request"></c:set>
	  		 <pd:pagination-hbres toPage="toPage"/>	 
     </div>
</div>
      
