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
	
	function graduate(){
		jboxConfirm("确认结业？",function(){
		},function(){
		});
		/* jboxOpen("<s:url value='/jsp/jsres/province/graduate/graduate.jsp'/>","结业",500,250); */
	}
	
	function graduateBatch(){
		jboxConfirm("确认结业<font size='4'>&nbsp;3&nbsp;</font>位医师？",function(){
		},function(){
		});
		/* jboxOpen("<s:url value='/jsp/jsres/province/graduate/graduate.jsp'/>","结业",500,250); */
	}
</script>
<div class="main_hd">
    <h2 class="underline">结业名单
	</h2> 
</div>
<div class="main_bd">
	<div class="div_search">
	     年&#12288;&#12288;份：
		<select class="select" style="width: 106px;">
		    <option value=""></option>
		    <option value="">2015</option>
		    <option value="">2014</option>
		    <option value="">2013</option>
		    <option value="">2012</option>
	    </select>&#12288;&#12288;
		合&nbsp;&nbsp;格&nbsp;率：<input type="text" class="input" style="width: 100px;"/>&#12288;&nbsp;&nbsp;&nbsp;
	    <font color="red">结业人数：</font><br/>
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
	    	届&#12288;&#12288;别：
		<select class="select" style="width: 106px;">
		    <option value=""></option>
		    <option value="">2015</option>
		    <option value="">2014</option>
		    <option value="">2013</option>
		    <option value="">2012</option>
	    </select>&#12288;&#12288;
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
        		<col style="text-align: left;padding-left: 40px;"/>
        	</colgroup>
            <tr>
            	<th><input type="checkbox" value=""></th>
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
             	<td><input type="checkbox" value=""></td>
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
            	<td><input type="checkbox" value=""></td>
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
            <tr>
            	<td><input type="checkbox" value=""></td>
                <td>汪洋</td>
                <td>320586199006285426</td>
                <td>苏州市立医院</td>
                <td>西医</td>
                <td>内科</td>
                <td>2013</td>
                <td title="2015-02-21">70</td>
                <td title="2015-03-15">80</td>
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
     <div class="btn_info">
    	<input type="button" style="width:100px;" class="btn_blue" onclick="graduateBatch();" value="批量结业"></input>
	</div>
</div>
      
