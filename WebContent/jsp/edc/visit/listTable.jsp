<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@include file="/jsp/common/doctype.jsp" %>
<html>
<head>
<jsp:include page="/jsp/common/htmlhead.jsp">
	<jsp:param name="basic" value="true"/>
	<jsp:param name="jbox" value="true"/>
	<jsp:param name="jquery_form" value="false"/>
	<jsp:param name="jquery_ui_tooltip" value="true"/>
	<jsp:param name="jquery_ui_combobox" value="false"/>
	<jsp:param name="jquery_ui_sortable" value="false"/>
	<jsp:param name="jquery_cxselect" value="false"/>
	<jsp:param name="jquery_scrollTo" value="false"/>
	<jsp:param name="jquery_jcallout" value="false"/>
	<jsp:param name="jquery_validation" value="true"/>
	<jsp:param name="jquery_datePicker" value="true"/>
	<jsp:param name="jquery_fullcalendar" value="false"/>
	<jsp:param name="jquery_fngantt" value="false"/>
	<jsp:param name="jquery_fixedtableheader" value="true"/>
	<jsp:param name="jquery_placeholder" value="true"/>
	<jsp:param name="jquery_iealert" value="false"/>
	<jsp:param name="jquery_fixedtable" value="true"/>
</jsp:include>
</head>
<script type="text/javascript">
function edit(visitFlow){
	window.location.href="<s:url value='/edc/visit/edit'/>?visitFlow="+visitFlow;
}
function modifyVisitName(visitFlow,obj,oldValue){
	$(obj).addClass("edit");
	if(obj.value==oldValue){
		return;
	}
	var data = {
		"visitFlow":visitFlow,
		"visitName":obj.value
	};
	jboxPost( "<s:url value='/edc/visit/modifyVisitName'/>",data,null,null,true);
}
function selModule(){
	jboxOpen("<s:url value='/edc/design/sdtm'/>", "模块选择", 900, 600);
}
function selEleAttr(moduleCode){
	jboxOpen("<s:url value='/edc/design/selEleAttr'/>?&moduleCode="+moduleCode, "元素选择", 950, 600);
}
function changeStyle(obj){
	$(obj).removeClass("edit");
}
function selVisitModuleTd(visitFlow,moduleCode,moduleName,visitName){
	var t = visitFlow+"_"+moduleCode;
	var existFlag = $("#"+t).attr("existFlag");
	if(existFlag == "${GlobalConstant.FLAG_N}"){
		selVisitModule(visitFlow,moduleCode,moduleName,visitName);
	}
}
function selVisitModule(visitFlow,moduleCode,moduleName,visitName){
	var t = visitFlow+"_"+moduleCode;
	var existFlag = $("#"+t).attr("existFlag");
	 var  tip = (existFlag == "${GlobalConstant.FLAG_Y}"?"移除":"添加至"); 
	 jboxConfirm("确认将&nbsp;<b>"+moduleName+"</b>&nbsp;<font color='red'>"+tip+"</font>&nbsp;<b>"+visitName+"</b>&nbsp;？" , function(){
		 jboxGet("<s:url value='/edc/design/selVisitModule'/>?moduleCode="+moduleCode+"&visitFlow="+visitFlow,null,function(resp){
			if(resp  == "${GlobalConstant.SAVE_SUCCESSED}"){
				$("#"+visitFlow+"_"+moduleCode).attr("existFlag","${GlobalConstant.FLAG_Y}");
				//$("#"+t).find("img").stop().attr("src","<s:url value='/css/skin/${skinPath}/images/gou.gif'/>");
				$("#"+t).addClass("divPic");
				init();
			}else if(resp  == "${GlobalConstant.DELETE_SUCCESSED}"){
				$("#"+visitFlow+"_"+moduleCode).attr("existFlag","${GlobalConstant.FLAG_N}");
				//$("#"+t).find("img").stop().attr("src","");
				$("#"+t).removeClass("divPic");
				$("#"+t+"_div").hide();
			}				
		},null,true);	
	 });
}
function seleVisitEleAttr(visitFlow,moduleCode){
	jboxOpen("<s:url value='/edc/design/seleVisitEleAttr'/>?visitFlow="+visitFlow+"&moduleCode="+moduleCode, "元素选择", 900, 600);
}
$(document).ready(function(){
	init();
});
function init(){
	$(".visitModuleTd").hover(function() {
		if($(this).attr("existFlag") == "${GlobalConstant.FLAG_N}"){
			return;
		}
		$(this).find("div").stop().animate({left: "210", opacity:1}, "slow").css("display","block");
	},function(){
		$(this).find("div").stop().animate({left: "0", opacity: 0}, "slow");
	});
}
function preview(visitFlow){
	var mainIframe = window.parent.frames["mainIframe"];
	var width = mainIframe.document.body.scrollWidth;
	var height = mainIframe.document.body.scrollHeight;
	jboxOpen("<s:url value='/edc/visit/preview?visitFlow='/>"+visitFlow,"访视预览",width, height);
}
function designManage(moduleCode){
	var mainIframe = window.parent.frames["mainIframe"];
	var width = mainIframe.document.body.scrollWidth;
	var height = mainIframe.document.body.scrollHeight;
	jboxOpen("<s:url value='/edc/visit/designManage'/>?moduleCode="+moduleCode,"设计维护",width, height);
}

