<script type="text/javascript">
$(document).ready(function(){
	$("#checkbox").click(function(){
		var length = $('#checkbox:checked').length;
		if (length==1) {
			setTimeout(function(){
				$('[type="checkbox"]').attr("checked",true);
			},100);
		}
		if(length==0){
			$('[type="checkbox"]').removeAttr("checked");
		};
	});
	$("#s>input").click(function(){
		var checkbox = $('#s>input').length;
		var currcheckbox = $('#s>:checked').length;
		if(checkbox==currcheckbox){
			 $('#checkbox').attr("checked",true);
		}
		if(currcheckbox!=checkbox){
			 $('#checkbox').removeAttr("checked");
		}
	});
});

</script>
  <div class="search_table">
       <table border="0" cellpadding="0" cellspacing="0" class="grid">
            <tr>
            	<th width="2%"><input type="checkbox" id="checkbox" value=""></th>
                <th width="5%">姓名</th>
                <th width="15%">证件号</th>
                <th width="5%">性别</th>
                <th width="20%">培训基地</th>
                <th width="10%">培训类别</th>
                <th width="10%">培训专业</th>
                <th width="10%">注册时间</th>
                <th width="5%">届别</th>
                <c:if test="${param.source == 'hospital'}">
                	<th width="8%">审核类型</th>
                </c:if>
                <th width="10%">操作</th>
            </tr>
            <c:forEach items="${recruitList}" var="recruit">
            	<tr>
	             	<td id="s"><input type="checkbox" value="${recruit.doctorFlow}"></td>
	                <td>${recruit.sysUser.userName}</td>
	                <td>${recruit.sysUser.idNo}</td>
	                <td>${recruit.sysUser.sexName}</td>
	                <td>${recruit.orgName}</td>
	                <td>${recruit.catSpeName}</td>
	                <td>${recruit.speName}</td>
	                <td>${pdfn:transDateTime(recruit.createTime)}</td>
	                <td>${recruit.sessionNumber}</td>
	                <c:if test="${param.source == 'hospital'}">
	                	<td>培训信息</td>
	                </c:if>
	                <td><a class="btn" onclick="getInfo('${recruit.recruitFlow}','${recruit.doctorFlow}');">审核</a></td>
	            </tr>
            </c:forEach>
            <c:if test="${empty recruitList}">
				<tr>
					<td colspan="10" >无记录！</td>
				</tr>
      	  	</c:if>
        </table>
    </div>
	<div class="page" style="padding-right: 40px;">
		<c:set var="pageView" value="${pdfn:getPageView(recruitList)}" scope="request"></c:set>
		<pd:pagination-hbres toPage="toPage"/>	 
	</div>
      
