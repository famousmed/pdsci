<script type="text/javascript">
	function toPage(page) {
		if(page){
			$("#currentPage").val(page);			
		}
		patients('${sessionScope.currUser.orgFlow }',$("#currentPage").val());
	} 
	function getInfo(patientFlow){
		jboxOpen("<s:url value='/enso/patientInfo'/>?patientFlow="+patientFlow,"受试者信息",1000,550);
	}
</script>
<div class="main_hd">
	<h2 class="underline">受试者列表</h2>
</div>
<div class="main_bd" id="div_table_0" >
    <div class="div_table">
           <table border="0" cellpadding="0" cellspacing="0" class="grid" style="width: 100%">
            <tr>
                <th width="200px;">编号(身份证后四位)</th>
                <th>姓名</th>
                <th>入组日期</th>
                <th>入组医师</th>
                 <th>上次访视日期</th>
                 <th  width="250px;">操作</th>
            </tr>
            <c:forEach items="${patientList }" var= "patient"> 
            <tr>
                <td>${pdfn:encryptIdNo(patient.patientCode,4)}</td>
                <td>${patient.patientName }</td>
                <td>${pdfn:transDate(patient.inDate)}</td> 
                 <td>${patient.inDoctorName }</td>
                <td>${pdfn:transDate(patient.inDate)}</td>
                <td><a class="btn" onclick="getInfo('${patient.patientFlow}');">受试者信息</a>
                &#12288;
                	<a class="btn" onclick="visit('${patient.patientFlow}');">访视</a>
                </td>
            </tr>
            </c:forEach>
        </table>
        </div>
         <div class="page" style="padding-right: 40px;">
       	 <input id="currentPage" type="hidden" name="currentPage" />
           <c:set var="pageView" value="${pdfn:getPageView(patientList)}" scope="request"></c:set>
	  		 <pd:pagination-hbres toPage="toPage"/>	 
        </div>
</div>
      
