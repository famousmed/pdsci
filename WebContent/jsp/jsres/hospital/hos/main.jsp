<jsp:include page="/jsp/jsres/htmlhead-jsres.jsp">
	<jsp:param name="basic" value="true"/>
	<jsp:param name="jbox" value="true"/>
	<jsp:param name="font" value="true"/>
</jsp:include>
<link rel="stylesheet" type="text/css" href="<s:url value='/jsp/jsres/css/exam.css'/>?v=${applicationScope.sysCfgMap['sys_version']}"></link>
<script type="text/javascript">
$(document).ready(function(){
	$("li").click(function(){
		$(".tab_select").addClass("tab");
		$(".tab_select").removeClass("tab_select");
		$(this).removeClass("tab");
		$(this).addClass("tab_select");
	});
	if ("${param.liId}" != "") {
		$("#${param.liId}").addClass("tab_select");
	} else {
		$('li').first().addClass("tab_select");
	}
	$(".tab_select a").click();
	
	<c:if test="${resBase.baseStatusId eq baseStatusEnumNotSubmit.id or resBase.baseStatusId eq baseStatusEnumNotPassed.id }">
		$("#submitBtn").show();	
    </c:if>
});
function submitInfo(){
	jboxConfirm("提交后不可修改！请确认修改的信息是否已保存，否则提交的仍是保存前的信息，确认提交?",function(){
		jboxPost("<s:url value='/jsres/base/submitBaseInfo'/>" , $("#baseForm").serialize() , function(resp){
			if("${GlobalConstant.OPRE_SUCCESSED}" == resp){
				setTimeout(function(){
					$("#submitBtn").hide();
					$(".tab_select").children().click();
				},1000);
			}
		} , null , true);
	});
}

function getInfo(baseInfoName,baseFlow){
	var resBase = $("#baseStatusId").val();
	if(!resBase){
		loadInfo(baseInfoName,baseFlow);
	}else{
		editInfo(baseInfoName,baseFlow);
	}
}

function editInfo(baseInfoName,orgFlow){
	var url="";
	if(baseInfoName=='${trainCategoryTypeEnumAfter2014.id}'||baseInfoName=='${trainCategoryTypeEnumBefore2014.id}'){
		url="<s:url value='/jsres/base/findTrainSpe'/>?editFlag=${GlobalConstant.FLAG_Y}&trainCategoryType="+baseInfoName+"&orgFlow="+orgFlow;
		jboxLoad("trainSpeContent",url,false);
	}else{
	  	url="<s:url value='/jsres/base/findAllBaseInfo'/>?editFlag=${GlobalConstant.FLAG_Y}&baseInfoName="+baseInfoName+"&baseFlow="+orgFlow;
	 	jboxLoad("hosContent", url, false);
	}
}

function loadInfo(baseInfoName,baseFlow){
	var url="<s:url value='/jsres/base/findAllBaseInfo'/>?baseInfoName="+baseInfoName+"&baseFlow="+baseFlow;
	jboxLoad("hosContent", url, false);
}

function editTrainSpeInfo(){
	var url="<s:url value='/jsres/base/trainSpeMain'/>";
	jboxLoad("hosContent", url, false);
}

function coopBaseInfo(){
	var url="<s:url value='/jsres/base/findCoopBase'/>";
	jboxLoad("hosContent", url, false);
}

function commuHospital(){
	jboxLoad("hosContent","<s:url value='/jsp/jsres/hospital/hos/commuHospital.jsp'/>",false);
}
</script>
<div class="main_hd">
	<input type="hidden" id="baseStatusId" name="baseStatusId" value="${resBase.baseStatusId}"/>
	<form id="baseForm"style="position:relative;">
    <input type="hidden" name="baseFlow" value="${sessionScope.currUser.orgFlow}"/>
	</form>
    <h2>
		基地信息维护<input id="submitBtn" class="btn_green" type="button" onclick="submitInfo();" value="提交"  style="display: none; float: right; margin-top: 30px; margin-right: 10px;" />
    </h2>
    <div class="title_tab" id="toptab">
        <ul>
            <li class="tab_select" onclick="loadInfo('${GlobalConstant.BASIC_INFO}','${sessionScope.currUser.orgFlow}');" style="cursor: pointer;"><a href="javascript:void(0);" >基本信息</a></li>
             <li class="tab" onclick="loadInfo('${GlobalConstant.TEACH_CONDITION}','${sessionScope.currUser.orgFlow}');" style="cursor: pointer;"><a href="javascript:void(0);" >教学条件</a></li>
             <li class="tab" onclick="loadInfo('${GlobalConstant.ORG_MANAGE}','${sessionScope.currUser.orgFlow}');" style="cursor: pointer;"><a href="javascript:void(0);" >组织管理</a></li>
             <li class="tab" onclick="loadInfo('${GlobalConstant.SUPPORT_CONDITION}','${sessionScope.currUser.orgFlow}');" style="cursor: pointer;"><a href="javascript:void(0);" >支撑条件</a></li>
             <li class="tab" onclick="editTrainSpeInfo();" style="cursor: pointer;"><a href="javascript:void(0);" >专业基地</a></li>
             <li class="tab" onclick="coopBaseInfo();" style="cursor: pointer;"><a href="javascript:void(0);" >协同基地</a></li>
            <li class="tab" onclick="commuHospital();" style="cursor: pointer;"><a href="javascript:void(0);" >社区培训基地</a></li>
        </ul>
    </div>
</div>
<div class="main_bd" id="div_table_0" >
    <div id="hosContent">
    </div>
</div>
