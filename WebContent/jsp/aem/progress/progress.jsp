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
.gantt, .gantt2 {
    width: 100%;
    margin: 20px auto;
    border: 14px solid #ddd;
        -webkit-border-radius: 6px;
        -moz-border-radius: 6px;
        border-radius: 6px;
            -webkit-box-sizing: border-box;
            -moz-box-sizing: border-box;
            box-sizing: border-box;
}

.gantt:after {
    content: ".";
    visibility: hidden;
    display: block;
    height: 0;
    clear: both;
}

.fn-gantt {
    width: 100%;
}

.fn-gantt .fn-content {
    overflow: hidden;
    position: relative;
    width: 100%;
}




/* === LEFT PANEL === */

.fn-gantt .leftPanel {
    float: left;
    width: 225px;
    overflow: hidden;
    border-right: 1px solid #DDD;
    position: relative;
    z-index: 20;
}

.fn-gantt .row {
    float: left;
    height: 24px;
    line-height: 24px;
    margin-left: -24px;
}

.fn-gantt .leftPanel .fn-label {
    display: inline-block;
    margin: 0 0 0 5px;
    color: #484A4D;
    width: 110px;
    white-space: nowrap;
    text-overflow: ellipsis;
    overflow: hidden;
}

.fn-gantt .leftPanel .row0 {
    border-top: 1px solid #DDD;
}
.fn-gantt .leftPanel .name, .fn-gantt .leftPanel .desc {
    float: left;
    height: 23px;
    margin: 0;
    border-bottom: 1px solid #DDD;
    background-color: #f6f6f6;
}

.fn-gantt .leftPanel .name {
    width: 110px;
    font-weight: bold;
}

.fn-gantt .leftPanel .desc {
    width: 115px;
}

.fn-gantt .leftPanel .fn-wide, .fn-gantt .leftPanel .fn-wide .fn-label {
    width: 225px;
}

.fn-gantt .spacer {
    margin: -2px 0 1px 0;
    border-bottom: none;
    background-color: #f6f6f6;
}




/* === RIGHT PANEL === */

.fn-gantt .rightPanel {
    overflow: hidden;
}

.fn-gantt .dataPanel {
    margin-left: 0px;
    border-right: 1px solid #DDD;
    background-image: url(img/grid.png);
    background-repeat: repeat;
    background-position: 24px 24px;
}
.fn-gantt .day, .fn-gantt .date {
    overflow: visible;
    width: 24px;
    line-height: 24px;
    text-align: center;
    border-left: 1px solid #DDD;
    border-bottom: 1px solid #DDD;
    margin: -1px 0 0 -1px;
    font-size: 11px;
    color: #484a4d;
    text-shadow: 0 1px 0 rgba(255,255,255,0.75);
    text-align: center;
}

.fn-gantt .holiday {
    background-color: #ffd263;
    height: 23px;
    margin: 0 0 -1px -1px;
}

.fn-gantt .today {
    background-color: #fff8da;
    height: 23px;
    margin: 0 0 -1px -1px;
    font-weight: bold;
    text-align: center;
}

.fn-gantt .sa, .fn-gantt .sn, .fn-gantt .wd {
    height: 23px;
    margin: 0 0 0 -1px;
    text-align: center;
}

.fn-gantt .sa, .fn-gantt .sn {
    color: #939496;
    background-color: #f5f5f5;
    text-align: center;
}

.fn-gantt .wd {
    background-color: #f6f6f6;
    text-align: center;
}

.fn-gantt .rightPanel .month, .fn-gantt .rightPanel .year {
    float: left;
    overflow: hidden;
    border-left: 1px solid #DDD;
    border-bottom: 1px solid #DDD;
    height: 23px;
    margin: 0 0 0 -1px;
    background-color: #f6f6f6;
    font-weight: bold;
    font-size: 11px;
    color: #484a4d;
    text-shadow: 0 1px 0 rgba(255,255,255,0.75);
    text-align: center;
}

.fn-gantt-hint {
    border: 5px solid #edc332;
    background-color: #fff5d4;
    padding: 10px;
    position: absolute;
    display: none;
    z-index: 11;
        -webkit-border-radius: 4px;
        -moz-border-radius: 4px;
        border-radius: 4px;
}

