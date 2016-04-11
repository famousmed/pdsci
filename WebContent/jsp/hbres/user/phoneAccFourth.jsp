<script>
$(document).ready(function(){
	$("#step3").removeClass("current");
	$("#step3").addClass("done");
	$("#step4").addClass("lasted");
});
</script>
<div class="main_bd">
<div class="div_table">
    <div id="tagContent">
	<div class="tagContent selectTag" id="tagContent0">
		<table border="0" cellspacing="0" cellpadding="0" style="line-height: 35px;font-size: 15px;">
				<tr>
					<td style="text-align: right;width: 50px;">
					<img src="<s:url value='/css/skin/${skinPath}/images/gou.png'/>" style="margin: 0 5px 0 10px;"/>
					</td>
					<td style="text-align: left;font-weight: bold;">恭喜您，手机号&nbsp;<font color="#ff6824">${userPhone }</font>&nbsp;修改成功！</td>
				</tr>
				<tr>
					<td>&nbsp;</td>
					<td style="text-align: left;font-size: 13px;">此手机号可作为登录账户，直接登录系统</td>
				</tr>	
			</table>
		</div>
		</div>
	</div>
        </div>
