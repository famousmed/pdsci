<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<style type="text/css">
td.td_sp{padding-left: 40px;}
</style>
<script type="text/javascript" src="<s:url value='/js/ajaxfileupload.js'/>?v=${applicationScope.sysCfgMap['sys_version']}"></script>
<script type="text/javascript">
function saveEval(){
	if(false==$("#evalForm").validationEngine("validate")){
		return false;
	}
	jboxConfirm("保存后不可修改，确定保存立项评估信息？",function(){
		var agree = $("input[name='agree']:checked").val();
		var url = "<s:url value='/gcp/rec/saveEval'/>?projFlow=${param.projFlow}&agree="+agree+"&projectTime="+$("#projectTime").val();
		$.ajaxFileUpload({
				url:url, 
				secureuri:false,
				fileElementId:'fileToUpload',
				dataType: 'json',
				success: function (data, status){
					if(data=='${GlobalConstant.SAVE_SUCCESSED}'){
						loadEvaluation();
					}
					jboxTip(data);
				},
				error: function (data, status, e){
					jboxError(e);
				}
			}
		)
	},null);
}
function reupload(){
	$("#file_td").html('上传附件：<input type="file" name="file" id="fileToUpload" class="validate[required]">');
}
</script>
<form id="evalForm" style="position: relative;">
<table cellpadding="0" class="i-trend-main-table" cellspacing="0" border="0" style="width: 100%">
  <tr>
	<th  class="ith">
	<span>立项评估表</span>
	</th>
  </tr>
  <tr>
    <td class="td_sp" id="file_td">立项评估表：<c:choose><c:when test="${empty evalForm.agree && param.roleScope eq GlobalConstant.ROLE_SCOPE_GO }">
    	<input type="file"  class="validate[required]" name="file" id="fileToUpload"></c:when><c:when test="${!empty evalForm.fileFlow}"><a href="${ctxPath}/pub/file/down?fileFlow=${evalForm.fileFlow}" title="点击下载">${evalForm.fileName}</a>
    <!--  &#12288;&#12288;&#12288;&#12288;&#12288;<c:if test="${param.roleScope != GlobalConstant.ROLE_SCOPE_DECLARER}">[<a href="javascript:void(0)" onclick="reupload()">重新上传</a>]</c:if>-->
    </c:when></c:choose></td>
  </tr>
  <tr class="odd">
  	<td class="td_sp" >评估意见：
  	<c:choose>
  		<c:when test="${param.roleScope eq GlobalConstant.ROLE_SCOPE_GO && empty evalForm.agree}">
  			<input type="radio" name="agree" id="agree_y" class="validate[required]" <c:if test="${evalForm.agree==GlobalConstant.FLAG_Y }">checked="checked"</c:if>  value="${GlobalConstant.FLAG_Y }"><label for="agree_y">同意立项</label>&#12288;
	  		<input type="radio" name="agree" id="agree_n"  class="validate[required]" <c:if test="${evalForm.agree==GlobalConstant.FLAG_N }">checked="checked"</c:if> value="${GlobalConstant.FLAG_N }"><label for="agree_n">不同意立项</label>
  		</c:when>
  		<c:otherwise>
  			<c:if test="${evalForm.agree==GlobalConstant.FLAG_Y }">同意立项</c:if>
  			<c:if test="${evalForm.agree==GlobalConstant.FLAG_N }">不同意立项</c:if>
  		</c:otherwise>
  	</c:choose>
  	</td>
  </tr>
  <tr>
  	<td class="td_sp">立项时间：
  		<c:choose>
	  		<c:when test="${param.roleScope eq GlobalConstant.ROLE_SCOPE_GO && empty evalForm.agree}">
	  			<input type="text" id="projectTime" class="ctime validate[required]" readonly="readonly" value="${empty evalForm.projectTime?pdfn:getCurrDate():evalForm.projectTime }" 
  					onClick="WdatePicker({dateFmt:'yyyy-MM-dd'})"/>
	  		</c:when>
	  		<c:otherwise>
	  			${evalForm.projectTime}
	  		</c:otherwise>
	  	</c:choose>
     </td>
  </tr>
  <c:if test="${param.roleScope eq GlobalConstant.ROLE_SCOPE_GO && empty evalForm.agree}">
  <tr><td class="td_sp"><a class="ui-button-t" href="javascript:void(0)" onclick="saveEval();">保&#12288;存</a></td></tr>
  </c:if>
</table>
</form>