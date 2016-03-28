<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@include file="/jsp/common/doctype.jsp"%>
<style type="text/css">
td.td_sp{padding-left: 30px;}
</style>
<script type="text/javascript">
function editProj(projFlow){
	jboxOpen("<s:url value='/gcp/proj/edit?roleScope=${param.roleScope}&projFlow='/>" + projFlow ,"编辑项目信息",950,460);
}
function editSponsor(projFlow){
	jboxOpen("<s:url value='/gcp/proj/editSponsor?projFlow='/>" + projFlow,"编辑项目来源/CRO",920,460);
}
function editOrg(projFlow){
	jboxOpen("<s:url value='/gcp/proj/editOrg?projFlow='/>"+ projFlow,"编辑临床研究单位",800,400);
}
function editInspector(projFlow){
	jboxOpen("<s:url value='/gcp/proj/editInspector?projFlow='/>" + projFlow,"编辑监查员",900,350);
}
</script>
<table cellpadding="0" class="i-trend-main-table" cellspacing="0" border="0" style="width: 100%">
	<colgroup>
		<col width="35%" />
		<col width="20%" />
		<col width="20%" />
		<col width="25%" />
	</colgroup>
  <tr>
	<th colspan="4" class="ith">
	<span>项目信息</span>
	<c:if test="${projInfoForm.proj.projStatusId == gcpProjStatusEnumEdit.id||projInfoForm.proj.projStatusId == gcpProjStatusEnumNoPassed.id}"><i class="i-trend-main-back"><a href="javascript:void(0)" onclick="editProj('${param.projFlow}')" title="点击修改"></a></i></c:if>
	</th>
  </tr>
  <tr>
    <td class="td_sp" colspan="4">项目名称：${projInfoForm.proj.projName}</td>
  </tr>
  <tr class="odd">
    <td class="td_sp">项目简称：${projInfoForm.proj.projShortName}</td>
    <td>期类别：${projInfoForm.proj.projSubTypeName}</td>
    <td>项目类别：${projInfoForm.proj.projTypeName}</td>
    <td>CFDA批件号：${projInfoForm.proj.cfdaNo}</td>
  </tr>
  <tr>
    <td class="td_sp">注册分类：${projInfoForm.registCategory}</td>
    <td>组长/参加：
    	<c:if test="${projInfoForm.isLeader eq projOrgTypeEnumLeader.id}">${projOrgTypeEnumLeader.name }</c:if>
    	<c:if test="${projInfoForm.isLeader eq projOrgTypeEnumParti.id}">${projOrgTypeEnumParti.name}</c:if>
    </td>
    <td>国际多中心：
    	<c:if test="${projInfoForm.interMulCenter == 1}">是</c:if>
    	<c:if test="${projInfoForm.interMulCenter == 2}">否</c:if>
	</td>
    <td>承担科室：${projInfoForm.proj.applyDeptName}</td>
  </tr>
  <tr class="odd">
    <td class="td_sp">主要研究者：${projInfoForm.proj.applyUserName}</td>
    <td colspan="3">起止时间：${projInfoForm.proj.projStartTime}~${projInfoForm.proj.projEndTime}</td>
  </tr>
  
  <tr>
	  <th colspan="4" class="ith">
	  <span>项目来源/CRO</span>
	   <c:if test="${projInfoForm.proj.projStatusId == gcpProjStatusEnumEdit.id||projInfoForm.proj.projStatusId == gcpProjStatusEnumNoPassed.id}"><i class="i-trend-main-back"><a href="javascript:void(0)" onclick="editSponsor('${param.projFlow}')" title="点击修改"></a></i></c:if>
	  </th>
  </tr>
  <tr>
    <td colspan="4" class="td_sp">项目来源全称：${projInfoForm2.proj.projDeclarer}</td>
  </tr>
  <tr class="odd">
    <td class="td_sp">项目来源简称：${projInfoForm2.proj.projShortDeclarer}</td>
    <td>联系人：${projInfoForm2.dLinkMan}</td>
    <td>手机：${projInfoForm2.dLinkManPhone}</td>
    <td>邮件：${projInfoForm2.dLinkManEmail}</td>
  </tr>
  <tr>
    <td class="td_sp">地址：${projInfoForm2.declarerAddress}</td>
    <td>邮编：${projInfoForm2.declarerZip}</td>
    <td></td>
    <td></td>
  </tr>
  
  <tr class="odd">
    <td colspan="4" class="td_sp">CRO：${projInfoForm2.CROName}</td>
  </tr>
  <tr>
    <td class="td_sp">法人代表：${projInfoForm2.CROLegalRepresent}</td>
    <td>联系人：${projInfoForm2.CROLinkMan}</td>
    <td>手机：${projInfoForm2.CROLinkManPhone}</td>
    <td>邮件：${projInfoForm2.CROLinkManEmail}</td>
  </tr>
  <tr class="odd">
    <td class="td_sp">地址：${projInfoForm2.CROAddress}</td>
    <td>邮编：${projInfoForm2.CROZip}</td>
    <td></td>
    <td></td>
  </tr>
