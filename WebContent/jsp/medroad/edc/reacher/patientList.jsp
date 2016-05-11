<script type="text/javascript" src="<s:url value='/jsp/medroad/js/sort.js'/>"></script>
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
	function searchPatients(){
		var data = {
				"patientCode":$("#patientCode").val(),
				"projFlow":'${sessionScope.edcCurrProj.projFlow}',
				"orgFlow":'${sessionScope.currUser.orgFlow}'
		}
		jboxPostLoad("content","<s:url value='/medroad/patientList'/>",data,true);
	}
	function EnterPress(e){ //传入 event
		var e = e || window.event;
		if(e.keyCode == 13){
			searchPatients();
		}
	}
</script>
<div class="main_hd">
	<h2 class="underline">受试者列表
	<!-- 
	<input type="button" style="float: right;margin-right: 10px;margin-top: 30px;" class="btn_green" onclick="addPatient();" value="受试者登记"></input>
	 -->
	</h2>
	<div class="extra_info search_bar" id="searchBar"><span class="frm_input_box search with_del append ">
	    <a class="del_btn jsSearchInputClose" href="javascript:searchPatients();" style="display:">
	        <i class="icon16_common search_gray"></i>&nbsp;
	    </a>
	    <a href="javascript:addPatient();" class="frm_input_append jsSearchInputBt">
	    	<i class="icon16_common add_gray" title="添加受试者" >添加受试者</i>&nbsp;
	    </a>
	    <input type="text" class="frm_input jsSearchInput" id="patientCode" onkeypress="EnterPress(event)" onkeydown="EnterPress()"  value="${param.patientCode }" placeholder="受试者编号/姓名">
		</span>
	</div>
</div>
<div class="main_bd" id="div_table_0" >
    <div class="div_table">
           <table border="0" cellpadding="0" cellspacing="0" class="grid" style="width: 100%" id="patientTab">
            <tr>
                <th width="200px;">编号(身份证后四位)</th>
                <th>姓名</th>
                <th>性别</th>
                <th>入组日期
                <!-- 
                	<span class="icon_rank">
                         <i class="arrow arrow_up"></i>
                         <i class="arrow arrow_down"></i>
                     </span>
                 -->
                </th>
                <th>入组医师</th>
                 <th  width="250px;">操作</th>
            </tr>
            <tbody>  
            <c:forEach items="${patientList }" var= "patient"> 
            <tr>
                <td>${pdfn:encryptIdNo(patient.patientCode,4)}</td>
                <td>${patient.patientNamePy }</td>
                <td>${patient.sexName }</td>
                <td>${pdfn:transDate(patient.inDate)}</td> 
                 <td>${patient.inDoctorName }</td>
                <td><a class="btn" onclick="getInfo('${patient.patientFlow}');">受试者信息</a>
                &#12288;
                	<a class="btn" onclick="visit('${patient.patientFlow}');">访视</a>
                </td>
            </tr>
            </c:forEach>
            	<c:if test="${empty patientList}">
            		<tr><td colspan="6">无记录</td></tr> 
            	</c:if>
            </tbody>
        </table>
        </div>
        <c:if test="${!empty patientList}">
         <div class="page" style="padding-right: 40px;">
       	 <input id="currentPage" type="hidden" name="currentPage" />
           <c:set var="pageView" value="${pdfn:getPageView(patientList)}" scope="request"></c:set>
	  		 <pd:pagination-hbres toPage="toPage"/>	 
        </div>
       	</c:if>
</div>
      
