<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>
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
	<jsp:param name="jquery_scrollTo" value="true"/>
	<jsp:param name="jquery_jcallout" value="false"/>
	<jsp:param name="jquery_validation" value="true"/>
	<jsp:param name="jquery_datePicker" value="true"/>
	<jsp:param name="jquery_fullcalendar" value="false"/>
	<jsp:param name="jquery_fngantt" value="false"/>
	<jsp:param name="jquery_fixedtableheader" value="true"/>
	<jsp:param name="jquery_placeholder" value="true"/>
	<jsp:param name="jquery_iealert" value="false"/>
	<jsp:param name="jquery_ztree" value="true"/>
</jsp:include>
<script type="text/javascript">
function initUEditer(id){
	if($("#"+id)){
		var ue = UE.getEditor(id, {
			initialFrameWidth:'100%',  //初始化编辑器宽度,默认1000
			autoFloatEnabled:false,
			elementPathEnabled:false,
			catchRemoteImageEnable:false,
		    autoHeight: false,
		    imagePath: '${sysCfgMap['upload_base_url']}/',
		    imageManagerPath: '${sysCfgMap['upload_base_url']}/',
		    filePath: '${sysCfgMap['upload_base_url']}/',
		    videoPath: '${sysCfgMap['upload_base_url']}/',
		    wordImagePath: '${sysCfgMap['upload_base_url']}/',
		    snapscreenPath: '${sysCfgMap['upload_base_url']}/',
		    catcherPath: '${sysCfgMap['upload_base_url']}/',
		    scrawlPath: '${sysCfgMap['upload_base_url']}/',
		    toolbars:[
		                [/* 'fullscreen' */, /*'source',*/ '|', 'undo', 'redo', '|','lineheight',
		                    'bold', 'italic', 'underline', 'fontborder', /* 'strikethrough', */ /*'superscript', 'subscript', 'removeformat', 'formatmatch', 'autotypeset', 'blockquote', 'pasteplain', '|', 'forecolor', 'backcolor', 'insertorderedlist', 'insertunorderedlist', 'selectall', 'cleardoc', '|',*/
		                    /* 'rowspacingtop', 'rowspacingbottom', 'lineheight', '|',
		                    'customstyle', 'paragraph', */ 'fontfamily', 'fontsize', '|',
		                    /* 'directionalityltr', 'directionalityrtl', 'indent', '|',*/ 
		                    'justifyleft', 'justifycenter', 'justifyright', 'justifyjustify', '|', 'touppercase', 'tolowercase', '|',
		                    /* 'link', 'unlink', 'anchor', '|', 'imagenone', 'imageleft', 'imageright', 'imagecenter', '|', */
		                    'insertimage', /* 'emotion','scrawl', 'insertvideo', 'music', 'attachment'*/, /*'map', 'gmap', 'insertframe','insertcode', 'webapp', 'pagebreak',*/ /*'template', 'background'*/, '|',
		                    /* 'horizontal', 'date', 'time', 'spechars', 'snapscreen',  'wordimage', '|',*/
		                    /*'inserttable', 'deletetable', 'insertparagraphbeforetable', 'insertrow', 'deleterow', 'insertcol', 'deletecol', 'mergecells', 'mergeright', 'mergedown', 'splittocells', 'splittorows', 'splittocols', 'charts', '|'*/,
		                    /*'print'*/,  'preview', /*'searchreplace', 'help' */, /*'drafts'*/'wordimage']
		            ]
		    ,initialStyle:'body{font-family: SimSun; font-size:14px}'
		});//实例化编辑器
		ue.addListener( 'ready', function( editor ) {
			ue.execCommand('FontSize', "14px");
			ue.execCommand( 'fontfamily' , "宋体");
		 } );
		
		ue.addListener('beforepaste', function(o , html){
			var ht = html.html;
			var dv = document.createElement("div");
			$(dv).html(ht);
			$(dv).find("span").css("font-size","14px").css("font-family" , "宋体").css('line-height' , '150%');
			html.html=$(dv).html();
		}); 
		
		return ue;
	}
}


	function doBack(){
		jboxConfirm("确认返回项目主界面?返回前请保存当前数据!",function(){
			window.location.href="<s:url value='/srm/proj/mine/process?projFlow=${proj.projFlow}'/>";
		});
	}
	
	function getIframeDocument(element) {
	    return  element.contentDocument || element.contentWindow.document;
	}
	
	function checkImg(ues){
		var flag = 1;
		if(ues){
			for(var j=0 ; j<ues.length;j++){
				var uedoc = getIframeDocument(document.getElementById("ueditor_"+j));
				var imgs = UE.dom.domUtils.getElementsByTagName(uedoc.body , 'img');
				for(var i=0;i<imgs.length;i++){
					var img = imgs[i];
					var w = $(img).css('width')!='0px'?$(img).css('width'):img.width;
					var h = $(img).css('height')!='0px'?$(imgs).css('height'):img.height;
					w = parseInt(w);
					h = parseInt(h);
					if(w<500 && h<835){
						flag = 1;
					}
					if(w>500 || h>835){
						jboxConfirm('请缩小图片 , 最大宽度500 , 最大高度800' , function(){
							var range = new UE.dom.Range(uedoc);
							range = range.selectNode(img).select();
							$(".mainright").scrollTo('#ueditor_'+j , 500);
						});
					    return 0;
					}
				}
			}
		}
		return flag;
		
	}
	
