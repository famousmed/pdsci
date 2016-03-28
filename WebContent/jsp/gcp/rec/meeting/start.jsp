<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<style type="text/css">
	td.td_sp{padding-left: 30px;}
</style>
<script type="text/javascript">
function editNotice(){
	if('${fundFlag}'=='N'){
		jboxTip("经费暂未到账，无法召开启动会!");
		return;
	}
	jboxGet("<s:url value='/gcp/proj/editStartConfirm'/>?projFlow=${param.projFlow}",null,function(resp){
		if(resp == '${GlobalConstant.OPRE_SUCCESSED}'){
			jboxOpen("<s:url value='/gcp/rec/editNotice'/>?projFlow=${param.projFlow}&roleScope=${param.roleScope}","编辑启动通知", 720,320);
		}else if(resp == '${GlobalConstant.OPRE_FAIL_FLAG}'){
			jboxTip("该项目不同意立项！");
		}else if(resp == '${GlobalConstant.OPRE_FAIL}'){
			jboxTip("请先填写立项评估!");
		}
	},null,false);
}
function editMeeting(){
	if('${fundFlag}'=='N'){
		jboxTip("经费暂未到账，无法召开启动会!");
		return;
	}
	jboxGet("<s:url value='/gcp/proj/editStartConfirm'/>?projFlow=${param.projFlow}",null,function(resp){
		if(resp == '${GlobalConstant.OPRE_SUCCESSED}'){
			jboxOpen("<s:url value='/gcp/rec/editMeeting'/>?projFlow=${param.projFlow}","编辑会议信息", 800,350);
		}else if(resp == '${GlobalConstant.OPRE_FAIL_FLAG}'){
			jboxTip("该项目不同意立项！");
		}else if(resp == '${GlobalConstant.OPRE_FAIL}'){
			jboxTip("请先填写立项评估!");
		}
	},null,false);
}
function meetingFile(){
	if('${fundFlag}'=='N'){
		jboxTip("经费暂未到账，无法召开启动会!");
		return;
	}
	jboxGet("<s:url value='/gcp/proj/editStartConfirm'/>?projFlow=${param.projFlow}",null,function(resp){
		if(resp == '${GlobalConstant.OPRE_SUCCESSED}'){
			jboxOpen("<s:url value='/gcp/rec/meetingFile'/>?projFlow=${param.projFlow}","编辑会议文件", 650,350);
		}else if(resp == '${GlobalConstant.OPRE_FAIL_FLAG}'){
			jboxTip("该项目不同意立项！");
		}else if(resp == '${GlobalConstant.OPRE_FAIL}'){
			jboxTip("请先填写立项评估!");
		}
	},null,false);
}
</script>
<table cellpadding="0" class="i-trend-main-table" cellspacing="0" border="0" style="width: 100%">
	<colgroup>
		<col width="40%" />
		<col width="30%" />
		<col width="30%" />
	</colgroup>
	<tr>
		<th colspan="3" class="ith">
		<span>会议信息</span>
		<c:if test="${param.roleScope eq GlobalConstant.ROLE_SCOPE_GO }">
		<i class="i-trend-main-back"><a href="javascript:void(0)" onclick="editMeeting('${param.projFlow}')" title="点击修改"></a></i>
		</c:if>
		</th>
  	</tr>
  	<tr>
	  	<td class="td_sp">会议地点：${meetingForm.address}</td>
	    <td >会议日期：${meetingForm.date}</td>
	    <td>主持人：${meetingForm.compere}</td>
    </tr>
  	<tr class="odd">
  		<td class="td_sp" colspan="3">参会人员：${meetingForm.user}</td>
    </tr>
  	<tr>
	  	<td class="td_sp" colspan="3">会议简介：${meetingForm.intro}</td>
    </tr>
    
</table>
<table cellpadding="0" class="i-trend-main-table" cellspacing="0" border="0" style="width: 100%">
	<colgroup>
		<col width="40%" />
		<col width="30%" />
		<col width="30%" />
	</colgroup>
	<tr>
		<th colspan="3" class="ith">
		<span>会议文件</span>
		<c:if test="${param.roleScope eq GlobalConstant.ROLE_SCOPE_GO }">
		<i class="i-trend-main-back"><a href="javascript:void(0)" onclick="meetingFile()" title="点击修改"></a></i>
		</c:if>
		</th>
  	</tr>
  	<tr>
  	<c:forEach items="${meetingForm.files}" var="file" varStatus="status">
  		<td <c:if test="${status.count%3==1}"> class="td_sp" </c:if> ><a href="<s:url value='/pub/file/down'/>?fileFlow=${file.fileFlow}">${file.fileName}</a></td>
  		<c:if test="${status.count%3==0}">
	    </tr>
	  	<tr>
	  </c:if>
  	</c:forEach>
    </tr>
    <c:if test="${empty meetingForm.files  }">
     <tr><td class="td_sp" colspan="3">无记录！</td></tr>
    </c:if>
</table>
<table cellpadding="0" class="i-trend-main-table" cellspacing="0" border="0" style="width: 100%">
	<colgroup>
		<col width="40%" />
		<col width="30%" />
		<col width="30%" />
	</colgroup>
  <tr>
	<th colspan="3" class="ith">
	<span>启动通知</span>
	<c:if test="${param.roleScope eq GlobalConstant.ROLE_SCOPE_GO }">
	<i class="i-trend-main-back"><a href="javascript:void(0)" onclick="editNotice()" title="点击修改"></a></i>
	</c:if>
	</th>
  </tr>
  <tr>
  	<td class="td_sp">项目名称：${proj.projShortName}</td>
    <td >期类别：${proj.projSubTypeName}</td>
    <td>项目来源：${proj.projDeclarer}</td>
  </tr>
  <tr class="odd">
  	<td class="td_sp">承担科室：${proj.applyDeptName}</td>
    <td>主要研究者：${userMap["主要研究者"]}</td>
    <td>研究者：${userMap["研究者"]}</td>
  </tr>
  <tr>
  	<td class="td_sp">研究助理：${userMap["研究助理"]}</td>
    <td>药品管理员：${userMap["药品管理员"]}</td>
    <td>质控员：${userMap["质控员"]}</td>
  </tr>
  <tr>
    <td class="td_sp" colspan="3">监查员：<c:forEach items="${mFormList}" var="mForm" varStatus="status">${mForm.name }&nbsp;${mForm.phone}<c:if test="${fn:length(mFormList)>1&&!status.last }">、</c:if></c:forEach></td>
  </tr>
  <tr class="odd">
  	<td class="td_sp">研究例数：${meetingForm.researchCount}</td>
    <td>疗程/观察周期：${meetingForm.period}</td>
    <td>药物编码范围：${meetingForm.scope}</td>
  </tr>
  <tr>
  	<td class="td_sp">机构管理员签字：${meetingForm.goSign}</td>
  	<td>启动通知日期：${meetingForm.noticeDate}</td>
    <td>项目状态：${proj.projStageName}</td>
  </tr>
</table>
