<jsp:include page="/jsp/sczyres/htmlhead-sczyres.jsp">
	<jsp:param name="ueditor" value="true"/>
</jsp:include>
<script>
$(function(){
	 var uecfg = {
			    autoHeight: false,
			    imagePath: '${sysCfgMap['upload_base_url']}/',
			    imageManagerPath: '${sysCfgMap['upload_base_url']}/',
			    maximumWords:500,
			    elementPathEnabled:false,
			    toolbars:[
			                ['|', 'undo', 'redo', '|','lineheight',
			                    'bold', 'italic', 'underline', 'fontborder', 'forecolor',
			                    'fontfamily', 'fontsize', '|',
			                    'justifyleft', 'justifycenter', 'justifyright', 'justifyjustify', '|', 'touppercase', 'tolowercase', '|',
			                    'insertimage', '|','preview']
			            ]
			};
	        var ue = UE.getEditor('uecontainer' , uecfg);
})
function updateOrg(){
	var orgInfo = UE.getEditor('uecontainer').getContent();
	var url="<s:url value='/sczyres/hosptial/updateInfo'/>";
    jboxPost(url, {"orgInfo":orgInfo},function(resp){
	    if(resp=="1"){
	    	jboxTip("更新成功！");
	    }else{
	    	jboxTip("更新失败！");
	    }
	},null,true);
}
</script>
<div class="main_hd">
	<h2 class="underline">
	    <span>基地简介</span>
    </h2>
</div>
<div style="padding-left: 10px;padding-right: 10px;">
    <script id="uecontainer" name="content" type="text/plain" style="width:100%;height:350px;margin-top: 10px;">
	    ${org.orgInfo}
    </script>
</div>
<div style="text-align: center;padding-top: 10px;padding-bottom: 10px;">
    <span class="btn_green" onclick="updateOrg()">保存</span>
</div>