</table>
<div class="i-trend-main-div">
	<table class="i-trend-main-table i-trend-main-div-table"  border="0" cellpadding="0" cellspacing="0" width="100%">
		 <colgroup>
            <col width="10%" />
            <col width="20%" />
            <col width="15%" />
            <col width="20%" />
            <col width="20%" />
          </colgroup>
          <tr>
			  <th colspan="5" class="ith">
			  	<span>监查员</span>
			    <c:if test="${projInfoForm.proj.projStatusId == gcpProjStatusEnumEdit.id||projInfoForm.proj.projStatusId == gcpProjStatusEnumNoPassed.id}"><i class="i-trend-main-back"><a href="javascript:void(0)" onclick="editInspector('${projInfoForm.proj.projFlow}')" title="点击修改"></a></i></c:if>
			  </th>
		  </tr>
		  <tr>
            <th>姓名</th>
            <th>身份证号</th>
            <th>手机</th>
            <th>邮箱</th>
            <th>是否GCP培训</th>
          </tr>
			<c:forEach items="${monitorFormList}" var="monitor" varStatus="status">
			<tr <c:if test="${status.count%2==0}"> class="odd" </c:if> >
				<td>${monitor.name}</td>
				<td>${monitor.identityCardNo}</td>
				<td>${monitor.phone}</td>
				<td>${monitor.email}</td>
				<td>
					<c:if test="${monitor.isGCPTrain eq GlobalConstant.FLAG_Y}">是</c:if>
					<c:if test="${monitor.isGCPTrain eq GlobalConstant.FLAG_N}">否</c:if>
				</td>
			</tr>
			</c:forEach>
	</table>
</div>
<div class="i-trend-main-div">
<table class="i-trend-main-table i-trend-main-div-table"  border="0" cellpadding="0" cellspacing="0" width="100%">
  <tr>
  	<th colspan="5" class="ith">
  	<span>临床研究单位</span>
    <c:if test="${projInfoForm.proj.projStatusId == gcpProjStatusEnumEdit.id||projInfoForm.proj.projStatusId == gcpProjStatusEnumNoPassed.id}"><i class="i-trend-main-back"><a href="javascript:void(0)" onclick="editOrg('${param.projFlow}')" title="点击修改"></a></i></c:if>
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
     <td>${org.centerNo}</td>
     <td>${org.orgTypeName}</td>
     <td>${org.orgName}</td>
     <td>${org.patientCount}</td>
     <td>${org.researcher}</td>
   </tr>
  </c:forEach>
  <tr class="odd">
    <td colspan="5" class="iright"><strong>临床试验负责单位：</strong>${projOrgForm.leaderOrg}<strong>联系人：</strong>${projOrgForm.leaderOrgLinkMan}<strong>联系电话：</strong>${projOrgForm.leaderOrgLinkManPhone}</td>
  </tr>
</table>
 </div>