<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>湖北省住院医师规范化培训招录系统</title>
<jsp:include page="/jsp/hbres/htmlhead-hbres.jsp">
	<jsp:param name="basic" value="true"/>
	<jsp:param name="jbox" value="true"/>
	<jsp:param name="font" value="true"/>
	<jsp:param name="jquery_validation" value="true"/>
	<jsp:param name="jquery_placeholder" value="true"/>
	<jsp:param name="jquery_ui_combobox" value="true"/>
</jsp:include>

<script type="text/javascript">
$(document).ready(function(){
	var fcombobox = $("#orgFlow").scombobox({
		forbidInvalid : true,
		invalidAsValue : true,
		expandOnFocus : false
	});
	$(".scombobox-display").addClass("validate[required]");
	initBindSpeInfo(fcombobox , "speId");
	
});

    function initBindSpeInfo(combobox , speId){
    	combobox.bind("change" , function(){
    		var orgFlow = $(this).val();
    		var url = "<s:url value='/hbres/singup/doctor/findspe'/>?orgFlow="+orgFlow;
    		jboxGet(url , null , function(resp){
    			$("#"+speId).empty();
    			$("#"+speId).append("<option value=''>请选择</option>");
    			$.each(resp , function(i , n){
    				$("#"+speId).append("<option value='"+n.recordFlow+"'>"+n.speName+"</option>");
    			});
    		} , null , false);
    	});
    }
    
	function submitRecruit(){
		jboxConfirm("确认提交？" , function(){
			if($("#recruitForm").validationEngine("validate")){
				jboxStartLoading();
            	$("#recruitForm").submit();
			}
		});
		
	}
	
	function showIntro(){
		var swapFlag = $("#swapFlag");
		if(swapFlag.attr("checked")){
			jboxConfirm("勾选后表示当您未被当前填报专业录取后同意院方调剂至其他专业!" , function(){
			}  , function(){
				swapFlag.attr("checked" , false);
			});
		}
	}
	
	function confirmRecruit(recruitFlow , confirmFlag){
		var tip = "确认";
		if(confirmFlag=="Y"){
			tip=tip+"录取？";
		}else if(confirmFlag=="N"){
			tip = tip+"拒绝录取？";
		}
		jboxConfirm(tip , function(){
			jboxPost("<s:url value='/hbres/singup/doctor/confirmrecruit'/>" , {"recruitFlow":recruitFlow,"confirmFlag":confirmFlag} , function(resp){
				if(resp=="1"){
					jboxTip("操作成功");
					location.href="<s:url value='/hbres/singup/doctor/scoreSearch'/>";
				}else{
					jboxTip("操作失败");
				}
			} , null , false);
		});
	}
	
	function delRecruit(recruitFlow){
		jboxConfirm("确认撤销？", function(){
			jboxGet("<s:url value='/hbres/singup/doctor/delrecruit'/>?recruitFlow="+recruitFlow , null , function(resp){
				if(resp=="1"){
					top.jboxTip("操作成功");
					location.href="<s:url value='/hbres/singup/doctor/scoreSearch'/>";
				}else{
					jboxTip("操作失败");
				}
			} , null , false);
		});
	}
	
	function showJidiRecruitInfo(){
		jboxOpen("<s:url value='/hbres/singup/doctor/showjidirecruitinfo'/>","基地招录信息",1000,500);
	}
	
	function removeMsg(){
		$("#msg").html("");
	}
	
	function initTrain(recruitFlow){
		window.open("<s:url value='/hbres/singup/doctor/initTrain'/>?recruitFlow="+recruitFlow);
	}
</script>
</head>

