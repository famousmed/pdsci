<jsp:include page="/jsp/jszy/htmlhead-jszy.jsp">
	<jsp:param name="font" value="true"/>
	<jsp:param name="jquery_validation" value="true"/>
	<jsp:param name="ueditor" value="true"/>
</jsp:include>
<script type="text/javascript">

$(document).ready(function(){
	var ue = UE.getEditor('ueditor', {
	    autoHeight: false,
	    imagePath: '${sysCfgMap['upload_base_url']}/',
	    imageManagerPath: '${sysCfgMap['upload_base_url']}/',
	    filePath: '${sysCfgMap['upload_base_url']}/',
	    videoPath: '${sysCfgMap['upload_base_url']}/',
	    wordImagePath: '${sysCfgMap['upload_base_url']}/',
	    snapscreenPath: '${sysCfgMap['upload_base_url']}/',
	    catcherPath: '${sysCfgMap['upload_base_url']}/',
	    scrawlPath: '${sysCfgMap['upload_base_url']}/',
	    elementPathEnabled : false,
	    autoFloatEnabled:false,
	    toolbars:[
	                ['|', 'undo', 'redo', '|','lineheight',
	                    'bold', 'italic', 'underline', 'fontborder', 'fontfamily', 'fontsize', '|',
	                    'justifyleft', 'justifycenter', 'justifyright', 'justifyjustify', '|', 'touppercase', 'tolowercase', '|',
	                    'insertimage', 'attachment' ,  'preview', 'wordimage']
	            ]
	});//实例化编辑器
	init();
});

function init(){
	$(".docDiv").hover(function() {
		$(this).find("span[class='showSpan']").hide();
		$(this).find("span[class='editSpan']").show();
	},function(){
		$(this).find("span[class='editSpan']").hide();
		$(this).find("span[class='showSpan']").show();
	});
}

function saveNotice(){
	if($("#editForm").validationEngine("validate")){
		jboxStartLoading();
		var title = $.trim($("#title").val());
		var infoFlow = $("#infoFlow").val();
		var content = UE.getEditor('ueditor').getContent();
		var requestData ={
				"infoFlow":infoFlow,
				"title":title,
				"content":content
		}
		var url = "<s:url value='/hbres/notice/save'/>";
		jboxPost(url,requestData,function(resp){
			if(resp=='${GlobalConstant.OPRE_SUCCESSED}'){
				notice();
				jboxClose();
				jboxEndLoading();
			}
		},null,true);
	}
}
function toPage(page) {
	if(page!=undefined){
		$("#currentPage").val(page);			
	}
	notice($("#currentPage").val());
} 
function edit(infoFlow){
	var url = "<s:url value='/hbres/notice/findnoticebyflow'/>?infoFlow="+infoFlow;
	jboxGet(url , null , function(resp){
		if(resp){
			editFormHidden(false);
			$("#infoFlow").val(resp.infoFlow);
			$("#title").val(resp.infoTitle);
			UE.getEditor('ueditor').setContent(resp.infoContent);
		}
	} , null , false);
}
function delNotice(infoFlow){
	jboxConfirm("确认删除？" , function(){
		var url = "<s:url value='/hbres/notice/delnotice'/>?infoFlow="+infoFlow;
		jboxGet(url , null , function(resp){
			notice();
		} , null , true);
	});
	
	
}
function editFormHidden(isHidden){
	if(isHidden){
		$("#editForm").hide();
		$("#down").show();
		$("#up").hide();
	}else{
		$("#editForm").show();
		$("#up").show();
		$("#down").hide();
	}
	
}
</script>

<div id="noticeEditor" class="index_form" style="margin-top: 5px;padding-left: 15px;padding-right: 15px;">
<h3>公告编辑
    <span style="float: right;margin-top: 10px;">
    <a title="收缩" id="up" onclick="editFormHidden(true);">
        <img src="<s:url value='/jsp/hbres/images/up.png'/>"/>
    </a>
    <a title="展开" id="down" onclick="editFormHidden(false);" style="display: none">
        <img src="<s:url value='/jsp/hbres/images/down.png'/>"/></a>
    </span>
</h3>
<form id="editForm" method="post">
<input type="hidden" id="infoFlow" name="infoFlow" value=""/>
<div style="height: 33px;margin-top: 5px;"><strong>标题：</strong><input id="title" name="title" class="validate[required,maxSize[50]] input" style="width: 84%;height: 22px;"/>&nbsp;&nbsp;&nbsp;<span style="color: red;">*</span>&nbsp;&nbsp;&nbsp;<input type="button" id="saveBtn" value="发布" onclick="saveNotice();" class="btn"/></div>
<script id="ueditor" name="content" type="text/plain" style="height:250px;"></script>
</form>
</div>
<div id="noticeList" class="index_form" style="margin-top:10px;padding-left: 15px;padding-right: 15px; ">
    <h3>系统公告</h3>
    <ul class="form_main">
        <c:forEach items="${infos}" var="msg">
            <li class="docDiv">
                <a>
                    <strong>
                        <a href="<s:url value='/inx/jszy/noticeView'/>?infoFlow=${msg.infoFlow}" target="_blank">${msg.infoTitle}</a>
                        <c:if test="${pdfn:signDaysBetweenTowDate(pdfn:getCurrDate(),pdfn:transDate(msg.infoTime))<=7}">
				     	    <i class="new1"></i>
				        </c:if>
				     </strong>
                    <span class="showSpan">${pdfn:transDate(msg.infoTime)}</span>
					<span class="editSpan" style="display:none;">
						<a href="javascript:edit('${msg.infoFlow}');" class="bl">编辑</a> |
						<a href="<s:url value='/inx/jszy/noticeView'/>?infoFlow=${msg.infoFlow}" target="_blank" class="bl">查看</a> |
						<a href="javascript:delNotice('${msg.infoFlow}');" class="bl">删除</a>
					</span>
                </a>
             </li>
         </c:forEach>
         <c:if test="${empty infos}">
		     <li>
			    <strong>无记录!</strong>
			 </li>
		 </c:if>
     </ul>
     <div class="page" style="padding-right: 40px;">
         <input id="currentPage" type="hidden" name="currentPage" value=""/>
         <c:set var="pageView" value="${pdfn:getPageView(infos)}" scope="request"></c:set>
	  	 <pd:pagination-hbres toPage="toPage"/>	 
     </div>
</div>
