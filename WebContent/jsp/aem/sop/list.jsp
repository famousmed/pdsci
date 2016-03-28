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
	<jsp:param name="swfobject" value="true"/>
</jsp:include>
<script type="text/javascript"> 
function view(docId){
	$("#tableFlash").html("<div id='flashContent'></div>");
	var swfVersionStr = "10.0.0";
	var xiSwfUrlStr = "<s:url value='/js/swfobject/playerProductInstall.swf'/>";//swfobject/playerProductInstall.swf  固定的辅助文件
	var swfFile = "<s:url value='/jsp/aem/sop/'/>"+docId+".swf";//这填写文档转换成的flash文件的路径           
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
		swfobject.embedSWF("<s:url value='/js/swfobject/FlexPaperViewer.swf'/>", "flashContent","800", "1000",//swfobject/FlexPaperViewer.swf  固定的辅助文件  flashContent 显示在哪里的id  900宽  600 高
		swfVersionStr, xiSwfUrlStr, 
		flashvars, params, attributes);
		//swfobject.createCSS("#flashContent", "display:block;text-align:left;");
}
$(document).ready(function(){
	view('01');
});	
</script>
</head>
<body>
<div class="mainright">
	<div class="content">
	<div class="title1 clearfix">
		<div class="content">
			<table>
				<tr>
					<td width="300px">
						<table class="xllist" width="300px">
							<thead>
								<tr>
									<th width="30px"></th>
									<th>文件名称</th>
								</tr>
								<tr><td>1</td><td style="text-align:left;"><a href="javascript:view('01');">屏障系统人员进出SOP</a></td></tr>
								<tr><td>2</td><td style="text-align:left;"><a href="javascript:view('02');">屏障动物房中IVC的SOP</a></td></tr>
								<tr><td>3</td><td style="text-align:left;"><a href="javascript:view('03');">动物尸体及废弃物处理SOP</a></td></tr>
								<tr><td>4</td><td style="text-align:left;"><a href="javascript:view('04');">SPF级大鼠、小鼠饲养SOP</a></td></tr>
								<tr><td>5</td><td style="text-align:left;"><a href="javascript:view('05');">SPF级动物实验室物品消毒操作规程</a></td></tr>
								<tr><td>6</td><td style="text-align:left;"><a href="javascript:view('06');">实验期内实验动物质量检查标准操作规程</a></td></tr>
								<tr><td>7</td><td style="text-align:left;"><a href="javascript:view('07');">发现逃离动物处理标准操作规程</a></td></tr>
								<tr><td>8</td><td style="text-align:left;"><a href="javascript:view('08');">大鼠接收和检疫标准操作规程</a></td></tr>
								<tr><td>9</td><td style="text-align:left;"><a href="javascript:view('09');">小鼠接收和检疫标准操作规程</a></td></tr>
								<tr><td>10</td><td style="text-align:left;"><a href="javascript:view('10');">普通级动物实验室消毒操作规程</a></td></tr>
								<tr><td>11</td><td style="text-align:left;"><a href="javascript:view('11');">普通级豚鼠饲养操作规程</a></td></tr>
								<tr><td>12</td><td style="text-align:left;"><a href="javascript:view('12');">普通级兔饲养操作规程</a></td></tr>
								<tr><td>13</td><td style="text-align:left;"><a href="javascript:view('13');">兔接收和检疫标准操作规程</a></td></tr>
								<tr><td>14</td><td style="text-align:left;"><a href="javascript:view('14');">豚鼠接收和检疫标准操作规程</a></td></tr>
								<tr><td>15</td><td style="text-align:left;"><a href="javascript:view('15');">动物实验室环境设施标准管理规程</a></td></tr>
								<tr><td>16</td><td style="text-align:left;"><a href="javascript:view('16');">高效过滤器标准管理规程</a></td></tr>
								<tr><td>17</td><td style="text-align:left;"><a href="javascript:view('17');">消毒剂、清洁剂管理标准操作规程</a></td></tr>
								<tr><td>18</td><td style="text-align:left;"><a href="javascript:view('18');">动物实验室工作服、工作鞋、帽管理标准规程</a></td></tr>
								<tr><td>19</td><td style="text-align:left;"><a href="javascript:view('19');">净化空调机组标准操作规程</a></td></tr>
								<tr><td>20</td><td style="text-align:left;"><a href="javascript:view('20');">空调机组清洁标准操作规程</a></td></tr>
								<tr><td>21</td><td style="text-align:left;"><a href="javascript:view('21');">脉动真空灭菌柜标准操作规程</a></td></tr>
								<tr><td>22</td><td style="text-align:left;"><a href="javascript:view('22');">灭菌柜清洁、消毒操作规程</a></td></tr>
								<tr><td>23</td><td style="text-align:left;"><a href="javascript:view('23');">灭菌柜维护保养操作规程</a></td></tr>
								<tr><td>24</td><td style="text-align:left;"><a href="javascript:view('24');">饮用水菌落检测标准操作规程</a></td></tr>
								<tr><td>25</td><td style="text-align:left;"><a href="javascript:view('25');">屏障系统菌落检测标准操作规程</a></td></tr>
								<tr><td>26</td><td style="text-align:left;"><a href="javascript:view('26');">洁净室沉降菌的测定法</a></td></tr>
								<tr><td>27</td><td style="text-align:left;"><a href="javascript:view('27');">洁净区尘埃粒子测定法</a></td></tr>
								<tr><td>28</td><td style="text-align:left;"><a href="javascript:view('28');">实验动物使用管理委员会(IACUC)标准管理制度</a></td></tr>
								<tr><td>29</td><td style="text-align:left;"><a href="javascript:view('29');">实验动物福利与管理标准管理制度</a></td></tr>
								<tr><td>30</td><td style="text-align:left;"><a href="javascript:view('30');">安乐死标准操作规程</a></td></tr>
								<tr><td>31</td><td style="text-align:left;"><a href="javascript:view('31');">实验动物品系标准操作规程</a></td></tr>
								<tr><td>32</td><td style="text-align:left;"><a href="javascript:view('32');">实验兔饲养准操作规程</a></td></tr>
								<tr><td>33</td><td style="text-align:left;"><a href="javascript:view('33');">患病实验动物标准操作规程</a></td></tr>
							</tbody>
						</table>
					</td>
					<td id="tableFlash" width="600px" valign="top">
						<div id="flashContent"></div>
						
					</td>
				</tr>
			</table>
			<div class="button" style="width: 900px;">
			</div>
		</div>
	</div>
	</div></div>
</body>
</html>