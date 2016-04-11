<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<style type="text/css">
.ui-recent-footer {
	padding: 12px 9px;
	height: 16px;
	line-height: 16px;
	text-align: right;
}
</style>
<script type="text/javascript">
function editResearcher(projFlow){
	jboxOpen("<s:url value='/gcp/proj/chooseUser'/>?projFlow=" + projFlow + "&addFlag=${GlobalConstant.FLAG_Y}","编辑主要研究者",900,350);
}
function editTeamer(projFlow){
	jboxOpen("<s:url value='/gcp/proj/editTeamer?projFlow='/>" +projFlow,"编辑项目成员",900,350);
}
</script>
<div class="i-trend-main-div">
	<table class="i-trend-main-table i-trend-main-div-table"  border="0" cellpadding="0" cellspacing="0" width="100%">
		<colgroup>
            <col width="10%" />
            <col width="15%" />
            <col width="15%" />
            <col width="15%" />
            <col width="30%" />
          </colgroup>
           <tr><th colspan="5" class="ith">
			  <span>主要研究者</span>
			  	 <c:if test="${param.roleScope eq GlobalConstant.ROLE_SCOPE_GO && empty researcherUser}">
			    <i class="i-trend-main-back"><a href="javascript:void(0)" onclick="editResearcher('${param.projFlow}')" title="点击修改"></a></i>
			    </c:if>
			 </th></tr>
		   <tr>
            <th>姓名</th>
            <th>科室</th>
            <th>职务</th>
            <th>手机</th>
            <th>邮箱</th>
          </tr>
          <tr>
			<td>${researcherUser.userName}</td>
			<td>${researcherUser.deptName}</td>
			<td>${researcherUser.postName}</td>
			<td>${researcherUser.userPhone}</td>
			<td>${researcherUser.userEmail}</td>
		  </tr>
	</table>
</div>
<div class="i-trend-main-div">
	<table class="i-trend-main-table i-trend-main-div-table"  border="0" cellpadding="0" cellspacing="0" width="100%">
		<colgroup>
            <col width="10%" />
            <col width="15%" />
            <col width="15%" />
            <col width="15%" />
            <col width="30%" />
          </colgroup>
           <tr><th colspan="5" class="ith">
			  <span>项目成员</span>
			    <c:if test="${param.roleScope != GlobalConstant.ROLE_SCOPE_DECLARER}">
			    <i class="i-trend-main-back" ><a href="javascript:void(0)" onclick="editTeamer('${param.projFlow}')" title="点击修改"></a></i>
			    </c:if>
			  </th>
		   </tr>
		   <tr>
            <th>姓名</th>
            <th>职称</th>
            <th>职务</th>
            <th>GCP培训日期</th>
            <th>研究岗位</th>
          </tr>
          <c:forEach items="${filterList}" var="filter" varStatus="status">
          <tr <c:if test="${status.count%2==0}"> class="odd" </c:if> >
			<td>${filter.user.userName}</td>
			<td>${filter.user.titleName}</td>
			<td>${filter.user.postName}</td>
			<td>${trainDateMap[filter.user.userFlow]}</td>
			<td>${filter.allRoleName}</td>
		  </tr>
          </c:forEach>
	</table>
</div>  
