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
<script type="text/javascript">
	function add() {
		jboxOpen("<s:url value='/edc/visit/editEdcGroup'/>", "新增组别", 500, 500);
	}
	function edit(groupFlow) {
		jboxOpen("<s:url value='/edc/visit/editEdcGroup?groupFlow='/>"+ groupFlow, "编辑组别信息", 500, 500);
	}		
	function del(groupFlow) {
		jboxGet("<s:url value='/edc/visit/delEdcGroupConfirm'/>?groupFlow="+groupFlow,null,function(resp){
			if(resp != '${GlobalConstant.OPRE_FAIL}'){
				jboxConfirm("确认删除该记录吗？",  function() {
					jboxGet( "<s:url value='/edc/visit/delEdcGroup?groupFlow='/>" + groupFlow,null,function(){
						window.location.reload(true);
					},null,true);
				}); 
			}else{
				jboxTip("已有该组别的访视页面，不能删除!");
			}
		},null,false);
	}
	function impEdcGroup(){
		jboxConfirm("确定导入?",function(){
			jboxGet("<s:url value='/edc/visit/impEdcGroup'/>",null,function(){
				window.location.reload(true);
			},null,true);
			});
	}
</script>
</head>
<body>
<div class="mainright">
	<div class="content">
		<c:if test="${isRandom }">
			<div style="margin-top: 20px;margin-bottom: 5px;">
				<c:choose>
					<c:when test="${projParam.designLock ==  GlobalConstant.FLAG_Y || projParam.projLock ==  GlobalConstant.FLAG_Y}">
						&#12288;<font color="red">当前项目已锁定设计，无法修改!</font>
					</c:when>
					<c:otherwise>
						<input type="button" class="search" onclick="add();" value="新&#12288;增">
						<!-- 
						<input type="button" class="search" onclick="impEdcGroup();" value="导&#12288;入">
						 -->
					</c:otherwise>
				</c:choose>
			</div>
		</c:if>
		<c:if test="${!isRandom}">
			<div style="margin-top: 20px;margin-bottom: 5px;">
			&#12288;<font color="red">当前项目不需要维护组别！</font>
			</div>
		</c:if>
		<div>
			<table class="xllist">
				<tr>
					<th width="50px">序号</th>
					<th width="100px">一级揭盲</th>
					<th width="100px">二级揭盲</th>
					<th width="100px">比例</th>
					<c:if test="${projParam.designLock !=  GlobalConstant.FLAG_Y && projParam.projLock !=  GlobalConstant.FLAG_Y}"> 
						<th width="150px">操作</th>
					</c:if>
				</tr>
				<c:forEach items="${groupList}" var="group">
					<tr style="height: 20px">
						<td>${group.ordinal}</td>
						<td>${group.groupCode}</td>
						<td>${group.groupName}</td>
						<td>${group.proportion}</td>
						<c:if test="${projParam.designLock !=  GlobalConstant.FLAG_Y && projParam.projLock !=  GlobalConstant.FLAG_Y}"> 
						<td>
							<c:if test="${projParam.designLock !=  GlobalConstant.FLAG_Y  && projParam.projLock !=  GlobalConstant.FLAG_Y}">
								[<a	href="javascript:edit('${group.groupFlow}');">编辑</a>] |
								[<a	href="javascript:del('${group.groupFlow}');">删除</a>] 
							</c:if>
						</td>
						</c:if>
					</tr>
				</c:forEach>
				<c:if test="${empty groupList }"> 
					<tr> 
						<td align="center" colspan="5">无记录</td>
					</tr>
				</c:if>
			</table>
		</div>
	</div>
</div>
</body>
</html>