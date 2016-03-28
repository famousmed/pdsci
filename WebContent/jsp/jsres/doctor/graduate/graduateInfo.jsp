<script type="text/javascript">
$(document).ready(function(){
	graduateProcess1();
});

function graduateProcess1(){
	jboxLoad("graduateContent","<s:url value='/jsp/jsres/doctor/graduate/onlineRegist.jsp'/>",false);
}

function graduateProcess2(){
	$("#step1").removeClass("current");
	$("#step1").addClass("done");
	$("#step2").addClass("current");
	jboxLoad("graduateContent","<s:url value='/jsp/jsres/doctor/graduate/theoryTest.jsp'/>",false);
}

function graduateProcess3(){
	$("#step2").removeClass("current");
	$("#step2").addClass("done");
	$("#step3").addClass("current");
	jboxLoad("graduateContent","<s:url value='/jsp/jsres/doctor/graduate/skillTest.jsp'/>",false);
}

function graduateProcess4(){
	$("#step3").removeClass("current");
	$("#step3").addClass("done");
	$("#step4").addClass("current");
	jboxLoad("graduateContent","<s:url value='/jsp/jsres/doctor/graduate/graduateAudit.jsp'/>",false);
}

function graduateProcess5(){
	$("#step4").removeClass("current");
	$("#step4").addClass("done");
	$("#step5").addClass("lasted");
	jboxLoad("graduateContent","<s:url value='/jsp/jsres/doctor/graduate/complete.jsp'/>",false);
}
</script>
<body>
	<div class="div_table" style="display: none;">
        <h4>培训信息</h4>
		<table border="0" cellpadding="0" cellspacing="0" class="base_info">
            <colgroup>
              <col width="13%"/>
              <col width="23%"/>
              <col width="13%"/>
              <col width="22%"/>
              <col width="13%"/>
              <col width="16%"/>
            </colgroup>
	           <tbody>
	           <tr>
	               <th>培训基地：</th>
	               <td>苏州市九龙医院</td>
	               <th>培训专业：</th>
	               <td>麻醉科</td>
	               <th>届&#12288;&#12288;别： </th>
	               <td>2013</td>
	           </tr>
	           <tr>
	               <th>规培起始日期：</th>
	               <td>2013-09-01</td>
	               <th>培养年限：</th>
	               <td>三年</td>
	               <th>已培养年限： </th>
	               <td>三年</td>
	           </tr>
	           </tbody>
           </table>  	
    </div>
    
    <div class="div_table">
        <h4>结业考核</h4>
        <div class="flowsteps" id="icn">
		  <ol class="num5">
	        <li class="first current" id="step1">
	          <span><i>1</i><em><a href="javascript:void(0)" onclick="graduateProcess1();" style="color: inherit;">网上报名</a></em></span>
	        </li>
	        <li id="step2">
	          <span><i>2</i><em><a href="javascript:void(0)" onclick="graduateProcess2();" style="color: inherit;">理论考试</a></em></span>
	        </li>
	        <li id="step3">
	          <span><i>3</i><em><a href="javascript:void(0)" onclick="graduateProcess3();" style="color: inherit;">技能考试</a></em></span>
	        </li>
	        <li id="step4">
	          <span><i>4</i><em><a href="javascript:void(0)" onclick="graduateProcess4();" style="color: inherit;">结业审核</a></em></span>
	        </li>
	        <li class="last" id="step5">
	          <span><i>5</i><em><a href="javascript:void(0)" onclick="graduateProcess5();" style="color: inherit;">完成</a></em></span>
	        </li>
	      </ol>
		</div>
		<div id="graduateContent" style="padding-top: 10px">
	
		</div>
    </div>
    
</body>
