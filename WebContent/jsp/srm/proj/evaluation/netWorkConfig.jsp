<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<script type="text/javascript">
<!--
function chooseExpert(){
	if($('#evalSetFlow').val()){
		var url = "<s:url value='/srm/proj/evaluation/chooseExpert'/>?evalSetFlow="+$('#evalSetFlow').val()+"&projFlow=${proj.projFlow}";
		jboxStartLoading();
		jboxOpen(url , "选择委员会" ,  900 ,600 );
	}else{
		jboxTip("对不起！请先提交评审设置才能添加评审专家，评审设置提交后不能更改，请按实填写！");
	}
	
	
}

function removeExpert(){
	var experts = $('#expertInfoListTb').find("input[name$='userFlow']:checked");
	if(experts.length==0){
		jboxTip('请至少选择一个要删除的委员');
		return;
	}else{
		experts.parent('td').parent('tr').remove();
	}
	 var trs=$("#expertInfoListTb").children().length;
	   if(trs==0){
		   $("#msg").show();
	   }
}

function delExpert(projFlow,userFlow){
	jboxConfirm("确认删除该评审专家?",function(){
		jboxStartLoading();
		jboxGet("<s:url value='/srm/proj/evaluation/delExpert'/>?projFlow="+projFlow+"&userFlow="+userFlow , null, function(){
			window.location.reload(true);
		} , null , true);
	});
}

function sendNotice(type , evalSetFlow , userFlow){
	jboxConfirm("确认发送通知?",function(){
		var url = "<s:url value='/srm/proj/evaluation/sendNotice'/>";
		var data = {"type":type , "evalSetFlow":evalSetFlow , "userFlow":userFlow};
		jboxPost(url , data , function(resp){
			if(resp=="1"){
				top.jboxTip("操作成功");
			}else{
				top.jboxTip(resp);
			}
			window.location.reload();
		} , null , false);
	});
}
	
//-->
</script>
         		 <table class="xllist" id="table_sp">
         		 <thead>
         		 <tr>
         		 	<th colspan="10" style="font-size: 14px;text-align: left;padding-left: 15px;background: #ECF2FA;">评审专家(添加评审专家之前，请保证评审设置已提交)
         		 	<span style="float: right;padding-right: 10px"><a href="javascript:void(0)"><img title="新增评审专家" src="<s:url value="/css/skin/${skinPath}/images/add3.png" />" style="cursor: pointer;" onclick="chooseExpert();"></img></a></span>
         		 	</th>
         		 </tr>
	             <tr>
	                   <th width="80px">姓名</th> 
	                   <th width="80px">性别</th>
	                   <th width="100px">专业</th>
	                   <th width="100px">学历</th>
					   <th width="200px">工作单位</th>
					   <th width="100px">手机</th>
					   <th width="100px">邮箱</th>
					   <th width="60px">短信通知</th>
					   <th width="60px">邮件通知</th>
					   <th width="60px">操作</th>
	               </tr> 
	               </thead>
	               <tbody id="expertInfoListTb">
	               <c:forEach items="${expertInfoList}" var="expertInfo" varStatus="sta">
	               <tr>
	                	<td>${expertInfo.user.userName}</td>
	                	<td>
	                		<c:if test='${expertInfo.user.sexId eq userSexEnumMan.id}'>男</c:if>
	                		<c:if test='${expertInfo.user.sexId eq userSexEnumWoman.id}'>女</c:if>
	                	</td>
	                	<td>${expertInfo.expert.majorName}</td>
	                	<td>${expertInfo.expert.education}</td>
	                	<td>${expertInfo.user.orgName}</td>
	                	<td>
	                		${expertInfo.user.userPhone}
	                	</td>
	                	<td>
	                		${expertInfo.user.userEmail}
	                	</td>
	                	<td>
	                		<input type="hidden" name="srmExpertProjList[${sta.index}].userFlow"    value="${expertInfo.user.userFlow}"/>
	                	    <input type="checkbox" name="srmExpertProjList[${sta.index}].phoneNotifyFlag" value="Y"
	                	    onclick="sendNotice('Phone' , '${groupProj.evalSetFlow}' ,'${expertInfo.user.userFlow}');" 
	                	    <c:if test='${expertProjMap[expertInfo.user.userFlow ].phoneNotifyFlag!="Y"}'></c:if>
	                	    <c:if test='${expertProjMap[expertInfo.user.userFlow ].phoneNotifyFlag=="Y"}'>checked="checked" disabled="disabled"</c:if>>${expert.user.userEmail}	
	                	</td>
	                	<td> 
	                	    <input type="checkbox" name="srmExpertProjList[${sta.index}].emailNotifyFlag"  value="Y"
	                	    onclick="sendNotice('Email' , '${groupProj.evalSetFlow}' ,'${expertInfo.user.userFlow}');" 
	                	    <c:if test='${expertProjMap[expertInfo.user.userFlow ].emailNotifyFlag!="Y"}'></c:if>
	                	    <c:if test='${expertProjMap[expertInfo.user.userFlow ].emailNotifyFlag=="Y"}'>checked="checked" disabled="disabled"</c:if>>${expert.user.userEmail}		
	                	</td>
	                	<td>[<a href="javascript:delExpert('${proj.projFlow }','${expertInfo.user.userFlow }');">删除</a>]</td>
	            	</tr>
	            </c:forEach>
	           
	            </tbody>
        		</table>
