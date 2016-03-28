<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<c:if test="${param.view != GlobalConstant.FLAG_Y}">
<script type="text/javascript">
function nextOpt(step){
	if(false==$("#projForm").validationEngine("validate")){
		return false;
	}
    var form = $('#projForm');
    form.append('<input type="hidden" name="nextPageName" value="'+step+'"/>');
    $('#nxt').attr({"disabled":"disabled"});
    jboxStartLoading();
    form.submit();
}
</script>
</c:if>
<style type="text/css">
.title_sp{padding-left: 10px;font-size: 14px; margin-bottom:10px; margin-top:10px; font-weight: bold;color: #333;}
</style>
<form action="<s:url value='/srm/proj/mine/saveStep'/>" method="post" id="projForm" style="position: relative;">
    <input type="hidden" name="pageName" value="step1" /> 
	<input type="hidden" id="recFlow" name="recFlow" value="${projRec.recFlow}"/>
    <input type="hidden" id="projFlow" name="projFlow" value="${proj.projFlow}"/>
	<input type="hidden" name="recTypeId" value="${param.recTypeId}" />
    <div>
	    <div class="title_sp">一、经费情况</div>
	    <table class="xllist" style="width:100%;">
	        <tr><th colspan="4" style="text-align: left;padding-left: 15px;font-size: 13px;">项目信息</th></tr>
		    <tr>
                <td style="text-align: left" colspan="2"><span style="padding-left: 20px;font-weight: bold;color: #333;">项目名称：</span><a style="color: blue" href="<s:url value='/srm/proj/mine/projView?projFlow=${proj.projFlow}'/>" target="_blank">${proj.projName}</a></td>
                <td width="25%" style="text-align: left"><span style="padding-left: 15px;font-weight: bold;color: #333;">年&#12288;&#12288;份：</span>${proj.projYear}</td>
                <td width="25%" style="text-align: left"><span style="padding-left: 15px;font-weight: bold;color: #333;">项目编号：</span>${proj.projNo}</td>
            </tr>
		    <tr>
                <td width="25%" style="text-align: left"><span style="padding-left: 20px;font-weight: bold;color: #333;">项目类型：</span>${proj.projTypeName}</td>
                <td width="25%" style="text-align: left"><span style="padding-left: 15px;font-weight: bold;color: #333;">起止时间：</span>${proj.projStartTime}~${proj.projEndTime}</td>
                <td width="25%" style="text-align: left"><span style="padding-left: 15px;font-weight: bold;color: #333;">当前阶段：</span>${proj.projStageName}</td>
                <td width="25%" style="text-align: left"><span style="padding-left: 15px;font-weight: bold;color: #333;">当前状态：</span>${proj.projStatusName}</td>
            </tr>
	    </table>
	</div>
	<div style="margin-top: 10px;">
	    <table width="100%" cellspacing="0" cellpadding="0" class="bs_tb">
            <tr>
			    <th colspan="6" class="theader">经费来源(单位：万元)</th>
			</tr>
			<tr>
			    <td rowspan="2" class="xlming"></td>
				<td rowspan="2" class="xlming">项目新增投入</td>
				<td colspan="4" class="xlming">其中</td>
			</tr>
			<tr>
			    <td class="xlming">卫生局拨款</td>
				<td class="xlming">主管部门配套</td>
				<td class="xlming">单位自筹</td>
				<td class="xlming">其他(含贷款)</td>
			</tr>  
			<tbody>
				<tr>
					<td class="xlming">预算总额</td>
					<td class="xlming">
					<input type="text" name="allCount" class="inputText"
						<c:if test="${empty resultMap.allCount}">value="${contractMap.allCount}"</c:if>
						<c:if test="${!empty resultMap.allCount}">value="${resultMap.allCount}"</c:if>/>
					</td>
					<td class="xlming"><input type="text"  name="allGovPostPlan" value="${resultMap.allGovPostPlan }" class="inputText"/></td>
					<td class="xlming"><input type="text"  name="orgBelongTrCount" class="inputText"
						<c:if test="${empty resultMap.orgBelongTrCount}">value="${contractMap.orgBelongTrCount}"</c:if>
						<c:if test="${!empty resultMap.orgBelongTrCount}">value="${resultMap.orgBelongTrCount}"</c:if>/>
					</td>
					<td class="xlming"><input type="text"  name="orgDoTrCount" class="inputText"
						<c:if test="${empty resultMap.orgDoTrCount}">value="${contractMap.orgDoTrCount}"</c:if>
						<c:if test="${!empty resultMap.orgDoTrCount}">value="${resultMap.orgDoTrCount}"</c:if>/>
					</td>
					<td class="xlming"><input type="text"  name="allBankPostPlan" value="${resultMap.allBankPostPlan}" class="inputText"/></td>
				</tr>
				<tr>
					<td>第一年已到位数</td>
					<td class="xlming"><input type="text" class="inputText validate[custom[number]]" name="firstYearPost" value="${resultMap.firstYearPost }" /></td>
					<td class="xlming"><input type="text" class="inputText validate[custom[number]]" name="firstYearGovPost" value="${resultMap.firstYearGovPost }" /></td>
					<td class="xlming"><input type="text" class="inputText validate[custom[number]]" name="firstYearOrgBelongPost" value="${resultMap.firstYearOrgBelongPost }" /></td>
					<td class="xlming"><input type="text" class="inputText validate[custom[number]]" name="firstYearOrgDoPost" value="${resultMap.firstYearOrgDoPost }" /></td>
					<td class="xlming"><input type="text" class="inputText validate[custom[number]]" name="firstYearBankPost" value="${resultMap.firstYearBankPost }" /></td>
				</tr>
				<tr>
					<td>第二年已到位数</td>
					<td class="xlming"><input type="text" class="inputText validate[custom[number]]" name="secondYearPost" value="${resultMap.secondYearPost }" /></td>
					<td class="xlming"><input type="text" class="inputText validate[custom[number]]" name="secondYearGovPost" value="${resultMap.secondYearGovPost }" /></td>
					<td class="xlming"><input type="text" class="inputText validate[custom[number]]" name="secondYearOrgBelongPost" value="${resultMap.secondYearOrgBelongPost }" /></td>
					<td class="xlming"><input type="text" class="inputText validate[custom[number]]" name="secondYearOrgDoPost" value="${resultMap.secondYearOrgDoPost }" /></td>
					<td class="xlming"><input type="text" class="inputText validate[custom[number]]" name="secondYearBankPost" value="${resultMap.secondYearBankPost }" /></td>
				</tr>
				<tr>
					<td class="xlming">第三年已到位数</td>
					<td class="xlming"><input type="text" class="inputText validate[custom[number]]" name="thirdYearPost" value="${resultMap.thirdYearPost }" /></td>
					<td class="xlming"><input type="text" class="inputText validate[custom[number]]" name="thirdYearGovPost" value="${resultMap.thirdYearGovPost }" /></td>
					<td class="xlming"><input type="text" class="inputText validate[custom[number]]" name="thirdYearOrgBelongPost" value="${resultMap.thirdYearOrgBelongPost }" /></td>
					<td class="xlming"><input type="text" class="inputText validate[custom[number]]" name="thirdYearOrgDoPost" value="${resultMap.thirdYearOrgDoPost }" /></td>
					<td class="xlming"><input type="text" class="inputText validate[custom[number]]" name="thirdYearBankPost" value="${resultMap.thirdYearBankPost }" /></td>
				</tr>
				<tr>
					<td class="xlming">合计已到位数</td>
					<td class="xlming"><input type="text" class="inputText validate[custom[number]]" name="newAllPost" value="${resultMap.newAllPost }" /></td>
					<td class="xlming"><input type="text" class="inputText validate[custom[number]]" name="allGovPost" value="${resultMap.allGovPost }" /></td>
					<td class="xlming"><input type="text" class="inputText validate[custom[number]]" name="allOrgBelongPost" value="${resultMap.allOrgBelongPost }" /></td>
					<td class="xlming"><input type="text" class="inputText validate[custom[number]]" name="allOrgDoPost" value="${resultMap.allOrgDoPost }" /></td>
					<td class="xlming"><input type="text" class="inputText validate[custom[number]]" name="allBankPost" value="${resultMap.allBankPost }" /></td>
				</tr>
			</tbody>
		</table>
		</div>
		
		<div style="margin-top: 10px;">
		<table width="100%" cellspacing="0" cellpadding="0" class="bs_tb">
			<tbody>
			    <tr>
					<th colspan="6" class="theader">已经到位的经费支出情况(单位：万元)</th>
				</tr>
				<tr>
					<td class="xlming">已支出经费合计</td>
					<td class="xlming">设备购置费</td>
					<td class="xlming">能源材料费</td>
					<td class="xlming">人员费</td>
					<td class="xlming">试验测试费</td>
					<td class="xlming">其它</td>
				</tr>
				<tr>
					<td rowspan="3" class="xlming">
					   <input type="text" class="inputText" name="allPostCount" value="${resultMap.allPostCount }" /></td>
					<td class="xlming"><input type="text" class="inputText validate[custom[number]]" name="buyEquipmentPost" value="${resultMap.buyEquipmentPost }" /></td>
					<td class="xlming"><input type="text" class="inputText validate[custom[number]]" name="energyPost" value="${resultMap.energyPost }" /></td>
					<td class="xlming"><input type="text" class="inputText validate[custom[number]]" name="peoplePost" value="${resultMap.peoplePost }" /></td>
					<td class="xlming"><input type="text" class="inputText validate[custom[number]]" name="testPost" value="${resultMap.testPost }" /></td>
					<td rowspan="3" class="xlming"><input type="text" class="inputText" name="otherPost" value="${resultMap.otherPost }" /></td>
				</tr>
				<tr>
					<td class="xlming">燃料动力费</td>
					<td class="xlming">差旅费</td>
					<td class="xlming">会议费</td>
					<td class="xlming">管理费</td>
				</tr>
				<tr>
					<td class="xlming"><input type="text" class="inputText validate[custom[number]]" name="fuelPost" value="${resultMap.fuelPost }" /></td>
					<td class="xlming"><input type="text" class="inputText validate[custom[number]]" name="travelPost" value="${resultMap.travelPost }" /></td>
					<td class="xlming"><input type="text" class="inputText validate[custom[number]]" name="meetPost" value="${resultMap.meetPost }" /></td>
					<td class="xlming"><input type="text" class="inputText validate[custom[number]]" name="managePost" value="${resultMap.managePost }" /></td>
				</tr>
			</tbody>
		</table>
		</div>
		
		<div style="margin-top: 10px;">
		<table width="100%" cellspacing="0" cellpadding="0" class="bs_tb">
			<tbody>
			    <tr>
					<th colspan="6" class="theader">各级经费到位情况</th>
				</tr>
				<tr>
					<td style="text-align: left;padding-left: 20px;">
						<input type="checkbox" id="moneyOption1" name="moneyOption" value="1"
								<c:forEach var="op" items="${resultMap.moneyOption }">
									<c:if test="${op eq 1}">checked="checked"</c:if>
								</c:forEach>/>
								<label for="moneyOption1">按计划到位</label>
						&#12288;
						<input type="checkbox" id="moneyOption2" name="moneyOption" value="2" 
								<c:forEach var="op" items="${resultMap.moneyOption }">
									<c:if test="${op eq 2}">checked="checked"</c:if>
								</c:forEach>/> 
								<label for="moneyOption2">苏州市拨款,主管部门配套未按计划到位</label>
						&#12288;
						<input type="checkbox" id="moneyOption3" name="moneyOption" value="3"
								<c:forEach var="op" items="${resultMap.moneyOption }">
									<c:if test="${op eq 3}">checked="checked"</c:if>
								</c:forEach>/>
								<label for="moneyOption3">单位自筹经费未按计划到位</label>
					</td>
				</tr>
				<tr>
					<td style="text-align: left;padding-top: 5px;padding-left: 10px">
						&nbsp;经费未到位原因：
						 <c:choose>
                             <c:when test="${param.view==GlobalConstant.FLAG_Y}">
                                ${resultMap.fundReason}
                             </c:when>
                             <c:otherwise>
						<textarea placeholder="此处填写经费未到位原因" name="fundReason" class="xltxtarea" >${resultMap.fundReason}</textarea>
					     </c:otherwise>
					     </c:choose>
					</td>
				</tr>
			</tbody>
		</table>
		</div>
	</form>
<div class="button" style="width: 100%;
    <c:if test="${param.view == GlobalConstant.FLAG_Y}">display:none</c:if>">
	    <input onclick="nextOpt('step2');" id="nxt" class="search" type="button" value="下一步"/>
</div>
		
	