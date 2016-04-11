<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<script type="text/javascript">
function selectSingle(obj) {
	var value = $(obj).val();
	var name = $(obj).attr("name");
	$("input[name="+name+"][value!="+value+"]:checked").attr("checked",false);
}
function loadTrackFormList(contactFlow){
	var url="<s:url value='/erp/sales/trackOpinionContent'/>?contactFlow="+contactFlow;
	jboxLoad("trackFormDiv",url,true);
}
$(document).ready(function(){
	loadTrackFormList('${param.contactFlow}');
});
</script>
<div id="trackFormDiv"></div>
<table width="100%" cellpadding="0" cellspacing="0" class="basic">
                            <tr>
								<th colspan="3" style="text-align: left; padding-left: 10px">进度跟踪</th>
							</tr>
							<tr>
								<td style="text-align: center; padding-right: 10px;">处理时间：
								  <input onClick="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm'})" name="trackDate" style="width: 130px; text-align: left;"  readonly="readonly" class="inputText validate[required]" type="text" />
								</td>
								<td style="text-align: center; padding-right: 10px;">记&#12288;录&#12288;人：
								 ${sessionScope.currUser.userName}
									<input type="hidden" name="recordUserFlow" value="${sessionScope.currUser.userFlow}"  style="text-align: left;" />
									<input type="hidden" name="recordUserName" value="${sessionScope.currUser.userName}"  style="text-align: left;" />
								</td>
								<td style="text-align: center; padding-right: 10px;">记录时间：
								  <input onClick="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm'})" name="recordDate" style="width: 130px; text-align: left;" value="${pdfn:getCurrDateTime('yyyy-MM-dd HH:mm') }" readonly="readonly" class="inputText validate[required]" type="text" />
								</td>
							</tr>
							<tr>
							    <td colspan="3" style="text-align: center;">
							       <textarea id="trackContent" name="trackContent" placeholder="请输入记录内容" class="xltxtarea validate[required]" style="width: 98%;"></textarea>
							    </td>
							</tr>
                       </table>
     <div class="button">
	       		<input type="button" value="提&#12288;交" onclick="saveTrack();" class="search"/>
			    <input type="button" class="search" value="关&#12288;闭" onclick="jboxCloseMessager();" >
     </div>