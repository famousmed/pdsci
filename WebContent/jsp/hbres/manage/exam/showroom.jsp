<jsp:include page="/jsp/hbres/htmlhead-hbres.jsp">
	<jsp:param name="font" value="true"/>
</jsp:include>
<link rel="stylesheet" type="text/css" href="<s:url value='/jsp/hbres/css/exam.css'/>?v=${applicationScope.sysCfgMap['sys_version']}"></link>
<script type="text/javascript">
$(function(){
	$(".shadeDivWrap").hide();
	$(".roomli").hover(function(){
		$(this).find(".shadeDivWrap").show();
	} , function(){
		$(this).find(".shadeDivWrap").hide();
	});
});
function changeRoom(){
	var doctorCheckBox = $("input[name='doctorFlow']:checked");
	if(doctorCheckBox.length==0){
		jboxTip("请勾选需要更换的学员");
		return;
	}
	jboxOpenContent($('#allRoom'),"更换考场" , 1000 ,550);
}

function submitChangeRoom(roomFlow , oldRoomCode , newRoomCode){
	var doctorCheckBox = $("input[name='doctorFlow']:checked");
	jboxConfirm("从&nbsp;&nbsp;<span style='color:red'>"+oldRoomCode+"</span>&nbsp;&nbsp;考场更换到&nbsp;&nbsp;<span style='color:red;'>"+newRoomCode+"</span>&nbsp;&nbsp;考场, 更换人数为：<span style='color:red;'>"+doctorCheckBox.length+"</span>人    , 确认更换？" , function(){
		var userFlows = {};
		$.each(doctorCheckBox , function(i , n){
			userFlows[i] = $(n).val();
		});
		var reqdata = {
				"roomFlow":roomFlow,
				"userFlows":userFlows
		};
		var url = "<s:url value='/hbres/singup/exam/changeroom'/>";
		jboxPost(url , reqdata , function(resp){
			if(resp=="1"){
				jboxTip("操作成功");
				jboxClose();
				jboxLoad("content",'<s:url value="/hbres/singup/exam/showroom"/>?roomFlow='+$('#roomFlow').val(),true);
			}else{
				jboxTip(resp);
			}
		} , null , false);
	});
}

function getInfo(userFlow){
	jboxOpen("<s:url value='/hbres/singup/manage/userInfo'/>?userFlow="+userFlow+"&isActive=","用户信息",1000,550);
}

