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
</jsp:include>
</head>
<script type="text/javascript">
function approveFile(){
	jboxOpen("<s:url value='/irb/secretary/approveFile'/>", "决定文件", 700,600);
}
function viewIrbFile(){
	jboxOpen("<s:url value='/irb/committee/viewIrbFile'/>","送审文件",1000,600);
}
function irbUserList(){
	jboxOpen("<s:url value='/irb/researcher/irbUserList'/>","研究团队",1000,600);
}
function apply(){
	jboxOpen("<s:url value='/irb/researcher/apply'/>?pjType=YW","审查申请表",1000,600);
}
function receiptNotice(){
	jboxOpen("<s:url value='/irb/secretary/receiptNotice'/>","受理通知",600,500);
}
function irbMemberList(){
	jboxOpen("<s:url value='/irb/secretary/irbMemberList'/>","伦理委员会成员名单",600,500);
}
function selectCommittee(){
	jboxOpen("<s:url value='/irb/secretary/selectCommittee'/>","选择主审委员/独立顾问",400,350);
}
function voteDesction(){
	jboxOpen("<s:url value='/irb/meeting/voteDesction'/>","投票结果",800,600);
}
function quickOpinion(){
	jboxOpen("<s:url value='/irb/secretary/quickOpinion'/>","快审主审综合意见",500,450);
}
function archiveFile(){
	jboxOpen("<s:url value='/irb/secretary/archiveFile'/>","文件存档",750,600);
}
</script>
<body>
	<div id="main">
		<div class="mainright">
			<div class="content">
				<div style="margin-top: 5px">
					项目名称：<b>喉返神经损伤、再支配机制的实验研究 </b>&#12288;&#12288;&#12288;&#12288;伦理审查类别：<b>初始审查申请</b>
				</div>
				<div class="title1 clearfix">
					<table class="xllist">
							<tr>
	                            <td width="200px" style="text-align: left">&#12288;主要研究者：方琪</td>
	                              <td width="200px" style="text-align: left">&#12288;专业组：骨科</td>
	                           <td width="200px" style="text-align: left">&#12288;送审日期：2013-05-12</td>
	                             <td width="200px" style="text-align: left">&#12288;受理日期：2013-05-20</td>
	                               <td width="60px" style="text-align: right" rowspan="3">
										<img src="<s:url value='/css/skin/${skinPath}/images/irb_jdwj.png'/>" onclick="approveFile();" style="cursor: pointer;"/>
									</td>
                       		 </tr>
								<tr>
                           <td width="200px" style="text-align: left">&#12288;主审委员：沈海琦</td>
                              <td width="200px" style="text-align: left">&#12288;审查方式：会议审查</td>
                            <td width="200px" style="text-align: left">&#12288;会议日期：2013-04-12</td>
                           <td width="200px" style="text-align: left">&#12288;审查结果：[<a href="#">修改后重审</a> ]</td>
                             
                         </tr>
                         <tr>
                         	 <td width="200px" style="text-align: left">&#12288;决定文件日期：2014-04-12</td>
                           	 <td width="200px" style="text-align: left">&#12288;跟踪审查频率：6个月</td>
                          	 <td width="200px" style="text-align: left">&#12288;跟踪审查日期：2014-10-12</td>
                             <td width="200px" style="text-align: left"></td>
                         </tr>
							</table>
					<br/>
					<div>
						<img src="<s:url value='/css/skin/${skinPath}/images/irb_wjcd.png'/>"  usemap="#Map"/>
						 <map name="Map">
						      <area shape="rect" coords="33,133,129,154" href="javascript:apply();">
						      <area shape="rect" coords="37,154,120,178" href="javascript:irbUserList();">
						      <area shape="rect" coords="37,184,120,205" href="javascript:viewIrbFile();">
						      <area shape="rect" coords="240,113,314,138" href="javascript:receiptNotice();">
						      <area shape="rect" coords="230,139,318,162" href="#">
						      <area shape="rect" coords="220,168,333,213" href="javascript:selectCommittee();">
						      <area shape="rect" coords="418,129,519,177" href="javascript:quickOpinion();">
						      <area shape="rect" coords="416,180,519,201" href="javascript:voteDesction();">
						      <area shape="rect" coords="600,137,674,164" href="javascript:approveFile();">
						      <area shape="rect" coords="577,167,694,188" href="javascript:irbMemberList();">
						      <area shape="rect" coords="779,142,854,163" href="javascript:archiveFile();">
						      <area shape="rect" coords="779,169,856,187" href="#">
						    </map>
							<!-- 
							<td width="200px"><a href="#">申请/报告</a></td>
							<td width="200px"><a href="#">受理/处理</a></td>
							<td width="200px"><a href="#">审查</a></td>
							<td width="200px"><a href="#">传达决定</a></td>
							<td width="200px"><a href="#">文件存档</a></td>
					</div>
					<!-- 
					<br/>
					<div>
						<table class="xllist" >
							<tr><td width="200px" >
								<ul>
									<li style="text-align: center;">审查申请表</li>
									<li style="text-align: center;">研究团队</li>
									<li style="text-align: center;">送审文件清单</li>
								</ul></td>
							<td width="200px"><ul>
									<li style="text-align: center;">补充修改材料</li>
									<li style="text-align: center;">受理通知</li>
									<li style="text-align: center;">主审委员：</li>
									<li style="text-align: center;">独立顾问：</li>
								</ul></td>
							<td width="200px"><ul>
										<li style="text-align: center;">审查工作表</li>
										<li style="text-align: center;">快速主审综合意见</li>
									</ul></td>
								<td width="200px"><ul>
										<li style="text-align: center;">决定文件</li>
										<li style="text-align: center;">IRB成员表</li>
									</ul></td>
								<td width="200px"><ul>
										<li style="text-align: center;">文件存档</li>
										<li style="text-align: center;">审查归档</li>
									</ul></td>
								 </tr>
						</table>
					</div>
					 -->
					<p>
						<script type="text/javascript">
							function selectTag(showContent, selfObj) {
								$(".tagContent").hide();
								$("#tagContent"+showContent).show();
								$("li").removeClass("selectTag");
								$(selfObj).parent().addClass("selectTag");
							}
						</script>
					</p>
				
			</div>
		</div>
		</div>
		</div></div>
</body>
</html>