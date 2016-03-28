<jsp:include page="/jsp/hbres/htmlhead-hbres.jsp">
	<jsp:param name="font" value="true"/>
</jsp:include>
<script type="text/javascript">
	function toPage(page) {
		if(page!=undefined){
			$("#currentPage").val(page);			
		}
		audit('${statusId}',$("#key").val() , $("#currentPage").val());
	} 
	function getInfo(userFlow){
		jboxOpen("<s:url value='/hbres/singup/manage/userInfo'/>?userFlow="+userFlow+"&isActive=","用户信息",1000,550);
	}
	$(document).ready(function(){
		$("li").click(function(){
			$(".tab_select").addClass("tab");
			$(".tab_select").removeClass("tab_select");
			$(this).removeClass("tab");
			$(this).addClass("tab_select");
			audit($(this).attr("statusId"),$("#key").val(),null);
		});
	});
	function searchPerson(){
		audit('${statusId}',$("#key").val(),null);
	}
	
	function withdrawUser(userFlow){
		jboxConfirm("确认退回使其重新填写信息吗?",function(){
			var data = {
					doctorFlow:userFlow,
					reeditFlag:"${GlobalConstant.FLAG_Y}"
			};
			jboxPost("<s:url value='/hbres/singup/manage/withdrawUser'/>",data,
				function(resp){
					if(resp == "${GlobalConstant.OPERATE_SUCCESSED}"){
						$("#withdraw_"+userFlow).hide();
					}
				}
			,null,true);
		});
	}
</script>
      <div class="main_hd">
        <h2>报名审核</h2>
        <div class="title_tab" id="toptab">
          <ul>
            <li class="${statusId==regStatusEnumPassing.id?'tab_select':'tab' }" statusId="${regStatusEnumPassing.id }"><a>待审核</a></li>
            <li class="${statusId==regStatusEnumPassed.id?'tab_select':'tab' }" statusId="${regStatusEnumPassed.id }"><a>审核通过</a></li>
            <li class="${statusId==regStatusEnumUnPassed.id?'tab_select':'tab' }" statusId="${regStatusEnumUnPassed.id }"><a>审核不通过</a></li>
          </ul>
        </div>
      </div>
      <div class="main_bd" id="div_table_0" > 
      	<div class="div_search fr">
      	<input type="text" class="fr input" id="key" name="key" value="${key}" placeholder="姓名/手机号/邮件/身份证" onblur="searchPerson();" style="width:200px; height:30px;"/>
      	</div>
        <div class="div_table">
        <c:if test="${statusId!=regStatusEnumUnPassed.id }">
          <table border="0" cellpadding="0" cellspacing="0" class="grid">
            <tr>
              <th  style="text-align: left;padding-left: 40px;">姓名</th>
              <th  style="text-align: left;padding-left: 40px;">身份证</th>
              <th  style="text-align: left;padding-left: 40px;">毕业专业</th>
                <th  style="text-align: left;padding-left: 40px;">类型</th>
              <th>报名信息</th>
            </tr>
            <c:forEach items="${ userList}" var="user">
            <tr>
              <td style="text-align: left;padding-left: 40px;">${user.sysUser.userName}</td>
              <td style="text-align: left;padding-left: 40px;">${user.sysUser.idNo}</td>
              <td style="text-align: left;padding-left: 40px;">
                  <c:forEach var="dict" items="${dictTypeEnumGraduateMajorList}">
              	        <c:if test='${user.specialized==dict.dictId}'>${dict.dictName}</c:if>
              	    </c:forEach>
              </td>
              <td style="text-align: left;padding-left: 40px;">${user.doctorTypeName}</td>
              <td >
	              <a class="btn" onclick="getInfo('${user.sysUser.userFlow}');">
	              	<c:if test="${statusId==regStatusEnumPassing.id }">审&#12288;核</c:if>
	              	<c:if test="${statusId==regStatusEnumPassed.id }">报名信息</c:if>
	              </a>
            </td>
            </tr>
            </c:forEach>
          </table>
          </c:if>
          <c:if test="${statusId==regStatusEnumUnPassed.id }">
          <table border="0" cellpadding="0" cellspacing="0" class="grid">
            <tr>
              <th  style="text-align: left;padding-left: 40px;width: 100px;">姓名</th>
              <th  style="text-align: left;padding-left: 40px;">未通过原因</th>
              <th width="120px;">报名信息</th>
              <th width="120px;">操作</th>
            </tr>
            <c:forEach items="${ userList}" var="user">
            <tr>
              <td style="text-align: left;padding-left: 40px;">${user.sysUser.userName}</td>
              <td style="text-align: left;padding-left: 40px;">${user.disactiveReason}</td>
              <td ><a class="btn" onclick="getInfo('${user.sysUser.userFlow}');">报名信息</a></td>
              <td >
	              <c:if test="${GlobalConstant.FLAG_Y != user.reeditFlag }">
	              	<a class="btn" id="withdraw_${user.sysUser.userFlow}" onclick="withdrawUser('${user.sysUser.userFlow}');">退&#12288;回</a>
	              </c:if>
              </td>
            </tr>
            </c:forEach>
          </table>
          </c:if>
        </div>
        <div class="page" style="padding-right: 40px;">
       	 <input id="currentPage" type="hidden" name="currentPage" value="${currentPage}"/>
           <c:set var="pageView" value="${pdfn:getPageView(userList)}" scope="request"></c:set>
	  		 <pd:pagination-hbres toPage="toPage"/>	 
        </div>
      </div>
      
