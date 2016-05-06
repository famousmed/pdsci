<link rel="stylesheet" type="text/css" href="<s:url value='/jsp/medroad/css/viewer.css'/>?v=${applicationScope.sysCfgMap['sys_version']}"></link>
<script type="text/javascript" src="<s:url value='/jsp/medroad/js/viewer.js'/>?v=${applicationScope.sysCfgMap['sys_version']}"></script>
<script type="text/javascript" src="<s:url value='/js/ajaxfileupload.js'/>?v=${applicationScope.sysCfgMap['sys_version']}"></script>
<script type="text/javascript">
var options = {
        inline: true,
        url: 'data-original',
 };
var $images = $('.docs-pictures');



var imgdefereds=[];
$('img').each(function(){
	 var dfd=$.Deferred();
	 $(this).bind('load',function(){
	  	dfd.resolve();
	 }).bind('error',function(){
		 //图片加载错误，加入错误处理
		 // dfd.resolve();
	 })
	 if(this.complete) setTimeout(function(){
	 	 dfd.resolve();
	 },1000);
	 imgdefereds.push(dfd);
});
$.when.apply(null,imgdefereds).done(function(){
	var height = Math.max($(".docs-galley").height(),window.innerHeight);
	$(".docs-galley").css("height",height-80+"px");
});



function slideClose(){
	//$(".content_side").show();
	$("#crfPic").rightSlideClose();
}

function viewImg(index){
	$images.viewer(options).viewer("view",index);
}
function destroy(){
	$images.viewer("destroy");
}
function doresize(){
	alert($(".docs-galley").height());
}
function editNote(imageFlow){
	$("#"+imageFlow+"_label").hide();
	$("#"+imageFlow+"_label").next(".edit_gray").hide();
	$("#"+imageFlow+"_note").show();
}
function saveNote(imageFlow){
	var data = {
			imgFlow:imageFlow,
			note: $("#"+imageFlow+"_note").val()
	}
	jboxPost("<s:url value='/medroad/savePhotoNote'/>",data,function(resp){
		if(resp=='${GlobalConstant.SAVE_SUCCESSED}'){
			$("#"+imageFlow+"_label").show();
			$("#"+imageFlow+"_label").html(data.note);
			$("#"+imageFlow+"_label").next(".edit_gray").show();
			$("#"+imageFlow+"_note").hide();
		}
	},null,false);
}
function delImg(imageFlow){
	jboxConfirm("确认删除?",function(){
		jboxGet("<s:url value='/medroad/deletePhoto'/>?imageFlow="+imageFlow,null,function(resp){
			if(resp=='${GlobalConstant.DELETE_SUCCESSED}'){
				$("#"+imageFlow).remove();
			}
		},null,false);
	});
}
function addImg(){
	$.ajaxFileUpload({
		url:"<s:url value='/medroad/addCrfPhoto'/>",
		secureuri:false,
		fileElementId:'imgFile',
		dataType: 'json',
		success: function (data){
			if(data=="${GlobalConstant.UPLOAD_SUCCESSED}"){
				jboxTip('${GlobalConstant.UPLOAD_SUCCESSED}');
				//刷新
				jboxLoad("crfPic","<s:url value='/medroad/crfViewer'/>?visitFlow=${currVisit.visitFlow}");
			}else{
				jboxTip(data);
			}
		},
		error: function (data, status, e){
			jboxTip('${GlobalConstant.UPLOAD_FAIL}');
		},
		complete:function(){
			$("#imgFile").val("");
		}
	});
}
</script>
<style>

.docs-pictures {
    margin: 0;
    padding: 0;
    list-style: none;
}
.docs-pictures li {
    margin: 0 -1px -1px 0;
    border: 1px solid transparent;
    overflow: hidden;
}
.docs-pictures li img {
 
}
.page-header {
    padding-bottom: 9px;
    margin: 10px 0 10px;
    border-bottom: 1px solid #eee;
}
.clearfix:after {
    content: ".";
    display: block;
    height: 0;
    clear: both;
    visibility: hidden;
}
</style>
<div class="container"   style="width: 100%;height: 100%;background-color: white;overflow-y: auto;position: relative;">
    <div class="row">
		 <div class="col-sm-8 col-md-6">
				       <h3 class="page-header">
				        <c:if test="${edcPatientVisit.inputOperStatusId != edcInputStatusEnumSubmit.id}">
				        <i class="icon16_common save_gray " title="保存"  style="cursor: pointer;float: left;margin-left: 20px;" onclick="saveData('${edcInputStatusEnumSave.id}');"></i>
				       </c:if>
				       	&#12288;原始病例图片&#12288;(${currVisit.visitName })
				       	<i class="icon_arrow_default" title="隐藏"  style="cursor: pointer;float: right;margin-right: 20px;" onclick="slideClose();"></i>
				       	<i class="icon14_common add_gray" title="上传病例"  style="cursor: pointer;float: right;margin-right: 20px;" onclick="$('#imgFile').click();"></i>
				       <input type="file" id="imgFile" name="imgFile" style="display: none" onchange="addImg()" />
				      
						&#12288;&#12288;
						<span style="float: right;">
						<!-- 
						<input type="button"  class="btn_green" onclick="destroy();" value="隐&#12288;藏"/>
						<input type="button"  class="btn_green" onclick="resetWin();" value="关&#12288;闭"/> 
						 -->
						</span>
						<!--
						<input type="button"  class="btn_green" onclick="doresize();" value="修&#12288;复"/>
						-->
						
						</h3>
				       <div class="docs-galley clearfix" >
						 <ul class="docs-pictures clearfix">
							<c:forEach items="${dataList }" var="map" varStatus="status">
					            <li id="${map.imageFlow }"><img onclick="viewImg('${status.index}')" alt="${map.note}"  data-original="${map.imageUrl}" src="${map.thumbUrl}" style="cursor: pointer;">
					            <span style="vertical-align: top;display: inline-block;">${map.time }<br/>
					            		备注：<font id="${map.imageFlow}_label">${map.note }</font><i class="icon14_common edit_gray" style="cursor: pointer;" onclick="editNote('${map.imageFlow}');"></i>
					            		<input id="${map.imageFlow}_note" value="${map.note }" type="text" class="input" style="width: 200px;display: none" onblur="saveNote('${map.imageFlow}');"/>
					            		<i class="icon14_common del_gray" style="cursor: pointer;" onclick="delImg('${map.imageFlow}');"></i>
					            		
					            </span>
					            </li>
				         	</c:forEach>
			         	 </ul>
					</div>		
		</div>			
	</div>
</div>