<body>
  <div class="main_wrap">
    <div class="zy_contain bs_search">
      <h1>笔试成绩查询</h1>
      <ul>
        <li class="score">您的笔试分数为：<span class="score_inner">${examDoctor.examResult}</span>分</li>
        <li>${fillMsg}</li>
      </ul>
    </div> 
    <c:if test="${showCfgDate!='N'}">
    <div class="zy_contain cjcx_tips">
        <span><font>志愿填报日期：</font>${recruitCfg.wishBeginDate}~${recruitCfg.wishEndDate}</span>
        <span><font>确认录取结果日期：</font>${recruitCfg.admitBeginDate}~${recruitCfg.admitEndDate}</span>
        <span><font>学员调剂日期：</font>${recruitCfg.swapBeginDate}~${recruitCfg.swapEndDate}</span>
    </div>
     <div class="zy_contain cjcx_tips">
        <span style="width: 100%">*凡是有执医资格证的学员不能进行专业调剂，只能进行基地医院调剂</span>
    </div>
    </c:if>
    <c:if test='${isShowRecruits}'>
    <form id="recruitForm" name="recruitForm" method="post" action="<s:url value='/hbres/singup/doctor/submitrecruit'/>">
    <input type="hidden" name="examResult" value="${examDoctor.examResult}"></input>
    <div class="zy_contain bs_tbzy">
      <h1>填报志愿 
          <span style="color: red;font-size: 18px;" id="msg">
          	<c:choose>
          		<c:when test="${param.msg eq '0' }">志愿填报成功</c:when>
          		<c:when test="${param.msg eq '1' }">该基地所填报志愿专业人数已满</c:when>
          		<c:when test="${param.msg eq '-1' }">所填志愿专业没有招录计划</c:when>
          		<c:otherwise>
          		</c:otherwise>
          	</c:choose>
          </span>
          <c:if test='${isSwapFill eq "Y" }'>
              <span class="fr" style="margin-right:10px;margin-top:13px;"><a href="javascript:void(0);" class="btn_green" onclick="showJidiRecruitInfo();">查看基地招录情况</a></span>
          </c:if>
      </h1>
      <table cellpadding="0" cellspacing="0" border="0" class="grey_tab">
          <tr>
            <th>序号</th>
            <th>医院</th>
            <th>专业</th>
            <th>服从专业调剂</th>
            <th>填报类型</th>
            <th>技能<br/>/面试成绩</th>
            <th>总成绩</th>
            <th>操作/结果</th>
          </tr>
          <c:set var="inx" value="0"></c:set>
          <c:set var="confirmFlag" value="" />
          <c:set var="recruitFlow" value="" />
          <c:forEach items="${doctorRecruits}" varStatus="status" var="recruit">
             <c:set var="inx" value="${status.count}"></c:set>
             <c:set var="confirmFlag" value="${recruit.confirmFlag }" />
             <c:set var="recruitFlow" value="${recruit.recruitFlow }" />
             <tr>
              <td>${status.count}</td>
              <td >
                ${recruit.orgName}
            </td>
            <td>
                 ${recruit.speName}
            </td>
            <td><input name="swapFlag" type="checkbox" readonly="readonly" disabled="disabled" <c:if test='${recruit.swapFlag eq "Y"}'>checked="checked"</c:if>/></td>
            <td>${recruit.recruitTypeName}</td>
            <td>${recruit.operResult}/${recruit.auditionResult}</td>
            <td>${recruit.totleResult}</td>
            <td style="color: red">
                <c:choose>
                    <c:when test='${recruit.confirmFlag eq "F"}'>
                        <span>过期</span>
                    </c:when>
                    <c:when test='${recruit.confirmFlag eq "N"}'>
                        <span>放弃录取</span>
                    </c:when>
                    <c:when test='${recruit.confirmFlag eq "Y"}'>
                        <span>已确认(请按录取通知时间报道)</span>
                    </c:when>
                    <c:when test='${recruit.recruitFlag eq "N"}'>
                        <span>未录取</span>
                    </c:when>
                    <c:when test='${(recruit.recruitFlag eq "Y") and (empty recruit.confirmFlag)}'>
                        <c:if test='${isConfirm eq "Y"}'>
                            <input type="button" onclick="confirmRecruit('${recruit.recruitFlow}' , '${GlobalConstant.FLAG_Y}');" class="btn_green" value="确认录取"></input>
                            <input type="button" onclick="confirmRecruit('${recruit.recruitFlow}' , '${GlobalConstant.FLAG_N}');" class="btn_blue"  value="放弃"></input>
                        </c:if>
                        <c:if test='${isConfirm eq "N"}'>
                            <span>当前录取结果未公布，请耐心等待...</span>
                        </c:if>
                        <c:if test='${isConfirm eq "F"}'>
                            <span>确认录取时间已截止</span>
                        </c:if>
                    </c:when>
                    <c:when test="${recruit.retestFlag eq 'N'}">
                        <span>志愿已填报，请等待基地通知.</span><br/>
                        <c:if test="${pdfn:signDaysBetweenTowDate(pdfn:getCurrDate(),recruitCfg.wishEndDate)<=0}">
                        <a class="btn_blue" href="javascript:void(0);" onclick="delRecruit('${recruit.recruitFlow}');">撤销</a>
                        </c:if>
                    </c:when>
                    <c:when test="${recruit.retestFlag eq 'Y'}">
                        <span>复试通知已发送.</span>
                    </c:when>
                </c:choose>
            </td>
            </tr>
          </c:forEach>
          <!--<c:set var='isFill' value='${(doctorRecruit==null) or (doctorRecruit.recruitFlag eq "N") or (doctorRecruit.recruitFlag eq "Y" and doctorRecruit.confirmFlag eq "N")}'></c:set>-->
          <c:if test='${isCanFill eq "Y" || isSwapFill eq "Y"}'>
          <tr class="odd">
            <td>${inx+1}</td>
            <td style="width: 300px;">
                <select class="validate[required]" id="orgFlow" name="orgFlow" style="width:230px;">
				    <option value="请选择">请检索</option>
					    <c:forEach var="sysOrg" items="${hospitals}">
							<option value="${sysOrg.orgFlow}">${sysOrg.orgName}</option>
						</c:forEach>
				</select>
            </td>
            <td>
            <select id="speId" name="speId" class="validate[required] select" style=" width:230px;" id="spe_1" onchange="removeMsg();">
               <option value="">请选择</option>
            </select>
            </td>
            <td><input id="swapFlag" name="swapFlag" type="checkbox" value="Y" onchange="showIntro();"></input></td>
            <td></td>
            <td></td>
            <td></td>
            <td></td>
          </tr>
          </c:if>
        </table>
        
        <div class="button">
        <c:if test='${isCanFill eq "Y" || isSwapFill eq "Y"}'>
        	<input type="button" class="btn_blue" style=" width:100px;" onclick="submitRecruit();" value="提交"></input>  
        </c:if>
        <c:if test="${GlobalConstant.FLAG_Y eq applicationScope.sysCfgMap['res_hbres_on'] && GlobalConstant.FLAG_Y eq confirmFlag }">
        	<input type="button" class="btn_red" style=" width:100px;" onclick="initTrain('${recruitFlow}');" value="开始培训"></input>  
        </c:if>
        </div>
    </div>
    </form>
    </c:if>
   
   <div id='recruitInfo'>
   <!-- 复试通知 -->
   <c:if test="${doctorRecruit.retestFlag eq 'Y'}">
    <div class="zy_contain bs_fstz">
      <h1>复试通知</h1>
      <div class="form_news">
        <h3>${doctorRecruit.orgName}通知</h3>
        <div>
            ${doctorRecruit.retestNotice}
        </div>
      </div>
    </div>
    </c:if>
    
    <!-- 复试成绩开始 -->
    <c:if test="${doctorRecruit.operResult!=null and doctorRecruit.auditionResult!=null}">
    <div class="zy_contain bs_fscj">
      <h1>复试成绩</h1>
      <ul>
        <li class="bs_yy">${doctorRecruit.orgName} : ${doctorRecruit.speName}</li>
        <li class="bs_cj"><!-- <img src="<s:url value='/jsp/hbres/images/basic/bhg_small.png'/>" /> --></li>
        <li class="bs_cj"><span class="blue">${doctorRecruit.operResult}分</span> <br />技能成绩</li>
        <li class="bs_cj"><span class="yellow">${doctorRecruit.auditionResult}分</span> <br />面试成绩</li>
      </ul>
    </div>
    </c:if>
    <!-- 复试成绩结束 -->
    
    <!-- 录取通知 -->
   <c:if test="${doctorRecruit.admitFlag eq 'Y'}">
    <div class="zy_contain bs_fstz">
      <h1>录取通知</h1>
      <div class="form_news">
        <h3>${doctorRecruit.orgName}通知</h3>
        <div>${doctorRecruit.admitNotice}</div>
      </div>
    </div>
    </c:if>
    <!-- 录取通知结束 -->
   </div> 
  </div>
</body>
</html>
