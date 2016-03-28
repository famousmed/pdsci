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
$('#prev').attr({"disabled":"disabled"});
jboxStartLoading();
form.submit();
}
</script>
</c:if>
        	    	<form action="<s:url value='/srm/proj/mine/saveStep'/>" method="post" id="projForm" style="position: relative;">
						<input type="hidden" name="pageName" value="chief"/>
						<input type="hidden" id="recFlow" name="recFlow" value="${projRec.recFlow}"/>
                        <input type="hidden" id="projFlow" name="projFlow" value="${proj.projFlow}"/>
						<input type="hidden" name="recTypeId" value="${param.recTypeId}"/>
						
					 <table class="basic" style="width: 100%">
					 	<tr>
					 		<th colspan="5" style="text-align: left;padding-left: 20px;font-size: 14px;">二、重点学科带头人概况</th>
					 	</tr>
				        <tr>
   							<td rowspan="3" width="17%" style="text-align: center;">基本情况</td>
							<td style="text-align:right;">姓&#12288;名：</td>
							<td style="text-align: left;padding-left: 10px;"><input type="text" name="name" value="${resultMap.name}" class="validate[required] inputText" style="width:177px;"/>
							<span class="redspan" style="color: red;padding: 0px;margin-left: 10px;">*</span>
							</td>
							<td style="text-align:right;">出生年月：</td>
							<td style="text-align: left;padding-left: 10px;">
								<input type="text" readonly="readonly" name="birthday" value="${resultMap.birthday}" class="validate[required] inputText"   onclick="WdatePicker({dateFmt:'yyyy-MM-dd'})" style="width:173px;"/>
							    <span class="redspan" style="color: red;padding: 0px;margin-left: 10px;">*</span>
							</td>
						</tr>
						<tr>
							<td style="text-align:right;">技术职称：</td>
							<td style="text-align: left;padding-left: 10px;">
								<input type="text" class="validate[required] inputText" name="title" value="${resultMap.title}" style="width:177px;"/>
							    <span class="redspan" style="color: red;padding: 0px;margin-left: 10px;">*</span>
							</td>
							<td style="text-align:right;">研究生导师： </td>
							<td style="text-align: left;padding-left: 10px;"><input type="text" class="validate[required] inputText" name="tutor" value="${resultMap.tutor}" style="width:177px;"/>（博/硕）
							<span class="redspan" style="color: red;padding: 0px;margin-left: 10px;">*</span>
							</td>
						</tr>
						<tr>
							<td style="text-align:right;">最高学会任职：</td>
							<td colspan="3" style="text-align: left;padding-left: 10px;"><input type="text" class="validate[required] inputText" name="highestTitle" value="${resultMap.highestTitle}" style="width:177px"/>
							<span class="redspan" style="color: red;padding: 0px;margin-left: 10px;">*</span>
							</td>
						</tr>
  						<tr>
  							<td style="text-align: center;">个人简介<br/>（业务能力、学术地位等）</td>
    						<td colspan="4" style="text-align:left;padding-left: 10px;padding-top: 10px;padding-bottom: 10px;">
    							<textarea placeholder="此处填写个人简介（包括业务能力、学术地位等）" style="width:98%;height: 150px; " name="personalIntroduction">${resultMap.personalIntroduction}</textarea>
    						</td>
  						</tr>
					 </table>
					 </form>
					 
                	 <div class="button"  style="width:100%;
                	 <c:if test="${param.view == GlobalConstant.FLAG_Y}">display:none;</c:if>">
                	 	<input id="prev" type="button" onclick="nextOpt('introduction')" class="search" value="上一步"/>
                	    <input id="nxt" type="button" onclick="nextOpt('achievement')" class="search" value="下一步"/>
      			     </div>
