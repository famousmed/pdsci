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
		jboxOpen("<s:url value='/jsp/jsres/province/hospital/hospitalInfo.jsp'/>","基地详情",1100,550);
	}
</script>

<div class="main_bd" id="div_table_0" >
	<div class="div_search">
		地&#12288;&#12288;区：
      	<select class="select" style="width: 106px;">
		    <option value="">全部</option>
		    <option value="">南京市</option>
		    <option value="">无锡市</option>
	    </select>&#12288;&#12288;
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
		基地名称：<input type="text" class="input" style="width: 100px;"/>&#12288;&#12288;<br/>
		培训基地：
		<select class="select" style="width: 106px;">
		    <option value="">全部</option>
		    <option value="">住院医师基地</option>
		    <option value="">全科医师基地</option>
	    </select>&#12288;&#12288;
	   	基地类型：
		<select class="select" style="width: 106px;">
		    <option selected="selected" value="0">全部</option>
			<option value="2">综合医院</option>
			<option value="3">专科医院</option>
			<option value="4">其他</option>
	    </select>&#12288;&#12288;
	          基地级别：
		<select class="select" style="width: 106px;">
		    <option selected="selected" value="0">全部</option>
			<option value="2">三级甲等</option>
			<option value="3">三级乙等</option>
			<option value="4">三级未定等级</option>
			<option value="5">二级甲等</option>
			<option value="6">二级乙等</option>
			<option value="7">未定等级</option>
	    </select>&#12288;&#12288;
	    <input class="btn_green" type="button" value="查询"/>
	    <input class="btn_green" type="button" value="批量修改"/>
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
            	<th>选择</th>
                <th>基地名称</th>
                <th>基地级别</th>
                <th>基地类型</th>
                <th>基地性质</th>
                <th>住院医师基地</th>
                <th>全科医师基地</th>
                <th>添加类型</th>
                <th>详情</th>
            </tr>
             <tr>
             	<td><input type="checkbox" value=""></td>
                <td>东南大学附属中大医院</td>
                <td>三级甲等</td>
                <td>综合医院</td>
                <td>公立医院</td>
                <td>毕教委已审核</td>
                <td>全科中心已审核</td>
                <td></td>
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
      
