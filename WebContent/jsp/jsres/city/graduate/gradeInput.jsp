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
		var url = "<s:url value='/jsp/jsres/province/graduate/importResult.jsp'/>?type=double&source=${param.source}";
		jboxOpen(url, "成绩导入", width, 250);
	}
	
	function setScoresMain(){
		var url = "<s:url value='/jsp/jsres/province/graduate/setScoresMain.jsp'/>?source=${param.source}";
		jboxOpen(url, "设置分数线", 520, 300);
	}
</script>
<div class="main_hd">
    <h2 class="underline">成绩管理
    <span style="float:right; margin-right:40px; *margin-top:-76px;">
	    <a href="javascript:;" style="font-size: 14px;">[&nbsp;成绩导入模板&nbsp;]</a>
	    <input type="button" value="成绩导入" class="btn_green" onclick="openImport('theoryTest');"/>
	    <input class="btn_green" type="button" value="设置分数线" onclick="setScoresMain();"/>
	</span>
	</h2> 
</div>
<div class="main_bd">
	<div class="div_search" style="line-height: 35px;">
		<c:if test="${param.source=='province' }">
		地&#12288;&#12288;区：
      	<select class="select" style="width: 106px;">
		    <option value="">全部</option>
		    <option value="">南京市</option>
		    <option value="">无锡市</option>
	    </select>&#12288;&#12288;
	    </c:if>
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
		年&#12288;&#12288;份：
		<select class="select" style="width: 106px;">
		    <option value=""></option>
		    <option value="">2015</option>
		    <option value="">2014</option>
		    <option value="">2013</option>
		    <option value="">2012</option>
	    </select>&#12288;
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
        	</colgroup>
            <tr>
                <th>姓名</th>
                <th>证件号</th>
                <th>培训基地</th>
                <th>培训类别</th>
                <th>培训专业</th>
                <th>届别</th>
                <th>公共科目成绩</th>
                <th>理论成绩</th>
                <th>技能成绩</th>
            </tr>
             <tr>
                <td>林燕</td>
                <td>320586199006285426</td>
                <td>苏州市立医院</td>
                <td>西医</td>
                <td>内科</td>
                <td>2013</td>
                <td>
                	<c:if test="${param.source=='city' }">
	                	<input class="validate[required,custom[number],min[0],max[999]] inp" value="" style="width: 50px;text-align: center;"/>
                	</c:if>
                	<c:if test="${param.source=='province' }">
                	82
                	</c:if>
                </td>
                <td>
                	<c:if test="${param.source=='province' }">
	                	<input class="validate[required,custom[number],min[0],max[999]] inp" value="" style="width: 50px;text-align: center;"/>
                	</c:if>
                </td>
                <td>
                	<c:if test="${param.source=='province' }">
                		<input class="validate[required,custom[number],min[0],max[999]] inp" value="" style="width: 50px;text-align: center;"/>
                	</c:if>
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
                	<c:if test="${param.source=='city' }">
	                	<input class="validate[required,custom[number],min[0],max[999]] inp" value="" style="width: 50px;text-align: center;"/>
                	</c:if>
                	<c:if test="${param.source=='province' }">
                	76
                	</c:if>
                </td>
                <td>
                	<c:if test="${param.source=='province' }">
	                	<input class="validate[required,custom[number],min[0],max[999]] inp" value="" style="width: 50px;text-align: center;"/>
                	</c:if>
                </td>
                <td>
                	<c:if test="${param.source=='province' }">
                		<input class="validate[required,custom[number],min[0],max[999]] inp" value="" style="width: 50px;text-align: center;"/>
                	</c:if>
                </td>
            </tr>
            <tr>
                <td>王伟</td>
                <td>320586199006285426</td>
                <td>苏州市立医院</td>
                <td>西医</td>
                <td>内科</td>
                <td>2013</td>
                <td>
                	<c:if test="${param.source=='city' }">
	                	<input class="validate[required,custom[number],min[0],max[999]] inp" value="" style="width: 50px;text-align: center;"/>
                	</c:if>
                	<c:if test="${param.source=='province' }">
                	85
                	</c:if>
                </td>
                <td>
                	<c:if test="${param.source=='province' }">
	                	<input class="validate[required,custom[number],min[0],max[999]] inp" value="" style="width: 50px;text-align: center;"/>
                	</c:if>
                </td>
                <td>
                	<c:if test="${param.source=='province' }">
                		<input class="validate[required,custom[number],min[0],max[999]] inp" value="" style="width: 50px;text-align: center;"/>
                	</c:if>
                </td>
            </tr>
            <tr>
                <td>周舟</td>
                <td>320586199006285426</td>
                <td>苏州市立医院</td>
                <td>西医</td>
                <td>内科</td>
                <td>2013</td>
                <td>
                	<c:if test="${param.source=='city' }">
	                	<input class="validate[required,custom[number],min[0],max[999]] inp" value="" style="width: 50px;text-align: center;"/>
                	</c:if>
                	<c:if test="${param.source=='province' }">
                	80
                	</c:if>
                </td>
                <td>
                	<c:if test="${param.source=='province' }">
	                	<input class="validate[required,custom[number],min[0],max[999]] inp" value="" style="width: 50px;text-align: center;"/>
                	</c:if>
                </td>
                <td>
                	<c:if test="${param.source=='province' }">
                		<input class="validate[required,custom[number],min[0],max[999]] inp" value="" style="width: 50px;text-align: center;"/>
                	</c:if>
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
      
