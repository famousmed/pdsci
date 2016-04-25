<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@include file="/jsp/common/doctype.jsp"%>
<html>
<head>
<title>${msg.infoTitle}</title>
<style type="text/css">
	
body{ font-family: "Microsoft YaHei";color:#222;font-size:14px;background-color:#fff;}
body, h1, h2, h3, h4, h5, h6, p, ul, ol, dl, dd, fieldset, textarea{margin:0;}
div{display:block;}



/*系统公告------------添加----------*/
.notice{ margin:20px auto; max-width:1200px;}
.notice h1{ text-align:center; font-weight:normal; font-size:18px; margin-bottom:48px;}
.notice h2{text-align:left; font-size:16px; margin-top:25px; margin-bottom:25px;}
.notice p{ margin:10px 0;}
.notice_date{ text-align:right; margin-top:30px; display:block;}

/*--header--*/
.header {width: 100%;}
.top {width: 100%;height: 45px;background: url(<s:url value='/css/skin/${skinPath}/images/header.png'/>) repeat;}
.tleft {float: left;}
.tleft img {padding-left: 27px;padding-top: 6px;}
 
/*--footer--------------添加----------*/
.footer{ height:40px; min-width:1200px; width:100%; line-height:40px; background-color:#b8b9b9; color:#fff; border-top:1px solid #a4a4a4; position:absolute; bottom:0; text-align:center; }

/*--basic--body-------------添加-----------*/
.wrapper{ background:#fff; width:100%; position:absolute; top:70px; bottom:41px; overflow-y:auto; overflow-x:hidden;}
	
</style>
</head>

<body>
  <div class="header">
    <div class="top">
     <p class="tleft"><img src="<s:url value='/css/skin/${skinPath}/images/${applicationScope.sysCfgMap["sys_login_img"]}_head.png'/>" /></p>
    </div>
  </div>
  
  <div class="wrapper"> 
       <div class="notice">
        <h1>${msg.infoTitle}</h1>
        ${msg.infoContent}
        <span class="notice_date">
        <p>${pdfn:transDate(msg.infoTime)}</p>
        </span>
      </div>
  </div>
  
  <div class="footer">
  技术支持：江苏法迈生医学科技有限公司
  </div>
<div class="mainright">
	<div class="content">
		<!-- <h1>${msg.infoTitle }</h1> -->
        <div style="margin: 10px;">
        	
        </div>
      </div>
   </div>
</body>
</html>
