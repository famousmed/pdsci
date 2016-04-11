<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<link rel="stylesheet" type="text/css" href="<s:url value='/jsp/res/log/css/time_style.css'/>" />

<script type="text/javascript">
	function add(){
		var url = "<s:url value='/res/log/edit'/>?logTypeId=${param.logTypeId}";
		var title = "周记";
		if("${param.logTypeId}" == "${logTypeEnumMonth.id}"){
			title = "月记";
		}
		jboxOpen(url, "添加"+title, 700, 500);
	}
	
	function view(logFlow){
		var url = "<s:url value='/res/log/getLog?logFlow='/>" + logFlow;
		window.location.href = url;
	}
	
	function toPage(page){
		var url = "<s:url value='/res/log/loadLog?&logTypeId=${param.logTypeId}&currentPage='/>" + page;
		jboxLoad("tagContent", url, true);
	}
	/* $(document).ready(function(){
		alert("${param.logTypeId}");
	}); */
	
	function delLog(logFlow){
		jboxConfirm("确认删除?" ,  function(){
			jboxStartLoading();
			var url = "<s:url value='/res/log/delLog?logFlow='/>" + logFlow;
			jboxPost(url , null , function(resp){
					if("${GlobalConstant.DELETE_SUCCESSED}" == resp){
						var url = "<s:url value='/res/log/list'/>?logTypeId=${param.logTypeId}";
						window.location.href = url;
					}
				} , null , true);
		});
	}
</script>
<div class="mainright" align="center" style="height: 100%;background-color: white;">
<div class="content">
<div class="title1 clearfix" align="left">
	<input type="button" class="search" value="新&#12288;增" onclick="add()"/>

	<c:forEach items="${workLogList}" var="workLog" varStatus="status">
    <li class="log_item">
    	<div class="timeline_date fl">
        	<p class="week">
        		<c:if test="${param.logTypeId eq logTypeEnumWeek.id}">
        			第${workLog.weekNum}周
        		</c:if>
        		<c:if test="${param.logTypeId eq logTypeEnumMonth.id}">
        			${workLog.fillDate}
        		</c:if>
        	</p>
        	<%-- <c:if test="${param.logTypeId eq logTypeEnumWeek.id}">
	            <p class="day">${workLog.fillDate} ~ ${workLog.endDate}</p>
       		</c:if> --%>
        </div>
        <div class="log_content fl">
        	<a class="arrow01">●</a>
        	<div class="timeline_title">
        		填写日期：${pdfn:transDate(workLog.createTime)}
            	<!-- <a>工作日志</a>
                <span>0</span> -->
                <a class="more_all fr" href="javascript:void(0)" onclick="view('${workLog.logFlow}')">查看全部&gt;</a>
            </div>
            <div class="content_area01">
            	<%-- <c:if test="${empty workLog.logContent}">
	            	<h4>keep:本周完成了哪些工作</h4>
            	</c:if> --%>
                <ul>
                	<li>
                	   <span style="display:block;">
                		<c:if test="${param.logTypeId eq logTypeEnumWeek.id}">
		        			${workLog.fillDate} ~ ${workLog.endDate}&#12288;周记
		        		</c:if>
		        		<c:if test="${param.logTypeId eq logTypeEnumMonth.id}">
		        			${workLog.fillDate}&#12288;月记
		        		</c:if>
		        		</span>
		        		<div class="fr" style="margin-bottom:5px;"> 
		    			<a class="datework_cz" href="javascript:void(0);" onclick="delLog('${workLog.logFlow}')" style="font-size: 13px; ">删除</a>
		    			</div>
                	</li>
                </ul>
            </div>
        </div>
    </li>
	</c:forEach>
	
	<c:if test="${empty workLogList}">
	<li class="log_item">
        	<h1>无记录！</h1>
    </li>
	</c:if>
	
	<p>
    	<input type="hidden" id="currentPage" name="currentPage">
       	<c:set var="pageView" value="${pdfn:getPageView2(workLogList , 10)}" scope="request"></c:set>
		<pd:pagination-inx toPage="toPage"/>
	</p>
	

</div>
</div>
</div>