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
	 <c:if test="${param.roleScope eq GlobalConstant.ROLE_SCOPE_GO}">
	if(${empty evalForm.dataMap.deptAgree}){
		jboxTip("承担科室未评估!");
		return;
	}
	</c:if>
	jboxConfirm("保存后不可修改，确定保存立项评估信息？",function(){
		var url = "<s:url value='/gcp/rec/saveEval'/>?projFlow=${param.projFlow}";
		var requestData = $("#evalForm").serialize();
		jboxPost(url,requestData,function(resp){
			if(resp=='${GlobalConstant.SAVE_SUCCESSED}'){
				loadEvaluation();
			}
		},null,true);
	});
}
function reupload(){
	$("#file_td").html('上传附件：<input type="file" name="file" id="fileToUpload" class="validate[required]">');
}

</script>
<form id="evalForm" style="position: relative;">
<table cellpadding="0" class="i-trend-main-table" cellspacing="0" border="0" style="width: 100%">
  <tr>
	<th  class="ith">
	<span>承担科室评估</span>
	</th>
  </tr>
  <tr class="odd">
  	<td class="td_sp" >1.是否能保证招募到足够的受试者：
  	<c:choose>
  		<c:when test="${empty evalForm.dataMap.deptAgree}">
  			<label><input type="radio" name="deptCondition1" class="validate[required]"   value="是">是</label>&#12288;
	  		<label><input type="radio" name="deptCondition1" class="validate[required]"  value="否">否</label>
  		</c:when>
  		<c:otherwise>
  			${evalForm.dataMap.deptCondition1}
  		</c:otherwise>
  	</c:choose>
  	</td>
  </tr>
  <tr >
  	<td class="td_sp" >2.研究者是否具备足够的试验时间：
  	<c:choose>
  		<c:when test="${empty evalForm.dataMap.deptAgree}">
  			<label><input type="radio" name="deptCondition2" class="validate[required]"  value="是">是</label>&#12288;
	  		<label><input type="radio" name="deptCondition2" class="validate[required]" value="否">否</label>
  		</c:when>
  		<c:otherwise>
  			${evalForm.dataMap.deptCondition2}
  		</c:otherwise>
  	</c:choose>
  	</td>
  </tr>
   <tr class="odd">
  	<td class="td_sp" >3.是否具备相应的仪器设备和其他技术条件：
  	<c:choose>
  		<c:when test="${empty evalForm.dataMap.deptAgree}">
  			<label><input type="radio" name="deptCondition3" class="validate[required]"  value="是">是</label>&#12288;
	  		<label><input type="radio" name="deptCondition3" class="validate[required]"  value="否">否</label>
  		</c:when>
  		<c:otherwise>
  		${evalForm.dataMap.deptCondition3}
  		</c:otherwise>
  	</c:choose>
  	</td>
  </tr>
   <tr >
  	<td class="td_sp" >4.目前科室承担与研究目标疾病相同的在研项目：
  	<c:choose>
  		<c:when test="${empty evalForm.dataMap.deptAgree}">
  			<label><input type="radio" name="deptCondition4" class="validate[required]"  value="无">无</label>&#12288;
	  		<label><input type="radio" name="deptCondition4" class="validate[required]"  value="1项">1项</label>&#12288;
	  		<label><input type="radio" name="deptCondition4" class="validate[required]"  value="2项">2项</label>
  		</c:when>
  		<c:otherwise>
  			${evalForm.dataMap.deptCondition3}
  		</c:otherwise>
  	</c:choose>
  	</td>
  </tr>
   <tr class="odd">
  	<td class="td_sp" >评估意见：
  	<c:choose>
  		<c:when test="${empty evalForm.dataMap.deptAgree}">
  			<label><input type="radio" name="deptAgree"  class="validate[required]"   value="同意">同意</label>&#12288;
	  		<label><input type="radio" name="deptAgree"  class="validate[required]"  value="不同意">不同意</label>
  		</c:when>
  		<c:otherwise>
  			${evalForm.dataMap.deptAgree}
  		</c:otherwise>
  	</c:choose>
  	</td>
  </tr>
  <c:if test="${not empty evalForm.dataMap.deptAgree}">
  <tr >
  	<td class="td_sp" >主要研究者签字：${evalForm.dataMap.deptSign}
  	&#12288;&#12288;&#12288;&#12288;日期:${evalForm.dataMap.deptSignDate}
  	</td>
  </tr>
  </c:if>
  
  <c:if test="${param.roleScope eq GlobalConstant.ROLE_SCOPE_GO}">
   <tr>
	<th  class="ith">
	<span>机构办公室评估</span>
	</th>
  </tr>
   <tr >
  	<td class="td_sp" >1.申请资料是否齐全：
  	<c:choose>
  		<c:when test="${empty evalForm.dataMap.agree}">
  			<label><input type="radio" name="officeCondition1" class="validate[required]"   value="是">是</label>&#12288;
	  		<label><input type="radio" name="officeCondition1" class="validate[required]"  value="否">否</label>
  		</c:when>
  		<c:otherwise>
  			${evalForm.dataMap.officeCondition1}
  		</c:otherwise>
  	</c:choose>
  	</td>
  </tr>
  <tr  class="odd">
  	<td class="td_sp" class="odd">2.承担科室承担项目的能力：
  	<c:choose>
  		<c:when test="${empty evalForm.dataMap.agree}">
  			<label><input type="radio" name="officeCondition2" class="validate[required]"   value="强">强</label>&#12288;
	  		<label><input type="radio" name="officeCondition2" class="validate[required]"  value="一般">一般</label>&#12288;
	  		<label><input type="radio" name="officeCondition2" class="validate[required]" value="弱">弱</label>
  		</c:when>
  		<c:otherwise>
  			${evalForm.dataMap.officeCondition2}
  		</c:otherwise>
  	</c:choose>
  	</td>
  </tr>
  <tr  >
  	<td class="td_sp" class="odd">3.申办者对试验过程质量保证的能力：
  	<c:choose>
  		<c:when test="${empty evalForm.dataMap.agree}">
  			<label><input type="radio" name="officeCondition3" class="validate[required]"   value="强">强</label>&#12288;
	  		<label><input type="radio" name="officeCondition3" class="validate[required]"  value="一般">一般</label>&#12288;
	  		<label><input type="radio" name="officeCondition3" class="validate[required]" value="弱">弱</label>
  		</c:when>
  		<c:otherwise>
  			${evalForm.dataMap.officeCondition3}
  		</c:otherwise>
  	</c:choose>
  	</td>
  </tr>
  <tr class="odd">
  	<td class="td_sp" >审核意见：
  	<c:choose>
  		<c:when test="${empty evalForm.dataMap.agree}">
  			<label><input type="radio" name="agree"  class="validate[required]"  value="立项">立项</label>&#12288;
	  		<label><input type="radio" name="agree"  class="validate[required]" value="不立项">不立项</label>
  		</c:when>
  		<c:otherwise>
  			${evalForm.dataMap.agree}
  		</c:otherwise>
  	</c:choose>
  	</td>
  </tr>
	  <c:if test="${not empty evalForm.dataMap.agree}">
	  <tr >
	  	<td class="td_sp" >机构办主任签字：${evalForm.dataMap.officeSign}
	  	&#12288;&#12288;&#12288;&#12288;日期:${evalForm.dataMap.officeSignDate}
	  	</td>
	  </tr>
 	 </c:if>
  </c:if>
  <c:if test="${(param.roleScope eq GlobalConstant.ROLE_SCOPE_RESEARCHER && empty evalForm.dataMap.deptAgree) ||(param.roleScope eq GlobalConstant.ROLE_SCOPE_GO && empty evalForm.dataMap.agree)}">
  	<tr><td class="td_sp"><a class="ui-button-t" href="javascript:void(0)" onclick="saveEval();">保&#12288;存</a></td></tr>
  </c:if>
</table>
</form>