<c:if test="${fn:length(moduleList)>0}">
$(document).ready(function() {
    var Id = "tableDiv";
    var maintbheight = $('.mainright').height()-120;
    var maintbwidth = $('.mainright').width()-50;
    
    $("#" + Id + " .FixedTables").fixedTable({
        width: maintbwidth,
        height: maintbheight,
        fixedColumns: 1,
        classHeader: "fixedHead",
        classFooter: "fixedFoot",
        classColumn: "fixedColumn",
        fixedColumnWidth: 150,
        outerId: Id
        //Contentbackcolor: "#187BAF",
       	//Contenthovercolor: "#fbf8e9",
        //fixedColumnbackcolor:"#187BAF",
        //fixedColumnhovercolor:"#fbf8e9"
    });
});
</c:if>

function impAttrCode(){
	jboxConfirm("此操作将影响整个系统库，请谨慎操作，确定导入?",function(){
		jboxGet("<s:url value='/edc/visit/impAttrCode'/>",null,function(){
		},null,true);
	});
}

function exportEmptyCrf(){
	window.location.href="<s:url value='/edc/visit/exportEmptyCrf'/>?soureType=emptyCrf";
}
function crfDesign(){
	jboxLoad("tableDiv","<s:url value='/edc/visit/showVisit'/>",true);
}

</script>
<style>
.edit{background-color:#D0E3F2;text-align: center;border:none;}
.divPic{background-image: url('<s:url value='/css/skin/${skinPath}/images/gou.gif' />');background-repeat: no-repeat;background-position: center;}
</style>
<body>
<c:set var="designLock" value="${projParam.designLock ==  GlobalConstant.FLAG_Y ||  projParam.projLock ==  GlobalConstant.FLAG_Y}"/>
<div>		
	<c:if test="${projParam.designLock ==  GlobalConstant.FLAG_Y || projParam.projLock ==  GlobalConstant.FLAG_Y}"> 
		<div>
			&#12288;<font color="red">当前项目已锁定设计，无法修改!</font>
		</div>
	</c:if>
	<div>
		<input type="button" value="导出空CRF" class="search" onclick="exportEmptyCrf();"/>
		<input type="button" value="切换模式" class="search" onclick="crfDesign();" style="display: none"/> 
	</div>
<div id="tableDiv" class="title1 clearfix">
<table id="patientFixedTable" class="xllist FixedTables">
	<thead>
		<tr>
			<th style="width: 150px">
				<c:if test="${!designLock}"> 
					<a href="javascript:selModule();">评估程序</a>
				</c:if>
				<c:if test="${designLock}"> 
					评估程序
				</c:if>
			</th>
			<c:forEach items="${visitList }" var="visit">
			<th style="text-align: center"  valign="middle" title="${visit.visitName }">
				<!-- 
				<input type="text" onfocus="changeStyle(this);" class="edit" value="${visit.visitName }"  onblur="modifyVisitName('${visit.visitFlow}',this,'${visit.visitName }');"/>
				 -->
				${pdfn:cutString(visit.visitName,14,true,1)}
				 <c:if test="${!designLock}"> 
				<img title="预览" src="<s:url value='/css/skin/${skinPath}/images/search.gif'/>" style="float: right;cursor: pointer;" onclick="preview('${visit.visitFlow }');"> 
				</c:if>
			</th>
			</c:forEach>  
		</tr>
	</thead>
	<tbody>
	<c:forEach items="${moduleList }" var="module"> 
		<tr style="height: 20px">
		<td style="width: 150px"> 
			<c:if test="${!designLock}"> 
			<a href="javascript:designManage('${ module.moduleCode}');">${ module.moduleName}</a>
	  		</c:if>
	  		<c:if test="${designLock}"> 
	  			${ module.moduleName}
	  		</c:if>
	   </td>
			<c:forEach items="${visitList }" var="visit">
			<c:set var="key" value="${visit.visitFlow }_${module.moduleCode }"/>
			<c:set var="existFlag" value="${!empty existMap[key]?GlobalConstant.FLAG_Y:GlobalConstant.FLAG_N }"/>
			<td class="visitModuleTd <c:if test="${existFlag eq  GlobalConstant.FLAG_Y}">divPic</c:if>" 
			<c:if test="${!designLock}">
			 onclick="selVisitModuleTd('${visit.visitFlow }','${module.moduleCode}','${module.moduleName}','${visit.visitName}');" 
			 </c:if>
			 existFlag="${existFlag }" id="${key}" >
			 <div style="width:220px;">
				<c:if test="${!designLock}"> 
				<div style="display:none ;vertical-align: middle;float: right" id="${key }_div"><a href="javascript:seleVisitEleAttr('${visit.visitFlow}','${ module.moduleCode}');">[编辑]</a><a href="javascript:selVisitModule('${visit.visitFlow }','${module.moduleCode}','${module.moduleName}','${visit.visitName}');">[移除]</a></div>
				</c:if>
				</div>
			</td>  
			</c:forEach>
		</tr>
	</c:forEach>
	</tbody>
	<c:if test="${moduleList == null || moduleList.size()==0 }"> 
		<tr> 
			<c:set var="visitNum" value="${visitList == null?0:visitList.size() }"></c:set>
			<td align="center" colspan="${visitNum+1 }">无记录</td>
		</tr>
	</c:if>
</table></div>
</div>
</body></html>
