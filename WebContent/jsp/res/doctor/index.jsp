<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@include file="/jsp/common/doctype.jsp"%>
<html>
<head>

<jsp:include page="/jsp/common/htmlhead.jsp">
<jsp:param name="basic" value="true"/>
<jsp:param name="jbox" value="true"/>
</jsp:include>
<link rel="stylesheet" type="text/css" href="<s:url value='/jsp/res/css/eteams.ui.css'/>"></link>
<link rel="stylesheet" type="text/css" href="<s:url value='/jsp/res/css/eteams.min.css'/>"></link>
<link rel="stylesheet" type="text/css" href="<s:url value='/jsp/res/css/all-crm.min.css'/>"></link>
</head>
<body> 
					<div class="col-12">
						<div class="toolkit">
							<ul class="toolkit-list">
								<li class="j_toolkit-bar-title toolkit-item toolkit-title">我的目标</li>
								<li class="toolkit-item"><div id="mainlines-filter"
										class="btn-group dropdown "
										data-toggle="#mainline-filter-dropdown">
										<a class="btn btn-sm btn-square">筛选 <i
											class="icon-caret-down"></i></a>
										<div id="mainline-filter-dropdown"
											class="dropdown-filter border-dropdown dropdown-div"></div>
									</div></li>
								<li class="toolkit-item"><div
										class="btn-group dropdown dropdown-menu-toggle">
										<a id="mainlines-order"
											class="btn btn-sm btn-square dropdown-toggle">排序 <i
											class="icon-caret-down"></i></a>
										<ul class="dropdown-menu border-dropdown">
											<li><a class="orderType" data-entity="default">默认</a></li>
											<li><a class="orderType" data-entity="last_comment_time">按反馈时间</a></li>
											<li><a class="orderType" data-entity="last_update_time">按目标更新时间</a></li>
											<li><a class="orderType" data-entity="create_time">按目标创建时间</a></li>
											<li><a class="orderType" data-entity="manager">按负责人</a></li>
										</ul>
									</div></li>
								<li class="toolkit-item search"><input
									id="mainline-keywords" class="form-control" type="text"
									name="mainlinesearch" placeholder="目标搜索"><i
									class="icon-search" title="搜索"></i></li>
								<li class="toolkit-item fr"><a
									class="j_goal-item-add btn btn-success btn-sm"><i
										class="icon-plus-thin glyphicon"></i>新建目标</a></li>
								<li class="toolkit-item fr"><div
										class="btn-group switch-tab j_goalView">
										<a class="btn btn-sm active" data-status="vtc"><i
											class="icon-th-large"></i></a><a class="btn btn-sm"
											data-status="horz"><i class="icon-reorder"></i></a>
									</div></li>
							</ul>
						</div>
						<div id="mainlinelist-container"
							class="mainlinelist-container goal-list j_goalScroll j_goalList scrollwrapper mCustomScrollbar _mCS_165"
							style="height: 222px;">
							<div id="mCSB_165"
								class="mCustomScrollBox mCS-darkblue mCSB_vertical mCSB_inside"
								tabindex="0">
								<div id="mCSB_165_container" class="mCSB_container"
									style="position: relative; top: 0px; left: 0px;" dir="ltr">
									<div id="guide-div" class="hide">
										<div class="goal-item-guide-wrap">
											<div class="guide-div goal-item-guide ">
												您还没有负责参与的目标，可通过右侧的“新建目标”来建立。<br>目标是团队成员或个人的每一件工作的中心主线和动力。
												围绕着工作目标，团队成员或个人可以凝聚同事的想法、开展具体任务等事项、以及在执行过程当中进行充分的交流沟通和分享，以促进共同方向的达成。
											</div>
										</div>
									</div>
									<div id="mainline-list" class="goal e-list">
										<dl class="j_goalitem goal-item router"
											data-id="4272061170457018173" data-module="mainline"
											href="/mainline/link/4271888972715732758/4272061170457018173"
											id="4272061170457018173">
											<dt class="goal-head clearfix">
												<div class="goal-icon pull-left">
													<img class="icon-img" src="/static/img/icon/goal/1.png">
												</div>
												<div class="goal-icon-r">
													<p class="caption ellipsis">
														<a class="j_goalname router title" title="99999">99999</a>
													</p>
													<p class="leader">
														负责人：<span class="manager">小三</span>
													</p>
												</div>
											</dt>
											<dd class="goal-detail clearfix">
												<div class="goal-chart pull-left" data-percent="0"
													_echarts_instance_="1420600071080"
													style="cursor: default; background-color: rgba(0, 0, 0, 0);">
													<div
														style="position: relative; overflow: hidden; width: 52px; height: 52px;">
														<div width="52" height="52" data-zr-dom-id="bg"
															style="position: absolute; left: 0px; top: 0px; width: 52px; height: 52px; -webkit-user-select: none;"></div>
														<canvas width="52" height="52" data-zr-dom-id="2"
															style="position: absolute; left: 0px; top: 0px; width: 52px; height: 52px; -webkit-user-select: none;"></canvas>
														<canvas width="52" height="52" data-zr-dom-id="3"
															style="position: absolute; left: 0px; top: 0px; width: 52px; height: 52px; -webkit-user-select: none;"></canvas>
														<canvas width="52" height="52" data-zr-dom-id="4"
															style="position: absolute; left: 0px; top: 0px; width: 52px; height: 52px; -webkit-user-select: none;"></canvas>
														<canvas width="52" height="52" data-zr-dom-id="6"
															style="position: absolute; left: 0px; top: 0px; width: 52px; height: 52px; -webkit-user-select: none;"></canvas>
														<canvas width="52" height="52"
															data-zr-dom-id="_zrender_hover_"
															style="position: absolute; left: 0px; top: 0px; width: 52px; height: 52px; -webkit-user-select: none;"></canvas>
													</div>
												</div>
												<div class="goal-info">
													<p>
														共<span class="participant">2</span>位同事参与
													</p>
													<p>
														共享给<span class="share">0</span>位
													</p>
												</div>
											</dd>
											<dd class="goal-date text-center">
												<span class="start">2015-01-08</span><span class="end">2015-01-09</span>
											</dd>
											<em class="arrow" targetid="4272061170457018173"
												watched="false" title="点击添加关注"></em>
											<i class="icon-star"></i>
											<i class="icon-star-empty hide"></i>
										</dl>
										<dl class="j_goalitem goal-item router"
											data-id="4272060660489113799" data-module="mainline"
											href="/mainline/link/4271888972715732758/4272060660489113799"
											id="4272060660489113799">
											<dt class="goal-head clearfix">
												<div class="goal-icon pull-left">
													<img class="icon-img" src="/static/img/icon/goal/1.png">
												</div>
												<div class="goal-icon-r">
													<p class="caption ellipsis">
														<a class="j_goalname router title" title="888">888</a>
													</p>
													<p class="leader">
														负责人：<span class="manager">李昱</span>
													</p>
												</div>
											</dt>
											<dd class="goal-detail clearfix">
												<div class="goal-chart pull-left" data-percent="0"
													_echarts_instance_="1420600071081"
													style="background-color: rgba(0, 0, 0, 0);">
													<div
														style="position: relative; overflow: hidden; width: 52px; height: 52px;">
														<div width="52" height="52" data-zr-dom-id="bg"
															style="position: absolute; left: 0px; top: 0px; width: 52px; height: 52px; -webkit-user-select: none;"></div>
														<canvas width="52" height="52" data-zr-dom-id="2"
															style="position: absolute; left: 0px; top: 0px; width: 52px; height: 52px; -webkit-user-select: none;"></canvas>
														<canvas width="52" height="52" data-zr-dom-id="3"
															style="position: absolute; left: 0px; top: 0px; width: 52px; height: 52px; -webkit-user-select: none;"></canvas>
														<canvas width="52" height="52" data-zr-dom-id="4"
															style="position: absolute; left: 0px; top: 0px; width: 52px; height: 52px; -webkit-user-select: none;"></canvas>
														<canvas width="52" height="52" data-zr-dom-id="6"
															style="position: absolute; left: 0px; top: 0px; width: 52px; height: 52px; -webkit-user-select: none;"></canvas>
														<canvas width="52" height="52"
															data-zr-dom-id="_zrender_hover_"
															style="position: absolute; left: 0px; top: 0px; width: 52px; height: 52px; -webkit-user-select: none;"></canvas>
													</div>
												</div>
												<div class="goal-info">
													<p>
														共<span class="participant">1</span>位同事参与
													</p>
													<p>
														共享给<span class="share">0</span>位
													</p>
												</div>
											</dd>
											<dd class="goal-date text-center">
												<span class="start no-date">无起止日期</span>
											</dd>
											<em class="arrow" targetid="4272060660489113799"
												watched="false" title="点击添加关注"></em>
											<i class="icon-star"></i>
											<i class="icon-star-empty hide"></i>
										</dl>
										<dl class="j_goalitem goal-item router"
											data-id="4272060350907612290" data-module="mainline"
											href="/mainline/link/4271888972715732758/4272060350907612290"
											id="4272060350907612290">
											<dt class="goal-head clearfix">
												<div class="goal-icon pull-left">
													<img class="icon-img" src="/static/img/icon/goal/1.png">
												</div>
												<div class="goal-icon-r">
													<p class="caption ellipsis">
														<a class="j_goalname router title" title="1">1</a>
													</p>
													<p class="leader">
														负责人：<span class="manager">李昱</span>
													</p>
												</div>
											</dt>
											<dd class="goal-detail clearfix">
												<div class="goal-chart pull-left" data-percent="0"
													_echarts_instance_="1420600071082"
													style="background-color: rgba(0, 0, 0, 0);">
													<div
														style="position: relative; overflow: hidden; width: 52px; height: 52px;">
														<div width="52" height="52" data-zr-dom-id="bg"
															style="position: absolute; left: 0px; top: 0px; width: 52px; height: 52px; -webkit-user-select: none;"></div>
														<canvas width="52" height="52" data-zr-dom-id="2"
															style="position: absolute; left: 0px; top: 0px; width: 52px; height: 52px; -webkit-user-select: none;"></canvas>
														<canvas width="52" height="52" data-zr-dom-id="3"
															style="position: absolute; left: 0px; top: 0px; width: 52px; height: 52px; -webkit-user-select: none;"></canvas>
														<canvas width="52" height="52" data-zr-dom-id="4"
															style="position: absolute; left: 0px; top: 0px; width: 52px; height: 52px; -webkit-user-select: none;"></canvas>
														<canvas width="52" height="52" data-zr-dom-id="6"
															style="position: absolute; left: 0px; top: 0px; width: 52px; height: 52px; -webkit-user-select: none;"></canvas>
														<canvas width="52" height="52"
															data-zr-dom-id="_zrender_hover_"
															style="position: absolute; left: 0px; top: 0px; width: 52px; height: 52px; -webkit-user-select: none;"></canvas>
													</div>
												</div>
												<div class="goal-info">
													<p>
														共<span class="participant">0</span>位同事参与
													</p>
													<p>
														共享给<span class="share">0</span>位
													</p>
												</div>
											</dd>
											<dd class="goal-date text-center">
												<span class="start">2015-01-07</span><span class="end">2015-01-30</span>
											</dd>
											<em class="arrow" targetid="4272060350907612290"
												watched="false" title="点击添加关注"></em>
											<i class="icon-star"></i>
											<i class="icon-star-empty hide"></i>
										</dl>
										<dl class="j_goalitem goal-item router"
											data-id="4272054239155484327" data-module="mainline"
											href="/mainline/link/4271888972715732758/4272054239155484327"
											id="4272054239155484327">
											<dt class="goal-head clearfix">
												<div class="goal-icon pull-left">
													<img class="icon-img" src="/static/img/icon/goal/1.png">
												</div>
												<div class="goal-icon-r">
													<p class="caption ellipsis">
														<a class="j_goalname router title" title="这个谁的任务1">这个谁的任务1</a>
													</p>
													<p class="leader">
														负责人：<span class="manager">李昱</span>
													</p>
												</div>
											</dt>
											<dd class="goal-detail clearfix">
												<div class="goal-chart pull-left" data-percent="0"
													_echarts_instance_="1420600071083"
													style="background-color: rgba(0, 0, 0, 0);">
													<div
														style="position: relative; overflow: hidden; width: 52px; height: 52px;">
														<div width="52" height="52" data-zr-dom-id="bg"
															style="position: absolute; left: 0px; top: 0px; width: 52px; height: 52px; -webkit-user-select: none;"></div>
														<canvas width="52" height="52" data-zr-dom-id="2"
															style="position: absolute; left: 0px; top: 0px; width: 52px; height: 52px; -webkit-user-select: none;"></canvas>
														<canvas width="52" height="52" data-zr-dom-id="3"
															style="position: absolute; left: 0px; top: 0px; width: 52px; height: 52px; -webkit-user-select: none;"></canvas>
														<canvas width="52" height="52" data-zr-dom-id="4"
															style="position: absolute; left: 0px; top: 0px; width: 52px; height: 52px; -webkit-user-select: none;"></canvas>
														<canvas width="52" height="52" data-zr-dom-id="6"
															style="position: absolute; left: 0px; top: 0px; width: 52px; height: 52px; -webkit-user-select: none;"></canvas>
														<canvas width="52" height="52"
															data-zr-dom-id="_zrender_hover_"
															style="position: absolute; left: 0px; top: 0px; width: 52px; height: 52px; -webkit-user-select: none;"></canvas>
													</div>
												</div>
												<div class="goal-info">
													<p>
														共<span class="participant">1</span>位同事参与
													</p>
													<p>
														共享给<span class="share">0</span>位
													</p>
												</div>
											</dd>
											<dd class="goal-date text-center">
												<span class="start">2015-01-06</span><span class="end">2015-01-09</span>
											</dd>
											<em class="arrow" targetid="4272054239155484327"
												watched="false" title="点击添加关注"></em>
											<i class="icon-star"></i>
											<i class="icon-star-empty hide"></i>
										</dl>
										<dl class="j_goalitem goal-item router"
											data-id="4272052365660861472" data-module="mainline"
											href="/mainline/link/4271888972715732758/4272052365660861472"
											id="4272052365660861472">
											<dt class="goal-head clearfix">
												<div class="goal-icon pull-left">
													<img class="icon-img" src="/static/img/icon/goal/1.png">
												</div>
												<div class="goal-icon-r">
													<p class="caption ellipsis">
														<a class="j_goalname router title" title="mywork">mywork</a>
													</p>
													<p class="leader">
														负责人：<span class="manager">李昱</span>
													</p>
												</div>
											</dt>
											<dd class="goal-detail clearfix">
												<div class="goal-chart pull-left" data-percent="100"
													_echarts_instance_="1420600071084"
													style="background-color: rgba(0, 0, 0, 0);">
													<div
														style="position: relative; overflow: hidden; width: 52px; height: 52px;">
														<div width="52" height="52" data-zr-dom-id="bg"
															style="position: absolute; left: 0px; top: 0px; width: 52px; height: 52px; -webkit-user-select: none;"></div>
														<canvas width="52" height="52" data-zr-dom-id="2"
															style="position: absolute; left: 0px; top: 0px; width: 52px; height: 52px; -webkit-user-select: none;"></canvas>
														<canvas width="52" height="52" data-zr-dom-id="3"
															style="position: absolute; left: 0px; top: 0px; width: 52px; height: 52px; -webkit-user-select: none;"></canvas>
														<canvas width="52" height="52" data-zr-dom-id="4"
															style="position: absolute; left: 0px; top: 0px; width: 52px; height: 52px; -webkit-user-select: none;"></canvas>
														<canvas width="52" height="52" data-zr-dom-id="6"
															style="position: absolute; left: 0px; top: 0px; width: 52px; height: 52px; -webkit-user-select: none;"></canvas>
														<canvas width="52" height="52"
															data-zr-dom-id="_zrender_hover_"
															style="position: absolute; left: 0px; top: 0px; width: 52px; height: 52px; -webkit-user-select: none;"></canvas>
													</div>
												</div>
												<div class="goal-info">
													<p>
														共<span class="participant">2</span>位同事参与
													</p>
													<p>
														共享给<span class="share">0</span>位
													</p>
												</div>
											</dd>
											<dd class="goal-date text-center">
												<span class="start">2015-01-04</span><span class="end">2015-01-06</span>
											</dd>
											<em class="arrow" targetid="4272052365660861472"
												watched="false" title="点击添加关注"></em>
											<i class="icon-star"></i>
											<i class="icon-star-empty hide"></i>
										</dl>
										<dl class="j_goalitem goal-item router"
											data-id="4272044649636770846" data-module="mainline"
											href="/mainline/link/4271888972715732758/4272044649636770846"
											id="4272044649636770846">
											<dt class="goal-head clearfix">
												<div class="goal-icon pull-left">
													<img class="icon-img" src="/static/img/icon/goal/1.png">
												</div>
												<div class="goal-icon-r">
													<p class="caption ellipsis">
														<a class="j_goalname router title" title="按计划完成">按计划完成</a>
													</p>
													<p class="leader">
														负责人：<span class="manager">李昱</span>
													</p>
												</div>
											</dt>
											<dd class="goal-detail clearfix">
												<div class="goal-chart pull-left" data-percent="67"
													_echarts_instance_="1420600071085"
													style="background-color: rgba(0, 0, 0, 0);">
													<div
														style="position: relative; overflow: hidden; width: 52px; height: 52px;">
														<div width="52" height="52" data-zr-dom-id="bg"
															style="position: absolute; left: 0px; top: 0px; width: 52px; height: 52px; -webkit-user-select: none;"></div>
														<canvas width="52" height="52" data-zr-dom-id="2"
															style="position: absolute; left: 0px; top: 0px; width: 52px; height: 52px; -webkit-user-select: none;"></canvas>
														<canvas width="52" height="52" data-zr-dom-id="3"
															style="position: absolute; left: 0px; top: 0px; width: 52px; height: 52px; -webkit-user-select: none;"></canvas>
														<canvas width="52" height="52" data-zr-dom-id="4"
															style="position: absolute; left: 0px; top: 0px; width: 52px; height: 52px; -webkit-user-select: none;"></canvas>
														<canvas width="52" height="52" data-zr-dom-id="6"
															style="position: absolute; left: 0px; top: 0px; width: 52px; height: 52px; -webkit-user-select: none;"></canvas>
														<canvas width="52" height="52"
															data-zr-dom-id="_zrender_hover_"
															style="position: absolute; left: 0px; top: 0px; width: 52px; height: 52px; -webkit-user-select: none;"></canvas>
													</div>
												</div>
												<div class="goal-info">
													<p>
														共<span class="participant">0</span>位同事参与
													</p>
													<p>
														共享给<span class="share">0</span>位
													</p>
												</div>
											</dd>
											<dd class="goal-date text-center">
												<span class="start no-date">无起止日期</span>
											</dd>
											<em class="arrow" targetid="4272044649636770846"
												watched="false" title="点击添加关注"></em>
											<i class="icon-star"></i>
											<i class="icon-star-empty hide"></i>
										</dl>
										<dl class="j_goalitem goal-item router active"
											data-id="4272043452458141857" data-module="mainline"
											href="/mainline/link/4271888972715732758/4272043452458141857"
											id="4272043452458141857">
											<dt class="goal-head clearfix">
												<div class="goal-icon pull-left">
													<img class="icon-img" src="/static/img/icon/goal/1.png">
												</div>
												<div class="goal-icon-r">
													<p class="caption ellipsis">
														<a class="j_goalname router title" title="1sdf">1sdf</a>
													</p>
													<p class="leader">
														负责人：<span class="manager">李昱</span>
													</p>
												</div>
											</dt>
											<dd class="goal-detail clearfix">
												<div class="goal-chart pull-left" data-percent="0"
													_echarts_instance_="1420600071086"
													style="background-color: rgba(0, 0, 0, 0);">
													<div
														style="position: relative; overflow: hidden; width: 52px; height: 52px;">
														<div width="52" height="52" data-zr-dom-id="bg"
															style="position: absolute; left: 0px; top: 0px; width: 52px; height: 52px; -webkit-user-select: none;"></div>
														<canvas width="52" height="52" data-zr-dom-id="2"
															style="position: absolute; left: 0px; top: 0px; width: 52px; height: 52px; -webkit-user-select: none;"></canvas>
														<canvas width="52" height="52" data-zr-dom-id="3"
															style="position: absolute; left: 0px; top: 0px; width: 52px; height: 52px; -webkit-user-select: none;"></canvas>
														<canvas width="52" height="52" data-zr-dom-id="4"
															style="position: absolute; left: 0px; top: 0px; width: 52px; height: 52px; -webkit-user-select: none;"></canvas>
														<canvas width="52" height="52" data-zr-dom-id="6"
															style="position: absolute; left: 0px; top: 0px; width: 52px; height: 52px; -webkit-user-select: none;"></canvas>
														<canvas width="52" height="52"
															data-zr-dom-id="_zrender_hover_"
															style="position: absolute; left: 0px; top: 0px; width: 52px; height: 52px; -webkit-user-select: none;"></canvas>
													</div>
												</div>
												<div class="goal-info">
													<p>
														共<span class="participant">0</span>位同事参与
													</p>
													<p>
														共享给<span class="share">0</span>位
													</p>
												</div>
											</dd>
											<dd class="goal-date text-center">
												<span class="start no-date">无起止日期</span>
											</dd>
											<em class="arrow" targetid="4272043452458141857"
												watched="true" title="点击取消关注"></em>
											<i class="icon-star"></i>
											<i class="icon-star-empty hide"></i>
										</dl>
										<dl class="j_goalitem goal-item router"
											data-id="4271984545544015718" data-module="mainline"
											href="/mainline/link/4271888972715732758/4271984545544015718"
											id="4271984545544015718">
											<dt class="goal-head clearfix">
												<div class="goal-icon pull-left">
													<img class="icon-img" src="/static/img/icon/goal/1.png">
												</div>
												<div class="goal-icon-r">
													<p class="caption ellipsis">
														<a class="j_goalname router title" title="ddddddddddd">ddddddddddd</a>
													</p>
													<p class="leader">
														负责人：<span class="manager">李昱</span>
													</p>
												</div>
											</dt>
											<dd class="goal-detail clearfix">
												<div class="goal-chart pull-left" data-percent="0"
													_echarts_instance_="1420600071087"
													style="background-color: rgba(0, 0, 0, 0);">
													<div
														style="position: relative; overflow: hidden; width: 52px; height: 52px;">
														<div width="52" height="52" data-zr-dom-id="bg"
															style="position: absolute; left: 0px; top: 0px; width: 52px; height: 52px; -webkit-user-select: none;"></div>
														<canvas width="52" height="52" data-zr-dom-id="2"
															style="position: absolute; left: 0px; top: 0px; width: 52px; height: 52px; -webkit-user-select: none;"></canvas>
														<canvas width="52" height="52" data-zr-dom-id="3"
															style="position: absolute; left: 0px; top: 0px; width: 52px; height: 52px; -webkit-user-select: none;"></canvas>
														<canvas width="52" height="52" data-zr-dom-id="4"
															style="position: absolute; left: 0px; top: 0px; width: 52px; height: 52px; -webkit-user-select: none;"></canvas>
														<canvas width="52" height="52" data-zr-dom-id="6"
															style="position: absolute; left: 0px; top: 0px; width: 52px; height: 52px; -webkit-user-select: none;"></canvas>
														<canvas width="52" height="52"
															data-zr-dom-id="_zrender_hover_"
															style="position: absolute; left: 0px; top: 0px; width: 52px; height: 52px; -webkit-user-select: none;"></canvas>
													</div>
												</div>
												<div class="goal-info">
													<p>
														共<span class="participant">0</span>位同事参与
													</p>
													<p>
														共享给<span class="share">0</span>位
													</p>
												</div>
											</dd>
											<dd class="goal-date text-center">
												<span class="start">2014-12-29</span><span class="end">2014-12-31</span>
											</dd>
											<em class="arrow" targetid="4271984545544015718"
												watched="false" title="点击添加关注"></em>
											<i class="icon-star"></i>
											<i class="icon-star-empty hide"></i>
										</dl>
										<dl class="j_goalitem goal-item router active"
											data-id="4271983016034580774" data-module="mainline"
											href="/mainline/link/4271888972715732758/4271983016034580774"
											id="4271983016034580774">
											<dt class="goal-head clearfix">
												<div class="goal-icon pull-left">
													<img class="icon-img" src="/static/img/icon/goal/1.png">
												</div>
												<div class="goal-icon-r">
													<p class="caption ellipsis">
														<a class="j_goalname router title" title="穿的">穿的</a>
													</p>
													<p class="leader">
														负责人：<span class="manager">李昱</span>
													</p>
												</div>
											</dt>
											<dd class="goal-detail clearfix">
												<div class="goal-chart pull-left" data-percent="0"
													_echarts_instance_="1420600071088"
													style="background-color: rgba(0, 0, 0, 0);">
													<div
														style="position: relative; overflow: hidden; width: 52px; height: 52px;">
														<div width="52" height="52" data-zr-dom-id="bg"
															style="position: absolute; left: 0px; top: 0px; width: 52px; height: 52px; -webkit-user-select: none;"></div>
														<canvas width="52" height="52" data-zr-dom-id="2"
															style="position: absolute; left: 0px; top: 0px; width: 52px; height: 52px; -webkit-user-select: none;"></canvas>
														<canvas width="52" height="52" data-zr-dom-id="3"
															style="position: absolute; left: 0px; top: 0px; width: 52px; height: 52px; -webkit-user-select: none;"></canvas>
														<canvas width="52" height="52" data-zr-dom-id="4"
															style="position: absolute; left: 0px; top: 0px; width: 52px; height: 52px; -webkit-user-select: none;"></canvas>
														<canvas width="52" height="52" data-zr-dom-id="6"
															style="position: absolute; left: 0px; top: 0px; width: 52px; height: 52px; -webkit-user-select: none;"></canvas>
														<canvas width="52" height="52"
															data-zr-dom-id="_zrender_hover_"
															style="position: absolute; left: 0px; top: 0px; width: 52px; height: 52px; -webkit-user-select: none;"></canvas>
													</div>
												</div>
												<div class="goal-info">
													<p>
														共<span class="participant">0</span>位同事参与
													</p>
													<p>
														共享给<span class="share">1</span>位
													</p>
												</div>
											</dd>
											<dd class="goal-date text-center">
												<span class="start no-date">无起止日期</span>
											</dd>
											<em class="arrow" targetid="4271983016034580774"
												watched="true" title="点击取消关注"></em>
											<i class="icon-star"></i>
											<i class="icon-star-empty hide"></i>
										</dl>
										<dl class="j_goalitem goal-item router"
											data-id="4271966804663755219" data-module="mainline"
											href="/mainline/link/4271888972715732758/4271966804663755219"
											id="4271966804663755219">
											<dt class="goal-head clearfix">
												<div class="goal-icon pull-left">
													<img class="icon-img" src="/static/img/icon/goal/1.png">
												</div>
												<div class="goal-icon-r">
													<p class="caption ellipsis">
														<a class="j_goalname router title" title="圣大非省">圣大非省</a>
													</p>
													<p class="leader">
														负责人：<span class="manager">小三</span>
													</p>
												</div>
											</dt>
											<dd class="goal-detail clearfix">
												<div class="goal-chart pull-left" data-percent="0"
													_echarts_instance_="1420600071089"
													style="background-color: rgba(0, 0, 0, 0);">
													<div
														style="position: relative; overflow: hidden; width: 52px; height: 52px;">
														<div width="52" height="52" data-zr-dom-id="bg"
															style="position: absolute; left: 0px; top: 0px; width: 52px; height: 52px; -webkit-user-select: none;"></div>
														<canvas width="52" height="52" data-zr-dom-id="2"
															style="position: absolute; left: 0px; top: 0px; width: 52px; height: 52px; -webkit-user-select: none;"></canvas>
														<canvas width="52" height="52" data-zr-dom-id="3"
															style="position: absolute; left: 0px; top: 0px; width: 52px; height: 52px; -webkit-user-select: none;"></canvas>
														<canvas width="52" height="52" data-zr-dom-id="4"
															style="position: absolute; left: 0px; top: 0px; width: 52px; height: 52px; -webkit-user-select: none;"></canvas>
														<canvas width="52" height="52" data-zr-dom-id="6"
															style="position: absolute; left: 0px; top: 0px; width: 52px; height: 52px; -webkit-user-select: none;"></canvas>
														<canvas width="52" height="52"
															data-zr-dom-id="_zrender_hover_"
															style="position: absolute; left: 0px; top: 0px; width: 52px; height: 52px; -webkit-user-select: none;"></canvas>
													</div>
												</div>
												<div class="goal-info">
													<p>
														共<span class="participant">1</span>位同事参与
													</p>
													<p>
														共享给<span class="share">0</span>位
													</p>
												</div>
											</dd>
											<dd class="goal-date text-center">
												<span class="start">2014-12-10</span><span class="end">2014-12-25</span>
											</dd>
											<em class="arrow" targetid="4271966804663755219"
												watched="false" title="点击添加关注"></em>
											<i class="icon-star"></i>
											<i class="icon-star-empty hide"></i>
										</dl>
										<dl class="j_goalitem goal-item router"
											data-id="4271966798289053610" data-module="mainline"
											href="/mainline/link/4271888972715732758/4271966798289053610"
											id="4271966798289053610">
											<dt class="goal-head clearfix">
												<div class="goal-icon pull-left">
													<img class="icon-img" src="/static/img/icon/goal/1.png">
												</div>
												<div class="goal-icon-r">
													<p class="caption ellipsis">
														<a class="j_goalname router title" title="8908">8908</a>
													</p>
													<p class="leader">
														负责人：<span class="manager">李昱</span>
													</p>
												</div>
											</dt>
											<dd class="goal-detail clearfix">
												<div class="goal-chart pull-left" data-percent="0"
													_echarts_instance_="1420600071090"
													style="background-color: rgba(0, 0, 0, 0);">
													<div
														style="position: relative; overflow: hidden; width: 52px; height: 52px;">
														<div width="52" height="52" data-zr-dom-id="bg"
															style="position: absolute; left: 0px; top: 0px; width: 52px; height: 52px; -webkit-user-select: none;"></div>
														<canvas width="52" height="52" data-zr-dom-id="2"
															style="position: absolute; left: 0px; top: 0px; width: 52px; height: 52px; -webkit-user-select: none;"></canvas>
														<canvas width="52" height="52" data-zr-dom-id="3"
															style="position: absolute; left: 0px; top: 0px; width: 52px; height: 52px; -webkit-user-select: none;"></canvas>
														<canvas width="52" height="52" data-zr-dom-id="4"
															style="position: absolute; left: 0px; top: 0px; width: 52px; height: 52px; -webkit-user-select: none;"></canvas>
														<canvas width="52" height="52" data-zr-dom-id="6"
															style="position: absolute; left: 0px; top: 0px; width: 52px; height: 52px; -webkit-user-select: none;"></canvas>
														<canvas width="52" height="52"
															data-zr-dom-id="_zrender_hover_"
															style="position: absolute; left: 0px; top: 0px; width: 52px; height: 52px; -webkit-user-select: none;"></canvas>
													</div>
												</div>
												<div class="goal-info">
													<p>
														共<span class="participant">0</span>位同事参与
													</p>
													<p>
														共享给<span class="share">0</span>位
													</p>
												</div>
											</dd>
											<dd class="goal-date text-center">
												<span class="start">2014-12-27</span><span class="end">2014-12-28</span>
											</dd>
											<em class="arrow" targetid="4271966798289053610"
												watched="false" title="点击添加关注"></em>
											<i class="icon-star"></i>
											<i class="icon-star-empty hide"></i>
										</dl>
										<dl class="j_goalitem goal-item router"
											data-id="4271965806105752451" data-module="mainline"
											href="/mainline/link/4271888972715732758/4271965806105752451"
											id="4271965806105752451">
											<dt class="goal-head clearfix">
												<div class="goal-icon pull-left">
													<img class="icon-img" src="/static/img/icon/goal/19.png">
												</div>
												<div class="goal-icon-r">
													<p class="caption ellipsis">
														<a class="j_goalname router title"
															title="鹅鹅鹅鹅鹅鹅鹅鹅鹅饿谁谁谁谁谁谁水水水水">鹅鹅鹅鹅鹅鹅鹅鹅鹅饿谁谁谁谁谁谁水水水水</a>
													</p>
													<p class="leader">
														负责人：<span class="manager">李昱</span>
													</p>
												</div>
											</dt>
											<dd class="goal-detail clearfix">
												<div class="goal-chart pull-left" data-percent="0"
													_echarts_instance_="1420600071091"
													style="background-color: rgba(0, 0, 0, 0);">
													<div
														style="position: relative; overflow: hidden; width: 52px; height: 52px;">
														<div width="52" height="52" data-zr-dom-id="bg"
															style="position: absolute; left: 0px; top: 0px; width: 52px; height: 52px; -webkit-user-select: none;"></div>
														<canvas width="52" height="52" data-zr-dom-id="2"
															style="position: absolute; left: 0px; top: 0px; width: 52px; height: 52px; -webkit-user-select: none;"></canvas>
														<canvas width="52" height="52" data-zr-dom-id="3"
															style="position: absolute; left: 0px; top: 0px; width: 52px; height: 52px; -webkit-user-select: none;"></canvas>
														<canvas width="52" height="52" data-zr-dom-id="4"
															style="position: absolute; left: 0px; top: 0px; width: 52px; height: 52px; -webkit-user-select: none;"></canvas>
														<canvas width="52" height="52" data-zr-dom-id="6"
															style="position: absolute; left: 0px; top: 0px; width: 52px; height: 52px; -webkit-user-select: none;"></canvas>
														<canvas width="52" height="52"
															data-zr-dom-id="_zrender_hover_"
															style="position: absolute; left: 0px; top: 0px; width: 52px; height: 52px; -webkit-user-select: none;"></canvas>
													</div>
												</div>
												<div class="goal-info">
													<p>
														共<span class="participant">0</span>位同事参与
													</p>
													<p>
														共享给<span class="share">0</span>位
													</p>
												</div>
											</dd>
											<dd class="goal-date text-center">
												<span class="start">2014-12-27</span><span class="end">2014-12-31</span>
											</dd>
											<em class="arrow" targetid="4271965806105752451"
												watched="false" title="点击添加关注"></em>
											<i class="icon-star"></i>
											<i class="icon-star-empty hide"></i>
										</dl>
										<dl class="j_goalitem goal-item router"
											data-id="4271959613980839124" data-module="mainline"
											href="/mainline/link/4271888972715732758/4271959613980839124"
											id="4271959613980839124">
											<dt class="goal-head clearfix">
												<div class="goal-icon pull-left">
													<img class="icon-img" src="/static/img/icon/goal/1.png">
												</div>
												<div class="goal-icon-r">
													<p class="caption ellipsis">
														<a class="j_goalname router title" title="12月自主任务">12月自主任务</a>
													</p>
													<p class="leader">
														负责人：<span class="manager">李昱</span>
													</p>
												</div>
											</dt>
											<dd class="goal-detail clearfix">
												<div class="goal-chart pull-left" data-percent="100"
													_echarts_instance_="1420600071092"
													style="background-color: rgba(0, 0, 0, 0);">
													<div
														style="position: relative; overflow: hidden; width: 52px; height: 52px;">
														<div width="52" height="52" data-zr-dom-id="bg"
															style="position: absolute; left: 0px; top: 0px; width: 52px; height: 52px; -webkit-user-select: none;"></div>
														<canvas width="52" height="52" data-zr-dom-id="2"
															style="position: absolute; left: 0px; top: 0px; width: 52px; height: 52px; -webkit-user-select: none;"></canvas>
														<canvas width="52" height="52" data-zr-dom-id="3"
															style="position: absolute; left: 0px; top: 0px; width: 52px; height: 52px; -webkit-user-select: none;"></canvas>
														<canvas width="52" height="52" data-zr-dom-id="4"
															style="position: absolute; left: 0px; top: 0px; width: 52px; height: 52px; -webkit-user-select: none;"></canvas>
														<canvas width="52" height="52" data-zr-dom-id="6"
															style="position: absolute; left: 0px; top: 0px; width: 52px; height: 52px; -webkit-user-select: none;"></canvas>
														<canvas width="52" height="52"
															data-zr-dom-id="_zrender_hover_"
															style="position: absolute; left: 0px; top: 0px; width: 52px; height: 52px; -webkit-user-select: none;"></canvas>
													</div>
												</div>
												<div class="goal-info">
													<p>
														共<span class="participant">2</span>位同事参与
													</p>
													<p>
														共享给<span class="share">0</span>位
													</p>
												</div>
											</dd>
											<dd class="goal-date text-center">
												<span class="start">2014-12-26</span><span class="end">2014-12-31</span>
											</dd>
											<em class="arrow" targetid="4271959613980839124"
												watched="false" title="点击添加关注"></em>
											<i class="icon-star"></i>
											<i class="icon-star-empty hide"></i>
										</dl>
										<dl class="j_goalitem goal-item router"
											data-id="4271932638409014753" data-module="mainline"
											href="/mainline/link/4271888972715732758/4271932638409014753"
											id="4271932638409014753">
											<dt class="goal-head clearfix">
												<div class="goal-icon pull-left">
													<img class="icon-img" src="/static/img/icon/goal/1.png">
												</div>
												<div class="goal-icon-r">
													<p class="caption ellipsis">
														<a class="j_goalname router title" title=" 了了发"> 了了发</a>
													</p>
													<p class="leader">
														负责人：<span class="manager">李昱</span>
													</p>
												</div>
											</dt>
											<dd class="goal-detail clearfix">
												<div class="goal-chart pull-left" data-percent="100"
													_echarts_instance_="1420600071093"
													style="background-color: rgba(0, 0, 0, 0);">
													<div
														style="position: relative; overflow: hidden; width: 52px; height: 52px;">
														<div width="52" height="52" data-zr-dom-id="bg"
															style="position: absolute; left: 0px; top: 0px; width: 52px; height: 52px; -webkit-user-select: none;"></div>
														<canvas width="52" height="52" data-zr-dom-id="2"
															style="position: absolute; left: 0px; top: 0px; width: 52px; height: 52px; -webkit-user-select: none;"></canvas>
														<canvas width="52" height="52" data-zr-dom-id="3"
															style="position: absolute; left: 0px; top: 0px; width: 52px; height: 52px; -webkit-user-select: none;"></canvas>
														<canvas width="52" height="52" data-zr-dom-id="4"
															style="position: absolute; left: 0px; top: 0px; width: 52px; height: 52px; -webkit-user-select: none;"></canvas>
														<canvas width="52" height="52" data-zr-dom-id="6"
															style="position: absolute; left: 0px; top: 0px; width: 52px; height: 52px; -webkit-user-select: none;"></canvas>
														<canvas width="52" height="52"
															data-zr-dom-id="_zrender_hover_"
															style="position: absolute; left: 0px; top: 0px; width: 52px; height: 52px; -webkit-user-select: none;"></canvas>
													</div>
												</div>
												<div class="goal-info">
													<p>
														共<span class="participant">0</span>位同事参与
													</p>
													<p>
														共享给<span class="share">0</span>位
													</p>
												</div>
											</dd>
											<dd class="goal-date text-center">
												<span class="start no-date">无起止日期</span>
											</dd>
											<em class="arrow" targetid="4271932638409014753"
												watched="false" title="点击添加关注"></em>
											<i class="icon-star"></i>
											<i class="icon-star-empty hide"></i>
										</dl>
										<dl class="j_goalitem goal-item router"
											data-id="4271932771744716714" data-module="mainline"
											href="/mainline/link/4271888972715732758/4271932771744716714"
											id="4271932771744716714">
											<dt class="goal-head clearfix">
												<div class="goal-icon pull-left">
													<img class="icon-img" src="/static/img/icon/goal/2.png">
												</div>
												<div class="goal-icon-r">
													<p class="caption ellipsis">
														<a class="j_goalname router title" title="夺地">夺地</a>
													</p>
													<p class="leader">
														负责人：<span class="manager">李昱</span>
													</p>
												</div>
											</dt>
											<dd class="goal-detail clearfix">
												<div class="goal-chart pull-left" data-percent="75"
													_echarts_instance_="1420600071094"
													style="background-color: rgba(0, 0, 0, 0);">
													<div
														style="position: relative; overflow: hidden; width: 52px; height: 52px;">
														<div width="52" height="52" data-zr-dom-id="bg"
															style="position: absolute; left: 0px; top: 0px; width: 52px; height: 52px; -webkit-user-select: none;"></div>
														<canvas width="52" height="52" data-zr-dom-id="2"
															style="position: absolute; left: 0px; top: 0px; width: 52px; height: 52px; -webkit-user-select: none;"></canvas>
														<canvas width="52" height="52" data-zr-dom-id="3"
															style="position: absolute; left: 0px; top: 0px; width: 52px; height: 52px; -webkit-user-select: none;"></canvas>
														<canvas width="52" height="52" data-zr-dom-id="4"
															style="position: absolute; left: 0px; top: 0px; width: 52px; height: 52px; -webkit-user-select: none;"></canvas>
														<canvas width="52" height="52" data-zr-dom-id="6"
															style="position: absolute; left: 0px; top: 0px; width: 52px; height: 52px; -webkit-user-select: none;"></canvas>
														<canvas width="52" height="52"
															data-zr-dom-id="_zrender_hover_"
															style="position: absolute; left: 0px; top: 0px; width: 52px; height: 52px; -webkit-user-select: none;"></canvas>
													</div>
												</div>
												<div class="goal-info">
													<p>
														共<span class="participant">1</span>位同事参与
													</p>
													<p>
														共享给<span class="share">0</span>位
													</p>
												</div>
											</dd>
											<dd class="goal-date text-center">
												<span class="start">2014-12-25</span><span
													class="end no-date">无结束日期</span>
											</dd>
											<em class="arrow" targetid="4271932771744716714"
												watched="false" title="点击添加关注"></em>
											<i class="icon-star"></i>
											<i class="icon-star-empty hide"></i>
										</dl>
										<dl class="j_goalitem goal-item router"
											data-id="4271940795207258157" data-module="mainline"
											href="/mainline/link/4271888972715732758/4271940795207258157"
											id="4271940795207258157">
											<dt class="goal-head clearfix">
												<div class="goal-icon pull-left">
													<img class="icon-img" src="/static/img/icon/goal/1.png">
												</div>
												<div class="goal-icon-r">
													<p class="caption ellipsis">
														<a class="j_goalname router title" title="sdsafdasfd">sdsafdasfd</a>
													</p>
													<p class="leader">
														负责人：<span class="manager">李昱</span>
													</p>
												</div>
											</dt>
											<dd class="goal-detail clearfix">
												<div class="goal-chart pull-left" data-percent="100"
													_echarts_instance_="1420600071095"
													style="background-color: rgba(0, 0, 0, 0);">
													<div
														style="position: relative; overflow: hidden; width: 52px; height: 52px;">
														<div width="52" height="52" data-zr-dom-id="bg"
															style="position: absolute; left: 0px; top: 0px; width: 52px; height: 52px; -webkit-user-select: none;"></div>
														<canvas width="52" height="52" data-zr-dom-id="2"
															style="position: absolute; left: 0px; top: 0px; width: 52px; height: 52px; -webkit-user-select: none;"></canvas>
														<canvas width="52" height="52" data-zr-dom-id="3"
															style="position: absolute; left: 0px; top: 0px; width: 52px; height: 52px; -webkit-user-select: none;"></canvas>
														<canvas width="52" height="52" data-zr-dom-id="4"
															style="position: absolute; left: 0px; top: 0px; width: 52px; height: 52px; -webkit-user-select: none;"></canvas>
														<canvas width="52" height="52" data-zr-dom-id="6"
															style="position: absolute; left: 0px; top: 0px; width: 52px; height: 52px; -webkit-user-select: none;"></canvas>
														<canvas width="52" height="52"
															data-zr-dom-id="_zrender_hover_"
															style="position: absolute; left: 0px; top: 0px; width: 52px; height: 52px; -webkit-user-select: none;"></canvas>
													</div>
												</div>
												<div class="goal-info">
													<p>
														共<span class="participant">0</span>位同事参与
													</p>
													<p>
														共享给<span class="share">1</span>位
													</p>
												</div>
											</dd>
											<dd class="goal-date text-center">
												<span class="start">2014-12-24</span><span class="end">2014-12-24</span>
											</dd>
											<em class="arrow" targetid="4271940795207258157"
												watched="false" title="点击添加关注"></em>
											<i class="icon-star"></i>
											<i class="icon-star-empty hide"></i>
										</dl>
										<dl class="j_goalitem goal-item router"
											data-id="4271932637458714737" data-module="mainline"
											href="/mainline/link/4271888972715732758/4271932637458714737"
											id="4271932637458714737">
											<dt class="goal-head clearfix">
												<div class="goal-icon pull-left">
													<img class="icon-img" src="/static/img/icon/goal/1.png">
												</div>
												<div class="goal-icon-r">
													<p class="caption ellipsis">
														<a class="j_goalname router title" title=" 女孩子了"> 女孩子了</a>
													</p>
													<p class="leader">
														负责人：<span class="manager">李昱</span>
													</p>
												</div>
											</dt>
											<dd class="goal-detail clearfix">
												<div class="goal-chart pull-left" data-percent="0"
													_echarts_instance_="1420600071096"
													style="background-color: rgba(0, 0, 0, 0);">
													<div
														style="position: relative; overflow: hidden; width: 52px; height: 52px;">
														<div width="52" height="52" data-zr-dom-id="bg"
															style="position: absolute; left: 0px; top: 0px; width: 52px; height: 52px; -webkit-user-select: none;"></div>
														<canvas width="52" height="52" data-zr-dom-id="2"
															style="position: absolute; left: 0px; top: 0px; width: 52px; height: 52px; -webkit-user-select: none;"></canvas>
														<canvas width="52" height="52" data-zr-dom-id="3"
															style="position: absolute; left: 0px; top: 0px; width: 52px; height: 52px; -webkit-user-select: none;"></canvas>
														<canvas width="52" height="52" data-zr-dom-id="4"
															style="position: absolute; left: 0px; top: 0px; width: 52px; height: 52px; -webkit-user-select: none;"></canvas>
														<canvas width="52" height="52" data-zr-dom-id="6"
															style="position: absolute; left: 0px; top: 0px; width: 52px; height: 52px; -webkit-user-select: none;"></canvas>
														<canvas width="52" height="52"
															data-zr-dom-id="_zrender_hover_"
															style="position: absolute; left: 0px; top: 0px; width: 52px; height: 52px; -webkit-user-select: none;"></canvas>
													</div>
												</div>
												<div class="goal-info">
													<p>
														共<span class="participant">0</span>位同事参与
													</p>
													<p>
														共享给<span class="share">0</span>位
													</p>
												</div>
											</dd>
											<dd class="goal-date text-center">
												<span class="start">2014-12-30</span><span class="end">2015-01-06</span>
											</dd>
											<em class="arrow" targetid="4271932637458714737"
												watched="false" title="点击添加关注"></em>
											<i class="icon-star"></i>
											<i class="icon-star-empty hide"></i>
										</dl>
										<dl id="goal-item-add"
											class="j_goal-item-add goal-item goal-item-add text-center">
											<i class="icon-plus"></i>
											<p>添加新目标</p>
										</dl>
									</div>
									<div id="mainlinelist-loading" class="loading_small hide">
										<span>正在加载数据，请稍后...</span>
									</div>
									<div class="hide no-result">无相关目标</div>
								</div>
								<div id="mCSB_165_scrollbar_vertical"
									class="mCSB_scrollTools mCSB_165_scrollbar mCS-darkblue mCSB_scrollTools_vertical"
									style="display: block;">
									<div class="mCSB_draggerContainer">
										<div id="mCSB_165_dragger_vertical" class="mCSB_dragger"
											style="position: absolute; min-height: 30px; height: 44px; top: 0px; display: block; max-height: 212px;"
											oncontextmenu="return false;">
											<div class="mCSB_dragger_bar" style="line-height: 30px;"></div>
										</div>
										<div class="mCSB_draggerRail"></div>
									</div>
								</div>
							</div>
						</div>
					</div>
					<div id="mainlineClone" class="hide">
						<dl class="j_goalitem goal-item router">
							<dt class="goal-head clearfix">
								<div class="goal-icon pull-left">
									<img class="icon-img" src="/static/img/icon/goal/1.png">
								</div>
								<div class="goal-icon-r">
									<p class="caption ellipsis">
										<a class="j_goalname router title">测试目标标题</a>
									</p>
									<p class="leader">
										负责人：<span class="manager">阿勇</span>
									</p>
								</div>
							</dt>
							<dd class="goal-detail clearfix">
								<div class="goal-chart pull-left"></div>
								<div class="goal-info">
									<p>
										共<span class="participant">0</span>位同事参与
									</p>
									<p>
										共享给<span class="share">0</span>位
									</p>
								</div>
							</dd>
							<dd class="goal-date text-center">
								<span class="start"></span><span class="end"></span>
							</dd>
							<em class="arrow"></em>
							<i class="icon-star"></i>
							<i class="icon-star-empty hide"></i>
						</dl>
						<dl id="goal-item-add"
							class="j_goal-item-add goal-item goal-item-add text-center">
							<i class="icon-plus"></i>
							<p>添加新目标</p>
						</dl>
					</div>
</body>
</html>