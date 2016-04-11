<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<style type="text/css">
	td.td_sp{padding-left: 30px;}
</style>
<script type="text/javascript">
function viewProv(){
	
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
		<span>批件信息</span>
		</th>
  	</tr>
  	<c:if test="${not empty irbProv }">
  	<tr>
	  	<td class="td_sp">批件号：${ irbProv.irbNo}</td>
	    <td >审查日期：${irbProv.meetingDate}</td>
	    <td>审查方式：${irbProv.reviewWayName}</td>
    </tr>
  	<tr class="odd">
  		<td class="td_sp" >有效期：${irbProv.approveValidity}个月</td>
  		<td >跟踪审查日期：${irbProv.trackDate}</td>
  		<td></td>
    </tr>
  	<tr>
	  <td class="td_sp" >伦理委员会：${irbInfoMap[irbProv.irbInfoFlow].irbName}</td>
	  <td >批件：<a href="javascript:void(0);" onclick="irbDetail('${irbProv.irbFlow}');" class="ui-blue-no-margin">[批件]</a></td>
	  <td></td>
    </tr>
    </c:if>
  	<c:if test="${ empty irbProv }">
    	<tr>
	  		<td class="td_sp" colspan="8" align="center">无记录！</td>
   		</tr>
    </c:if>
    
</table>
