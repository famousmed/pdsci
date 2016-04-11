<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>
<c:if test="${param.view != GlobalConstant.FLAG_Y}">
<script type="text/javascript">
	function nextOpt(step){
		if(false==$("#projForm").validationEngine("validate")){
			return false;
		}
		var form = $('#projForm');
		var action = form.attr('action');
		action+="?nextPageName="+step;
		form.attr("action" , action);
		form.submit();
	}
	
	function increase(index , obj){
		var $increaseInput;
		var increaseVal = 0;
		var prevVal;
		var afterVal;
		if(index==0){
			prevVal = parseFloat($(obj).val());	
			afterVal = parseFloat($(obj).parent().next().children().val());
			$increaseInput = $(obj).parent().next().next().children();
		}else if(index==1){
			prevVal = parseFloat($(obj).parent().prev().children().val());
			afterVal = parseFloat($(obj).val());
			$increaseInput = $(obj).parent().next().children();
		}
		//alert((afterVal-prevVal) + "/" + prevVal);
		if(prevVal == null || prevVal == undefined || prevVal == '' || isNaN(prevVal) || prevVal == 0 ){
			$increaseInput.val(null);
			return false;
	 	}
		if(afterVal == null || afterVal == undefined || afterVal == '' || isNaN(afterVal)){
			$increaseInput.val(null);
			return false;
	 	}
		/* （建设期内—申报前3年）/申报前3年 */
		increaseVal = (afterVal-prevVal)/prevVal*100;
		$increaseInput.val(parseFloat(increaseVal.toFixed(2)) + "%");
	}
</script>
</c:if>
<style>
	.borderNone{border-bottom-style: none;}
