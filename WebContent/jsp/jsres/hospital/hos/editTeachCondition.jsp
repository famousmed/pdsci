<jsp:include page="/jsp/jsres/htmlhead-jsres.jsp">
	<jsp:param name="basic" value="true"/>
	<jsp:param name="jbox" value="true"/>
	<jsp:param name="font" value="true"/>
    <jsp:param name="jquery_validation" value="true"/>
</jsp:include>
<script type="text/javascript">
function saveEducationInfo(){
	if(false==$("#baseInfoForm").validationEngine("validate")){
		return false;
	}
	jboxPost("<s:url value='/jsres/base/saveBase'/>" , $("#baseInfoForm").serialize() , function(resp){
		if("${GlobalConstant.SAVE_SUCCESSED}" == resp){
			setTimeout(function(){
				$("#submitBtn").show();
				loadInfo('${GlobalConstant.TEACH_CONDITION}','${sessionScope.currUser.orgFlow}');
			},1000);
		}
	} , null , true);
}
$(document).ready(function(){
	for(var i=1;i<3;i++){
		for(var j=1;j<5;j++){
			calculate(i,"td"+j);
		}
	}
	for(var i=5;i<7;i++ ){
		calculate(2,"td"+i);
	}
	$("#cw").text(parseInt($("#td11").text())+parseInt($("#td12").text()));
	$("#mz").text(parseInt($("#td21").text())+parseInt($("#td22").text()));
	$("#cy").text(parseInt($("#td31").text())+parseInt($("#td32").text()));
	$("#dj").text(parseInt($("#td41").text())+parseInt($("#td42").text())+parseInt($("#td62").text()));
});

function  calculate(tableName,className){
var sum = 0;
$("#table"+tableName+" ." + className).each(function(){
	 var val = $(this).val();
	 if (val == null || val == undefined || val == '' || isNaN(val)){
			val = 0;
		}
	 sum +=  parseFloat(val); 
  });
$("#"+className+tableName).text(parseFloat(sum.toFixed(3)));
$("#cw").text(parseInt($("#td11").text())+parseInt($("#td12").text()));
$("#mz").text(parseInt($("#td21").text())+parseInt($("#td22").text()));
$("#cy").text(parseInt($("#td31").text())+parseInt($("#td32").text()));
$("#dj").text(parseInt($("#td41").text())+parseInt($("#td42").text())+parseInt($("#td62").text()))
}
</script>
<style>
	input{width: 68px;}
