<jsp:include page="/jsp/cnres/htmlhead-cnres.jsp">
	<jsp:param name="font" value="true"/>
</jsp:include>
<script type="text/javascript">
	$(document).ready(function(){
		$("li").click(function(){
			$(".tab_select").addClass("tab");
			$(".tab_select").removeClass("tab_select");
			$(this).removeClass("tab");
			$(this).addClass("tab_select");
		});
		if ("${param.liId}" != "") {
			$("#${param.liId}").addClass("tab_select");
		} else {
			$('li').first().addClass("tab_select");
		}
		$(".tab_select").click();
	});
	
	function retest(){
		jboxLoad("div_table_0","<s:url value='/cnres/singup/hospital/retest'/>",true);
	}
	
	function gradeInput(currentPage){
		if(!currentPage){
			currentPage = 1; 
		}
		var url = "<s:url value='/cnres/singup/hospital/gradeinput'/>?currentPage="+currentPage;
		jboxPostLoad("div_table_0", url, $("#gradeInputForm").serialize(), true);
	}
	
	function recruitNotice(){
		jboxLoad("div_table_0","<s:url value='/cnres/singup/hospital/recruitNotice'/>",true);
	}
	function recruitResultList(){
		jboxLoad("div_table_0","<s:url value='/cnres/singup/hospital/recruitResultList'/>",true);
	}
</script>
<div class="main_hd">
	<h2>招录管理</h2>
   <div class="title_tab" id="toptab">
    <ul>
      <li class="tab" id="fstz" onclick="retest();"><a href="javascript:void(0);">复试通知</a></li>
      <li class="tab" onclick="gradeInput();"><a href="javascript:void(0);">成绩录入</a></li>
      <li class="tab" id="ylqtz" onclick="recruitNotice();"><a href="javascript:void(0);">预录取通知</a></li>
      <li class="tab" id="lqjg" onclick="recruitResultList();"><a href="javascript:void(0);">录取结果</a></li>
    </ul>
  </div>
</div>
      <div class="main_bd" id="div_table_0" >
      </div>
      