function checkedAll(){
	var ck = $("#checkedAll").attr("checked");
	if(ck){
		$("input[name='doctorFlow']").attr("checked" , true);
	}else{
		$("input[name='doctorFlow']").attr("checked" , false);
	}
}
</script>
      <div class="main_hd">
        <h2>考场信息</h2>
      </div>
      <div class="main_bd" id="div_table_0" >
        <div class="bd_tips_1">
          <div class="desc_n">
           <h4>
              <span>考点名称：${site.siteName} </span><span> 考点编号：${site.siteCode}</span>  <span>考场编号：${room.roomCode} </span>  <span>座位数：${room.seatNum} </span> 
              <c:if test='${sessionScope.currExam.examStatusId eq examStatusEnumArrange.id}'><a href="javascript:void(0);" onclick="changeRoom();">更换</a></c:if>
              <a href="javascript:void(0);" onclick="examRoomManage('${room.siteFlow}');">返回</a>
              <input type="hidden" id="roomFlow" value="${room.roomFlow}"/>
           </h4> 
          </div>
        </div>
        <div class="div_table">
          <table border="0" cellpadding="0" cellspacing="0" class="grid">
            <tr>
              <c:if test='${sessionScope.currExam.examStatusId eq examStatusEnumArrange.id}'><th><input type="checkbox" id="checkedAll" onclick="checkedAll();"/></th></c:if>
              <th style="text-align: left; padding-left:40px;">姓名</th>
              <th style="text-align: left;">毕业院校</th>
              <th style="text-align: left;">毕业专业</th>
              <th style="text-align: left;">准考证号</th>
              <th>详细</th>
            </tr>
            <c:forEach items="${examDoctorExts}" var="examDoctorExt">
            <tr>
              <c:if test='${sessionScope.currExam.examStatusId eq examStatusEnumArrange.id}'><td><input name="doctorFlow" type="checkbox" value="${examDoctorExt.doctorFlow}"/></td></c:if>
              <td style="text-align:left; padding-left:40px;">${examDoctorExt.doctor.doctorName}</td>
              <td style="text-align:left;">${examDoctorExt.doctor.graduatedName}</td>
              <td style="text-align:left;">
                  <c:forEach var="dict" items="${dictTypeEnumGraduateMajorList}">
              	      <c:if test='${examDoctorExt.doctor.specialized==dict.dictId}'>${dict.dictName}</c:if>
              	  </c:forEach>
              </td>
              <td style="text-align: left;">${examDoctorExt.ticketNum}</td>
              <td><a class="btn" href="javascript:void(0);" onclick="getInfo('${examDoctorExt.doctorFlow}');">详细</a></td>
            </tr>
            </c:forEach>
          </table>
        </div>
      </div>
      
      <div id="allRoom" style="display: none ;">
      <div class="infoAudit">
          <ul>
              <c:forEach items="${rooms}" var="tmproom">
              <c:if test='${room.roomFlow != tmproom.roomFlow}'>
                  <li class="roomli">
                      <div class="sch">
		                  <div class="sch_top">
			                  <div class="sch_img">
				                  <c:set value="0" var="sumUserCount"></c:set>
							        <c:forEach var="dict" items="${dictTypeEnumGraduateMajorList}">
							            <c:set value="${sumUserCount+roomSpeUserNumResultMap[tmproom.roomFlow][dict.dictId]}" var="sumUserCount"></c:set>
				              	    </c:forEach>
				              	    <c:choose>
				              	        <c:when test="${tmproom.seatNum==0}">
				              	            <img alt="" src="<s:url value='/jsp/hbres/images/empty.png'/>">
				              	        </c:when>
				              	        <c:when test="${tmproom.seatNum>0 and sumUserCount>0 and tmproom.seatNum==sumUserCount}">
				              	            <img alt="" src="<s:url value='/jsp/hbres/images/full.png'/>">
				              	        </c:when>
				              	        <c:when test="${tmproom.seatNum>sumUserCount}">
				              	            <img alt="" src="<s:url value='/jsp/hbres/images/free.png'/>">
				              	        </c:when>
				              	    </c:choose>
			                  </div>
			                  <div class="sch_title">
			                      <h3>考场名称：<span class="roomName">${tmproom.roomCode}</span></h3>
			                      <p>座位数：
			                          <span class="seatNum">${tmproom.seatNum}</span>
			                          &nbsp;&nbsp;<a href="javascript:void(0);" onclick="changeSeatNum(this , 'add' ,'${tmproom.roomFlow}');">+</a>
			                          &nbsp;&nbsp;<a href="javascript:void(0);" onclick="changeSeatNum(this , 'sub' , '${tmproom.roomFlow}');">-</a>
			                      </p>
			                 </div>
		                 </div>
		                 <div class="sch_body">
			                 <div class="sch_jd"><img alt="" src="<s:url value='/jsp/hbres/images/exam.png'/>"></div>
			                 <div class="sch_info">
			                     <c:forEach var="dict" items="${dictTypeEnumGraduateMajorList}">
			                         <p>${dict.dictName}:<span name="zhuanyeUserCount" style="padding-left: 5px;">${roomSpeUserNumResultMap[tmproom.roomFlow][dict.dictId]}</span>人</p>
              	                 </c:forEach>
			                 </div>
		                 </div>
		                 <div class="shadeDivWrap" >             
                             <div class="shadeDiv">        
                                 <p style="color:#ffffff"  onclick="submitChangeRoom('${tmproom.roomFlow}' , '${room.roomCode}' , '${tmproom.roomCode}');"><a href='javascript:void(0);'>确&nbsp;认</a></p>
                             </div>
                         </div>
	                 </div>
                 </li> 
             </c:if>
             </c:forEach>  
         </ul>
     </div>
     </div>
      
      
           
	      
      
      
      
      