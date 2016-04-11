<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@include file="/jsp/common/doctype.jsp" %>
<html>
<head>
<jsp:include page="/jsp/common/htmlhead.jsp">
	<jsp:param name="basic" value="true"/>
	<jsp:param name="jbox" value="true"/>
	<jsp:param name="jquery_validation" value="true"/>
	<jsp:param name="jquery_placeholder" value="true"/>
</jsp:include>
<link rel="stylesheet" type="text/css" href="<s:url value='/css/validationEngine.jquery.css'/>?v=${applicationScope.sysCfgMap['sys_version']}"></link>
<script type="text/javascript" src="<s:url value='/js/jquery.validationEngine-zh_CN.js'/>?v=${applicationScope.sysCfgMap['sys_version']}"></script>
<script type="text/javascript" src="<s:url value='/js/jquery.validationEngine${min}.js'/>?v=${applicationScope.sysCfgMap['sys_version']}"></script>
<script type="text/javascript">
$(function(){
	$("#evalSetDetailA").toggle(
			  function () {
			    $("#evalSetDetail").show();
			  },
			  function () {
			    $("#evalSetDetail").hide();
			  }
			);
	$("#projForm").validationEngine("attach",{
		binded:false,
		promptPosition : "bottomLeft",
		scroll:true,
		autoPositionUpdate: true,
		autoHidePrompt:true,
		maxErrorsPerField:1,
		showOneMessage : true
		});
});
	//立项编号
	function checkProjNo(obj){
		var projNo = obj.value;
		if(projNo == ''){
			return;
		}
		var url = "<s:url value = '/srm/proj/approve/checkProjNo?projNo='/>"+ projNo;
		jboxStartLoading();
		jboxGet(url ,null , function(data){
			if(data == "${GlobalConstant.FLAG_N}"){
		    	 $("#projNoMessage").text("项目编号已存在！");
		    	 $("input[name=isSave]").val("${GlobalConstant.FLAG_N}");
			}else{
		    	 $("#projNoMessage").text("可以使用此编号！");
		    	 $("input[name=isSave]").val("${GlobalConstant.FLAG_Y}");
			}
		}, null , false);
	}
	
	function saveApprove(result){
		$("#projForm").validationEngine("hideAll");
		var tip = "是否确认";
		if("${GlobalConstant.FLAG_Y}"==result){
			tip+="立项？";
			$('#projNo').addClass("validate[required,maxSize[50]]");
			$('#sug').removeClass("validate[required,maxSize[200]]");
		}else if("${GlobalConstant.FLAG_N}"==result){
			tip+='不立项？';
			$('#projNo').removeClass("validate[required,maxSize[50]]");
			$('#sug').addClass("validate[required,maxSize[200]]");
			$("input[name=isSave]").val("${GlobalConstant.FLAG_Y}");
		}
		var form = $('#projForm');
		if(false==form.validationEngine("validate")){
			return ;
		}
		var isSave = $("input[name=isSave]").val();
		if(isSave == "${GlobalConstant.FLAG_N}"){
			jboxTip("项目编号已存在！");
			return false;
		}
		jboxConfirm(tip , function(){
			var url ="<s:url value='/srm/proj/approve/saveSetUp'/>";
			$('#result').val(result);
			jboxStartLoading();
			jboxPost(url ,  $('#projForm').serialize() , function(resp){
				if(resp=='${GlobalConstant.FLAG_Y}'){
					jboxTip("操作成功");
					window.parent.frames['mainIframe'].window.searchProj();
					jboxClose();
				}else if(resp=='${GlobalConstant.FLAG_N}'){
					jboxTip("立项编号已存在");
				}
				
			} , null , false);
		});
		
	}

	function doClose() {
		jboxClose();
	}

</script>

