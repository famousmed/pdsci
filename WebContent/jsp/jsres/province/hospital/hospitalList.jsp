<jsp:include page="/jsp/jsres/htmlhead-jsres.jsp">
	<jsp:param name="font" value="true"/>
</jsp:include>
<script type="text/javascript">
function toPage(page){
	if(!page){
		page = 1;
	}
	$("#currentPage").val(page);
	searchBase();
	jboxEndLoading();
}
	
	function getInfo(baseFlow){
		var url =  "<s:url value='/jsres/base/hospitalMain'/>?baseFlow="+baseFlow;
		jboxOpen(url ,"基地详情",1100,550);
	}
	
// 	function editHospital(){
// 		jboxOpen("<s:url value='/jsp/jsres/province/hospital/editHospital.jsp'/>","编辑基地信息",1100,550);
// 	}
	function searchBase(){
		jboxPost("<s:url value='/jsres/base/findBaseInfo'/>" , $("#searchForm").serialize() , function(resp){
			$("#content").html(resp);
		} , null , false);
	}
</script>

<div class="main_bd" id="div_table_0" >
	<div class="div_search">
<%-- 		<c:if test="${param.source != 'city' }"> --%>
<!-- 		地&#12288;&#12288;区： -->
<!--       	<select class="select" style="width: 106px;"> -->
<!-- 		    <option value="">全部</option> -->
<!-- 		    <option value="">南京市</option> -->
<!-- 		    <option value="">无锡市</option> -->
<!-- 	    </select>&#12288;&#12288; -->
<%-- 	    </c:if> --%>
	         <!-- 审核状态：
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
		</select>&#12288;&#12288; -->
<%-- 		<input type="hidden" name="baseName" value="${org.name}" > --%>
<!-- 		获取批文号： -->
<!-- 		<select class="select" name="ddlstate" id="ddlstate" style="width:106px;"> -->
<!-- 			<option value=""></option> -->
<!-- 			<option value="">第一批（苏卫科教[2008] 18号）</option> -->
<!-- 			<option value="">第二批（苏卫科教[2008] 28号）</option> -->
<!-- 			<option value="">第三批（苏卫办科教[2011] 1号）</option> -->
<!-- 			<option value="">第四批（苏卫办科教[2012] 8号）</option> -->
<!-- 			<option value="">第五批（苏卫科教[2012] 13号）</option> -->
<!-- 			<option value="">第六批（苏卫科教[2013] 26号）</option> -->
<!-- 			<option value="">（苏卫科教[2014] 16号）</option> -->
<!-- 			<option value="">其他</option> -->
<!-- 			<option value="">无</option> -->
<!-- 		</select><br/> -->
<!-- 		培训基地： -->
<!-- 		<select class="select" style="width: 110px;"id="trainBase"> -->
<!-- 		    <option value=""  selected="selected">全部</option> -->
<!-- 		    <option value="liveDocBase">住院医师基地</option> -->
<!-- 		    <option value="allDocBase" >全科医师基地</option> -->
<%-- 	    </select>&#12288;&#12288;<c:if test="${param.source eq 'city' }">&nbsp;&nbsp;</c:if> --%>
<form id="searchForm">
		<input id="currentPage" type="hidden" name="currentPage" value="${param.currentPage}"/>
		基地名称：<input type="text" class="input"style="width: 100px;" name="orgName" value="${param.orgName }"/>&#12288;
	    	基地性质：
		<select class="select" style="width: 110px;"name="basePropertyName">
		    <option value=""  selected="selected">全部</option>
		    <option value="公立医院" <c:if test="${param.basePropertyName eq '公立医院'  }">selected="selected"</c:if>>公立医院</option>
		    <option value="私立医院"  <c:if test="${param.basePropertyName eq '私立医院'  }">selected="selected"</c:if>>私立医院</option>
	    </select>&#12288;&#12288;<c:if test="${param.source eq 'city' }">&nbsp;&nbsp;</c:if>
	   	基地类型：
		<select class="select" style="width: 100px;"name="baseTypeName">
		    <option selected="selected" value="" >全部</option>
			<option value="综合医院"  <c:if test="${param.baseTypeName eq '综合医院'  }">selected="selected"</c:if>>综合医院</option>
			<option value="专科医院"  <c:if test="${param.baseTypeName eq '专科医院'  }">selected="selected"</c:if> >专科医院</option>
	    </select>&#12288;
	      基地级别：
		<select class="select" style="width: 100px;" name="baseGradeName">
		    <option selected="selected" value="" >全部</option>
			<option value="三级甲等"   <c:if test="${param.baseGradeName eq '三级甲等'  }">selected="selected"</c:if>>三级甲等</option>
			<option value="三级乙等" <c:if test="${param.baseGradeName eq '三级乙等'  }">selected="selected"</c:if>>三级乙等</option>
			<option value="三级未定等级"  <c:if test="${param.baseGradeName eq '三级未定等级'  }">selected="selected"</c:if> >三级未定等级</option>
			<option value="二级甲等" <c:if test="${param.baseGradeName eq '二级甲等'  }">selected="selected"</c:if>>二级甲等</option>
			<option value="二级乙等"  <c:if test="${param.baseGradeName eq '二级乙等'  }">selected="selected"</c:if>>二级乙等</option>
			<option value="未定等级"  <c:if test="${param.baseGradeName eq '未定等级'  }">selected="selected"</c:if>>未定等级</option>
	    </select>&#12288;
	    <c:if test="${param.source == 'city' }">&#12288;</c:if>
	   <input class="btn_green" type="button"  onclick="searchBase();"value="查询"/>
	   </form>
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
        		<c:if test="${param.source != 'city' }">
        		<col style="text-align: left;padding-left: 40px;"/>
        		<col style="text-align: left;padding-left: 40px;"/>
        		</c:if>
        		<col style="text-align: left;padding-left: 40px;"/>
        	</colgroup>
            <tr>
                <th>基地名称</th>
                <th>基地级别</th>
                <th>基地类型</th>
                <th>基地性质</th>
<!--                 <th>住院医师基地</th> -->
<!--                 <th>全科医师基地</th> -->
<%--                 <c:if test="${param.source != 'city' }"> --%>
<!--                 <th>国家基地</th> -->
<!--                 <th>协同医院</th> -->
<%--                 </c:if> --%>
                <th>详情</th>
            </tr>
           	<c:forEach items="${resBaseExtList}" var="resExt">
           		<tr>
           			<td>${resExt.sysOrg.orgName}</td>
           			<td>${resExt.baseGradeName}</td>
           			<td>${resExt.baseTypeName}</td>
           			<td>${resExt.basePropertyName }</td>
           			<td><a class="btn" onclick="getInfo(${resExt.orgFlow});">详情</a></td>
           		</tr>
           	</c:forEach>
           	<c:if test="${empty resBaseExtList}">
           		<td colspan="5"> 无记录</td>
           	</c:if>
           	
<!--                 <td>毕教委已审核</td> -->
<!--                 <td>全科中心已审核</td> -->
<%--                 <c:if test="${param.source != 'city' }"> --%>
<!--                 <td>是/[<a class="btn" onclick="">否</a>]</td> -->
<!--                 <td>有/[<a class="btn" onclick="">设置</a>]</td> -->
<%--                 </c:if> --%>
<!--                 <td><a class="btn" onclick="getInfo();">详情</a></td> -->
        </table>
    </div>
     <div class="page" style="padding-right: 40px;">
				<c:set var="pageView" value="${pdfn:getPageView2(resBaseExtList, 10)}" scope="request"/>
				 <pd:pagination-hbres toPage="toPage"/>	 
				
        </div>
</div>
      
