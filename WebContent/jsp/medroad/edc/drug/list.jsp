<style>
.main_hd h2 {
	border-bottom: 1px solid #e7e7eb
}

.main_bd {
	padding: 30px
}

.tool_item {
	overflow: hidden;
	margin-bottom: 50px
}

.tool_item .extra {
	float: right;
	margin-left: 15px;
	padding: 30px 0
}

.tool_item .cover {
	float: left;
	margin-right: 15px
}

.tool_item .cover .img {
	display: block;
	width: 52px;
	height: 52px
}

.tool_item .info1 {
	overflow: hidden
}

.tool_item .info1 .title1 {
	font-weight: normal;
	font-size: 16px;
	
	
}

.tool_item .info1 .desc1 {
	color: #8d8d8d;
	padding-left: 70px;
}

p:first-letter {
		margin-left: -5em;
}
.sub_title {
	margin-bottom: 35px;
	padding-bottom: 15px;
	border-bottom: 1px solid #e7e7eb;
	font-size: 16px
}
</style>
<script>
$(document).ready(function(){
	$(".icon_msg_mini").on("mouseenter mouseleave",function(){
		$(this).parent().next("div").toggle();
		$(this).parent().next("div").css({"left":$(this).offset().left-245,"top":$(this).offset().top+15});
	});
	
	$(".popover").on("mouseenter mouseleave",function(){
		$(this).toggle();
	});
});
function drugInfo(drugFlow){
	jboxLoad("content","<s:url value='/medroad/drug/info'/>?drugFlow="+drugFlow,true);
}
</script>
<div class="main_hd">
	<h2 class="underline">药物信息</h2>
</div>
<div class="main_bd">
	<div class="tools">
		<c:forEach items="${drugList }" var="drug">
			<div class="tool_item">
				<div class="extra">
					<a href="javascript:drugInfo('${drug.drugFlow }');" target="_blank" class="btn btn_primary">查&#12288;看</a>

				</div>
				<div class="cover">
					<img src="<s:url value='/jsp/medroad/images/drugs.png'/>" alt=""
						class="img">
				</div>
				<div class="info1">
					<h2 class="title1">${drug.drugName }</h2>
					<p class="desc1">规格：${drug.spec
						}&#12288;储存条件：${drug.storageCondition }</p>
					<p class="desc1">用法用量：${drug.recipeUsage }</p>
					<p class="desc1">生产厂家：${drug.manufacturer }
					&#12288;<i class="icon_msg_mini info" style="height: 10px;float: none;"></i></p>
					<div class="popover pos_right" style="display: none;" id="js_table_ask_content">
                        <div class="popover_inner">
                            <div class="popover_content"> 
                              	药品咨询、订单、发货请与厂家联系.
                            </div>
                        </div>
                        <i class="popover_arrow popover_arrow_out">
                        </i>
                        <i class="popover_arrow popover_arrow_in">
                        </i>
                    </div>
				</div>
			</div>
			<p class="sub_title"></p>
		</c:forEach>
		<!-- 
        <p class="sub_title">sub_title</p>
       <div class="tool_item">
            <div class="extra">
                
                <a href="#" target="_blank" class="btn btn_primary">进入</a>
                
            </div>
            <div class="cover">
                <img src="<s:url value='/jsp/medroad/images/drugs.png'/>" alt="" class="img">
            </div>
            <div class="info1" style="text-align: left;">
                <h2 class="title1">sub_title</h2>
                <p class="desc1">sub_title</p>
            </div>
        </div>
         -->
	</div>
</div>

