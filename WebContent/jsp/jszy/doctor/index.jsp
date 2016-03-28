
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>${sysCfgMap['sys_title_name']}</title>
<jsp:include page="/jsp/jszy/htmlhead-jszy.jsp">
	<jsp:param name="basic" value="true"/>
	<jsp:param name="jbox" value="true"/>
	<jsp:param name="jquery_ui_tooltip" value="true"/>
	<jsp:param name="font" value="true"/>
	<jsp:param name="login" value="true"/>
</jsp:include>
<script>
$(document).ready(function(){
	$(".menu_item a").click(function(){
		$(".select").removeClass("select");
		$(this).addClass("select");
	});
	setBodyHeight();
});


function setBodyHeight(){
	if (navigator.appName.indexOf("Microsoft Internet Explorer")>-1) {//处理ie浏览器placeholder和password的不兼容问题
		if(navigator.appVersion.indexOf("MSIE 7.0")>-1){
			$("#indexBody").css("height",window.innerHeight+"px");
		}else if(navigator.appVersion.indexOf("MSIE 8.0")>-1){
			$("#indexBody").css("height",document.documentElement.offsetHeight+"px");
		}else{
			$("#indexBody").css("height",window.innerHeight+"px");
		}
    } else {
    	$("#indexBody").css("height",window.innerHeight+"px");
    }
}

onresize=function(){
	setBodyHeight();
}

function singup(){
	var url = "<s:url value='/jszy/doctor/singup'/>";
	jboxLoad("content", url, true);
}

function toPage(page) {
	if(page!=undefined){
		$("#currentPage").val(page);			
	}
	window.location.href="<s:url value='/jszy/doctor/home'/>?currentPage="+page;
} 

function msgToPage(page){
	msg(page);
}

function msg(page){
	var url = "<s:url value='/jszy/doctor/msg'/>?currentPage="+(page || "");
	jboxLoad("content", url, true);
}
function confirmRecruit(confirmFlag,recruitFlow){
	var requestData ={
			"recruitFlow":$.trim(recruitFlow),
			"confirmFlag":$.trim(confirmFlag)
	}
	var msg="确认同意该基地录取操作?";
	if(confirmFlag=="N"){
		msg="确认<font color='red'>拒绝并放弃</font>该基地的录取操作?";
	}
	jboxConfirm(msg,function (resp) {
		var url = "<s:url value='/jszy/doctor/confirmRecruit'/>";
		jboxPost(url ,requestData, function(resp){
			if(resp=="1"){
				jboxTip("操作成功");
				setTimeout(function(){
					window.location.href='<s:url value='/jszy/doctor/home'/>';
				},1000);
			}else{
				jboxTip("操作失败");
			}	
		} , null , false);
	});
	jboxClose();
}
function openDialog(recruitFlow){
	jboxOpenContent("<div style='text-align:center;'>"+'<span class="btn_green"  onclick="confirmRecruit('+"'Y'"+' , '+"'"+recruitFlow+"'"+');">确认录取</span>&nbsp;&nbsp;<span class="btn_red" onclick="confirmRecruit('+"'N'"+' , '+"' "+recruitFlow+" '"+')">放弃录取</span>'+"<div>","是否确认录取?",340,40,true);
}

/**
 * 安全中心
 */
function accounts(){
	jboxLoad("content","<s:url value='/hbres/singup/accounts'/>",true);
}
</script>
<style>
body{overflow:hidden;}
</style>
</head>
<body>
<div style="overflow:auto;" id="indexBody">
<div class="bd_bg">
<div class="yw">
<jsp:include page="/jsp/jszy/head.jsp">
    <jsp:param value="true" name="notice"/>
