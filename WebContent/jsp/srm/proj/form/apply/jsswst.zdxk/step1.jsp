<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<c:if test="${param.view != GlobalConstant.FLAG_Y}">
<script type="text/javascript">
    var setting = {
		view: {
			dblClickExpand: false,
			showIcon: false,
			showTitle:false,
			selectedMulti:false
		},
		data: {
			simpleData: {
				enable: true
			}
		},
		callback: {
			beforeClick: beforeClick,
			onClick: onClick
		}
	};
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
    function c(obj,n){
    	$(obj).val(n);
    }
    
    function showMenu() {
    	
		var cityObj = $("#proSelect");
		var cityOffset = $("#proSelect").offset();
		$("#menuContent").css({left:cityOffset.left + "px", top:cityOffset.top + cityObj.outerHeight() + "px"}).slideDown("fast");
		$("body").bind("mousedown", onBodyDown);
	}
    function onBodyDown(event) {
    	
		if (!(event.target.id == "menuBtn" || event.target.id == "menuContent" || $(event.target).parents("#menuContent").length>0)) {
			hideMenu();
		}
	}
    function hideMenu() {
    	
		$("#menuContent").fadeOut("fast");
		$("body").unbind("mousedown", onBodyDown);
	}
    function onClick(e, treeId, treeNode) {
    	
		var zTree = $.fn.zTree.getZTreeObj("treeDemo"),
		nodes = zTree.getSelectedNodes(),
		v = "";
		id = "";
		nodes.sort(function compare(a,b){return a.id-b.id;});
		for (var i=0, l=nodes.length; i<l; i++) {
			v += nodes[i].name + ",";
			id += nodes[i].id + ",";
		}
		if (v.length > 0 ) v = v.substring(0, v.length-1);
		if (id.length > 0 ) id = id.substring(0, id.length-1);
		var cityObj = $("#proSelect");
		$("#selectProjId").val(id);
		cityObj.attr("value", v);
	}
    $(document).ready(function(){
    	
		var url = "<s:url value='/sys/subject/getAllDataJson'/>";
		jboxPostJson(url,null,function(data){
	    	if(data){
				zNodes = $.parseJSON(data);
				$.fn.zTree.init($("#treeDemo"), setting, zNodes);
			}
	    },null,false);
	});
    function beforeClick(treeId, treeNode) {
		var check = (treeNode.id!=0);
		if (!check) jboxTip('不能选择根节点');
		return check;
	}
</script>
</c:if>

<style type="text/css">
 .bs_tb tbody td input{text-align: left;margin-left: 10px;}