</style>

 <form id='baseInfoForm' style="position:relative;">
 	<input type="hidden" name="sysOrg.orgFlow" value="${empty sysOrg.orgFlow?sessionScope.currUser.orgFlow:sysOrg.orgFlow}"/>
	<input type="hidden" name="flag" value="${GlobalConstant.TEACH_CONDITION}"/>
	<div class="main_bd">
		<div class="div_table">
		  <h4>教学条件（门诊科室设置情况，截止上年度）</h4>
		   <table border="0" cellspacing="0" cellpadding="0" class="base_info">
		   <colgroup>
		     <col width="20%"/>
		     <col width="30%"/>
		     <col width="20%"/>
		     <col width="30%"/>
		   </colgroup>
		   <tbody>
		      <tr>
		       <th>年门诊量：</th>
		       <td><input type="text" class="input1 validate[custom[number],min[0],required]" style="width:100px;" name="educationInfo.yearMzCount"value="${educationInfo.yearMzCount}" />&nbsp;万人次<span class="red">*</span></td>
		       <th>年急诊量：</th>
		       <td><input type="text" class="input1 validate[custom[number],min[0],required]" style="width:100px;" name="educationInfo.yearJzCount"value="${educationInfo.yearJzCount}"/>&nbsp;万人次<span class="red">*</span></td>
		     </tr>
		     <tr>
		       <th>编制总床位数：<br/>(等于各科室床位数之和)</th>
		       <td><input type="text" class="input1 validate[custom[integer],min[0],required]"  style="width:100px;"   name="educationInfo.bzBedCount"  value="${educationInfo.bzBedCount}"/>&nbsp;张<span class="red">*</span></td>
		       <th>实际开放床位数：</th>
		       <td><input type="text" class="input1 validate[custom[integer],min[0],required]"  style="width:100px;"  name="educationInfo.sjBedCount" value="${educationInfo.sjBedCount }"/>&nbsp;张<span class="red">*</span></td>
		     </tr>
		     <tr>
		       <th>年出院病人数：</th>
		       <td><input type="text" class="input1 validate[custom[number],min[0],required]" style="width:100px;" name="educationInfo.yearCybrCount" value="${ educationInfo.yearCybrCount}"/>&nbsp;万人次<span class="red">*</span></td>
		       <th>年手术量：</th>
		       <td><input type="text" class="input1 validate[custom[integer],min[0],required]"  style="width:100px;" name="educationInfo.yearSjCount" value="${ educationInfo.yearSjCount}"/>&nbsp;台次<span class="red">*</span></td>
		     </tr>
		     <tr>
		       <th>四级手术室：<br/>(四级手术台次/年手术台次)</th>
		       <td><input type="text" class="input1 validate[custom[number].min[0],max[100]]" style="width:100px;" name="educationInfo.sjOperationRoom"  value="${educationInfo.sjOperationRoom}"/>&nbsp;%<span class="red">*</span></td>
		       <th>教学总面积：<br/>(含教室、示教室、教学诊室)</th>
		       <td><input type="text" class="input1 validate[custom[number],min[0],required]" style="width:100px;"name="educationInfo.educationArea"  value="${educationInfo.educationArea }"/>&nbsp;平方米<span class="red">*</span></td>
		     </tr>
		     <tr>
		       <th>独立手术室间数：<br/></th>
		       <td><input type="text" class="input1 validate[custom[integer],min[0],required]" style="width:100px;" name="educationInfo.dlshcount" value="${ educationInfo.dlshcount}"/>&nbsp;间<span class="red">*</span></td>
		       <th>手术室总面积：</th>
		       <td><input type="text" class="input1 validate[custom[number],min[0],required]"  style="width:100px;" name="educationInfo.shsArea" value="${ educationInfo.shsArea}"/>&nbsp;平方米<span class="red">*</span></td>
		     </tr>
		     <tr>
		       <th>图书馆藏书总量：<br/></th>
		       <td><input type="text" class="input1 validate[custom[integer],min[0],required]" style="width:100px;" name="educationInfo.libBookCount"value="${educationInfo.libBookCount}"/>&nbsp;种<span class="red">*</span></td>
		       <th>藏书数量：</th>
		       <td><input type="text" class="input1 validate[custom[integer],min[0],required]"  style="width:100px;" name="educationInfo.bookCount"value="${educationInfo.bookCount}"/>&nbsp;册<span class="red">*</span></td>
		     </tr>
		     <tr>
		       <th>获得临床基地师资培训合格证<br/>(全科医师基地填写)：</th>
		       <td colspan="3"><input type="text" class="input1 validate[custom[integer],min[0],required]" style="width:100px;"name="educationInfo.lcjdszpxCount"value="${educationInfo.lcjdszpxCount}"/>&nbsp;人<span class="red">*</span></td>
		     </tr>
		   </tbody>
		   </table>
		   <table border="0" cellpadding="0" cellspacing="0" class="grid" id="table1" style="border-top-style: none;" >
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
		        <td colspan="5" style="text-align:left;padding-left:5px;">1、内科（为以下8个三级培训专业之和，床位数、年门诊量、年出院病人数、带教师资数（基本条件是3主治及以上医师））</td>
		      </tr>
		      <tr>
		        <td style="text-align:left;">&#12288;（1）心血管内科</td>
		        <td><input type="text" class="td1 input1 validate[custom[integer],min[0]]"name="educationInfo.xxgInBedCount"value="${educationInfo.xxgInBedCount}"   onchange="calculate('1','td1');"/></td>
		        <td><input type="text"  class="td2  input1 validate[custom[integer],min[0]]"  name="educationInfo.xxgInyearMzCount"value="${educationInfo.xxgInyearMzCount}" onchange="calculate('1','td2');"/></td>
		        <td><input type="text"  class="td3  input1 validate[custom[integer],min[0]]" name="educationInfo.xxgInyearCybrCount"value="${educationInfo.xxgInyearCybrCount}" onchange="calculate('1','td3');"/></td>
		        <td><input type="text"  class="td4  input1 validate[custom[integer],min[0]]" name="educationInfo.xxgInTeacherCount"value="${educationInfo.xxgInTeacherCount}" onchange="calculate('1','td4');"/></td>
		      </tr>
		      <tr>
		        <td style="text-align:left;">&#12288;（2）呼吸内科</td>
		        <td><input type="text"  class="td1  input1 validate[custom[integer],min[0]]" name="educationInfo.hxInBedCount"value="${educationInfo.hxInBedCount}" onchange="calculate('1','td1');"/></td>
		        <td><input type="text"  class="td2  input1 validate[custom[integer],min[0]]" name="educationInfo.hxInyearMzCount"value="${educationInfo.hxInyearMzCount}"onchange="calculate('1','td2');"/></td>
		        <td><input type="text"  class="td3  input1 validate[custom[integer],min[0]]" name="educationInfo.hxInyearCybrCount"value="${educationInfo.hxInyearCybrCount}"onchange="calculate('1','td3');"/></td>
		        <td><input type="text" class="td4  input1 validate[custom[integer],min[0]]" name="educationInfo.hxInTeacherCount"value="${educationInfo.hxInTeacherCount}" onchange="calculate('1','td4');"/></td>
		      </tr>
		      <tr>
		        <td style="text-align:left;">&#12288;（3）消化内科</td>
		        <td><input type="text"  class="td1  input1 validate[custom[integer],min[0]]" name="educationInfo.xhInBedCount"value="${educationInfo.xhInBedCount}" onchange="calculate('1','td1');"/></td>
		        <td><input type="text"  class="td2  input1 validate[custom[integer],min[0]]" name="educationInfo.xhInyearMzCount"value="${educationInfo.xhInyearMzCount}" onchange="calculate('1','td2');"/></td>
		        <td><input type="text"  class="td3  input1 validate[custom[integer],min[0]]" name="educationInfo.xhInyearCybrCount"value="${educationInfo.xhInyearCybrCount}" onchange="calculate('1','td3');"/></td>
		        <td><input type="text"  class="td4  input1 validate[custom[integer],min[0]]" name="educationInfo.xhInTeacherCount"value="${educationInfo.xhInTeacherCount}" onchange="calculate('1','td4');"/></td>
		      </tr>
		      <tr>
		        <td style="text-align:left;">&#12288;（4）血液内科</td>
		        <td><input type="text"  class="td1  input1 validate[custom[integer],min[0]]" name="educationInfo.xyInBedCount"value="${educationInfo.xyInBedCount}" onchange="calculate('1','td1');"/></td>
		        <td><input type="text"  class="td2  input1 validate[custom[integer],min[0]]" name="educationInfo.xyInyearMzCount"value="${educationInfo.xyInyearMzCount}" onchange="calculate('1','td2');"/></td>
		        <td><input type="text"  class="td3  input1 validate[custom[integer],min[0]]" name="educationInfo.xyInyearCybrCount"value="${educationInfo.xyInyearCybrCount}" onchange="calculate('1','td3');"/></td>
		        <td><input type="text"  class="td4  input1 validate[custom[integer],min[0]]" name="educationInfo.xyInTeacherCount"value="${educationInfo.xyInTeacherCount}" onchange="calculate('1','td4');"/></td>
		      </tr>
		      <tr>
		        <td style="text-align:left;">&#12288;（5）内分泌科</td>
		        <td><input type="text"  class="td1  input1 validate[custom[integer],min[0]]"  name="educationInfo.nfmBedCount"value="${educationInfo.nfmBedCount}" onchange="calculate('1','td1');"/></td>
		        <td><input type="text"  class="td2  input1 validate[custom[integer],min[0]]" name="educationInfo.nfmyearMzCount"value="${educationInfo.nfmyearMzCount}" onchange="calculate('1','td2');"/></td>
		        <td><input type="text"  class="td3  input1 validate[custom[integer],min[0]]" name="educationInfo.nfmyearCybrCount"value="${educationInfo.nfmyearCybrCount}" onchange="calculate('1','td3');"/></td>
		        <td><input type="text" class="td4  input1 validate[custom[integer],min[0]]" name="educationInfo.nfmTeacherCount"value="${educationInfo.nfmTeacherCount}" onchange="calculate('1','td4');"/></td>
		      </tr>
		      <tr>
		        <td style="text-align:left;">&#12288;（6）肾脏内科</td>
		        <td><input type="text"  class="td1  input1 validate[custom[integer],min[0]]" name="educationInfo.szInBedCount"value="${educationInfo.szInBedCount}"onchange="calculate('1','td1');"/></td>
		        <td><input type="text"  class="td2  input1 validate[custom[integer],min[0]]"  name="educationInfo.szInyearMzCount"value="${educationInfo.szInyearMzCount}"onchange="calculate('1','td2');"/></td>
		        <td><input type="text"  class="td3  input1 validate[custom[integer],min[0]]" name="educationInfo.szInyearCybrCount"value="${educationInfo.szInyearCybrCount}"onchange="calculate('1','td3');"/></td>
		        <td><input type="text"  class="td4  input1 validate[custom[integer],min[0]]"   name="educationInfo.szInTeacherCount"value="${educationInfo.szInTeacherCount}"onchange="calculate('1','td4');"/></td>
		      </tr>
		      <tr>
		        <td style="text-align:left;">&#12288;（7）风湿免疫科</td>
		        <td><input type="text"  class="td1  input1 validate[custom[integer],min[0]]" name="educationInfo.fsmyBedCount"value="${educationInfo.fsmyBedCount}" onchange="calculate('1','td1');"/></td>
		        <td><input type="text"  class="td2  input1 validate[custom[integer],min[0]]" name="educationInfo.fsmyyearMzCount"value="${educationInfo.fsmyyearMzCount}"onchange="calculate('1','td2');"/></td>
		        <td><input type="text" class="td3  input1 validate[custom[integer],min[0]]" name="educationInfo.fsmyyearCybrCount"value="${educationInfo.fsmyyearCybrCount}" onchange="calculate('1','td3');"/></td>
		        <td><input type="text"  class="td4  input1 validate[custom[integer],min[0]]" name="educationInfo.fsmyTeacherCount"value="${educationInfo.fsmyTeacherCount}" onchange="calculate('1','td4');"/></td>
		      </tr>
		      <tr>
		        <td style="text-align:left;">&#12288;（8）感染科</td>
		        <td><input type="text"  class="td1  input1 validate[custom[integer],min[0]]"name="educationInfo.grBedCount"value="${educationInfo.grBedCount}"onchange="calculate('1','td1');"/></td>
		        <td><input type="text" class="td2  input1 validate[custom[integer],min[0]]" name="educationInfo.gryearMzCount"value="${educationInfo.gryearMzCount}"onchange="calculate('1','td2');"/></td>
		        <td><input type="text"  class="td3  input1 validate[custom[integer],min[0]]" name="educationInfo.gryearCybrCount"value="${educationInfo.gryearCybrCount}"onchange="calculate('1','td3');"/></td>
		        <td><input type="text" class="td4  input1 validate[custom[integer],min[0]]" name="educationInfo.grTeacherCount"value="${educationInfo.grTeacherCount}"onchange="calculate('1','td4');"/></td>
		      </tr>
		      <tr>
		        <td style="text-align:left;">&#12288;（9）其它</td>
		        <td><input type="text"  class="td1  input1 validate[custom[integer],min[0]]" name="educationInfo.otherInBedCount"value="${educationInfo.otherInBedCount}"onchange="calculate('1','td1');"/></td>
		        <td><input type="text"  class="td2 input1 validate[custom[integer],min[0]]" name="educationInfo.otherInyearMzCount"value="${educationInfo.otherInyearMzCount}"onchange="calculate('1','td2');"/></td>
		        <td><input type="text"  class="td3  input1 validate[custom[integer],min[0]]" name="educationInfo.otherInyearCybrCount"value="${educationInfo.otherInyearCybrCount}"onchange="calculate('1','td3');"/></td>
		        <td><input type="text" class="td4  input1 validate[custom[integer],min[0]]" name="educationInfo.otherInTeacherCount"value="${educationInfo.otherInTeacherCount}"onchange="calculate('1','td4');"/></td>
		      </tr>
		      <tr>
		        <td style="text-align:left;">&#12288;&#12288;&#12288;合计</td>
		        <td ><span id="td11" ></span></td>
		        <td><span id="td21"></span></td>
		        <td><span id="td31"></span></td>
		        <td><span id="td41" ></span></td>
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
		        <td style="text-align:left;">2.妇产科</td>
		        <td><input type="text"  class="td1  input1 validate[custom[integer],min[0]]" name="educationInfo.fcDeptBedCount"value="${educationInfo.fcDeptBedCount}" onchange="calculate('2','td1');"   /></td>
		        <td><input type="text"  class="td2  input1 validate[custom[integer],min[0]]" name="educationInfo.fcDeptyearMzCount"value="${educationInfo.fcDeptyearMzCount}"  onchange="calculate('2','td2');"  /></td>
		        <td><input type="text" class="td3 input1 validate[custom[integer],min[0]]" name="educationInfo.fcDeptyearCybrCount"value="${educationInfo.fcDeptyearCybrCount}"  onchange="calculate('2','td3');" /></td>
		        <td><input type="text"  class="td4  input1 validate[custom[integer],min[0]]" name="educationInfo.fcDeptTeacherCount"value="${educationInfo.fcDeptTeacherCount}" onchange="calculate('2','td4');"  /></td>
		      </tr>
		      <tr>
		        <td style="text-align:left;">3.儿科</td>
		        <td><input type="text"  class="td1  input1 validate[custom[integer],min[0]]"  name="educationInfo.childBedCount"value="${educationInfo.childBedCount}" onchange="calculate('2','td1');" /></td>
		        <td><input type="text"  class="td2  input1 validate[custom[integer],min[0]]"  name="educationInfo.childyearMzCount"value="${educationInfo.childyearMzCount}" onchange="calculate('2','td2');" /></td>
		        <td><input type="text"  class="td3  input1 validate[custom[integer],min[0]]"  name="educationInfo.childyearCybrCount"value="${educationInfo.childyearCybrCount}" onchange="calculate('2','td3');" /></td>
		        <td><input type="text"  class="td4 input1 validate[custom[integer],min[0]]"   name="educationInfo.childTeacherCount"value="${educationInfo.childTeacherCount}" onchange="calculate('2','td4');" /></td>
		      </tr>
		       <tr>
		        <td style="text-align:left;">4.急诊科</td>
		        <td><input type="text"  class="td1  input1 validate[custom[integer],min[0]]" name="educationInfo.jzDeptBedCount"value="${educationInfo.jzDeptBedCount}" onchange="calculate('2','td1');" /></td>
		        <td><input type="text"  class="td2 input1 validate[custom[integer],min[0]]" name="educationInfo.jzDeptyearMzCount"value="${educationInfo.jzDeptyearMzCount}" onchange="calculate('2','td2');" /></td>
		        <td><input type="text"  class="td3  input1 validate[custom[integer],min[0]]" name="educationInfo.jzDeptyearCybrCount"value="${educationInfo.jzDeptyearCybrCount}" onchange="calculate('2','td3');" /></td>
		        <td><input type="text" class="td4  input1 validate[custom[integer],min[0]]" name="educationInfo.jzDeptTeacherCount"value="${educationInfo.jzDeptTeacherCount}" onchange="calculate('2','td4');" /></td>
		      </tr>
		       <tr>
		        <td style="text-align:left;">5.神经内科</td>
		        <td><input type="text" class="td1  input1 validate[custom[integer],min[0]]"  name="educationInfo.sjInBedCount"value="${educationInfo.sjInBedCount}" onchange="calculate('2','td1');" /></td>
		        <td><input type="text"  class="td2  input1 validate[custom[integer],min[0]]" name="educationInfo.sjInyearMzCount"value="${educationInfo.sjInyearMzCount}" onchange="calculate('2','td2');" /></td>
		        <td><input type="text"  class="td3 input1 validate[custom[integer],min[0]]" name="educationInfo.sjInyearCybrCount"value="${educationInfo.sjInyearCybrCount}" onchange="calculate('2','td3);" /></td>
		        <td><input type="text"  class="td4  input1 validate[custom[integer],min[0]]" name="educationInfo.sjInTeacherCount"value="${educationInfo.sjInTeacherCount}" onchange="calculate('2','td4');" /></td>
		      </tr>
		       <tr>
		        <td style="text-align:left;">6.皮肤性病科</td>
		        <td><input type="text"  class="td1 input1 validate[custom[integer],min[0]]" name="educationInfo.pfbBedCount"value="${educationInfo.pfbBedCount}" onchange="calculate('2','td1');" /></td>
		        <td><input type="text" class="td2 input1 validate[custom[integer],min[0]]" name="educationInfo.pfbyearMzCount"value="${educationInfo.pfbyearMzCount}" onchange="calculate('2','td2');" /></td>
		        <td><input type="text"  class="td3 input1 validate[custom[integer],min[0]]" name="educationInfo.pfbyearCybrCount"value="${educationInfo.pfbyearCybrCount}" onchange="calculate('2','td3');" /></td>
		        <td><input type="text"  class="td4 input1 validate[custom[integer],min[0]]" name="educationInfo.pfbTeacherCount"value="${educationInfo.pfbTeacherCount}" onchange="calculate('2','td4');" /></td>
		      </tr>
		       <tr>
		        <td style="text-align:left;">7.眼科</td>
		        <td><input type="text" class="td1 input1 validate[custom[integer],min[0]]" name="educationInfo.eyeDeptBedCount"value="${educationInfo.eyeDeptBedCount}" onchange="calculate('2','td1');" /></td>
		        <td><input type="text"  class="td2 input1 validate[custom[integer],min[0]]"  name="educationInfo.eyeDeptyearMzCount"value="${educationInfo.eyeDeptyearMzCount}" onchange="calculate('2','td2');" /></td>
		        <td><input type="text"  class="td3 input1 validate[custom[integer],min[0]]"  name="educationInfo.eyeDeptyearCybrCount"value="${educationInfo.eyeDeptyearCybrCount}" onchange="calculate('2','td3');" /></td>
		        <td><input type="text"  class="td4 input1 validate[custom[integer],min[0]]"  name="educationInfo.eyeDeptTeacherCount"value="${educationInfo.eyeDeptTeacherCount}" onchange="calculate('2','td4');" /></td>
		      </tr>
		       <tr>
		        <td style="text-align:left;">8.耳鼻咽喉科</td>
		        <td><input type="text" class="td1 input1 validate[custom[integer],min[0]]" name="educationInfo.ebhkBedCount"value="${educationInfo.ebhkBedCount}" onchange="calculate('2','td1');" /></td>
		        <td><input type="text"  class="td2 input1 validate[custom[integer],min[0]]" name="educationInfo.ebhkyearMzCount"value="${educationInfo.ebhkyearMzCount}" onchange="calculate('2','td2');" /></td>
		        <td><input type="text"  class="td3 input1 validate[custom[integer],min[0]]" name="educationInfo.ebhkyearCybrCount"value="${educationInfo.ebhkyearCybrCount}" onchange="calculate('2','td3');" /></td>
		        <td><input type="text"  class="td4 input1 validate[custom[integer],min[0]]" name="educationInfo.ebhkTeacherCount"value="${educationInfo.ebhkTeacherCount}" onchange="calculate('2','td4');" /></td>
		      </tr>
		       <tr>
		        <td style="text-align:left;">9.精神科</td>
		        <td><input type="text"  class="td1 input1 validate[custom[integer],min[0]]" name="educationInfo.jskBedCount"value="${educationInfo.jskBedCount}" onchange="calculate('2','td1');" /></td>
		        <td><input type="text"  class="td2 input1 validate[custom[integer],min[0]]" name="educationInfo.jskyearMzCount"value="${educationInfo.jskyearMzCount}" onchange="calculate('2','td2');" /></td>
		        <td><input type="text" class="td3 input1 validate[custom[integer],min[0]]" name="educationInfo.jskyearCybrCount"value="${educationInfo.jskyearCybrCount}" onchange="calculate('2','td3');" /></td>
		        <td><input type="text"  class="td4 input1 validate[custom[integer],min[0]]" name="educationInfo.jskTeacherCount"value="${educationInfo.jskTeacherCount}" onchange="calculate('2','td4');" /></td>
		      </tr>
		       <tr>
		        <td style="text-align:left;">10.儿外科</td>
		        <td><input type="text"  class="td1 input1 validate[custom[integer],min[0]]" name="educationInfo.ewkBedCount"value="${educationInfo.ewkBedCount}" onchange="calculate('2','td1');" /></td>
		        <td><input type="text"  class="td2 input1 validate[custom[integer],min[0]]" name="educationInfo.ewkyearMzCount"value="${educationInfo.ewkyearMzCount}" onchange="calculate('2','td2');" /></td>
		        <td><input type="text"  class="td3 input1 validate[custom[integer],min[0]]" name="educationInfo.ewkyearCybrCount"value="${educationInfo.ewkyearCybrCount}" onchange="calculate('2','td3');" /></td>
		        <td><input type="text"  class="td4 input1 validate[custom[integer],min[0]]"  name="educationInfo.ewkTeacherCount"value="${educationInfo.ewkTeacherCount}" onchange="calculate('2','td4');" /></td>
		      </tr>
		       <tr>
		        <td style="text-align:left;">11.康复医学科</td>
		        <td><input type="text"  class="td1 input1 validate[custom[integer],min[0]]"  name="educationInfo.kfyxkBedCount"value="${educationInfo.kfyxkBedCount}" onchange="calculate('2','td1');" /></td>
		        <td><input type="text"  class="td2 input1 validate[custom[integer],min[0]]"  name="educationInfo.kfyxkyearMzCount"value="${educationInfo.kfyxkyearMzCount}" onchange="calculate('2','td2');" /></td>
		        <td><input type="text" class="td3  input1 validate[custom[integer],min[0]]"  name="educationInfo.kfyxkyearCybrCount"value="${educationInfo.kfyxkyearCybrCount}"onchange="calculate('2','td3');"  /></td>
		        <td><input type="text"  class="td4 input1 validate[custom[integer],min[0]]"  name="educationInfo.kfyxkTeacherCount"value="${educationInfo.kfyxkTeacherCount}" onchange="calculate('2','td4');" /></td>
		      </tr>
		      <tr>
		        <td style="text-align:left;">12.麻醉科</td>
		        <td colspan="2">年手术台数：&nbsp;&nbsp;<input type="text" class="input1 validate[custom[integer],min[0]]" name="educationInfo.mzkYearSjCount"value="${educationInfo.mzkYearSjCount}" /></td>
		        <td colspan="2"   style="text-align: right; padding-right: 6%;" >带教师资数：<input type="text" class=" td4 input1 validate[custom[integer],min[0]]"  name="educationInfo.mzkTeacherCount"value="${educationInfo.mzkTeacherCount}"  onchange="calculate('2','td4');" /></td>
		      </tr>
		      <tr>
		        <td colspan="5" style="text-align:left;padding-left:5px;">13、医学影像科（为放射、超声、核医学总和，年手术台数、带教师资数）</td>
		      </tr>
		      <tr>
		        <td style="text-align:left;">&#12288;（1）放射科</td>
		        <td colspan="2" >年手术台数：&nbsp;&nbsp;<input type="text"  class="td5 input1 validate[custom[integer],min[0]]" name="educationInfo.fskYearSjCount"value="${educationInfo.fskYearSjCount}" onchange="calculate('2','td5');" /></td>
		        <td colspan="2" style="text-align: right; padding-right: 6%;">带教师资数：&nbsp;&nbsp;<input type="text"  class="td6 input1 validate[custom[integer],min[0]]" name="educationInfo.fskTeacherCount"value="${educationInfo.fskTeacherCount}" onchange="calculate('2','td6');" /></td>
		      </tr>
		      <tr>
		        <td style="text-align:left;">&#12288;（2）超声诊断科</td>
		        <td colspan="2">年手术台数：&nbsp;&nbsp;<input type="text"  class="td5 input1 validate[custom[integer],min[0]]"  name="educationInfo.cszdkYearSjCount"value="${educationInfo.cszdkYearSjCount}" onchange="calculate('2','td5');" /></td>
		        <td colspan="2" style="text-align: right; padding-right: 6%;">带教师资数：&nbsp;&nbsp;<input type="text"  class="td6 input1 validate[custom[integer],min[0]]"  name="educationInfo.cszdkTeacherCount"value="${educationInfo.cszdkTeacherCount}"onchange="calculate('2','td6');"  /></td>
		      </tr>
		      <tr>
		        <td style="text-align:left;">&#12288;（3）核医学科</td>
		        <td colspan="2">年手术台数：&nbsp;&nbsp;<input type="text"  class="td5 input1 validate[custom[integer],min[0]]" name="educationInfo.hyxkYearSjCount"value="${educationInfo.hyxkYearSjCount}" onchange="calculate('2','td5');" /></td>
		        <td colspan="2" style="text-align: right; padding-right: 6%;">带教师资数：&nbsp;&nbsp;<input type="text"  class="td6 input1 validate[custom[integer],min[0]]" name="educationInfo.hyxkTeacherCount"value="${educationInfo.hyxkTeacherCount}" onchange="calculate('2','td6');" /></td>
		      </tr>
		      <tr>
		        <td style="text-align:left;">&#12288;（4）其它</td>
		        <td colspan="2">年手术台数：&nbsp;&nbsp;<input type="text"  class="td5 input1 validate[custom[integer],min[0]]" name="educationInfo.otherYearSjCount"value="${educationInfo.otherYearSjCount}" onchange="calculate('2','td5');" /></td>
		        <td colspan="2" style="text-align: right; padding-right: 6%;">带教师资数：&nbsp;&nbsp;<input type="text"  class="td6 input1 validate[custom[integer],min[0]]" name="educationInfo.otherTeacherCount"value="${educationInfo.otherTeacherCount}" onchange="calculate('2','td6');" /></td>
		      </tr>
		      <tr>
		        <td style="text-align:left;">&#12288;&#12288;&#12288;合计</td>
		        <td colspan="2"><span id="td52" style="margin-left: 23%"></span></td>
		        <td colspan="2" ><span id="td62" style="margin-left: 53%"></span>
		      </tr>
		      <tr>
		        <td style="text-align:left;">14.医学检验科</td>
		        <td colspan="2">年手术台数：&nbsp;&nbsp;<input type="text" class="input1 validate[custom[integer],min[0]]" name="educationInfo.yxjyYearSjCount"value="${educationInfo.yxjyYearSjCount}"/></td>
		        <td colspan="2" style="text-align: right; padding-right: 6%;">带教师资数：&nbsp;&nbsp;<input type="text" class=" td4 input1 validate[custom[integer],min[0]]" name="educationInfo.yxjyTeacherCount"value="${educationInfo.yxjyTeacherCount}" onchange="calculate('2','td4');" /></td>
		      </tr>
		      <tr>
		        <td style="text-align:left;">15.病理科</td>
		        <td colspan="2">年手术台数：&nbsp;&nbsp;<input type="text" class="input1 validate[custom[integer],min[0]]" name="educationInfo.blkYearSjCount"value="${educationInfo.blkYearSjCount}" /></td>
		        <td colspan="2" style="text-align: right; padding-right: 6%;">带教师资数：&nbsp;&nbsp;<input type="text" class=" td4 input1 validate[custom[integer],min[0]]" name="educationInfo.blkTeacherCount"value="${educationInfo.blkTeacherCount}" onchange="calculate('2','td4');" /></td>
		      </tr>
		       <tr>
		        <td style="text-align:left;">16.口腔科</td>
		        <td><input type="text" class="td1 input1 validate[custom[integer],min[0]]"  name="educationInfo.kqkBedCount"value="${educationInfo.kqkBedCount}" onchange="calculate('2','td1');" /></td>
		        <td><input type="text" class="td2 input1 validate[custom[integer],min[0]]"  name="educationInfo.kqkyearMzCount"value="${educationInfo.kqkyearMzCount}" onchange="calculate('2','td2');" /></td>
		        <td><input type="text" class="td3 input1 validate[custom[integer],min[0]]"  name="educationInfo.kqkyearCybrCount"value="${educationInfo.kqkyearCybrCount}" onchange="calculate('2','td3');" /></td>
		        <td><input type="text" class="td4 input1 validate[custom[integer],min[0]]"  name="educationInfo.kqkTeacherCount"value="${educationInfo.kqkTeacherCount}" onchange="calculate('2','td4');" /></td>
		      </tr>
		      <tr>
		        <td style="text-align:left;">17.全科医学（西医）</td>
		        <td><input type="text" class="td1 input1 validate[custom[integer],min[0]]" name="educationInfo.qyxkWestBedCount"value="${educationInfo.qyxkWestBedCount}" onchange="calculate('2','td1');" /></td>
		        <td><input type="text" class="td2 input1 validate[custom[integer],min[0]]"  name="educationInfo.qyxkWestyearMzCount"value="${educationInfo.qyxkWestyearMzCount}" onchange="calculate('2','td2');" /></td>
		        <td><input type="text" class="td3 input1 validate[custom[integer],min[0]]"  name="educationInfo.qyxkWestyearCybrCount"value="${educationInfo.qyxkWestyearCybrCount}" onchange="calculate('2','td3');" /></td>
		        <td><input type="text" class="td4 input1 validate[custom[integer],min[0]]"  name="educationInfo.qyxkWestTeacherCount"value="${educationInfo.qyxkWestTeacherCount}" onchange="calculate('2','td4');" /></td>
		      </tr>
		      <tr>
		        <td style="text-align:left;">18.全科医学（中医）</td>
		        <td><input type="text" class="td1 input1 validate[custom[integer],min[0]]"  name="educationInfo.qyxkChinaBedCount"value="${educationInfo.qyxkChinaBedCount}" onchange="calculate('2','td1');" /></td>
		        <td><input type="text" class="td2 input1 validate[custom[integer],min[0]]"  name="educationInfo.qyxkChinayearMzCount"value="${educationInfo.qyxkChinayearMzCount}" onchange="calculate('2','td2');" /></td>
		        <td><input type="text" class="td3 input1 validate[custom[integer],min[0]]"  name="educationInfo.qyxkChinayearCybrCount"value="${educationInfo.qyxkChinayearCybrCount}" onchange="calculate('2','td3');" /></td>
		        <td><input type="text" class="td4 input1 validate[custom[integer],min[0]]"  name="educationInfo.qyxkChinaTeacherCount"value="${educationInfo.qyxkChinaTeacherCount}" onchange="calculate('2','td4');" /></td>
		      </tr>
				 <tr style="display: none;" >
		        <th style="text-align:left;">合计</th>
		        <th ><span id="td12" ></span></th>
		        <th><span id="td22"></span></th>
		        <th><span id="td32"></span></th>
		        <th><span id="td42" ></span></th>
		      </tr>
		      <tr>
		        <th style="text-align:left;">总计：
		        <th>总床位数：<label id="cw"></label></th>
		        <th>总年门诊量：<label id="mz"></label></th>
		        <th>总年出院病人数：<label id="cy"></label></th>
		        <th>总带教师资数：<label id="dj"></label></th>
		      </tr>
		      <tr>
		        <td style="text-align:left;" colspan="5">医学信息检索条件（请具体说明）：</td>
		      </tr>
		      <tr>
		        <td colspan="5"><textarea name="educationInfo.yxInfoSearch" >${educationInfo.yxInfoSearch}</textarea></td>
		      </tr>
		  </table> 
		</div>
	</div>
	<c:if test="${ resBase.baseStatusId eq baseStatusEnumNotSubmit.id  or resBase.baseStatusId eq baseStatusEnumNotPassed.id or empty resBase.baseStatusId  }">
		<div  class="btn_info">
			<input class="btn_blue"  onclick="saveEducationInfo();" type="button" value="保存"/>
		</div>
	</c:if>
</form>