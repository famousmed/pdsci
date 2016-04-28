<script type="text/javascript">
	function toPage(page) {
		if(page){
			$("#currentPage").val(page);			
		}
		patients('${sessionScope.currUser.orgFlow }',$("#currentPage").val());
	} 
	function getInfo(patientFlow){
		jboxOpen("<s:url value='/medroad/patientInfo'/>?patientFlow="+patientFlow,"受试者信息",1000,550);
	}
	$(document).ready(function(){
		$("li").click(function(){
			$(".tab_select").addClass("tab");
			$(".tab_select").removeClass("tab_select");
			$(this).removeClass("tab");
			$(this).addClass("tab_select");
		});
		$("li:first").click();
	});
	function datainput(visitFlow,operUserFlow){
		jboxLoad("div_table_0","<s:url value='/medroad/datainput'/>?visitFlow="+visitFlow+"&operUserFlow="+operUserFlow,true);
	}
	function searchPatient(patientCode){
		/*
		var patientCode = {
				"patientCode" : $("#patientCode").val()
		};
		jboxPostLoad("content","<s:url value='/medroad/visit'/>",patientCode,true);
		*/
	}
	function recipe(){
		jboxLoad("div_table_0","<s:url value='/medroad/recipe/list'/>",true);	
	}
	function recipeDrug(){
		jboxLoad("div_table_0","<s:url value='/medroad/recipe/drug'/>",true);	
	}
</script>
<style>

</style>
<div class="main_hd">
	<h2>受试者访视</h2>
	<div class="title_tab" id="toptab">
		<ul>
			<li  class="tab_select " onclick="recipe();"><a>就诊记录</a></li>
			<li  class="tab" onclick="recipeDrug();"><a>用药记录</a></li>
			<li  class="tab "  onclick="datainput('${currVisit.visitFlow}','');"><a>病例录入</a></li>
		</ul>
	</div>
	<div class="extra_info search_bar" id="searchBar"><span class="frm_input_box search with_del append ">
	    <a class="del_btn jsSearchInputClose" href="javascript:" style="display:none">
	        <i class="icon_search_del"></i>&nbsp;
	    </a>
	    <a href="javascript:searchPatient();" class="frm_input_append jsSearchInputBt">
	    	<i class="icon16_common search_gray">搜索</i>&nbsp;
	    </a>
	    <input type="text" class="frm_input jsSearchInput" id="patientCode" readonly="readonly" value="${currPatient.patientName }(${pdfn:encryptIdNo(currPatient.patientCode,4)})" placeholder="受试者编号/姓名">
		</span>
	</div>
</div>
<div class="main_bd " id="div_table_0" >
	
   
</div>
      
