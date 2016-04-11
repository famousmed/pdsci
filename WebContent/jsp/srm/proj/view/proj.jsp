<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>
<%@include file="/jsp/common/doctype.jsp" %>
<html>
<head>
<jsp:include page="/jsp/common/htmlhead.jsp">
	<jsp:param name="basic" value="true"/>
	<jsp:param name="jbox" value="true"/>
	<jsp:param name="jquery_ui_tooltip" value="true"/>
	<jsp:param name="jquery_datePicker" value="true"/>
</jsp:include>
<script type="text/javascript">
	$(function(){
		$('#content').load("<s:url value='/srm/proj/mine/view?projFlow=${param.projFlow}&recTypeId=${param.recTypeId}&recFlow=${param.recFlow}'/>");
	});
	
	function loadContent(projFlow , recTypeId , recFlow , obj){
		change_bg(obj);
		var url = "<s:url value='/srm/proj/mine/view?projFlow='/>"+projFlow+'&recTypeId='+recTypeId+'&recFlow='+recFlow;
		
		jboxGet(url , null , function(data){
			$('#content').html(data);
		}, null , false);
	}
	
	function back() {
		history.back();
	}
	
	 function change_bg(obj){
		$(obj).parent('li').siblings().removeClass().addClass('pro');
		$(obj).parent('li').removeClass().addClass('pro_h');
	
	 }
	 
	 function printRec(watermarkFlag){
		 var currLi = $('#menu li[class="pro_h"]');
		 var id = currLi.attr('id');
		 if(id){
			 if(id=="projInfo"){
				 jboxTip('“基本信息”不需要打印，请选择页面上方其他需要打印的表单信息');
				 return false;
			 }
			 var datas = id.split("_");
			 jboxGet("<s:url value='/srm/proj/print/existsPrint'/>?projFlow="+datas[0]+"&recFlow="+datas[1]+"&watermarkFlag="+watermarkFlag , null , function(resp){
				 if("Y"==resp){
					 var url = "<s:url value='/srm/proj/print/info'/>";
					 url+="?projFlow="+datas[0]+"&recFlow="+datas[1]+"&watermarkFlag="+watermarkFlag;
					 //$('body').append('<iframe name="down" id="down"></iframe>');
					 //document.getElementById('iframeId').contentWindow.
					 //jboxOpen(url , "下载" , 300 , 200);
					 window.location.href=url;
					 //jboxStartLoading();
					 //alert(url);
					 //$.fileDownload(url).done(function () { alert('File download a success!'); }).fail(function () { alert('File download failed!'); });
				    //return false; //this is critical to stop the click event which will trigger a normal file download
				 }else if("N"==resp){
					 jboxTip("不支持打印");
				 }else if("F"==resp){
					 jboxTip("审核中,暂不支持正式稿打印");
				 }
			 } , null , false);
			
		 }else{
			 jboxTip('不支持打印');
		 }
		
	 }
</script>

</head>
<body>
 <div class="basic_title">
	<span>
		<c:choose>
			<c:when test="${sessionScope.projCateScope==projCategroyEnumXk.id}">学科名称：</c:when>
			<c:when test="${sessionScope.projCateScope==projCategroyEnumRc.id}">人才名称：</c:when>
			<c:otherwise>项目名称：</c:otherwise>
		</c:choose>${proj.projName}
	</span>
    <span>
    	<c:choose>
			<c:when test="${sessionScope.projCateScope==projCategroyEnumXk.id}">学科类型：</c:when>
			<c:when test="${sessionScope.projCateScope==projCategroyEnumRc.id}">人才类型：</c:when>
			<c:otherwise>项目类型：</c:otherwise>
		</c:choose>：${proj.projTypeName}
	</span>
</div>
<div class="project">
  <ul id='menu'>
        <li id="projInfo"
        	<c:choose>
        		<c:when test='${empty param.recTypeId and empty param.recFlow}'>class="pro_h"</c:when>
        		<c:otherwise>class="pro"</c:otherwise>
        	</c:choose>
        >
        	<a  href="javascript:void(0);" onclick="loadContent('${param.projFlow}' , '' , '' , this)">基本信息</a>
        </li>
        <c:forEach items="${recList}" var="rec">
        	<c:if test='${projRecTypeEnumSetUp.id != rec.recTypeId}'>
				<li id="${rec.projFlow}_${rec.recFlow}"
					<c:if test='${rec.recFlow eq param.recFlow}'>class='pro_h'</c:if>
					<c:if test='${empty param.recFlow and rec.recTypeId eq param.recTypeId}'>class='pro_h'</c:if> 
					<c:if test='${not rec.recFlow eq param.recFlow}'>class='pro'</c:if> >
					<a href="javascript:void(0);" onclick="loadContent('${param.projFlow}' , '${rec.recTypeId}' , '${rec.recFlow}' , this)">${rec.recTypeName}&nbsp;${pdfn:transDateForPattern(rec.createTime , "yy/MM/dd")}</a>
				</li>
			</c:if>
		</c:forEach>
    </ul>
    <div class="print">
    	<table border="0" style="margin-top:10px;">
    		<tr>
    			<td style="padding-right:20px;"><img class="img_print" title="打印草稿" style="cursor: pointer;" src="<s:url value='/css/skin/${skinPath}/images/printCaogao.png'/>" onclick="printRec('${GlobalConstant.FLAG_N}');"/></td>
    			<td><img class="img_print" title="打印正式稿,点击“正式稿”图标后，请对生成的正式稿文档样式进行确认、调整" style="cursor: pointer;" src="<s:url value='/css/skin/${skinPath}/images/printZhengshi.png'/>" onclick="printRec('${GlobalConstant.FLAG_Y}');"/></td>
    		</tr>
    	</table>
    </div>
</div>
<div class='basic_fix' >
<div id='main'>
	<div id='content' style="width:95%; margin:0 auto;" >

	</div>
	
</div>
</div>
</body>
</html>