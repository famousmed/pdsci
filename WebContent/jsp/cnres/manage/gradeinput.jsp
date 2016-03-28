<jsp:include page="/jsp/cnres/htmlhead-cnres.jsp">
	<jsp:param name="font" value="true"/>
	<jsp:param name="jquery_validation" value="true"/>
</jsp:include>
<script type="text/javascript">
function openImport(){
	var width = (window.screen.width)*0.5; 
	var height = (window.screen.height)*0.2;
	if($('#examFlow').val()){
		var url = "<s:url value='/cnres/grade/openImport'/>?examFlow="+$('#examFlow').val();
		jboxOpen(url, "成绩导入", width, height);
	}else{
		jboxTip('请先选择考试');
	}
	
}

function downloadTemplate(){
	var downUrl = "<s:url value='/jsp/cnres/print/examResult.xlsx'/>";
	window.location.href = downUrl;
}

function search(){
	if($('#examFlow').val()){
		gradeInput('');
	}else{
		jboxTip('请先选择考试');
	}
}
</script>

<div class="main_hd">
    <h2 class="underline">成绩录入
    <span style="float:right; margin-right:40px; *margin-top:-76px;">
	    <a href="javascript:downloadTemplate()" style="font-size: 14px;">成绩导入模板</a>
	    <input type="button" value="成绩导入" class="btn_green" onclick="openImport();">
	</span>
	</h2> 
</div>
<div id="search" class="div_search">
<form id="examResultForm">
    <span>考试：</span>
    <select class="select" style="width: 150px;" id="examFlow" name="examFlow" onchange="gradeInput('');">
	    <option value="">请选择</option>
	    <c:forEach items="${exams}" var="exam">
		    <option value="${exam.examFlow}" <c:if test='${param.examFlow eq exam.examFlow}'>selected="selected"</c:if>>${exam.examName}</option>
		</c:forEach>  
    </select>&nbsp;&nbsp;
    <span>考点：</span>
    <select class="select" style="width: 150px;" id="siteFlow" name="siteFlow" onchange="gradeInput('');">
        <option value="">请选择</option>
        <c:forEach items="${sites}" var="site">
            <option value="${site.recordFlow}" <c:if test='${param.siteFlow eq site.recordFlow}'>selected="selected"</c:if>>${site.siteName}</option>
        </c:forEach>
    </select>&nbsp;&nbsp;
    <span>考场：</span>
    <select class="select" style="width: 150px;" id="roomFlow" name="roomFlow" onchange="gradeInput('');">
        <option value="">请选择</option>
        <c:forEach items="${rooms}" var="room">
            <option value="${room.roomFlow}" <c:if test='${param.roomFlow eq room.roomFlow}'>selected="selected"</c:if>>${room.roomCode}</option>
        </c:forEach>
    </select>&nbsp;&nbsp;
    <span>准考证号：</span>
    <input type="text" class="input" style="width: 150px;" id="ticketNum" name="ticketNum" onblur="search();"/>&nbsp;&nbsp;
    <!-- 
	<span>姓名：</span>
	<input type="text" name="doctor.doctorName" value="${searchForm.doctor.doctorName}" onchange="gradeInput();" class="inp" style="width: 100px;"/>&nbsp;&nbsp;
    <span>毕业院校：</span>
	<select class="inp" id="graduatedId" name="doctor.graduatedId" onchange="gradeInput();" style="width: 150px;">
	    <option value="">请选择</option>
		<c:forEach var="dict" items="${dictTypeEnumGraduateSchoolList}">
		    <option value="${dict.dictId}" <c:if test='${dict.dictId == searchForm.doctor.graduatedId}'>selected="selected"</c:if>>${dict.dictName}</option>
		</c:forEach>
		<option value="00" <c:if test="${'00' == searchForm.doctor.graduatedId}">selected="selected"</c:if>>其它</option>
    </select>&nbsp;&nbsp; -->
</form>
</div>
<div id='gradelist'>
    <jsp:include page="./gradelist.jsp"></jsp:include>
</div>
      
