<jsp:include page="/jsp/cnres/htmlhead-cnres.jsp">
    <jsp:param name="font" value="true"/>
    <jsp:param name="jquery_validation" value="true"/>
</jsp:include>
<link rel="stylesheet" type="text/css" href="<s:url value='/jsp/cnres/css/exam.css'/>?v=${applicationScope.sysCfgMap['sys_version']}"></link>
<script type="text/javascript">
function initRoom(){
	var siteFlow = $('#siteCode').val();
	var initRoomNum = $("#initRoomNum").val();
	var initSeatNum = $("#initSeatNum").val();
	if(siteFlow){
		if($("#initForm").validationEngine("validate")){
			jboxConfirm("确认考场设置？" , function(){
				var url = "<s:url value='/cnres/singup/exam/initroom'/>";
				jboxStartLoading();
				jboxPost(url,{"siteFlow":siteFlow , "roomNum":initRoomNum , "seatNum":initSeatNum} , function(resp){
					jboxEndLoading();
					if(resp=="1"){
						chageExamSite();
					}
				},null,false);
			});
		}
	}
}

function delRoom(roomFlow){
	jboxConfirm("确认删除？" , function(){
		jboxPost("<s:url value='/cnres/singup/exam/delroom'/>" , {"roomFlow":roomFlow} , function(resp){
			if(resp=="1"){
				chageExamSite();
			}else{
				jboxTip(resp);
			}
		} , null , false);
	});
}

</script>
<!-- 考点人数信息开始 -->
<div id="siteInfo" class="search_table"><span class="tip_right"><em>●</em>总人数：<strong>${sumDoctorCountInSite}</strong></span><span class="tip_right"><em>●</em>已分配人数：<strong>${alreadyAllotDoctorCountInSite}</strong></span><span class="tip_right"><em>●</em>待分配人数：<strong>${notAllotDoctorCountInSite}</strong></span></div>
<!-- 考点人数信息结束 -->
<!-- 考点下考场开始 -->
<div id="room" class="search_table">
    <c:if test='${sessionScope.currExam.examStatusId eq examStatusEnumArrange.id}'>
        <c:if test='${rooms.size()==0}'>
            <form id="initForm">
              <div class="news_boxin" style="margin-top:25px;">
                <h4>考场设置</h4>
                <div class="boxin">
                  <div class="ui_tips icon_info">
                                                     请先初始化考场数和座位数
                  </div>
                  <div class="e_seats">
                                                         考场数：<input type="text" id="initRoomNum" placeholder="考场数" class="validate[required,custom[positiveNum],maxSize[2]] input" style="width: 100px;"/> 
                     &nbsp;&nbsp;
                                                       每个考场座位数：<input type="text" id="initSeatNum" placeholder="座位数" class="validate[required,custom[positiveNum],maxSize[2]] input" style="width: 100px;"/> 
                     &nbsp;&nbsp;
                     <input class="btn_green" type="button" onclick="initRoom();" value="设置"/>
                  </div> 
                </div>
              </div>
            </form>
        </c:if>
    </c:if>
    <c:forEach items="${rooms}" var="room" varStatus="st">
        <div class="sch">
		    <div class="sch_top">
			    <div class="sch_img">
			        <c:set value="0" var="sumUserCount"></c:set>
			        <c:forEach var="dict" items="${dictTypeEnumGraduateMajorList}">
			            <c:set value="${sumUserCount+roomSpeUserNumResultMap[room.roomFlow][dict.dictId]}" var="sumUserCount"></c:set>
              	    </c:forEach>
              	    <c:choose>
              	        <c:when test="${room.seatNum==0}">
              	            <img alt="" src="<s:url value='/jsp/cnres/images/empty.png'/>">
              	        </c:when>
              	        <c:when test="${room.seatNum==sumUserCount}">
              	            <img alt="" src="<s:url value='/jsp/cnres/images/full.png'/>">
              	        </c:when>
              	        <c:when test="${room.seatNum>sumUserCount}">
              	            <img alt="" src="<s:url value='/jsp/cnres/images/free.png'/>">
              	        </c:when>
              	    </c:choose>
			    </div>
				<div class="sch_title">
				    <h3 onclick="showRoom('${room.roomFlow}');">考场名称：<span class="roomName">${room.roomCode}</span></h3>
				    <p>座位数：
				        <span class="seatNum">${room.seatNum}</span>
				        <c:if test='${sessionScope.currExam.examStatusId eq examStatusEnumArrange.id}'>
				            &nbsp;&nbsp;<a href="javascript:void(0);" onclick="changeSeatNum(this , 'add' ,'${room.roomFlow}');">+</a>
				            &nbsp;&nbsp;<a href="javascript:void(0);" onclick="changeSeatNum(this , 'sub' , '${room.roomFlow}');">-</a>
				        </c:if>
				    </p>
				</div>
		    </div>
		    <div class="sch_body">
			    <div class="sch_jd"> <img alt="" src="<s:url value='/jsp/cnres/images/exam.png'/>"></div>
			    <div class="sch_info">
			        <c:set var="tmpsum" value="0"/>
			        <c:forEach var="dict" items="${dictTypeEnumGraduateMajorList}">
			            <c:set var="tmpsum" value="${tmpsum+roomSpeUserNumResultMap[room.roomFlow][dict.dictId]}"/>
			            <c:if test='${roomSpeUserNumResultMap[room.roomFlow][dict.dictId] > 0}'>
			                <p>${dict.dictName}:<span name="zhuanyeUserCount" style="padding-left: 5px;">${roomSpeUserNumResultMap[room.roomFlow][dict.dictId]}</span>人</p>
              	        </c:if>
              	    </c:forEach>
              	    <c:if test='${st.count ==rooms.size() and tmpsum==0}'>
              	        <p style="margin-top: 15px;margin-left: 30px;"><a class="btn_red" style="width:60px;display: inline-block;text-align: center;" href="javascript:void(0);" onclick="delRoom('${room.roomFlow}');">删&nbsp;除</a></p>
              	    </c:if>
			    </div>
		    </div>
	    </div>
	</c:forEach>
	<c:if test='${sessionScope.currExam.examStatusId eq examStatusEnumArrange.id}'>
	    <c:if test='${rooms.size()>0}'>
	        <div id="addDiv" class="sch_add" onclick="addRoom();">
	            <a href='javascript:void(0);' class="add_font">添加考场</a>
	        </div>
	    </c:if>
	</c:if>
</div>
<!-- 考点下考场结束 -->
      