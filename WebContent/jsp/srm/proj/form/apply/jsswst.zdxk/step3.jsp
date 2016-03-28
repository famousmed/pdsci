<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<c:if test="${param.view != GlobalConstant.FLAG_Y}">
<script type="text/javascript">
	function nextOpt(step){
		if(false==$("#projForm").validationEngine("validate")){
			return false;
		}
		var form = $('#projForm');
		var action = form.attr('action');
		action+="?nextPageName="+step;
		form.attr("action" , action);
		form.submit();
	}
	function add(tb){
	 	$("#"+tb+"Tb").append($("#"+tb+"Template tr:eq(0)").clone());
	 	
	 	var length = $("#"+tb+"Tb").children().length;
	 	//序号
		$("#"+tb+"Tb").children("tr").last().children("td").eq(1).text(length);
	}
	
	
	function delTr(tb){
		//alert("input[name="+tb+"Ids]:checked");
		var checkboxs = $("input[name='"+tb+"Ids']:checked");
		if(checkboxs.length==0){
			jboxTip("请勾选要删除的！");
			return false;
		}
		jboxConfirm("确认删除?",function () {
			var trs = $('#'+tb+'Tb').find(':checkbox:checked');
			$.each(trs , function(i , n){
				$(n).parent('td').parent("tr").remove();
			});
			//删除后序号
			var serial = 0;
			$("."+tb+"Serial").each(function(){
				serial += 1;
				$(this).text(serial);
			});
			//统计
			finishTechStatistics();
			ingTechStatistics();
		});
	}
	
	
	function finishTechStatistics(){
		$("#finishTechStatistics input").each(function(){
			$(this).val("");
		});
		$("#finishTechTb select[name=finishTech_source]").each(function (){
			var source = this.value;
			var fund = parseFloat($(this).parent().next().next().children().val());
			//alert(source +"," +fund);
			var num = parseFloat($("input[name="+source +"projCount]").val());
			var fundCount = parseFloat($("input[name="+source +"fundCount]").val());
			if(isNaN(num)){
				num = 0;
			}
			if(isNaN(fund)){
				fund = 0;
			}
			if(isNaN(fundCount)){
				fundCount = 0;
			}
			$("input[name="+source +"projCount]").val(num+1);
			fundCount += fund;
			$("input[name="+source +"fundCount]").val(parseFloat(fundCount.toFixed(3)));
			
			//项目数
			var projSum = 0;
			var tds = $("#finishTechStatistics").children().eq(0).find("td:not(:last , :first)");
			$.each(tds , function(i , domEle){
					var val = $(domEle).children("input").val();
					if (val == null || val == undefined || val == '' || isNaN(val)){
						val = 0;
					}
					projSum = parseFloat(projSum)+parseFloat(val);
				
			});
			$("input[name=finishProjCount]").val(parseFloat(projSum.toFixed(3))); 
			
			
			//经费合计
			var fundSum = 0;
			var tds = $("#finishTechStatistics").children().eq(1).find("td:not(:last , :first)");
			$.each(tds , function(i , domEle){
					var val = $(domEle).children("input").val();
					if (val == null || val == undefined || val == '' || isNaN(val)){
						val = 0;
					}
					fundSum = parseFloat(fundSum)+parseFloat(val);
				
			});
			$("input[name=finishFundCount]").val(parseFloat(fundSum.toFixed(3))); 
			
		});
	}
	
	function ingTechStatistics(){
		$("#ingTechStatistics input").each(function(){
			$(this).val("");
		});
		$("#ingTechTb select[name=ingTech_source]").each(function (){
			var source = this.value;
			var fund = parseFloat($(this).parent().next().next().children().val());
			//alert(source +"," +fund);
			var num = parseFloat($("input[name="+source +"ingProjCount]").val());
			var fundCount = parseFloat($("input[name="+source +"ingFundCount]").val());
			if(isNaN(num)){
				num = 0;
			}
			if(isNaN(fund)){
				fund = 0;
			}
			if(isNaN(fundCount)){
				fundCount = 0;
			}
			$("input[name="+source +"ingProjCount]").val(num+1);
			fundCount += fund;
			$("input[name="+source +"ingFundCount]").val(parseFloat(fundCount.toFixed(3)));
			
			//项目数
			var projSum = 0;
			var tds = $("#ingTechStatistics").children().eq(0).find("td:not(:last , :first)");
			$.each(tds , function(i , domEle){
					var val = $(domEle).children("input").val();
					if (val == null || val == undefined || val == '' || isNaN(val)){
						val = 0;
					}
					projSum = parseFloat(projSum)+parseFloat(val);
				
			});
			$("input[name=ingProjCount]").val(parseFloat(projSum.toFixed(3))); 
			
			
			//经费合计
			var fundSum = 0;
			var tds = $("#ingTechStatistics").children().eq(1).find("td:not(:last , :first)");
			$.each(tds , function(i , domEle){
					var val = $(domEle).children("input").val();
					if (val == null || val == undefined || val == '' || isNaN(val)){
						val = 0;
					}
					fundSum = parseFloat(fundSum)+parseFloat(val);
			});
			$("input[name=ingFundCount]").val(parseFloat(fundSum.toFixed(3))); 
			
		});
	}