</jsp:include>
 <div class="body">
   <div class="container">
     <div class="content_side">
        <dl class="menu">
          <dt class="menu_title" >
            <i class="icon_menu menu_management"></i>志愿填报<input type="hidden" id="subMenuId" value=""/>
          </dt>
          <dd class="menu_item" id="main"><a onclick="singup();">网上报名</a></dd>
        </dl>
        <dl class="menu">
          <dt class="menu_title">
            <i class="icon_menu menu_setup"></i>设置
          </dt>
           <dd class="menu_item"><a href="javascript:accounts();">安全中心</a></dd>
        </dl>
     </div>
     <div class="col_main" id="content">
       <div class="content_main">
         <div class="index_show">
          <div class="index_tap top_left">
            <ul class="inner">
              <li class="index_item index_blue">
                <a>
                  <span class="tap_inner">
                    <i class="message"></i>
                    <em class="number" id="newMsg">${newMsg+0}</em>
                    <strong  class="title">新消息</strong>
                  </span>
                </a>
              </li>
              <li class="index_item index_blue">
                <a href="#" style="cursor: point;" onclick="singup();">
                  <span class="tap_inner tab_second">
                    <i class="people"></i>
                    <em class="number" style="font-size: 25px;">
                        <c:if test='${doctor==null}'>未填写</c:if>
                        <c:if test='${doctor!=null}'>${doctor.doctorStatusName}</c:if>
                    </em>
                    <strong  class="title">报名信息</strong>
                  </span>
                </a>
              </li>
            </ul>
          </div>
          <div class="index_tap top_right" >
            <ul class="inner">
              <li class="index_item index_green">
                <a href="#">
                  <span class="tap_inner Volunteer">
                  <c:if test='${empty recruit}'><span class="Volunteeer_none">志愿未填写</span></c:if>
                  <c:if test='${recruit!=null}'>	
                  <!--         调剂      开始        -->
                  <c:if test='${recruit.recruitTypeId eq recruitTypeEnumSwap.id}'>
	                    <table>
	                      <tr>
	                        <th width="80px">调剂基地：</th>
	                        <td>${recruit.orgName}</td>
	                      </tr>
	                      <tr>
	                        <th>调剂专业：</th>
	                        <td>
	                        	<c:if test="${recruit.catSpeId==speCatEnumZy.id }">${recruit.speName}(${recruit.catSpeName})</c:if>
	                        	<c:if test="${recruit.catSpeId==speCatEnumZyqk.id }">${recruit.speName}</c:if>
	                        </td>
	                      </tr>
	                      <tr>
	                        <th> <c:if test='${!empty recruit.recruitFlag}'>录取状态：</c:if></th>
	                        <td >
	                         <c:if test='${recruit.recruitFlag eq "Y"}'>
								   <c:choose>
				                        <c:when test='${recruit.confirmFlag eq null}'>
				                            	<span style="float: left; padding-right:5px; font-size:1em;">调剂<img src="<s:url value='/jsp/jszy/images/djqr.png' />" onclick='openDialog("${recruit.recruitFlow}");' title="点击确认录取" style="vertical-align: middle; margin-left:5px;" alt="" /> </span>
				                     	 </c:when>
				                     	 <c:otherwise>
					                     	 	<c:if test='${recruit.confirmFlag eq "N" }'><span >调剂</span><span>(放弃录取)</span></c:if>
					                     	 	<c:if test='${recruit.confirmFlag eq "Y" }'><span>调剂</span><span>(已确认)</span></c:if>
				                     	 </c:otherwise>
			                        </c:choose>
	                          </c:if>
	                        <c:if test='${recruit.recruitFlag eq "N"}'>未录取</c:if>
	                        </td>
	                      </tr>
	                    </table>  
                    </c:if>
                    <!-- 调剂   结束  -->
                    <!--   非调剂     开始 -->
                    <c:if test='${recruit.recruitTypeId eq  recruitTypeEnumFill.id}'>
                        <table>
	                      <tr>
	                        <th width="80px">志愿基地：</th>
	                        <td>${recruit.orgName}</td>
	                      </tr>
	                      <tr>
	                        <th>培训专业：</th>
	                        <td>
	                        	<c:if test="${recruit.catSpeId==speCatEnumZy.id }">${recruit.speName}(${recruit.catSpeName})</c:if>
	                        	<c:if test="${recruit.catSpeId==speCatEnumZyqk.id }">${recruit.speName}</c:if>
	                        </td>
	                      </tr>
	                      <tr>
	                        <th> <c:if test='${!empty recruit.recruitFlag}'>录取状态：</c:if></th>
	                        <td >
	                         <c:if test='${recruit.recruitFlag eq "Y"}'>
								   <c:choose>
				                        <c:when test='${recruit.confirmFlag eq null}'>
				                            	<span style="float: left; padding-right:5px; font-size:1em;">已录取<img src="<s:url value='/jsp/jszy/images/djqr.png' />" onclick='openDialog("${recruit.recruitFlow}");' title="点击确认录取" style="vertical-align: middle; margin-left:5px;" alt="" /> </span>
				                     	 </c:when>
				                     	 <c:otherwise>
					                     	 	<c:if test='${recruit.confirmFlag eq "N" }'><span>已录取(放弃录取)</span></c:if>
					                     	 	<c:if test='${recruit.confirmFlag eq "Y" }'><span>已录取(已确认)</span></c:if>
				                     	 </c:otherwise>
			                        </c:choose>
	                          </c:if>
	                        <c:if test='${recruit.recruitFlag eq "N"}'>未录取</c:if>
	                        </td>
	                      </tr>
	                    </table>  
                    </c:if>
                    <!-- 非调剂    结束 -->
                    </c:if>      
                  </span>
                </a>
              </li>
            </ul>
          </div>
        </div>
        <div class="main_bd" style="display: none">
		    <ul>
		        <li class="score_frame">
		            <h1>报名流程</h1>
		            <div class="index_table" >
		                <table cellpadding="0"  cellspacing="0" width="100%">
		                <colgroup>
		                  <col width="50%"/>
		                  <col width="50%"/>
		                </colgroup>
		                <tbody>
		                <tr>
			                <td class="" colspan="2">
			                	<h3>当前进度</h3>
								<div class="flowsteps" id="icn">
								  <ol class="num4">
							        <li class='first current'>
							          <span><i>1</i><em>网上报名</em></span>
							        </li>
							        <!-- class="done" -->
							        <li>
							          <span><i>2</i><em>基地审核</em></span>
							        </li>
							        <!--class="current"  -->
							        <li>
							          <span><i>3</i><em>志愿调剂</em></span>
							        </li>
							        <li class="last">
							          <span><i>4</i><em>完成</em></span>
							        </li>
							      </ol>
								</div>
								<!-- 
								<p>还未填写报名信息,请先填写报名信息</p>
								 -->
			                </td>
		                </tr>
		                </tbody>
		                </table>
		            </div>
		        </li>
		    </ul>
		</div>
		
		<script>
			function viewMsg(dl,msgFlow){
				var isSelect = dl.className.indexOf("msgselect")<0;
				$(".msgselect").removeClass("msgselect").find("dd").addClass("none");
				if(isSelect){
					$(dl).addClass("msgselect").find("dd").removeClass("none");
				}
				if(dl.className.indexOf("readed")<0){
					jboxPost("<s:url value='/jszy/doctor/readMsg'/>?msgFlow="+msgFlow+"&receiveFlag=${GlobalConstant.FLAG_Y}",null,function(resp){
						if(resp=="${GlobalConstant.OPRE_SUCCESSED_FLAG}"){
							$(dl).addClass("readed");
							var msgNum = parseInt($("#newMsg").text());
							$("#newMsg").text(--msgNum);
						}
					},null,false);
				};
			}
		</script>
		<div class="index_form" style="margin-bottom: 10px;">
          <h3>通知中心</h3>