.fn-gantt .bar {
    background-color: #D0E4FD;
    height: 18px;
    margin: 4px 3px 3px 3px;
    position: absolute;
    z-index: 10;
    text-align: center;
        -webkit-box-shadow: 0 0 1px rgba(0,0,0,0.25) inset;
        -moz-box-shadow: 0 0 1px rgba(0,0,0,0.25) inset;
        box-shadow: 0 0 1px rgba(0,0,0,0.25) inset;
            -webkit-border-radius: 3px;
            -moz-border-radius: 3px;
            border-radius: 3px;
}

.fn-gantt .bar .fn-label {
    line-height: 18px;
    font-weight: bold;
    white-space: nowrap;
    width: 100%;
    text-overflow: ellipsis;
    overflow: hidden;
    text-shadow: 0 1px 0 rgba(255,255,255,0.4);
    color: #414B57 !important;
    text-align: center;
    font-size: 11px;
}

.fn-gantt .ganttRed {
    background-color: #F9C4E1;
}
.fn-gantt .ganttRed .fn-label {
    color: #78436D !important;
}

.fn-gantt .ganttGreen {
    background-color: #D8EDA3;
}
.fn-gantt .ganttGreen .fn-label {
    color: #778461 !important;
}

.fn-gantt .ganttOrange {
    background-color: #FCD29A;
}
.fn-gantt .ganttOrange .fn-label {
    color: #714715 !important;
}


/* === BOTTOM NAVIGATION === */

.fn-gantt .bottom {
    clear: both;
    background-color: #f6f6f6;
    width: 100%;
}
.fn-gantt .navigate {
    border-top: 1px solid #DDD;
    padding: 10px 0 10px 225px;
}

.fn-gantt .navigate .nav-slider {
    height: 20px;
    display: inline-block;
}

.fn-gantt .navigate .nav-slider-left, .fn-gantt .navigate .nav-slider-right {
    text-align: center;
    height: 20px;
    display: inline-block;
}

.fn-gantt .navigate .nav-slider-left {
    float: left;
}

.fn-gantt .navigate .nav-slider-right {
    float: right;
}

.fn-gantt .navigate .nav-slider-content {
    text-align: left;
    width: 160px;
    height: 20px;
    display: inline-block;
    margin: 0 10px;
}

.fn-gantt .navigate .nav-slider-bar, .fn-gantt .navigate .nav-slider-button {
    position: absolute;
    display: block;
}

.fn-gantt .navigate .nav-slider-bar {
    width: 155px;
    height: 6px;
    background-color: #838688;
    margin: 8px 0 0 0;
        -webkit-box-shadow: 0 1px 3px rgba(0,0,0,0.6) inset;
        -moz-box-shadow: 0 1px 3px rgba(0,0,0,0.6) inset;
        box-shadow: 0 1px 3px rgba(0,0,0,0.6) inset;
            -webkit-border-radius: 3px;
            -moz-border-radius: 3px;
            border-radius: 3px;
}

.fn-gantt .navigate .nav-slider-button {
    width: 17px;
    height: 60px;
    background: url(img/slider_handle.png) center center no-repeat;
    left: 0px;
    top: 0px;
    margin: -26px 0 0 0;
    cursor: pointer;
}

.fn-gantt .navigate .page-number {
    display: inline-block;
    font-size: 10px;
    height: 20px;
}

.fn-gantt .navigate .page-number span {
    color: #666666;
    margin: 0 6px;
    height: 20px;
    line-height: 20px;
    display: inline-block;
}

.fn-gantt .navigate a:link, .fn-gantt .navigate a:visited, .fn-gantt .navigate a:active {
    text-decoration: none;
}

.fn-gantt .nav-link {
    margin: 0 3px 0 0;
    display: inline-block;
    width: 20px;
    height: 20px;
    font-size: 0px;
    background: #595959 url(img/icon_sprite.png) !important;
    border: 1px solid #454546;
    cursor: pointer;
    vertical-align: top;
        -webkit-border-radius: 2px;
        -moz-border-radius: 2px;
        border-radius: 2px;
            -webkit-box-shadow: 0 1px 0 rgba(255,255,255,0.1) inset, 0 1px 1px rgba(0,0,0,0.2);
            -moz-box-shadow: 0 1px 0 rgba(255,255,255,0.1) inset, 0 1px 1px rgba(0,0,0,0.2);
            box-shadow: 0 1px 0 rgba(255,255,255,0.1) inset, 0 1px 1px rgba(0,0,0,0.2);
                -webkit-box-sizing: border-box;
                -moz-box-sizing: border-box;
                box-sizing: border-box;
}
.fn-gantt .nav-link:active {
    -webkit-box-shadow: 0 1px 1px rgba(0,0,0,0.25) inset, 0 1px 0 #FFF;
    -moz-box-shadow: 0 1px 1px rgba(0,0,0,0.25) inset, 0 1px 0 #FFF;
    box-shadow: 0 1px 1px rgba(0,0,0,0.25) inset, 0 1px 0 #FFF;
}

