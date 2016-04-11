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
</head>
<script type="text/javascript">
	
	function saveAudit(agreeFlag){
		if(agreeFlag=="${GlobalConstant.FLAG_Y}"){
			$('#auditContent').removeClass("validate[required,maxSize[200]]");
		}else{
			$('#auditContent').addClass("validate[required,maxSize[200]]");
		}
		if(false==$("#auditForm").validationEngine("validate")){
			return;
		}
		var tip =  agreeFlag=="${GlobalConstant.FLAG_Y}"?"审核通过":"退回";
		var url = "<s:url value='/srm/proj/terminate/saveAudit/${sessionScope.projListScope}/${sessionScope.projCateScope}'/>?agreeFlag="+agreeFlag;
		jboxConfirm("确认"+tip+"?" , function(){
			jboxStartLoading();
			jboxPost(url , $('#auditForm').serialize() , function(){
				window.parent.frames['mainIframe'].window.searchProj();
				jboxClose();
			} , null , true);
		});
	}
</script>
</head>

<body>
    <div class="mainright">
      <div class="content">
         <div class="title1 clearfix">
        	  <span style="font-weight: bold">您正在查看的学科：</span>
        	  <p>学科名称： ${proj.projName}</p>
              <p>
              	学科类型：${proj.projTypeName}
              	起止时间：${proj.projStartTime}~${proj.projEndTime}
              </p>
              <p>
              	承担单位：${proj.applyOrgName}
              	负责人：${proj.applyUserName}
              	<a class='search' href="<s:url value='/srm/proj/mine/auditProjView?projFlow=${proj.projFlow}&recTypeId=${projRecTypeEnumTerminateReport.id}'/>"  target="_blank">查&#12288;看</a>

              </p>
        </div>
          <hr/>
	<div >
	<form id="auditForm">
		 <table class="basic" cellpadding="0" cellspacing="0" style="width: 100%">
	        <tr>
	            <td style="background-image: url(../css/skin/${skinPath}/images/middle_left.jpg); background-repeat: repeat-y;padding: 0px;">
	            </td>
	            <td style="text-align: center;padding-left: 0px;">
	                <table  class="basic" cellpadding="0" cellspacing="0" style="width: 100%">
	                    <tr style="height: 25px; background-image: url(../css/skin/${skinPath}/images/top_bg.jpg); background-repeat: repeat-x">
	                        <td colspan="2" style="width: 100%; text-align: left">
	                            &#12288;&#12288;&#12288;<span style="font-weight: bold">学科审核信息：<font color="red"> 学科被退回时必须填写“审核意见”(最多200个字)</font></span>
	                        </td>
	                    </tr>
	                    <tr>
	                        <th style="width:17%">审核意见：</th>
	                        <td style="text-align: left;padding-left: 0px;">
	                            <textarea id="auditContent" name="auditContent" class="validate[maxSize[200]] textbox"  rows="6" cols="20"  style="width:100%;resize :none" placeholder="请填写审核意见..."></textarea>
	                        </td>
	                    </tr>
	                    <tr>
	                        <td colspan="2" style="padding: 0px;">
	                       		 <input type="hidden" name="projFlow" value="${proj.projFlow }"/>
	                        </td>
	                    </tr>
	                </table>
	            </td>
	        </tr>
	    </table>
	    <div style="margin-top: 20px;">
        <center>
                <input class='search' onclick="saveAudit('${GlobalConstant.FLAG_Y}')" type='button' value='同&#12288;意' />  
                <input class='search' onclick="saveAudit('${GlobalConstant.FLAG_N}')" type='button' value='不同意'/> 	
        </center>
        </div>
    </form>
	</div>
   </div>
   </div>
</body>
</html>
