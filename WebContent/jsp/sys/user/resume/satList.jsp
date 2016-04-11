<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<script type="text/javascript">
	function addSat(){
		jboxOpen("<s:url value='/pub/resume/editSat?userFlow=${userFlow}'/>", "添加获奖信息", 500, 350);
	}
	function editSat(satFlow){
		jboxOpen("<s:url value='/pub/resume/editSat?userFlow=${userFlow}&satFlow='/>"+satFlow, "编辑获奖信息", 500, 350);
	}
	
	function delSat(satFlow){
		jboxConfirm("确认删除?",function () {
			var url = "<s:url value='/pub/resume/delSat?satFlow='/>" + satFlow;
			jboxPost(url,null,function(resp){
				if(resp == '${GlobalConstant.DELETE_SUCCESSED}'){
					window.parent.frames['mainIframe'].window.loadSat();
					doClose();
				}
			},null,true);
		});
	}
</script>

<div>
	<table class="xllist" style="width: 100%">
		<tr>
			<th colspan="6" style="text-align: left;padding-left: 20px;" onclick="slideToggle('sat');">
				获奖
				<c:if test="${param.editFlag == GlobalConstant.FLAG_Y}">
					<a style="float: right; padding-right: 10px;" href="javascript:addSat()">[新增]</a>
				</c:if>
			</th>
		</tr>
		<tr>
           <th width="20%">科技名称</th>
	       <th width="20%">获奖级别</th>
	       <th width="10%">获奖等级</th>
	       <th width="10%">获奖日期</th>
	       <th width="25%">成果形式</th>
	       <c:if test="${param.editFlag == GlobalConstant.FLAG_Y}">
				<th style="width: 100px;">操作</th>
			</c:if>
		</tr>
		<c:if test="${! empty satList}">
		<tbody class="sat">
			<c:forEach items="${satList}" var="sat">
			   	 <tr>
			     	 <td>${sat.satName}</td>
			     	 <td>${sat.prizedGradeName}</td>
			     	 <td>${sat.prizedLevelName}</td>
			     	 <td>${sat.prizedDate}</td>
			     	 <td>${sat.achTypeName}</td>
			     	 <c:if test="${param.editFlag == GlobalConstant.FLAG_Y}">
				     	 <td style="width: 100px">
							[<a href="javascript:void(0)" onclick="editSat('${sat.satFlow}')">编辑</a>]
							[<a href="javascript:void(0)" onclick="delSat('${sat.satFlow}')">删除</a>]
						</td>
					 </c:if>
			   </tr>
			  </c:forEach>
		  </tbody>
		</c:if>
		<c:if test="${empty satList}">
			<tr>
	             <td colspan="6">无记录</td>
			</tr>
		</c:if>
	</table>
</div>
	

		
