<jsp:include page="/jsp/hbres/htmlhead-hbres.jsp">
    <jsp:param name="basic" value="true"/>
	<jsp:param name="jbox" value="true"/>
	<jsp:param name="font" value="true"/>
</jsp:include>
<div class="div_search">
  <input type='hidden' id='recruitFlow' value='${param.recruitFlow}'/>   
  <div style="margin-top:10px;"> 
  <select id='spe' class="select" style="width:215px;">
    <option value=''>请选择</option>
    <c:forEach items="${spes}" var='spe'>
        <option value='${spe.speId}'>${spe.speName}</option>
    </c:forEach>
       </select>
    <a class="btn_green" href='javascript:void(0);' onclick="adjustSpe();">调整专业</a>
    </div>
    <div align="center" class="div_table"> <a class="btn_green" href='javascript:void(0);' onclick="confirm();">学员确认</a>&nbsp;&nbsp;<a class="btn_green" href='javascript:void(0);' onclick="noRecruit();">不录取</a></div>

<script>
    function confirm(){
    	jboxConfirm("确定帮助学员进行确认录取的操作？" , function(){
    		var recruitFlow = $("#recruitFlow").val();
    		if(recruitFlow){
    			jboxPost("<s:url value='/hbres/singup/hospital/hospitalOperDoctorConfirm'/>" , {"recruitFlow":recruitFlow} , function(resp){
    				jboxTip(resp);
    				window.parent.searchDoctor();
    				jboxClose();
    			} , null , false);	
    		}
    		
    	});
    }
    
    function adjustSpe(){
    	var speId = $('#spe').val();
    	if(!speId){
    		jboxTip('请选择专业');
    		return;
    	}
    	jboxConfirm("确定更换专业？" , function(){
    		var recruitFlow = $("#recruitFlow").val();
    		if(recruitFlow){
    			jboxPost("<s:url value='/hbres/singup/hospital/hospitalOperChangeSpe'/>" , {"recruitFlow":recruitFlow , "speId":speId} , function(resp){
    				jboxTip(resp);
    				window.parent.searchDoctor();
    				jboxClose();
    			} , null , false);
    		}
    		
    	});
    }
    
    function noRecruit(){
    	jboxConfirm("确定不录取该学生？" , function(){
    		var recruitFlow = $("#recruitFlow").val();
    		if(recruitFlow){
    			jboxPost("<s:url value='/hbres/singup/hospital/hospitalOperNoRecruit'/>" , {"recruitFlow":recruitFlow} , function(resp){
    				jboxTip(resp);
    				window.parent.searchDoctor();
    				jboxClose();
    			} , null , false);	
    		}
    		
    	});
    }
    
</script>
</div>