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
	
	function getInfo(){
		jboxOpen("<s:url value='/jsp/jsres/hospital/doctor/graduateMain.jsp'/>?type=audit","结业申请审核",950,550);
	}
	
</script>
<div class="main_hd">
    <h2 class="underline">考核申请审核</h2> 
</div>
<div class="main_bd" id="div_table_0" >
	<div class="div_search">
	  <c:if test="${param.source != 'city' && param.source != 'hospital'}">
		地&#12288;&#12288;区：
      	<select class="select" style="width: 106px;">
		    <option value="">全部</option>
		    <option value="">南京市</option>
		    <option value="">无锡市</option>
	    </select>&#12288;&#12288;
	   </c:if>
	   <c:if test="${param.source != 'hospital'}">
	   	 培训基地：
		<select class="select" style="width: 106px;">
		    <option value=""></option>
		    <option value="">南京医科大学</option>
		    <option value="">镇江市中医院</option>
	    </select>&#12288;&#12288;
	    </c:if>
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
	    </select>&#12288;&#12288;
	    <c:if test="${'province' != param.source}">
	    <label><input type="checkbox"/>报名材料齐全</label>
	    </c:if>
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
		<c:if test="${param.source eq 'province'}">
	    <label><input type="checkbox"/>报名材料齐全</label>&#12288;
	    </c:if>
	    <input class="btn_green" type="button" value="查询"/>
    </div>
    <div class="search_table">
        <table border="0" cellpadding="0" cellspacing="0" class="grid">
        	<colgroup>
        		<col style="text-align: left;padding-left: 40px;"/>
        		<col style="text-align: left;padding-left: 40px;"/>
        		<col style="text-align: left;padding-left: 40px;"/>
        		<col style="text-align: left;padding-left: 40px;"/>
        		<c:if test="${param.source != 'hospital'}">
        		<col style="text-align: left;padding-left: 40px;"/>
        		</c:if>
        		<col style="text-align: left;padding-left: 40px;"/>
        		<col style="text-align: left;padding-left: 40px;"/>
        		<col style="text-align: left;padding-left: 40px;"/>
        		<col style="text-align: left;padding-left: 40px;"/>
        		<col style="text-align: left;padding-left: 40px;"/>
        	</colgroup>
            <tr>
            	<th><input type="checkbox" value=""></th>
                <th>姓名</th>
                <th>证件号</th>
                <th>性别</th>
                <c:if test="${param.source != 'hospital'}">
                <th>培训基地</th>
                </c:if>
                <th>培训类别</th>
                <th>培训专业</th>
                <th>届别</th>
                <th>报名材料<br/>是否齐全</th>
                <th>操作</th>
            </tr>
             <tr>
             	<td><input type="checkbox" value=""></td>
                <td>林燕</td>
                <td>320586199006285426</td>
                <td>女</td>
                <c:if test="${param.source != 'hospital'}">
                <td>苏州市立医院</td>
                </c:if>
                <td>西医</td>
                <td>内科</td>
                <td>2013</td>
                <td><img src="<s:url value='/jsp/jsres/images/gou.gif'/>" /></td>
                <td><a class="btn" onclick="getInfo();">审核</a></td>
            </tr>
            <tr>
            	<td><input type="checkbox" value=""></td>
                <td>刘强</td>
                <td>320586199006285426</td>
                <td>女</td>
                <c:if test="${param.source != 'hospital'}">
                <td>苏州市立医院</td>
                </c:if>
                <td>西医</td>
                <td>内科</td>
                <td>2013</td>
                <td></td>
                <td><a class="btn" onclick="getInfo();">审核</a></td>
            </tr>
        </table>
    </div>
     <div class="page" style="padding-right: 40px;">
       	 <input id="currentPage" type="hidden" name="currentPage" value="${param.currentPage}"/>
           <c:set var="pageView" value="${pdfn:getPageView(hospitalList)}" scope="request"></c:set>
	  		 <pd:pagination-hbres toPage="toPage"/>	 
        </div>
    <div class="btn_info">
    	<input type="button" style="width:100px;" class="btn_blue" onclick="" value="通过"></input>
		<input type="button" style="width:100px;" class="btn_red" onclick="" value="不通过"></input>
	</div>
</div>
      
