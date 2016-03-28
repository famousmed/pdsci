<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>
<c:if test="${param.view != GlobalConstant.FLAG_Y}">
<script type="text/javascript">
function nextOpt(step){
	if(false==$("#projForm").validationEngine("validate")){
			return false;
		}
	var form = $('#projForm');
	form.append("<input name='nextPageName' value='"+step+"' type='hidden'/>");
	$('#nxt').attr({"disabled":"disabled"});
	jboxStartLoading();
	form.submit();
	
}

</script>
</c:if>
<style type="text/css">
.title_sp{padding-left: 10px;font-size: 14px;padding-bottom: 10px;font-weight: bold;color: #333;}
</style>
<c:choose>
<c:when test="${param.view==GlobalConstant.FLAG_Y}">
<style type="text/css">
.bs_tb_sp td{text-align: left; padding: 5px 15px;}
</style>
</c:when>
<c:otherwise>
<style type="text/css">
#tagContent{border: none;}
</style>
</c:otherwise>
</c:choose>

<form action="<s:url value='/srm/proj/mine/saveStep'/>" method="post" id="projForm" style="position: relative;">
    <input type="hidden" id="pageName" name="pageName" value="step1"/>
	<input type="hidden" id="recFlow" name="recFlow" value="${projRec.recFlow}"/>
    <input type="hidden" id="projFlow" name="projFlow" value="${proj.projFlow}"/>
    <input type="hidden" name="recTypeId" value="${param.recTypeId}"/>

    <table width="100%" cellpadding="0" cellspacing="0" class="basic">
        <tbody>
    	    <tr><th colspan="4" style="text-align: left;padding-left: 20px;font-size: 14px;">一、基本信息</th></tr>
    	    <tr>
    		    <td width="20%" style="text-align: right;">项目名称：</td>
    		    <td colspan="3" width="80%">
    			    <c:choose>
    				    <c:when test="${param.view==GlobalConstant.FLAG_Y}">${resultMap.projName}</c:when>
    				    <c:otherwise><input name="projName" type="text" value="<c:if test='${empty resultMap.projName}'>${proj.projName}</c:if><c:if test='${!empty resultMap.projName}'>${resultMap.projName}</c:if>" class="validate[required] inputText"  style="width: 400px; "/></c:otherwise>
    			    </c:choose>
    			    <span class="redspan" style="color: red;padding: 0px;margin-left: 10px;">*</span>
                </td>
    	    </tr>
    	    <tr>
    		    <td width="20%" style="text-align: right;">承担单位：</td>
    		    <td colspan="3" width="80%">
    		        <c:choose>
   				        <c:when test="${param.view==GlobalConstant.FLAG_Y}">${resultMap.orgName}</c:when>
   				        <c:otherwise><input name="orgName" type="text" value="<c:if test='${empty resultMap.orgName}'>${proj.applyOrgName}</c:if><c:if test='${!empty resultMap.orgName}'>${resultMap.orgName}</c:if>" class="validate[required] inputText"  style="width: 400px; "/></c:otherwise>
   			        </c:choose>
   			        <span class="redspan" style="color: red;padding: 0px;margin-left: 10px;">*</span>
                </td>
    	    </tr>
    	    <tr>
     		    <td width="20%" style="text-align: right;">所在地区：</td>
    		    <td colspan="3" width="80%">
    		        <c:choose>
   				        <c:when test="${param.view==GlobalConstant.FLAG_Y}">${resultMap.area}</c:when>
   				        <c:otherwise><input name="area" type="text" value="<c:if test='${empty resultMap.area}'>${org.orgAreaName}</c:if><c:if test='${!empty resultMap.area}'>${resultMap.area}</c:if>" class="validate[required] inputText"  style="width: 400px; "/></c:otherwise>
   			        </c:choose>
   			        <span class="redspan" style="color: red;padding: 0px;margin-left: 10px;">*</span>
                </td>
    	    </tr>
    	    <tr>
    		    <td width="20%" style="text-align: right;">单位地址：</td>
    		    <td colspan="3" >
    		        <c:choose>
   				        <c:when test="${param.view==GlobalConstant.FLAG_Y}"><span style="display: inline-block; width:300px">${resultMap.orgAddress}&nbsp;</span></c:when>
   				        <c:otherwise><input name="orgAddress" type="text" value="<c:if test='${empty resultMap.orgAddress}'>${org.orgAddress}</c:if><c:if test='${!empty resultMap.orgAddress}'>${resultMap.orgAddress}</c:if>" class="validate[required] inputText"  style="width: 400px; "/></c:otherwise>
   			        </c:choose>
   			        <span class="redspan" style="color: red;padding: 0px;margin-left: 10px;">*</span>
                 		&#12288;&#12288;邮编：
                	<c:choose>
   				        <c:when test="${param.view==GlobalConstant.FLAG_Y}">${resultMap.postcode}</c:when>
   				        <c:otherwise><input name="postcode" type="text" value="<c:if test='${empty resultMap.postcode}'>${org.orgZip}</c:if><c:if test='${! empty resultMap.postcode}'>${resultMap.postcode}</c:if>" class="validate[required] inputText"  style="width: 200px; "/></c:otherwise>
  				    </c:choose>
  				    <span class="redspan" style="color: red;padding: 0px;margin-left: 10px;">*</span>
                </td>
    	    </tr>
    	    <tr>
    		    <td width="20%" style="text-align: right;">项目负责人：</td>
    		    <td colspan="3" >
    		        <c:choose>
   				        <c:when test="${param.view==GlobalConstant.FLAG_Y}"><span style="display: inline-block; width:300px">${resultMap.applyUserName}&nbsp;</span></c:when>
   				        <c:otherwise><input name="applyUserName" type="text" value="<c:if test='${empty resultMap.applyUserName}'>${proj.applyUserName}</c:if><c:if test='${!empty resultMap.applyUserName}'>${resultMap.applyUserName}</c:if>" class="validate[required] inputText"  style="width: 400px; "/></c:otherwise>
   			        </c:choose>
   			        <span class="redspan" style="color: red;padding: 0px;margin-left: 10px;">*</span>
                  	&#12288;&#12288;电话：
                    <c:choose>
   				        <c:when test="${param.view==GlobalConstant.FLAG_Y}">${resultMap.phone}</c:when>
   				        <c:otherwise><input name="phone" type="text" value="<c:if test='${empty resultMap.phone}'>${user.userPhone}</c:if><c:if test='${!empty resultMap.phone}'>${resultMap.phone}</c:if>" class="validate[required] inputText"  style="width: 200px; "/></c:otherwise>
   			        </c:choose>
   			        <span class="redspan" style="color: red;padding: 0px;margin-left: 10px;">*</span>
                </td>
    	    </tr>
    	    <tr>
    		    <td width="20%" style="text-align: right;">主管部门：</td>
    		    <td colspan="3" width="80%">
    		        <c:choose>
   				        <c:when test="${param.view==GlobalConstant.FLAG_Y}">${resultMap.chargeOrgName}</c:when>
   				        <c:otherwise><input name="chargeOrgName" type="text" value="<c:if test='${empty resultMap.chargeOrgName}'>${org.chargeOrgName}</c:if><c:if test='${!empty resultMap.chargeOrgName}'>${resultMap.chargeOrgName}</c:if>" class="inputText"  style="width: 400px; "/></c:otherwise>
   			        </c:choose>
                </td>
    	    </tr>
        </tbody>
    </table>
    
	<c:if test="${param.view!=GlobalConstant.FLAG_Y}">
	<div align="center" style="margin-top: 10px">
		<input type="button" id="nxt" onclick="nextOpt('step2')" class="search" value="下一步"/>
	</div>
	</c:if>
</form>