</style>

	<form action="<s:url value='/srm/proj/mine/saveStep'/>" method="post" style="position: relative;"
		id="projForm">
		<input type="hidden" id="pageName" name="pageName" value="step6" /> 
		<input type="hidden" id="recFlow" name="recFlow" value="${projRec.recFlow}"/>
		<input type="hidden" id="projFlow" name="projFlow" value="${proj.projFlow}"/>
		<input type="hidden" id="recTypeId" name="recTypeId" value="${param.recTypeId}"/>
		
		<font style="font-size: 14px; font-weight:bold;color: #333;">九、余杭区医学重点学科合同书有关指标</font>
		<table class="bs_tb" style="width: 100%; margin-top: 10px;" >
			<tr>
				<th class="theader" colspan="5" style="text-align: center; padding-left: 20px;">学科临床指标</th>
			</tr>
	        <tr>		
		     	<td colspan="2">指标名称</td>
		     	<td width="15%">建设前一年<br/>（<input type="text" name="title1Year1" value="${resultMap.title1Year1}" onclick="WdatePicker({dateFmt:'yyyy'})" class="inputText" style="width: 50px;" readonly="readonly"/>年度）</td>
		     	<td width="15%">预计建设后<br/>（<input type="text" name="title1Year2" value="${resultMap.title1Year2}" onclick="WdatePicker({dateFmt:'yyyy'})" class="inputText" style="width: 50px;" readonly="readonly"/>年）</td>
		     	<td width="15%">预期增幅%<br/>(保留两位小数)</td>
		    </tr>
		    <tr>
		    	<td width="15%" rowspan="9">医疗服务指标</td> 
		    	<td>年出院人数</td> 
		     	<td><input type="text" name="index1Row1Cell1" value="${resultMap.index1Row1Cell1}" onchange="increase(0, this)" class="validate[custom[number]] inputText" style="width: 90%"/></td>
		     	<td><input type="text" name="index1Row1Cell2" value="${resultMap.index1Row1Cell2}" onchange="increase(1, this)" class="validate[custom[number]] inputText" style="width: 90%"/></td>
		     	<td><input type="text" name="index1Row1Cell3" value="${resultMap.index1Row1Cell3}" class="borderNone inputText" readonly="readonly" style="width: 90%"/></td>
		    </tr>
		    <tr>
		    	<td>年门诊人次</td> 
		     	<td><input type="text" name="index1Row2Cell1" value="${resultMap.index1Row2Cell1}" onchange="increase(0, this)" class="validate[custom[number]] inputText" style="width: 90%"/></td>
		     	<td><input type="text" name="index1Row2Cell2" value="${resultMap.index1Row2Cell2}" onchange="increase(1, this)" class="validate[custom[number]] inputText" style="width: 90%"/></td>
		     	<td><input type="text" name="index1Row2Cell3" value="${resultMap.index1Row2Cell3}" class="borderNone inputText" readonly="readonly" style="width: 90%"/></td>
		    </tr>
		    <tr>
		    	<td>业务收入</td> 
		     	<td><input type="text" name="index1Row3Cell1" value="${resultMap.index1Row3Cell1}" onchange="increase(0, this)" class="validate[custom[number]] inputText" style="width: 90%"/></td>
		     	<td><input type="text" name="index1Row3Cell2" value="${resultMap.index1Row3Cell2}" onchange="increase(1, this)" class="validate[custom[number]] inputText" style="width: 90%"/></td>
		     	<td><input type="text" name="index1Row3Cell3" value="${resultMap.index1Row3Cell3}" class="borderNone inputText" readonly="readonly" style="width: 90%"/></td>
		    </tr>
		    <tr>
		    	<td>床位数</td> 
		     	<td><input type="text" name="index1Row4Cell1" value="${resultMap.index1Row4Cell1}" onchange="increase(0, this)" class="validate[custom[number]] inputText" style="width: 90%"/></td>
		     	<td><input type="text" name="index1Row4Cell2" value="${resultMap.index1Row4Cell2}" onchange="increase(1, this)" class="validate[custom[number]] inputText" style="width: 90%"/></td>
		     	<td><input type="text" name="index1Row4Cell3" value="${resultMap.index1Row4Cell3}" class="borderNone inputText" readonly="readonly" style="width: 90%"/></td>
		    </tr>
		    <tr>
		    	<td>平均住院日</td> 
		     	<td><input type="text" name="index1Row5Cell1" value="${resultMap.index1Row5Cell1}" onchange="increase(0, this)" class="validate[custom[number]] inputText" style="width: 90%"/></td>
		     	<td><input type="text" name="index1Row5Cell2" value="${resultMap.index1Row5Cell2}" onchange="increase(1, this)" class="validate[custom[number]] inputText" style="width: 90%"/></td>
		     	<td><input type="text" name="index1Row5Cell3" value="${resultMap.index1Row5Cell3}" class="borderNone inputText" readonly="readonly" style="width: 90%"/></td>
		    </tr>
		    <tr>
		    	<td>年均手术量</td> 
		     	<td><input type="text" name="index1Row6Cell1" value="${resultMap.index1Row6Cell1}" onchange="increase(0, this)" class="validate[custom[number]] inputText" style="width: 90%"/></td>
		     	<td><input type="text" name="index1Row6Cell2" value="${resultMap.index1Row6Cell2}" onchange="increase(1, this)" class="validate[custom[number]] inputText" style="width: 90%"/></td>
		     	<td><input type="text" name="index1Row6Cell3" value="${resultMap.index1Row6Cell3}" class="borderNone inputText" readonly="readonly" style="width: 90%"/></td>
		    </tr>
		    <tr>
		    	<td>急危重症比例</td> 
		     	<td><input type="text" name="index1Row7Cell1" value="${resultMap.index1Row7Cell1}" onchange="increase(0, this)" class="validate[custom[number]] inputText" style="width: 90%"/></td>
		     	<td><input type="text" name="index1Row7Cell2" value="${resultMap.index1Row7Cell2}" onchange="increase(1, this)" class="validate[custom[number]] inputText" style="width: 90%"/></td>
		     	<td><input type="text" name="index1Row7Cell3" value="${resultMap.index1Row7Cell3}" class="borderNone inputText" readonly="readonly" style="width: 90%"/></td>
		    </tr>
		    <tr>
		    	<td>疑难症比例</td> 
		     	<td><input type="text" name="index1Row8Cell1" value="${resultMap.index1Row8Cell1}" onchange="increase(0, this)" class="validate[custom[number]] inputText" style="width: 90%"/></td>
		     	<td><input type="text" name="index1Row8Cell2" value="${resultMap.index1Row8Cell2}" onchange="increase(1, this)" class="validate[custom[number]] inputText" style="width: 90%"/></td>
		     	<td><input type="text" name="index1Row8Cell3" value="${resultMap.index1Row8Cell3}" class="borderNone inputText" readonly="readonly" style="width: 90%"/></td>
		    </tr>
		    <tr>
		    	<td>治愈好转率</td> 
		     	<td><input type="text" name="index1Row9Cell1" value="${resultMap.index1Row9Cell1}" onchange="increase(0, this)" class="validate[custom[number]] inputText" style="width: 90%"/></td>
		     	<td><input type="text" name="index1Row9Cell2" value="${resultMap.index1Row9Cell2}" onchange="increase(1, this)" class="validate[custom[number]] inputText" style="width: 90%"/></td>
		     	<td><input type="text" name="index1Row9Cell3" value="${resultMap.index1Row9Cell3}" class="borderNone inputText" readonly="readonly" style="width: 90%"/></td>
		    </tr>
		    
		    <tr>
		    	<td rowspan="4">合理用药指标</td> 
		    	<td>基本药物占处方用药比例</td> 
		     	<td><input type="text" name="index1Row10Cell1" value="${resultMap.index1Row10Cell1}" onchange="increase(0, this)" class="validate[custom[number]] inputText" style="width: 90%"/></td>
		     	<td><input type="text" name="index1Row10Cell2" value="${resultMap.index1Row10Cell2}" onchange="increase(1, this)" class="validate[custom[number]] inputText" style="width: 90%"/></td>
		     	<td><input type="text" name="index1Row10Cell3" value="${resultMap.index1Row10Cell3}" class="borderNone inputText" readonly="readonly" style="width: 90%"/></td>
		    </tr>
		    <tr>
		    	<td>门诊患者抗菌药物使用比例</td> 
		     	<td><input type="text" name="index1Row11Cell1" value="${resultMap.index1Row11Cell1}" onchange="increase(0, this)" class="validate[custom[number]] inputText" style="width: 90%"/></td>
		     	<td><input type="text" name="index1Row11Cell2" value="${resultMap.index1Row11Cell2}" onchange="increase(1, this)" class="validate[custom[number]] inputText" style="width: 90%"/></td>
		     	<td><input type="text" name="index1Row11Cell3" value="${resultMap.index1Row11Cell3}" class="borderNone inputText" readonly="readonly" style="width: 90%"/></td>
		    </tr>
		    <tr>
		    	<td>住院患者抗菌药物使用比例</td> 
		     	<td><input type="text" name="index1Row12Cell1" value="${resultMap.index1Row12Cell1}" onchange="increase(0, this)" class="validate[custom[number]] inputText" style="width: 90%"/></td>
		     	<td><input type="text" name="index1Row12Cell2" value="${resultMap.index1Row12Cell2}" onchange="increase(1, this)" class="validate[custom[number]] inputText" style="width: 90%"/></td>
		     	<td><input type="text" name="index1Row12Cell3" value="${resultMap.index1Row12Cell3}" class="borderNone inputText" readonly="readonly" style="width: 90%"/></td>
		    </tr>
		    <tr>
		    	<td>抗菌药物使用强度</td> 
		     	<td><input type="text" name="index1Row13Cell1" value="${resultMap.index1Row13Cell1}" onchange="increase(0, this)" class="validate[custom[number]] inputText" style="width: 90%"/></td>
		     	<td><input type="text" name="index1Row13Cell2" value="${resultMap.index1Row13Cell2}" onchange="increase(1, this)" class="validate[custom[number]] inputText" style="width: 90%"/></td>
		     	<td><input type="text" name="index1Row13Cell3" value="${resultMap.index1Row13Cell3}" class="borderNone inputText" readonly="readonly" style="width: 90%"/></td>
		    </tr>
		    <tr>
		    	<td rowspan="11">相关病区质量指标</td> 
		    	<td>诊断符合率</td> 
		     	<td><input type="text" name="index1Row14Cell1" value="${resultMap.index1Row14Cell1}" onchange="increase(0, this)" class="validate[custom[number]] inputText" style="width: 90%"/></td>
		     	<td><input type="text" name="index1Row14Cell2" value="${resultMap.index1Row14Cell2}" onchange="increase(1, this)" class="validate[custom[number]] inputText" style="width: 90%"/></td>
		     	<td><input type="text" name="index1Row14Cell3" value="${resultMap.index1Row14Cell3}" class="borderNone inputText" readonly="readonly" style="width: 90%"/></td>
		    </tr>
		    <tr>
		    	<td>临床主要诊断、病理诊断符合率</td> 
		     	<td><input type="text" name="index1Row15Cell1" value="${resultMap.index1Row15Cell1}" onchange="increase(0, this)" class="validate[custom[number]] inputText" style="width: 90%"/></td>
		     	<td><input type="text" name="index1Row15Cell2" value="${resultMap.index1Row15Cell2}" onchange="increase(1, this)" class="validate[custom[number]] inputText" style="width: 90%"/></td>
		     	<td><input type="text" name="index1Row15Cell3" value="${resultMap.index1Row15Cell3}" class="borderNone inputText" readonly="readonly" style="width: 90%"/></td>
		    </tr>
		    <tr>
		    	<td>甲级病案率</td> 
		     	<td><input type="text" name="index1Row16Cell1" value="${resultMap.index1Row16Cell1}" onchange="increase(0, this)" class="validate[custom[number]] inputText" style="width: 90%"/></td>
		     	<td><input type="text" name="index1Row16Cell2" value="${resultMap.index1Row16Cell2}" onchange="increase(1, this)" class="validate[custom[number]] inputText" style="width: 90%"/></td>
		     	<td><input type="text" name="index1Row16Cell3" value="${resultMap.index1Row16Cell3}" class="borderNone inputText" readonly="readonly" style="width: 90%"/></td>
		    </tr>
		    <tr>
		    	<td>出院患者随访率</td> 
		     	<td><input type="text" name="index1Row17Cell1" value="${resultMap.index1Row17Cell1}" onchange="increase(0, this)" class="validate[custom[number]] inputText" style="width: 90%"/></td>
		     	<td><input type="text" name="index1Row17Cell2" value="${resultMap.index1Row17Cell2}" onchange="increase(1, this)" class="validate[custom[number]] inputText" style="width: 90%"/></td>
		     	<td><input type="text" name="index1Row17Cell3" value="${resultMap.index1Row17Cell3}" class="borderNone inputText" readonly="readonly" style="width: 90%"/></td>
		    </tr>
		    <tr>
		    	<td>择期手术患者术前平均住院日</td> 
		     	<td><input type="text" name="index1Row18Cell1" value="${resultMap.index1Row18Cell1}" onchange="increase(0, this)" class="validate[custom[number]] inputText" style="width: 90%"/></td>
		     	<td><input type="text" name="index1Row18Cell2" value="${resultMap.index1Row18Cell2}" onchange="increase(1, this)" class="validate[custom[number]] inputText" style="width: 90%"/></td>
		     	<td><input type="text" name="index1Row18Cell3" value="${resultMap.index1Row18Cell3}" class="borderNone inputText" readonly="readonly" style="width: 90%"/></td>
		    </tr>
		    <tr>
		    	<td>基础护理合格率</td> 
		     	<td><input type="text" name="index1Row19Cell1" value="${resultMap.index1Row19Cell1}" onchange="increase(0, this)" class="validate[custom[number]] inputText" style="width: 90%"/></td>
		     	<td><input type="text" name="index1Row19Cell2" value="${resultMap.index1Row19Cell2}" onchange="increase(1, this)" class="validate[custom[number]] inputText" style="width: 90%"/></td>
		     	<td><input type="text" name="index1Row19Cell3" value="${resultMap.index1Row19Cell3}" class="borderNone inputText" readonly="readonly" style="width: 90%"/></td>
		    </tr>
		    <tr>
		    	<td>危重患者护理合格率</td> 
		     	<td><input type="text" name="index1Row20Cell1" value="${resultMap.index1Row20Cell1}" onchange="increase(0, this)" class="validate[custom[number]] inputText" style="width: 90%"/></td>
		     	<td><input type="text" name="index1Row20Cell2" value="${resultMap.index1Row20Cell2}" onchange="increase(1, this)" class="validate[custom[number]] inputText" style="width: 90%"/></td>
		     	<td><input type="text" name="index1Row20Cell3" value="${resultMap.index1Row20Cell3}" class="borderNone inputText" readonly="readonly" style="width: 90%"/></td>
		    </tr>
		    <tr>
		    	<td>院内感染率</td> 
		     	<td><input type="text" name="index1Row21Cell1" value="${resultMap.index1Row21Cell1}" onchange="increase(0, this)" class="validate[custom[number]] inputText" style="width: 90%"/></td>
		     	<td><input type="text" name="index1Row21Cell2" value="${resultMap.index1Row21Cell2}" onchange="increase(1, this)" class="validate[custom[number]] inputText" style="width: 90%"/></td>
		     	<td><input type="text" name="index1Row21Cell3" value="${resultMap.index1Row21Cell3}" class="borderNone inputText" readonly="readonly" style="width: 90%"/></td>
		    </tr>
		    <tr>
		    	<td>病床周转率</td> 
		     	<td><input type="text" name="index1Row22Cell1" value="${resultMap.index1Row22Cell1}" onchange="increase(0, this)" class="validate[custom[number]] inputText" style="width: 90%"/></td>
		     	<td><input type="text" name="index1Row22Cell2" value="${resultMap.index1Row22Cell2}" onchange="increase(1, this)" class="validate[custom[number]] inputText" style="width: 90%"/></td>
		     	<td><input type="text" name="index1Row22Cell3" value="${resultMap.index1Row22Cell3}" class="borderNone inputText" readonly="readonly" style="width: 90%"/></td>
		    </tr>
		    <tr>
		    	<td>病床周转次数</td> 
		     	<td><input type="text" name="index1Row23Cell1" value="${resultMap.index1Row23Cell1}" onchange="increase(0, this)" class="validate[custom[number]] inputText" style="width: 90%"/></td>
		     	<td><input type="text" name="index1Row23Cell2" value="${resultMap.index1Row23Cell2}" onchange="increase(1, this)" class="validate[custom[number]] inputText" style="width: 90%"/></td>
		     	<td><input type="text" name="index1Row23Cell3" value="${resultMap.index1Row23Cell3}" class="borderNone inputText" readonly="readonly" style="width: 90%"/></td>
		    </tr>
		    <tr>
		    	<td>药品收入占业务收入比例</td> 
		     	<td><input type="text" name="index1Row24Cell1" value="${resultMap.index1Row24Cell1}" onchange="increase(0, this)" class="validate[custom[number]] inputText" style="width: 90%"/></td>
		     	<td><input type="text" name="index1Row24Cell2" value="${resultMap.index1Row24Cell2}" onchange="increase(1, this)" class="validate[custom[number]] inputText" style="width: 90%"/></td>
		     	<td><input type="text" name="index1Row24Cell3" value="${resultMap.index1Row24Cell3}" class="borderNone inputText" readonly="readonly" style="width: 90%"/></td>
		    </tr>
		    <tr>
		    	<td rowspan="4">门诊质量指标</td>
		    	<td>年均专家出诊人次所占比例</td> 
		     	<td><input type="text" name="index1Row25Cell1" value="${resultMap.index1Row25Cell1}" onchange="increase(0, this)" class="validate[custom[number]] inputText" style="width: 90%"/></td>
		     	<td><input type="text" name="index1Row25Cell2" value="${resultMap.index1Row25Cell2}" onchange="increase(1, this)" class="validate[custom[number]] inputText" style="width: 90%"/></td>
		     	<td><input type="text" name="index1Row25Cell3" value="${resultMap.index1Row25Cell3}" class="borderNone inputText" readonly="readonly" style="width: 90%"/></td>
		    </tr>
		    <tr>
		    	<td>年门诊人均费用</td> 
		     	<td><input type="text" name="index1Row26Cell1" value="${resultMap.index1Row26Cell1}" onchange="increase(0, this)" class="validate[custom[number]] inputText" style="width: 90%"/></td>
		     	<td><input type="text" name="index1Row26Cell2" value="${resultMap.index1Row26Cell2}" onchange="increase(1, this)" class="validate[custom[number]] inputText" style="width: 90%"/></td>
		     	<td><input type="text" name="index1Row26Cell3" value="${resultMap.index1Row26Cell3}" class="borderNone inputText" readonly="readonly" style="width: 90%"/></td>
		    </tr>
		    <tr>
		    	<td>日均专病门诊数量</td> 
		     	<td><input type="text" name="index1Row27Cell1" value="${resultMap.index1Row27Cell1}" onchange="increase(0, this)" class="validate[custom[number]] inputText" style="width: 90%"/></td>
		     	<td><input type="text" name="index1Row27Cell2" value="${resultMap.index1Row27Cell2}" onchange="increase(1, this)" class="validate[custom[number]] inputText" style="width: 90%"/></td>
		     	<td><input type="text" name="index1Row27Cell3" value="${resultMap.index1Row27Cell3}" class="borderNone inputText" readonly="readonly" style="width: 90%"/></td>
		    </tr>
		    <tr>
		    	<td>门诊预约挂号比例</td> 
		     	<td><input type="text" name="index1Row28Cell1" value="${resultMap.index1Row28Cell1}" onchange="increase(0, this)" class="validate[custom[number]] inputText" style="width: 90%"/></td>
		     	<td><input type="text" name="index1Row28Cell2" value="${resultMap.index1Row28Cell2}" onchange="increase(1, this)" class="validate[custom[number]] inputText" style="width: 90%"/></td>
		     	<td><input type="text" name="index1Row28Cell3" value="${resultMap.index1Row28Cell3}" class="borderNone inputText" readonly="readonly" style="width: 90%"/></td>
		    </tr>
	    </table>
	    
	    
	    <table class="bs_tb" style="width: 100%; margin-top: 20px;" >
			<tr>
				<th class="theader" colspan="5" class="" style="text-align: center; padding-left: 20px;">学科科研指标</th>
			</tr>
	        <tr>		
		     	<td colspan="2">指标名称</td>
		     	<td width="15%">
		     		申报前3年<br/>（<input type="text" name="title2Year1" value="${resultMap.title2Year1}" onclick="WdatePicker({dateFmt:'yyyy'})" class="inputText" style="width: 50px;" readonly="readonly"/>
		     		-<input type="text" name="title2Year2" value="${resultMap.title2Year2}" onclick="WdatePicker({dateFmt:'yyyy'})" class="inputText" style="width: 50px;" readonly="readonly"/>）
	     		</td>
		     	<td width="15%">
		     		建设期内<br/>（<input type="text" name="title2Year3" value="${resultMap.title2Year3}" onclick="WdatePicker({dateFmt:'yyyy'})" class="inputText" style="width: 50px;" readonly="readonly"/>
	     			-<input type="text" name="title2Year4" value="${resultMap.title2Year4}" onclick="WdatePicker({dateFmt:'yyyy'})" class="inputText" style="width: 50px;" readonly="readonly"/>）
	     		</td>
		     	<td width="15%">预期增幅%</td>
		    </tr>
		    <tr>
		    	<td width="15%" rowspan="6">作为第一单位承担科研项目数量</td> 
		    	<td>国家级项目</td> 
		     	<td><input type="text" name="index2Row1Cell1" value="${resultMap.index2Row1Cell1}" onchange="increase(0, this)" class="validate[custom[number]] inputText" style="width: 90%"/></td>
		     	<td><input type="text" name="index2Row1Cell2" value="${resultMap.index2Row1Cell2}" onchange="increase(1, this)" class="validate[custom[number]] inputText" style="width: 90%"/></td>
		     	<td><input type="text" name="index2Row1Cell3" value="${resultMap.index2Row1Cell3}" class="borderNone inputText" readonly="readonly" style="width: 90%"/></td>
		    </tr>
		    <tr>
		    	<td>省部级项目</td> 
		     	<td><input type="text" name="index2Row2Cell1" value="${resultMap.index2Row2Cell1}" onchange="increase(0, this)" class="validate[custom[number]] inputText" style="width: 90%"/></td>
		     	<td><input type="text" name="index2Row2Cell2" value="${resultMap.index2Row2Cell2}" onchange="increase(1, this)" class="validate[custom[number]] inputText" style="width: 90%"/></td>
		     	<td><input type="text" name="index2Row2Cell3" value="${resultMap.index2Row2Cell3}" class="borderNone inputText" readonly="readonly" style="width: 90%"/></td>
		    </tr>
		    <tr>
		    	<td>厅局级项目</td> 
		     	<td><input type="text" name="index2Row3Cell1" value="${resultMap.index2Row3Cell1}" onchange="increase(0, this)" class="validate[custom[number]] inputText" style="width: 90%"/></td>
		     	<td><input type="text" name="index2Row3Cell2" value="${resultMap.index2Row3Cell2}" onchange="increase(1, this)" class="validate[custom[number]] inputText" style="width: 90%"/></td>
		     	<td><input type="text" name="index2Row3Cell3" value="${resultMap.index2Row3Cell3}" class="borderNone inputText" readonly="readonly" style="width: 90%"/></td>
		    </tr>
		    <tr>
		    	<td>市级项目</td> 
		     	<td><input type="text" name="index2Row4Cell1" value="${resultMap.index2Row4Cell1}" onchange="increase(0, this)" class="validate[custom[number]] inputText" style="width: 90%"/></td>
		     	<td><input type="text" name="index2Row4Cell2" value="${resultMap.index2Row4Cell2}" onchange="increase(1, this)" class="validate[custom[number]] inputText" style="width: 90%"/></td>
		     	<td><input type="text" name="index2Row4Cell3" value="${resultMap.index2Row4Cell3}" class="borderNone inputText" readonly="readonly" style="width: 90%"/></td>
		    </tr>
		    <tr>
		    	<td>区级项目</td> 
		     	<td><input type="text" name="index2Row5Cell1" value="${resultMap.index2Row5Cell1}" onchange="increase(0, this)" class="validate[custom[number]] inputText" style="width: 90%"/></td>
		     	<td><input type="text" name="index2Row5Cell2" value="${resultMap.index2Row5Cell2}" onchange="increase(1, this)" class="validate[custom[number]] inputText" style="width: 90%"/></td>
		     	<td><input type="text" name="index2Row5Cell3" value="${resultMap.index2Row5Cell3}" class="borderNone inputText" readonly="readonly" style="width: 90%"/></td>
		    </tr>
		    <tr>
		    	<td>拟设计申报课题名称</td> 
		     	<td colspan="3"><input type="text" name="index2Row6" value="${resultMap.index2Row6}" onchange="increase(0, this)" class="inputText" style="width: 90%"/></td>
		    </tr>

		    
		    <tr>
		    	<td rowspan="6">作为联合单位承担科研项目数量</td>
		    	<td>国家级项目</td> 
		     	<td><input type="text" name="index2Row7Cell1" value="${resultMap.index2Row7Cell1}" onchange="increase(0, this)" class="validate[custom[number]] inputText" style="width: 90%"/></td>
		     	<td><input type="text" name="index2Row7Cell2" value="${resultMap.index2Row7Cell2}" onchange="increase(1, this)" class="validate[custom[number]] inputText" style="width: 90%"/></td>
		     	<td><input type="text" name="index2Row7Cell3" value="${resultMap.index2Row7Cell3}" class="borderNone inputText" readonly="readonly" style="width: 90%"/></td>
		    </tr>
		    <tr>
		    	<td>省部级项目</td> 
		     	<td><input type="text" name="index2Row8Cell1" value="${resultMap.index2Row8Cell1}" onchange="increase(0, this)" class="validate[custom[number]] inputText" style="width: 90%"/></td>
		     	<td><input type="text" name="index2Row8Cell2" value="${resultMap.index2Row8Cell2}" onchange="increase(1, this)" class="validate[custom[number]] inputText" style="width: 90%"/></td>
		     	<td><input type="text" name="index2Row8Cell3" value="${resultMap.index2Row8Cell3}" class="borderNone inputText" readonly="readonly" style="width: 90%"/></td>
		    </tr>
		    <tr>
		    	<td>厅局级项目</td> 
		     	<td><input type="text" name="index2Row9Cell1" value="${resultMap.index2Row9Cell1}" onchange="increase(0, this)" class="validate[custom[number]] inputText" style="width: 90%"/></td>
		     	<td><input type="text" name="index2Row9Cell2" value="${resultMap.index2Row9Cell2}" onchange="increase(1, this)" class="validate[custom[number]] inputText" style="width: 90%"/></td>
		     	<td><input type="text" name="index2Row9Cell3" value="${resultMap.index2Row9Cell3}" class="borderNone inputText" readonly="readonly" style="width: 90%"/></td>
		    </tr>
		    <tr>
		    	<td>市级项目</td> 
		     	<td><input type="text" name="index2Row10Cell1" value="${resultMap.index2Row10Cell1}" onchange="increase(0, this)" class="validate[custom[number]] inputText" style="width: 90%"/></td>
		     	<td><input type="text" name="index2Row10Cell2" value="${resultMap.index2Row10Cell2}" onchange="increase(1, this)" class="validate[custom[number]] inputText" style="width: 90%"/></td>
		     	<td><input type="text" name="index2Row10Cell3" value="${resultMap.index2Row10Cell3}" class="borderNone inputText" readonly="readonly" style="width: 90%"/></td>
		    </tr>
		    <tr>
		    	<td>区级项目</td> 
		     	<td><input type="text" name="index2Row11Cell1" value="${resultMap.index2Row11Cell1}" onchange="increase(0, this)" class="validate[custom[number]] inputText" style="width: 90%"/></td>
		     	<td><input type="text" name="index2Row11Cell2" value="${resultMap.index2Row11Cell2}" onchange="increase(1, this)" class="validate[custom[number]] inputText" style="width: 90%"/></td>
		     	<td><input type="text" name="index2Row11Cell3" value="${resultMap.index2Row11Cell3}" class="borderNone inputText" readonly="readonly" style="width: 90%"/></td>
		    </tr>
		    <tr>
		    	<td>拟参与课题名称</td> 
		     	<td colspan="3"><input type="text" name="index2Row12" value="${resultMap.index2Row12}" onchange="increase(0, this)" class="inputText" style="width: 90%"/></td>
		    </tr>
		    
		     
		    <tr>
		    	<td rowspan="2">预期总经费</td>
		    	<td></td>
		    	<td width="15%">
		     		申报前3年<br/>（<input type="text" name="title3Year1" value="${resultMap.title3Year1}" onclick="WdatePicker({dateFmt:'yyyy'})" class="inputText" style="width: 50px;" readonly="readonly"/>
		     		-<input type="text" name="title3Year2" value="${resultMap.title3Year2}" onclick="WdatePicker({dateFmt:'yyyy'})" class="inputText" style="width: 50px;" readonly="readonly"/>）
	     		</td>
		     	<td width="15%">
		     		建设期内<br/>（<input type="text" name="title3Year3" value="${resultMap.title3Year3}" onclick="WdatePicker({dateFmt:'yyyy'})" class="inputText" style="width: 50px;" readonly="readonly"/>
	     			-<input type="text" name="title3Year4" value="${resultMap.title3Year4}" onclick="WdatePicker({dateFmt:'yyyy'})" class="inputText" style="width: 50px;" readonly="readonly"/>）
	     		</td>
		     	<td width="15%">预期增幅%</td>
		    </tr>
		    <tr>
		     	<td width="40%"><input type="text" name="index2Row13Cell0" value="${resultMap.index2Row13Cell0}" class="inputText" style="width: 90%"/></td>
		     	<td><input type="text" name="index2Row13Cell1" value="${resultMap.index2Row13Cell1}" onchange="increase(0, this)" class="validate[custom[number]] inputText" style="width: 90%"/></td>
		     	<td><input type="text" name="index2Row13Cell2" value="${resultMap.index2Row13Cell2}" onchange="increase(1, this)" class="validate[custom[number]] inputText" style="width: 90%"/></td>
		     	<td><input type="text" name="index2Row13Cell3" value="${resultMap.index2Row13Cell3}" class="borderNone inputText" readonly="readonly" style="width: 90%"/></td>
		    </tr>
		    
		    
		    <tr>
		    	<td rowspan="5">围绕主攻方向发表文章</td>
		    	<td></td>
		    	<td width="15%">
		     		申报前3年<br/>（<input type="text" name="title4Year1" value="${resultMap.title4Year1}" onclick="WdatePicker({dateFmt:'yyyy'})" class="inputText" style="width: 50px;" readonly="readonly"/>
		     		-<input type="text" name="title4Year2" value="${resultMap.title4Year2}" onclick="WdatePicker({dateFmt:'yyyy'})" class="inputText" style="width: 50px;" readonly="readonly"/>）
	     		</td>
		     	<td width="15%">
		     		建设期内<br/>（<input type="text" name="title4Year3" value="${resultMap.title4Year3}" onclick="WdatePicker({dateFmt:'yyyy'})" class="inputText" style="width: 50px;" readonly="readonly"/>
	     			-<input type="text" name="title4Year4" value="${resultMap.title4Year4}" onclick="WdatePicker({dateFmt:'yyyy'})" class="inputText" style="width: 50px;" readonly="readonly"/>）
	     		</td>
		     	<td width="15%">预期增幅%</td>
		    </tr>
		    <tr>
		    	<td>SCI论文数</td> 
		     	<td><input type="text" name="index2Row14Cell1" value="${resultMap.index2Row14Cell1}" onchange="increase(0, this)" class="validate[custom[number]] inputText" style="width: 90%"/></td>
		     	<td><input type="text" name="index2Row14Cell2" value="${resultMap.index2Row14Cell2}" onchange="increase(1, this)" class="validate[custom[number]] inputText" style="width: 90%"/></td>
		     	<td><input type="text" name="index2Row14Cell3" value="${resultMap.index2Row14Cell3}" class="borderNone inputText" readonly="readonly" style="width: 90%"/></td>
		    </tr>
		    <tr>
		    	<td>中华级论文数</td> 
		     	<td><input type="text" name="index2Row15Cell1" value="${resultMap.index2Row15Cell1}" onchange="increase(0, this)" class="validate[custom[number]] inputText" style="width: 90%"/></td>
		     	<td><input type="text" name="index2Row15Cell2" value="${resultMap.index2Row15Cell2}" onchange="increase(1, this)" class="validate[custom[number]] inputText" style="width: 90%"/></td>
		     	<td><input type="text" name="index2Row15Cell3" value="${resultMap.index2Row15Cell3}" class="borderNone inputText" readonly="readonly" style="width: 90%"/></td>
		    </tr>
		    <tr>
		    	<td>其他论文数</td> 
		     	<td><input type="text" name="index2Row16Cell1" value="${resultMap.index2Row16Cell1}" onchange="increase(0, this)" class="validate[custom[number]] inputText" style="width: 90%"/></td>
		     	<td><input type="text" name="index2Row16Cell2" value="${resultMap.index2Row16Cell2}" onchange="increase(1, this)" class="validate[custom[number]] inputText" style="width: 90%"/></td>
		     	<td><input type="text" name="index2Row16Cell3" value="${resultMap.index2Row16Cell3}" class="borderNone inputText" readonly="readonly" style="width: 90%"/></td>
		    </tr>
		    <tr>
		    	<td>学科成员人均论文数</td> 
		     	<td><input type="text" name="index2Row17Cell1" value="${resultMap.index2Row17Cell1}" onchange="increase(0, this)" class="validate[custom[number]] inputText" style="width: 90%"/></td>
		     	<td><input type="text" name="index2Row17Cell2" value="${resultMap.index2Row17Cell2}" onchange="increase(1, this)" class="validate[custom[number]] inputText" style="width: 90%"/></td>
		     	<td><input type="text" name="index2Row17Cell3" value="${resultMap.index2Row17Cell3}" class="borderNone inputText" readonly="readonly" style="width: 90%"/></td>
		    </tr>
		    
		    
		    <tr>
		    	<td rowspan="3">获得专利和专著</td>
		    	<td></td>
		    	<td width="15%">
		     		申报前3年<br/>（<input type="text" name="title5Year1" value="${resultMap.title5Year1}" onclick="WdatePicker({dateFmt:'yyyy'})" class="inputText" style="width: 50px;" readonly="readonly"/>
		     		-<input type="text" name="title5Year2" value="${resultMap.title5Year2}" onclick="WdatePicker({dateFmt:'yyyy'})" class="inputText" style="width: 50px;" readonly="readonly"/>）
	     		</td>
		     	<td width="15%">
		     		建设期内<br/>（<input type="text" name="title5Year3" value="${resultMap.title5Year3}" onclick="WdatePicker({dateFmt:'yyyy'})" class="inputText" style="width: 50px;" readonly="readonly"/>
	     			-<input type="text" name="title5Year4" value="${resultMap.title5Year4}" onclick="WdatePicker({dateFmt:'yyyy'})" class="inputText" style="width: 50px;" readonly="readonly"/>）
	     		</td>
		     	<td width="15%">预期增幅%</td>
		    </tr>
		    <tr>
		    	<td>专利数</td> 
		     	<td><input type="text" name="index2Row18Cell1" value="${resultMap.index2Row18Cell1}" onchange="increase(0, this)" class="validate[custom[number]] inputText" style="width: 90%"/></td>
		     	<td><input type="text" name="index2Row18Cell2" value="${resultMap.index2Row18Cell2}" onchange="increase(1, this)" class="validate[custom[number]] inputText" style="width: 90%"/></td>
		     	<td><input type="text" name="index2Row18Cell3" value="${resultMap.index2Row18Cell3}" class="borderNone inputText" readonly="readonly" style="width: 90%"/></td>
		    </tr>
		    <tr>
		    	<td>专著数量</td> 
		     	<td><input type="text" name="index2Row19Cell1" value="${resultMap.index2Row19Cell1}" onchange="increase(0, this)" class="validate[custom[number]] inputText" style="width: 90%"/></td>
		     	<td><input type="text" name="index2Row19Cell2" value="${resultMap.index2Row19Cell2}" onchange="increase(1, this)" class="validate[custom[number]] inputText" style="width: 90%"/></td>
		     	<td><input type="text" name="index2Row19Cell3" value="${resultMap.index2Row19Cell3}" class="borderNone inputText" readonly="readonly" style="width: 90%"/></td>
		    </tr>
	    </table>
	    
	    
	    
	    <table class="bs_tb" style="width: 100%; margin-top: 20px;" >
			<tr>
				<th class="theader" colspan="5" class="" style="text-align: center; padding-left: 20px;">学科人才培养指标</th>
			</tr>
	        <tr>		
		     	<td colspan="2">指标名称</td>
		     	<td width="15%">申报前一年<br/>（<input type="text" name="title6Year1" value="${resultMap.title6Year1}" onclick="WdatePicker({dateFmt:'yyyy'})" class="inputText" style="width: 50px;" readonly="readonly"/>年度）</td>
		     	<td width="15%">三年后<br/>（<input type="text" name="title6Year2" value="${resultMap.title6Year2}" onclick="WdatePicker({dateFmt:'yyyy'})" class="inputText" style="width: 50px;" readonly="readonly"/>年）</td>
		     	<td width="15%">预期增幅%</td>
		    </tr>
		    <tr>
		    	<td width="15%" rowspan="5">人才培养</td> 
		    	<td>团队人数</td> 
		     	<td><input type="text" name="index3Row1Cell1" value="${resultMap.index3Row1Cell1}" onchange="increase(0, this)" class="validate[custom[number]] inputText" style="width: 90%"/></td>
		     	<td><input type="text" name="index3Row1Cell2" value="${resultMap.index3Row1Cell2}" onchange="increase(1, this)" class="validate[custom[number]] inputText" style="width: 90%"/></td>
		     	<td><input type="text" name="index3Row1Cell3" value="${resultMap.index3Row1Cell3}" class="borderNone inputText" readonly="readonly" style="width: 90%"/></td>
		    </tr>
		    <tr>
		    	<td>高级职称数</td> 
		     	<td><input type="text" name="index3Row2Cell1" value="${resultMap.index3Row2Cell1}" onchange="increase(0, this)" class="validate[custom[number]] inputText" style="width: 90%"/></td>
		     	<td><input type="text" name="index3Row2Cell2" value="${resultMap.index3Row2Cell2}" onchange="increase(1, this)" class="validate[custom[number]] inputText" style="width: 90%"/></td>
		     	<td><input type="text" name="index3Row2Cell3" value="${resultMap.index3Row2Cell3}" class="borderNone inputText" readonly="readonly" style="width: 90%"/></td>
		    </tr>
		    <tr>
		    	<td>副高级职称数</td> 
		     	<td><input type="text" name="index3Row3Cell1" value="${resultMap.index3Row3Cell1}" onchange="increase(0, this)" class="validate[custom[number]] inputText" style="width: 90%"/></td>
		     	<td><input type="text" name="index3Row3Cell2" value="${resultMap.index3Row3Cell2}" onchange="increase(1, this)" class="validate[custom[number]] inputText" style="width: 90%"/></td>
		     	<td><input type="text" name="index3Row3Cell3" value="${resultMap.index3Row3Cell3}" class="borderNone inputText" readonly="readonly" style="width: 90%"/></td>
		    </tr>
		    <tr>
		    	<td>硕士数</td> 
		     	<td><input type="text" name="index3Row4Cell1" value="${resultMap.index3Row4Cell1}" onchange="increase(0, this)" class="validate[custom[number]] inputText" style="width: 90%"/></td>
		     	<td><input type="text" name="index3Row4Cell2" value="${resultMap.index3Row4Cell2}" onchange="increase(1, this)" class="validate[custom[number]] inputText" style="width: 90%"/></td>
		     	<td><input type="text" name="index3Row4Cell3" value="${resultMap.index3Row4Cell3}" class="borderNone inputText" readonly="readonly" style="width: 90%"/></td>
		    </tr>
		    <tr>
		    	<td>博士数</td> 
		     	<td><input type="text" name="index3Row5Cell1" value="${resultMap.index3Row5Cell1}" onchange="increase(0, this)" class="validate[custom[number]] inputText" style="width: 90%"/></td>
		     	<td><input type="text" name="index3Row5Cell2" value="${resultMap.index3Row5Cell2}" onchange="increase(1, this)" class="validate[custom[number]] inputText" style="width: 90%"/></td>
		     	<td><input type="text" name="index3Row5Cell3" value="${resultMap.index3Row5Cell3}" class="borderNone inputText" readonly="readonly" style="width: 90%"/></td>
		    </tr>
		    
		    <tr>
		    	<td rowspan="4">主办或承办学术会议或继续医学教育</td>
		    	<td></td>
		    	<td width="15%">
		     		申报前3年<br/>（<input type="text" name="title7Year1" value="${resultMap.title7Year1}" onclick="WdatePicker({dateFmt:'yyyy'})" class="inputText" style="width: 50px;" readonly="readonly"/>
		     		-<input type="text" name="title7Year2" value="${resultMap.title7Year2}" onclick="WdatePicker({dateFmt:'yyyy'})" class="inputText" style="width: 50px;" readonly="readonly"/>）
	     		</td>
		     	<td width="15%">
		     		建设期内<br/>（<input type="text" name="title7Year3" value="${resultMap.title7Year3}" onclick="WdatePicker({dateFmt:'yyyy'})" class="inputText" style="width: 50px;" readonly="readonly"/>
	     			-<input type="text" name="title7Year4" value="${resultMap.title7Year4}" onclick="WdatePicker({dateFmt:'yyyy'})" class="inputText" style="width: 50px;" readonly="readonly"/>）
	     		</td>
		     	<td width="15%">预期增幅%</td>
		    </tr>
		    <tr>
		    	<td>国家级</td> 
		     	<td><input type="text" name="index3Row6Cell1" value="${resultMap.index3Row6Cell1}" onchange="increase(0, this)" class="validate[custom[number]] inputText" style="width: 90%"/></td>
		     	<td><input type="text" name="index3Row6Cell2" value="${resultMap.index3Row6Cell2}" onchange="increase(1, this)" class="validate[custom[number]] inputText" style="width: 90%"/></td>
		     	<td><input type="text" name="index3Row6Cell3" value="${resultMap.index3Row6Cell3}" class="borderNone inputText" readonly="readonly" style="width: 90%"/></td>
		    </tr>
		    <tr>
		    	<td>省级</td> 
		     	<td><input type="text" name="index3Row7Cell1" value="${resultMap.index3Row7Cell1}" onchange="increase(0, this)" class="validate[custom[number]] inputText" style="width: 90%"/></td>
		     	<td><input type="text" name="index3Row7Cell2" value="${resultMap.index3Row7Cell2}" onchange="increase(1, this)" class="validate[custom[number]] inputText" style="width: 90%"/></td>
		     	<td><input type="text" name="index3Row7Cell3" value="${resultMap.index3Row7Cell3}" class="borderNone inputText" readonly="readonly" style="width: 90%"/></td>
		    </tr>
		    <tr>
		    	<td>市级</td> 
		     	<td><input type="text" name="index3Row8Cell1" value="${resultMap.index3Row8Cell1}" onchange="increase(0, this)" class="validate[custom[number]] inputText" style="width: 90%"/></td>
		     	<td><input type="text" name="index3Row8Cell2" value="${resultMap.index3Row8Cell2}" onchange="increase(1, this)" class="validate[custom[number]] inputText" style="width: 90%"/></td>
		     	<td><input type="text" name="index3Row8Cell3" value="${resultMap.index3Row8Cell3}" class="borderNone inputText" readonly="readonly" style="width: 90%"/></td>
		    </tr>
	    </table>
	</form>
	
    <c:if test="${param.view!=GlobalConstant.FLAG_Y}">
		<div align="center" style="margin-top: 10px">
		    <input id="prev" type="button" onclick="nextOpt('step5')" class="search" value="上一步"/>
     	    <input id="nxt" type="button" onclick="nextOpt('finish')" class="search" value="完&#12288;成"/>
       	</div>
    </c:if>
   
  

		