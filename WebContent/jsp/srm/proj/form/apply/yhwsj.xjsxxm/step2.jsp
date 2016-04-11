<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<c:if test="${param.view!=GlobalConstant.FLAG_Y}">
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
	
	function calculate(){
		var sum = 0;
		$("#tb input").each(function(){
			var val = $(this).val();
			if(val == null || val == undefined || val == '' || isNaN(val)){
				val = 0;
			}
			sum += parseFloat(val) ;
		});
		$("#selfGradeAmount").val(parseFloat(sum.toFixed(2)));
	}
</script>
</c:if>

	<form action="<s:url value='/srm/proj/mine/saveStep'/>" method="post" style="position: relative;"
		id="projForm">
		<input type="hidden" id="pageName" name="pageName" value="step2" /> 
		<input type="hidden" id="recFlow" name="recFlow" value="${projRec.recFlow}"/>
		<input type="hidden" id="projFlow" name="projFlow" value="${proj.projFlow}"/>
		<input type="hidden" id="recTypeId" name="recTypeId" value="${param.recTypeId}"/>

		<font style="font-size: 14px; font-weight:bold;color: #333; ">二、评分标准</font>
		<table class="bs_tb" style="width: 100%; margin-top: 10px;" >
			<tr>
				<td>序号</td>
				<td>名  称</td>
				<td>评分标准</td>
				<td>分值</td>
				<td>自评分</td>
			</tr>
			<tbody id="tb">
				<tr>
					<td>1</td>
					<td>先进性</td>
					<td>国内先进10分、省内先进8分，市内先进5分，区内先进3分。（需省市级检索报告）</td>
					<td>10分</td>
					<td><input type="text" name="selfGrade1" value="${resultMap.selfGrade1}" class="validate[custom[number]] inputText" style="width: 90%" onchange="calculate();"/></td>
				</tr>
				<tr>
					<td>2</td>
					<td>实用性</td>
					<td>根据学术价值和临床开展情况给分（30例为基数，不足的，每减少1例扣0.5分）</td>
					<td>10分</td>
					<td><input type="text" name="selfGrade2" value="${resultMap.selfGrade2}" class="validate[custom[number]] inputText" style="width: 90%" onchange="calculate();"/></td>
				</tr>
				<tr>
					<td>3</td>
					<td>类型和应用</td>
					<td>创新型5分、引进型3分、改良型技术2分；应用率≥50%，5分，20%-50%，4分，≥10%，2分。</td>
					<td>10分</td>
					<td><input type="text" name="selfGrade3" value="${resultMap.selfGrade3}" class="validate[custom[number]] inputText" style="width: 90%" onchange="calculate();"/></td>
				</tr>
				<tr>
					<td>4</td>
					<td>技术难度</td>
					<td>高技术难度10分，中等技术难度7分，一般难度4分。</td>
					<td>10分</td>
					<td><input type="text" name="selfGrade4" value="${resultMap.selfGrade4}" class="validate[custom[number]] inputText" style="width: 90%" onchange="calculate();"/></td>
				</tr>
				<tr>
					<td>5</td>
					<td>合理性</td>
					<td>以设计合理、操作简单、易于推广为原则。</td>
					<td>5分</td>
					<td><input type="text" name="selfGrade5" value="${resultMap.selfGrade5}" class="validate[custom[number]] inputText" style="width: 90%" onchange="calculate();"/></td>
				</tr>
				<tr>
					<td>6</td>
					<td>医疗成本</td>
					<td>以成本低、治疗周期短，易于被病人接受为原则。</td>
					<td>10分</td>
					<td><input type="text" name="selfGrade6" value="${resultMap.selfGrade6}" class="validate[custom[number]] inputText" style="width: 90%" onchange="calculate();"/></td>
				</tr>
				<tr>
					<td>7</td>
					<td>社会效益</td>
					<td>与开展状况相参照，治疗效果良好，或受到社会关注，被新闻媒体报道等。</td>
					<td>15分</td>
					<td><input type="text" name="selfGrade7" value="${resultMap.selfGrade7}" class="validate[custom[number]] inputText" style="width: 90%" onchange="calculate();"/></td>
				</tr>
				<tr>
					<td>8</td>
					<td>推广价值</td>
					<td>以符合需求和易于推广实践运用为原则，具有可持续发展。</td>
					<td>15分</td>
					<td><input type="text" name="selfGrade8" value="${resultMap.selfGrade8}" class="validate[custom[number]] inputText" style="width: 90%" onchange="calculate();"/></td>
				</tr>
				<tr>
					<td>9</td>
					<td>合法性和安全性</td>
					<td>项目开展符合医疗法定程序及医学伦理，以患者安全为目标。</td>
					<td>10分</td>
					<td><input type="text" name="selfGrade9" value="${resultMap.selfGrade9}" class="validate[custom[number]] inputText" style="width: 90%" onchange="calculate();"/></td>
				</tr>
				<tr>
					<td>10</td>
					<td>项目汇报</td>
					<td>表述流畅清晰、条理清楚3分，课件内容图文并茂、详实，数据准确2分，汇报时间为5分钟，超过1分钟扣5分。</td>
					<td>5分</td>
					<td><input type="text" name="selfGrade10" value="${resultMap.selfGrade10}" class="validate[custom[number]] inputText" style="width: 90%" onchange="calculate();"/></td>
				</tr>
			</tbody>
			<tr>
				<td colspan="3">合计</td>
				<td>100分</td>
				<td><input type="text" id="selfGradeAmount" name="selfGradeAmount" value="${resultMap.selfGradeAmount}" class="validate[custom[number]] inputText" style="width: 90%;border-bottom-style: none;" readonly="readonly"/></td>
			</tr>
		 </table>
	</form>
	
   	<c:if test="${param.view!=GlobalConstant.FLAG_Y}">
		<div align="center" style="margin-top: 10px">
		    <input id="prev" type="button" onclick="nextOpt('step1')" class="search" value="上一步"/>
		    <input id="nxt" type="button" onclick="nextOpt('step3')" class="search" value="下一步"/>
       	</div>
    </c:if>

		