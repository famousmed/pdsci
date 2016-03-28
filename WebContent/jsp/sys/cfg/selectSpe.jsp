<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@include file="/jsp/common/doctype.jsp" %>
<html>
<head>
<jsp:include page="/jsp/common/htmlhead.jsp">
	<jsp:param name="basic" value="true"/>
	<jsp:param name="jbox" value="true"/>
	<jsp:param name="jquery_form" value="true"/>
	<jsp:param name="jquery_validation" value="true"/>
</jsp:include>
<script type="text/javascript">
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
function saveTrainSpe(cfgCode){
	var info="";
 	var fields = $("input:checked").serializeArray();
	jQuery.each( fields, function(i, field){
		  info+=field.value + ",";
	}); 
	result=info.substring(0,info.length-1);
	var data={
		"result":result,
		"cfgCode":cfgCode
	};
	
	var url = "<s:url value='/sys/cfg/saveTrainSpe'/>";
	jboxPost(url , data , function(resp){
		if(GlobalConstant.SAVE_SUCCESSED==resp){
// 			setTimeout(function(){
// 			}
		}
	} , null , true);
}
</script>
</head>
<body>
    <ul class="search_table" style="width: 100%;margin: 0px;padding: 0px;">
        <li class="score_frame">
            <h1 >基地培训专业管理  <span style="float: right;"><input type="checkbox" onclick=" choose();"name="choose" />全选 </span></h1>
            	<c:forEach items="${trainCategoryEnumList}" var="trainCategory" varStatus="status">
				<c:if test="${trainCategory.typeId eq param.trainCategoryType}">
				<c:set var="dictName" value="dictTypeEnum${trainCategory.id}List" />
				<table border="0" cellpadding="0" cellspacing="0" class="basic" style="border: 0; width: 100%" >
                	<tr>
                		<th style="width: 20%;text-align: center;font-size: 14px;">${trainCategory.name}</th>
                		<td style="width: 80%;">
                			<ul>
						        <c:forEach items="${applicationScope[dictName]}" var="dict">
					        		<c:set var="speMapKey" value="${trainCategory.id}${dict.dictId}"/>
						            <li style="width: 220px;float: left;line-height: 25px; font-size: 14px;" >
						            	<input type="checkbox" id="${trainCategory.id}_${dict.dictId}" name="speId" value="${trainCategory.id}:${dict.dictId}" <c:if  test="${rbsMap[speMapKey]!=null}">checked="checked"</c:if>/>
						            	<label for="${trainCategory.id}_${dict.dictId }">${dict.dictName}</label>
					                </li>
								</c:forEach>
							</ul>
                		</td>
                	</tr>
                </table>
			</c:if>
		</c:forEach>
        </li>
    </ul>
    <p style="text-align: center;">
		<input class="btn_blue" onclick="saveTrainSpe('${param.cfgCode}')" type="button" value="保存"/>
	</p>
</body>