<!-- 		<div class="main_hd"> -->
<!-- 			<h2>通知中心</h2> -->
<!-- 		</div> -->
		<div class="main_bd">
			<div id="notification" class="notificationCenterPage">
				<c:forEach items="${msgList}" var="msg">
					<dl class="notify_item <c:if test="${msg.receiveFlag eq GlobalConstant.FLAG_Y}"> readed</c:if>" onclick="viewMsg(this,'${msg.msgFlow}');">
						<dt>
							<a class="notify_title_wrapper">
								<span class="notify_status">
									<span class="notify_time">
										${pdfn:transDate(msg.msgTime)}
									</span>
									<i class="noticearrow"></i>
								</span>
								<span class="notify_title">
									<i class="dot">●</i>
									${msg.msgTitle}
								</span>
							</a>
						</dt>
						<dd class="none">
							${msg.msgContent}
						</dd>
					</dl>
				</c:forEach>
				<c:if test="${empty msgList}">
					<dl class="notify_item" style="text-align: left;padding-left: 50px;">
						<dt>
							暂无通知！
						</dt>
					</dl>
				</c:if>
			</div>
		</div>
		</div>
		<c:if test="${!empty msgList}">
	        <div class="page" style="padding-right: 40px;">
	       	 <input id="currentPage" type="hidden" name="currentPage" value=""/>
	           <c:set var="pageView" value="${pdfn:getPageView(msgList)}" scope="request"></c:set>
		  		 <pd:pagination-hbres toPage="toPage"/>	 
	        </div>
		</c:if>
       </div>
     </div>
   </div>
 </div>
</div>
</div>
<c:if test="${applicationScope.sysCfgMap['online_service']=='Y'}">
    <jsp:include page="/jsp/service.jsp"></jsp:include>
</c:if>
<jsp:include page="/jsp/jszy/foot.jsp" />
</div>
</body>
</html>
