<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
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
</jsp:include>

<style type="text/css">
@charset "utf-8";
*{margin:0;padding:0;-webkit-text-size-adjust:none;}
body{background:#fff;font-size:12px;color:#555;font-family:Tahoma,"微软雅黑", Geneva, sans-serif;background:#f5f5f5;}
a{color:#555;text-decoration:none;}
a:hover{color:#c00;text-decoration:underline;}
img{border:none;}

li{list-style:none;}
.clearfix:after {visibility: hidden;display: block;font-size: 0;content: " ";clear: both;height: 0;}
* html .clearfix             {zoom: 1;} /* IE6 */
*:first-child+html .clearfix {zoom: 1;} /* IE7 */




.w1100{width:1100px;margin:0 auto;}
.s-mod{margin:20px auto 0;position:relative;}
.s-mod-loding{text-align:center;}
.s-mod ul{display:none;}
.s-mod-item{display:block;position:absolute;}
.s-mod-wrap{position:relative;overflow:hidden;}
.s-mod-def{position:absolute;left:0;top:0;z-index:1;padding:0 12px;color:#fff;font-size:18px;line-height:25px;text-align:center;cursor: pointer;}
.s-mod-def span{display:block;}
.s-mod-cur{position:absolute;left:0;top:0;z-index:2;padding:0 12px;color:#fff;font-size:18px;line-height:25px;text-align:center;cursor: pointer;}
.s-mod-cur span{display:block;}
</style>
<script type="text/javascript">
$(function(){
	$(".s-mod ul").fadeIn(300,function(){$(".s-mod .s-mod-loding").remove();})	
	$(".s-mod ul .s-mod-item").each(function(){
		var i=$(this);
		var o={
			w:1*i.attr("w"),
			h:1*i.attr("h"),
			l:1*i.attr("l"),
			t:1*i.attr("t"),
			bg:i.attr("bg"),
			cbg:i.attr("cbg"),
			speed:600
		};
		var wrap=i.find(".s-mod-wrap");
		var def=i.find(".s-mod-def");
		var cur=i.find(".s-mod-cur");
		i.css({width:o.w,height:o.h,left:o.l,top:o.t});
		wrap.css({width:o.w,height:o.h});
		def.css({width:(o.w-24),height:o.h,backgroundColor:o.bg});
		cur.css({width:(o.w-24),height:o.h,backgroundColor:o.cbg,top:o.h});
		
		def.find("span").css({paddingTop:((o.h-def.find("span").height())/2)})
		cur.find("span").css({paddingTop:((o.h-cur.find("span").height())/2)})
		
		//婊戝姩鏁堟灉
		i.hover(function(){
			def.stop().animate({top:-o.h},o.speed,"easeOutBounce")
			cur.stop().animate({top:0},o.speed,"easeOutBounce")
		},function(){
			def.stop().animate({top:0},o.speed,"easeOutBounce")
			cur.stop().animate({top:o.h},o.speed,"easeOutBounce")
		})
	})
})
</script>
</head>

<body>
<div id="register">
<div id="logo"><img src="<s:url value='/css/skin/${skinPath}/images/${applicationScope.sysCfgMap["sys_login_img"]}_head.png'/>" /></div>
<%-- <div id="logo"><img src="<s:url value='/css/skin/${skinPath}/images/nj_sta.png' />" /></div> --%>
<div style="height:80px"></div>
<div class="s-mod w1100" style="height:410px">
	<ul>
		<li class="s-mod-item" w="266" h="127" l="0" t="0" bg="#e8443a" cbg="#d92e24" onclick="window.location.href='<s:url value='/main/srm' />'">
			<div class="s-mod-wrap">
				<div class="s-mod-def"><span>科研项目管理子系统</span></div>
				<div class="s-mod-cur"><span>科研项目管理子系统</span></div>
			</div>
		</li>
		<li class="s-mod-item" w="266" h="127" l="278" t="0" bg="#aa5096" cbg="#922a7b" onclick="window.location.href='<s:url value='/main/irb' />'">
			<div class="s-mod-wrap">
				<div class="s-mod-def"><span>伦理审查管理子系统</span></div>
				<div class="s-mod-cur"><span>伦理审查管理子系统</span></div>
			</div>
		</li>
		<li class="s-mod-item" w="127" h="266" l="556" t="0" bg="#1CA1E2" cbg="#1182BA" onclick="window.location.href='<s:url value='/main/aem' />'">
			<div class="s-mod-wrap">
				<div class="s-mod-def"><span>动物实验管理子系统</span></div>
				<div class="s-mod-cur"><span>动物实验管理子系统</span></div>
			</div>
		</li>
		<li class="s-mod-item" w="127" h="127" l="973" t="0" bg="#FFD302" cbg="#EAC203">
			<div class="s-mod-wrap">
				<div class="s-mod-def"><span>系统管理模块</span></div>
				<div class="s-mod-cur"><span>系统管理模块</span></div>
			</div>
		</li>
		<li class="s-mod-item" w="127" h="127" l="0" t="139" bg="#9B4C13" cbg="#8F4108">
			<div class="s-mod-wrap">
				<div class="s-mod-def"><span>重点学科管理子系统</span></div>
				<div class="s-mod-cur"><span>重点学科管理子系统</span></div>
			</div>
		</li>
		<li class="s-mod-item" w="266" h="127" l="695" t="0" bg="#0C6DB2" cbg="#09578E" onclick="window.open('http://localhost:9000/Default.aspx?UserID=admin&PassWord=123456&Type=Admin&RoleID=30')">
			<div class="s-mod-wrap">
				<div class="s-mod-def"><span>住院医师管理子系统</span></div>
				<div class="s-mod-cur"><span>住院医师管理子系统</span></div>
			</div>
		</li>
		<li class="s-mod-item" w="127" h="127" l="139" t="139" bg="#8DC027" cbg="#76A31B">
			<div class="s-mod-wrap">
				<div class="s-mod-def"><span>重点人才管理子系统</span></div>
				<div class="s-mod-cur"><span>重点人才管理子系统</span></div>
			</div>
		</li>
		<li class="s-mod-item" w="266" h="127" l="278" t="139" bg="#FF0198" cbg="#D80683" onclick="window.location.href='<s:url value='/main/edc' />'">
			<div class="s-mod-wrap">
				<div class="s-mod-def"><span>E-CRF管理子系统</span></div>
				<div class="s-mod-cur"><span>E-CRF管理子系统</span></div>
			</div>
		</li>
		<li class="s-mod-item" w="127" h="127" l="973" t="139" bg="#2b7ab7" cbg="#1e669d">
			<div class="s-mod-wrap">
				<div class="s-mod-def"><span>基础信息模块</span></div>
				<div class="s-mod-cur"><span>基础信息模块</span></div>
			</div>
		</li>
		<li class="s-mod-item" w="266" h="127" l="695" t="139" bg="#4837cd" cbg="#3c2bb7" onclick="window.open('http://localhost:9500/Plugin/CME.WebSite/Index.aspx')">
			<div class="s-mod-wrap">
				<div class="s-mod-def"><span>继续教育管理子系统</span></div>
				<div class="s-mod-cur"><span>继续教育管理子系统</span></div>
			</div>
		</li>
		<!-- 
		<li class="s-mod-item" w="127" h="266" l="0" t="278" bg="#33ac5b" cbg="#209747">
			<div class="s-mod-wrap">
				<div class="s-mod-def"><span>9.流量统计管理模块</span></div>
				<div class="s-mod-cur"><span>集成第三方提供的网站流量统计系统，通过统计可以可看网站的访问量，以及互联网品牌指数。</span></div>
			</div>
		</li>
		<li class="s-mod-item" w="266" h="127" l="139" t="278" bg="#bf7030" cbg="#ae6021">
			<div class="s-mod-wrap">
				<div class="s-mod-def"><span>10.新闻资讯管理模块</span></div>
				<div class="s-mod-cur"><span>不限层级添加新闻资讯类别，可自主管理公司简介、公司新闻、产品新闻、行业知识等。在后台进行增、删、查、改等一系列操作。</span></div>
			</div>
		</li> -->
		<!-- <li class="s-mod-item" w="127" h="266" l="417" t="278" bg="#914ae2" cbg="#7d33d0">
			<div class="s-mod-wrap">
				<div class="s-mod-def"><span>11.在线咨询管理模块</span></div>
				<div class="s-mod-cur"><span>实现网站前台页面提交咨询内容及联系方式，后台查询咨询内容及咨询人情况，并进行在线咨询的回复，前台页面自动显示。</span></div>
			</div>
		</li>
		<li class="s-mod-item" w="266" h="266" l="556" t="278" bg="#e42ec4" cbg="#cf19af">
			<div class="s-mod-wrap">
				<div class="s-mod-def"><span>12.会员中心管理模块</span></div>
				<div class="s-mod-cur"><span>实现会员填写字段注册，对填写内容进行有效性校验。 根据注册信息的用户名、密码、验证码进行会员登陆。 对会员注册的基本资料进行查看、修改。 管理会员注册信息、会员列表，建立会员等级权限组，分配会员至权限组，然后根据权限使用网站的其它各个功能模块。</span></div>
			</div>
		</li>
		<li class="s-mod-item" w="266" h="127" l="834" t="278" bg="#4392ec" cbg="#206fc8">
			<div class="s-mod-wrap">
				<div class="s-mod-def"><span>13.友情链接管理模块</span></div>
				<div class="s-mod-cur"><span>与客户网站交换文字链接、图片链接均可，通过链接提升网站的PR值，有利于SEO优化排名。</span></div>
			</div>
		</li>
		<li class="s-mod-item" w="127" h="127" l="139" t="417" bg="#20c8a6" cbg="#13af90">
			<div class="s-mod-wrap">
				<div class="s-mod-def"><span>14.会员管理模块</span></div>
				<div class="s-mod-cur"><span>会员短信、邮箱校验模,块 会员短信、邮箱验模块,密码问题保护模块,红包推,广管理模块 ,会员API接口.</span></div>
			</div>
		</li>
		<li class="s-mod-item" w="127" h="127" l="834" t="417" bg="#a3ca1d" cbg="#8bb00c">
			<div class="s-mod-wrap">
				<div class="s-mod-def"><span>15.订单管理模块</span></div>
				<div class="s-mod-cur"><span>订单管理模块</span></div>
			</div>
		</li> -->
		<!-- <li class="s-mod-item" w="266" h="127" l="0" t="556" bg="#d8493a" cbg="#ba3122">
			<div class="s-mod-wrap">
				<div class="s-mod-def"><span>16.订单管理模块</span></div>
				<div class="s-mod-cur"><span>订单管理模块</span></div>
			</div>
		</li>
		<li class="s-mod-item" w="127" h="266" l="278" t="417" bg="#c44a8c" cbg="#b72b77">
			<div class="s-mod-wrap">
				<div class="s-mod-def"><span>17.订单管理模块</span></div>
				<div class="s-mod-cur"><span>订单管理模块</span></div>
			</div>
		</li>
		<li class="s-mod-item" w="266" h="127" l="417" t="556" bg="#8e48f7" cbg="#7026df">
			<div class="s-mod-wrap">
				<div class="s-mod-def"><span>18.订单管理模块</span></div>
				<div class="s-mod-cur"><span>订单管理模块</span></div>
			</div>
		</li>
		<li class="s-mod-item" w="127" h="127" l="695" t="556" bg="#7a92c2" cbg="#5876b2">
			<div class="s-mod-wrap">
				<div class="s-mod-def"><span>18.订单管理模块</span></div>
				<div class="s-mod-cur"><span>订单管理模块</span></div>
			</div>
		</li>
		<li class="s-mod-item" w="127" h="127" l="834" t="556" bg="#7f9861" cbg="#658242">
			<div class="s-mod-wrap">
				<div class="s-mod-def"><span>18.订单管理模块</span></div>
				<div class="s-mod-cur"><span>订单管理模块</span></div>
			</div>
		</li>
		<li class="s-mod-item" w="127" h="266" l="973" t="417" bg="#876f5a" cbg="#755a41">
			<div class="s-mod-wrap">
				<div class="s-mod-def"><span>18.订单管理模块</span></div>
				<div class="s-mod-cur"><span>订单管理模块</span></div>
			</div>
		</li> -->
	</ul>
</div>
<div id="footer">技术支持：南京品德信息技术有限公司<br />Copyright © 2001- 2014 Character Technology, Inc. All rights reserved.</div>
</div>
</body>
</html>