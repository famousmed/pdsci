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
		var url = "<s:url value='/jsp/jsres/province/graduate/importResult.jsp'/>";
		jboxOpen(url, "公共科目成绩导入", width, height);
	}
	
	function setScoresMain(){
		$("#setScoresDiv").show();
	}
	
	function setScores(){
		jboxConfirm("确认设定该分数线？",function(){
			jboxTip("设定成功！");
			$("#setScoresDiv").hide();
		},function(){
		});
	}
</script>
<div class="main_hd">
    <h2 class="underline">成绩管理
    <span style="float:right; margin-right:40px; *margin-top:-76px;">
	    <a href="javascript:;" style="font-size: 14px;">[&nbsp;成绩导入模板&nbsp;]</a>
	    <input type="button" value="成绩导入" class="btn_green" onclick="openImport();"/>
	</span>
	</h2> 
</div>
<div class="main_bd">
	<div class="div_setParam" id="setScoresDiv" style="display: none;">
		年&#12288;&#12288;份：
		<select class="select" style="width: 106px;">
		    <option value=""></option>
		    <option value="">2015</option>
		    <option value="">2014</option>
		    <option value="">2013</option>
		    <option value="">2012</option>
	    </select>&#12288;&#12288;
		分&nbsp;&nbsp;数&nbsp;线：<input type="text" class="input" style="width: 100px;"/>&#12288;
	    <input class="btn_green" type="button" value="设定" onclick="setScores();"/>&#12288;
	    <font color="red">合格人数：&#12288;合格率：&#12288;</font>
	</div>
	<div class="div_search">
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
	    <input class="btn_green" type="button" value="设置分数线" onclick="setScoresMain();"/>
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
                <th>姓名</th>
                <th>证件号</th>
                <th>培训基地</th>
                <th>培训类别</th>
                <th>培训专业</th>
                <th>届别</th>
                <th>分数</th>
            </tr>
             <tr>
                <td>林燕</td>
                <td>320586199006285426</td>
                <td>苏州市立医院</td>
                <td>西医</td>
                <td>内科</td>
                <td>2013</td>
                <td>
                	<input class="validate[required,custom[number],min[0],max[999]] inp" value="" style="width: 50px;text-align: center;"/>
                </td>
            </tr>
            <tr>
                <td>刘强</td>
                <td>320586199006285426</td>
                <td>苏州市立医院</td>
                <td>西医</td>
                <td>内科</td>
                <td>2013</td>
                <td>
                	<input class="validate[required,custom[number],min[0],max[999]] inp" value="" style="width: 50px;text-align: center;"/>
                </td>
            </tr>
        </table>
    </div>
     <div class="page" style="padding-right: 40px;">
       	 <input id="currentPage" type="hidden" name="currentPage" value="${param.currentPage}"/>
           <c:set var="pageView" value="${pdfn:getPageView(hospitalList)}" scope="request"></c:set>
	  		 <pd:pagination-hbres toPage="toPage"/>	 
     </div>
</div>
      
