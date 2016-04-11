<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<title>学习中心-查看课程</title>
<meta name="keywords" content=""/>
<meta name="description" content=""/>
<jsp:include page="/jsp/edu/htmlhead-edu.jsp">
	<jsp:param name="basic" value="true"/>
	<jsp:param name="jbox" value="true"/>
	<jsp:param name="jquery_placeholder" value="true"/>
	<jsp:param name="jquery_validation" value="true"/>
	<jsp:param name="jquery_scrollTo" value="true"/>
	<jsp:param name="video" value="true"/>
</jsp:include>
<script type="text/javascript">
function checkResult(obj){
	$(obj).closest("dd").find("input:radio").attr("disabled",true);
	$(obj).closest("dd").find("span").show();
}

function checkMultiResult(obj,end) {
	$(obj).hide();
	$(obj).closest("dd").find("input:checkbox").attr("disabled",true);
	$(obj).closest("dd").find("span").show();
	if ("Y"==end) {
		$("#testResultSpan").show();
	} else if ("N"==end) {
		$("#retestResultSpan").show();
	}
	if (end != "") {
		$("#nextItemBtn").hide();
	}
}

function reExam(){
	$("#examForm").hide();
	$("#reexamForm").show();
	$("#nextItemBtn").show();
	$("#reradioTitle").show();
	$("body").scrollTo("#courseTestDiv", 1000,{ offset:{ top:-20} } );
}

function nextItem(){
	var currObj = $("#courseTestDiv").find("dl:visible");
	if ($(currObj).find("span").is(':hidden')) {
		jboxTipExt("请完成当前题！");
		return;
	}
	if ($(currObj).next().is('h3')) {
		$("#courseTestDiv").find("h3").hide();
		$(currObj).next().show();
		$(currObj).next().next("dl").show();
	} else {
		$(currObj).next("dl").show();
	}
	$(currObj).hide();
}

