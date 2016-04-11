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

function doBack(){
	window.location.href="<s:url value='/srm/proj/mine/process?projFlow='/>"+$("#projFlow").val();
}
</script>
</c:if>

        	    	<form action="<s:url value='/srm/proj/mine/saveStep'/>" method="post" id="projForm" style="position: relative;">
						<input type="hidden" name="pageName" value="introduction"/>
						<input type="hidden" id="recFlow" name="recFlow" value="${projRec.recFlow}"/>
                        <input type="hidden" id="projFlow" name="projFlow" value="${proj.projFlow}"/>
						<input type="hidden" name="recTypeId" value="${param.recTypeId}"/>
						
					<div >
						<table  class="basic" style="width: 100%">
						  <tr><th colspan="2" style="text-align: left;padding-left: 20px;font-size: 14px">一、基本信息</th></tr>
  						   <tr>
   							<td width="200px;" style="text-align: center">学科名称：</td>
    						<td  style="text-align: left;padding-left: 10px;"><input type="text" class="validate[required] inputText" name='projName' value="<c:if test='${empty resultMap.projName and param.view!=GlobalConstant.FLAG_Y}'>${proj.projName}</c:if><c:if test='${! empty resultMap.projName}'>${resultMap.projName}</c:if>" style="width: 46%"/>
    						<span class="redspan" style="color: red;padding: 0px;margin-left: 10px;">*</span></td>
  						  </tr>
  						  <tr>
   							<td  style="text-align: center">单位名称：</td>
    						<td  style="text-align: left;padding-left: 10px;"><input type="text" class="validate[required] inputText" name="orgName" value="<c:if test='${empty resultMap.orgName and param.view!=GlobalConstant.FLAG_Y}'>${proj.applyOrgName}</c:if><c:if test='${! empty resultMap.orgName}'>${resultMap.orgName}</c:if>" style="width: 46%"/>
    						<span class="redspan" style="color: red;padding: 0px;margin-left: 10px;">*</span>
    						</td>
  						  </tr>
  						  <tr>
   							<td   style="text-align: center">单位地址：</td>
    						<td style="text-align: left;padding-left: 10px;"><input type="text"  class="inputText" name="orgAddress" value="<c:if test='${empty resultMap.orgAddress and param.view!=GlobalConstant.FLAG_Y}'>${org.orgAddress}</c:if><c:if test='${! empty resultMap.orgAddress}'>${resultMap.orgAddress}</c:if>" style="width: 46%"/>
    						</td>
  						  </tr>
  						  <tr>
   							<td   style="text-align: center">邮政编码：</td>
    						<td style="text-align: left;padding-left: 10px;"><input type="text"  class="inputText" name="postcode" value="<c:if test='${empty resultMap.postcode and param.view!=GlobalConstant.FLAG_Y}'>${org.orgZip}</c:if><c:if test='${! empty resultMap.postcode}'>${resultMap.postcode}</c:if>" style="width: 46%"/></td>
  						  </tr>
  						  <tr>
   							<td   style="text-align: center">联系人：</td>
    						<td style="text-align: left;padding-left: 10px;"><input type="text" class="validate[required] inputText" name="linkman" value="<c:if test='${empty resultMap.linkman and param.view!=GlobalConstant.FLAG_Y}'>${proj.applyUserName}</c:if><c:if test='${! empty resultMap.linkman}'>${resultMap.linkman}</c:if>" style="width: 46%"/>
    						<span class="redspan" style="color: red;padding: 0px;margin-left: 10px;">*</span>
    						</td>
  						  </tr>
  						  <tr>
   							<td   style="text-align: center">联系电话：</td>
    						<td style="text-align: left;padding-left: 10px;"><input type="text" name="telephone" class="validate[required] inputText" value="<c:if test='${empty resultMap.telephone and param.view!=GlobalConstant.FLAG_Y}'>${user.userPhone}</c:if><c:if test='${! empty resultMap.telephone}'>${resultMap.telephone}</c:if>" class="validate[custom[phone]]" style="width: 46%"/>
    						<span class="redspan" style="color: red;padding: 0px;margin-left: 10px;">*</span>
    						</td>
  						  </tr>
  						  <tr>
   							<td style="text-align: center">邮箱地址：</td>
    						<td style="text-align: left;padding-left: 10px;"><input type="text" name="email" class="validate[required] inputText" value="<c:if test='${empty resultMap.email and param.view!=GlobalConstant.FLAG_Y}'>${user.userEmail}</c:if><c:if test='${! empty resultMap.email}'>${resultMap.email}</c:if>" class="validate[custom[email]]" style="width: 46%"/>
    						<span class="redspan" style="color: red;padding: 0px;margin-left: 10px;">*</span>
    						</td>
  						  </tr>
					 </table>
			    </div>
					 <table class="basic" style="width: 100%;border-top: none;">
				        <tr><th style="text-align: left;padding-left: 20px;">简介<span class="redspan" style="color: red;padding: 0px;margin-left: 10px;">*</span></th></tr>
				        <tr>
					     	<td style="text-align:left;padding-left: 10px;padding-top: 10px;padding-bottom: 10px;">
					     		<textarea placeholder="&#12288;概述本学科主要技术特色、优势，规模、国内外学术地位等（限1000字内）" class="validate[required] validate[maxSize[1000]] xltxtarea"  name="introductionContent">${resultMap.introductionContent}</textarea>
					     	</td>
					    </tr>
					 </table>
					 
					  <table class="basic" style="width: 100%;margin-top: 10px;">
				        <tr><th style="text-align: left;padding-left: 20px;">主攻方向<span class="redspan" style="color: red;padding: 0px;margin-left: 10px;">*</span></th></tr>
				        <tr>
					     	<td style="text-align:left;padding-left: 10px;padding-top: 10px;padding-bottom: 10px;">
					     		<textarea placeholder="&#12288;围绕1-2个主攻方向，概述本学科今后3年在应用基础研究、临床研究方面的建设目标、研究内容、预期成果、年度安排等。（限2000字内）。"  class="validate[required] validate[maxSize[2000]] xltxtarea" name="attackContent">${resultMap.attackContent}</textarea>
					     	</td>
					    </tr>
					 </table>
					 
					 </form>
                	 <div class="button" style="width:100%;
                	 <c:if test="${param.view == GlobalConstant.FLAG_Y}">display:none;</c:if>">
                	 	<input id="prev" type="button" onclick="doBack()" class="search" value="返&#12288;回"/>
                	    <input id="nxt" type="button" onclick="nextOpt('chief')" class="search" value="下一步"/>
      			     </div>