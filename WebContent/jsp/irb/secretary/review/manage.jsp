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
	function uploadFile(){
		jboxOpen("<s:url value='/irb/applyFile'/>", "上传文件", 700,300);
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
                       		 </tr>
								<tr>
                           <td width="200px" style="text-align: left">&#12288;主审委员：沈海琦</td>
                              <td width="200px" style="text-align: left">&#12288;审查方式：会议审查</td>
                            <td width="200px" style="text-align: left">&#12288;会议日期：2013-04-12</td>
                           <td width="200px" style="text-align: left">&#12288;审查结果：[<a href="#">修改后重审</a> ]</td>
                             
                         </tr>
							</table>
					<br/>
					<div>
						<img src="<s:url value='/css/skin/${skinPath}/images/irb_sc.png'/>"/>
							<!-- 
							<td width="200px"><a href="#">申请/报告</a></td>
							<td width="200px"><a href="#">受理/处理</a></td>
							<td width="200px"><a href="#">审查</a></td>
							<td width="200px"><a href="#">传达决定</a></td>
							<td width="200px"><a href="#">文件存档</a></td>
							 -->
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
										<li style="text-align: center;"></li>
									</ul></td>
								<td width="200px"><ul>
										<li style="text-align: center;"></li>
										<li style="text-align: center;"></li>
									</ul></td>
								<td width="200px"><ul>
										<li style="text-align: center;"></li>
										<li style="text-align: center;"></li>
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
		</div>
</body>
</html>