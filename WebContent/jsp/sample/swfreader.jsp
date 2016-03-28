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
		<jsp:param name="jquery_fullcalendar" value="false"/>
		<jsp:param name="jquery_fixedtableheader" value="true"/>
		<jsp:param name="jquery_placeholder" value="true"/>
		<jsp:param name="jquery_iealert" value="false"/>
		<jsp:param name="swfobject" value="true"/>
	</jsp:include>
       <style type="text/css" media="screen"> 
             html, body    { height:100%; } 
             body { margin:0; padding:0; overflow:auto; }  
           #flashContent { display:none; }
		</style> 
       
        <script type="text/javascript"> 
			 var swfVersionStr = "10.0.0";
			 var xiSwfUrlStr = "<s:url value='/js/swfobject/playerProductInstall.swf'/>";//swfobject/playerProductInstall.swf  固定的辅助文件
			 var swfFile = "<s:url value='/jsp/sample/111.swf'/>";//这填写文档转换成的flash文件的路径           
			 var flashvars = { 
					SwfFile : escape(swfFile),
					Scale : 1.5, 
					ZoomTransition : "easeOut",
					ZoomTime : 0.5,
                    ZoomInterval : 0.1,
                    FitPageOnLoad : true,
                    FitWidthOnLoad : true,
					PrintEnabled : false,
                    FullScreenAsMaxWindow : false,
                    ProgressiveLoading : true,
                    PrintToolsVisible : false,
                    ViewModeToolsVisible : true,
                    ZoomToolsVisible : true,
                    FullScreenVisible : true,
                    NavToolsVisible : true,
                    CursorToolsVisible : true,
                    SearchToolsVisible : true,
					localeChain: "zh_CN"
                   };
			 var params = { }
					params.quality = "high";
					params.bgcolor = "#ffffff";
					params.allowscriptaccess = "sameDomain";
					params.allowfullscreen = "true";
			 var attributes = {};
					attributes.id = "FlexPaperViewer";
					attributes.name = "FlexPaperViewer";
					swfobject.embedSWF("<s:url value='/js/swfobject/FlexPaperViewer.swf'/>", "flashContent","800", "800",//swfobject/FlexPaperViewer.swf  固定的辅助文件  flashContent 显示在哪里的id  900宽  600 高
					swfVersionStr, xiSwfUrlStr, 
					flashvars, params, attributes);
					swfobject.createCSS("#flashContent", "display:block;text-align:left;");
 </script>
  </head> 
    <body> 
         <div align="center">
             <div id="flashContent"> 
             </div>
       </div>
   </body>
 </html> 