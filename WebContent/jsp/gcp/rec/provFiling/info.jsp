<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<style type="text/css">
td.td_sp{padding-left: 30px;}
</style>
<script type="text/javascript">
function editFiling(projFlow){
	jboxOpen("<s:url value='/gcp/rec/editProvFiling?projFlow='/>" + projFlow ,"编辑省级备案",900,350);
}
</script>
<table cellpadding="0" class="i-trend-main-table" cellspacing="0" border="0" style="width: 100%">
	<colgroup>
		<col width="55%" />
		<col width="45%" />
	</colgroup>
  <tr>
	<th colspan="2" class="ith">
	<span>省级备案表</span>
	<c:if test="${param.roleScope eq GlobalConstant.ROLE_SCOPE_GO }">
	<i class="i-trend-main-back" ><a href="javascript:void(0)" onclick="editFiling('${param.projFlow}')" title="点击修改"></a></i>
	</c:if>
	</th>
  </tr>
  <tr>
  	<td class="td_sp" colspan="2">项目名称：${projInfoForm.proj.projName }</td>
  </tr>
  <tr class="odd">
  	<td class="td_sp">项目类别：${projInfoForm.proj.projTypeName }</td>
    <td >注册分类：${projInfoForm.registCategory }</td>
  </tr>
  <tr>
  	<td class="td_sp">期类别：${projInfoForm.proj.projSubTypeName }</td>
    <td >CFDA批件号：${projInfoForm.proj.cfdaNo }</td>
  </tr>
  <tr class="odd">
    <td class="td_sp">临床试验预期时间：${projInfoForm.proj.projStartTime}~${projInfoForm.proj.projEndTime}</td>
    <td>病例总数：<c:out value="${countMap[projInfoForm.proj.projFlow]['caseTotal'] }" default="0"/></td>
  </tr>
  <tr>
  	<td class="td_sp">申办单位：${projInfoForm2.proj.projDeclarer }</td>
    <td >联系人 / 电话：${projInfoForm2.dLinkMan } / ${projInfoForm2.dLinkManPhone}</td>
  </tr>
  <tr class="odd">
    <td class="td_sp">临床试验负责单位：${projOrgForm.leaderOrg}</td>
    <td>联系人 / 电话：${projOrgForm.leaderOrgLinkMan} / ${projOrgForm.leaderOrgLinkManPhone}</td>
  </tr>
   <tr>
	<td colspan="2" style="border-bottom: none;">
		<table class="i-trend-main-div-table"   border="0" cellpadding="0" cellspacing="0" width="100%">
		  <tr>
		  	<th colspan="5" class="ith">
		  	<span>临床研究单位</span>
		  	</th>
		  </tr>
		  <colgroup>
		    <col width="10%" />
		    <col width="15%" />
		    <col width="20%" />
		    <col width="15%" />
		    <col width="20%" />
		  </colgroup>
		  <tr>
		    <th>序号</th>
		    <th>机构角色</th>
		    <th>机构名称</th>
		    <th>承担例数</th>
		    <th>主要研究者</th>
		  </tr>
		  <c:forEach items="${projOrgForm.projOrgList}" var="org" varStatus="status">
		   <tr <c:if test="${status.count%2==0}"> class="odd" </c:if> >
		     <td>${status.count}</td>
		     <td>${org.orgTypeName}</td>
		     <td>${org.orgName}</td>
		     <td>${org.patientCount}</td>
		     <td>${org.researcher}</td>
		   </tr>
		  </c:forEach>
		</table>
	</td>
  </tr>
  <tr>
    <td class="td_sp" colspan="2">备案意见：${pfForm.opinion }</td>
  </tr>
  <tr>
    <td class="td_sp" colspan="2">备案时间：${pfForm.date }</td>
  </tr>
</table>