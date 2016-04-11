<jsp:include page="/jsp/jsres/htmlhead-jsres.jsp">
	<jsp:param name="font" value="true"/>
</jsp:include>
<script type="text/javascript">
	$(document).ready(function(){
		toPage();
	});
	function toPage(page) {
		$("#currentPage").val(page);
		jboxStartLoading();
		jboxPostLoad("abc","<s:url value='/jsres/doctorRecruit/doctorTrendList'/>",$("#searchForm").serialize(),false);
	} 
	function getInfo(doctorFlow){
		var url = "<s:url value='/jsres/manage/province/doctor/doctorMain'/>?doctorFlow="+doctorFlow;
		jboxOpen(url,"医师信息审核",950,550);
		
	}
	
	function editDoctorTrend(doctorFlow,recruitflow){
		var url = "<s:url value='/jsres/doctorRecruit/updateDoctorRecruit'/>?doctorFlow="+doctorFlow+"&recruitFlow="+recruitflow;
		jboxOpen(url,"更新医师走向",650,250);
	}
	
	function changeTrainSpes(trainCategoryid){
		//清空原来专业！！！
		if(trainCategoryid==""){
			$("select[name=speId] option[value != '']").remove();
			return false;
		}
		var orgFlow= "${sessionScope.currUser.orgFlow}";
		var url = "<s:url value='/jsres/doctor/searchResBaseSpeList?orgFlow='/>"+orgFlow+"&speTypeId="+trainCategoryid;
		jboxPost(url, null, function(resp){
			$("select[name=speId] option[value != '']").remove();
				if(resp!=""){
			   		var dataObj = resp;
				    for(var i = 0; i<dataObj.length;i++){
				     	var speId = dataObj[i].speId;
				     	var speName = dataObj[i].speName;
				     	$option =$("<option></option>");
				     	$option.attr("value",speId);
				     	$option.text(speName);
				     	$("select[name=speId]").append($option);
				   }
				}
			}, null , false);
	}
</script>

<div class="main_bd" id="div_table_0" >
	<div class="div_search">
	<form id="searchForm">
		<input id="currentPage" type="hidden" name="currentPage"/>
		  <c:if test="${sessionScope.userListScope != GlobalConstant.USER_LIST_LOCAL}"> 
			地&#12288;&#12288;区：
	      	<select class="select" style="width: 106px;">
			    <option value="">全部</option>
			    <option value="">南京市</option>
			    <option value="">无锡市</option>
		    </select>&#12288;&#12288;&#12288;
		   	 培训基地：
			<select class="select" style="width: 106px;">
			    <option value=""></option>
			    <option value="">南京医科大学</option>
			    <option value="">镇江市中医院</option>
		    </select>&#12288;&#12288;
		   </c:if> 
	        培训类别：
	        <select name="catSpeId" class="select" onchange="changeTrainSpes(this.value)" style="width:107px;">
	        	<option value="">请选择</option>
				<c:forEach items="${trainCategoryEnumList}" var="trainCategory">
					<option name="${trainCategory.id}"  value="${trainCategory.id}" <c:if test="${param.catSpeId==trainCategory.id}">selected="selected"</c:if>>${trainCategory.name}</option>
				</c:forEach>
			</select>&#12288;&#12288;&#12288;
		
	        培训专业：
		<select name="speId" class="select" style="width: 106px;">
		    <option value="">全部</option>
	    </select>
	    <br/>
		届&#12288;&#12288;别：<input type="test" name="sessionNumber" value="${param.sessionNumber}" style="width: 100px;" class="input"/>
		&#12288;&#12288;&nbsp;
		姓&#12288;&#12288;名：<input type="text" name="userName" value="${param.userName}" class="input" style="width: 100px;"/>&#12288;&nbsp;&nbsp;&nbsp;
		证&nbsp;件&nbsp;号：<input type="text" name="idNo" value="${param.idNo}" class="input" style="width: 100px;"/>&#12288;&nbsp;&nbsp;
	    <input class="btn_green" type="button" value="查询" onclick="toPage();"/>
	</form>
    </div>
    <div id="abc">
    
    </div>
</div>
      
