<script type="text/javascript">
function showTestRecord(paperFlow){
	var $div = $("#div_"+paperFlow);
	$div.slideToggle("slow", function(){
		var url = "<s:url value='/resedu/student/loadMyTestHistory'/>?paperFlow="+paperFlow;
		jboxLoad("content_"+paperFlow, url, false);
 	});
}
function startTest(paperFlow){
	 spreadContent();
	 loadTestPaper(paperFlow);
}

function spreadContent(){
	 var mainDiv=$("#mainContent");
	 var rightDiv=$("#rightContent");
	 $(rightDiv).hide();
	 $(mainDiv).removeClass("videoLists-l");
	 $(mainDiv).addClass("videoLists-r");
}

function loadTestPaper(paperFlow){
	
	//var url="http://192.168.2.16:8020/DepartmentalExaminationHandler.ashx?UserName=root&SoluID=1296&RealName=超级管理员";
	var url = "<s:url value='/resedu/student/startTest'/>?paperFlow="+paperFlow;
	jboxLoad("content4", url, false);
	//window.open(url);
}

$(document).ready(function(){
	var divs=$("#module-content").find(".ith");
	if(divs.length>0){
		$.each(divs,function(i,n){
			if(i==0){
				$(n).click();
			}
		});
	}
	
});
</script>

<body>
<!--videoPage-->
   <!--video-l-->
  <div class="video-l fl" style="padding: 0;border-bottom:0;margin-top: 0;" id="examDiv">
    <div class="module-content" id="module-content">
       <c:forEach items="${eduCourseTestPaperExts}" var="eduCourseTestPaperExt">
        <div class="ith" onclick="showTestRecord('${eduCourseTestPaperExt.paperFlow}');">
           <table class="xxzx_exam" style="width: 90%;border: 0;line-height: 30px;">
					<tr>
					    <td width="30%">考卷名称：${eduCourseTestPaperExt.testPaper.paperName }</td>
						<td width="20%">考试时间：${eduCourseTestPaperExt.testPaper.testTime }&nbsp;分钟</td>
						<td width="20%">出题方式：${eduCourseTestPaperExt.testPaper.paperTypeName }</td>
						
							<td width="30%">考试章节：
							<c:forEach items="${eduCourseChapterMap[eduCourseTestPaperExt.testPaper.paperFlow]}" var="chapter" varStatus="num">
								${chapter.chapterName}<c:if test="${num.count!=fn:length(eduCourseChapterMap[eduCourseTestPaperExt.testPaper.paperFlow])}">，</c:if>
							</c:forEach>
							
							</td>
							
					</tr>
					<tr>
						<td>出&nbsp;卷&nbsp;人：${eduCourseTestPaperExt.testPaper.paperUserName }</td>
						<td>总&#12288;&#12288;分：${eduCourseTestPaperExt.testPaper.totleScore }&nbsp;分</td>
						<td>及&nbsp;格&nbsp;分：${eduCourseTestPaperExt.testPaper.passScore }&nbsp;分</td>
						<td style="text-align:left;" >
							
							<c:if test="${(empty examPassMap[eduCourseTestPaperExt.testPaper.paperFlow]) and (not empty chapterFinshMap[eduCourseTestPaperExt.testPaper.paperFlow])}">
								<input type="button" value="开始考试" class="search" onclick="startTest('${eduCourseTestPaperExt.paperFlow }');"/>
							</c:if>
						</td>
					</tr>
					<tbody>
				        <tr>
				          <td colspan="4">
				             <div id="test_1">
				             </div>
				          </td>
				        </tr>
			      </tbody>
				</table>
        </div>
         <div id="div_${eduCourseTestPaperExt.testPaper.paperFlow }" style="display: none;">
				<table cellpadding="0" class="xllist" cellspacing="0" border="0" style="width: 100%; margin-top:0; border-top:0;border-bottom:0;">
					<colgroup>
					    <col width="33%"/>
						<col width="33%"/>
						<col width="33%"/>
					</colgroup>
					<tr style="height: 40px;">
					    <th>考试时间</th>
					    <th>考试成绩</th>
						<th>是否及格</th>
					</tr>
					<tbody>
				        <tr>
				          <td colspan="3" style="border-bottom:0;">
				             <div id="content_${eduCourseTestPaperExt.testPaper.paperFlow }">
				             </div>
				          </td>
				        </tr>
			      </tbody>
				</table>
			</div>
		 </c:forEach> 
		<c:if test="${empty eduCourseTestPaperExts }">
		    <div class="ith">
		      <table class="xxzx_exam" style="width: 90%;border: 0;line-height: 30px;">
		         <tr>
		            <td style="text-align: center;">无记录</td>
		         </tr>
		      </table>
		    </div>
		</c:if>
   </div>
  </div>
