<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<c:if test="${param.view != GlobalConstant.FLAG_Y}">
<script type="text/javascript">
	function nextOpt(step){
		var val = "";
		$("input[name='achievement']:checked").each(function(){
			val += "," + $(this).val();
		});
		val = val.substring(1);
		$("#expectAchievement").val(val);
		if(false==$("#projForm").validationEngine("validate")){
			return false;
		}
		var form = $('#projForm');
		var action = form.attr('action');
		action+="?nextPageName="+step;
		form.attr("action" , action);
		form.submit();
	}
</script>
</c:if>
<script type="text/javascript">
	function selectCount(obj){
		var leng = $("input[name='achievement']:checked").length;
		if(leng > 4){
			$(obj).removeAttr("checked");
			jboxTip("最多四项！");
			return;
		}
	}
	
	$(document).ready(function(){
		  var expectAchievement = "${resultMap.expectAchievement}";
		  if(expectAchievement != ""){
			  var achievementArray = expectAchievement.split(",");
			  for(var i=0; i<achievementArray.length; i++){
				  $("input[name='achievement'][value='"+ achievementArray[i]+"']").attr("checked",true);
			  }
		  }
	});
</script>
	<form action="<s:url value='/srm/proj/mine/saveStep'/>" method="post" style="position: relative;"
		id="projForm" style="position:relative;">
		<input type="hidden" id="pageName" name="pageName" value="step5" /> 
		<input type="hidden" id="recFlow" name="recFlow" value="${projRec.recFlow}"/>
		<input type="hidden" id="projFlow" name="projFlow" value="${proj.projFlow}"/>
		<input type="hidden" id="recTypeId" name="recTypeId" value="${param.recTypeId}"/>
		
		<input type="hidden" id="expectAchievement" name="expectAchievement"/>
		
	    <font style="font-size: 14px; font-weight:bold; ">五、预期成果、预期经济效益、项目经费</font>
		<table width="100%" class="basic" style="margin: 20px 0px;">
			<tr>
				<td width="15%" style="text-align: right; padding-right: 2%;">预期成果&#12288;<br/>（最多四项）</td>
				<td>
					<input type="checkbox" name="achievement" id="achievement_1" onchange="selectCount(this)" value="新药证书（含生物制品）"/>&nbsp;<label for="achievement_1">新药证书（含生物制品）</label>&#12288;
					<input type="checkbox" name="achievement" id="achievement_2" onchange="selectCount(this)" value="专利"/>&nbsp;<label for="achievement_2">专利</label>&#12288;
					<input type="checkbox" name="achievement" id="achievement_3" onchange="selectCount(this)" value="技术标准"/>&nbsp;<label for="achievement_3">技术标准</label>&#12288;<br/>
					<input type="checkbox" name="achievement" id="achievement_4" onchange="selectCount(this)" value="新仪器"/>&nbsp;<label for="achievement_4">新仪器</label>&#12288;
					<input type="checkbox" name="achievement" id="achievement_5" onchange="selectCount(this)" value="新方法"/>&nbsp;<label for="achievement_5">新方法</label>&#12288;
					<input type="checkbox" name="achievement" id="achievement_6" onchange="selectCount(this)" value="新产品"/>&nbsp;<label for="achievement_6">新产品</label>&#12288;<br/>
					<input type="checkbox" name="achievement" id="achievement_7" onchange="selectCount(this)" value="新材料"/>&nbsp;<label for="achievement_7">新材料</label>&#12288;
					<input type="checkbox" name="achievement" id="achievement_8" onchange="selectCount(this)" value="论文著作"/>&nbsp;<label for="achievement_8">论文著作</label>&#12288;
					<input type="checkbox" name="achievement" id="achievement_9" onchange="selectCount(this)" value="软件/数据库"/>&nbsp;<label for="achievement_9">软件/数据库</label>&#12288;<br/>
					<input type="checkbox" name="achievement" id="achievement_10" onchange="selectCount(this)" value="其它"/>&nbsp;<label for="achievement_10">其它</label>&#12288;
				</td>
			</tr>
		</table>
		
		<hr/>
		
		<table width="100%" class="basic" style="margin: 20px 0px;">
			<tr>
				<th width="15%" style="text-align: right;" rowspan="2">预期经济效益</th>
				<td width="15%" style="text-align: right;">技术转让：</td>
				<td><input type="text" name="benefit1" class="validate[custom[number]] inputText" value="${resultMap.benefit1}" style="width: 110px;"/>万元</td>
				<td width="15%" style="text-align: right;">技术创收：</td>
				<td><input type="text" name="benefit2" class="validate[custom[number]] inputText" value="${resultMap.benefit2}" style="width: 110px;"/>万元</td>
			</tr>
			<tr>
				<td style="text-align: right;">出售专利：</td>
				<td><input type="text" name="benefit3" class="validate[custom[number]] inputText" value="${resultMap.benefit3}" style="width: 110px;"/>万元</td>
				<td style="text-align: right;">其它：</td>
				<td><input type="text" name="benefit4" class="validate[custom[number]] inputText" value="${resultMap.benefit4}" style="width: 110px;"/>万元</td>
			</tr>
		</table>
		
		<hr/>
		
		<table width="100%" class="basic" style="margin: 20px 0px;">
			<tr>
				<th width="15%" style="text-align: right;" rowspan="3">项目经费</th>
				<td width="15%" style="text-align: right;">项目总投资：</td>
				<td><input type="text" name="fund1" class="validate[custom[number]] inputText" value="${resultMap.fund1}" style="width: 110px;"/>万元</td>
				<td width="15%" style="text-align: right;">申请卫生厅拨款：</td>
				<td><input type="text" name="fund2" class="validate[custom[number]] inputText" value="${resultMap.fund2}" style="width: 110px;"/>万元</td>
			</tr>
			<tr>
				<td style="text-align: right;">业务审核部门匹配：</td>
				<td><input type="text" name="fund3" class="validate[custom[number]] inputText" value="${resultMap.fund3}" style="width: 110px;"/>万元</td>
				<td style="text-align: right;">单位自筹：</td>
				<td><input type="text" name="fund4" class="validate[custom[number]] inputText" value="${resultMap.fund4}" style="width: 110px;"/>万元</td>
			</tr>
			<tr>
				<td style="text-align: right;">其他来源：</td>
				<td colspan="3"><input type="text" name="fund5" class="validate[custom[number]] inputText" value="${resultMap.fund5}" style="width: 110px;"/>万元</td>
			</tr>
		</table>
		
	</form>
    <div class="button" style="width: 100%; <c:if test="${param.view == GlobalConstant.FLAG_Y}">display:none</c:if>">
        <input type="button" onclick="nextOpt('step4')" class="search" value="上一步"/>
	    <input type="button" onclick="nextOpt('finish')" class="search" value="完&#12288;成"/>
    </div>

		