</script>

</head>
<body>
<div id="main" >
	<div class="mainright">
        <div class="content">
            <div class="title1 clearfix" >
	            <p>
	    	        <b>
						<c:choose>
							<c:when test="${sessionScope.projCateScope==projCategroyEnumXk.id}">学科名称：</c:when>
							<c:when test="${sessionScope.projCateScope==projCategroyEnumRc.id}">人才名称：</c:when>
							<c:otherwise>项目名称：</c:otherwise>
						</c:choose>
	    	       </b><a style="color: blue"  href="javascript:doBack();">${proj.projName}</a>&#12288;&#12288;
	    	        <b>
	    	        	<c:choose>
							<c:when test="${sessionScope.projCateScope==projCategroyEnumXk.id}">学科类型：</c:when>
							<c:when test="${sessionScope.projCateScope==projCategroyEnumRc.id}">人才类型：</c:when>
							<c:otherwise>项目类型：</c:otherwise>
						</c:choose>
	    	        </b>${proj.projTypeName}&#12288;&#12288; <br/>
	            </p>
	        </div>
	        
	        <c:if test='${proj.projTypeId eq "szwsj.qnkj"}'>
	            <c:if test='${param.recTypeId eq projRecTypeEnumApply.id}'>
	                <jsp:include page="apply/szwsj.qnkj/menu.jsp"></jsp:include>
        	    </c:if>
        	    <c:if test='${param.recTypeId eq projRecTypeEnumContract.id}'>
	               <jsp:include page="contract/szwsj.qnkj/menu.jsp"></jsp:include>
        	    </c:if>
        	    <c:if test='${param.recTypeId eq projRecTypeEnumChangeReport.id}'>
	               <jsp:include page="change/product/menu.jsp"></jsp:include>
        	    </c:if>
        	    <c:if test='${param.recTypeId eq projRecTypeEnumScheduleReport.id}'>
	               <jsp:include page="schedule/product/menu.jsp"></jsp:include>
        	    </c:if>
        	    <c:if test='${param.recTypeId eq projRecTypeEnumCompleteReport.id}'>
	               <jsp:include page="complete/product/menu.jsp"></jsp:include>
        	    </c:if>
        	    <c:if test='${param.recTypeId eq projRecTypeEnumTerminateReport.id}'>
	               <jsp:include page="terminate/product/menu.jsp"></jsp:include>
        	    </c:if>
        	</c:if>
        	<c:if test='${proj.projTypeId eq "szwsj.lczcbzzljs"}'>
        	    <c:if test='${param.recTypeId eq projRecTypeEnumApply.id}'>
        	        <jsp:include page="apply/szwsj.lczcbzzljs/menu.jsp"></jsp:include>
        	    </c:if>
        	    <c:if test='${param.recTypeId eq projRecTypeEnumContract.id}'>
	               <jsp:include page="contract/szwsj.lczcbzzljs/menu.jsp"></jsp:include>
        	    </c:if>
        	     <c:if test='${param.recTypeId eq projRecTypeEnumChangeReport.id}'>
	               <jsp:include page="change/product/menu.jsp"></jsp:include>
        	    </c:if>
        	    <c:if test='${param.recTypeId eq projRecTypeEnumScheduleReport.id}'>
	               <jsp:include page="schedule/product/menu.jsp"></jsp:include>
        	    </c:if>
        	    <c:if test='${param.recTypeId eq projRecTypeEnumCompleteReport.id}'>
	               <jsp:include page="complete/product/menu.jsp"></jsp:include>
        	    </c:if>
        	    <c:if test='${param.recTypeId eq projRecTypeEnumTerminateReport.id}'>
	               <jsp:include page="terminate/product/menu.jsp"></jsp:include>
        	    </c:if>
        	</c:if>
        	<c:if test='${proj.projTypeId eq "szwsj.yxxjs"}'>
        	    <c:if test='${param.recTypeId eq projRecTypeEnumApply.id}'>
        	        <jsp:include page="apply/szwsj.yxxjs/menu.jsp"></jsp:include>
                </c:if>
        	</c:if>
        	<c:if test='${proj.projTypeId eq "wxwsj.zdxm"}'>
        	    <%-- <c:if test='${param.recTypeId eq projRecTypeEnumApply.id}'>
        	        <jsp:include page="apply/wxwsj.zdxm/menu.jsp"></jsp:include>
                </c:if>
                <c:if test='${param.recTypeId eq projRecTypeEnumContract.id}'>
	               <jsp:include page="contract/wxwsj.zdxm/menu.jsp"></jsp:include>
        	    </c:if> --%>
        	</c:if>
            <jsp:include page="/jsp/${jspPath}.jsp" flush="true"/>
	    </div>
    </div>
</div>
</body>
</html>