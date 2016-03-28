<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>江苏省住院医师规范化培训管理平台</title>
<jsp:include page="/jsp/jsres/htmlhead-jsres.jsp">
	<jsp:param name="basic" value="true"/>
	<jsp:param name="jbox" value="true"/>
	<jsp:param name="font" value="true"/>
	<jsp:param name="jquery_datePicker" value="true"/>
</jsp:include>
<script type="text/javascript">
	function updateDoctorRecruit(){
		$('[name="doctorStatusName"]').val($("#doctorStatusId option:selected").text());
		$('[name="doctorStrikeName"]').val($("#doctorStrikeId option:selected").text());
		var fromSerizalize=$("#from").serialize();
		var url="<s:url value='/jsres/doctorRecruit/modifyDoctorRecruit'/>";
		jboxPost(url,fromSerizalize,function(s){
				setTimeout(function(){
					window.parent.doctorTrendMain();
					jboxClose();
				},1000);
		},null,true); 
		
		
	}
	
</script>
</head>
<body>
<div class="div_search">
	<form id="from">
	<input type="hidden" name="recruitFlow" value="${doctorRecruit.recruitFlow}"/>
	<input type="hidden" name="doctorStatusName"/>
	<input type="hidden" name="doctorStrikeName"/>
	<table border="0" cellpadding="0" cellspacing="0" class="base_info">
            <colgroup>
              <col width="20%"/>
              <col width="30%"/>
              <col width="20%"/>
              <col width="30%"/>
            </colgroup>
	           <tbody>
	           <tr>
	               <th>姓名：</th>
	               <td>${user.userName}</td>
	               <th>届别：</th>
	               <td>${doctorRecruit.sessionNumber}</td>
	           </tr>
	           <tr>
	               <th>培训类别：</th>
	               <td>${doctorRecruit.catSpeName}</td>
	               <th>培训专业：</th>
	               <td>${doctorRecruit.speName}</td>
	           </tr>
	           <tr>
	               <th>医师状态：</th>
	               <td>
		               <select class="select" style="width: 106px;" name="doctorStatusId" id="doctorStatusId" onchange="sunzz();">
		               <c:forEach items="${dictTypeEnumDoctorStatusList}" var="dict">
						    <option name="${dict.dictId}" value="${dict.dictId}" <c:if test="${doctorRecruit.doctorStatusId==dict.dictId}">selected="selected"</c:if>>${dict.dictName}</option>
					    </c:forEach>
				       </select>
				   </td>
	               <th>医师走向：</th>
	               <td>
	               	<select class="select" style="width: 106px;" name="doctorStrikeId" id="doctorStrikeId" onchange="sunzz();">
	               	 	<c:forEach items="${dictTypeEnumDoctorStrikeList}" var="strike">
	               			   <option name="${strike.dictId}" value="${strike.dictId}" <c:if test="${doctorRecruit.doctorStrikeId==strike.dictId}">selected="selected"</c:if>>${strike.dictName}</option>
					     </c:forEach>
				    </select>
	               </td>
	           </tr>
	           </tbody>
           </table>
           </form>
          <div class="btn_info">
			<input type="button" style="width:100px;" class="btn_blue"  onclick="updateDoctorRecruit();" value="保存"></input>
			<input type="button" style="width:100px;" class="btn_grey" onclick="javascript:jboxClose();" value="关闭"></input>
		 </div>
 </div>
</body>
</html>