<jsp:include page="/jsp/jsres/htmlhead-jsres.jsp">
	<jsp:param name="basic" value="true"/>
	<jsp:param name="jbox" value="true"/>
	<jsp:param name="font" value="true"/>
</jsp:include>
<script type="text/javascript">
$(document).ready(function(){
		for(var i=1;i<3;i++){
			for(var j=1;j<5;j++){
				calculate(i,"td"+j);
			}
		}
		for(var i=5;i<7; i++){
			calculate(2,"td"+i);
		}
		$("#cw").text(parseInt($("#td11").text())+parseInt($("#td12").text()));
		$("#mz").text(parseInt($("#td21").text())+parseInt($("#td22").text()));
		$("#cy").text(parseInt($("#td31").text())+parseInt($("#td32").text()));
		$("#dj").text(parseInt($("#td41").text())+parseInt($("#td42").text()));
});

function  calculate(tableName,className){
	var sum = 0;
	$("#table"+tableName+" ." + className).each(function(){
		 var val = $(this).text();
		 if (val == null || val == undefined || val == '' || isNaN(val)){
				val = 0;
			}
		 sum +=  parseFloat(val); 
	  });
	$("#"+className+tableName).text(parseFloat(sum.toFixed(3)) );
}
function auditStatus(baseFlow,status){
	var s="通过";
	if(status=='${GlobalConstant.FLAG_N}'){
		s="不通过";
	}
	jboxConfirm("确认"+s+"？",function(){
		var data={
				"baseFlow":baseFlow,
				"status":status
			};
		jboxPost("<s:url value='/jsres/base/baseAudit'/>" , data , function(resp){
			if("${GlobalConstant.OPRE_SUCCESSED}"==resp){
				setTimeout(function(){
					window.parent.auditHospitals();
					loadInfo('${GlobalConstant.TEACH_CONDITION}','${param.baseFlow}');
				},1000);
			}
		} , null , true);
	});
}
</script>
</head>
<body>
	<div class="infoAudit"  <c:if test="${param.openType != 'open'}">style="height: auto;"</c:if>>
	    <div class="div_table">
		  <h4>教学条件（门诊科室设置情况，截止上年度）</h4>
		   <table border="0" cellspacing="0" cellpadding="0" class="base_info" >
		   <colgroup>
		     <col width="20%"/>
		     <col width="30%"/>
		     <col width="20%"/>
		     <col width="30%"/>
		   </colgroup>
		   <tbody>
		      <tr>
		       <th>年门诊量：</th>
		       <td>${educationInfo.yearMzCount}万人次</td>
		       <th>年急诊量：</th>
		       <td>${educationInfo.yearJzCount}万人次</td>
		     </tr>
		     <tr>
		       <th>编制总床位数：<br/>(等于各科室床位数之和)</th>
		       <td>${educationInfo.bzBedCount}张</td>
		       <th>实际开放床位数：</th>
		       <td>${educationInfo.sjBedCount}张</td>
		     </tr>
		     <tr>
		       <th>年出院病人数：</th>
		       <td>${educationInfo.yearCybrCount}万人次</td>
		       <th>年手术量：</th>
		       <td>${educationInfo.yearSjCount}台次</td>
		     </tr>
		     <tr>
		       <th>四级手术室：<br/>(四级手术台次/年手术台次)</th>
		       <td>${educationInfo.sjOperationRoom }%</td>
		       <th>教学总面积：<br/>(含教室、示教室、教学诊室)</th>
		       <td>${educationInfo.educationArea }平方米</td>
		     </tr>
		     <tr>
		       <th>独立手术室间数：<br/></th>
		       <td>${educationInfo.dlshcount}间</td>
		       <th>手术室总面积：</th>
		       <td>${educationInfo.shsArea}平方米</td>
		     </tr>
		     <tr>
		       <th>图书馆藏书总量：<br/></th>
		       <td>${educationInfo.libBookCount}种</td>
		       <th>藏书数量：</th>
		       <td>${educationInfo.bookCount}册</td>
		     </tr>
		     <tr>
		       <th>获得临床基地师资培训合格证<br/>(全科医师基地填写)：</th>
		       <td colspan="3">${ educationInfo.lcjdszpxCount}人</td>
		     </tr>
		   </tbody>
		   </table>
		   <table border="0" cellpadding="0" cellspacing="0" class="grid" id="table1" style="border-top-style: none;">
		    <colgroup>
		      <col width="20%"/>
		      <col width="20%"/>
		      <col width="20%"/>
		      <col width="20%"/>
		      <col width="20%"/>
		    </colgroup>
		      <tr>
		        <th>科室名称</th>
		        <th>床位数</th>
		        <th>年门诊量</th>
		        <th>年出院病人数</th>
		        <th>带教师资数</th>
		      </tr>
		      <tr>
		        <td colspan="5" style="text-align:left;">1、内科（为以下8个三级培训专业之和，床位数、年门诊量、年出院病人数、带教师资数（基本条件是3主治及以上医师））</td>
		      </tr>
		      <tr>
		        <td style="text-align:left;">&#12288;（1）心血管内科</td>
		        <td class="td1">${educationInfo.xxgInBedCount }</td>
		        <td class="td2">${ educationInfo.xxgInyearMzCount}</td>
		        <td class="td3">${educationInfo.xxgInyearCybrCount }</td>
		        <td class="td4">${ educationInfo.xxgInTeacherCount}</td>
		      </tr>
		      <tr>
		        <td style="text-align:left;">&#12288;（2）呼吸内科</td>
		        <td class="td1">${educationInfo.hxInBedCount }</td>
		        <td class="td2">${educationInfo.hxInyearMzCount }</td>
		        <td class="td3">${educationInfo.hxInyearCybrCount }</td>
		        <td class="td4">${educationInfo.hxInTeacherCount}</td>
		      </tr>
		      <tr>
		        <td style="text-align:left;">&#12288;（3）消化内科</td>
		        <td class="td1">${ educationInfo.xhInBedCount}</td>
		        <td class="td2">${educationInfo.xhInyearMzCount }</td>
		        <td class="td3">${educationInfo.xhInyearCybrCount }</td>
		        <td class="td4">${educationInfo.xhInTeacherCount }</td>
		      </tr>
		      <tr>
		        <td style="text-align:left;">&#12288;（4）血液内科</td>
		        <td class="td1">${ educationInfo.xyInBedCount}</td>
		        <td class="td2">${ educationInfo.xyInBedCount}</td>
		        <td class="td3">${educationInfo.xyInyearCybrCount }</td>
		        <td class="td4">${educationInfo.xyInTeacherCount }</td>
		      </tr>
		      <tr>
		        <td style="text-align:left;">&#12288;（5）内分泌科</td>
		        <td class="td1">${educationInfo.nfmBedCount }</td>
		        <td class="td2">${ educationInfo.nfmyearMzCount}</td>
		        <td class="td3">${educationInfo.nfmyearCybrCount }</td>
		        <td class="td4">${educationInfo.nfmTeacherCount }</td>
		      </tr>
		      <tr>
		        <td style="text-align:left;">&#12288;（6）肾脏内科</td>
		        <td class="td1">${educationInfo.szInBedCount }</td>
		        <td class="td2">${educationInfo.szInyearMzCount }</td>
		        <td class="td3">${ educationInfo.szInyearCybrCount}</td>
		        <td class="td4">${ educationInfo.szInTeacherCount}</td>
		      </tr>
		      <tr>
		        <td style="text-align:left;">&#12288;（7）风湿免疫科</td>
		        <td class="td1">${ educationInfo.fsmyBedCount}</td>
		        <td  class="td2">${educationInfo.fsmyyearMzCount }</td>
		        <td class="td3">${educationInfo.fsmyyearCybrCount }</td>
		        <td class="td4">${educationInfo.fsmyTeacherCount }</td>
		      </tr>
		      <tr>
		        <td style="text-align:left;">&#12288;（8）感染科</td>
		        <td class="td1">${ educationInfo.grBedCount}</td>
		        <td class="td2">${educationInfo.gryearMzCount }</td>
		        <td class="td3">${educationInfo.gryearCybrCount }</td>
		        <td class="td4">${ educationInfo.grTeacherCount}</td>
		      </tr>
		      <tr>
		        <td style="text-align:left;">&#12288;（9）其它</td>
		        <td class="td1">${ educationInfo.otherInBedCount}</td>
		        <td class="td2">${ educationInfo.otherInyearMzCount}</td>
		        <td class="td3">${educationInfo.otherInyearCybrCount }</td>
		        <td class="td4">${educationInfo.otherInTeacherCount }</td>
		      </tr>
		      <tr>
		        <td style="text-align:left;">&#12288;&#12288;合计</td>
		        <td id ="td11"></td>
		        <td id="td21"></td>
		        <td id="td31"></td>
		        <td id="td41"></td>
		      </tr>
		      </table>
		    <table border="0" cellpadding="0" cellspacing="0" class="grid" id="table2" style="border-top-style: none;">
		     <colgroup>
		      <col width="20%"/>
		      <col width="20%"/>
		      <col width="20%"/>
		      <col width="20%"/>
		      <col width="20%"/>
		    </colgroup>
		       <tr>
		        <td style="text-align:left;">3.妇产科</td>
		        <td class="td1">${educationInfo.fcDeptBedCount }</td>
		        <td class="td2">${educationInfo.fcDeptyearMzCount }</td>
		        <td class="td3">${educationInfo.fcDeptyearCybrCount }</td>
		        <td class="td4">${educationInfo.fcDeptTeacherCount }</td>
		      </tr>
		      <tr>
		        <td style="text-align:left;">4.儿科</td>
		        <td class="td1">${educationInfo.childBedCount}</td>
		        <td class="td2">${educationInfo.childyearMzCount }</td>
		        <td class="td3">${educationInfo.childyearCybrCount}</td>
		        <td  class="td4">${educationInfo.childTeacherCount}</td>
		      </tr>
		       <tr>
		        <td style="text-align:left;">5.急诊科</td>
		        <td class="td1">${educationInfo.jzDeptBedCount }</td>
		        <td class="td2">${educationInfo.jzDeptyearMzCount }</td>
		        <td class="td3">${educationInfo.jzDeptyearCybrCount}</td>
		        <td  class="td4">${educationInfo.jzDeptTeacherCount }</td>
		      </tr>
		       <tr>
		        <td style="text-align:left;">6.神经内科</td>
		        <td  class="td1">${educationInfo.sjInBedCount}</td>
		        <td class="td2">${educationInfo.sjInyearMzCount }</td>
		        <td class="td3">${educationInfo.sjInyearCybrCount }</td>
		        <td class="td4">${educationInfo.sjInTeacherCount }</td>
		      </tr>
		       <tr>
		        <td style="text-align:left;">7.皮肤性病科</td>
		        <td class="td1">${educationInfo.pfbBedCount }</td>
		        <td class="td2">${educationInfo.pfbyearMzCount }</td>
		        <td class="td3">${educationInfo.pfbyearCybrCount}</td>
		        <td class="td4">${educationInfo.pfbTeacherCount }</td>
		      </tr>
		       <tr>
		        <td style="text-align:left;">8.眼科</td>
		        <td class="td1">${educationInfo.eyeDeptBedCount}</td>
		        <td class="td2">${educationInfo.eyeDeptyearMzCount}</td>
		        <td class="td3">${educationInfo.eyeDeptyearCybrCount}</td>
		        <td class="td4">${educationInfo.eyeDeptTeacherCount}</td>
		      </tr>
		       <tr>
		        <td style="text-align:left;">9.耳鼻咽喉科</td>
		        <td class="td1">${educationInfo.ebhkBedCount }</td>
		        <td class="td2">${educationInfo.ebhkyearMzCount }</td>
		        <td class="td3">${educationInfo.ebhkyearCybrCount}</td>
		        <td class="td4">${educationInfo.ebhkTeacherCount }</td>
		      </tr>
		       <tr>
		        <td style="text-align:left;">10.精神科</td>
		        <td class="td1">${educationInfo.jskBedCount}</td>
		        <td class="td2">${educationInfo.jskyearMzCount }</td>
		        <td class="td3">${educationInfo.jskyearCybrCount }</td>
		        <td class="td4">${educationInfo.jskTeacherCount}</td>
		      </tr>
		       <tr>
		        <td style="text-align:left;">11.儿外科</td>
		        <td class="td1">${educationInfo.ewkBedCount}</td>
		        <td class="td2">${educationInfo.ewkyearMzCount}</td>
		        <td class="td3">${educationInfo.ewkyearCybrCount}</td>
		        <td class="td4">${educationInfo.ewkTeacherCount}</td>
		      </tr>
		       <tr>
		        <td style="text-align:left;">12.康复医学科</td>
		        <td class="td1">${educationInfo.kfyxkBedCount}</td>
		        <td class="td2">${educationInfo.kfyxkyearMzCount}</td>
		        <td class="td3">${educationInfo.kfyxkyearCybrCount}</td>
		        <td class="td4">${educationInfo.kfyxkTeacherCount}</td>
		      </tr>
		      <tr>
		        <td style="text-align:left;">13.麻醉科</td>
		        <td colspan="2">年手术台数：&nbsp;&nbsp;${educationInfo.mzkYearSjCount }</td>
		        <td colspan="2">带教师资数：&nbsp;&nbsp;${educationInfo.mzkTeacherCount}</td>
		      </tr>
		      <tr style="display: none;">
		        <th style="text-align:left;">合计</th>
		        <th id ="td12"></th>
		        <th id="td22"></th>
		        <th id="td32"></th>
		        <th id="td42"></th>
		      </tr>
		      <tr>
		        <td colspan="5" style="text-align:left;">14、医学影像科（为放射、超声、核医学总和，年检查人数、带教师资数）</td>
		      </tr>
		      <tr>
		        <td style="text-align:left;">&#12288;（1）放射科</td>
		        <td colspan="2" >年检查人数：&nbsp;&nbsp;<label class="td5">${educationInfo.fskYearSjCount }</label></td>
		        <td colspan="2" class="td4">带教师资数：&nbsp;&nbsp;<label class="td6">${ educationInfo.fskTeacherCount}</label></td>
		      </tr>
		      <tr>
		        <td style="text-align:left;">&#12288;（2）超声诊断科</td>
		        <td colspan="2" >年检查人数：&nbsp;&nbsp;<label class="td5">${ educationInfo.cszdkYearSjCount}</label></td>
		        <td colspan="2"  class="td4">带教师资数：&nbsp;&nbsp;<label class="td6">${educationInfo.cszdkTeacherCount }</label></td>
		      </tr>
		      <tr>
		        <td style="text-align:left;">&#12288;（3）核医学科</td>
		        <td colspan="2" >年检查人数：&nbsp;&nbsp;<label class="td5">${ educationInfo.hyxkYearSjCount}</label></td>
		        <td colspan="2" >带教师资数：&nbsp;&nbsp;<label class="td6">${educationInfo.hyxkTeacherCount }</label></td>
		      </tr>
		      <tr>
		        <td style="text-align:left;">&#12288;（4）其它</td>
		        <td colspan="2" >年检查人数：&nbsp;&nbsp;<label class="td5">${educationInfo.otherYearSjCount }</label></td>
		        <td colspan="2" class="td4" >带教师资数：&nbsp;&nbsp;<label class="td6">${ educationInfo.otherTeacherCount}</label></td>
		      </tr>
		      <tr>
		        <td style="text-align:left;">&#12288;&#12288;合计</td>
		        <td colspan="2" id="td52" style="padding-left: 13%"></td>
		        <td colspan="2" id="td62" style="padding-left: 13%"></td>
		      </tr>
		      <tr>
		        <td style="text-align:left;">15.医学检验科</td>
		        <td colspan="2">年检查人数：&nbsp;&nbsp;${ educationInfo.yxjyYearSjCount}</td>
		        <td colspan="2" class="td4">带教师资数：&nbsp;&nbsp;${educationInfo.yxjyTeacherCount }</td>
		      </tr>
		      <tr>
		        <td style="text-align:left;">16.病理科</td>
		        <td colspan="2">年检查人数：&nbsp;&nbsp;${ educationInfo.blkYearSjCount}</td>
		        <td colspan="2" class="td4">带教师资数：&nbsp;&nbsp;${ educationInfo.blkTeacherCount}</td>
		      </tr>
		       <tr>
		        <td style="text-align:left;">17.口腔科</td>
		        <td class="td1">${educationInfo.kqkBedCount }</td>
		        <td class="td2">${educationInfo.kqkyearMzCount }</td>
		        <td class="td3">${educationInfo.kqkyearCybrCount }</td>
		        <td class="td4">${ educationInfo.kqkTeacherCount}</td>
		      </tr>
		      <tr>
		        <td style="text-align:left;">18.全科医学（西医）</td>
		        <td class="td1">${educationInfo.qyxkWestBedCount }</td>
		        <td class="td2">${ educationInfo.qyxkWestyearMzCount}</td>
		        <td class="td3">${educationInfo.qyxkWestyearCybrCount }</td>
		        <td class="td4">${educationInfo.qyxkWestTeacherCount }</td>
		      </tr>
		      <tr>
		        <td style="text-align:left;">19.全科医学（中医）</td>
		        <td class="td1">${ educationInfo.qyxkChinaBedCount}</td>
		        <td class="td2">${educationInfo.qyxkChinayearMzCount }</td>
		        <td class="td3">${ educationInfo.qyxkChinayearCybrCount}</td>
		        <td class="td4">${educationInfo.qyxkChinaTeacherCount }</td>
		      </tr>
		      <tr>
		        <th style="text-align:left;">总计：</th>
		        <th>总床位数：<label id="cw"></label></th>
		        <th>总年门诊量：<label id="mz"></label></th>
		        <th>总年出院病人数：<label id="cy"></label></th>
		        <th>总带教师资数：<label id="dj"></label></th>
		      </tr>
		      <tr>
		        <td style="text-align:left;" colspan="5">医学信息检索条件（请具体说明）：</td>
		      </tr>
		      <tr>
		        <td style="text-align:left;" colspan="5">${educationInfo.yxInfoSearch} 
		        </td>
		      </tr>
		  </table> 
		</div>
		<div class="btn_info">
		 	<jsp:include page='/jsp/jsres/province/hospital/passBtn.jsp'/>
	    </div>
		
	</div>
</body>
</html>