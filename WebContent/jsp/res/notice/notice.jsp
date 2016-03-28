<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@include file="/jsp/common/doctype.jsp"%>
<html>
<head>
<jsp:include page="/jsp/common/htmlhead.jsp">
	<jsp:param name="basic" value="true" />
	<jsp:param name="jbox" value="true" />
	<jsp:param name="jquery_form" value="false" />
	<jsp:param name="jquery_ui_tooltip" value="true" />
	<jsp:param name="jquery_ui_combobox" value="false" />
	<jsp:param name="jquery_ui_sortable" value="false" />
	<jsp:param name="jquery_cxselect" value="true" />
	<jsp:param name="jquery_scrollTo" value="false" />
	<jsp:param name="jquery_jcallout" value="false" />
	<jsp:param name="jquery_validation" value="true" />
	<jsp:param name="jquery_datePicker" value="true" />
	<jsp:param name="jquery_fullcalendar" value="false" />
	<jsp:param name="jquery_fngantt" value="false" />
	<jsp:param name="jquery_fixedtableheader" value="true" />
	<jsp:param name="jquery_placeholder" value="true" />
	<jsp:param name="jquery_iealert" value="false" />
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
		                    'link', 'insertimage', 'attachment' ,  'preview', 'wordimage']
		            ]
		});//实例化编辑器
		init();
	});
	
	function init(){
		$(".operDiv").on("mouseenter mouseleave",function(){
			$(this).find("span").toggle();
		});
	}
	
	function saveNotice(){
		if($("#title").val().length==0){
			jboxTip("公告标题不能为空!");
			return;
		}
		if($("#title").val().length>50){
			jboxTip("公告标题不能大于50个字符或汉字!");
			return;
		}
		if($("#columnId").val().length==0){
			jboxTip("公告类型不能为空!");
			return;
		}
		jboxStartLoading();
		var title = $.trim($("#title").val());
		var infoFlow = $("#infoFlow").val();
		var content = UE.getEditor('ueditor').getContent();
		var columnId = $("#columnId").val();
		var requestData ={
				"infoFlow":infoFlow,
				"infoTitle":title,
				"infoContent":content,
				"columnId":columnId
		}
		var url = "<s:url value='/res/platform/saveNotice/${roleFlag}'/>";
		jboxPost(url,requestData,function(resp){
			if(resp=='${GlobalConstant.OPRE_SUCCESSED}'){
				jboxEndLoading();
				goNoticeByPage();
			}
		},null,true);
	}
	function toPage(page) {
		if(!page){
			$("#currentPage").val(page);			
		}
		location.href="<s:url value='/res/platform/notice/${roleFlag}'/>?currentPage="+page;
	} 
	function goNoticeByPage(){
		toPage("${param.currentPage}");
	}
	function edit(infoFlow){
		var url = "<s:url value='/res/platform/findNoticeByFlow'/>?infoFlow="+infoFlow;
		jboxGet(url , null , function(resp){
			if(resp){
				if($("#editForm").is(":hidden")){
					editFormHidden();
				}
				$("#infoFlow").val(resp.infoFlow);
				$("#title").val(resp.infoTitle);
				UE.getEditor('ueditor').setContent(resp.infoContent);
				$("[value='"+resp.columnId+"']").attr("selected","selected");
				$("#bodyDiv").animate({scrollTop:"0px"},500);
			}
		} , null , false);
	}
	function delNotice(infoFlow){
		jboxConfirm("确认删除？" , function(){
			var url = "<s:url value='/res/platform/delNotice'/>?infoFlow="+infoFlow;
			jboxGet(url , null , function(resp){
				notice();
			} , null , true);
		});
	}
	function editFormHidden(){
		$("#editForm,#operImg img").toggle();
	}
</script>

</head>
<body>
<div id="bodyDiv" style="height: 100%;overflow: auto;">
	<div style="margin-bottom: 20px;">
		<div style="margin-top: 5px;padding-left: 15px;padding-right: 15px;">
			<table width="100%" class="basic">
				<tr>
					<th style="text-align: left;padding-left:10px;">
						新增通知
						<span id="operImg" style="float: right;cursor: pointer;" onclick="editFormHidden();">
							<img title="收缩" src="<s:url value='/jsp/hbres/images/up.png'/>"/>
							<img title="展开" src="<s:url value='/jsp/hbres/images/down.png'/>" style="display: none;"/>
						</span>
					</th>
				</tr>
			</table>
			<form id="editForm" method="post">
				<input type="hidden" id="infoFlow" name="infoFlow" value=""/>
				<input type="hidden" id="orgFlow" name="orgFlow"/>
				<input type="hidden" id="orgName" name="orgName"/>
				<div style="height: 33px;margin-top: 5px;">
					<table style="width: 100%;">
						<tr>
							<td width="5%"><span style="color: red;">*</span>标题：</td>
							<td width="70%"><input id="title" name="title" class="" style="height: 22px;width:98%;"/></td>
							<td width="7%"><span style="color: red;">*</span>公告类型：</td>
							<td width="13%">
								<select id="columnId" name="columnId" style="height: 22px;width: 98%;" class="">
									<option></option>
									<c:forEach items="${dictTypeEnumInfoColumnList}" var="dict">
										<option value="${dict.dictId}">${dict.dictName}</option>
									</c:forEach>
								</select>
							</td>
							<td width="5%"><input type="button" id="saveBtn" value="发&#12288;布" onclick="saveNotice();" class="search"/></td>
						</tr>
					</table>
				</div>
				<script id="ueditor" name="content" type="text/plain" style="height:250px;"></script>
			</form>
		</div>
		<div id="noticeList" class="index_form" style="margin-top:10px;padding-left: 15px;padding-right: 15px; ">
			<table width="100%" class="basic">
				<tr>
					<th style="padding-left: 10px;text-align: left;">科教通知</th>
				</tr>
				<c:forEach items="${infos}" var="msg">
		            <tr  class="operDiv">
		            	<td style="padding-right: 10px;">
		            		<div style="float: left;">
		            			<a href="<s:url value='/res/platform/noticeView'/>?infoFlow=${msg.infoFlow}" target="_blank">${msg.infoTitle}</a>
		            			<c:if test="${pdfn:signDaysBetweenTowDate(pdfn:getCurrDate(),pdfn:transDate(msg.infoTime))<=7}">
							     	 <img src="<s:url value='/jsp/hbres/images/new.png'/>"/>
							     </c:if>
		            		</div>
		            		<div style="float: right;">
		            			<span>${pdfn:transDate(msg.infoTime)}</span>
		            			<span style="display:none;">
		            				<a href="javascript:edit('${msg.infoFlow}');" style="color: gray;">编辑</a> |
									<a href="<s:url value='/res/platform/noticeView'/>?infoFlow=${msg.infoFlow}" target="_blank" style="color: gray;">查看</a> |
									<a href="javascript:delNotice('${msg.infoFlow}');" style="color: gray;">删除</a>
		            			</span>
		            		</div>
		                </td>
		             </tr>
		         </c:forEach>
		         <c:if test="${empty infos}">
				     <tr>
				     	<td style="text-align: center;"><strong>无记录!</strong></td>
					 </tr>
				 </c:if>
			</table>
		     <div class="page" style="padding-right: 40px;">
		         <input id="currentPage" type="hidden" name="currentPage" value=""/>
		         <c:set var="pageView" value="${pdfn:getPageView(infos)}" scope="request"></c:set>
			  	 <pd:pagination toPage="toPage"/>	 
		     </div>
		</div>
	</div>
</div>
</body>
</html>
