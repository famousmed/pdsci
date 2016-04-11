<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<script>
	function chooseHospital(orgFlow){
		var url="<s:url value='/sczyres/manage/showAdmit'/>";
		jboxPostLoad('content' , url , {"orgFlow":orgFlow} , true);
	}
	function getInfo(doctorFlow){
		jboxOpen("<s:url value='/sczyres/doctor/getsingupinfofordialog'/>?userFlow="+doctorFlow,"人员信息",1000,550);
	}
	function chooseConfirm(Flag,orgFlow){
		var url="<s:url value='/sczyres/manage/showConfirm'/>";
		var requestData ={
				"Flag":Flag,
				"orgFlow":orgFlow
		}
		jboxPostLoad('content' , url ,requestData , true);
	}
	
	function searchDocRecruit(){
		var url="<s:url value='/sczyres/manage/showDocRecruit'/>";
		jboxPostLoad('content' , url ,$("#searchForm").serialize() , true);
	}
		
</script>
<div class="main_hd">
    <h2 class="underline">
        <span>基地录取人员情况表</span>
    </h2>
	<div class="div_search">
        <form id="searchForm">
        <b>基地:</b>
            <select name="orgFlow" onchange="searchDocRecruit();"  class="select" >
    	    <option value="" >请选择</option>
        	<c:forEach items="${hospitals}" var="hos">
  	    	    <option value="${hos.orgFlow}" <c:if test='${param.orgFlow eq hos.orgFlow}'>selected="selected"</c:if>>${hos.orgName}</option> 
       		</c:forEach>
   		</select>
   		&#12288;
   		<select name="confirmFlag"  onchange="searchDocRecruit();"  class="select" >
   		    <option value="" >请选择</option>
   		    <option value="${GlobalConstant.FLAG_Y}"  <c:if test='${GlobalConstant.FLAG_Y eq param.confirmFlag}'>selected="selected"</c:if>>已确认</option>
   		    <option value="${GlobalConstant.NULL}"  <c:if test='${GlobalConstant.NULL eq param.confirmFlag}'>selected="selected"</c:if>>未确认</option>
   		</select>
        </form>
   		<c:choose >
            <c:when test="${empty recruitCount}"><span>确认人数：0&nbsp;&nbsp;</span><span>录取人数：0&nbsp;&nbsp;</span></c:when>
            <c:otherwise >  <span>确认人数：${confirmCount}&nbsp;&nbsp;</span><span>录取人数：${recruitCount}&nbsp;&nbsp;</span></c:otherwise>
        </c:choose>
   	</div> 
</div>
<div class="search_table">
    <table border="0" cellspacing="0" cellpadding="0" class="grid">
        <tr>
            <th>姓名</th>
            <th>性别</th>
            <th>身份证号</th>
            <th>人员类型</th>
            <th>学历</th>
            <th>填报专业</th>
            <th>人员信息</th>
    	</tr>
    	<c:forEach items="${doctorRecruitExts}" var="dor">
            <tr>
      			<td >${dor.doctor.doctorName}</td>
      		    <td>${dor.sysUser.sexName}</td>
      		    <td>${dor.sysUser.idNo}</td>
      		    <td>${dor.doctor.doctorTypeName}</td>
      		    <td>${dor.sysUser.educationName}</td>
     		    <td>${dor.catSpeName}-${dor.speName}</td>
      		    <td><a class="btn" onclick="getInfo('${dor.doctorFlow}');">详情</a></td>
   	       </tr>
        </c:forEach>
        <c:if test="${empty doctorRecruitExts}">
            <tr>
                <td colspan="7">无记录</td>
            </tr>
        </c:if>
    </table>
</div> 
    	