.fn-gantt .navigate .nav-page-back {
    background-position: 1px 0 !important;
    margin: 0;
}

.fn-gantt .navigate .nav-page-next {
    background-position: 1px -16px !important;
    margin-right: 15px;
}

.fn-gantt .navigate .nav-slider .nav-page-next {
    margin-right: 5px;
}

.fn-gantt .navigate .nav-begin {
    background-position: 1px -112px !important;
}

.fn-gantt .navigate .nav-prev-week {
    background-position: 1px -128px !important;
}

.fn-gantt .navigate .nav-prev-day {
    background-position: 1px -48px !important;
}

.fn-gantt .navigate .nav-next-day {
    background-position: 1px -64px !important;
}

.fn-gantt .navigate .nav-next-week {
    background-position: 1px -160px !important;
}

.fn-gantt .navigate .nav-end {
    background-position: 1px -144px !important;
}

.fn-gantt .navigate .nav-zoomOut {
    background-position: 1px -96px !important;
}

.fn-gantt .navigate .nav-zoomIn {
    background-position: 1px -80px !important;
    margin-left: 15px;
}

.fn-gantt .navigate .nav-now {
    background-position: 1px -32px !important;
}

.fn-gantt .navigate .nav-slider .nav-now {
    margin-right: 5px;
}

.fn-gantt-loader {
    background-image: url(img/loader_bg.png);
    z-index: 30;
}

.fn-gantt-loader-spinner {
    width: 100px;
    height: 20px;
    position: absolute;
    margin-left: 50%;
    margin-top: 50%;
    text-align: center;
}
.fn-gantt-loader-spinner span {
    color: #fff;
    font-size: 12px;
    font-weight: bold;
}

.row:after {
    clear: both;
}


</style>
<script type="text/javascript">
$(function(){

	$("#gantt").gantt({
		source: [{
			name: "第一次试验",
			desc: "喂药",
			values: [{
				from: "/Date('2014-05-13')/",
				to: "/Date('2014-05-16')/",
				label: "喂药", 
				customClass: "ganttRed"
			}]
		},{
			name: " ",
			desc: "抽血",
			values: [{
				from: "/Date(1322611200000)/",
				to: "/Date(1323302400000)/",
				label: "抽血", 
				customClass: "ganttRed"
			}]
		},{
			name: "第二次试验",
			desc: "喂药",
			values: [{
				from: "/Date(1323802400000)/",
				to: "/Date(1325685200000)/",
				label: "喂药", 
				customClass: "ganttGreen"
			}]
		},{
			name: " ",
			desc: "抽血",
			values: [{
				from: "/Date(1325685200000)/",
				to: "/Date(1325695200000)/",
				label: "抽血", 
				customClass: "ganttBlue"
			}]
		},{
			name: "",
			desc: "拍X片",
			values: [{
				from: "/Date(1326785200000)/",
				to: "/Date(1325785200000)/",
				label: "拍X片", 
				customClass: "ganttGreen"
			}]
		},{
			name: " ",
			desc: "拍XX片",
			values: [{
				from: "/Date(1336611200000)/",
				to: "/Date(1349711200000)/",
				label: "拍XX片", 
				customClass: "ganttBlue"
			}]
		}],
		navigate: "scroll",
		scale: "days",
		maxScale: "weeks",
		minScale: "days",
		itemsPerPage: 20,
		onItemClick: function(data) {
		},
		onAddClick: function(dt, rowId) {
		},
		onRender: function() {
		}
	});

});
</script>
</head>
<body>
	<div class="mainright">
		<div class="content">
			<div id="gantt" class="gantt"></div>
		</div>
	</div>
</body>
</html>