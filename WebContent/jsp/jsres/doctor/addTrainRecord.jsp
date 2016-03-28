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
$(function(){
	$('#trainDate').datepicker();
});

function changeTrainCategoryType(){
	var trainDate = $("#trainDate").val();
	var trainCategoryType = "";
	if (trainDate<'2013-11-01') {
		trainCategoryType = "${trainCategoryTypeEnumBefore2014.id}";
	} else if (trainDate>='2013-11-01' && trainDate<'2015-11-01') {
		trainCategoryType = "${trainCategoryTypeEnumBetween20142015.id}";
	} else if (trainDate>='2015-11-01') {
		trainCategoryType = "${trainCategoryTypeEnumAfter2015.id}";
	}
	$("#trainCategoryTd").html($("#clone_"+trainCategoryType).html());
	var defaultOption = $("#trainCategoryTd").find("[name='trainCategory']")[0];
	$(defaultOption).attr("checked","checked");
	changeTrainSpes($(defaultOption).val());
}

function changeTrainSpes(trainCategory){
	$("#trainSpeTd").html($("#cloneSpe_"+trainCategory).html());
}
</script>
</head>
<body>
<div class="div_search">
		<table border="0" cellpadding="0" cellspacing="0" class="base_info">
            <colgroup>
              <col width="15%"/>
              <col width="30%"/>
              <col width="15%"/>
              <col width="40%"/>
            </colgroup>
            <thead>
            </thead>
	           <tbody>
	           <tr>
	               <th>规培起始日期：</th>
	               <td><input class="validate[required] input" type="text"  id="trainDate"  onchange="changeTrainCategoryType();" readonly="readonly" style="margin: 0;"/></td>
	               <th>培训阶段：</th>
	               <td id="trainCategoryTd">
	               </td>
	           </tr>
	           <tr>
	               <th>所在地区：</th>
	               <td colspan="3">
	               		<select class="select" style="width: 160px;" >
		               		<option value="">请选择</option>
						    <option value="">南京市</option>
						    <option value="">无锡市</option>
						    <option value="">徐州市</option>
						    <option value="">常州市</option>
					    </select>
	               </td>
	           </tr>
	           <tr>
	               <th>培训基地：</th>
	               <td>
		               	<select class="select" style="width: 160px;" >
		               		<option value="">请选择</option>
						    <option value="">江苏省中医院</option>
						    <option value="">江苏省人民医院</option>
						    <option value="">南京中西医结合医院</option>
					    </select>
	               </td>
	               <th>培训专业：</th>
	               <td id="trainSpeTd">
	               </td>
	           </tr>
	           <tr>
	               <th>培养年限：</th>
	               <td>
		               	<select class="select" style="width: 160px;" >
		               		<option value="">请选择</option>
						    <option value="">一年</option>
						    <option value="">两年</option>
						    <option value="">三年</option>
					    </select>
	               </td>
	               <th>已培养年限：</th>
	               <td>
	               		<select class="select" style="width: 160px;" >
		               		<option value="">不满一年</option>
						    <option value="">一年</option>
						    <option value="">两年</option>
						    <option value="">三年</option>
						    <option value="">四年</option>
						    <option value="">五年</option>
						    <option value="">六年</option>
					    </select>
	               </td>
	           </tr>
	           <tr>
	               <th>医师状态：</th>
	               <td>
		               <select class="select" style="width: 160px;">
		               <option value="">请选择</option>
					    <option value="" selected>在培</option>
					    <option value="">终止</option>
					    <option value="">结业</option>
				       </select>
				   </td>
	               <th>医师走向：</th>
	               <td>
	               	<select class="select" style="width: 160px;">
	               		<option value="">请选择</option>
					    <option value="">留院</option>
					    <option value="">考研</option>
					    <option value="">出国</option>
					    <option value="">外院就业</option>
					    <option value="">终止培训</option>
				       </select>
	               </td>
	           </tr>
	           </tbody>
           </table>
          <div align="center" style="margin-top: 20px; margin-bottom:20px;">
			<input type="button" style="width:100px;" class="btn_blue"  onclick="" value="保存"></input>
			<input type="button" style="width:100px;" class="btn_grey" onclick="javascript:jboxClose();" value="关闭"></input>
		 </div>
 </div>
 <c:forEach items="${trainCategoryTypeEnumList }" var="trainCategoryType">	
	<span id="clone_${trainCategoryType.id }" style="display: none;">
	<c:forEach items="${trainCategoryEnumList }" var="trainCategory">
	<c:if test="${trainCategory.typeId eq trainCategoryType.id }">
		<label><input type="radio" name="trainCategory" value="${trainCategory.id }" onchange="changeTrainSpes(this.value);"/>${trainCategory.name }</label>
	</c:if>
	</c:forEach>
    <%-- <select class="select" name="trainCategory" style="width: 160px;" onchange="changeTrainSpes(this.value);">
       <option value="">请选择</option>
	   <c:forEach items="${trainCategoryEnumList }" var="trainCategory">
	       <c:if test="${trainCategory.typeId eq trainCategoryType.id }">
	       <option value="${trainCategory.id }">${trainCategory.name }</option>
	       </c:if>
	   </c:forEach>
    </select> --%>
	</span>
</c:forEach>

<c:forEach items="${trainCategoryEnumList }" var="trainCategory">	
	<span id="cloneSpe_${trainCategory.id }" style="display:none ;">
    <select class="select" name="trainSpe" style="width: 160px;">
       <option value="">请选择</option>
       <c:set var="dictName" value="dictTypeEnum${trainCategory.id }List" />
	   <c:forEach items="${applicationScope[dictName]}" var="trainSpe">
	       <option value="${trainSpe.dictId }">${trainSpe.dictName }</option>
	   </c:forEach>
    </select>
	</span>
</c:forEach>
</body>
</html>