<jsp:include page="/jsp/cnres/htmlhead-cnres.jsp">
	<jsp:param name="font" value="true"/>
</jsp:include>
<script type="text/javascript">
function toPage(page) {
	if(page!=undefined){
		$("#currentPage").val(page);			
	}
	search();
} 
function getInfo(userFlow){
	jboxOpen("<s:url value='/cnres/singup/manage/userInfo'/>?userFlow="+userFlow+"&isActive=","用户信息",1000,550);
}
function search(){
	var siteCode = $("#siteCode").val();
	var currentPage = $("#currentPage").val();
	var url = "<s:url value='/cnres/singup/exam/list'/>?siteCode="+siteCode+"&currentPage="+currentPage;
	jboxGet(url , null , function(resp){
		$("#content").html(resp);
	} , null , false);
}

function chageExamSite(){
	var siteCode = $("#siteCode").val();
	var url = "<s:url value='/cnres/singup/exam/list'/>?siteCode="+siteCode;
	jboxGet(url , null , function(resp){
		$("#content").html(resp);
	} , null , false);
}

function allotExamCode(){
	var doctorCheckBox = $("input[name='doctorFlow']:checked");
	var siteCode = $("#siteCode").val();
	if(!siteCode){
		jboxTip("请选择考点!");
		return ;
	}
	if(doctorCheckBox.length>0){
		jboxConfirm("确认提交？" , function(){
			var url = "<s:url value='/cnres/singup/exam/getexamsite'/>?siteCode="+siteCode;
			jboxGet(url , null , function(resp){
				if(resp.siteFlow){
					$("#room").empty();
					$("#user_num_span").html(doctorCheckBox.length);
					$("#site_code_span").html(resp.siteCode);
					$("#site_name_span").html(resp.siteName);
					for(var t=1;t<=resp.roomNum;t++){
						var tmp = t;
						if(t<10){
							tmp = "0"+t;
						}
						$("#room").append("<option value='"+tmp+"'>"+tmp+"</option>");
					}
					jboxOpenContent($("#allotExamCodeView").html() , "考场分配" , 400 , 200);
				}else{
					jboxTip("数据加载失败");
				}
			} , null , false);
		});
	}else{
		jboxTip("请勾选学员!");
		return;
	}
}

function submitAllotExamCode(){
	alert($(".ui-dialog-content #room").val());
	
	var url = "<s:url value='/cnres/singup/exam/allotexamcode'/>";
	var doctorCheckBox = $("input[name='doctorFlow']:checked");
	var userFlows = {};
	$.each(doctorCheckBox , function(i , n){
		userFlows[i] = $(n).val();
	});
	var reqdata = {
			"siteCode":$("#siteCode").val(),
			"room":$(".ui-dialog-content #room").val(),
			"userFlows":userFlows
	};
	jboxPost(url , reqdata , function(resp){
		if(resp=="1"){
			jboxTip("操作成功");
			jboxClose();
			search();
		}else{
			jboxTip(resp);
		}
	} , null , false);
	
}

function checkedAll(){
	var ck = $("#checkedAll").attr("checked");
	if(ck){
		$("input[name='doctorFlow']").attr("checked" , true);
	}else{
		$("input[name='doctorFlow']").attr("checked" , false);
	}
}

</script>
      <div class="main_hd">
        <h2>考试管理&#12288;&#12288;&#12288;&#12288;
        考点：<select name="siteCode" id="siteCode" class="select" style="width:200px;" onchange="chageExamSite();">
            	    <option value=''>请选择</option>
            	     <c:forEach items="${sites}" var='site'>
                  		 <option value="${site.siteCode}" <c:if test='${param.siteCode eq site.siteCode}'>selected="selected"</c:if>>${site.siteName}</option>
              		 </c:forEach>
            	</select>
        &#12288;&#12288;<input type="button" value="分配准考证号" class="btn" onclick="allotExamCode();"/>
        </h2>
        
         <div class="title_tab" id="toptab">
          <ul>
            <li class="tab_select"><a>人员列表</a></li>
            <li class="tab" ><a>考场分配</a></li>
          </ul>
        </div>
      </div>
      
      <div class="main_bd" id="div_table_0" >
        <div class="div_table">
          <table border="0" cellpadding="0" cellspacing="0" class="grid">
            <tr>
              <th style="text-align: left;padding-left: 10px;"><input type="checkbox" id="checkedAll" onclick="checkedAll();"/></th>
              <th style="text-align: left;padding-left: 40px;">姓名</th>
              <th style="text-align: left;padding-left: 40px;">毕业院校</th>
              <th style="text-align: left;padding-left: 40px;">毕业专业</th>
              <th style="text-align: left;padding-left: 40px;">准考证号</th>
              <th>报名信息</th>
            </tr>
            <c:forEach items="${doctors}" var="user">
            <tr>
              <td><c:if test='${empty user.doctorRecruit.examCode}'><input name="doctorFlow" type="checkbox" value="${user.doctorFlow}"/></c:if></td>
              <td style="text-align: left;padding-left: 40px;">${user.sysUser.userName}</td>
              <td style="text-align: left;padding-left: 40px;">${user.graduatedName}</td>
              <td style="text-align: left;padding-left: 40px;">
                  <c:forEach var="dict" items="${dictTypeEnumGraduateMajorList}">
              	        <c:if test='${user.specialized==dict.dictId}'>${dict.dictName}</c:if>
              	    </c:forEach>
              </td>
              <td>${user.doctorRecruit.examCode}</td>
              <td>
	             <a class="btn" onclick="getInfo('${user.sysUser.userFlow}');">详细</a>
              </td>
            </tr>
            </c:forEach>
          </table>
        </div>
        <div class="page" style="padding-right: 40px;">
       	 <input id="currentPage" type="hidden" name="currentPage" value="${currentPage}"/>
           <c:set var="pageView" value="${pdfn:getPageView(doctors)}" scope="request"></c:set>
	  		 <pd:pagination-cnres toPage="toPage"/>	 
        </div>
      </div>
      <div id="allotExamCodeView" style="display: none">
      	<table style="text-align: center;margin-left: 20px;margin-right: 20px;line-height: 30px;">
      		<tr><td  style="text-align: left;">&#12288;当前考点：<span id="site_code_span"></span>-<span id="site_name_span"></span></td></tr>
      		<tr><td  style="text-align: left;">待分配人数：<span id="user_num_span" style="color: red"></span></td></tr>
      		<tr><td  style="text-align: left;">&#12288;选择考场：<select id="room" class="select" style="width:100px;">
              </select></td></tr>
      	</table>
         <div style="text-align: center;margin-top: 10px;margin-right: 120px;">
         	<input type="button" class="btn_blue"   value="确定" onclick="submitAllotExamCode();"/>
         </div>
      </div>
