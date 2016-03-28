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
		<jsp:param name="jquery_validation" value="false"/>
		<jsp:param name="jquery_datePicker" value="true"/>
		<jsp:param name="jquery_fullcalendar" value="true"/>
		<jsp:param name="jquery_fngantt" value="false"/>
		<jsp:param name="jquery_fixedtableheader" value="true"/>
		<jsp:param name="jquery_placeholder" value="true"/>
		<jsp:param name="jquery_iealert" value="false"/>
	</jsp:include>
<link rel="stylesheet" type="text/css" href="<s:url value='/jsp/res/log/css/time_style.css'/>" />
</head>
<style type="text/css">
	#tags li{cursor: pointer;}
</style>

<script type="text/javascript">
	$(function(){
		$("#tags li:first a").click();
		renderCalendar();
	});

	function selectTag(conObj,obj){
		$(".selectTag").removeClass("selectTag");
		$(obj).parent().addClass("selectTag");
		$(".tagContent").hide();
		$("#"+conObj).show();
	}
	function renderCalendar() {
		$('#calendar').fullCalendar({
			buttonText: {
				prev: '<',
				next: '>',
				today: '今天',
				month: '单击日期添加随访记录'
			},
			header: {
				left: 'prev,next,today',
				center: 'title',
				right: 'month'
			},
			firstDay:1,
			editable: true,
			lang:"zh-cn",
			dayClick:function(date, allDay, jsEvent, view ) { 
				$("#detail").load("<s:url value='/jsp/fllow/patient/data.jsp'/>");
	        	$("#detail").rightSlideOpen();
			},
			//单击事件项时触发 
	        eventClick: function(calEvent, jsEvent, view) { 
	        	$("#detail").load("<s:url value='/jsp/fllow/patient/data.jsp'/>");
	        	$("#detail").rightSlideOpen();
	        },
			events: [
		    	{
					title: '体格检查',
					allDay: true,
					start: '2015-08-01',
					editable : false
				},
				{
					title: '血常规检查',
					allDay: true,
					start: '2015-08-01',
					editable : false
				},
				{
					title: '炎症性肠病问卷',
					allDay: true,
					start: '2015-08-01',
					editable : false
				},
				{
					title: '中医辨证',
					allDay: true,
					start: '2015-08-01',
					editable : false
				}
			]
		});
	}
	$(function(){
		$("#detail").slideInit({
			width:800,
			speed:500,
			outClose:true
		});
	});
	
</script>
</head>

<body>
<div id="main">
   <div class="mainright">
      <div class="content">
	   <div>
	   	<table class="xllist">
	   		<tr><th colspan="4" style="text-align: left;">&#12288;患者基本信息</th></tr>
			<tr>
	            <td width="150px" style="text-align: left" >&#12288;<b>病历号：00123</b></td>
	            <td width="200px" style="text-align: left">&#12288;<b>姓名：</b>李军</td>
	            <td width="200px" style="text-align: left">&#12288;<b>身份证号：</b>32192312893123</td>
	            <td width="200px" style="text-align: left">&#12288;<b>联系电话：</b>13810010000 | 022-58856666</td>
	        </tr>
		    <tr>
	            <td width="150px" style="text-align: left">&#12288;<b>性别：</b>男</td>
	            <td width="200px" style="text-align: left">&#12288;<b>年龄：</b>53</td>
	            <td width="200px" style="text-align: left">&#12288;<b>居住住址：</b>天津市南开区南京路358号2001</td>
	            <td width="200px" style="text-align: left">&#12288;<b>邮箱地址：</b>cctv5@weibo.com</td>
	        </tr>
		</table>
	   </div>
		<div class="title1 clearfix">
		</div>
		<ul id="tags">
			<li ><a onclick="selectTag('calendar',this);">随访计划</a></li>
			<li ><a onclick="selectTag('tjfx',this)">数据分析统计</a></li>
			<li ><a onclick="selectTag('hzrz',this)">患者日志</a></li>
	    </ul>
	    <div id="tagContent" class="divContent">
	    	<div style="margin-top: 20px;margin-left: 20px;margin-right: 20px;margin-bottom: 20px;">
	    		<div class="tagContent" id="calendar" style="display: ;">
				</div>
				<div class="tagContent" id="tjfx" style="display: ;">
					暂无患者随访数据!
				</div>
				<div class="tagContent" id="hzrz">
				    <li class="log_item">
				    	<div class="timeline_date fl">
				        	<p class="week">
				        			2015-03-12
				        	</p>
				        </div>
				        <div class="log_content fl">
				        	<a class="arrow01">●</a>
				        	<div class="timeline_title">
				        		<b>身体状况描述</b>
				            	<!-- <a>工作日志</a>
				                <span>0</span> -->
				                <a class="more_all fr" href="javascript:void(0)" onclick="view('${workLog.logFlow}')">查&#12288;看&gt;</a>
				            </div>
				            <div class="content_area01">
				                	今天感觉身体乏力，上楼感觉呼吸急促
				            </div>
				        </div>
				    </li>
				    <li class="log_item">
				    	<div class="timeline_date fl">
				        	<p class="week">
				        			2015-03-01
				        	</p>
				        </div>
				        <div class="log_content fl">
				        	<a class="arrow01">●</a>
				        	<div class="timeline_title">
				        		<b>身体状况描述</b>
				            	<!-- <a>工作日志</a>
				                <span>0</span> -->
				                <a class="more_all fr" href="javascript:void(0)" onclick="view('${workLog.logFlow}')">查&#12288;看&gt;</a>
				            </div>
				            <div class="content_area01">
				                	今天精神尚可，无不适症状
				            </div>
				        </div>
				    </li>
				</div>
	    	</div>
	    	
	    </div>
      </div>
    </div>
</div>
 <div id="detail"></div>
</body>
</html>