</script>
</head>
<body>
<!--videoPage-->
   <!--video-l-->
  <div class="video-l fl" style="padding: 0;border-bottom:0;margin-top: 0;" id="courseTestDiv">
    <div class="module-content">
       <div class="test" style="padding-top: 0;">
       <p style="font-size:16px; color:#009fff; text-align:right;"> 满分：100 &nbsp;&nbsp;&nbsp;&nbsp;及格分：60</p>
       <form id="examForm">
       		<h3>一、单选题</h3>
            	<dl>
                	<dt class="fl">1</dt>
                    <dd class="fl">
                    	<p>下列哪项不是我国食管癌病理分级标准</p>
                        <p><input type="radio" name="item1" onclick="checkResult(this);"/>A. 病变长度<br/>
                        <input type="radio" name="item1" onclick="checkResult(this);"/>B. 病变范围<br/>
                        <input type="radio" name="item1" onclick="checkResult(this);"/>C. 有无转移<br/>
                        <input type="radio" name="item1" onclick="checkResult(this);"/>D. 消瘦和贫血程度
                        </p>
                   		<span style="display: none;"><img src="<s:url value='/jsp/edu/css/images/gou.png'/>"/>&#12288;恭喜你，答对了！</span>
                    </dd>
                </dl>
                <dl style="display: none;">
                	<dt class="fl">2</dt>
                    <dd class="fl">
                    	<p>以下哪项能确定心脏有器质性病变：</p>
                        <p><input type="radio" name="item2" onclick="checkResult(this);"/>A. 心脏震颤<br/> 
                        <input type="radio" name="item2" onclick="checkResult(this);"/>B. 心尖区Ⅱ级吹风样杂音<br/>
                        <input type="radio" name="item2" onclick="checkResult(this);"/>C. 第四心音<br/>
                        <input type="radio" name="item2" onclick="checkResult(this);"/>D. 窦性心动过速
                        </p>
                    	<span style="display: none;"><img src="<s:url value='/jsp/edu/css/images/del3.png'/>"/>&#12288;您答错了！标准答案是：A. 心脏震颤</span>
                    </dd>
                </dl>
                <dl style="display: none;">
                	<dt class="fl">3</dt>
                    <dd class="fl">
                    	<p>下列哪项不是主动脉瓣狭窄的特点：</p>
                        <p><input type="radio" name="item3" onclick="checkResult(this);"/>A. 主动脉瓣区粗糙、响亮的收缩期杂音伴震颤<br/>
                        <input type="radio" name="item3" onclick="checkResult(this);"/>B. 主动脉瓣区第二心音减弱<br/>
                        <input type="radio" name="item3" onclick="checkResult(this);"/>C. 收缩压增高，舒张压降低，脉压增大<br/>
                        <input type="radio" name="item3" onclick="checkResult(this);"/>D. 左室肥大
                        </p>
                    	<span style="display: none;"><img src="<s:url value='/jsp/edu/css/images/gou.png'/>"/>&#12288;恭喜你，答对了！</span>
                    </dd>
                </dl>
                <dl style="display: none;">
                	<dt class="fl">4</dt>
                    <dd class="fl">
                    	<p>关于溃疡性结肠炎的治疗，下列哪项说法错误</p>
                        <p><input type="radio" name="item4" onclick="checkResult(this);"/>A. 可用SASP<br/>
                        <input type="radio" name="item4" onclick="checkResult(this);"/>B. 可用激素<br/>
                        <input type="radio" name="item4" onclick="checkResult(this);"/>C. SASP的有效成分是磺胺吡啶<br/> 
                        <input type="radio" name="item4" onclick="checkResult(this);"/>D. 应予少渣饮食</p>
                    	<span style="display: none;"><img src="<s:url value='/jsp/edu/css/images/del3.png'/>"/>&#12288;您答错了！标准答案是：C. SASP的有效成分是磺胺吡啶</span>
                    </dd>
                </dl>
                <h3 style="margin-top: 12px;display: none;">二、多选题</h3>
                <dl style="display: none;">
                	<dt class="fl">1</dt>
                    <dd class="fl">
                    	<p>急性白血病的临床特征是</p>
                        <p><input type="checkbox"/>A. 发烧、贫血、肝脾及淋巴结肿大<br/>
                        <input type="checkbox"/>B. 高烧、出血、白细胞及血小板减少<br/>
                        <input type="checkbox"/>C. 贫血、出血、恶病质及白细胞增多<br/>
                        <input type="checkbox"/>D. 贫血、发热、出血、器官组织浸润</p>
                   		<input type="button" class="fb-btn fr" value="确定" onclick="checkMultiResult(this,'');"/>
                   		<span style="display: none;"><img src="<s:url value='/jsp/edu/css/images/gou.png'/>"/>&#12288;恭喜你，答对了！</span>
                    </dd>
                </dl>
                <dl style="display: none;">
                	<dt class="fl">2</dt>
                    <dd class="fl">
                    	<p>急性白血病的临床特征是</p>
                        <p><input type="checkbox"/>A. 发烧、贫血、肝脾及淋巴结肿大<br/>
                        <input type="checkbox"/>B. 高烧、出血、白细胞及血小板减少<br/>
                        <input type="checkbox"/>C. 贫血、出血、恶病质及白细胞增多<br/>
                        <input type="checkbox"/>D. 贫血、发热、出血、器官组织浸润</p>
                        <input type="button" class="fb-btn fr" value="确定" onclick="checkMultiResult(this,'');"/>
                   		<span style="display: none;"><img src="<s:url value='/jsp/edu/css/images/del3.png'/>"/>&#12288;您答错了！标准答案是：B、D</span>
                    </dd>
                </dl>
                <dl style="display: none;">
                	<dt class="fl">3</dt>
                    <dd class="fl">
                    	<p>急性白血病的临床特征是</p>
                        <p><input type="checkbox"/>A. 发烧、贫血、肝脾及淋巴结肿大<br/>
                        <input type="checkbox"/>B. 高烧、出血、白细胞及血小板减少<br/>
                        <input type="checkbox"/>C. 贫血、出血、恶病质及白细胞增多<br/>
                        <input type="checkbox"/>D. 贫血、发热、出血、器官组织浸润</p>
                    	<input type="button" class="fb-btn fr" value="确定" onclick="checkMultiResult(this,'Y');"/>
                   		<span style="display: none;"><img src="<s:url value='/jsp/edu/css/images/gou.png'/>"/>&#12288;恭喜你，答对了！</span>
                    </dd>
                </dl>
                <span id="testResultSpan" style="display: none;">
                	<input type="button" id="nextChapter" class="fb-btn fr" value="重新考试" onclick="reExam();"/>
	                <span style="float:left;margin: 18px 20px 0 0;font-size: 15px;"><img src="<s:url value='/jsp/edu/css/images/gou.png'/>"/>&nbsp;&nbsp;&nbsp;<strong class="score-num">4 题</strong>&nbsp;&nbsp;<img src="<s:url value='/jsp/edu/css/images/del3.png'/>"/>&nbsp;&nbsp;&nbsp;<strong class="score-num">3 题</strong>&nbsp;&nbsp;得分：<strong class="score-num">55分</strong>&nbsp;&nbsp;<font style="color:#ff0000; padding-left:10px;">很遗憾，您没有通过此次考试！</font></span>
          		</span>
          	</form>
          	<form id="reexamForm" style="display: none;">
       		<h3 id="reradioTitle">一、单选题</h3>
            	<dl>
                	<dt class="fl">1</dt>
                    <dd class="fl">
                    	<p>近视的原因主要是由于眼球的</p>
                        <p><input type="radio" name="item1" onclick="checkResult(this);"/>A. 前后径过短，物像在视网膜之前<br/>
							<input type="radio" name="item1" onclick="checkResult(this);"/>B. 前后径过短，物像在视网膜之后<br/>
							<input type="radio" name="item1" onclick="checkResult(this);"/>C. 前后径过长，物像在视网膜之前<br/>
							<input type="radio" name="item1" onclick="checkResult(this);"/>D. 前后径过长，物像在视网膜之后
						</p>
                   		<span style="display: none;"><img src="<s:url value='/jsp/edu/css/images/gou.png'/>"/>&#12288;恭喜你，答对了！</span>
                    </dd>
                </dl>
                <dl style="display: none;">
                	<dt class="fl">2</dt>
                    <dd class="fl">
                    	<p>正常成人的颅内压力约为</p>
                        <p><input type="radio" name="item2" onclick="checkResult(this);"/>A. 0.11110～0.29Kpa(10～30mm水柱)<br/>
                        <input type="radio" name="item2" onclick="checkResult(this);"/>B. 0.29～0.59Kpa(30～60mm水柱)<br/>
                        <input type="radio" name="item2" onclick="checkResult(this);"/>C. 1.96～2.25Kpa(200～230mm水柱)<br/>
                        <input type="radio" name="item2" onclick="checkResult(this);"/>D. 0.78～1.70Kpa(80～180mm水柱)
                        </p>
                    	<span style="display: none;"><img src="<s:url value='/jsp/edu/css/images/del3.png'/>"/>&#12288;您答错了！标准答案是：D. 0.78～1.70Kpa(80～180mm水柱)</span>
                    </dd>
                </dl>
                <dl style="display: none;">
                	<dt class="fl">3</dt>
                    <dd class="fl">
                    	<p>典型心绞痛发作持续时间约？分钟</p>
                        <p><input type="radio" name="item3" onclick="checkResult(this);"/>A. 2～3<br/>
                        <input type="radio" name="item3" onclick="checkResult(this);"/>B. 3～5<br/>
                        <input type="radio" name="item3" onclick="checkResult(this);"/>C. 5～7<br/>
                        <input type="radio" name="item3" onclick="checkResult(this);"/>D. 7以上</p>
                    	<span style="display: none;"><img src="<s:url value='/jsp/edu/css/images/gou.png'/>"/>&#12288;恭喜你，答对了！</span>
                    </dd>
                </dl>
                <dl style="display: none;">
                	<dt class="fl">4</dt>
                    <dd class="fl">
                    	<p>健康人进入高原地区(4000M)或通气不良矿井，发生缺氧主要是因为:</p>
                        <p><input type="radio" name="item4" onclick="checkResult(this);"/>A. 吸入气氧分压过低<br/>
                        <input type="radio" name="item4" onclick="checkResult(this);"/>B. 肺部气体交换障碍<br/>
                        <input type="radio" name="item4" onclick="checkResult(this);"/>C. 肺血液循环功能下降<br/>
                        <input type="radio" name="item4" onclick="checkResult(this);"/>D. 血液携带氧能力降低
                        </p>
                    	<span style="display: none;"><img src="<s:url value='/jsp/edu/css/images/del3.png'/>"/>&#12288;您答错了！标准答案是：A. 吸入气氧分压过低</span>
                    </dd>
                </dl>
                <h3 style="margin-top: 12px;display: none;">二、多选题</h3>
                <dl style="display: none;">
                	<dt class="fl">1</dt>
                    <dd class="fl">
                    	<p>急性白血病的临床特征是</p>
                        <p><input type="checkbox"/>A. 发烧、贫血、肝脾及淋巴结肿大<br/>
                        <input type="checkbox"/>B. 高烧、出血、白细胞及血小板减少<br/>
                        <input type="checkbox"/>C. 贫血、出血、恶病质及白细胞增多<br/>
                        <input type="checkbox"/>D. 贫血、发热、出血、器官组织浸润</p>
                   		<input type="button" class="fb-btn fr" value="确定" onclick="checkMultiResult(this,'');"/>
                   		<span style="display: none;"><img src="<s:url value='/jsp/edu/css/images/gou.png'/>"/>&#12288;恭喜你，答对了！</span>
                    </dd>
                </dl>
                <dl style="display: none;">
                	<dt class="fl">2</dt>
                    <dd class="fl">
                    	<p>急性白血病的临床特征是</p>
                        <p><input type="checkbox"/>A. 发烧、贫血、肝脾及淋巴结肿大<br/>
                        <input type="checkbox"/>B. 高烧、出血、白细胞及血小板减少<br/>
                        <input type="checkbox"/>C. 贫血、出血、恶病质及白细胞增多<br/>
                        <input type="checkbox"/>D. 贫血、发热、出血、器官组织浸润</p>
                    	<input type="button" class="fb-btn fr" value="确定" onclick="checkMultiResult(this,'');"/>
                   		<span style="display: none;"><img src="<s:url value='/jsp/edu/css/images/del3.png'/>"/>&#12288;您答错了！标准答案是：B、D</span>
                    </dd>
                </dl>
                <dl style="display: none;">
                	<dt class="fl">3</dt>
                    <dd class="fl">
                    	<p>急性白血病的临床特征是</p>
                        <p><input type="checkbox"/>A. 发烧、贫血、肝脾及淋巴结肿大<br/>
                        <input type="checkbox"/>B. 高烧、出血、白细胞及血小板减少<br/>
                        <input type="checkbox"/>C. 贫血、出血、恶病质及白细胞增多<br/>
                        <input type="checkbox"/>D. 贫血、发热、出血、器官组织浸润</p>
                    	<input type="button" class="fb-btn fr" value="确定" onclick="checkMultiResult(this,'N');"/>
                   		<span style="display: none;"><img src="<s:url value='/jsp/edu/css/images/gou.png'/>"/>&#12288;恭喜你，答对了！</span>
                    </dd>
                </dl>
                <span id="retestResultSpan" style="display: none;">
	                <span style="float:left;margin: 18px 20px 0 0;font-size: 15px;"><img src="<s:url value='/jsp/edu/css/images/gou.png'/>"/>&nbsp;&nbsp;&nbsp;<strong class="score-num">6 题</strong>&nbsp;&nbsp;<img src="<s:url value='/jsp/edu/css/images/del3.png'/>"/>&nbsp;&nbsp;&nbsp;<strong class="score-num">1 题</strong>&nbsp;&nbsp;得分：<strong class="score-num">80分</strong>&nbsp;&nbsp;<font style="color:#44b549; padding-left:10px;">恭喜你，通过此次考试！</font></span>
          		</span>
          	</form>
           </div>
           <div style="margin-top: 12px;text-align: center;">
		     	<input type="button" id="nextItemBtn" class="fb-btn" value="下一题" onclick="nextItem();"/>
		  </div>
   </div>
  </div>
</body>
</html>