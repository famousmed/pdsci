<jsp:include page="/jsp/jsres/htmlhead-jsres.jsp">
	<jsp:param name="basic" value="true"/>
	<jsp:param name="jbox" value="true"/>
	<jsp:param name="font" value="true"/>
</jsp:include>
<script type="text/javascript">
$(document).ready(function(){
  		$(":radio").attr("disabled",true);
  		$(":input").attr("readonly",true);
});
function auditStatus(baseFlow,status){
	var s="通过";
	if(status=='${GlobalConstant.FLAG_N}'){
		s="不通过";
	}
	jboxConfirm("确认"+s+"？",function(){
		var data={
				"baseFlow":baseFlow,
				"status":status
			};
		jboxPost("<s:url value='/jsres/base/baseAudit'/>" , data , function(resp){
			if("${GlobalConstant.OPRE_SUCCESSED}"==resp){
				setTimeout(function(){
					window.parent.auditHospitals();
					loadInfo('${GlobalConstant.SUPPORT_CONDITION}','${param.baseFlow }');
				},1000);
			}
		} , null , true);
	});
}
</script>
	<div class="infoAudit"  <c:if test="${param.openType != 'open'}">style="height: auto;"</c:if>>
		<div class="div_table" >
		  <h4>支撑条件（在是或否栏内选中）</h4>
		  <table border="0" cellpadding="0" cellspacing="0" class="grid" id="supportContent">
		    <colgroup>
		      <col width="50%"/>
		      <col width="10%"/>
		      <col width="10%"/>
		      <col width="30%"/>
		    </colgroup>
		    <tbody>
		      <tr>
		        <th style="text-align:left;">项目内容</th>
		        <th>是</th>
		        <th>否</th>
		        <th style="text-align:left;">划“是”者请填写具体数值或措施</th>
		      </tr>
		      <tr>
		        <td style="text-align:left;">能提供用于基地建设和管理经费</td>
		        <td><label><input name="supportCondition.buildAndMang" type="radio" value="${ supportCondition.buildAndMang}" <c:if test="${supportCondition.buildAndMang ==GlobalConstant.FLAG_Y }">checked="checked"</c:if> /> </label> </td>
		        <td><label><input name="supportCondition.buildAndMang" type="radio" value="${ supportCondition.buildAndMang}" <c:if test="${supportCondition.buildAndMang ==GlobalConstant.FLAG_N }">checked="checked"</c:if> /> </label> </td>
		        <td  style="text-align:left;"><div id="buildAndManginput"  style="display:${ supportCondition.buildAndMang == GlobalConstant.FLAG_Y?'':'none'}"><span  style="height:20px;width:250px ">${supportCondition.buildAndManginfo}</span></div></td>
		      </tr>
		      <tr>
		        <td style="text-align:left;">能否解决住院医师住宿</td>
		        <td><label><input name="supportCondition.giveLive" type="radio" value="${supportCondition.giveLive }"  <c:if test="${supportCondition.giveLive ==GlobalConstant.FLAG_Y }">checked="checked"</c:if>/> </label> </td>
		        <td><label><input name="supportCondition.giveLive" type="radio" value="${supportCondition.giveLive }" <c:if test="${supportCondition.giveLive ==GlobalConstant.FLAG_N }">checked="checked"</c:if>/> </label> </td>
		        <td  style="text-align:left;"><div  style="display:${supportCondition.giveLive == GlobalConstant.FLAG_Y?'':'none'}" id="giveLiveinput" ><span  style="height:20px;width:250px ">${supportCondition.giveLiveinfo}</span></div></td>
		      </tr>
		      <tr>
		        <td style="text-align:left;">是否能解决住院医师工资及补贴</td>
		        <td><label><input name="supportCondition.wageAndTip" type="radio" value="${supportCondition.wageAndTip }"  <c:if test="${supportCondition.wageAndTip==GlobalConstant.FLAG_Y }">checked="checked"</c:if>/> </label> </td>
		        <td><label><input name="supportCondition.wageAndTip" type="radio" value="${supportCondition.wageAndTip }" <c:if test="${supportCondition.wageAndTip==GlobalConstant.FLAG_N }">checked="checked"</c:if>/> </label> </td>
		        <td style="text-align:left;"><div  style="display:${ supportCondition.wageAndTip == GlobalConstant.FLAG_Y?'':'none'}" id="wageAndTipinput" ><span  style="height:20px;width:250px ">${supportCondition.wageAndTipinfo}</span></div></td>
		      </tr>
		      <tr>
		        <td style="text-align:left;">是否能解决住院医师的社会保障</td>
		        <td><label><input name="supportCondition.socialSecurity" type="radio" value="${supportCondition.socialSecurity }"  <c:if test="${supportCondition.socialSecurity ==GlobalConstant.FLAG_Y }">checked="checked"</c:if>/> </label> </td>
		        <td><label><input name="supportCondition.socialSecurity" type="radio" value="${ supportCondition.socialSecurity}" <c:if test="${supportCondition.socialSecurity ==GlobalConstant.FLAG_N}">checked="checked"</c:if>/> </label> </td>
		        <td style="text-align:left;"><div   style="display:${ supportCondition.socialSecurity == GlobalConstant.FLAG_Y?'':'none'}"   id="socialSecurityinput" ><span  style="height:20px;width:250px ">${supportCondition.socialSecurityinfo}</span></div></td>
		      </tr>
		      <tr>
		        <td style="text-align:left;">能否解决住院医师的人事档案和工龄</td>
		        <td><label><input name="supportCondition.recordAndStanding" type="radio" value="${ supportCondition.recordAndStanding}" <c:if test="${supportCondition.recordAndStanding ==GlobalConstant.FLAG_Y }">checked="checked"</c:if>/>  </label> </td>
		        <td><label><input name="supportCondition.recordAndStanding" type="radio" value="${supportCondition.recordAndStanding }" <c:if test="${supportCondition.recordAndStanding ==GlobalConstant.FLAG_N }">checked="checked"</c:if>/> </label> </td>
		        <td style="text-align:left;"><div   style="display:${ supportCondition.recordAndStanding == GlobalConstant.FLAG_Y?'':'none'}"    id="recordAndStandinginput" ><span  style="height:20px;width:250px ">${supportCondition.recordAndStandinginfo}</span></div></td>
		      </tr>
		      <tr>
		        <td style="text-align:left;">能否解决住院医师的医师资格和注册管理</td>
		        <td><label><input name="supportCondition.qualifiAndregis" type="radio" value="${supportCondition.qualifiAndregis }" <c:if test="${supportCondition.qualifiAndregis ==GlobalConstant.FLAG_Y }">checked="checked"</c:if>/> </label> </td>
		        <td><label><input name="supportCondition.qualifiAndregis" type="radio" value="${supportCondition.qualifiAndregis }" <c:if test="${supportCondition.qualifiAndregis ==GlobalConstant.FLAG_N }">checked="checked"</c:if>/> </label> </td>
		        <td style="text-align:left;"><div style="display:${ supportCondition.qualifiAndregis == GlobalConstant.FLAG_Y?'':'none'}"   id="qualifiAndregisinput" ><span  style="height:20px;width:250px ">${supportCondition.qualifiAndregisinfo}</span></div></td>
		      </tr>
		      <tr>
		        <td style="text-align:left;">能否与培训对象签订3年以上聘用合同</td>
		        <td><label><input name="supportCondition.threeYearContract" type="radio" value="${supportCondition.threeYearContract }" <c:if test="${supportCondition.threeYearContract==GlobalConstant.FLAG_Y}">checked="checked"</c:if>/> </label> </td>
		        <td><label><input name="supportCondition.threeYearContract" type="radio" value="${supportCondition.threeYearContract }" <c:if test="${supportCondition.threeYearContract==GlobalConstant.FLAG_N}">checked="checked"</c:if>/> </label> </td>
		        <td style="text-align:left;"><div  style="display:${ supportCondition.threeYearContract  == GlobalConstant.FLAG_Y?'':'none'}"    id="threeYearContractinput" ><span  style="height:20px;width:250px ">${supportCondition.threeYearContractinfo}</span></div></td>
		      </tr>
		      <tr>
		        <td style="text-align:left;">能否保证大多数住院医师分流去基层服务</td>
		        <td><label><input name="supportCondition.goBasicServe" type="radio" value="${supportCondition.goBasicServe }" <c:if test="${supportCondition.goBasicServe ==GlobalConstant.FLAG_Y }">checked="checked"</c:if>/> </label> </td>
		        <td><label><input name="supportCondition.goBasicServe" type="radio" value="${supportCondition.goBasicServe }" <c:if test="${supportCondition.goBasicServe ==GlobalConstant.FLAG_N }">checked="checked"</c:if>/> </label> </td>
		        <td style="text-align:left;"><div style="display:${ supportCondition.goBasicServe  == GlobalConstant.FLAG_Y?'':'none'}"    id="goBasicServeinput" ><span  style="height:20px;width:250px ">${supportCondition.goBasicServeinfo}</span></div></td>
		      </tr>
		      <tr>
		        <td style="text-align:left;">已开展住院医师规范化培训工作的经验</td>
		        <td><label><input name="supportCondition.openTraning" type="radio" value="${supportCondition.openTraning }" <c:if test="${supportCondition.openTraning==GlobalConstant.FLAG_Y }">checked="checked"</c:if>/> </label> </td>
		        <td><label><input name="supportCondition.openTraning" type="radio" value="${supportCondition.openTraning }" <c:if test="${supportCondition.openTraning==GlobalConstant.FLAG_N }">checked="checked"</c:if>/> </label> </td>
		        <td style="text-align:left;"><div style="display:${ supportCondition.openTraning == GlobalConstant.FLAG_Y?'':'none'}"   id="openTraninginput" ><span  style="height:20px;width:250px ">${supportCondition.openTraninginfo}</span></div></td>
		      </tr>
		      <tr>
		        <td style="text-align:left;">是否建立了临床技能训练中心</td>
		        <td><label><input name="supportCondition.skillTrain" type="radio" value="${supportCondition.skillTrain }" <c:if test="${supportCondition.skillTrain==GlobalConstant.FLAG_Y }">checked="checked"</c:if>/> </label> </td>
		        <td><label><input name="supportCondition.skillTrain" type="radio" value="${supportCondition.skillTrain }" <c:if test="${supportCondition.skillTrain==GlobalConstant.FLAG_N }">checked="checked"</c:if>/> </label> </td>
		        <td style="text-align:left;"><div style="display:${ supportCondition.skillTrain == GlobalConstant.FLAG_Y?'':'none'}"  id="skillTraininput" ><span  style="height:20px;width:250px ">${supportCondition.skillTraininfo}</span></div></td>
		      </tr>
		      <tr>
		        <td style="text-align:left;">注陪合格资格与主治医师报考、聘任挂钩</td>
		        <td><label><input name="supportCondition.zpqualification" type="radio" value="${supportCondition.zpqualification }" <c:if test="${supportCondition.zpqualification==GlobalConstant.FLAG_Y }">checked="checked"</c:if>/> </label> </td>
		        <td><label><input name="supportCondition.zpqualification" type="radio" value="${supportCondition.zpqualification }" <c:if test="${supportCondition.zpqualification==GlobalConstant.FLAG_N }">checked="checked"</c:if>/> </label> </td>
		        <td style="text-align:left;"><div style="display:${ supportCondition.zpqualification  == GlobalConstant.FLAG_Y?'':'none'}"  id="zpqualificationinput" ><span style="height:20px;width:250px ">${supportCondition.zpqualificationinfo}</span></div></td>
		      </tr>
		    </tbody>
		  </table>
		</div>
		<div class="btn_info">
		 <jsp:include page='/jsp/jsres/province/hospital/passBtn.jsp'/>
	    </div>
	</div>
