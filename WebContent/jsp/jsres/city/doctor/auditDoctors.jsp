<jsp:include page="/jsp/jsres/htmlhead-jsres.jsp">
	<jsp:param name="font" value="true"/>
</jsp:include>
<script type="text/javascript">
	$(document).ready(function(){
		changerTrainingTypeId("${param.trainingTypeId}");
	});
	function toPage(page) {
		if(page!=undefined){
			$("#currentPage").val(page);			
		}
		var url = "<s:url value='/jsres/manage/province/doctor/auditDoctors'/>?source=hospital";
		jboxPostLoad("content", url, $("#searchForm").serialize(), true);
	} 
	
	function getInfo(doctorFlow){
		var url = "<s:url value='/jsres/manage/province/doctor/doctorMain'/>?type=audit&doctorFlow="+doctorFlow;
		jboxOpen(url,"医师信息审核",950,550);
	}
	
	function changerTrainingTypeId(trainingTypeId){
		$("select[name=trainingSpeId] option[value != '']").remove();
		if(trainingTypeId != ""){
			if(trainingTypeId == "${dictTypeEnumWM.id}"){
				<c:forEach var="dict" items="${dictTypeEnumWMList}">
			    	$option =$("<option></option>");
					$option.attr("value","${dict.dictId}");
					$option.text("${dict.dictName}");
					$("select[name=trainingSpeId]").append($option);
				</c:forEach>
			}
			if(trainingTypeId == "${dictTypeEnumTCM.id}"){
				<c:forEach var="dict" items="${dictTypeEnumTCMList}">
			    	$option =$("<option></option>");
					$option.attr("value","${dict.dictId}");
					$option.text("${dict.dictName}");
					$("select[name=trainingSpeId]").append($option);
				</c:forEach>
			}
		}
		var trainingSpeId = "${param.trainingSpeId}";
	  	if("" != trainingSpeId){
	  		$("select[name=trainingSpeId] option[value='"+trainingSpeId+"']").attr("selected",true);
	  	}
	}
	
</script>

<div class="main_bd" id="div_table_0" >
	<div class="div_search">
	<form id="searchForm">
		<input id="currentPage" type="hidden" name="currentPage"/>
		<c:if test="${param.source != 'city' && param.source != 'hospital'}">
			地&#12288;&#12288;区：
			<select class="select" style="width: 106px;">
				<option value="">全部</option>
				<option value="南京市">南京市</option>
				<option value="无锡市">无锡市</option>
			</select>&#12288;&#12288;
		</c:if>
	    <c:if test="${param.source != 'hospital'}">
		        培训基地：
			<select name="orgName" class="select" style="width: 106px;">
			    <option value=""></option>
			    <option value="南京医科大学" ${param.orgName eq '南京医科大学'?'selected':''}>南京医科大学</option>
			    <option value="镇江市中医院" ${param.orgName eq '镇江市中医院'?'selected':''}>镇江市中医院</option>
		    </select>&#12288;&#12288;
	    </c:if>
	        培训类别：
		<select name="trainingTypeId" class="select" style="width: 106px;" onchange="changerTrainingTypeId(this.value);">
		    <option value="">全部</option>
		    <option value="${dictTypeEnumWM.id}" ${param.trainingTypeId eq dictTypeEnumWM.id?'selected':''}>${dictTypeEnumWM.name}</option>
		    <option value="${dictTypeEnumTCM.id}" ${param.trainingTypeId eq dictTypeEnumTCM.id?'selected':''}>${dictTypeEnumTCM.name}</option>
	    </select>&#12288;&#12288;
	        培训专业：
		<select name="trainingSpeId" class="select" style="width: 106px;">
		    <option value="">全部</option>
	    </select>
		    
	    <c:if test="${param.source == 'hospital'}">
		    &#12288;&#12288;审核类型：
			<select name="auditType" class="select" style="width: 106px;">
				<option value="">全部</option>
			    <option value="基本信息" ${param.auditType eq '基本信息'?'select':''}>基本信息</option>
			    <option value="培训信息" ${param.auditType eq '培训信息'?'select':''}>培训信息</option>
		    </select>&#12288;&#12288;
	    </c:if>
	    <br/>
		届&#12288;&#12288;别：
	    <select name="sessionNumber" class="select" style="width: 106px;" onchange="toPage();">
			<option value=""></option>
			<c:forEach items="${dictTypeEnumDoctorSessionNumberList}" var="dict">
				<option value="${dict.dictName}" ${param.sessionNumber eq dict.dictName?'selected':''}>${dict.dictName}</option>
			</c:forEach>
		</select>&#12288;&#12288;
		姓&#12288;&#12288;名：<input type="text" name="userName" value="${param.userName}" class="input" style="width: 100px;"/>&#12288;&nbsp;&nbsp;&nbsp;
		证&nbsp;件&nbsp;号：<input type="text" name="idNo" value="${param.idNo}" class="input" style="width: 100px;"/>&#12288;&nbsp;&nbsp;
	    <input class="btn_green" type="button" value="查询" onclick="toPage();"/>
	</form>
    </div>
    <div class="search_table">
        <table border="0" cellpadding="0" cellspacing="0" class="grid">
            <tr>
            	<th><input type="checkbox" value=""></th>
                <th>姓名</th>
                <th>证件号</th>
                <th>性别</th>
                <th>培训基地</th>
                <th>培训类别</th>
                <th>培训专业</th>
                <th>注册时间</th>
                <th>届别</th>
                <c:if test="${param.source == 'hospital'}">
                	<th>审核类型</th>
                </c:if>
                <th width="9%">操作</th>
            </tr>
            <c:forEach items="${doctorExtList}" var="doctorExt">
            	<tr>
	             	<td><input type="checkbox" value="${doctorExt.doctorFlow}"></td>
	                <td>${doctorExt.sysUser.userName}</td>
	                <td>${doctorExt.sysUser.idNo}</td>
	                <td>${doctorExt.sysUser.sexName}</td>
	                <td>${doctorExt.orgName}</td>
	                <td>${doctorExt.trainingTypeName}</td>
	                <td>${doctorExt.trainingSpeName}</td>
	                <td>${pdfn:transDateTime(doctorExt.createTime)}</td>
	                <td>${doctorExt.sessionNumber}</td>
	                <c:if test="${param.source == 'hospital'}">
	                	<td>培训信息</td>
	                </c:if>
	                <td><a class="btn" onclick="getInfo('${doctorExt.doctorFlow}');">审核</a></td>
	            </tr>
            </c:forEach>
        </table>
    </div>
	<div class="page" style="padding-right: 40px;">
		<c:set var="pageView" value="${pdfn:getPageView(doctorExtList)}" scope="request"></c:set>
		<pd:pagination-hbres toPage="toPage"/>	 
	</div>
	<div class="btn_info">
		<input type="button" style="width:100px;" class="btn_blue" onclick="" value="通过"></input>
		<input type="button" style="width:100px;" class="btn_red" onclick="" value="不通过"></input>
	</div>
</div>
      
