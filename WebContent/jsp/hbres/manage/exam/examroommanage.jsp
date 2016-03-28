<jsp:include page="/jsp/hbres/htmlhead-hbres.jsp">
	<jsp:param name="font" value="true"/>
</jsp:include>
<link rel="stylesheet" type="text/css" href="<s:url value='/jsp/hbres/css/exam.css'/>?v=${applicationScope.sysCfgMap['sys_version']}"></link>
<script type="text/javascript">
$(function(){
	chageExamSite();
});
function chageExamSite(){
	var recordFlow = $('#siteCode').val();
	if(recordFlow){
		var url = "<s:url value='/hbres/singup/exam/getexamsite2'/>?recordFlow="+recordFlow;
		jboxStartLoading();
		jboxGet(url , null , function(resp){
			jboxEndLoading();
			$('#siteContent').html(resp);
		},null , false);
	}else{
		$('#siteContent').html("");
	}
	
}

function addRoom(){
	jboxConfirm("确认添加考场？", function(){
		var siteFlow = $('#siteCode').val();
		var num = $("#room .sch").length+1;
		num = countRoomNum(num);
		var url = "<s:url value='/hbres/singup/exam/addroom'/>";
		var reqdata = {"siteFlow":siteFlow,"roomCode":num};
		jboxPost(url,reqdata , function(resp){
			if(resp=="1"){
				chageExamSite();
			}
		},null,false);
	});
	
}

function changeSeatNum(obj , opt , roomFlow){
	var $seatNumSpan = $(obj).siblings(".seatNum");
	var seatNum = $seatNumSpan.html();
	if(!seatNum){
		seatNum = 0;
	}
	seatNum = parseInt(seatNum);
	if(opt=="add"){
		seatNum = seatNum+1;
		if(seatNum>99){
			jboxTip("座位数不能大于99");
			return;
		}
	}else if(opt="sub"){
		if(seatNum>1){
			seatNum--;
		}else{
			jboxTip("座位数不能小于1");
			return;
		}
		
	}
	var url = "<s:url value='/hbres/singup/exam/updateseatnum'/>";
	jboxPost(url , {"roomFlow":roomFlow,"seatNum":seatNum},function(resp){
		if(resp=="1"){
			$seatNumSpan.html(seatNum);		
			changeSchimg(obj , seatNum);
		}else{
			jboxTip(resp);
		}
	},null,false);
	
}

function changeSchimg(obj , seatNum){
	var room = $(obj).parents(".sch");
	var zhuanye = room.find('.sch_body .sch_info').find("span[name='zhuanyeUserCount']");
	var sumUserCountInRoom = 0;
	var imgsrc = "";
	$.each(zhuanye , function(i , n){
		sumUserCountInRoom+=parseInt($(n).text());
	});
	if(seatNum==0){
		imgsrc = "<s:url value='/jsp/hbres/images/empty.png'/>";
	}else if(seatNum==sumUserCountInRoom){
		imgsrc = "<s:url value='/jsp/hbres/images/full.png'/>";
	}else if(seatNum>sumUserCountInRoom){
		imgsrc = "<s:url value='/jsp/hbres/images/free.png'/>";
	}
	room.find(".sch_img img").attr('src' , imgsrc);
	
}

function countRoomNum(num){
	if(num<10){
		return "0"+num;
	}else{
		return num;
	}
}

function showRoom(roomFlow){
	jboxLoad("content",'<s:url value="/hbres/singup/exam/showroom"/>?roomFlow='+roomFlow,true);
}

function smartAllotTicketnum(){
	jboxConfirm("确认分配？" , function(){
		var siteFlow = $('#siteCode').val();
		if(siteFlow){
			var url = "<s:url value='/hbres/singup/exam/smartallotticketnum'/>";
			jboxStartLoading();
			jboxPost(url , {"siteFlow":siteFlow} , function(resp){
				jboxEndLoading();
				if(resp=="1"){
					jboxTip("操作成功");
					chageExamSite();
				}else{
					jboxTip(resp);
				}
			} , null , false);
		}else{
			jboxTip("请选择考点");
		}
	});
}
</script>
<div class="main_hd">
    <h2>考试管理
    <span class="tips">当前考试：${sessionScope.currExam.examName}</span>
    </h2>
    <jsp:include page="./nvtab.jsp">
        <jsp:param value="3" name="tabIndex"/>
    </jsp:include>
</div>
<div class="main_bd" id="div_table_0" >
    <div class="div_search">
        <div style="display:inline-block;*float:left;">
	        <span>考点：</span>
	        <select name="siteCode" id="siteCode" style="padding-left:5px; border:1px solid #d6d7d9; height:30px; line-height:30px; width:200px; outline:none;font-family: microsoft yahei;" onchange="chageExamSite();">
	            <!-- <option value=''>请选择</option> -->
	            <c:forEach items="${sites}" var='site'>
	                <option value="${site.recordFlow}" <c:if test='${param.siteFlow eq site.recordFlow}'>selected="selected"</c:if>>${site.siteName}</option>
	            </c:forEach>
	        </select>
	    </div>
	    <c:if test="${sessionScope.currExam.examStatusId eq examStatusEnumArrange.id}">
            &nbsp;&nbsp;<input type="button" value="一键分配准考证号" class="btn_green" onclick="smartAllotTicketnum();"/>
        </c:if>
    </div> 
    <!-- 选择考点后动态加载内容至此 -->
    <div id="siteContent"></div>
</div>
<!-- 添加考场模板开始 -->
<div id="roomTmp" style="display: none;">
    <div class="sch">
	    <div class="sch_top">
		    <div class="sch_img">
			    <img alt="" src="<s:url value='/css/skin/${skinPath}/images/yck.png'/>">
			</div>
			<div class="sch_title">
			    <h3 onclick="showRoom();">考场名称：<span class="roomName"></span></h3>
			    <p>座位数：
			        <span class="seatNum">0</span>
			        &nbsp;&nbsp;<a href="javascript:void(0);" onclick="changeSeatNum(this , 'add');">+</a>
			        &nbsp;&nbsp;<a href="javascript:void(0);" onclick="changeSeatNum(this , 'sub');">-</a>
			    </p>
			</div>
		</div>
		<div class="sch_body">
		    <div class="sch_jd"><img alt="" src="<s:url value='/jsp/hbres/images/exam.png'/>"></div>
			<div class="sch_info">
			    <c:forEach var="dict" items="${dictTypeEnumGraduateMajorList}">
			        <p>${dict.dictName}:<span name="zhuanyeUserCount" style="padding-left: 5px;">0</span>人</p>
              	</c:forEach>
			</div>
		</div>
	</div>
</div>
<!-- 添加考场模板结束-->