</style>
  
	<form action="<s:url value='/srm/proj/mine/saveStep'/>" method="post" style="position: relative;"
		id="projForm" style="position:relative;">
		<input type="hidden" id="pageName" name="pageName" value="step1" /> 
		<input type="hidden" id="recFlow" name="recFlow" value="${projRec.recFlow}"/>
		<input type="hidden" id="projFlow" name="projFlow" value="${proj.projFlow}"/>
		<input type="hidden" id="recTypeId" name="recTypeId" value="${param.recTypeId}"/>
		  <div>
		    <font style="font-size: 18px; font-weight:bold; ">一、中心情况</font>
		  </div>
		  <table width="100%" class="basic" style="margin-top: 40px;">
		    <tr><th colspan="8" style="padding-left:15px;text-align:left;">1.基本情况</th></tr>
		    <tr>
		       <td style="text-align: right;">类别：</td>
		       <td>
		          &#12288;<input type="radio" name="subjectInfo" id="subjectInfo_zdxk" <c:if test="${resultMap.subjectInfo eq 'zdxk' }">checked="checked"</c:if>  onclick="c(this,'zdxk')"/><label for="subjectInfo_zdxk">重点学科</label>
		          &#12288;<input type="radio" name="subjectInfo" id="subjectInfo_lcyxzx" <c:if test="${resultMap.subjectInfo eq 'lcyxzx' }">checked="checked"</c:if>  onclick="c(this,'lcyxzx')"/><label for="subjectInfo_lcyxzx">临床医学中心</label>
		       </td>
		       <td style="text-align: right;">中心名称：</td>
		       <td>
		          <input type="text" name="centerName" class="inputText" value="${resultMap.centerName }"/>
		       </td>
		       <td style="text-align: right;">电话：</td>
		       <td>
		          <input type="text" name="phone" class="inputText validate[custom[number]]" value="${resultMap.phone }"/>
		       </td>
		       <td style="text-align: right;">单位名称：</td>
		       <td>
		          <input type="text" name="orgName" class="inputText" value="${resultMap.orgName }"/>
		       </td>
		    </tr>
		    <tr>
		       <td style="text-align: right;">主管部门：</td>
		       <td>
		          <input type="text" name="chargeOrgName" class="inputText" value="${resultMap.chargeOrgName }"/>
		       </td>
		       <td style="text-align: right;">隶属关系：</td>
		       <td>
		          <input type="text" name="subordinate" class="inputText" value="${resultMap.subordinate }"/>
		       </td>
		       <td style="text-align: right;">学科代码：</td>
		       <td>
				<input id="proSelect" name="subjectCode" class="inputText" value="${projInfoMap.subjectCode}" readonly="readonly" onclick="showMenu(); return false;"/>
		       </td>
		       <td style="text-align: right;">学科负责人：</td>
		       <td>
		         <input type="text" name="subjectPrincipal" class="inputText" value="${resultMap.subjectPrincipal }"/>
		       </td>
		    </tr>
		    <tr>
		       <td style="text-align: right;">通讯地址：</td>
		       <td colspan="5">
		         <input type="text" name="address" class="inputText" value="${resultMap.address }" style="width: 90%"/>
		       </td>
		       <td style="text-align: right;">邮编：</td>
		       <td>
		         <input type="text" name="postalcode" class="inputText validate[custom[number]]" value="${resultMap.postalcode }"/>
		       </td>
		    </tr>
		  </table>
		  
		  <table class="basic" style="margin-top: 40px; width: 100%;">
		    <tr><th colspan="8" style="padding-left:15px;text-align:left;">2.现有规模</th></tr>
		    <tr>
		      <td style="text-align: right;">学科人员总数：</td>
		      <td>
		        <input type="text" name="subjectMemberCount" class="inputText validate[custom[number]]" value="${resultMap.subjectMemberCount }"/>
		      </td>
		      <td style="text-align: right;">高级职称：</td>
		      <td>
		        <input type="text" name="highTitle" class="inputText validate[custom[number]]" value="${resultMap.highTitle}"/>
		      </td>
		      <td style="text-align: right;">中级职称：</td>
		      <td>
		        <input type="text" name="middleTitle" class="inputText validate[custom[number]]" value="${resultMap.middleTitle}"/>
		      </td>
		      <td style="text-align: right;">初级职称：</td>
		      <td>
		        <input type="text" name="primaryTitle" class="inputText validate[custom[number]]" value="${resultMap.primaryTitle}"/>
		      </td>
		    </tr>
	    </table>
	    <table class="basic" style="border-top: none; width: 100%;">	    
		    <tr>
		      <td style="text-align: right;">学科实有床位数：</td>
		      <td>
		        <input type="text" name="subjectBunk" class="inputText validate[custom[number]]" value="${resultMap.subjectBunk}"/>
		      </td>
		      <td style="text-align: right;">病床周转次数：</td>
		      <td>
		        <input type="text" name="bunkTurnover" class="inputText validate[custom[number]]" value="${resultMap.bunkTurnover}"/>
		      </td>
		      <td style="text-align: right;">病床使用率（%）：</td>
		      <td>
		        <input type="text" name="bunkUseProportion" class="inputText validate[custom[number]]" value="${resultMap.bunkUseProportion}"/>
		      </td>
		    </tr>
		    <tr>
		      <td style="text-align: right;">学科业务总收入：</td>
		      <td>
		        <input type="text" name="subjectBusinessIncome" class="inputText validate[custom[number]]" value="${resultMap.subjectBusinessIncome}"/>
		      </td>
		      <td style="text-align: right;">出院病人总数：</td>
		      <td>
		        <input type="text" name="cureCount" class="inputText validate[custom[number]]" value="${resultMap.cureCount}"/>
		      </td>
		      <td style="text-align: right;">门急诊人次数：</td>
		      <td>
		        <input type="text" name="outpatientCount" class="inputText validate[custom[number]]" value="${resultMap.outpatientCount}"/>
		      </td>
		    </tr>		    
		    <tr>
		      <td style="text-align: right;">学科设备总值：</td>
		      <td>
		         <input type="text" name="subjectEquipmentCount" class="inputText validate[custom[number]]" value="${resultMap.subjectEquipmentCount}"/>
		      </td>
		       <td style="text-align: right;">实验室使用面积：</td>
		      <td>
		         <input type="text" name="laboratoryArea" class="inputText validate[custom[number]]" value="${resultMap.laboratoryArea}"/>
		      </td>
		       <td style="text-align: right;">学科专用实验室设备价值：</td>
		      <td>
		         <input type="text" name="laboratoryEquipmentCount" class="inputText validate[custom[number]]" value="${resultMap.laboratoryEquipmentCount}"/>
		      </td>
		    </tr>
		  </table>
		  
		  
		  <table width="100%" class="basic" style="margin-top: 40px;">
		    <tr><th colspan="6" style="padding-left:15px;text-align:left;">3.业务主攻方向</th></tr>
		    <tr>
		      <td style="text-align: right;" width="17%">主攻方向：</td>
		      <td colspan="5">
		         <input type="text" name="mainDirection" class="inputText" value="${resultMap.mainDirection}" style="width: 500px;"/> 
		      </td>
		    </tr>
		    <tr>
		      <td style="text-align: right;">从事本发展方向的人员：</td>
		      <td colspan="5">
		         <input type="text" name="mainAcademicPerson" class="inputText" value="${resultMap.mainAcademicPerson}"/>、
		         <input type="text" name="technologyLeader" class="inputText" value="${resultMap.technologyLeader}"/> 、
		         <input type="text" name="technologyBackbone" class="inputText" value="${resultMap.technologyBackbone}"/>  
		      </td>
		    </tr>
		    <tr>
		      <td style="text-align: right;">主任医师人数：</td>
		      <td>
		         <input type="text" name="archiater" class="inputText validate[custom[number]]" value="${resultMap.archiater}"/>
		      </td>
		      <td style="text-align: right;">副主任医师人数：</td>
		      <td>
		         <input type="text" name="assistantArchiater" class="inputText validate[custom[number]]" value="${resultMap.assistantArchiater}"/>
		      </td>
		      <td style="text-align: right;">主治医师人数：</td>
		      <td>
		         <input type="text" name="visitingStaff" class="inputText validate[custom[number]]" value="${resultMap.visitingStaff}"/>
		      </td>
		    </tr>
		      <tr><th colspan="6" style="padding-left:15px;text-align:left;">简介</th></tr>
		      <tr>
		        <td rowspan="2"  style="text-align: right;">10个关键词：</td>
		        <td colspan="5">             
		         <input type="text" name="introKeyword1" class="inputText" value="${resultMap.introKeyword1}" style="margin-left: 50px;"/>、
		         <input type="text" name="introKeyword2" class="inputText" value="${resultMap.introKeyword2}"/>、
		         <input type="text" name="introKeyword3" class="inputText" value="${resultMap.introKeyword3}"/>、
		         <input type="text" name="introKeyword4" class="inputText" value="${resultMap.introKeyword4}"/>、
		         <input type="text" name="introKeyword5" class="inputText" value="${resultMap.introKeyword5}"/>             
		        </td>
		      </tr>
		      <tr>
		        <td colspan="5">
		         <input type="text" name="introKeyword6" class="inputText" value="${resultMap.introKeyword6}"/>、
		         <input type="text" name="introKeyword7" class="inputText" value="${resultMap.introKeyword7}"/>、
		         <input type="text" name="introKeyword8" class="inputText" value="${resultMap.introKeyword8}"/>、
		         <input type="text" name="introKeyword9" class="inputText" value="${resultMap.introKeyword9}"/>、
		         <input type="text" name="introKeyword10" class="inputText" value="${resultMap.introKeyword10}"/>  
		        </td>
		      </tr>
		      <tr>
		        <td colspan="6">
		           <textarea class="xltxtarea" class="validate[required]" placeholder="此处填写该学科简介"  name="intro">${resultMap.intro}</textarea>
		        </td>
		      </tr>
		      <tr><th colspan="6" style="padding-left:15px;text-align:left;">重大领先技术</th></tr>
		      <tr>
		        <td  style="text-align: right;">5个关键词：</td>
		        <td colspan="5">
		         <input type="text" name="leadKeyword1" class="inputText" value="${resultMap.leadKeyword1}" style="margin-left: 50px;"/>、
		         <input type="text" name="leadKeyword2" class="inputText" value="${resultMap.leadKeyword2}"/>、
		         <input type="text" name="leadKeyword3" class="inputText" value="${resultMap.leadKeyword3}"/>、
		         <input type="text" name="leadKeyword4" class="inputText" value="${resultMap.leadKeyword4}"/>、
		         <input type="text" name="leadKeyword5" class="inputText" value="${resultMap.leadKeyword5}"/>   
		        </td>
		      </tr>
		       <tr>
		        <td colspan="6">
		           <textarea class="xltxtarea" class="validate[required]" placeholder="此处填写该学科重大领先技术"  name="greatLeadTechnology">${resultMap.greatLeadTechnology}</textarea>
		        </td>
		      </tr>
		  </table>
		  <table width="100%" class="basic" style="margin-top: 40px;">
		    <tr><th colspan="4" style="padding-left:15px;text-align:left;">4.协作单位相关材料</th></tr> 
		    <tr>
		      <td style="text-align: right;">单位名称：</td>
		      <td>
		        <input type="text" name="cooperationOrgName" class="inputText" value="${resultMap.cooperationOrgName}"/>
		      </td>
		      <td style="text-align: right;">学科代码：</td>
		      <td>
		        <input type="text" name="cooperationSubjectCode" class="inputText" value="${resultMap.cooperationSubjectCode}"/>
		      </td>
		    </tr>
		    <tr>
		      <td style="text-align: right;">主要技术人员：</td>
		      <td>
		        <input type="text" name="cooperationTechnicist" class="inputText" value="${resultMap.cooperationTechnicist}"/>
		      </td>
		      <td style="text-align: right;">主要协作人姓名：</td>
		      <td>
		        <input type="text" name="cooperationPerson" class="inputText" value="${resultMap.cooperationPerson}"/>
		      </td>
		    </tr>
		    <tr>
		      <td colspan="4">
		         <textarea class="xltxtarea" class="validate[required]" placeholder="此处填写协作内容"  name="cooperationContent">${resultMap.cooperationContent}</textarea>
		      </td>
		    </tr>
		  </table>
		</form>
    
    <div id="menuContent" class="menuContent" style="display:none; position:absolute;">
		<ul id="treeDemo" class="ztree" style="margin-top:0; width:159px;"></ul>
    </div>
    <div class="button" style="width: 100%; <c:if test="${param.view == GlobalConstant.FLAG_Y}">display:none</c:if>">
        <a href="javascript:void(0)" target="_self" class="search" onclick="nextOpt('step2')">下一步</a>
    </div>

		