<jsp:include page="/jsp/jsres/htmlhead-jsres.jsp">
	<jsp:param name="basic" value="true"/>
	<jsp:param name="jbox" value="true"/>
	<jsp:param name="jquery_form" value="true"/>
</jsp:include>
<script type="text/javascript">
function saveTrainSpe(baseFlow){
	var $checkSpe = $("input[name='speId']:checked");
	var datas = [];
	$.each($checkSpe, function(i,n){
		var speId = $(n).val();
		var speTypeId = $(n).next().val();
		var speTypeName = $(n).next().next().val();
		var speName = $(n).next().next().next().val();
		var data={
			"speId":speId,
			"speTypeId":speTypeId,
			"speTypeName":speTypeName,
			"speName":speName
		};
		datas.push(data);
	});
	var requestData = {"speList":datas};
	var url = "<s:url value='/jsres/base/saveTrainSpe'/>?baseFlow="+baseFlow+"&trainCategoryType=${param.trainCategoryType}";
	jboxPostJson(
			url,
			JSON.stringify(requestData),
			function(resp){
				if(resp=="${GlobalConstant.SAVE_SUCCESSED}"){
					setTimeout(function(){
					$("#submitBtn").show();
					trainSpe('${param.trainCategoryType}');
					},1000);
				}
			}, null, true);
}
function choose(){
	var length=$("input[name='choose']:checked").length;
	if(length>0){
		$("input[name='speId']").attr("checked",true); 
		return;
	}else{
		$("input[name='speId']").attr("checked",false); 
		return;
	}
}

</script>
</head>
<body>
	<div class="main_bd" style="margin-top: 20px;">
    <ul class="search_table">
        <li class="score_frame">
            <h1 >基地培训专业管理  <span style="float: right;"><input type="checkbox"   onclick=" choose();"name="choose" />全选 </span></h1>
            	<c:forEach items="${trainCategoryEnumList}" var="trainCategory" varStatus="status">
				<c:if test="${trainCategory.typeId eq param.trainCategoryType}">
				<c:set var="dictName" value="dictTypeEnum${trainCategory.id}List" />
			<div>
				<table border="0" cellpadding="0" cellspacing="0" class="base_info" style="border: 0;">
                	<tr>
                		<th style="width: 20%;text-align: center;">${trainCategory.name}</th>
                		<td style="width: 80%;border-top: 0;border-right: 0;">
                			<ul>
						        <c:forEach items="${applicationScope[dictName]}" var="dict">
						        	<c:set var="speMapKey" value="${trainCategory.id}${dict.dictId}"/>
						            <li style="width: 220px;float: left;line-height: 25px;" >
						            	<input type="checkbox" class="spe" id="${trainCategory.id}_${dict.dictId}" name="speId" value="${dict.dictId}" 
						            	 <c:if  test="${rbsMap[speMapKey]!=null}">
						            	 checked="checked"</c:if>/>
						            	<input type="hidden" name ="speTypeId" value="${trainCategory.id}"/>
						            	<input type="hidden" name ="speTypeName" value="${trainCategory.name}"/>
						            	<input type="hidden" name ="speName" value="${dict.dictName}"/>
						            	<label for="${trainCategory.id}_${dict.dictId }">${dict.dictName}</label>
						            </li>
								</c:forEach>
							</ul>
                		</td>
                	</tr>
                </table>
			</div>
			</c:if>
		</c:forEach>
        </li>
    </ul>
</div>
<div class="btn_info">
	<input class="btn_blue" style="width:100px;" onclick="saveTrainSpe('${sessionScope.currUser.orgFlow}')" type="button" value="保存"/>
</div>
</body>
</html>