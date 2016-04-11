<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@include file="/jsp/common/doctype.jsp"%>
<html>
<head>
<jsp:include page="/jsp/common/htmlhead.jsp">
	<jsp:param name="basic" value="true" />
	<jsp:param name="jbox" value="true" />
	<jsp:param name="jquery_form" value="false" />
	<jsp:param name="jquery_ui_tooltip" value="true" />
	<jsp:param name="jquery_ui_combobox" value="false" />
	<jsp:param name="jquery_ui_sortable" value="false" />
	<jsp:param name="jquery_cxselect" value="true" />
	<jsp:param name="jquery_scrollTo" value="false" />
	<jsp:param name="jquery_jcallout" value="false" />
	<jsp:param name="jquery_validation" value="true" />
	<jsp:param name="jquery_datePicker" value="true" />
	<jsp:param name="jquery_fullcalendar" value="false" />
	<jsp:param name="jquery_fngantt" value="false" />
	<jsp:param name="jquery_fixedtableheader" value="true" />
	<jsp:param name="jquery_placeholder" value="true" />
	<jsp:param name="jquery_iealert" value="false" />
</jsp:include>
<script type="text/javascript">
	function saveOrg(){
		var addResult = [];
		var delResult = [];
		$(":checkbox:checked:not([isResult])").each(function(){
			addResult.push(this.value);
		});
		$(":checkbox[isResult]:not(:checked)").each(function(){
			delResult.push($(this).attr("isResult"));
		});
		
		var data = "";
		if(addResult.length>0){
			data += "&";
			data+=serializeList("jointOrgFlows",addResult);
		}
		if(delResult.length>0){
			data+=("&"+serializeList("delJointFlows",delResult));
		}
		if((addResult.length+delResult.length)<=0){
			top.jboxTip("${GlobalConstant.SAVE_SUCCESSED}");
			window.parent.document.mainIframe.search();
			return jboxClose();
		}
		var url = "<s:url value='/res/platform/save'/>?orgFlow=${org.orgFlow}";
		jboxPost(url,data, function(obj) {
			if(obj=="${GlobalConstant.SAVE_SUCCESSED}"){
				window.parent.document.mainIframe.search();
				jboxClose();
				}
			});
		}
	function serializeList(name,list){
		var result = "";
		for(var index in list){
			if(result){
				result+=("&"+name+"="+list[index]);
			}else{
				result+=(name+"="+list[index]);
			}
		}
		return result;
	}
	//模糊查询
	function likeSearch(name){
		if(name){
			$("[orgName]").hide();
			$("[orgName*='"+name+"']").show();
		}else{
			$("[orgName]").show();
		}
	}
</script>
</head>
<body>
	<div class="mainright">
		<div class="content">
				<table class="basic" style="width: 100%;">
					<tr>
						<th style="width: 10%; text-align:left; padding-left: 10px;">机构名称</th>
						<td>${org.orgName }</td>
					</tr>
					<tr>
						<th colspan="2" style="text-align: left; padding-left: 10px;">
							协同机构
							<input placeholder="输入机构名称搜索" type="text" value="" style="float: right;" onkeyup="likeSearch(this.value);"/>
						</th>
					</tr>
					<tr>
							<td colspan="2" id="jointId">
								<c:forEach items="${resultList}" var="orgl">
									<div style="width: 24%;float: left;" orgName="${orgl.orgName}"> 
										<label><input type="checkbox" name="jointOrgFlows" value="${orgl.orgFlow}" <c:if test="${!empty jointMap[orgl.orgFlow]}">checked isResult="${jointMap[orgl.orgFlow].jointFlow}"</c:if>/>${orgl.orgName}</label>
									</div>
								</c:forEach>
							</td>
					</tr>
				</table>
				<div class="button" style="width: 800px;">
					<input class="search" type="button" value="保&#12288;存" onclick="saveOrg();"/>
					<input class="search" type="button" value="关&#12288;闭" onclick="jboxClose();"/>
				</div>
		</div>
	</div>
</body>
</html>