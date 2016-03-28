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
	<jsp:param name="jquery_fullcalendar" value="true" />
	<jsp:param name="jquery_fngantt" value="false" />
	<jsp:param name="jquery_fixedtableheader" value="true" />
	<jsp:param name="jquery_placeholder" value="true" />
	<jsp:param name="jquery_iealert" value="false" />
	<jsp:param name="ueditor" value="true"/>
</jsp:include>
<script type="text/javascript">
$(function(){
	$("#detail").slideInit({
		width:800,
		speed:500,
		outClose:true
	});
	//加载
	var logTypeId = "${param.logTypeId}";
	//alert(logTypeId);
	selTag($("#"+logTypeId)[0]);
});
	
	function add(){
		jboxStartLoading();
		jboxGet("<s:url value='/res/teacher/log/add'/>",null,function(resp){
			$("#detail").html(resp);
			$("#detail").rightSlideOpen();
			end();
		},function(){end();},false);
	}
	
	function end(){
		jboxEndLoading();
	}
	
	function selTag(obj){
		$(obj).siblings("li").removeClass("selectTag");
		$(obj).addClass("selectTag");
		var logTypeId = $(obj).attr("id");
		var url = "<s:url value='/res/log/loadLog?fillDate=${param.fillDate}&logTypeId='/>"+logTypeId;
		jboxLoad("tagContent", url, true);
	}
</script>

</head>
<body>
<div class="mainright" align="center" style="height: 100%;background-color: white;">
	<div class="content">
		<div class="title1 clearfix" align="left">
			<div style="float: left;width: 100%">
				<ul id="tags">
				    <li id="Day" onclick="selTag(this);"><a style="cursor: pointer;">日志</a></li>
				    <li id="Week" onclick="selTag(this);"><a style="cursor: pointer;">周记</a></li>
				    <li id="Month" onclick="selTag(this);"><a style="cursor: pointer;">月记</a></li>
				</ul>
				<div id="tagContent">
		        </div>
			</div>
		</div>
	</div>
</div>
<!-- 
<div id="bodyDiv" style="height: 100%;overflow: auto;">
	<div style="margin-bottom: 20px;">
		<div style="float: left;padding-left: 10px;margin-bottom: 20px;"><input type="button" value="新&#12288;增" onclick="add();" class="search"></div>
		<div  class="index_form" style="margin-top:10px;padding-left: 15px;padding-right: 15px; ">
			<table width="100%" class="basic">
				<tr>
					<th class="tit" style="padding-left: 10px;text-align: left;" >周记 &#12288;&#12288;第2周  &#12288;&#12288;2015-05-22 - 2015-05-27
					<span style="float: right;padding-right: 20px;"><a href="javascript:void(0)"><img title="修改" src="<s:url value="/css/skin/${skinPath}/images/shu.gif" />" style="cursor: pointer;" onclick="addFile('fileList')"></img></a>&#12288;<a href="javascript:void(0)"><img title="删除"  style="cursor: pointer;" src="<s:url value='/css/skin/${skinPath}/images/del1.png'/>" onclick="delTr('fileList')"></img></a></span>
					</th>
				</tr>
				<tr class="content1"><td>1、在科主任及上级医师指导下，认真做好各项医疗工作，具有良好的服务意识和服务态度。

2、对所管病员全面负责，参加交接班晨会；做好主治医师查房前的准备，查房时详细汇报病员的病情，提出诊治意见；严格执行上级医师的诊治决定；密切观察病情变化；每日至少上、下午各查房一次并作好病程记录；请其他科室会诊时，应陪同诊视；下班时应遵守交班制度，作好书面交班，危重病人应当面交班或床边交班；严格执行值班制度。

3、认真写好书面文书，在24小时内完成新病人的入院录；写好病程录，一般病人二——三天一次，危重病人随时记录；认真记录主任查房内容及家属谈话记录；每月撰写依次阶段小结，对手术病人要作好术前谈话记录、术前小结和手术记录，手术记录必须在术后及时完成医学全。在。线。提供。 www.med126.com；及时完成出院病人的出院小结，填好病史首页；检查和修改实习医师的病史记录及有关记录，第一年的医师要撰写大病史，不少于10例。

4、向上级医师及时报告所分管的病人诊断、治疗情况及病情变化医学教|育网搜集整理，提出需要转科或出院的意见，遇有疑难病例及时请示上级医师，不得推诿病人甚至贻误病情。</td></tr>
			</table>
		</div>
		<div id="noticeList" class="index_form" style="margin-top:10px;padding-left: 15px;padding-right: 15px; ">
			<table width="100%" class="basic">
				<tr>
					<th class="tit" style="padding-left: 10px;text-align: left;">日记 &#12288;&#12288;&#12288;&#12288;2015-05-18
					<span style="float: right;padding-right: 20px;"><a href="javascript:void(0)"><img title="修改" src="<s:url value="/css/skin/${skinPath}/images/shu.gif" />" style="cursor: pointer;" onclick="addFile('fileList')"></img></a>&#12288;<a href="javascript:void(0)"><img title="删除"  style="cursor: pointer;" src="<s:url value='/css/skin/${skinPath}/images/del1.png'/>" onclick="delTr('fileList')"></img></a></span>
					</th>
				</tr>
				<tr class="content1" style="display: none"><td>1、在科主任及上级医师指导下，认真做好各项医疗工作，具有良好的服务意识和服务态度。

2、对所管病员全面负责，参加交接班晨会；做好主治医师查房前的准备，查房时详细汇报病员的病情，提出诊治意见；严格执行上级医师的诊治决定；密切观察病情变化；每日至少上、下午各查房一次并作好病程记录；请其他科室会诊时，应陪同诊视；下班时应遵守交班制度，作好书面交班，危重病人应当面交班或床边交班；严格执行值班制度。

3、认真写好书面文书，在24小时内完成新病人的入院录；写好病程录，一般病人二——三天一次，危重病人随时记录；认真记录主任查房内容及家属谈话记录；每月撰写依次阶段小结，对手术病人要作好术前谈话记录、术前小结和手术记录，手术记录必须在术后及时完成医学全。在。线。提供。 www.med126.com；及时完成出院病人的出院小结，填好病史首页；检查和修改实习医师的病史记录及有关记录，第一年的医师要撰写大病史，不少于10例。

4、向上级医师及时报告所分管的病人诊断、治疗情况及病情变化医学教|育网搜集整理，提出需要转科或出院的意见，遇有疑难病例及时请示上级医师，不得推诿病人甚至贻误病情。</td></tr>
			</table>
		</div>
	</div>
</div>
 <div id="detail"></div>
 -->
</body>
</html>