</head>
<body>
	<div class="mainright">
    	<div class="content">
        	<div class="title1 clearfix">
        		<div>
        		<input type="hidden" name="isSave" value="${GlobalConstant.FLAG_N}"/>
        		<table>
        		<tr height="30px">
        			<td style="font-weight: bold;">项目名称：</td><td colspan="3"><a target="_blank" style="color:blue;" href="<s:url value='/srm/proj/mine/auditProjView?projFlow=${proj.projFlow}'/>">${proj.projName}</a></td>
        		</tr> 
        		<tr  height="30px">
        			<td style="font-weight: bold;">项目类型：</td>
        			<td width="200px">${proj.projTypeName}</td>
        			<td style="font-weight: bold;">起止时间：</td>
        			<td>${proj.projStartTime}~${proj.projEndTime}</td>
        		</tr>
        		<tr  height="30px">
        			<td style="font-weight: bold;">承担单位：</td>
        			<td>${proj.applyOrgName}</td>
        			<td style="font-weight: bold;">负责人：</td>
        			<td>${proj.applyUserName}</td>
        		</tr>
              </table>
              </div>
              
              <c:if test="${not empty evalSet}">
              <div>
              	<c:set var='agreeCount' value='0'></c:set>
					<c:set var='noAgreeCount' value='0'></c:set>
					<c:set var='noEvalCount' value='0'></c:set>
					<c:forEach var="expertProj" items="${expertProjList}">
						<c:if test="${empty expertProj.scoreResultId }">
							<c:set var='noEvalCount' value='${noEvalCount+1}'></c:set>
						</c:if>
						<c:if test='${expertProj.scoreResultId eq expertScoreResultEnumAgree.id}'>
							<c:set var='agreeCount' value='${agreeCount+1}'></c:set>
						</c:if>
						<c:if test='${expertProj.scoreResultId eq expertScoreResultEnumNotAgree.id}'>
							<c:set var='noAgreeCount' value='${noAgreeCount+1}'></c:set>
						</c:if>
					</c:forEach>
              	<table class="xllist">
              		<tr><th style="text-align: left;"> &#12288;立项评审信息：
              		${evalSet.evaluationWayName}&#12288;评审专家数：${expertProjList.size()}&#12288;
              		<c:choose>
              			<c:when test="${evalSet.evaluationWayId == evaluationWayEnumNetWorkWay.id }">
              				&#12288;同意：${agreeCount}&#12288;不同意：${noAgreeCount}&#12288;未评：${noEvalCount}&#12288;
              			</c:when>
              			<c:otherwise>
              				会评日期：${meeting.meetingDate }
              			</c:otherwise>
              		</c:choose>
              		&#12288;&#12288;[<a href='javascript:void(0);' id="evalSetDetailA">查看详细</a>]
              		</th></tr>
              	</table>
	        	  <div id='evalSetDetail' style="display: none;margin-bottom: 10px">
	        	  	<c:if test="${evalSet.evaluationWayId == evaluationWayEnumNetWorkWay.id }">
		        	  	<table class="xllist" >
							<thead>
								<tr>
									<th width="10%">姓名</th>
									<th width="10%">结果</th>
									<th width="10%">总分</th>
									<th width="70%">意见</th>
								</tr>
							</thead>
							<tbody>
								<c:forEach var="expertProj" items="${expertProjList}">
									<tr>
										<td>${expertProj.userExt.userName}</td>
										<td><c:if test='${ empty expertProj.scoreResultName}'>未评审</c:if><c:if test='${not empty expertProj.scoreResultName}'>${expertProj.scoreResultName}</c:if></td>
										<td>${expertProj.scoreTotal}</td>
										<td>${expertProj.expertOpinion}</td>
									</tr>
								</c:forEach>
							</tbody>
						</table>
					</c:if>
					<c:if test="${evalSet.evaluationWayId == evaluationWayEnumMeetingWay.id }">
						<table class="xllist" >
							<tr><td style="text-align: left;padding-left: 10px;">
							<b style="font-size: 15px;font-weight: bold;">会评意见：</b>${evalSet.evalOpinion}
							<td></tr>
						 </table>
					</c:if>
	        	  </div>
        	  </div>
        	  </c:if>
        	  <form  method="post" id="projForm" onsubmit="return false;">
	        	  <input type="hidden" name="projFlow" value="${proj.projFlow}"/>
	        	  <input type="hidden" name="result" id="result"/>
	        	  <table class='basic' width="100%" style="margin-top:10px;">
	        	  	<tr>
							<th colspan="4" style="text-align: left;">
	                            &#12288;<span style="font-weight: bold">项目立项意见：<font color="red"> 项目立项意见(最多200个字)</font></span>
	                        </th>
						</tr>
						<tr>
							<th style="width:150px">项目编号：</th>
							<td colspan="3">
								<input id="projNo" name="projNo" class="validate[required]" value="${proj.projNo}" style="width: 200px" onblur="checkProjNo(this)"/>
								<b id="projNoMessage" style="color: red;margin-left: 0px; text-decoration: none;"></b>
							</td>
						</tr>
						<tr>
	                        <th>
	                                                                                立项意见：
	                        </th>
	                        <td colspan="3" >
	                            <textarea id="sug" name="sug" class="validate[required,maxSize[200]]" rows="5" cols="20" style="margin-top:5px;margin-bottom:5px;width:95%; resize :none" placeholder="请填写意见..."></textarea>
	                        </td>
	                    </tr>
	        	  </table>
	        	  <c:if test='${setupFormPath!=null}'>
	        	      <jsp:include page="/jsp/${setupFormPath}.jsp"></jsp:include>
	        	  </c:if>
        	  </form>
        	  <div style='text-align: center;margin-top: 20px;'>
        	  		<input onclick="saveApprove('${GlobalConstant.FLAG_Y}');"  class="search" type="button" value="立&#12288;项"/>
        	  		<input onclick="saveApprove('${GlobalConstant.FLAG_N}');"  class="search" type="button" value="不&nbsp;立&nbsp;项"/>
               		<input onclick="doClose();" class="search" type="button"  value="关&#12288;闭"/>  
        	  </div>
        	</div>
      	</div>
 	</div>
</body>
</html>