</script>
</c:if>

<style type="text/css">
 .bs_tb tbody td input{text-align: left;margin-left: 10px;}
</style>
	<form action="<s:url value='/srm/proj/mine/saveStep'/>" method="post" style="position: relative;"
		id="projForm">
		<input type="hidden" id="pageName" name="pageName" value="step3" /> 
		<input type="hidden" id="recFlow" name="recFlow" value="${projRec.recFlow}"/>
		<input type="hidden" id="projFlow" name="projFlow" value="${proj.projFlow}"/>
		<input type="hidden" id="recTypeId" name="recTypeId" value="${param.recTypeId}"/>
		   
		  <div>
		    <font style="font-size: 18px; font-weight:bold; ">三、科技项目情况</font>
		  </div>
		  
		 <table width="100%" class="bs_tb" style="margin-top: 20px;">
		    <tr>
		       <th colspan="9" class="theader">1.本中心已完成的主要科技项目
		            <c:if test="${param.view!=GlobalConstant.FLAG_Y }">
					<span style="float: right;padding-right: 10px">
					<img title="新增" src="<s:url value="/css/skin/${skinPath}/images/add3.png" />" style="cursor: pointer;" onclick="add('finishTech')"></img>&#12288;
					<img title="删除"  style="cursor: pointer;" src="<s:url value='/css/skin/${skinPath}/images/del1.png'/>" onclick="delTr('finishTech');"></img></span>
					</c:if>
		       </th>
		    </tr>
		    <tr>
		       <td width="50px;"></td>
		       <td width="50px">序号</td>
		       <td width="10%">项目编号</td>
		       <td width="15%">项目名称</td>
		       <td width="15%">项目来源</td>
		       <td width="20%">起止时间</td>
		       <td width="10%">项目经费</td>
		       <td width="10%">负责人姓名</td>
		       <td width="10%">负责人职称</td>
		    </tr>
		    <tbody id="finishTechTb">
		    <c:forEach items="${resultMap.finishTech }" var="finishTech" varStatus="status">
		    <tr>
		      <td width="50px" style="text-align: center;"><input name="finishTechIds" type="checkbox"/></td>
              <td width="50px" style="text-align: center;" class="finishTechSerial">${status.count}</td>
		      <td>
		         <input type="text" name="finishTech_code" class="inputText" style="width: 90%" value="${finishTech.objMap.finishTech_code}"/>
		      </td>
		      <td>
		         <input type="text" name="finishTech_name" class="inputText" style="width: 90%" value="${finishTech.objMap.finishTech_name}"/>
		      </td>
		      <td>
		         <select name="finishTech_source"  class="inputText" style="width: 90%" onchange="finishTechStatistics()">
			 		<option value="">请选择</option>
			 		<option value="GJJ" <c:if test="${finishTech.objMap.finishTech_source eq 'GJJ'}">selected="selected"</c:if>>国家级</option>
			 		<option value="SBJ" <c:if test="${finishTech.objMap.finishTech_source eq 'SBJ'}">selected="selected"</c:if>>省部级</option>
			 		<option value="WST" <c:if test="${finishTech.objMap.finishTech_source eq 'WST'}">selected="selected"</c:if>>卫生厅</option>
			 		<option value="SJJ" <c:if test="${finishTech.objMap.finishTech_source eq 'SJJ'}">selected="selected"</c:if>>市局级</option>
			 		<option value="QSYDWWT" <c:if test="${finishTech.objMap.finishTech_source eq 'QSYDWWT'}">selected="selected"</c:if>>企事业单位委托</option>
			 		<option value="ZWHZ" <c:if test="${finishTech.objMap.finishTech_source eq 'ZWHZ'}">selected="selected"</c:if>>中外合作</option>
			 		<option value="GJZZ" <c:if test="${finishTech.objMap.finishTech_source eq 'GJZZ'}">selected="selected"</c:if>>国际组织</option>
			 		<option value="QT" <c:if test="${finishTech.objMap.finishTech_source eq 'QT'}">selected="selected"</c:if>>其他</option>
			 	</select>
		      </td>
		      <td>
		         <input type="text" name="finishTech_startTime" class="inputText" style="width: 40%" value="${finishTech.objMap.finishTech_startTime}" onClick="WdatePicker({dateFmt:'yyyy-MM-dd'})" readonly="readonly"/>
		         ~<input type="text" name="finishTech_endTime" class="inputText" style="width: 40%" value="${finishTech.objMap.finishTech_endTime}" onClick="WdatePicker({dateFmt:'yyyy-MM-dd'})" readonly="readonly"/>
		      </td>
		      <td>
		         <input type="text" name="finishTech_fund" class="validate[custom[number]] inputText" style="width: 90%" value="${finishTech.objMap.finishTech_fund}" onchange="finishTechStatistics()"/>
		      </td>
		      <td>
		         <input type="text" name="finishTech_principalName" class="inputText" style="width: 90%" value="${finishTech.objMap.finishTech_principalName}"/>
		      </td>
		      <td>
		         <select name="finishTech_principalPost" class="inputText" style="width: 90%">
		         	   <option value="">请选择</option>
					   <c:forEach items="${dictTypeEnumUserTitleList}" var="dict">
		        	   <option value="${dict.dictId}" <c:if test='${finishTech.objMap.finishTech_principalPost == dict.dictId}'>selected="selected"</c:if>>${dict.dictName}</option>
		        	   </c:forEach>
			     </select>
		      </td>
		    </tr>
		    </c:forEach> 
		    </tbody>  
		 </table>    
		
		 <font style="font-size: 14px; font-weight:bold; ">&#12288;项目课题统计：</font>
		 <table width="100%" class="basic">
		    <tr>
		      <td width="5%" style="text-align: center;"></td>
		      <td style="text-align: center;">国家级</td>
		      <td style="text-align: center;">省部级</td>
		      <td style="text-align: center;">卫生厅</td>
		      <td style="text-align: center;">市局级</td>
		      <td style="text-align: center;">企事业单位委托</td>
		      <td style="text-align: center;">中外合作</td>
		      <td style="text-align: center;">国际组织</td>
		      <td style="text-align: center;">其他</td>
		      <td style="text-align: center;">合计</td>
		    </tr>
		    <tbody id="finishTechStatistics">
		    <tr>
		      <td style="text-align: center;">项目数</td>
		      <td style="text-align: center;"><input name="GJJprojCount" type="text" value="${resultMap.GJJprojCount}" class="validate[custom[integer]] inputText" style="width: 90%"/></td>
		      <td style="text-align: center;"><input name="SBJprojCount" type="text" value="${resultMap.SBJprojCount}" class="validate[custom[integer]] inputText" style="width: 90%"/></td>
		      <td style="text-align: center;"><input name="WSTprojCount" type="text" value="${resultMap.WSTprojCount}" class="validate[custom[integer]] inputText" style="width: 90%"/></td>
		      <td style="text-align: center;"><input name="SJJprojCount" type="text" value="${resultMap.SJJprojCount}" class="validate[custom[integer]] inputText" style="width: 90%"/></td>
		      <td style="text-align: center;"><input name="QSYDWWTprojCount" type="text" value="${resultMap.QSYDWWTprojCount}" class="validate[custom[integer]] inputText" style="width: 90%"/></td>
		      <td style="text-align: center;"><input name="ZWHZprojCount" type="text" value="${resultMap.ZWHZprojCount}" class="validate[custom[integer]] inputText" style="width: 90%"/></td>    
		      <td style="text-align: center;"><input name="GJZZprojCount" type="text" value="${resultMap.GJZZprojCount}" class="validate[custom[integer]] inputText" style="width: 90%"/></td>
		      <td style="text-align: center;"><input name="QTprojCount" type="text" value="${resultMap.QTprojCount}" class="validate[custom[integer]] inputText" style="width: 90%" /></td>
		      <td style="text-align: center;"><input name="finishProjCount" type="text" value="${resultMap.finishProjCount}" class="validate[custom[integer]] inputText" style="width: 90%" /></td>
		    </tr>
		    <tr>
		      <td style="text-align: center;">经费数</td>
		      <td style="text-align: center;"><input name="GJJfundCount" type="text" value="${resultMap.GJJfundCount}" class="validate[custom[number]] inputText"  style="width: 90%"/></td>
		      <td style="text-align: center;"><input name="SBJfundCount" type="text" value="${resultMap.SBJfundCount}" class="validate[custom[number]] inputText"  style="width: 90%"/></td>
		      <td style="text-align: center;"><input name="WSTfundCount" type="text" value="${resultMap.WSTfundCount}" class="validate[custom[number]] inputText" style="width: 90%" /></td>
		      <td style="text-align: center;"><input name="SJJfundCount" type="text" value="${resultMap.SJJfundCount}" class="validate[custom[number]] inputText" style="width: 90%" /></td>
		      <td style="text-align: center;"><input name="QSYDWWTfundCount" type="text" value="${resultMap.QSYDWWTfundCount}" class="validate[custom[number]] inputText" style="width: 90%" /></td>
		      <td style="text-align: center;"><input name="ZWHZfundCount" type="text" value="${resultMap.ZWHZfundCount}" class="validate[custom[number]] inputText" style="width: 90%" /></td>
		      <td style="text-align: center;"><input name="GJZZfundCount" type="text" value="${resultMap.GJZZfundCount}" class="validate[custom[number]] inputText" style="width: 90%" /></td>
		      <td style="text-align: center;"><input name="QTfundCount" type="text" value="${resultMap.QTfundCount}" class="validate[custom[number]] inputText" style="width: 90%" /></td>
		      <td style="text-align: center;"><input name="finishFundCount" type="text" value="${resultMap.finishFundCount}" class="validate[custom[number]] inputText" style="width: 90%" /></td>
		    </tr>
		    </tbody>
		 </table>
		 
		 <table width="100%" class="bs_tb" style="margin-top: 40px;">
		    <tr>
		       <th colspan="9" class="theader">2.本中心目前正在承担的主要科技项目
		            <c:if test="${param.view!=GlobalConstant.FLAG_Y }">
					<span style="float: right;padding-right: 10px">
					<img title="新增" src="<s:url value="/css/skin/${skinPath}/images/add3.png" />" style="cursor: pointer;" onclick="add('ingTech')"></img>&#12288;
					<img title="删除"  style="cursor: pointer;" src="<s:url value='/css/skin/${skinPath}/images/del1.png'/>" onclick="delTr('ingTech');"></img></span>
					</c:if>
		       </th>
		    </tr>
		    <tr>
		       <td width="50px"></td>
		       <td width="50px">序号</td>
		       <td width="10%">项目编号</td>
		       <td width="15%">项目名称</td>
		       <td width="15%">项目来源</td>
		       <td width="20%">起止时间</td>
		       <td width="10%">项目经费</td>
		       <td width="10%">负责人姓名</td>
		       <td width="10%">负责人职称</td>
		    </tr>
		    <tbody id="ingTechTb">
		    <c:forEach items="${resultMap.ingTech }" var="ingTech" varStatus="status">
		    <tr>
		      <td width="50px" style="text-align: center;"><input name="ingTechIds" type="checkbox"/></td>
              <td width="50px" style="text-align: center;" class="ingTechSerial">${status.count}</td>
		      <td>
		         <input type="text" name="ingTech_code" class="inputText" style="width: 90%" value="${ingTech.objMap.ingTech_code}"/>
		      </td>
		      <td>
		         <input type="text" name="ingTech_name" class="inputText" style="width: 90%" value="${ingTech.objMap.ingTech_name}"/>
		      </td>
		      <td>
		         <select name="ingTech_source"  class="inputText" style="width: 90%" onchange="ingTechStatistics()">
			 		<option value="">请选择</option>
			 		<option value="GJJ" <c:if test="${ingTech.objMap.ingTech_source eq 'GJJ'}">selected="selected"</c:if>>国家级</option>
			 		<option value="SBJ" <c:if test="${ingTech.objMap.ingTech_source eq 'SBJ'}">selected="selected"</c:if>>省部级</option>
			 		<option value="WST" <c:if test="${ingTech.objMap.ingTech_source eq 'WST'}">selected="selected"</c:if>>卫生厅</option>
			 		<option value="SJJ" <c:if test="${ingTech.objMap.ingTech_source eq 'SJJ'}">selected="selected"</c:if>>市局级</option>
			 		<option value="QSYDWWT" <c:if test="${ingTech.objMap.ingTech_source eq 'QSYDWWT'}">selected="selected"</c:if>>企事业单位委托</option>
			 		<option value="ZWHZ" <c:if test="${ingTech.objMap.ingTech_source eq 'ZWHZ'}">selected="selected"</c:if>>中外合作</option>
			 		<option value="GJZZ" <c:if test="${ingTech.objMap.ingTech_source eq 'GJZZ'}">selected="selected"</c:if>>国际组织</option>
			 		<option value="QT" <c:if test="${ingTech.objMap.ingTech_source eq 'QT'}">selected="selected"</c:if>>其他</option>
			 	</select>
		      </td>
		      <td>
		         <input type="text" name="ingTech_startTime" class="inputText" style="width: 40%" value="${ingTech.objMap.ingTech_startTime}" onClick="WdatePicker({dateFmt:'yyyy-MM-dd'})" readonly="readonly"/>
		         ~<input type="text" name="ingTech_endTime" class="inputText" style="width: 40%" value="${ingTech.objMap.ingTech_endTime}"  onClick="WdatePicker({dateFmt:'yyyy-MM-dd'})" readonly="readonly"/>
		      </td>
		      <td>
		         <input type="text" name="ingTech_fund" class="validate[custom[number]] inputText" style="width: 90%" value="${ingTech.objMap.ingTech_fund}" onchange="ingTechStatistics()"/>
		      </td>
		      <td>
		         <input type="text" name="ingTech_principalName" class="inputText" style="width: 90%" value="${ingTech.objMap.ingTech_principalName}"/>
		      </td>
		      <td>
		        <select name="ingTech_principalPost" class="inputText" style="width: 90%">
		         	   <option value="">请选择</option>
					   <c:forEach items="${dictTypeEnumUserTitleList}" var="dict">
		        	   <option value="${dict.dictId}" <c:if test='${ingTech.objMap.ingTech_principalPost == dict.dictId}'>selected="selected"</c:if>>${dict.dictName}</option>
		        	   </c:forEach>
			     </select>
		      </td>
		    </tr>
		    </c:forEach> 
		    </tbody>  
		 </table>    
		
		<font style="font-size: 14px; font-weight:bold; ">&#12288;项目课题统计：</font>
		<table width="100%" class="basic">
		    <tr>
		      <td width="5%" style="text-align: center;"></td>
		      <td style="text-align: center;">国家级</td>
		      <td style="text-align: center;">省部级</td>
		      <td style="text-align: center;">卫生厅</td>
		      <td style="text-align: center;">市局级</td>
		      <td style="text-align: center;">企事业单位委托</td>
		      <td style="text-align: center;">中外合作</td>
		      <td style="text-align: center;">国际组织</td>
		      <td style="text-align: center;">其他</td>
		      <td style="text-align: center;">合计</td>
		    </tr>
		    <tbody id="ingTechStatistics">
		    <tr>
		      <td>项目数</td>
		      <td><input name="GJJingProjCount" type="text" value="${resultMap.GJJingProjCount}" class="validate[custom[integer]] inputText" style="width: 90%"/></td>
		      <td><input name="SBJingProjCount" type="text" value="${resultMap.SBJingProjCount}" class="validate[custom[integer]] inputText" style="width: 90%"/></td>
		      <td><input name="WSTingProjCount" type="text" value="${resultMap.WSTingProjCount}" class="validate[custom[integer]] inputText" style="width: 90%"/></td>
		      <td><input name="SJJingProjCount" type="text" value="${resultMap.SJJingProjCount}" class="validate[custom[integer]] inputText" style="width: 90%"/></td>
		      <td><input name="QSYDWWTingProjCount" type="text" value="${resultMap.QSYDWWTingProjCount}" class="validate[custom[integer]] inputText" style="width: 90%"/></td>
		      <td><input name="ZWHZingProjCount" type="text" value="${resultMap.ZWHZingProjCount}" class="validate[custom[integer]] inputText" style="width: 90%"/></td>    
		      <td><input name="GJZZingProjCount" type="text" value="${resultMap.GJZZingProjCount}" class="validate[custom[integer]] inputText" style="width: 90%"/></td>
		      <td><input name="QTingProjCount" type="text" value="${resultMap.QTingProjCount}" class="validate[custom[integer]] inputText" style="width: 90%" /></td>
		      <td><input name="ingProjCount" type="text" value="${resultMap.ingProjCount}" class="validate[custom[integer]] inputText" style="width: 90%" /></td>
		    </tr>
		    <tr>
		      <td>经费数</td>
		      <td><input name="GJJingFundCount" type="text" value="${resultMap.GJJingFundCount}" class="validate[custom[number]] inputText" style="width: 90%" /></td>
		      <td><input name="SBJingFundCount" type="text" value="${resultMap.SBJingFundCount}" class="validate[custom[number]] inputText" style="width: 90%" /></td>
		      <td><input name="WSTingFundCount" type="text" value="${resultMap.WSTingFundCount}" class="validate[custom[number]] inputText" style="width: 90%" /></td>
		      <td><input name="SJJingFundCount" type="text" value="${resultMap.SJJingFundCount}" class="validate[custom[number]] inputText" style="width: 90%" /></td>
		      <td><input name="QSYDWWTingFundCount" type="text" value="${resultMap.QSYDWWTingFundCount}" class="validate[custom[number]] inputText" style="width: 90%" /></td>
		      <td><input name="ZWHZingFundCount" type="text" value="${resultMap.ZWHZingFundCount}" class="validate[custom[number]] inputText" style="width: 90%" /></td>
		      <td><input name="GJZZingFundCount" type="text" value="${resultMap.GJZZingFundCount}" class="validate[custom[number]] inputText" style="width: 90%" /></td>
		      <td><input name="QTingFundCount" type="text" value="${resultMap.QTingFundCount}" class="validate[custom[number]] inputText" style="width: 90%" /></td>
		      <td><input name="ingFundCount" type="text" value="${resultMap.ingFundCount}" class="validate[custom[number]] inputText" style="width: 90%" /></td>
		    </tr>
		    </tbody>
		 </table>
		
		  <table width="100%" class="basic" style="margin-top: 40px;">
		    <tr><th colspan="4" style="padding-left:15px;text-align:left;">科研项目其他信息</th></tr>
		    <tr>
		      <td style="text-align: right;">获得的科研经费：</td>
		      <td style="text-align: center;">
		          <input name="scientificFund" type="text" value="${resultMap.scientificFund}" class="validate[custom[number]] inputText" style="width: 90%" />
		      </td>
		      <td style="text-align: right;">中级技术职称及以上人员科研经费平均数：</td>
		      <td style="text-align: center;">
		         <input name="fundAvg" type="text" value="${resultMap.fundAvg}" class="inputText" style="width: 90%" />
		      </td>
		    </tr>
		     <tr>
		      <td style="text-align: right;">设立的开放性课题数：</td>
		      <td style="text-align: center;">
		         <input name="openCount" type="text" value="${resultMap.openCount}" class="inputText" style="width: 90%" />
		      </td>
		      <td style="text-align: right;">开放性课题经费：</td>
		      <td style="text-align: center;">
		         <input name="openFund" type="text" value="${resultMap.openFund}" class="validate[custom[number]] inputText" style="width: 90%" />
		      </td>
		    </tr>
		  </table>
		</form>
    <div class="button" style="width: 100%; <c:if test="${param.view == GlobalConstant.FLAG_Y}">display:none</c:if>">
	   <a href="javascript:void(0)" target="_self" class="search" onclick="nextOpt('step2')">上一步</a>
	   <a href="javascript:void(0)" target="_self" class="search" onclick="nextOpt('step4')">下一步</a>
    </div>
    <div style="display: none;">
      <!-- 本中心已完成科技项目模板 -->
       <table id="finishTechTemplate" width="100%" class="bs_tb" style="margin-top: 10px;">
           <tr>
		      <td width="50px" style="text-align: center;"><input name="finishTechIds" type="checkbox"/></td>
              <td width="50px" style="text-align: center;" class="finishTechSerial"></td>
		      <td>
		         <input type="text" name="finishTech_code" class="inputText" style="width: 90%" value="${finishTech.finishTech_code}"/>
		      </td>
		      <td>
		         <input type="text" name="finishTech_name" class="inputText" style="width: 90%" value="${finishTech.finishTech_name}"/>
		      </td>
		      <td>
		         <select name="finishTech_source"  class="inputText" style="width: 90%" onchange="finishTechStatistics()">
			 		<option value="">请选择</option>
			 		<option value="GJJ">国家级</option>
			 		<option value="SBJ">省部级</option>
			 		<option value="WST">卫生厅</option>
			 		<option value="SJJ">市局级</option>
			 		<option value="QSYDWWT">企事业单位委托</option>
			 		<option value="ZWHZ">中外合作</option>
			 		<option value="GJZZ">国际组织</option>
			 		<option value="QT">其他</option>
			 	</select>
		      </td>
		      <td>
		         <input type="text" name="finishTech_startTime" class="inputText" style="width: 40%" value="${finishTech.finishTech_startTime}" onClick="WdatePicker({dateFmt:'yyyy-MM-dd'})" readonly="readonly"/>
		         ~<input type="text" name="finishTech_endTime" class="inputText" style="width: 40%" value="${finishTech.finishTech_endTime}" onClick="WdatePicker({dateFmt:'yyyy-MM-dd'})" readonly="readonly"/>
		      </td>
		      <td>
		         <input type="text" name="finishTech_fund" class="validate[custom[number]] inputText" style="width: 90%" value="${finishTech.finishTech_fund}" onchange="finishTechStatistics()"/>
		      </td>
		      <td>
		         <input type="text" name="finishTech_principalName" class="inputText" style="width: 90%" value="${finishTech.finishTech_principalName}"/>
		      </td>
		      <td>
		        <select name="finishTech_principalPost" class="inputText" style="width: 90%">
		        	   <option value="">请选择</option>
					   <c:forEach items="${dictTypeEnumUserTitleList}" var="dict">
		        	   <option value="${dict.dictId}">${dict.dictName}</option>
		        	   </c:forEach>
			     </select>
		      </td>
		    </tr>
       </table>
      <!-- 本中心正在承担科技项目模板 --> 
       <table id="ingTechTemplate" width="100%" class="bs_tb" style="margin-top: 10px;">
           <tr>
		      <td width="50px" style="text-align: center;"><input name="ingTechIds" type="checkbox"/></td>
              <td width="50px" style="text-align: center;" class="ingTechSerial"></td>
		      <td>
		         <input type="text" name="ingTech_code" class="inputText" style="width: 90%" />
		      </td>
		      <td>
		         <input type="text" name="ingTech_name" class="inputText" style="width: 90%" />
		      </td>
		      <td>
		         <select name="ingTech_source"  class="inputText" style="width: 90%" onchange="ingTechStatistics()">
			 		<option value="">请选择</option>
			 		<option value="GJJ">国家级</option>
			 		<option value="SBJ">省部级</option>
			 		<option value="WST">卫生厅</option>
			 		<option value="SJJ">市局级</option>
			 		<option value="QSYDWWT">企事业单位委托</option>
			 		<option value="ZWHZ">中外合作</option>
			 		<option value="GJZZ">国际组织</option>
			 		<option value="QT">其他</option>
			 	</select>
		      </td>
		      <td>
		         <input type="text" name="ingTech_startTime" class="inputText" style="width: 40%" readonly="readonly" onClick="WdatePicker({dateFmt:'yyyy-MM-dd'})"/>
		         ~<input type="text" name="ingTech_endTime" class="inputText" style="width: 40%" onClick="WdatePicker({dateFmt:'yyyy-MM-dd'})" readonly="readonly"/>
		      </td>
		      <td>
		         <input type="text" name="ingTech_fund" class="validate[custom[number]] inputText" style="width: 90%" onchange="ingTechStatistics()"/>
		      </td>
		      <td>
		         <input type="text" name="ingTech_principalName" class="inputText" style="width: 90%" />
		      </td>
		      <td>
		         <select name="ingTech_principalPost" class="inputText" style="width: 90%">
		         	   <option value="">请选择</option>
					   <c:forEach items="${dictTypeEnumUserTitleList}" var="dict">
		        	   <option value="${dict.dictId}" >${dict.dictName}</option>
		        	   </c:forEach>
			     </select>
		      </td>
		    </tr>
       </table>
    </div>

		