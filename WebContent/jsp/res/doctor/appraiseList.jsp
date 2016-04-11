<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@include file="/jsp/common/doctype.jsp"%>
<html>
<head>
<jsp:include page="/jsp/common/htmlhead.jsp">
	<jsp:param name="basic" value="true" />
	<jsp:param name="jbox" value="true" />
	<jsp:param name="jquery_ui_tooltip" value="true" />
</jsp:include>
<script type="text/javascript">
	function showRecList(reqFlow){
		$("#"+reqFlow).slideToggle(500);
		if(reqFlow in openRec){
			delete openRec[reqFlow];
		}else{
			openRec[reqFlow] = reqFlow;
		}
	}
	$(function(){
		if(!$.isEmptyObject(openRec)){
			var newOpenRec = openRec;
			openRec = {};
			for(var key in newOpenRec){
				showRecList(key);
			}
		}
	});
</script>
</head>
<body>
<div class="mainright">
	<div class="content">
		<div class="title1 clearfix">
<!-- 			<table class="basic" style="margin-bottom: 10px;width:100%;"> -->
<!-- 	          <tr> -->
<!-- 	            <td style="text-align: center;font-weight: bold;color: black;font-size: 15px;line-height: 15px;">带&nbsp;教&nbsp;老&nbsp;师&nbsp;审&nbsp;核</td> -->
<!-- 	          </tr> -->
<!-- 	       </table> -->
		    <c:if test="${!empty appraiseMap['deptAppraise']}">
			    <c:forEach items="${appraiseMap['deptAppraise']}" var="appraise" varStatus="num">
					<table class="basic" style="margin-bottom: 10px;width: 100%;">
						<tr>
						    <th style="text-align: left;padding-left: 10px;">
						    	${num.count }、审核时间：${pdfn:transDateTime(appraise.operTime)}
						    	&#12288;&#12288;
						    	<span style="display: inline-block;width: 150px;">
						    		审核人：${appraise.operUserName}
						    	</span>
						    	审核结果：${appraise.auditStatusName}
						    </th>
						</tr>
						<tr> 
							<td><pre style="font-family: Microsoft Yahei;line-height:25px;">${appraise.appraise}</pre></td>
						</tr>
					</table>
			    </c:forEach>
		    </c:if>
		    <c:if test="${empty appraiseMap}">
		       <table class="basic" style="margin-bottom: 10px;width:100%;">
		          <tr>
		            <td style="text-align: center;">无记录</td>
		          </tr>
		       </table>
		    </c:if>
			<div style="width: 100%;" align="center" >
				<input class="search" type="button" value="关&#12288;闭" onclick="jboxClose()" />
			</div>
		</div>
	</div>
</div>
</body>
</html>