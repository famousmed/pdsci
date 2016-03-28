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
		jboxOpen("<s:url value='/jsp/jsres/province/doctor/doctorMain.jsp'/>","医师信息",950,550);
	}
	
</script>

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
	    </select>
	    <%-- <c:if test="${param.source == 'hospital'}">
	     &#12288;&#12288;审核状态：
      	<select class="select" name="ddlstate" id="ddlstate" style="width:106px;">
			<option selected="selected" value="全部">全部</option>
			<option value="">未提交申请</option>
			<option value="0">提交未审核</option>
			<option value="1">市局已审核</option>
			<option value="11">市局未通过</option>
			<option value="全科中心已审核">全科中心已审核</option>
			<option value="全科中心未通过">全科中心未通过</option>
			<option value="毕教委已审核">毕教委已审核</option>
			<option value="毕教委未通过">毕教委未通过</option>
		</select>&#12288;&#12288;
		</c:if> --%>
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
		<%-- <c:if test="${param.source != 'hospital'}">
	         审核状态：
      	<select class="select" name="ddlstate" id="ddlstate" style="width:106px;">
			<option selected="selected" value="全部">全部</option>
			<option value="">未提交申请</option>
			<option value="0">提交未审核</option>
			<option value="1">市局已审核</option>
			<option value="11">市局未通过</option>
			<option value="全科中心已审核">全科中心已审核</option>
			<option value="全科中心未通过">全科中心未通过</option>
			<option value="毕教委已审核">毕教委已审核</option>
			<option value="毕教委未通过">毕教委未通过</option>
		</select>&#12288;&#12288;
		</c:if> --%>
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
                <th>性别</th>
                <th>联系方式</th>
                <th>培训类别</th>
                <th>培训基地</th>
                <th>培训专业</th>
                <th>届别</th>
                <th>培养年限</th>
                <th>详情</th>
            </tr>
             <tr>
                <td>艾静惠</td>
                <td>320586199006285426</td>
                <td>女</td>
                <td>18962115659</td>
                <td>西医</td>
                <td>苏州市立医院</td>
                <td>内科</td>
                <td>2013</td>
                <td>三年</td>
                <td><a class="btn" onclick="getInfo();">详情</a></td>
            </tr>
            <tr>
                <td>安冬梅</td>
                <td>320586199006285426</td>
                <td>女</td>
                <td>18962115659</td>
                <td>西医</td>
                <td>苏州市立医院</td>
                <td>内科</td>
                <td>2013</td>
                <td>三年</td>
                <td><a class="btn" onclick="getInfo();">详情</a></td>
            </tr>
        </table>
    </div>
     <div class="page" style="padding-right: 40px;">
       	 <input id="currentPage" type="hidden" name="currentPage" value="${param.currentPage}"/>
           <c:set var="pageView" value="${pdfn:getPageView(hospitalList)}" scope="request"></c:set>
	  		 <pd:pagination-hbres toPage="toPage"/>	 
     </div>
</div>
      
