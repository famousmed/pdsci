<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<script>
function searchDoctorForStatus(obj){
	var status = $(obj).attr('id');
	$("#status").val(status);
	searchDoctor();
}
function getInfo(doctorFlow){
	jboxOpen("<s:url value='/sczyres/doctor/getsingupinfofordialog'/>?userFlow="+doctorFlow,"人员信息",1000,550);
}
function searchDoctor(){
	var data = $("#searchForm").serialize();
	jboxPostLoad("content","<s:url value='/sczyres/hosptial/recruitDoctorForSwap'/>",data ,true);
}
</script>
   <div class="main_hd">
       <h2>调剂</h2>
       <div class="title_tab" id="toptab">
          <ul>
            <li class="${empty param.status or param.status=='Y'?'tab_select':tab}" id="Y" onclick="searchDoctorForStatus(this);"><a>本基地</a></li>
            <c:if test='${showJointOrg}'>
                <li class="${param.status=='N'?'tab_select':tab}" id="N" onclick="searchDoctorForStatus(this);"><a>协同基地</a></li>
            </c:if>
          </ul>
       </div>
	   
	   <div class="div_search" style="text-align:right;">
	       <form id="searchForm">
			<input type="text" id="key" style="width: 200px;" name="key" value="${param.key}" class="input" placeholder="姓名/手机号/邮件/身份证" 
			onchange="searchDoctor();"
			/>
			<input type="hidden" name="status" id="status" value='${param.status}'/>
		    </form>
		</div>
   </div>
     <div class="search_table">
        <table border="0" cellpadding="0" cellspacing="0" class="grid">
            <tr>
              <th style=" text-align:left; padding-left:5px;">姓名</th>
              <th>身份证号</th>
              <th>填报志愿</th>
              <th>调剂志愿</th>
              <th>是否确认</th>
              <th>人员信息</th>
            </tr>
            <c:forEach items="${doctorRecruitExts}"  var="doc">
            <tr>
				<td style=" text-align:left; padding-left:5px;">${doc.sysUser.userName}</td>
				<td>${doc.sysUser.idNo}</td>
				<td>
				    <c:set var="noRecruit" value='${noRecruitMap[doc.doctorFlow]}'></c:set>
				    ${noRecruit.orgName}<br/>${noRecruit.catSpeName}-${noRecruit.speName}
				</td>
				<td>${doc.orgName}<br/>${doc.catSpeName}-${doc.speName}</td>
				<td>
				<c:if test='${doc.confirmFlag eq null}'>未确认</c:if>
				<c:if test='${doc.confirmFlag eq "N"}'>已放弃</c:if>
				<c:if test='${doc.confirmFlag eq "Y"}'>已确认</c:if>
				</td>
				<td><a class="btn" onclick="getInfo('${doc.doctorFlow}');">详情</a></td>
            </tr>
            </c:forEach>
            <c:if test="${empty doctorRecruitExts}">
            <tr>
                <td colspan="6">无记录</td>
            </tr>
        </c:if>
          </table>
    </div>

