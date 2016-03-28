<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
	<p><b style="font-size: 15px">二、会评项目</b>&nbsp;<img title="新增" src="<s:url value="/css/skin/${skinPath}/images/add3.png" />" style="cursor: pointer;" onclick="addEvalProjUI()" ></img></p>
	<script type="text/javascript">
		function expertRecord(evalSetFlow){
			var url ='<s:url value="/srm/meeting/expertScore"/>?evalSetFlow='+evalSetFlow;
			jboxStartLoading();
			jboxOpen(url , "评审结果" , 800 , 600);
		}
	</script>
	<table class="xllist" style="margin-top: 10px;">
					<thead>
						<tr>
							<th width="5%">序号</th>
							<th width="10%">项目编号</th>
							<th width="20%">项目名称</th>
							<th width="10%">项目类别</th>
							<th width="20%">承担单位</th>
							<th width="10%">评审类别</th>
							<th width="10%">审查记录</th>
						</tr>
					</thead>
					<tbody id="evalProjList">
						<c:forEach items="${expertGroupProjList}" var="expertGroupProj" varStatus="status">
						<tr>
							<td>${status.count}</td>
							<td>${expertGroupProj.pubProj.projNo}</td>
							<td>${expertGroupProj.pubProj.projName}</td>
							<td>${expertGroupProj.pubProj.projTypeName}</td>
							<td>${expertGroupProj.pubProj.applyOrgName}</td>
							<td>${expertGroupProj.evaluationName}</td>
							<td>
								[<a href="javascript:expertRecord('${expertGroupProj.evalSetFlow}')">评分</a>] &#12288;
								<c:if test='${not isDelMap[expertGroupProj.pubProj.projFlow]}'>
									[<a href="javascript:cancelEvalSet('${expertGroupProj.evalSetFlow}');">删除</a>]
								</c:if>
							</td>
						</tr>
						</c:forEach>
					</tbody>
				</table>