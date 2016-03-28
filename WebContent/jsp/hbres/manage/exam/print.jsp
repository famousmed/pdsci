<jsp:include page="/jsp/hbres/htmlhead-hbres.jsp">
	<jsp:param name="font" value="true"/>
</jsp:include>
<link rel="stylesheet" type="text/css" href="<s:url value='/jsp/hbres/css/exam.css'/>?v=${applicationScope.sysCfgMap['sys_version']}"></link>
<link rel="stylesheet" type="text/css" href="<s:url value='/jsp/hbres/css/font.css'/>?v=${applicationScope.sysCfgMap['sys_version']}"></link>
<script type="text/javascript">
function search(){
	var searchdata = {
	    "siteFlow":$("#siteFlow").val(),
	    "roomFlow":$("#roomFlow").val(),
	    "beginRoomCode":$("#beginRoomCode").val(),
	    "endRoomCode":$("#endRoomCode").val()
	};
	
	jboxPostLoad("content" ,"<s:url value='/hbres/singup/exam/print'/>" ,searchdata , true);
}
function doPrint(){
	var headstr = "<html><head><title></title></head><body>"; 
	var footstr = "</body>"; 
	var newstr = $(".search_table").html(); 
	var oldstr = document.body.innerHTML; 
	document.body.innerHTML = headstr+newstr+footstr; 
	window.print(); 
	document.body.innerHTML = oldstr; 
	return false; 
}
</script>
<body>
      <div class="main_hd">
        <h2>考试管理
        <span class="tips">当前考试：${sessionScope.currExam.examName}</span>
        </h2>
        <jsp:include page="./nvtab.jsp">
             <jsp:param value="5" name="tabIndex"/>
        </jsp:include>
      </div>
      
      <div class="main_bd" id="div_table_0" >
      <div class="div_search noprint">
         <label >考点：</label>
         <select name="siteFlow" id="siteFlow" style="width:200px;" class="select" onchange="search();">
             <option value=''>请选择</option>
             <c:forEach items="${sites}" var='site'>
                 <option value="${site.recordFlow}" <c:if test='${param.siteFlow eq site.recordFlow}'>selected="selected"</c:if>>${site.siteName}</option>
             </c:forEach>
         </select>
          <label >考场：</label>
         <select name="roomFlow" id="roomFlow" style="width:200px;" class="select" onchange="search();">
             <option value=''>请选择</option>
             <c:forEach items="${rooms}" var='room'>
                 <option value="${room.roomFlow}" <c:if test='${param.roomFlow eq room.roomFlow}'>selected="selected"</c:if>>${room.roomCode}</option>
             </c:forEach>
         </select>
           <label >考场区间：</label>
        <input type="text" id="beginRoomCode" name="beginRoomCode" value="${param.beginRoomCode }"  class="select" style="width: 50px;"/>~ 
        <input type="text" id="endRoomCode" name="endRoomCode" value="${param.endRoomCode }"  class="select" style="width: 50px;" onblur="search();"/>
         <input class="fr btn_green change" type="button" onclick="doPrint();"  value="打印"/>
         </div>
         
         <div class="search_table">
         <c:forEach items="${ roomCodeList}" var="roomCode">
            <div class="A4">
          	<table border="0" align="center" cellpadding="0" cellspacing="0" class="kch" >
  				<tr>
   					 <td>第 ${roomCode} 考场</td>
 			    </tr>
 			    <c:forEach items="${speList }" var="speid">
	  				<c:set var="key" value="${roomCode}_${speid }"/> 
	  				<c:if test="${ !empty speDocCountMap[key]}">
	  				<tr>
	    				<td>
	    				<c:set var="begin" value="${key }_S"/>
	    				<c:set var="end" value="${key }_E"/>
	    				准考证号：${speTicktNumRangeMap[begin] }-${speTicktNumRangeMap[end] }</td>
	  				</tr>
	  				<tr>
	   					 <td>
	   					 ${pdfn:getDictName(dictTypeEnumGraduateMajor,speid)}：${speDocCountMap[key] }人</td>
	  				</tr>
	  				</c:if>
  				</c:forEach>
			</table>
			</div>
			<div class="A4 title ">
				<h1>${exam.examName }考场座位标签</h1>				    			
				<table width="100%" border="0" cellspacing="0" cellpadding="0" class="seat">
  					<tr>
    					<td style=" text-align:left;padding-left:20px;">考点：${site.siteName }</td>
   						<td>考场号：${roomCode }</td>
    					<td style="text-align:right; padding-right:50px;"></td>
  					</tr>
				</table>
				
				<c:forEach items="${roomDoctorExtMap[roomCode] }" varStatus="status1">
				<c:if test="${status1.index % 12 eq 0}">
				<table <c:if test="${ status1.index!=0}">class='A4'</c:if>>
				<c:forEach items="${roomDoctorExtMap[roomCode] }" varStatus="status2" begin="${status1.index }" end="${status1.index +11}">
				<c:if test="${status2.index % 3 eq 0}">
					<tr>
						<c:forEach items="${roomDoctorExtMap[roomCode] }" var="doctorExt"  begin="${status2.index}" end="${status2.index+2}">
								<td>
									<table border="0" cellspacing="0" cellpadding="0" class="seat_label"  >
				  					<tr>
				    					<td colspan="2">姓名：${doctorExt.doctorName }</td>
				    					<th rowspan="5"> <img src="${sysCfgMap['upload_base_url']}/${doctorExt.doctor.doctorHeadImg}" width="100px" height="120px"/></th>
				  					</tr>
				  					<tr>
				    					<td colspan="2">准考证号：${doctorExt.ticketNum }</td>
				    				</tr>
				  					<tr>
				    					<td colspan="2">身份证号：</td>
				    				</tr>
				  					<tr>
				    					<td colspan="2">${doctorExt.user.idNo }</td>
				    				</tr>
				  					<tr>
				    					<td style="line-height:45px;">座位：<p>${fn:substring(doctorExt.ticketNum,6,8)}</p></td>
				    					<td></td>
				    				</tr>
								</table>
							</td>
						</c:forEach>
					</tr>
					</c:if>
				</c:forEach>
				</table>
				</c:if>
				</c:forEach>
			</div>
			<div class="A4 title ">
				<h1>${exam.examName }考场核对单</h1>
   				<table width="100%" border="0" cellspacing="0" cellpadding="0" class="seat">
  					<tr>
    					<td style=" text-align:left;padding-left:20px;">考点：${site.siteName }</td>
    					<td>考场号：${roomCode }</td>
    					<td style="text-align:right; padding-right:50px;"></td>
  					</tr>
				</table>
				<c:forEach items="${roomDoctorExtMap[roomCode] }" varStatus="status1">
				<c:if test="${status1.index % 9 eq 0}">
				<table class='A4'>
				<c:forEach items="${roomDoctorExtMap[roomCode] }" varStatus="status2" begin="${status1.index }" end="${status1.index +8}">
				<c:if test="${status2.index % 3 eq 0}">
					<tr>
						<c:forEach items="${roomDoctorExtMap[roomCode] }" var="doctorExt"  begin="${status2.index}" end="${status2.index+2}">
								<td>
									<table border="0" cellspacing="0" cellpadding="0" class="seat_label"  >
				 					 <tr>
				    					<td rowspan="3" width="100"><img src="${sysCfgMap['upload_base_url']}/${doctorExt.doctor.doctorHeadImg}" width="100px" height="120px" /></td>
				    					<td colspan="2">考生签名：<input name="" type="text" class="seat_text" /></td>
				    				</tr>
				  					<tr>
				    					<td colspan="2">缺考标记：<input name="" type="checkbox" value="" /></td>
				    				</tr>
				  					<tr>
				    					<td>座位号：<span>${fn:substring(doctorExt.ticketNum,6,8)}</span></td>
				    					<th rowspan="3" width="70"></th>
				  					</tr>
				  					<tr>
				    					<td colspan="2">准考证号：${doctorExt.ticketNum }</td>
				    				</tr>
				  					<tr>
				    					<td colspan="2">姓名：${doctorExt.doctorName }</td>
				    				</tr>
								</table>
							</td>
						</c:forEach>
					</tr>
					</c:if>
				</c:forEach>
				</table>
				</c:if>
				</c:forEach>
			</div>
			</c:forEach>
        </div>
      </div>
</body>