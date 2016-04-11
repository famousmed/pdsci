<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@include file="/jsp/common/doctype.jsp" %>
<html>
<head>

<script type="text/javascript">
	$(function(){
		$("#tags li:first a").click();
		renderCalendar();
	});

	function show(divId,obj){
		$(".active").removeClass("active");
		$(obj).parent().addClass("active");
		$(".tableContent").hide();
		$("#"+divId).show();
	}
</script>
<style>
.sub_menu{background: #f4f5f9;box-shadow: none;border-bottom: 1px solid #e7e7eb;padding: 0 20px;height: 50px;}
.sub_menu h3{display:inline-block; font-weight:normal; line-height:50px; font-size:14px;}
.sub_menu ul li{float:left;}
.ryxz{ display:inline-flex;}
.ryxz a{display: block;padding: 0 22px;min-width: 60px;height: 30px;border: 1px solid #e6e7ec;background: #fff;line-height: 30px;color: #222;text-align: center;}
.ryxz a:hover{background: #44b549; color:#fff;}
.ryxz .active a{background: #44b549; color:#fff;}
.tableContent{margin: 10px;}
</style>
</head>

<body>
      <div style="width: 100%;height: 100%;background-color: white;">
	 <div style="margin: 10px;">
	   	<table class="xllist">
			<tr>
	            <td width="250px" style="text-align: left" >&#12288;<b>随访日期：</b>
	            <input type="text" value="2015-08-01" readonly="readonly"/>
	            </td>
	            <td>下次随访日期：  <input type="text" value="2015-12-01" onclick="WdatePicker({dateFmt:'yyyy-MM-dd'})"/></td>
	        </tr>
		</table>
	   </div>
		<div class="sub_menu">
              <h3>随访表单：</h3>
              <ul class="ryxz">
					<li  class="active"><a onclick="show('zybz',this);" style="cursor: pointer;">中医辨证</a></li>
	              	<li><a onclick="show('tgjc',this);" style="cursor: pointer;">体格检查</a></li>
					<li ><a onclick="show('xcg',this);" style="cursor: pointer;">血常规检查</a></li>
					<li ><a onclick="show('yzxcbwj',this)" style="cursor: pointer;">炎症性肠病问卷</a></li>
					<li ><a onclick="show('fj',this)" style="cursor: pointer;">上传附件</a></li>
              </ul>
            </div>
	    <div id="tagContent" class="divContent" >
	    <div class="tableContent" id="fj" style="display: none">
	    	<table class="basic" width="100%" style="margin-top: 20px;margin-bottom: 20px;">
	    	<tbody><tr style="cursor: pointer;">
	    		<th style="text-align: left;padding-left: 20px;"colspan="2">附件清单</th></tr></tbody>
	    		<tr>
	    			<td >1.CT扫描件.jpg</td>
	    			<td style="width: 100px;">预览 |下载 | 删除</td>
	    		</tr>
	    		<tr>
	    			<td >2.胃镜.jpg</td>
	    			<td style="width: 100px;">预览 |下载 | 删除</td>
	    		</tr>
	    	</table>
	    </div>
	    	<div class="tableContent" id="zybz" >
	    		<table class="basic" width="100%" style="margin-top: 20px;margin-bottom: 20px;">
	 			<tbody><tr style="cursor: pointer;">
	 				<th colspan="10" onclick="togleShow('3f2776496be5479ab98004756b8fbd07');" style="text-align: left;padding-left: 20px;font-size: 16px;">中医辨证<img id="3f2776496be5479ab98004756b8fbd07_img" src="${ctxPath }/css/skin/LightBlue/images/zTreeStandard_05.png" style="float: right;padding-right: 10px;padding-top: 5px;">
	 				</th>
	 			</tr>
 			</tbody><tbody id="3f2776496be5479ab98004756b8fbd07_tbody" class="moduleBody" style="display: table-row-group;">
	 		<!-- 设置moduleCode -->
	 		<tr>
	 				<th width="15%" style="text-align: left;padding-left: 10px;">
		 					中医辨证　
		 				</th>
	 				<!-- 单次录入 -->
	 			<td>
		 				
<!-- <!doctype html public "-/w3c/dtd xhtml 1.0 transitional/en" "http://www.w3.org/tr/xhtml1/dtd/xhtml1-transitional.dtd"> -->





	<!-- 设置宽度 -->
	<!-- 单位 -->
							<div style="clear: both !important" attrname="录入值"></div>
							<div style="float:left;"> 
								<!-- 文本/日期 --> 
								<!-- 大文本 -->
							<!-- 单选/复选 -->
							<input type="checkbox" name="7ac5d9fcc26d4f79b20aa09023994f43_1" onchange="doSave('N','7ac5d9fcc26d4f79b20aa09023994f43',this);" value="7" id="7ac5d9fcc26d4f79b20aa09023994f43_7" attrtype="">
									<label for="7ac5d9fcc26d4f79b20aa09023994f43_7">脾肾两虚　</label>
									<input type="checkbox" name="7ac5d9fcc26d4f79b20aa09023994f43_1" onchange="doSave('N','7ac5d9fcc26d4f79b20aa09023994f43',this);" value="8" id="7ac5d9fcc26d4f79b20aa09023994f43_8" attrtype="">
									<label for="7ac5d9fcc26d4f79b20aa09023994f43_8">湿热内蕴证　</label>
									<!-- 下拉-->
							</div>
								<!-- 
								<div style="clear: both !important" attrName="录入值"></div>
							
								 -->
						<div style="clear: both !important"></div>
			</td>
	 			<!-- 多次录入 -->
	 			</tr>
	 			</tbody>
 		</table>
	    	</div>
	    	<div class="tableContent" id="tgjc" style="display: none">
	    		<table class="basic" width="100%" style="margin-top: 20px;margin-bottom: 20px;">
	 			<tbody><tr style="cursor: pointer;">
	 				<th colspan="10" onclick="togleShow('1b9fa314b5364469ab91c8a18f3e4fbd');" style="text-align: left;padding-left: 20px;font-size: 16px;">体格检查<img id="1b9fa314b5364469ab91c8a18f3e4fbd_img" src="${ctxPath }/css/skin/LightBlue/images/zTreeStandard_05.png" style="float: right;padding-right: 10px;padding-top: 5px;">
	 				</th>
	 			</tr>
 			</tbody><tbody id="1b9fa314b5364469ab91c8a18f3e4fbd_tbody" class="moduleBody" style="display: table-row-group;">
	 		<!-- 设置moduleCode -->
	 		<tr>
	 				<th width="25%" style="text-align: left;padding-left: 10px;">
		 					身高（cm）　
		 				</th>
	 				<!-- 单次录入 -->
	 			<td>
		 				
<!-- <!doctype html public "-/w3c/dtd xhtml 1.0 transitional/en" "http://www.w3.org/tr/xhtml1/dtd/xhtml1-transitional.dtd"> -->





	<!-- 设置宽度 -->
	<!-- 单位 -->
							<div style="clear: both !important" attrname="录入值"></div>
							<div style="float:left;"> 
								<!-- 文本/日期 --> 
								<span title="">
										<input type="text" name="a6ca21a95f4343298cae09c72ce05f90_1" value="" codevalues="" attrtype="" class=" validate[custom[integer],maxSize[3],] input mer_input" onchange="doSave('N','a6ca21a95f4343298cae09c72ce05f90',this);" id="form-validation-field-51">
									</span>　
								<!-- 大文本 -->
							<!-- 单选/复选 -->
							<!-- 下拉-->
							</div>
								<!-- 
								<div style="clear: both !important" attrName="录入值"></div>
							
								 -->
						<div style="clear: both !important"></div>
			</td>
	 			<!-- 多次录入 -->
	 			</tr>
	 			<!-- 设置moduleCode -->
	 		<tr>
	 				<th width="15%" style="text-align: left;padding-left: 10px;">
		 					体重（kg）　
		 				</th>
	 				<!-- 单次录入 -->
	 			<td>
		 				
<!-- <!doctype html public "-/w3c/dtd xhtml 1.0 transitional/en" "http://www.w3.org/tr/xhtml1/dtd/xhtml1-transitional.dtd"> -->





	<!-- 设置宽度 -->
	<!-- 单位 -->
							<div style="clear: both !important" attrname="录入值"></div>
							<div style="float:left;"> 
								<!-- 文本/日期 --> 
								<span title="">
										<input type="text" name="5b4eae2f2a594219ba38261e76255d3b_1" value="" codevalues="" attrtype="" class=" validate[custom[number],maxSize[5],] input mer_input" onchange="doSave('N','5b4eae2f2a594219ba38261e76255d3b',this);" id="form-validation-field-52">
									</span>　
								<!-- 大文本 -->
							<!-- 单选/复选 -->
							<!-- 下拉-->
							</div>
								<!-- 
								<div style="clear: both !important" attrName="录入值"></div>
							
								 -->
						<div style="clear: both !important"></div>
			</td>
	 			<!-- 多次录入 -->
	 			</tr>
	 			<!-- 设置moduleCode -->
	 		<tr>
	 				<th width="15%" style="text-align: left;padding-left: 10px;">
		 					体温（℃）　
		 				</th>
	 				<!-- 单次录入 -->
	 			<td>
		 				
<!-- <!doctype html public "-/w3c/dtd xhtml 1.0 transitional/en" "http://www.w3.org/tr/xhtml1/dtd/xhtml1-transitional.dtd"> -->





	<!-- 设置宽度 -->
	<!-- 单位 -->
							<div style="clear: both !important" attrname="录入值"></div>
							<div style="float:left;"> 
								<!-- 文本/日期 --> 
								<span title="">
										<input type="text" name="3b3c82fce0ad497bb984a00ad546285b_1" value="" codevalues="" attrtype="" class=" validate[custom[number],maxSize[4],] input mer_input" onchange="doSave('N','3b3c82fce0ad497bb984a00ad546285b',this);" id="form-validation-field-53">
									</span>　
								<!-- 大文本 -->
							<!-- 单选/复选 -->
							<!-- 下拉-->
							</div>
								<!-- 
								<div style="clear: both !important" attrName="录入值"></div>
							
								 -->
						<div style="clear: both !important"></div>
			</td>
	 			<!-- 多次录入 -->
	 			</tr>
	 			<!-- 设置moduleCode -->
	 		<tr>
	 				<th width="15%" style="text-align: left;padding-left: 10px;">
		 					呼吸（次/分）　
		 				</th>
	 				<!-- 单次录入 -->
	 			<td>
		 				
<!-- <!doctype html public "-/w3c/dtd xhtml 1.0 transitional/en" "http://www.w3.org/tr/xhtml1/dtd/xhtml1-transitional.dtd"> -->





	<!-- 设置宽度 -->
	<!-- 单位 -->
							<div style="clear: both !important" attrname="录入值"></div>
							<div style="float:left;"> 
								<!-- 文本/日期 --> 
								<span title="">
										<input type="text" name="48be6ceb634d4ee3acf2c04249f22c3e_1" value="" codevalues="" attrtype="" class=" validate[custom[integer],maxSize[2],] input mer_input" onchange="doSave('N','48be6ceb634d4ee3acf2c04249f22c3e',this);" id="form-validation-field-54">
									</span>　
								<!-- 大文本 -->
							<!-- 单选/复选 -->
							<!-- 下拉-->
							</div>
								<!-- 
								<div style="clear: both !important" attrName="录入值"></div>
							
								 -->
						<div style="clear: both !important"></div>
			</td>
	 			<!-- 多次录入 -->
	 			</tr>
	 			<!-- 设置moduleCode -->
	 		<tr>
	 				<th width="15%" style="text-align: left;padding-left: 10px;">
		 					收缩压（mmHg）　
		 				</th>
	 				<!-- 单次录入 -->
	 			<td>
		 				
<!-- <!doctype html public "-/w3c/dtd xhtml 1.0 transitional/en" "http://www.w3.org/tr/xhtml1/dtd/xhtml1-transitional.dtd"> -->





	<!-- 设置宽度 -->
	<!-- 单位 -->
							<div style="clear: both !important" attrname="录入值"></div>
							<div style="float:left;"> 
								<!-- 文本/日期 --> 
								<span title="">
										<input type="text" name="b6c50bb5b95d4d5aae9eae725b4d42b9_1" value="" codevalues="" attrtype="" class=" validate[custom[integer],maxSize[3],] input mer_input" onchange="doSave('N','b6c50bb5b95d4d5aae9eae725b4d42b9',this);" id="form-validation-field-55">
									</span>　
								<!-- 大文本 -->
							<!-- 单选/复选 -->
							<!-- 下拉-->
							</div>
								<!-- 
								<div style="clear: both !important" attrName="录入值"></div>
							
								 -->
						<div style="clear: both !important"></div>
			</td>
	 			<!-- 多次录入 -->
	 			</tr>
	 			<!-- 设置moduleCode -->
	 		<tr>
	 				<th width="15%" style="text-align: left;padding-left: 10px;">
		 					舒张压（mmHg）　
		 				</th>
	 				<!-- 单次录入 -->
	 			<td>
		 				
<!-- <!doctype html public "-/w3c/dtd xhtml 1.0 transitional/en" "http://www.w3.org/tr/xhtml1/dtd/xhtml1-transitional.dtd"> -->





	<!-- 设置宽度 -->
	<!-- 单位 -->
							<div style="clear: both !important" attrname="录入值"></div>
							<div style="float:left;"> 
								<!-- 文本/日期 --> 
								<span title="">
										<input type="text" name="db1c34f6c1174674ae85fb4487dd711e_1" value="" codevalues="" attrtype="" class=" validate[custom[integer],maxSize[3],] input mer_input" onchange="doSave('N','db1c34f6c1174674ae85fb4487dd711e',this);" id="form-validation-field-56">
									</span>　
								<!-- 大文本 -->
							<!-- 单选/复选 -->
							<!-- 下拉-->
							</div>
								<!-- 
								<div style="clear: both !important" attrName="录入值"></div>
							
								 -->
						<div style="clear: both !important"></div>
			</td>
	 			<!-- 多次录入 -->
	 			</tr>
	 			<!-- 设置moduleCode -->
	 		<tr>
	 				<th width="15%" style="text-align: left;padding-left: 10px;">
		 					其他阳性体征　
		 				</th>
	 				<!-- 单次录入 -->
	 			<td>
							<div style="float:left;"> 
							<input type="radio" name="d6e82f0b6efb4d47bdeeb71fd6dece1e_1" onchange="doSave('N','d6e82f0b6efb4d47bdeeb71fd6dece1e',this);" value="0" id="d6e82f0b6efb4d47bdeeb71fd6dece1e_0" attrtype="">
									<label for="d6e82f0b6efb4d47bdeeb71fd6dece1e_0">无　</label>
									<input type="radio" name="d6e82f0b6efb4d47bdeeb71fd6dece1e_1" onchange="doSave('N','d6e82f0b6efb4d47bdeeb71fd6dece1e',this);" value="1" id="d6e82f0b6efb4d47bdeeb71fd6dece1e_1" attrtype="">
									<label for="d6e82f0b6efb4d47bdeeb71fd6dece1e_1">有　</label>
									<!-- 下拉-->
							</div>
							<div style="float:left;"> 
								<span width=""> 
										请详述：
									</span>
								<!-- 文本/日期 --> 
								<span title="">
										<input type="text" name="3258a40dd1d44f63a09f7bbe824535b3_1" value="" codevalues="" attrtype="" class=" validate[maxSize[100],] input mer_input" onchange="doSave('N','3258a40dd1d44f63a09f7bbe824535b3',this);" id="form-validation-field-57">
									</span>　
								<!-- 大文本 -->
							<!-- 单选/复选 -->
							<!-- 下拉-->
							</div>
								<!-- 
								
								 -->
						<div style="clear: both !important"></div>
			</td>
	 			<!-- 多次录入 -->
	 			</tr>
	 			</tbody>
 		</table>
	    	</div>
	    	<div class="tableContent" id="xcg" style="display: none;overflow: auto;height: 100%;">
	    		<table class="basic" width="100%" style="margin-top: 20px;margin-bottom: 20px;">
	 			<tbody><tr style="cursor: pointer;">
	 				<th colspan="10" onclick="togleShow('5a7c86a73045424299cbb74c0793cf3e');" style="text-align: left;padding-left: 20px;font-size: 16px;">血常规<img id="5a7c86a73045424299cbb74c0793cf3e_img" src="${ctxPath }/css/skin/LightBlue/images/zTreeStandard_05.png" style="float: right;padding-right: 10px;padding-top: 5px;">
	 				</th>
	 			</tr>
 			</tbody><tbody id="5a7c86a73045424299cbb74c0793cf3e_tbody" class="moduleBody" style="display: table-row-group;">
	 		<!-- 设置moduleCode -->
	 		<tr>
	 				<th width="10%" style="text-align: left;padding-left: 10px;">
		 					报告日期　
		 				</th>
	 				<!-- 单次录入 -->
	 			<td>
		 				
<!-- <!doctype html public "-/w3c/dtd xhtml 1.0 transitional/en" "http://www.w3.org/tr/xhtml1/dtd/xhtml1-transitional.dtd"> -->





	<!-- 设置宽度 -->
	<!-- 单位 -->
							<div style="clear: both !important" attrname="录入值"></div>
							<div style="float:left;"> 
								<!-- 文本/日期 --> 
								<span title="">
										<input type="text" name="7670510494d4403fa37c5a6a053be0f4_1" value="" codevalues="" attrtype="" onclick="WdatePicker({dateFmt:'yyyy-MM-dd'})" onblur="doSave('N','7670510494d4403fa37c5a6a053be0f4',this);" class="dateClass validate[maxSize[100],] input mer_input" onchange="doSave('N','7670510494d4403fa37c5a6a053be0f4',this);" id="form-validation-field-26">
									</span>　
								<!-- 大文本 -->
							<!-- 单选/复选 -->
							<!-- 下拉-->
							</div>
								<!-- 
								<div style="clear: both !important" attrName="录入值"></div>
							
								 -->
						<div style="clear: both !important"></div>
			</td>
	 			<!-- 多次录入 -->
	 			</tr>
	 			<!-- 设置moduleCode -->
	 		<tr>
	 				<th width="15%" style="text-align: left;padding-left: 10px;">
		 					红细胞　
		 				</th>
	 				<!-- 单次录入 -->
	 			<td>
		 				
<!-- <!doctype html public "-/w3c/dtd xhtml 1.0 transitional/en" "http://www.w3.org/tr/xhtml1/dtd/xhtml1-transitional.dtd"> -->





	<!-- 设置宽度 -->
	<!-- 单位 -->
							<div style="float:left;"> 
								<!-- 文本/日期 --> 
								<span title="">
										<input type="text" name="1bc1cdae8dce46068c4145056864b8f6_1" value="" codevalues="" attrtype="" class=" validate[custom[number],maxSize[6],] input mer_input" onchange="doSave('N','1bc1cdae8dce46068c4145056864b8f6',this);" id="form-validation-field-27">
									</span>　
								<!-- 大文本 -->
							<!-- 单选/复选 -->
							<!-- 下拉-->
							</div>
								<!-- 
								
								 -->
						<!-- 单位 -->
							<div style="float:left;"> 
								<span width=""> 
										单位：
									</span>
								<!-- 文本/日期 --> 
								<span title="">
										<input type="text" name="227580522b75498da784c47c15a16e5e_1" value="×10^12/L" codevalues="" attrtype="unit" class=" validate[maxSize[100],] input mer_input" onchange="doSave('N','227580522b75498da784c47c15a16e5e',this);" id="form-validation-field-28">
									</span>　
								<!-- 大文本 -->
							<!-- 单选/复选 -->
							<!-- 下拉-->
							</div>
								<!-- 
								
								 -->
						<!-- 单位 -->
								<!-- 
								
								 -->
						<!-- 单位 -->
							<div style="float:left;"> 
								<span width=""> 
										异常注释：
									</span>
								<!-- 文本/日期 --> 
								<span title="">
										<input type="text" name="848d70ad3ad14dbe976c45bec846b75f_1" value="" codevalues="" attrtype="" class=" validate[maxSize[100],] input mer_input" onchange="doSave('N','848d70ad3ad14dbe976c45bec846b75f',this);" id="form-validation-field-30">
									</span>　
								<!-- 大文本 -->
							<!-- 单选/复选 -->
							<!-- 下拉-->
							</div>
								<!-- 
								
								 -->
						<div style="clear: both !important"></div>
			</td>
	 			<!-- 多次录入 -->
	 			</tr>
	 			<!-- 设置moduleCode -->
	 		<tr>
	 				<th width="15%" style="text-align: left;padding-left: 10px;">
		 					白细胞　
		 				</th>
	 				<!-- 单次录入 -->
	 			<td>
		 				
<!-- <!doctype html public "-/w3c/dtd xhtml 1.0 transitional/en" "http://www.w3.org/tr/xhtml1/dtd/xhtml1-transitional.dtd"> -->





	<!-- 设置宽度 -->
	<!-- 单位 -->
							<div style="float:left;"> 
								<!-- 文本/日期 --> 
								<span title="">
										<input type="text" name="e18676fc2d944cdaa60736162f62619e_1" value="" codevalues="" attrtype="" class=" validate[custom[number],maxSize[6],] input mer_input" onchange="doSave('N','e18676fc2d944cdaa60736162f62619e',this);" id="form-validation-field-31">
									</span>　
								<!-- 大文本 -->
							<!-- 单选/复选 -->
							<!-- 下拉-->
							</div>
								<!-- 
								
								 -->
						<!-- 单位 -->
							<div style="float:left;"> 
								<span width=""> 
										单位：
									</span>
								<!-- 文本/日期 --> 
								<span title="">
										<input type="text" name="ea21920b68b146508ad3977f48c32d61_1" value="×10^9/L" codevalues="" attrtype="unit" class=" validate[maxSize[100],] input mer_input" onchange="doSave('N','ea21920b68b146508ad3977f48c32d61',this);" id="form-validation-field-32">
									</span>　
								<!-- 大文本 -->
							<!-- 单选/复选 -->
							<!-- 下拉-->
							</div>
								<!-- 
								
								 -->
						<!-- 单位 -->
								<!-- 
								
								 -->
						<!-- 单位 -->
							<div style="float:left;"> 
								<span width=""> 
										异常注释：
									</span>
								<!-- 文本/日期 --> 
								<span title="">
										<input type="text" name="bb41d89219444fd0b3788a5ba469344d_1" value="" codevalues="" attrtype="" class=" validate[maxSize[100],] input mer_input" onchange="doSave('N','bb41d89219444fd0b3788a5ba469344d',this);" id="form-validation-field-34">
									</span>　
								<!-- 大文本 -->
							<!-- 单选/复选 -->
							<!-- 下拉-->
							</div>
								<!-- 
								
								 -->
						<div style="clear: both !important"></div>
			</td>
	 			<!-- 多次录入 -->
	 			</tr>
	 			<!-- 设置moduleCode -->
	 		<tr>
	 				<th width="15%" style="text-align: left;padding-left: 10px;">
		 					血红蛋白　
		 				</th>
	 				<!-- 单次录入 -->
	 			<td>
		 				
<!-- <!doctype html public "-/w3c/dtd xhtml 1.0 transitional/en" "http://www.w3.org/tr/xhtml1/dtd/xhtml1-transitional.dtd"> -->





	<!-- 设置宽度 -->
	<!-- 单位 -->
							<div style="float:left;"> 
								<!-- 文本/日期 --> 
								<span title="">
										<input type="text" name="29b7e8d44d654b7fb92061caec6cc44b_1" value="" codevalues="" attrtype="" class=" validate[custom[integer],maxSize[3],] input mer_input" onchange="doSave('N','29b7e8d44d654b7fb92061caec6cc44b',this);" id="form-validation-field-35">
									</span>　
								<!-- 大文本 -->
							<!-- 单选/复选 -->
							<!-- 下拉-->
							</div>
								<!-- 
								
								 -->
						<!-- 单位 -->
							<div style="float:left;"> 
								<span width=""> 
										单位：
									</span>
								<!-- 文本/日期 --> 
								<span title="">
										<input type="text" name="92a33f475de645d5a6329d26eb217462_1" value="g/L" codevalues="" attrtype="unit" class=" validate[maxSize[100],] input mer_input" onchange="doSave('N','92a33f475de645d5a6329d26eb217462',this);" id="form-validation-field-36">
									</span>　
								<!-- 大文本 -->
							<!-- 单选/复选 -->
							<!-- 下拉-->
							</div>
								<!-- 
								
								 -->
						<!-- 单位 -->
								<!-- 
								
								 -->
						<!-- 单位 -->
							<div style="float:left;"> 
								<span width=""> 
										异常注释：
									</span>
								<!-- 文本/日期 --> 
								<span title="">
										<input type="text" name="47d42a4a1df14b2db1e10b3d28fe1ded_1" value="" codevalues="" attrtype="" class=" validate[maxSize[100],] input mer_input" onchange="doSave('N','47d42a4a1df14b2db1e10b3d28fe1ded',this);" id="form-validation-field-38">
									</span>　
								<!-- 大文本 -->
							<!-- 单选/复选 -->
							<!-- 下拉-->
							</div>
								<!-- 
								
								 -->
						<div style="clear: both !important"></div>
			</td>
	 			<!-- 多次录入 -->
	 			</tr>
	 			<!-- 设置moduleCode -->
	 		<tr>
	 				<th width="15%" style="text-align: left;padding-left: 10px;">
		 					中性粒细胞　
		 				</th>
	 				<!-- 单次录入 -->
	 			<td>
		 				
<!-- <!doctype html public "-/w3c/dtd xhtml 1.0 transitional/en" "http://www.w3.org/tr/xhtml1/dtd/xhtml1-transitional.dtd"> -->





	<!-- 设置宽度 -->
	<!-- 单位 -->
							<div style="float:left;"> 
								<!-- 文本/日期 --> 
								<span title="">
										<input type="text" name="ff605b5f09fa4ad8ab4542db65a4a4c5_1" value="" codevalues="" attrtype="" class=" validate[custom[number],maxSize[6],] input mer_input" onchange="doSave('N','ff605b5f09fa4ad8ab4542db65a4a4c5',this);" id="form-validation-field-39">
									</span>　
								<!-- 大文本 -->
							<!-- 单选/复选 -->
							<!-- 下拉-->
							</div>
								<!-- 
								
								 -->
						<!-- 单位 -->
							<div style="float:left;"> 
								<span width=""> 
										单位：
									</span>
								<!-- 文本/日期 --> 
								<span title="">
										<input type="text" name="8bdf51f0bcce42d8a36aadbf0faf03d5_1" value="%" codevalues="" attrtype="unit" class=" validate[maxSize[100],] input mer_input" onchange="doSave('N','8bdf51f0bcce42d8a36aadbf0faf03d5',this);" id="form-validation-field-40">
									</span>　
								<!-- 大文本 -->
							<!-- 单选/复选 -->
							<!-- 下拉-->
							</div>
								<!-- 
								
								 -->
						<!-- 单位 -->
								<!-- 
								
								 -->
						<!-- 单位 -->
							<div style="float:left;"> 
								<span width=""> 
										异常注释：
									</span>
								<!-- 文本/日期 --> 
								<span title="">
										<input type="text" name="df0e0e8882a145ff97a617b071748c27_1" value="" codevalues="" attrtype="" class=" validate[maxSize[100],] input mer_input" onchange="doSave('N','df0e0e8882a145ff97a617b071748c27',this);" id="form-validation-field-42">
									</span>　
								<!-- 大文本 -->
							<!-- 单选/复选 -->
							<!-- 下拉-->
							</div>
								<!-- 
								
								 -->
						<div style="clear: both !important"></div>
			</td>
	 			<!-- 多次录入 -->
	 			</tr>
	 			<!-- 设置moduleCode -->
	 		<tr>
	 				<th width="15%" style="text-align: left;padding-left: 10px;">
		 					淋巴细胞　
		 				</th>
	 				<!-- 单次录入 -->
	 			<td>
		 				
<!-- <!doctype html public "-/w3c/dtd xhtml 1.0 transitional/en" "http://www.w3.org/tr/xhtml1/dtd/xhtml1-transitional.dtd"> -->





	<!-- 设置宽度 -->
	<!-- 单位 -->
							<div style="float:left;"> 
								<!-- 文本/日期 --> 
								<span title="">
										<input type="text" name="1b57e74ac8dd4fb892e9130a3d37e870_1" value="" codevalues="" attrtype="" class=" validate[maxSize[6],] input mer_input" onchange="doSave('N','1b57e74ac8dd4fb892e9130a3d37e870',this);" id="form-validation-field-43">
									</span>　
								<!-- 大文本 -->
							<!-- 单选/复选 -->
							<!-- 下拉-->
							</div>
								<!-- 
								
								 -->
						<!-- 单位 -->
							<div style="float:left;"> 
								<span width=""> 
										单位：
									</span>
								<!-- 文本/日期 --> 
								<span title="">
										<input type="text" name="738efde1a11e434f93b1aa082574ec2a_1" value="%" codevalues="" attrtype="unit" class=" validate[maxSize[100],] input mer_input" onchange="doSave('N','738efde1a11e434f93b1aa082574ec2a',this);" id="form-validation-field-44">
									</span>　
								<!-- 大文本 -->
							<!-- 单选/复选 -->
							<!-- 下拉-->
							</div>
								<!-- 
								
								 -->
						<!-- 单位 -->
								<!-- 
								
								 -->
						<!-- 单位 -->
							<div style="float:left;"> 
								<span width=""> 
										异常注释：
									</span>
								<!-- 文本/日期 --> 
								<span title="">
										<input type="text" name="e1edf8915c184fb4967ddf0003b4fe64_1" value="" codevalues="" attrtype="" class=" validate[maxSize[100],] input mer_input" onchange="doSave('N','e1edf8915c184fb4967ddf0003b4fe64',this);" id="form-validation-field-46">
									</span>　
								<!-- 大文本 -->
							<!-- 单选/复选 -->
							<!-- 下拉-->
							</div>
								<!-- 
								
								 -->
						<div style="clear: both !important"></div>
			</td>
	 			<!-- 多次录入 -->
	 			</tr>
	 			<!-- 设置moduleCode -->
	 		<tr>
	 				<th width="15%" style="text-align: left;padding-left: 10px;">
		 					血小板计数　
		 				</th>
	 				<!-- 单次录入 -->
	 			<td>
		 				
<!-- <!doctype html public "-/w3c/dtd xhtml 1.0 transitional/en" "http://www.w3.org/tr/xhtml1/dtd/xhtml1-transitional.dtd"> -->





	<!-- 设置宽度 -->
	<!-- 单位 -->
							<div style="float:left;"> 
								<!-- 文本/日期 --> 
								<span title="">
										<input type="text" name="d716b74a47a64723933d7d08c9d67ff7_1" value="" codevalues="" attrtype="" class=" validate[custom[number],maxSize[6],] input mer_input" onchange="doSave('N','d716b74a47a64723933d7d08c9d67ff7',this);" id="form-validation-field-47">
									</span>　
								<!-- 大文本 -->
							<!-- 单选/复选 -->
							<!-- 下拉-->
							</div>
								<!-- 
								
								 -->
						<!-- 单位 -->
							<div style="float:left;"> 
								<span width=""> 
										单位：
									</span>
								<!-- 文本/日期 --> 
								<span title="">
										<input type="text" name="e1bd266b51d447fcb196a42ef586943e_1" value="×10^9/L" codevalues="" attrtype="unit" class=" validate[maxSize[100],] input mer_input" onchange="doSave('N','e1bd266b51d447fcb196a42ef586943e',this);" id="form-validation-field-48">
									</span>　
								<!-- 大文本 -->
							<!-- 单选/复选 -->
							<!-- 下拉-->
							</div>
								<!-- 
								
								 -->
						<!-- 单位 -->
								<!-- 
								
								 -->
						<!-- 单位 -->
							<div style="float:left;"> 
								<span width=""> 
										异常注释：
									</span>
								<!-- 文本/日期 --> 
								<span title="">
										<input type="text" name="ad2d5b6c215c4c7fab96ea8918a145f4_1" value="" codevalues="" attrtype="" class=" validate[maxSize[100],] input mer_input" onchange="doSave('N','ad2d5b6c215c4c7fab96ea8918a145f4',this);" id="form-validation-field-50">
									</span>　
								<!-- 大文本 -->
							<!-- 单选/复选 -->
							<!-- 下拉-->
							</div>
								<!-- 
								
								 -->
						<div style="clear: both !important"></div>
			</td>
	 			<!-- 多次录入 -->
	 			</tr>
	 			</tbody>
 		</table>
	    	</div>
	    </div>
     
    		 <div class="tableContent" id="yzxcbwj" style="display: none;overflow: auto;height: 100%;">
    		 	<table class="basic" width="100%" style="margin-top: 20px;margin-bottom: 20px;">
	 			<tbody><tr style="cursor: pointer;">
	 				<th colspan="10" onclick="togleShow('369bdece928a4c4a93a7d45f076c5a65');" style="text-align: left;padding-left: 20px;font-size: 16px;">炎症性肠病问卷<img id="369bdece928a4c4a93a7d45f076c5a65_img" src="${ctxPath }/css/skin/LightBlue/images/zTreeStandard_05.png" style="float: right;padding-right: 10px;padding-top: 5px;">
	 				</th>
	 			</tr>
 			</tbody><tbody id="369bdece928a4c4a93a7d45f076c5a65_tbody" class="moduleBody" style="display: table-row-group;">
	 		<!-- 设置moduleCode -->
	 		<tr>
	 				<th style="text-align: left;padding-left: 10px;">
	 					1． 过去2 周，您的大便次数有多频繁 请选择下列其中一项以反映过去2 周您的大便频率：</th>
	 			</tr>
	 			<tr>
	 			<!-- 单次录入 -->
	 			<td>
		 				
<!-- <!doctype html public "-/w3c/dtd xhtml 1.0 transitional/en" "http://www.w3.org/tr/xhtml1/dtd/xhtml1-transitional.dtd"> -->





	<!-- 设置宽度 -->
	<!-- 单位 -->
							<div style="clear: both !important" attrname="录入值"></div>
							<div style="float:left;"> 
								<!-- 文本/日期 --> 
								<!-- 大文本 -->
							<!-- 单选/复选 -->
							<input type="radio" name="f60f540a9cfa4709999d0abbdbabb732_1" onchange="doSave('N','f60f540a9cfa4709999d0abbdbabb732',this);" value="1" id="f60f540a9cfa4709999d0abbdbabb732_1" attrtype="">
									<label for="f60f540a9cfa4709999d0abbdbabb732_1">1 大便次数跟过去最严重时一样频繁或更频繁　</label>
									<input type="radio" name="f60f540a9cfa4709999d0abbdbabb732_1" onchange="doSave('N','f60f540a9cfa4709999d0abbdbabb732',this);" value="2" id="f60f540a9cfa4709999d0abbdbabb732_2" attrtype="">
									<label for="f60f540a9cfa4709999d0abbdbabb732_2">2 极度频繁　</label>
									<input type="radio" name="f60f540a9cfa4709999d0abbdbabb732_1" onchange="doSave('N','f60f540a9cfa4709999d0abbdbabb732',this);" value="3" id="f60f540a9cfa4709999d0abbdbabb732_3" attrtype="">
									<label for="f60f540a9cfa4709999d0abbdbabb732_3">3 非常频繁　</label>
									<input type="radio" name="f60f540a9cfa4709999d0abbdbabb732_1" onchange="doSave('N','f60f540a9cfa4709999d0abbdbabb732',this);" value="4" id="f60f540a9cfa4709999d0abbdbabb732_4" attrtype="">
									<label for="f60f540a9cfa4709999d0abbdbabb732_4">4 大便次数中度增加　</label>
									<input type="radio" name="f60f540a9cfa4709999d0abbdbabb732_1" onchange="doSave('N','f60f540a9cfa4709999d0abbdbabb732',this);" value="5" id="f60f540a9cfa4709999d0abbdbabb732_5" attrtype="">
									<label for="f60f540a9cfa4709999d0abbdbabb732_5">5 大便次数有些增加　</label>
									<input type="radio" name="f60f540a9cfa4709999d0abbdbabb732_1" onchange="doSave('N','f60f540a9cfa4709999d0abbdbabb732',this);" value="6" id="f60f540a9cfa4709999d0abbdbabb732_6" attrtype="">
									<label for="f60f540a9cfa4709999d0abbdbabb732_6">6 大便次数稍有增加　</label>
									<input type="radio" name="f60f540a9cfa4709999d0abbdbabb732_1" onchange="doSave('N','f60f540a9cfa4709999d0abbdbabb732',this);" value="7" id="f60f540a9cfa4709999d0abbdbabb732_7" attrtype="">
									<label for="f60f540a9cfa4709999d0abbdbabb732_7">7 正常，大便次数没有增加　</label>
									<!-- 下拉-->
							</div>
								<!-- 
								<div style="clear: both !important" attrName="录入值"></div>
							
								 -->
						<div style="clear: both !important"></div>
			</td>
	 			<!-- 多次录入 -->
	 			</tr>
	 			<!-- 设置moduleCode -->
	 		<tr>
	 				<th style="text-align: left;padding-left: 10px;">
	 					2． 过去2 周，您有多少时间受到疲劳、乏力或筋疲力尽感的影响 请选择下列其中一项以反映过去2 周内</th>
	 			</tr>
	 			<tr>
	 			<!-- 单次录入 -->
	 			<td>
		 				
<!-- <!doctype html public "-/w3c/dtd xhtml 1.0 transitional/en" "http://www.w3.org/tr/xhtml1/dtd/xhtml1-transitional.dtd"> -->





	<!-- 设置宽度 -->
	<!-- 单位 -->
							<div style="clear: both !important" attrname="录入值"></div>
							<div style="float:left;"> 
								<!-- 文本/日期 --> 
								<!-- 大文本 -->
							<!-- 单选/复选 -->
							<input type="radio" name="fd60626640ad485a9477443a672e434b_1" onchange="doSave('N','fd60626640ad485a9477443a672e434b',this);" value="1" id="fd60626640ad485a9477443a672e434b_1" attrtype="">
									<label for="fd60626640ad485a9477443a672e434b_1">1 所有时间　</label>
									<input type="radio" name="fd60626640ad485a9477443a672e434b_1" onchange="doSave('N','fd60626640ad485a9477443a672e434b',this);" value="2" id="fd60626640ad485a9477443a672e434b_2" attrtype="">
									<label for="fd60626640ad485a9477443a672e434b_2">2 大部分时间　</label>
									<input type="radio" name="fd60626640ad485a9477443a672e434b_1" onchange="doSave('N','fd60626640ad485a9477443a672e434b',this);" value="3" id="fd60626640ad485a9477443a672e434b_3" attrtype="">
									<label for="fd60626640ad485a9477443a672e434b_3">3 很多时间　</label>
									<input type="radio" name="fd60626640ad485a9477443a672e434b_1" onchange="doSave('N','fd60626640ad485a9477443a672e434b',this);" value="4" id="fd60626640ad485a9477443a672e434b_4" attrtype="">
									<label for="fd60626640ad485a9477443a672e434b_4">4 有些时间　</label>
									<input type="radio" name="fd60626640ad485a9477443a672e434b_1" onchange="doSave('N','fd60626640ad485a9477443a672e434b',this);" value="5" id="fd60626640ad485a9477443a672e434b_5" attrtype="">
									<label for="fd60626640ad485a9477443a672e434b_5">5 少部分时间　</label>
									<input type="radio" name="fd60626640ad485a9477443a672e434b_1" onchange="doSave('N','fd60626640ad485a9477443a672e434b',this);" value="6" id="fd60626640ad485a9477443a672e434b_6" attrtype="">
									<label for="fd60626640ad485a9477443a672e434b_6">6 很少时间　</label>
									<input type="radio" name="fd60626640ad485a9477443a672e434b_1" onchange="doSave('N','fd60626640ad485a9477443a672e434b',this);" value="7" id="fd60626640ad485a9477443a672e434b_7" attrtype="">
									<label for="fd60626640ad485a9477443a672e434b_7">7 完全没有　</label>
									<!-- 下拉-->
							</div>
								<!-- 
								<div style="clear: both !important" attrName="录入值"></div>
							
								 -->
						<div style="clear: both !important"></div>
			</td>
	 			<!-- 多次录入 -->
	 			</tr>
	 			<!-- 设置moduleCode -->
	 		<tr>
	 				<th style="text-align: left;padding-left: 10px;">
	 					3． 过去2 周，您有多少时间感到沮丧、不耐烦或烦躁不安 请从下列选项中选择一项：</th>
	 			</tr>
	 			<tr>
	 			<!-- 单次录入 -->
	 			<td>
		 				
<!-- <!doctype html public "-/w3c/dtd xhtml 1.0 transitional/en" "http://www.w3.org/tr/xhtml1/dtd/xhtml1-transitional.dtd"> -->





	<!-- 设置宽度 -->
	<!-- 单位 -->
							<div style="clear: both !important" attrname="录入值"></div>
							<div style="float:left;"> 
								<!-- 文本/日期 --> 
								<!-- 大文本 -->
							<!-- 单选/复选 -->
							<input type="radio" name="69f8e1fb759748b49307e798b88dd720_1" onchange="doSave('N','69f8e1fb759748b49307e798b88dd720',this);" value="1" id="69f8e1fb759748b49307e798b88dd720_1" attrtype="">
									<label for="69f8e1fb759748b49307e798b88dd720_1">1 所有时间　</label>
									<input type="radio" name="69f8e1fb759748b49307e798b88dd720_1" onchange="doSave('N','69f8e1fb759748b49307e798b88dd720',this);" value="2" id="69f8e1fb759748b49307e798b88dd720_2" attrtype="">
									<label for="69f8e1fb759748b49307e798b88dd720_2">2 大部分时间　</label>
									<input type="radio" name="69f8e1fb759748b49307e798b88dd720_1" onchange="doSave('N','69f8e1fb759748b49307e798b88dd720',this);" value="3" id="69f8e1fb759748b49307e798b88dd720_3" attrtype="">
									<label for="69f8e1fb759748b49307e798b88dd720_3">3 很多时间　</label>
									<input type="radio" name="69f8e1fb759748b49307e798b88dd720_1" onchange="doSave('N','69f8e1fb759748b49307e798b88dd720',this);" value="4" id="69f8e1fb759748b49307e798b88dd720_4" attrtype="">
									<label for="69f8e1fb759748b49307e798b88dd720_4">4 有些时间　</label>
									<input type="radio" name="69f8e1fb759748b49307e798b88dd720_1" onchange="doSave('N','69f8e1fb759748b49307e798b88dd720',this);" value="5" id="69f8e1fb759748b49307e798b88dd720_5" attrtype="">
									<label for="69f8e1fb759748b49307e798b88dd720_5">5 少部分时间　</label>
									<input type="radio" name="69f8e1fb759748b49307e798b88dd720_1" onchange="doSave('N','69f8e1fb759748b49307e798b88dd720',this);" value="6" id="69f8e1fb759748b49307e798b88dd720_6" attrtype="">
									<label for="69f8e1fb759748b49307e798b88dd720_6">6 很少时间　</label>
									<input type="radio" name="69f8e1fb759748b49307e798b88dd720_1" onchange="doSave('N','69f8e1fb759748b49307e798b88dd720',this);" value="7" id="69f8e1fb759748b49307e798b88dd720_7" attrtype="">
									<label for="69f8e1fb759748b49307e798b88dd720_7">7 完全没有　</label>
									<!-- 下拉-->
							</div>
								<!-- 
								<div style="clear: both !important" attrName="录入值"></div>
							
								 -->
						<div style="clear: both !important"></div>
			</td>
	 			<!-- 多次录入 -->
	 			</tr>
	 			<!-- 设置moduleCode -->
	 		<tr>
	 				<th style="text-align: left;padding-left: 10px;">
	 					4． 过去2 周， 您有多少时间因肠道问题而不能上学或工作 请从下列选项中选择一项：</th>
	 			</tr>
	 			<tr>
	 			<!-- 单次录入 -->
	 			<td>
		 				
<!-- <!doctype html public "-/w3c/dtd xhtml 1.0 transitional/en" "http://www.w3.org/tr/xhtml1/dtd/xhtml1-transitional.dtd"> -->





	<!-- 设置宽度 -->
	<!-- 单位 -->
							<div style="clear: both !important" attrname="录入值"></div>
							<div style="float:left;"> 
								<!-- 文本/日期 --> 
								<!-- 大文本 -->
							<!-- 单选/复选 -->
							<input type="radio" name="26636ddf35114c21afda3de70ec8c430_1" onchange="doSave('N','26636ddf35114c21afda3de70ec8c430',this);" value="1" id="26636ddf35114c21afda3de70ec8c430_1" attrtype="">
									<label for="26636ddf35114c21afda3de70ec8c430_1">1 所有时间　</label>
									<input type="radio" name="26636ddf35114c21afda3de70ec8c430_1" onchange="doSave('N','26636ddf35114c21afda3de70ec8c430',this);" value="2" id="26636ddf35114c21afda3de70ec8c430_2" attrtype="">
									<label for="26636ddf35114c21afda3de70ec8c430_2">2 大部分时间　</label>
									<input type="radio" name="26636ddf35114c21afda3de70ec8c430_1" onchange="doSave('N','26636ddf35114c21afda3de70ec8c430',this);" value="3" id="26636ddf35114c21afda3de70ec8c430_3" attrtype="">
									<label for="26636ddf35114c21afda3de70ec8c430_3">3 很多时间　</label>
									<input type="radio" name="26636ddf35114c21afda3de70ec8c430_1" onchange="doSave('N','26636ddf35114c21afda3de70ec8c430',this);" value="4" id="26636ddf35114c21afda3de70ec8c430_4" attrtype="">
									<label for="26636ddf35114c21afda3de70ec8c430_4">4 有些时间　</label>
									<input type="radio" name="26636ddf35114c21afda3de70ec8c430_1" onchange="doSave('N','26636ddf35114c21afda3de70ec8c430',this);" value="5" id="26636ddf35114c21afda3de70ec8c430_5" attrtype="">
									<label for="26636ddf35114c21afda3de70ec8c430_5">5 少部分时间　</label>
									<input type="radio" name="26636ddf35114c21afda3de70ec8c430_1" onchange="doSave('N','26636ddf35114c21afda3de70ec8c430',this);" value="6" id="26636ddf35114c21afda3de70ec8c430_6" attrtype="">
									<label for="26636ddf35114c21afda3de70ec8c430_6">6 很少时间　</label>
									<input type="radio" name="26636ddf35114c21afda3de70ec8c430_1" onchange="doSave('N','26636ddf35114c21afda3de70ec8c430',this);" value="7" id="26636ddf35114c21afda3de70ec8c430_7" attrtype="">
									<label for="26636ddf35114c21afda3de70ec8c430_7">7 完全没有　</label>
									<!-- 下拉-->
							</div>
								<!-- 
								<div style="clear: both !important" attrName="录入值"></div>
							
								 -->
						<div style="clear: both !important"></div>
			</td>
	 			<!-- 多次录入 -->
	 			</tr>
	 			<!-- 设置moduleCode -->
	 		<tr>
	 				<th style="text-align: left;padding-left: 10px;">
	 					5． 过去2 周，您有多少时间有解稀便的现象 请从下列选项中选择一项：</th>
	 			</tr>
	 			<tr>
	 			<!-- 单次录入 -->
	 			<td>
		 				
<!-- <!doctype html public "-/w3c/dtd xhtml 1.0 transitional/en" "http://www.w3.org/tr/xhtml1/dtd/xhtml1-transitional.dtd"> -->





	<!-- 设置宽度 -->
	<!-- 单位 -->
							<div style="clear: both !important" attrname="录入值"></div>
							<div style="float:left;"> 
								<!-- 文本/日期 --> 
								<!-- 大文本 -->
							<!-- 单选/复选 -->
							<input type="radio" name="8fc7f1d5a8934b00b3f47b4bcb924f12_1" onchange="doSave('N','8fc7f1d5a8934b00b3f47b4bcb924f12',this);" value="1" id="8fc7f1d5a8934b00b3f47b4bcb924f12_1" attrtype="">
									<label for="8fc7f1d5a8934b00b3f47b4bcb924f12_1">1 所有时间　</label>
									<input type="radio" name="8fc7f1d5a8934b00b3f47b4bcb924f12_1" onchange="doSave('N','8fc7f1d5a8934b00b3f47b4bcb924f12',this);" value="2" id="8fc7f1d5a8934b00b3f47b4bcb924f12_2" attrtype="">
									<label for="8fc7f1d5a8934b00b3f47b4bcb924f12_2">2 大部分时间　</label>
									<input type="radio" name="8fc7f1d5a8934b00b3f47b4bcb924f12_1" onchange="doSave('N','8fc7f1d5a8934b00b3f47b4bcb924f12',this);" value="3" id="8fc7f1d5a8934b00b3f47b4bcb924f12_3" attrtype="">
									<label for="8fc7f1d5a8934b00b3f47b4bcb924f12_3">3 很多时间　</label>
									<input type="radio" name="8fc7f1d5a8934b00b3f47b4bcb924f12_1" onchange="doSave('N','8fc7f1d5a8934b00b3f47b4bcb924f12',this);" value="4" id="8fc7f1d5a8934b00b3f47b4bcb924f12_4" attrtype="">
									<label for="8fc7f1d5a8934b00b3f47b4bcb924f12_4">4 有些时间　</label>
									<input type="radio" name="8fc7f1d5a8934b00b3f47b4bcb924f12_1" onchange="doSave('N','8fc7f1d5a8934b00b3f47b4bcb924f12',this);" value="5" id="8fc7f1d5a8934b00b3f47b4bcb924f12_5" attrtype="">
									<label for="8fc7f1d5a8934b00b3f47b4bcb924f12_5">5 少部分时间　</label>
									<input type="radio" name="8fc7f1d5a8934b00b3f47b4bcb924f12_1" onchange="doSave('N','8fc7f1d5a8934b00b3f47b4bcb924f12',this);" value="6" id="8fc7f1d5a8934b00b3f47b4bcb924f12_6" attrtype="">
									<label for="8fc7f1d5a8934b00b3f47b4bcb924f12_6">6 很少时间　</label>
									<input type="radio" name="8fc7f1d5a8934b00b3f47b4bcb924f12_1" onchange="doSave('N','8fc7f1d5a8934b00b3f47b4bcb924f12',this);" value="7" id="8fc7f1d5a8934b00b3f47b4bcb924f12_7" attrtype="">
									<label for="8fc7f1d5a8934b00b3f47b4bcb924f12_7">7 完全没有　</label>
									<!-- 下拉-->
							</div>
								<!-- 
								<div style="clear: both !important" attrName="录入值"></div>
							
								 -->
						<div style="clear: both !important"></div>
			</td>
	 			<!-- 多次录入 -->
	 			</tr>
	 			<!-- 设置moduleCode -->
	 		<tr>
	 				<th style="text-align: left;padding-left: 10px;">
	 					6． 过去2 周，您有多少精力 请从下列选项中选择一项：</th>
	 			</tr>
	 			<tr>
	 			<!-- 单次录入 -->
	 			<td>
		 				
<!-- <!doctype html public "-/w3c/dtd xhtml 1.0 transitional/en" "http://www.w3.org/tr/xhtml1/dtd/xhtml1-transitional.dtd"> -->





	<!-- 设置宽度 -->
	<!-- 单位 -->
							<div style="clear: both !important" attrname="录入值"></div>
							<div style="float:left;"> 
								<!-- 文本/日期 --> 
								<!-- 大文本 -->
							<!-- 单选/复选 -->
							<input type="radio" name="edf6d7134c8045abbc0395c468abc29c_1" onchange="doSave('N','edf6d7134c8045abbc0395c468abc29c',this);" value="1" id="edf6d7134c8045abbc0395c468abc29c_1" attrtype="">
									<label for="edf6d7134c8045abbc0395c468abc29c_1">1 完全没有精力　</label>
									<input type="radio" name="edf6d7134c8045abbc0395c468abc29c_1" onchange="doSave('N','edf6d7134c8045abbc0395c468abc29c',this);" value="2" id="edf6d7134c8045abbc0395c468abc29c_2" attrtype="">
									<label for="edf6d7134c8045abbc0395c468abc29c_2">2 精力很少　</label>
									<input type="radio" name="edf6d7134c8045abbc0395c468abc29c_1" onchange="doSave('N','edf6d7134c8045abbc0395c468abc29c',this);" value="3" id="edf6d7134c8045abbc0395c468abc29c_3" attrtype="">
									<label for="edf6d7134c8045abbc0395c468abc29c_3">3 少许精力　</label>
									<input type="radio" name="edf6d7134c8045abbc0395c468abc29c_1" onchange="doSave('N','edf6d7134c8045abbc0395c468abc29c',this);" value="4" id="edf6d7134c8045abbc0395c468abc29c_4" attrtype="">
									<label for="edf6d7134c8045abbc0395c468abc29c_4">4 有些精力　</label>
									<input type="radio" name="edf6d7134c8045abbc0395c468abc29c_1" onchange="doSave('N','edf6d7134c8045abbc0395c468abc29c',this);" value="5" id="edf6d7134c8045abbc0395c468abc29c_5" attrtype="">
									<label for="edf6d7134c8045abbc0395c468abc29c_5">5 中等量的精力　</label>
									<input type="radio" name="edf6d7134c8045abbc0395c468abc29c_1" onchange="doSave('N','edf6d7134c8045abbc0395c468abc29c',this);" value="6" id="edf6d7134c8045abbc0395c468abc29c_6" attrtype="">
									<label for="edf6d7134c8045abbc0395c468abc29c_6">6 精力很多　</label>
									<input type="radio" name="edf6d7134c8045abbc0395c468abc29c_1" onchange="doSave('N','edf6d7134c8045abbc0395c468abc29c',this);" value="7" id="edf6d7134c8045abbc0395c468abc29c_7" attrtype="">
									<label for="edf6d7134c8045abbc0395c468abc29c_7">7 精力旺盛　</label>
									<!-- 下拉-->
							</div>
								<!-- 
								<div style="clear: both !important" attrName="录入值"></div>
							
								 -->
						<div style="clear: both !important"></div>
			</td>
	 			<!-- 多次录入 -->
	 			</tr>
	 			<!-- 设置moduleCode -->
	 		<tr>
	 				<th style="text-align: left;padding-left: 10px;">
	 					7． 过去2 周，您有多少时间担心您的肠道问题可能需要手术治疗 请从下列选项中选择一项：</th>
	 			</tr>
	 			<tr>
	 			<!-- 单次录入 -->
	 			<td>
		 				
<!-- <!doctype html public "-/w3c/dtd xhtml 1.0 transitional/en" "http://www.w3.org/tr/xhtml1/dtd/xhtml1-transitional.dtd"> -->





	<!-- 设置宽度 -->
	<!-- 单位 -->
							<div style="clear: both !important" attrname="录入值"></div>
							<div style="float:left;"> 
								<!-- 文本/日期 --> 
								<!-- 大文本 -->
							<!-- 单选/复选 -->
							<input type="radio" name="09566a55866e4f2fbd1791c2723a0fd1_1" onchange="doSave('N','09566a55866e4f2fbd1791c2723a0fd1',this);" value="1" id="09566a55866e4f2fbd1791c2723a0fd1_1" attrtype="">
									<label for="09566a55866e4f2fbd1791c2723a0fd1_1">1 所有时间 　</label>
									<input type="radio" name="09566a55866e4f2fbd1791c2723a0fd1_1" onchange="doSave('N','09566a55866e4f2fbd1791c2723a0fd1',this);" value="2" id="09566a55866e4f2fbd1791c2723a0fd1_2" attrtype="">
									<label for="09566a55866e4f2fbd1791c2723a0fd1_2">2 大部分时间　</label>
									<input type="radio" name="09566a55866e4f2fbd1791c2723a0fd1_1" onchange="doSave('N','09566a55866e4f2fbd1791c2723a0fd1',this);" value="3" id="09566a55866e4f2fbd1791c2723a0fd1_3" attrtype="">
									<label for="09566a55866e4f2fbd1791c2723a0fd1_3">3 很多时间　</label>
									<input type="radio" name="09566a55866e4f2fbd1791c2723a0fd1_1" onchange="doSave('N','09566a55866e4f2fbd1791c2723a0fd1',this);" value="4" id="09566a55866e4f2fbd1791c2723a0fd1_4" attrtype="">
									<label for="09566a55866e4f2fbd1791c2723a0fd1_4">4 有些时间　</label>
									<input type="radio" name="09566a55866e4f2fbd1791c2723a0fd1_1" onchange="doSave('N','09566a55866e4f2fbd1791c2723a0fd1',this);" value="5" id="09566a55866e4f2fbd1791c2723a0fd1_5" attrtype="">
									<label for="09566a55866e4f2fbd1791c2723a0fd1_5">5 少部分时间　</label>
									<input type="radio" name="09566a55866e4f2fbd1791c2723a0fd1_1" onchange="doSave('N','09566a55866e4f2fbd1791c2723a0fd1',this);" value="6" id="09566a55866e4f2fbd1791c2723a0fd1_6" attrtype="">
									<label for="09566a55866e4f2fbd1791c2723a0fd1_6">6 很少时间　</label>
									<input type="radio" name="09566a55866e4f2fbd1791c2723a0fd1_1" onchange="doSave('N','09566a55866e4f2fbd1791c2723a0fd1',this);" value="7" id="09566a55866e4f2fbd1791c2723a0fd1_7" attrtype="">
									<label for="09566a55866e4f2fbd1791c2723a0fd1_7">7 完全没有　</label>
									<!-- 下拉-->
							</div>
								<!-- 
								<div style="clear: both !important" attrName="录入值"></div>
							
								 -->
						<div style="clear: both !important"></div>
			</td>
	 			<!-- 多次录入 -->
	 			</tr>
	 			<!-- 设置moduleCode -->
	 		<tr>
	 				<th style="text-align: left;padding-left: 10px;">
	 					8． 过去2 周，您有多少时间因肠道问题而不得不推迟或取消社交活动 请从下列选项中选择一项：</th>
	 			</tr>
	 			<tr>
	 			<!-- 单次录入 -->
	 			<td>
		 				
<!-- <!doctype html public "-/w3c/dtd xhtml 1.0 transitional/en" "http://www.w3.org/tr/xhtml1/dtd/xhtml1-transitional.dtd"> -->





	<!-- 设置宽度 -->
	<!-- 单位 -->
							<div style="clear: both !important" attrname="录入值"></div>
							<div style="float:left;"> 
								<!-- 文本/日期 --> 
								<!-- 大文本 -->
							<!-- 单选/复选 -->
							<input type="radio" name="85784087322043c7aa21bf4f63bb2f96_1" onchange="doSave('N','85784087322043c7aa21bf4f63bb2f96',this);" value="1" id="85784087322043c7aa21bf4f63bb2f96_1" attrtype="">
									<label for="85784087322043c7aa21bf4f63bb2f96_1">1 所有时间　</label>
									<input type="radio" name="85784087322043c7aa21bf4f63bb2f96_1" onchange="doSave('N','85784087322043c7aa21bf4f63bb2f96',this);" value="2" id="85784087322043c7aa21bf4f63bb2f96_2" attrtype="">
									<label for="85784087322043c7aa21bf4f63bb2f96_2">2 大部分时间　</label>
									<input type="radio" name="85784087322043c7aa21bf4f63bb2f96_1" onchange="doSave('N','85784087322043c7aa21bf4f63bb2f96',this);" value="3" id="85784087322043c7aa21bf4f63bb2f96_3" attrtype="">
									<label for="85784087322043c7aa21bf4f63bb2f96_3">3 很多时间　</label>
									<input type="radio" name="85784087322043c7aa21bf4f63bb2f96_1" onchange="doSave('N','85784087322043c7aa21bf4f63bb2f96',this);" value="4" id="85784087322043c7aa21bf4f63bb2f96_4" attrtype="">
									<label for="85784087322043c7aa21bf4f63bb2f96_4">4 有些时间　</label>
									<input type="radio" name="85784087322043c7aa21bf4f63bb2f96_1" onchange="doSave('N','85784087322043c7aa21bf4f63bb2f96',this);" value="5" id="85784087322043c7aa21bf4f63bb2f96_5" attrtype="">
									<label for="85784087322043c7aa21bf4f63bb2f96_5">5 少部分时间　</label>
									<input type="radio" name="85784087322043c7aa21bf4f63bb2f96_1" onchange="doSave('N','85784087322043c7aa21bf4f63bb2f96',this);" value="6" id="85784087322043c7aa21bf4f63bb2f96_6" attrtype="">
									<label for="85784087322043c7aa21bf4f63bb2f96_6">6 很少时间　</label>
									<input type="radio" name="85784087322043c7aa21bf4f63bb2f96_1" onchange="doSave('N','85784087322043c7aa21bf4f63bb2f96',this);" value="7" id="85784087322043c7aa21bf4f63bb2f96_7" attrtype="">
									<label for="85784087322043c7aa21bf4f63bb2f96_7">7 完全没有　</label>
									<!-- 下拉-->
							</div>
								<!-- 
								<div style="clear: both !important" attrName="录入值"></div>
							
								 -->
						<div style="clear: both !important"></div>
			</td>
	 			<!-- 多次录入 -->
	 			</tr>
	 			<!-- 设置moduleCode -->
	 		<tr>
	 				<th style="text-align: left;padding-left: 10px;">
	 					9． 过去2 周，您有多少时间因腹部绞痛而烦恼 请从下列选项中选择一项：</th>
	 			</tr>
	 			<tr>
	 			<!-- 单次录入 -->
	 			<td>
		 				
<!-- <!doctype html public "-/w3c/dtd xhtml 1.0 transitional/en" "http://www.w3.org/tr/xhtml1/dtd/xhtml1-transitional.dtd"> -->





	<!-- 设置宽度 -->
	<!-- 单位 -->
							<div style="clear: both !important" attrname="录入值"></div>
							<div style="float:left;"> 
								<!-- 文本/日期 --> 
								<!-- 大文本 -->
							<!-- 单选/复选 -->
							<input type="radio" name="6d5a0d87b06d4b7c913b968ba3e1744e_1" onchange="doSave('N','6d5a0d87b06d4b7c913b968ba3e1744e',this);" value="1" id="6d5a0d87b06d4b7c913b968ba3e1744e_1" attrtype="">
									<label for="6d5a0d87b06d4b7c913b968ba3e1744e_1">1 所有时间　</label>
									<input type="radio" name="6d5a0d87b06d4b7c913b968ba3e1744e_1" onchange="doSave('N','6d5a0d87b06d4b7c913b968ba3e1744e',this);" value="2" id="6d5a0d87b06d4b7c913b968ba3e1744e_2" attrtype="">
									<label for="6d5a0d87b06d4b7c913b968ba3e1744e_2">2 大部分时间　</label>
									<input type="radio" name="6d5a0d87b06d4b7c913b968ba3e1744e_1" onchange="doSave('N','6d5a0d87b06d4b7c913b968ba3e1744e',this);" value="3" id="6d5a0d87b06d4b7c913b968ba3e1744e_3" attrtype="">
									<label for="6d5a0d87b06d4b7c913b968ba3e1744e_3">3 很多时间　</label>
									<input type="radio" name="6d5a0d87b06d4b7c913b968ba3e1744e_1" onchange="doSave('N','6d5a0d87b06d4b7c913b968ba3e1744e',this);" value="4" id="6d5a0d87b06d4b7c913b968ba3e1744e_4" attrtype="">
									<label for="6d5a0d87b06d4b7c913b968ba3e1744e_4">4 有些时间　</label>
									<input type="radio" name="6d5a0d87b06d4b7c913b968ba3e1744e_1" onchange="doSave('N','6d5a0d87b06d4b7c913b968ba3e1744e',this);" value="5" id="6d5a0d87b06d4b7c913b968ba3e1744e_5" attrtype="">
									<label for="6d5a0d87b06d4b7c913b968ba3e1744e_5">5 少部分时间　</label>
									<input type="radio" name="6d5a0d87b06d4b7c913b968ba3e1744e_1" onchange="doSave('N','6d5a0d87b06d4b7c913b968ba3e1744e',this);" value="6" id="6d5a0d87b06d4b7c913b968ba3e1744e_6" attrtype="">
									<label for="6d5a0d87b06d4b7c913b968ba3e1744e_6">6 很少时间　</label>
									<input type="radio" name="6d5a0d87b06d4b7c913b968ba3e1744e_1" onchange="doSave('N','6d5a0d87b06d4b7c913b968ba3e1744e',this);" value="7" id="6d5a0d87b06d4b7c913b968ba3e1744e_7" attrtype="">
									<label for="6d5a0d87b06d4b7c913b968ba3e1744e_7">7 完全没有　</label>
									<!-- 下拉-->
							</div>
								<!-- 
								<div style="clear: both !important" attrName="录入值"></div>
							
								 -->
						<div style="clear: both !important"></div>
			</td>
	 			<!-- 多次录入 -->
	 			</tr>
	 			<!-- 设置moduleCode -->
	 		<tr>
	 				<th style="text-align: left;padding-left: 10px;">
	 					10． 过去2 周，您有多少时间感到身体不适 请从下列选项中选择一项：</th>
	 			</tr>
	 			<tr>
	 			<!-- 单次录入 -->
	 			<td>
		 				
<!-- <!doctype html public "-/w3c/dtd xhtml 1.0 transitional/en" "http://www.w3.org/tr/xhtml1/dtd/xhtml1-transitional.dtd"> -->





	<!-- 设置宽度 -->
	<!-- 单位 -->
							<div style="clear: both !important" attrname="录入值"></div>
							<div style="float:left;"> 
								<!-- 文本/日期 --> 
								<!-- 大文本 -->
							<!-- 单选/复选 -->
							<input type="radio" name="0c4104199cc245eda7e707f533b446f3_1" onchange="doSave('N','0c4104199cc245eda7e707f533b446f3',this);" value="1" id="0c4104199cc245eda7e707f533b446f3_1" attrtype="">
									<label for="0c4104199cc245eda7e707f533b446f3_1">1 所有时间　</label>
									<input type="radio" name="0c4104199cc245eda7e707f533b446f3_1" onchange="doSave('N','0c4104199cc245eda7e707f533b446f3',this);" value="2" id="0c4104199cc245eda7e707f533b446f3_2" attrtype="">
									<label for="0c4104199cc245eda7e707f533b446f3_2">2 大部分时间　</label>
									<input type="radio" name="0c4104199cc245eda7e707f533b446f3_1" onchange="doSave('N','0c4104199cc245eda7e707f533b446f3',this);" value="3" id="0c4104199cc245eda7e707f533b446f3_3" attrtype="">
									<label for="0c4104199cc245eda7e707f533b446f3_3">3 很多时间　</label>
									<input type="radio" name="0c4104199cc245eda7e707f533b446f3_1" onchange="doSave('N','0c4104199cc245eda7e707f533b446f3',this);" value="4" id="0c4104199cc245eda7e707f533b446f3_4" attrtype="">
									<label for="0c4104199cc245eda7e707f533b446f3_4">4 有些时间　</label>
									<input type="radio" name="0c4104199cc245eda7e707f533b446f3_1" onchange="doSave('N','0c4104199cc245eda7e707f533b446f3',this);" value="5" id="0c4104199cc245eda7e707f533b446f3_5" attrtype="">
									<label for="0c4104199cc245eda7e707f533b446f3_5">5 少部分时间　</label>
									<input type="radio" name="0c4104199cc245eda7e707f533b446f3_1" onchange="doSave('N','0c4104199cc245eda7e707f533b446f3',this);" value="6" id="0c4104199cc245eda7e707f533b446f3_6" attrtype="">
									<label for="0c4104199cc245eda7e707f533b446f3_6">6 很少时间　</label>
									<input type="radio" name="0c4104199cc245eda7e707f533b446f3_1" onchange="doSave('N','0c4104199cc245eda7e707f533b446f3',this);" value="7" id="0c4104199cc245eda7e707f533b446f3_7" attrtype="">
									<label for="0c4104199cc245eda7e707f533b446f3_7">7 完全没有　</label>
									<!-- 下拉-->
							</div>
								<!-- 
								<div style="clear: both !important" attrName="录入值"></div>
							
								 -->
						<div style="clear: both !important"></div>
			</td>
	 			<!-- 多次录入 -->
	 			</tr>
	 			<!-- 设置moduleCode -->
	 		<tr>
	 				<th style="text-align: left;padding-left: 10px;">
	 					11． 过去2 周，您有多少时间因担心找不到厕所而烦恼 请从下列选项中选择一项：</th>
	 			</tr>
	 			<tr>
	 			<!-- 单次录入 -->
	 			<td>
		 				
<!-- <!doctype html public "-/w3c/dtd xhtml 1.0 transitional/en" "http://www.w3.org/tr/xhtml1/dtd/xhtml1-transitional.dtd"> -->





	<!-- 设置宽度 -->
	<!-- 单位 -->
							<div style="clear: both !important" attrname="录入值"></div>
							<div style="float:left;"> 
								<!-- 文本/日期 --> 
								<!-- 大文本 -->
							<!-- 单选/复选 -->
							<input type="radio" name="a7e645ad8a1641069d6f88b2fde3ce9b_1" onchange="doSave('N','a7e645ad8a1641069d6f88b2fde3ce9b',this);" value="1" id="a7e645ad8a1641069d6f88b2fde3ce9b_1" attrtype="">
									<label for="a7e645ad8a1641069d6f88b2fde3ce9b_1">1 所有时间　</label>
									<input type="radio" name="a7e645ad8a1641069d6f88b2fde3ce9b_1" onchange="doSave('N','a7e645ad8a1641069d6f88b2fde3ce9b',this);" value="2" id="a7e645ad8a1641069d6f88b2fde3ce9b_2" attrtype="">
									<label for="a7e645ad8a1641069d6f88b2fde3ce9b_2">2 大部分时间　</label>
									<input type="radio" name="a7e645ad8a1641069d6f88b2fde3ce9b_1" onchange="doSave('N','a7e645ad8a1641069d6f88b2fde3ce9b',this);" value="3" id="a7e645ad8a1641069d6f88b2fde3ce9b_3" attrtype="">
									<label for="a7e645ad8a1641069d6f88b2fde3ce9b_3">3 很多时间　</label>
									<input type="radio" name="a7e645ad8a1641069d6f88b2fde3ce9b_1" onchange="doSave('N','a7e645ad8a1641069d6f88b2fde3ce9b',this);" value="4" id="a7e645ad8a1641069d6f88b2fde3ce9b_4" attrtype="">
									<label for="a7e645ad8a1641069d6f88b2fde3ce9b_4">4 有些时间　</label>
									<input type="radio" name="a7e645ad8a1641069d6f88b2fde3ce9b_1" onchange="doSave('N','a7e645ad8a1641069d6f88b2fde3ce9b',this);" value="5" id="a7e645ad8a1641069d6f88b2fde3ce9b_5" attrtype="">
									<label for="a7e645ad8a1641069d6f88b2fde3ce9b_5">5 少部分时间　</label>
									<input type="radio" name="a7e645ad8a1641069d6f88b2fde3ce9b_1" onchange="doSave('N','a7e645ad8a1641069d6f88b2fde3ce9b',this);" value="6" id="a7e645ad8a1641069d6f88b2fde3ce9b_6" attrtype="">
									<label for="a7e645ad8a1641069d6f88b2fde3ce9b_6">6 很少时间　</label>
									<input type="radio" name="a7e645ad8a1641069d6f88b2fde3ce9b_1" onchange="doSave('N','a7e645ad8a1641069d6f88b2fde3ce9b',this);" value="7" id="a7e645ad8a1641069d6f88b2fde3ce9b_7" attrtype="">
									<label for="a7e645ad8a1641069d6f88b2fde3ce9b_7">7 完全没有　</label>
									<!-- 下拉-->
							</div>
								<!-- 
								<div style="clear: both !important" attrName="录入值"></div>
							
								 -->
						<div style="clear: both !important"></div>
			</td>
	 			<!-- 多次录入 -->
	 			</tr>
	 			<!-- 设置moduleCode -->
	 		<tr>
	 				<th style="text-align: left;padding-left: 10px;">
	 					12． 过去2 周，肠道问题给您原本想参加的休闲或体育活动带来多大困难 请从下列选项中选择一 项：</th>
	 			</tr>
	 			<tr>
	 			<!-- 单次录入 -->
	 			<td>
		 				
<!-- <!doctype html public "-/w3c/dtd xhtml 1.0 transitional/en" "http://www.w3.org/tr/xhtml1/dtd/xhtml1-transitional.dtd"> -->





	<!-- 设置宽度 -->
	<!-- 单位 -->
							<div style="clear: both !important" attrname="录入值"></div>
							<div style="float:left;"> 
								<!-- 文本/日期 --> 
								<!-- 大文本 -->
							<!-- 单选/复选 -->
							<input type="radio" name="01fb803f9e264f0c92ded6418168f9f4_1" onchange="doSave('N','01fb803f9e264f0c92ded6418168f9f4',this);" value="1" id="01fb803f9e264f0c92ded6418168f9f4_1" attrtype="">
									<label for="01fb803f9e264f0c92ded6418168f9f4_1">1 很大困难，无法进行活动　</label>
									<input type="radio" name="01fb803f9e264f0c92ded6418168f9f4_1" onchange="doSave('N','01fb803f9e264f0c92ded6418168f9f4',this);" value="2" id="01fb803f9e264f0c92ded6418168f9f4_2" attrtype="">
									<label for="01fb803f9e264f0c92ded6418168f9f4_2">2 很多困难　</label>
									<input type="radio" name="01fb803f9e264f0c92ded6418168f9f4_1" onchange="doSave('N','01fb803f9e264f0c92ded6418168f9f4',this);" value="3" id="01fb803f9e264f0c92ded6418168f9f4_3" attrtype="">
									<label for="01fb803f9e264f0c92ded6418168f9f4_3">3 中等度困难　</label>
									<input type="radio" name="01fb803f9e264f0c92ded6418168f9f4_1" onchange="doSave('N','01fb803f9e264f0c92ded6418168f9f4',this);" value="4" id="01fb803f9e264f0c92ded6418168f9f4_4" attrtype="">
									<label for="01fb803f9e264f0c92ded6418168f9f4_4">4 有些困难　</label>
									<input type="radio" name="01fb803f9e264f0c92ded6418168f9f4_1" onchange="doSave('N','01fb803f9e264f0c92ded6418168f9f4',this);" value="5" id="01fb803f9e264f0c92ded6418168f9f4_5" attrtype="">
									<label for="01fb803f9e264f0c92ded6418168f9f4_5">5 很少困难　</label>
									<input type="radio" name="01fb803f9e264f0c92ded6418168f9f4_1" onchange="doSave('N','01fb803f9e264f0c92ded6418168f9f4',this);" value="6" id="01fb803f9e264f0c92ded6418168f9f4_6" attrtype="">
									<label for="01fb803f9e264f0c92ded6418168f9f4_6">6 极少困难　</label>
									<input type="radio" name="01fb803f9e264f0c92ded6418168f9f4_1" onchange="doSave('N','01fb803f9e264f0c92ded6418168f9f4',this);" value="7" id="01fb803f9e264f0c92ded6418168f9f4_7" attrtype="">
									<label for="01fb803f9e264f0c92ded6418168f9f4_7">7 没有困难，肠道问题没有限制体育或休闲活动　</label>
									<!-- 下拉-->
							</div>
								<!-- 
								<div style="clear: both !important" attrName="录入值"></div>
							
								 -->
						<div style="clear: both !important"></div>
			</td>
	 			<!-- 多次录入 -->
	 			</tr>
	 			<!-- 设置moduleCode -->
	 		<tr>
	 				<th style="text-align: left;padding-left: 10px;">
	 					13． 过去2 周，您有多少时间因腹痛而烦恼 请从下列选项中选择一项：</th>
	 			</tr>
	 			<tr>
	 			<!-- 单次录入 -->
	 			<td>
		 				
<!-- <!doctype html public "-/w3c/dtd xhtml 1.0 transitional/en" "http://www.w3.org/tr/xhtml1/dtd/xhtml1-transitional.dtd"> -->





	<!-- 设置宽度 -->
	<!-- 单位 -->
							<div style="clear: both !important" attrname="录入值"></div>
							<div style="float:left;"> 
								<!-- 文本/日期 --> 
								<!-- 大文本 -->
							<!-- 单选/复选 -->
							<input type="radio" name="45c2041ba1424cfe94a7bc64d4e28db3_1" onchange="doSave('N','45c2041ba1424cfe94a7bc64d4e28db3',this);" value="1" id="45c2041ba1424cfe94a7bc64d4e28db3_1" attrtype="">
									<label for="45c2041ba1424cfe94a7bc64d4e28db3_1">1 所有时间　</label>
									<input type="radio" name="45c2041ba1424cfe94a7bc64d4e28db3_1" onchange="doSave('N','45c2041ba1424cfe94a7bc64d4e28db3',this);" value="2" id="45c2041ba1424cfe94a7bc64d4e28db3_2" attrtype="">
									<label for="45c2041ba1424cfe94a7bc64d4e28db3_2">2 大部分时间　</label>
									<input type="radio" name="45c2041ba1424cfe94a7bc64d4e28db3_1" onchange="doSave('N','45c2041ba1424cfe94a7bc64d4e28db3',this);" value="3" id="45c2041ba1424cfe94a7bc64d4e28db3_3" attrtype="">
									<label for="45c2041ba1424cfe94a7bc64d4e28db3_3">3 很多时间　</label>
									<input type="radio" name="45c2041ba1424cfe94a7bc64d4e28db3_1" onchange="doSave('N','45c2041ba1424cfe94a7bc64d4e28db3',this);" value="4" id="45c2041ba1424cfe94a7bc64d4e28db3_4" attrtype="">
									<label for="45c2041ba1424cfe94a7bc64d4e28db3_4">4 有些时间　</label>
									<input type="radio" name="45c2041ba1424cfe94a7bc64d4e28db3_1" onchange="doSave('N','45c2041ba1424cfe94a7bc64d4e28db3',this);" value="5" id="45c2041ba1424cfe94a7bc64d4e28db3_5" attrtype="">
									<label for="45c2041ba1424cfe94a7bc64d4e28db3_5">5 少部分时间　</label>
									<input type="radio" name="45c2041ba1424cfe94a7bc64d4e28db3_1" onchange="doSave('N','45c2041ba1424cfe94a7bc64d4e28db3',this);" value="6" id="45c2041ba1424cfe94a7bc64d4e28db3_6" attrtype="">
									<label for="45c2041ba1424cfe94a7bc64d4e28db3_6">6 很少时间　</label>
									<input type="radio" name="45c2041ba1424cfe94a7bc64d4e28db3_1" onchange="doSave('N','45c2041ba1424cfe94a7bc64d4e28db3',this);" value="7" id="45c2041ba1424cfe94a7bc64d4e28db3_7" attrtype="">
									<label for="45c2041ba1424cfe94a7bc64d4e28db3_7">7 完全没有　</label>
									<!-- 下拉-->
							</div>
								<!-- 
								<div style="clear: both !important" attrName="录入值"></div>
							
								 -->
						<div style="clear: both !important"></div>
			</td>
	 			<!-- 多次录入 -->
	 			</tr>
	 			<!-- 设置moduleCode -->
	 		<tr>
	 				<th style="text-align: left;padding-left: 10px;">
	 					14． 过去2 周，您有多少时间因夜间不能安睡或夜间醒来而烦恼 请从下列选项中选择一项：</th>
	 			</tr>
	 			<tr>
	 			<!-- 单次录入 -->
	 			<td>
		 				
<!-- <!doctype html public "-/w3c/dtd xhtml 1.0 transitional/en" "http://www.w3.org/tr/xhtml1/dtd/xhtml1-transitional.dtd"> -->





	<!-- 设置宽度 -->
	<!-- 单位 -->
							<div style="clear: both !important" attrname="录入值"></div>
							<div style="float:left;"> 
								<!-- 文本/日期 --> 
								<!-- 大文本 -->
							<!-- 单选/复选 -->
							<input type="radio" name="21360339c39b461a98125aae14a2dbca_1" onchange="doSave('N','21360339c39b461a98125aae14a2dbca',this);" value="1" id="21360339c39b461a98125aae14a2dbca_1" attrtype="">
									<label for="21360339c39b461a98125aae14a2dbca_1">1 所有时间　</label>
									<input type="radio" name="21360339c39b461a98125aae14a2dbca_1" onchange="doSave('N','21360339c39b461a98125aae14a2dbca',this);" value="2" id="21360339c39b461a98125aae14a2dbca_2" attrtype="">
									<label for="21360339c39b461a98125aae14a2dbca_2">2 大部分时间　</label>
									<input type="radio" name="21360339c39b461a98125aae14a2dbca_1" onchange="doSave('N','21360339c39b461a98125aae14a2dbca',this);" value="3" id="21360339c39b461a98125aae14a2dbca_3" attrtype="">
									<label for="21360339c39b461a98125aae14a2dbca_3">3 很多时间　</label>
									<input type="radio" name="21360339c39b461a98125aae14a2dbca_1" onchange="doSave('N','21360339c39b461a98125aae14a2dbca',this);" value="4" id="21360339c39b461a98125aae14a2dbca_4" attrtype="">
									<label for="21360339c39b461a98125aae14a2dbca_4">4 有些时间　</label>
									<input type="radio" name="21360339c39b461a98125aae14a2dbca_1" onchange="doSave('N','21360339c39b461a98125aae14a2dbca',this);" value="5" id="21360339c39b461a98125aae14a2dbca_5" attrtype="">
									<label for="21360339c39b461a98125aae14a2dbca_5">5 少部分时间　</label>
									<input type="radio" name="21360339c39b461a98125aae14a2dbca_1" onchange="doSave('N','21360339c39b461a98125aae14a2dbca',this);" value="6" id="21360339c39b461a98125aae14a2dbca_6" attrtype="">
									<label for="21360339c39b461a98125aae14a2dbca_6">6 很少时间　</label>
									<input type="radio" name="21360339c39b461a98125aae14a2dbca_1" onchange="doSave('N','21360339c39b461a98125aae14a2dbca',this);" value="7" id="21360339c39b461a98125aae14a2dbca_7" attrtype="">
									<label for="21360339c39b461a98125aae14a2dbca_7">7 完全没有　</label>
									<!-- 下拉-->
							</div>
								<!-- 
								<div style="clear: both !important" attrName="录入值"></div>
							
								 -->
						<div style="clear: both !important"></div>
			</td>
	 			<!-- 多次录入 -->
	 			</tr>
	 			<!-- 设置moduleCode -->
	 		<tr>
	 				<th style="text-align: left;padding-left: 10px;">
	 					15． 过去2 周，您有多少时间感到抑郁或沮丧 请从下列选项中选择一项：</th>
	 			</tr>
	 			<tr>
	 			<!-- 单次录入 -->
	 			<td>
		 				
<!-- <!doctype html public "-/w3c/dtd xhtml 1.0 transitional/en" "http://www.w3.org/tr/xhtml1/dtd/xhtml1-transitional.dtd"> -->





	<!-- 设置宽度 -->
	<!-- 单位 -->
							<div style="clear: both !important" attrname="录入值"></div>
							<div style="float:left;"> 
								<!-- 文本/日期 --> 
								<!-- 大文本 -->
							<!-- 单选/复选 -->
							<input type="radio" name="5cf9337a82d946a28a719cfc997b7f49_1" onchange="doSave('N','5cf9337a82d946a28a719cfc997b7f49',this);" value="1" id="5cf9337a82d946a28a719cfc997b7f49_1" attrtype="">
									<label for="5cf9337a82d946a28a719cfc997b7f49_1">1 所有时间　</label>
									<input type="radio" name="5cf9337a82d946a28a719cfc997b7f49_1" onchange="doSave('N','5cf9337a82d946a28a719cfc997b7f49',this);" value="2" id="5cf9337a82d946a28a719cfc997b7f49_2" attrtype="">
									<label for="5cf9337a82d946a28a719cfc997b7f49_2">2 大部分时间　</label>
									<input type="radio" name="5cf9337a82d946a28a719cfc997b7f49_1" onchange="doSave('N','5cf9337a82d946a28a719cfc997b7f49',this);" value="3" id="5cf9337a82d946a28a719cfc997b7f49_3" attrtype="">
									<label for="5cf9337a82d946a28a719cfc997b7f49_3">3 很多时间　</label>
									<input type="radio" name="5cf9337a82d946a28a719cfc997b7f49_1" onchange="doSave('N','5cf9337a82d946a28a719cfc997b7f49',this);" value="4" id="5cf9337a82d946a28a719cfc997b7f49_4" attrtype="">
									<label for="5cf9337a82d946a28a719cfc997b7f49_4">4 有些时间　</label>
									<input type="radio" name="5cf9337a82d946a28a719cfc997b7f49_1" onchange="doSave('N','5cf9337a82d946a28a719cfc997b7f49',this);" value="5" id="5cf9337a82d946a28a719cfc997b7f49_5" attrtype="">
									<label for="5cf9337a82d946a28a719cfc997b7f49_5">5 少部分时间　</label>
									<input type="radio" name="5cf9337a82d946a28a719cfc997b7f49_1" onchange="doSave('N','5cf9337a82d946a28a719cfc997b7f49',this);" value="6" id="5cf9337a82d946a28a719cfc997b7f49_6" attrtype="">
									<label for="5cf9337a82d946a28a719cfc997b7f49_6">6 很少时间　</label>
									<input type="radio" name="5cf9337a82d946a28a719cfc997b7f49_1" onchange="doSave('N','5cf9337a82d946a28a719cfc997b7f49',this);" value="7" id="5cf9337a82d946a28a719cfc997b7f49_7" attrtype="">
									<label for="5cf9337a82d946a28a719cfc997b7f49_7">7 完全没有　</label>
									<!-- 下拉-->
							</div>
								<!-- 
								<div style="clear: both !important" attrName="录入值"></div>
							
								 -->
						<div style="clear: both !important"></div>
			</td>
	 			<!-- 多次录入 -->
	 			</tr>
	 			<!-- 设置moduleCode -->
	 		<tr>
	 				<th style="text-align: left;padding-left: 10px;">
	 					16． 过去2周，您有多少时间因您想要去的场所附近没有厕所而去不了 请从下列选项中选择一项：</th>
	 			</tr>
	 			<tr>
	 			<!-- 单次录入 -->
	 			<td>
		 				
<!-- <!doctype html public "-/w3c/dtd xhtml 1.0 transitional/en" "http://www.w3.org/tr/xhtml1/dtd/xhtml1-transitional.dtd"> -->





	<!-- 设置宽度 -->
	<!-- 单位 -->
							<div style="clear: both !important" attrname="录入值"></div>
							<div style="float:left;"> 
								<!-- 文本/日期 --> 
								<!-- 大文本 -->
							<!-- 单选/复选 -->
							<input type="radio" name="3f6d2ce2b6c4475e95be4fb923c63e73_1" onchange="doSave('N','3f6d2ce2b6c4475e95be4fb923c63e73',this);" value="1" id="3f6d2ce2b6c4475e95be4fb923c63e73_1" attrtype="">
									<label for="3f6d2ce2b6c4475e95be4fb923c63e73_1">1 所有时间　</label>
									<input type="radio" name="3f6d2ce2b6c4475e95be4fb923c63e73_1" onchange="doSave('N','3f6d2ce2b6c4475e95be4fb923c63e73',this);" value="2" id="3f6d2ce2b6c4475e95be4fb923c63e73_2" attrtype="">
									<label for="3f6d2ce2b6c4475e95be4fb923c63e73_2">2 大部分时间　</label>
									<input type="radio" name="3f6d2ce2b6c4475e95be4fb923c63e73_1" onchange="doSave('N','3f6d2ce2b6c4475e95be4fb923c63e73',this);" value="3" id="3f6d2ce2b6c4475e95be4fb923c63e73_3" attrtype="">
									<label for="3f6d2ce2b6c4475e95be4fb923c63e73_3">3 很多时间　</label>
									<input type="radio" name="3f6d2ce2b6c4475e95be4fb923c63e73_1" onchange="doSave('N','3f6d2ce2b6c4475e95be4fb923c63e73',this);" value="4" id="3f6d2ce2b6c4475e95be4fb923c63e73_4" attrtype="">
									<label for="3f6d2ce2b6c4475e95be4fb923c63e73_4">4 有些时间　</label>
									<input type="radio" name="3f6d2ce2b6c4475e95be4fb923c63e73_1" onchange="doSave('N','3f6d2ce2b6c4475e95be4fb923c63e73',this);" value="5" id="3f6d2ce2b6c4475e95be4fb923c63e73_5" attrtype="">
									<label for="3f6d2ce2b6c4475e95be4fb923c63e73_5">5 少部分时间　</label>
									<input type="radio" name="3f6d2ce2b6c4475e95be4fb923c63e73_1" onchange="doSave('N','3f6d2ce2b6c4475e95be4fb923c63e73',this);" value="6" id="3f6d2ce2b6c4475e95be4fb923c63e73_6" attrtype="">
									<label for="3f6d2ce2b6c4475e95be4fb923c63e73_6">6 很少时间　</label>
									<input type="radio" name="3f6d2ce2b6c4475e95be4fb923c63e73_1" onchange="doSave('N','3f6d2ce2b6c4475e95be4fb923c63e73',this);" value="7" id="3f6d2ce2b6c4475e95be4fb923c63e73_7" attrtype="">
									<label for="3f6d2ce2b6c4475e95be4fb923c63e73_7">7 完全没有　</label>
									<!-- 下拉-->
							</div>
								<!-- 
								<div style="clear: both !important" attrName="录入值"></div>
							
								 -->
						<div style="clear: both !important"></div>
			</td>
	 			<!-- 多次录入 -->
	 			</tr>
	 			<!-- 设置moduleCode -->
	 		<tr>
	 				<th style="text-align: left;padding-left: 10px;">
	 					17． 总的说来，过去2 周，大量放屁对您来说是一多大问题 请从下列选项中选择一项：</th>
	 			</tr>
	 			<tr>
	 			<!-- 单次录入 -->
	 			<td>
		 				
<!-- <!doctype html public "-/w3c/dtd xhtml 1.0 transitional/en" "http://www.w3.org/tr/xhtml1/dtd/xhtml1-transitional.dtd"> -->





	<!-- 设置宽度 -->
	<!-- 单位 -->
							<div style="clear: both !important" attrname="录入值"></div>
							<div style="float:left;"> 
								<!-- 文本/日期 --> 
								<!-- 大文本 -->
							<!-- 单选/复选 -->
							<input type="radio" name="8705ab8ef3884174ad9f8919d48df7ab_1" onchange="doSave('N','8705ab8ef3884174ad9f8919d48df7ab',this);" value="1" id="8705ab8ef3884174ad9f8919d48df7ab_1" attrtype="">
									<label for="8705ab8ef3884174ad9f8919d48df7ab_1">1 是一严重问题　</label>
									<input type="radio" name="8705ab8ef3884174ad9f8919d48df7ab_1" onchange="doSave('N','8705ab8ef3884174ad9f8919d48df7ab',this);" value="2" id="8705ab8ef3884174ad9f8919d48df7ab_2" attrtype="">
									<label for="8705ab8ef3884174ad9f8919d48df7ab_2">2 是一重大问题　</label>
									<input type="radio" name="8705ab8ef3884174ad9f8919d48df7ab_1" onchange="doSave('N','8705ab8ef3884174ad9f8919d48df7ab',this);" value="3" id="8705ab8ef3884174ad9f8919d48df7ab_3" attrtype="">
									<label for="8705ab8ef3884174ad9f8919d48df7ab_3">3 是一明显问题　</label>
									<input type="radio" name="8705ab8ef3884174ad9f8919d48df7ab_1" onchange="doSave('N','8705ab8ef3884174ad9f8919d48df7ab',this);" value="4" id="8705ab8ef3884174ad9f8919d48df7ab_4" attrtype="">
									<label for="8705ab8ef3884174ad9f8919d48df7ab_4">4 有些麻烦　</label>
									<input type="radio" name="8705ab8ef3884174ad9f8919d48df7ab_1" onchange="doSave('N','8705ab8ef3884174ad9f8919d48df7ab',this);" value="5" id="8705ab8ef3884174ad9f8919d48df7ab_5" attrtype="">
									<label for="8705ab8ef3884174ad9f8919d48df7ab_5">5 很少麻烦　</label>
									<input type="radio" name="8705ab8ef3884174ad9f8919d48df7ab_1" onchange="doSave('N','8705ab8ef3884174ad9f8919d48df7ab',this);" value="6" id="8705ab8ef3884174ad9f8919d48df7ab_6" attrtype="">
									<label for="8705ab8ef3884174ad9f8919d48df7ab_6">6 绝少麻烦　</label>
									<input type="radio" name="8705ab8ef3884174ad9f8919d48df7ab_1" onchange="doSave('N','8705ab8ef3884174ad9f8919d48df7ab',this);" value="7" id="8705ab8ef3884174ad9f8919d48df7ab_7" attrtype="">
									<label for="8705ab8ef3884174ad9f8919d48df7ab_7">7 没有麻烦　</label>
									<!-- 下拉-->
							</div>
								<!-- 
								<div style="clear: both !important" attrName="录入值"></div>
							
								 -->
						<div style="clear: both !important"></div>
			</td>
	 			<!-- 多次录入 -->
	 			</tr>
	 			<!-- 设置moduleCode -->
	 		<tr>
	 				<th style="text-align: left;padding-left: 10px;">
	 					18． 总的说来，过去2 周，保持或达到您想要的理想体重对您来说是一多大问题 请从下列选项中 选择一项：</th>
	 			</tr>
	 			<tr>
	 			<!-- 单次录入 -->
	 			<td>
		 				
<!-- <!doctype html public "-/w3c/dtd xhtml 1.0 transitional/en" "http://www.w3.org/tr/xhtml1/dtd/xhtml1-transitional.dtd"> -->





	<!-- 设置宽度 -->
	<!-- 单位 -->
							<div style="clear: both !important" attrname="录入值"></div>
							<div style="float:left;"> 
								<!-- 文本/日期 --> 
								<!-- 大文本 -->
							<!-- 单选/复选 -->
							<input type="radio" name="46d35fa74b7a4652b45002f584f87fb6_1" onchange="doSave('N','46d35fa74b7a4652b45002f584f87fb6',this);" value="1" id="46d35fa74b7a4652b45002f584f87fb6_1" attrtype="">
									<label for="46d35fa74b7a4652b45002f584f87fb6_1">1 是一严重问题　</label>
									<input type="radio" name="46d35fa74b7a4652b45002f584f87fb6_1" onchange="doSave('N','46d35fa74b7a4652b45002f584f87fb6',this);" value="2" id="46d35fa74b7a4652b45002f584f87fb6_2" attrtype="">
									<label for="46d35fa74b7a4652b45002f584f87fb6_2">2 是一重大问题　</label>
									<input type="radio" name="46d35fa74b7a4652b45002f584f87fb6_1" onchange="doSave('N','46d35fa74b7a4652b45002f584f87fb6',this);" value="3" id="46d35fa74b7a4652b45002f584f87fb6_3" attrtype="">
									<label for="46d35fa74b7a4652b45002f584f87fb6_3">3 是一明显问题　</label>
									<input type="radio" name="46d35fa74b7a4652b45002f584f87fb6_1" onchange="doSave('N','46d35fa74b7a4652b45002f584f87fb6',this);" value="4" id="46d35fa74b7a4652b45002f584f87fb6_4" attrtype="">
									<label for="46d35fa74b7a4652b45002f584f87fb6_4">4 有些麻烦　</label>
									<input type="radio" name="46d35fa74b7a4652b45002f584f87fb6_1" onchange="doSave('N','46d35fa74b7a4652b45002f584f87fb6',this);" value="5" id="46d35fa74b7a4652b45002f584f87fb6_5" attrtype="">
									<label for="46d35fa74b7a4652b45002f584f87fb6_5">5 很少麻烦　</label>
									<input type="radio" name="46d35fa74b7a4652b45002f584f87fb6_1" onchange="doSave('N','46d35fa74b7a4652b45002f584f87fb6',this);" value="6" id="46d35fa74b7a4652b45002f584f87fb6_6" attrtype="">
									<label for="46d35fa74b7a4652b45002f584f87fb6_6">6 绝少麻烦　</label>
									<input type="radio" name="46d35fa74b7a4652b45002f584f87fb6_1" onchange="doSave('N','46d35fa74b7a4652b45002f584f87fb6',this);" value="7" id="46d35fa74b7a4652b45002f584f87fb6_7" attrtype="">
									<label for="46d35fa74b7a4652b45002f584f87fb6_7">7 没有麻烦　</label>
									<!-- 下拉-->
							</div>
								<!-- 
								<div style="clear: both !important" attrName="录入值"></div>
							
								 -->
						<div style="clear: both !important"></div>
			</td>
	 			<!-- 多次录入 -->
	 			</tr>
	 			<!-- 设置moduleCode -->
	 		<tr>
	 				<th style="text-align: left;padding-left: 10px;">
	 					19． 许多肠病病人经常会因疾病而担心、忧虑。包括担心并发癌症、担心病情不会好转，担心复发。 总体来说，过去2 周，您有多少时间感到这方面的担心、忧虑 请从下列选项中选择一项：</th>
	 			</tr>
	 			<tr>
	 			<!-- 单次录入 -->
	 			<td>
		 				
<!-- <!doctype html public "-/w3c/dtd xhtml 1.0 transitional/en" "http://www.w3.org/tr/xhtml1/dtd/xhtml1-transitional.dtd"> -->





	<!-- 设置宽度 -->
	<!-- 单位 -->
							<div style="clear: both !important" attrname="录入值"></div>
							<div style="float:left;"> 
								<!-- 文本/日期 --> 
								<!-- 大文本 -->
							<!-- 单选/复选 -->
							<input type="radio" name="9e1a90bdc26c47c191db6ea3964ce856_1" onchange="doSave('N','9e1a90bdc26c47c191db6ea3964ce856',this);" value="1" id="9e1a90bdc26c47c191db6ea3964ce856_1" attrtype="">
									<label for="9e1a90bdc26c47c191db6ea3964ce856_1">1 所有时间　</label>
									<input type="radio" name="9e1a90bdc26c47c191db6ea3964ce856_1" onchange="doSave('N','9e1a90bdc26c47c191db6ea3964ce856',this);" value="2" id="9e1a90bdc26c47c191db6ea3964ce856_2" attrtype="">
									<label for="9e1a90bdc26c47c191db6ea3964ce856_2">2 大部分时间　</label>
									<input type="radio" name="9e1a90bdc26c47c191db6ea3964ce856_1" onchange="doSave('N','9e1a90bdc26c47c191db6ea3964ce856',this);" value="3" id="9e1a90bdc26c47c191db6ea3964ce856_3" attrtype="">
									<label for="9e1a90bdc26c47c191db6ea3964ce856_3">3 很多时间　</label>
									<input type="radio" name="9e1a90bdc26c47c191db6ea3964ce856_1" onchange="doSave('N','9e1a90bdc26c47c191db6ea3964ce856',this);" value="4" id="9e1a90bdc26c47c191db6ea3964ce856_4" attrtype="">
									<label for="9e1a90bdc26c47c191db6ea3964ce856_4">4 有些时间　</label>
									<input type="radio" name="9e1a90bdc26c47c191db6ea3964ce856_1" onchange="doSave('N','9e1a90bdc26c47c191db6ea3964ce856',this);" value="5" id="9e1a90bdc26c47c191db6ea3964ce856_5" attrtype="">
									<label for="9e1a90bdc26c47c191db6ea3964ce856_5">5 少部分时间　</label>
									<input type="radio" name="9e1a90bdc26c47c191db6ea3964ce856_1" onchange="doSave('N','9e1a90bdc26c47c191db6ea3964ce856',this);" value="6" id="9e1a90bdc26c47c191db6ea3964ce856_6" attrtype="">
									<label for="9e1a90bdc26c47c191db6ea3964ce856_6">6 很少时间　</label>
									<input type="radio" name="9e1a90bdc26c47c191db6ea3964ce856_1" onchange="doSave('N','9e1a90bdc26c47c191db6ea3964ce856',this);" value="7" id="9e1a90bdc26c47c191db6ea3964ce856_7" attrtype="">
									<label for="9e1a90bdc26c47c191db6ea3964ce856_7">7 完全没有　</label>
									<!-- 下拉-->
							</div>
								<!-- 
								<div style="clear: both !important" attrName="录入值"></div>
							
								 -->
						<div style="clear: both !important"></div>
			</td>
	 			<!-- 多次录入 -->
	 			</tr>
	 			<!-- 设置moduleCode -->
	 		<tr>
	 				<th style="text-align: left;padding-left: 10px;">
	 					21． 过去2 周，您有多少时间感到放松、没有压力 请从下列选项中选择一项：</th>
	 			</tr>
	 			<tr>
	 			<!-- 单次录入 -->
	 			<td>
		 				
<!-- <!doctype html public "-/w3c/dtd xhtml 1.0 transitional/en" "http://www.w3.org/tr/xhtml1/dtd/xhtml1-transitional.dtd"> -->





	<!-- 设置宽度 -->
	<!-- 单位 -->
							<div style="clear: both !important" attrname="录入值"></div>
							<div style="float:left;"> 
								<!-- 文本/日期 --> 
								<!-- 大文本 -->
							<!-- 单选/复选 -->
							<input type="radio" name="5adbe4571b934d42b67cd97e0c98870f_1" onchange="doSave('N','5adbe4571b934d42b67cd97e0c98870f',this);" value="1" id="5adbe4571b934d42b67cd97e0c98870f_1" attrtype="">
									<label for="5adbe4571b934d42b67cd97e0c98870f_1">1 完全没有　</label>
									<input type="radio" name="5adbe4571b934d42b67cd97e0c98870f_1" onchange="doSave('N','5adbe4571b934d42b67cd97e0c98870f',this);" value="2" id="5adbe4571b934d42b67cd97e0c98870f_2" attrtype="">
									<label for="5adbe4571b934d42b67cd97e0c98870f_2">2 少部分时间　</label>
									<input type="radio" name="5adbe4571b934d42b67cd97e0c98870f_1" onchange="doSave('N','5adbe4571b934d42b67cd97e0c98870f',this);" value="3" id="5adbe4571b934d42b67cd97e0c98870f_3" attrtype="">
									<label for="5adbe4571b934d42b67cd97e0c98870f_3">3 有些时间　</label>
									<input type="radio" name="5adbe4571b934d42b67cd97e0c98870f_1" onchange="doSave('N','5adbe4571b934d42b67cd97e0c98870f',this);" value="4" id="5adbe4571b934d42b67cd97e0c98870f_4" attrtype="">
									<label for="5adbe4571b934d42b67cd97e0c98870f_4">4 很多时间　</label>
									<input type="radio" name="5adbe4571b934d42b67cd97e0c98870f_1" onchange="doSave('N','5adbe4571b934d42b67cd97e0c98870f',this);" value="5" id="5adbe4571b934d42b67cd97e0c98870f_5" attrtype="">
									<label for="5adbe4571b934d42b67cd97e0c98870f_5">5 大部分时间　</label>
									<input type="radio" name="5adbe4571b934d42b67cd97e0c98870f_1" onchange="doSave('N','5adbe4571b934d42b67cd97e0c98870f',this);" value="6" id="5adbe4571b934d42b67cd97e0c98870f_6" attrtype="">
									<label for="5adbe4571b934d42b67cd97e0c98870f_6">6 几乎所有时间　</label>
									<input type="radio" name="5adbe4571b934d42b67cd97e0c98870f_1" onchange="doSave('N','5adbe4571b934d42b67cd97e0c98870f',this);" value="7" id="5adbe4571b934d42b67cd97e0c98870f_7" attrtype="">
									<label for="5adbe4571b934d42b67cd97e0c98870f_7">7 所有时间　</label>
									<!-- 下拉-->
							</div>
								<!-- 
								<div style="clear: both !important" attrName="录入值"></div>
							
								 -->
						<div style="clear: both !important"></div>
			</td>
	 			<!-- 多次录入 -->
	 			</tr>
	 			<!-- 设置moduleCode -->
	 		<tr>
	 				<th style="text-align: left;padding-left: 10px;">
	 					22． 过去2 周，您有多少时间在排便时有直肠出血的问题 请从下列选项中选择一项：</th>
	 			</tr>
	 			<tr>
	 			<!-- 单次录入 -->
	 			<td>
		 				
<!-- <!doctype html public "-/w3c/dtd xhtml 1.0 transitional/en" "http://www.w3.org/tr/xhtml1/dtd/xhtml1-transitional.dtd"> -->





	<!-- 设置宽度 -->
	<!-- 单位 -->
							<div style="clear: both !important" attrname="录入值"></div>
							<div style="float:left;"> 
								<!-- 文本/日期 --> 
								<!-- 大文本 -->
							<!-- 单选/复选 -->
							<input type="radio" name="5cf7689683f24b1798ed0251cbc301f3_1" onchange="doSave('N','5cf7689683f24b1798ed0251cbc301f3',this);" value="1" id="5cf7689683f24b1798ed0251cbc301f3_1" attrtype="">
									<label for="5cf7689683f24b1798ed0251cbc301f3_1">1 所有时间　</label>
									<input type="radio" name="5cf7689683f24b1798ed0251cbc301f3_1" onchange="doSave('N','5cf7689683f24b1798ed0251cbc301f3',this);" value="2" id="5cf7689683f24b1798ed0251cbc301f3_2" attrtype="">
									<label for="5cf7689683f24b1798ed0251cbc301f3_2">2 大部分时间　</label>
									<input type="radio" name="5cf7689683f24b1798ed0251cbc301f3_1" onchange="doSave('N','5cf7689683f24b1798ed0251cbc301f3',this);" value="3" id="5cf7689683f24b1798ed0251cbc301f3_3" attrtype="">
									<label for="5cf7689683f24b1798ed0251cbc301f3_3">3 很多时间　</label>
									<input type="radio" name="5cf7689683f24b1798ed0251cbc301f3_1" onchange="doSave('N','5cf7689683f24b1798ed0251cbc301f3',this);" value="4" id="5cf7689683f24b1798ed0251cbc301f3_4" attrtype="">
									<label for="5cf7689683f24b1798ed0251cbc301f3_4">4 有些时间　</label>
									<input type="radio" name="5cf7689683f24b1798ed0251cbc301f3_1" onchange="doSave('N','5cf7689683f24b1798ed0251cbc301f3',this);" value="5" id="5cf7689683f24b1798ed0251cbc301f3_5" attrtype="">
									<label for="5cf7689683f24b1798ed0251cbc301f3_5">5 少部分时间　</label>
									<input type="radio" name="5cf7689683f24b1798ed0251cbc301f3_1" onchange="doSave('N','5cf7689683f24b1798ed0251cbc301f3',this);" value="6" id="5cf7689683f24b1798ed0251cbc301f3_6" attrtype="">
									<label for="5cf7689683f24b1798ed0251cbc301f3_6">6 很少时间　</label>
									<input type="radio" name="5cf7689683f24b1798ed0251cbc301f3_1" onchange="doSave('N','5cf7689683f24b1798ed0251cbc301f3',this);" value="7" id="5cf7689683f24b1798ed0251cbc301f3_7" attrtype="">
									<label for="5cf7689683f24b1798ed0251cbc301f3_7">7 完全没有　</label>
									<!-- 下拉-->
							</div>
								<!-- 
								<div style="clear: both !important" attrName="录入值"></div>
							
								 -->
						<div style="clear: both !important"></div>
			</td>
	 			<!-- 多次录入 -->
	 			</tr>
	 			<!-- 设置moduleCode -->
	 		<tr>
	 				<th style="text-align: left;padding-left: 10px;">
	 					23． 过去2 周，您有多少时间因您的肠道问题而感到尴尬 请从下列选项中选择一项：</th>
	 			</tr>
	 			<tr>
	 			<!-- 单次录入 -->
	 			<td>
		 				
<!-- <!doctype html public "-/w3c/dtd xhtml 1.0 transitional/en" "http://www.w3.org/tr/xhtml1/dtd/xhtml1-transitional.dtd"> -->





	<!-- 设置宽度 -->
	<!-- 单位 -->
							<div style="clear: both !important" attrname="录入值"></div>
							<div style="float:left;"> 
								<!-- 文本/日期 --> 
								<!-- 大文本 -->
							<!-- 单选/复选 -->
							<input type="radio" name="38f93d186d2c4ce190acc4a550c0d4f6_1" onchange="doSave('N','38f93d186d2c4ce190acc4a550c0d4f6',this);" value="1" id="38f93d186d2c4ce190acc4a550c0d4f6_1" attrtype="">
									<label for="38f93d186d2c4ce190acc4a550c0d4f6_1">1 所有时间　</label>
									<input type="radio" name="38f93d186d2c4ce190acc4a550c0d4f6_1" onchange="doSave('N','38f93d186d2c4ce190acc4a550c0d4f6',this);" value="2" id="38f93d186d2c4ce190acc4a550c0d4f6_2" attrtype="">
									<label for="38f93d186d2c4ce190acc4a550c0d4f6_2">2 大部分时间　</label>
									<input type="radio" name="38f93d186d2c4ce190acc4a550c0d4f6_1" onchange="doSave('N','38f93d186d2c4ce190acc4a550c0d4f6',this);" value="3" id="38f93d186d2c4ce190acc4a550c0d4f6_3" attrtype="">
									<label for="38f93d186d2c4ce190acc4a550c0d4f6_3">3 很多时间　</label>
									<input type="radio" name="38f93d186d2c4ce190acc4a550c0d4f6_1" onchange="doSave('N','38f93d186d2c4ce190acc4a550c0d4f6',this);" value="4" id="38f93d186d2c4ce190acc4a550c0d4f6_4" attrtype="">
									<label for="38f93d186d2c4ce190acc4a550c0d4f6_4">4 有些时间　</label>
									<input type="radio" name="38f93d186d2c4ce190acc4a550c0d4f6_1" onchange="doSave('N','38f93d186d2c4ce190acc4a550c0d4f6',this);" value="5" id="38f93d186d2c4ce190acc4a550c0d4f6_5" attrtype="">
									<label for="38f93d186d2c4ce190acc4a550c0d4f6_5">5 少部分时间　</label>
									<input type="radio" name="38f93d186d2c4ce190acc4a550c0d4f6_1" onchange="doSave('N','38f93d186d2c4ce190acc4a550c0d4f6',this);" value="6" id="38f93d186d2c4ce190acc4a550c0d4f6_6" attrtype="">
									<label for="38f93d186d2c4ce190acc4a550c0d4f6_6">6 很少时间　</label>
									<input type="radio" name="38f93d186d2c4ce190acc4a550c0d4f6_1" onchange="doSave('N','38f93d186d2c4ce190acc4a550c0d4f6',this);" value="7" id="38f93d186d2c4ce190acc4a550c0d4f6_7" attrtype="">
									<label for="38f93d186d2c4ce190acc4a550c0d4f6_7">7 完全没有　</label>
									<!-- 下拉-->
							</div>
								<!-- 
								<div style="clear: both !important" attrName="录入值"></div>
							
								 -->
						<div style="clear: both !important"></div>
			</td>
	 			<!-- 多次录入 -->
	 			</tr>
	 			<!-- 设置moduleCode -->
	 		<tr>
	 				<th style="text-align: left;padding-left: 10px;">
	 					24． 尽管肠道是空的，但仍感觉要上厕所，过去2 周，您有多少时间为此而烦恼 请从下列选项中 选择一项：</th>
	 			</tr>
	 			<tr>
	 			<!-- 单次录入 -->
	 			<td>
		 				
<!-- <!doctype html public "-/w3c/dtd xhtml 1.0 transitional/en" "http://www.w3.org/tr/xhtml1/dtd/xhtml1-transitional.dtd"> -->





	<!-- 设置宽度 -->
	<!-- 单位 -->
							<div style="clear: both !important" attrname="录入值"></div>
							<div style="float:left;"> 
								<!-- 文本/日期 --> 
								<!-- 大文本 -->
							<!-- 单选/复选 -->
							<input type="radio" name="cf5cb7898f3e476fb3c0a9df9d4c6732_1" onchange="doSave('N','cf5cb7898f3e476fb3c0a9df9d4c6732',this);" value="1" id="cf5cb7898f3e476fb3c0a9df9d4c6732_1" attrtype="">
									<label for="cf5cb7898f3e476fb3c0a9df9d4c6732_1">1 所有时间　</label>
									<input type="radio" name="cf5cb7898f3e476fb3c0a9df9d4c6732_1" onchange="doSave('N','cf5cb7898f3e476fb3c0a9df9d4c6732',this);" value="2" id="cf5cb7898f3e476fb3c0a9df9d4c6732_2" attrtype="">
									<label for="cf5cb7898f3e476fb3c0a9df9d4c6732_2">2 大部分时间　</label>
									<input type="radio" name="cf5cb7898f3e476fb3c0a9df9d4c6732_1" onchange="doSave('N','cf5cb7898f3e476fb3c0a9df9d4c6732',this);" value="3" id="cf5cb7898f3e476fb3c0a9df9d4c6732_3" attrtype="">
									<label for="cf5cb7898f3e476fb3c0a9df9d4c6732_3">3 很多时间　</label>
									<input type="radio" name="cf5cb7898f3e476fb3c0a9df9d4c6732_1" onchange="doSave('N','cf5cb7898f3e476fb3c0a9df9d4c6732',this);" value="4" id="cf5cb7898f3e476fb3c0a9df9d4c6732_4" attrtype="">
									<label for="cf5cb7898f3e476fb3c0a9df9d4c6732_4">4 有些时间　</label>
									<input type="radio" name="cf5cb7898f3e476fb3c0a9df9d4c6732_1" onchange="doSave('N','cf5cb7898f3e476fb3c0a9df9d4c6732',this);" value="5" id="cf5cb7898f3e476fb3c0a9df9d4c6732_5" attrtype="">
									<label for="cf5cb7898f3e476fb3c0a9df9d4c6732_5">5 少部分时间　</label>
									<input type="radio" name="cf5cb7898f3e476fb3c0a9df9d4c6732_1" onchange="doSave('N','cf5cb7898f3e476fb3c0a9df9d4c6732',this);" value="6" id="cf5cb7898f3e476fb3c0a9df9d4c6732_6" attrtype="">
									<label for="cf5cb7898f3e476fb3c0a9df9d4c6732_6">6 很少时间　</label>
									<input type="radio" name="cf5cb7898f3e476fb3c0a9df9d4c6732_1" onchange="doSave('N','cf5cb7898f3e476fb3c0a9df9d4c6732',this);" value="7" id="cf5cb7898f3e476fb3c0a9df9d4c6732_7" attrtype="">
									<label for="cf5cb7898f3e476fb3c0a9df9d4c6732_7">7 完全没有　</label>
									<!-- 下拉-->
							</div>
								<!-- 
								<div style="clear: both !important" attrName="录入值"></div>
							
								 -->
						<div style="clear: both !important"></div>
			</td>
	 			<!-- 多次录入 -->
	 			</tr>
	 			<!-- 设置moduleCode -->
	 		<tr>
	 				<th style="text-align: left;padding-left: 10px;">
	 					25． 过去2 周，您有多少时间感到伤心流泪或心理难过 请从下列选项中选择一项：</th>
	 			</tr>
	 			<tr>
	 			<!-- 单次录入 -->
	 			<td>
		 				
<!-- <!doctype html public "-/w3c/dtd xhtml 1.0 transitional/en" "http://www.w3.org/tr/xhtml1/dtd/xhtml1-transitional.dtd"> -->





	<!-- 设置宽度 -->
	<!-- 单位 -->
							<div style="clear: both !important" attrname="录入值"></div>
							<div style="float:left;"> 
								<!-- 文本/日期 --> 
								<!-- 大文本 -->
							<!-- 单选/复选 -->
							<input type="radio" name="05fc6ebd991645d2addf5940d61ef1f6_1" onchange="doSave('N','05fc6ebd991645d2addf5940d61ef1f6',this);" value="1" id="05fc6ebd991645d2addf5940d61ef1f6_1" attrtype="">
									<label for="05fc6ebd991645d2addf5940d61ef1f6_1">1所有时间　</label>
									<input type="radio" name="05fc6ebd991645d2addf5940d61ef1f6_1" onchange="doSave('N','05fc6ebd991645d2addf5940d61ef1f6',this);" value="2" id="05fc6ebd991645d2addf5940d61ef1f6_2" attrtype="">
									<label for="05fc6ebd991645d2addf5940d61ef1f6_2">2大部分时间　</label>
									<input type="radio" name="05fc6ebd991645d2addf5940d61ef1f6_1" onchange="doSave('N','05fc6ebd991645d2addf5940d61ef1f6',this);" value="3" id="05fc6ebd991645d2addf5940d61ef1f6_3" attrtype="">
									<label for="05fc6ebd991645d2addf5940d61ef1f6_3">3很多时间　</label>
									<input type="radio" name="05fc6ebd991645d2addf5940d61ef1f6_1" onchange="doSave('N','05fc6ebd991645d2addf5940d61ef1f6',this);" value="4" id="05fc6ebd991645d2addf5940d61ef1f6_4" attrtype="">
									<label for="05fc6ebd991645d2addf5940d61ef1f6_4">4有些时间　</label>
									<input type="radio" name="05fc6ebd991645d2addf5940d61ef1f6_1" onchange="doSave('N','05fc6ebd991645d2addf5940d61ef1f6',this);" value="5" id="05fc6ebd991645d2addf5940d61ef1f6_5" attrtype="">
									<label for="05fc6ebd991645d2addf5940d61ef1f6_5">5少部分时间　</label>
									<input type="radio" name="05fc6ebd991645d2addf5940d61ef1f6_1" onchange="doSave('N','05fc6ebd991645d2addf5940d61ef1f6',this);" value="6" id="05fc6ebd991645d2addf5940d61ef1f6_6" attrtype="">
									<label for="05fc6ebd991645d2addf5940d61ef1f6_6">6很少时间　</label>
									<input type="radio" name="05fc6ebd991645d2addf5940d61ef1f6_1" onchange="doSave('N','05fc6ebd991645d2addf5940d61ef1f6',this);" value="7" id="05fc6ebd991645d2addf5940d61ef1f6_7" attrtype="">
									<label for="05fc6ebd991645d2addf5940d61ef1f6_7">7完全没有　</label>
									<!-- 下拉-->
							</div>
								<!-- 
								<div style="clear: both !important" attrName="录入值"></div>
							
								 -->
						<div style="clear: both !important"></div>
			</td>
	 			<!-- 多次录入 -->
	 			</tr>
	 			<!-- 设置moduleCode -->
	 		<tr>
	 				<th style="text-align: left;padding-left: 10px;">
	 					26． 过去2 周，您有多少时间因意外弄脏内裤而烦恼 请从下列选项中选择一项：</th>
	 			</tr>
	 			<tr>
	 			<!-- 单次录入 -->
	 			<td>
		 				
<!-- <!doctype html public "-/w3c/dtd xhtml 1.0 transitional/en" "http://www.w3.org/tr/xhtml1/dtd/xhtml1-transitional.dtd"> -->





	<!-- 设置宽度 -->
	<!-- 单位 -->
							<div style="clear: both !important" attrname="录入值"></div>
							<div style="float:left;"> 
								<!-- 文本/日期 --> 
								<!-- 大文本 -->
							<!-- 单选/复选 -->
							<input type="radio" name="70218e2076614e44b059bb1f02bdb87b_1" onchange="doSave('N','70218e2076614e44b059bb1f02bdb87b',this);" value="1" id="70218e2076614e44b059bb1f02bdb87b_1" attrtype="">
									<label for="70218e2076614e44b059bb1f02bdb87b_1">1所有时间　</label>
									<input type="radio" name="70218e2076614e44b059bb1f02bdb87b_1" onchange="doSave('N','70218e2076614e44b059bb1f02bdb87b',this);" value="2" id="70218e2076614e44b059bb1f02bdb87b_2" attrtype="">
									<label for="70218e2076614e44b059bb1f02bdb87b_2">2大部分时间　</label>
									<input type="radio" name="70218e2076614e44b059bb1f02bdb87b_1" onchange="doSave('N','70218e2076614e44b059bb1f02bdb87b',this);" value="3" id="70218e2076614e44b059bb1f02bdb87b_3" attrtype="">
									<label for="70218e2076614e44b059bb1f02bdb87b_3">3很多时间　</label>
									<input type="radio" name="70218e2076614e44b059bb1f02bdb87b_1" onchange="doSave('N','70218e2076614e44b059bb1f02bdb87b',this);" value="4" id="70218e2076614e44b059bb1f02bdb87b_4" attrtype="">
									<label for="70218e2076614e44b059bb1f02bdb87b_4">4有些时间　</label>
									<input type="radio" name="70218e2076614e44b059bb1f02bdb87b_1" onchange="doSave('N','70218e2076614e44b059bb1f02bdb87b',this);" value="5" id="70218e2076614e44b059bb1f02bdb87b_5" attrtype="">
									<label for="70218e2076614e44b059bb1f02bdb87b_5">5少部分时间　</label>
									<input type="radio" name="70218e2076614e44b059bb1f02bdb87b_1" onchange="doSave('N','70218e2076614e44b059bb1f02bdb87b',this);" value="6" id="70218e2076614e44b059bb1f02bdb87b_6" attrtype="">
									<label for="70218e2076614e44b059bb1f02bdb87b_6">6很少时间　</label>
									<input type="radio" name="70218e2076614e44b059bb1f02bdb87b_1" onchange="doSave('N','70218e2076614e44b059bb1f02bdb87b',this);" value="7" id="70218e2076614e44b059bb1f02bdb87b_7" attrtype="">
									<label for="70218e2076614e44b059bb1f02bdb87b_7">7完全没有　</label>
									<!-- 下拉-->
							</div>
								<!-- 
								<div style="clear: both !important" attrName="录入值"></div>
							
								 -->
						<div style="clear: both !important"></div>
			</td>
	 			<!-- 多次录入 -->
	 			</tr>
	 			<!-- 设置moduleCode -->
	 		<tr>
	 				<th style="text-align: left;padding-left: 10px;">
	 					27． 过去2 周，您有多少时间因肠道问题而感到愤怒 请从下列选项中选择一项：</th>
	 			</tr>
	 			<tr>
	 			<!-- 单次录入 -->
	 			<td>
		 				
<!-- <!doctype html public "-/w3c/dtd xhtml 1.0 transitional/en" "http://www.w3.org/tr/xhtml1/dtd/xhtml1-transitional.dtd"> -->





	<!-- 设置宽度 -->
	<!-- 单位 -->
							<div style="clear: both !important" attrname="录入值"></div>
							<div style="float:left;"> 
								<!-- 文本/日期 --> 
								<!-- 大文本 -->
							<!-- 单选/复选 -->
							<input type="radio" name="5ce91991977046b2b87b084fa9dca313_1" onchange="doSave('N','5ce91991977046b2b87b084fa9dca313',this);" value="1" id="5ce91991977046b2b87b084fa9dca313_1" attrtype="">
									<label for="5ce91991977046b2b87b084fa9dca313_1">1所有时间　</label>
									<input type="radio" name="5ce91991977046b2b87b084fa9dca313_1" onchange="doSave('N','5ce91991977046b2b87b084fa9dca313',this);" value="2" id="5ce91991977046b2b87b084fa9dca313_2" attrtype="">
									<label for="5ce91991977046b2b87b084fa9dca313_2">2大部分时间　</label>
									<input type="radio" name="5ce91991977046b2b87b084fa9dca313_1" onchange="doSave('N','5ce91991977046b2b87b084fa9dca313',this);" value="3" id="5ce91991977046b2b87b084fa9dca313_3" attrtype="">
									<label for="5ce91991977046b2b87b084fa9dca313_3">3很多时间　</label>
									<input type="radio" name="5ce91991977046b2b87b084fa9dca313_1" onchange="doSave('N','5ce91991977046b2b87b084fa9dca313',this);" value="4" id="5ce91991977046b2b87b084fa9dca313_4" attrtype="">
									<label for="5ce91991977046b2b87b084fa9dca313_4">4有些时间　</label>
									<input type="radio" name="5ce91991977046b2b87b084fa9dca313_1" onchange="doSave('N','5ce91991977046b2b87b084fa9dca313',this);" value="5" id="5ce91991977046b2b87b084fa9dca313_5" attrtype="">
									<label for="5ce91991977046b2b87b084fa9dca313_5">5少部分时间　</label>
									<input type="radio" name="5ce91991977046b2b87b084fa9dca313_1" onchange="doSave('N','5ce91991977046b2b87b084fa9dca313',this);" value="6" id="5ce91991977046b2b87b084fa9dca313_6" attrtype="">
									<label for="5ce91991977046b2b87b084fa9dca313_6">6很少时间　</label>
									<input type="radio" name="5ce91991977046b2b87b084fa9dca313_1" onchange="doSave('N','5ce91991977046b2b87b084fa9dca313',this);" value="7" id="5ce91991977046b2b87b084fa9dca313_7" attrtype="">
									<label for="5ce91991977046b2b87b084fa9dca313_7">7完全没有　</label>
									<!-- 下拉-->
							</div>
								<!-- 
								<div style="clear: both !important" attrName="录入值"></div>
							
								 -->
						<div style="clear: both !important"></div>
			</td>
	 			<!-- 多次录入 -->
	 			</tr>
	 			<!-- 设置moduleCode -->
	 		<tr>
	 				<th style="text-align: left;padding-left: 10px;">
	 					28． 过去2 周，您的肠道问题在多大程度上限制了您的性生活 请从下列选项中选择一项：</th>
	 			</tr>
	 			<tr>
	 			<!-- 单次录入 -->
	 			<td>
		 				
<!-- <!doctype html public "-/w3c/dtd xhtml 1.0 transitional/en" "http://www.w3.org/tr/xhtml1/dtd/xhtml1-transitional.dtd"> -->





	<!-- 设置宽度 -->
	<!-- 单位 -->
							<div style="clear: both !important" attrname="录入值"></div>
							<div style="float:left;"> 
								<!-- 文本/日期 --> 
								<!-- 大文本 -->
							<!-- 单选/复选 -->
							<input type="radio" name="bdb50f5508224873bb07e80eae4a59fc_1" onchange="doSave('N','bdb50f5508224873bb07e80eae4a59fc',this);" value="1" id="bdb50f5508224873bb07e80eae4a59fc_1" attrtype="">
									<label for="bdb50f5508224873bb07e80eae4a59fc_1">1因肠病之故没有性生活　</label>
									<input type="radio" name="bdb50f5508224873bb07e80eae4a59fc_1" onchange="doSave('N','bdb50f5508224873bb07e80eae4a59fc',this);" value="2" id="bdb50f5508224873bb07e80eae4a59fc_2" attrtype="">
									<label for="bdb50f5508224873bb07e80eae4a59fc_2">2因肠病之故严重受限　</label>
									<input type="radio" name="bdb50f5508224873bb07e80eae4a59fc_1" onchange="doSave('N','bdb50f5508224873bb07e80eae4a59fc',this);" value="3" id="bdb50f5508224873bb07e80eae4a59fc_3" attrtype="">
									<label for="bdb50f5508224873bb07e80eae4a59fc_3">3因肠病之故中度受限　</label>
									<input type="radio" name="bdb50f5508224873bb07e80eae4a59fc_1" onchange="doSave('N','bdb50f5508224873bb07e80eae4a59fc',this);" value="4" id="bdb50f5508224873bb07e80eae4a59fc_4" attrtype="">
									<label for="bdb50f5508224873bb07e80eae4a59fc_4">4因肠病之故有一些限制　</label>
									<input type="radio" name="bdb50f5508224873bb07e80eae4a59fc_1" onchange="doSave('N','bdb50f5508224873bb07e80eae4a59fc',this);" value="5" id="bdb50f5508224873bb07e80eae4a59fc_5" attrtype="">
									<label for="bdb50f5508224873bb07e80eae4a59fc_5">5因肠病之故稍有限制　</label>
									<input type="radio" name="bdb50f5508224873bb07e80eae4a59fc_1" onchange="doSave('N','bdb50f5508224873bb07e80eae4a59fc',this);" value="6" id="bdb50f5508224873bb07e80eae4a59fc_6" attrtype="">
									<label for="bdb50f5508224873bb07e80eae4a59fc_6">6极少因肠病之故受限制　</label>
									<input type="radio" name="bdb50f5508224873bb07e80eae4a59fc_1" onchange="doSave('N','bdb50f5508224873bb07e80eae4a59fc',this);" value="7" id="bdb50f5508224873bb07e80eae4a59fc_7" attrtype="">
									<label for="bdb50f5508224873bb07e80eae4a59fc_7">7并未因肠病而受限制　</label>
									<!-- 下拉-->
							</div>
								<!-- 
								<div style="clear: both !important" attrName="录入值"></div>
							
								 -->
						<div style="clear: both !important"></div>
			</td>
	 			<!-- 多次录入 -->
	 			</tr>
	 			<!-- 设置moduleCode -->
	 		<tr>
	 				<th style="text-align: left;padding-left: 10px;">
	 					29． 过去2 周， 您有多少时间因恶心、胃部不适而烦恼 请从下列选项中选择一项：</th>
	 			</tr>
	 			<tr>
	 			<!-- 单次录入 -->
	 			<td>
		 				
<!-- <!doctype html public "-/w3c/dtd xhtml 1.0 transitional/en" "http://www.w3.org/tr/xhtml1/dtd/xhtml1-transitional.dtd"> -->





	<!-- 设置宽度 -->
	<!-- 单位 -->
							<div style="clear: both !important" attrname="录入值"></div>
							<div style="float:left;"> 
								<!-- 文本/日期 --> 
								<!-- 大文本 -->
							<!-- 单选/复选 -->
							<input type="radio" name="0402b3c46ab5498ea1bc875cb198d293_1" onchange="doSave('N','0402b3c46ab5498ea1bc875cb198d293',this);" value="1" id="0402b3c46ab5498ea1bc875cb198d293_1" attrtype="">
									<label for="0402b3c46ab5498ea1bc875cb198d293_1">1所有时间　</label>
									<input type="radio" name="0402b3c46ab5498ea1bc875cb198d293_1" onchange="doSave('N','0402b3c46ab5498ea1bc875cb198d293',this);" value="2" id="0402b3c46ab5498ea1bc875cb198d293_2" attrtype="">
									<label for="0402b3c46ab5498ea1bc875cb198d293_2">2大部分时间　</label>
									<input type="radio" name="0402b3c46ab5498ea1bc875cb198d293_1" onchange="doSave('N','0402b3c46ab5498ea1bc875cb198d293',this);" value="3" id="0402b3c46ab5498ea1bc875cb198d293_3" attrtype="">
									<label for="0402b3c46ab5498ea1bc875cb198d293_3">3很多时间　</label>
									<input type="radio" name="0402b3c46ab5498ea1bc875cb198d293_1" onchange="doSave('N','0402b3c46ab5498ea1bc875cb198d293',this);" value="4" id="0402b3c46ab5498ea1bc875cb198d293_4" attrtype="">
									<label for="0402b3c46ab5498ea1bc875cb198d293_4">4有些时间　</label>
									<input type="radio" name="0402b3c46ab5498ea1bc875cb198d293_1" onchange="doSave('N','0402b3c46ab5498ea1bc875cb198d293',this);" value="5" id="0402b3c46ab5498ea1bc875cb198d293_5" attrtype="">
									<label for="0402b3c46ab5498ea1bc875cb198d293_5">5少部分时间　</label>
									<input type="radio" name="0402b3c46ab5498ea1bc875cb198d293_1" onchange="doSave('N','0402b3c46ab5498ea1bc875cb198d293',this);" value="6" id="0402b3c46ab5498ea1bc875cb198d293_6" attrtype="">
									<label for="0402b3c46ab5498ea1bc875cb198d293_6">6很少时间　</label>
									<input type="radio" name="0402b3c46ab5498ea1bc875cb198d293_1" onchange="doSave('N','0402b3c46ab5498ea1bc875cb198d293',this);" value="7" id="0402b3c46ab5498ea1bc875cb198d293_7" attrtype="">
									<label for="0402b3c46ab5498ea1bc875cb198d293_7">7完全没有　</label>
									<!-- 下拉-->
							</div>
								<!-- 
								<div style="clear: both !important" attrName="录入值"></div>
							
								 -->
						<div style="clear: both !important"></div>
			</td>
	 			<!-- 多次录入 -->
	 			</tr>
	 			<!-- 设置moduleCode -->
	 		<tr>
	 				<th style="text-align: left;padding-left: 10px;">
	 					30． 过去2 周，您有多少时间感到急躁易怒 请从下列选项中选择一项：</th>
	 			</tr>
	 			<tr>
	 			<!-- 单次录入 -->
	 			<td>
		 				
<!-- <!doctype html public "-/w3c/dtd xhtml 1.0 transitional/en" "http://www.w3.org/tr/xhtml1/dtd/xhtml1-transitional.dtd"> -->





	<!-- 设置宽度 -->
	<!-- 单位 -->
							<div style="clear: both !important" attrname="录入值"></div>
							<div style="float:left;"> 
								<!-- 文本/日期 --> 
								<!-- 大文本 -->
							<!-- 单选/复选 -->
							<input type="radio" name="d96a08ed4c854de68072af1e2a710695_1" onchange="doSave('N','d96a08ed4c854de68072af1e2a710695',this);" value="1" id="d96a08ed4c854de68072af1e2a710695_1" attrtype="">
									<label for="d96a08ed4c854de68072af1e2a710695_1">1 所有时间　</label>
									<input type="radio" name="d96a08ed4c854de68072af1e2a710695_1" onchange="doSave('N','d96a08ed4c854de68072af1e2a710695',this);" value="2" id="d96a08ed4c854de68072af1e2a710695_2" attrtype="">
									<label for="d96a08ed4c854de68072af1e2a710695_2">2大部分时间　</label>
									<input type="radio" name="d96a08ed4c854de68072af1e2a710695_1" onchange="doSave('N','d96a08ed4c854de68072af1e2a710695',this);" value="3" id="d96a08ed4c854de68072af1e2a710695_3" attrtype="">
									<label for="d96a08ed4c854de68072af1e2a710695_3">3很多时间　</label>
									<input type="radio" name="d96a08ed4c854de68072af1e2a710695_1" onchange="doSave('N','d96a08ed4c854de68072af1e2a710695',this);" value="4" id="d96a08ed4c854de68072af1e2a710695_4" attrtype="">
									<label for="d96a08ed4c854de68072af1e2a710695_4">4有些时间　</label>
									<input type="radio" name="d96a08ed4c854de68072af1e2a710695_1" onchange="doSave('N','d96a08ed4c854de68072af1e2a710695',this);" value="5" id="d96a08ed4c854de68072af1e2a710695_5" attrtype="">
									<label for="d96a08ed4c854de68072af1e2a710695_5">5少部分时间　</label>
									<input type="radio" name="d96a08ed4c854de68072af1e2a710695_1" onchange="doSave('N','d96a08ed4c854de68072af1e2a710695',this);" value="6" id="d96a08ed4c854de68072af1e2a710695_6" attrtype="">
									<label for="d96a08ed4c854de68072af1e2a710695_6">6很少时间　</label>
									<input type="radio" name="d96a08ed4c854de68072af1e2a710695_1" onchange="doSave('N','d96a08ed4c854de68072af1e2a710695',this);" value="7" id="d96a08ed4c854de68072af1e2a710695_7" attrtype="">
									<label for="d96a08ed4c854de68072af1e2a710695_7">7完全没有　</label>
									<!-- 下拉-->
							</div>
								<!-- 
								<div style="clear: both !important" attrName="录入值"></div>
							
								 -->
						<div style="clear: both !important"></div>
			</td>
	 			<!-- 多次录入 -->
	 			</tr>
	 			<!-- 设置moduleCode -->
	 		<tr>
	 				<th style="text-align: left;padding-left: 10px;">
	 					32． 过去2 周，您对个人生活感到有多满意、幸福或开心 请从下列选项中选择一项：</th>
	 			</tr>
	 			<tr>
	 			<!-- 单次录入 -->
	 			<td>
		 				
<!-- <!doctype html public "-/w3c/dtd xhtml 1.0 transitional/en" "http://www.w3.org/tr/xhtml1/dtd/xhtml1-transitional.dtd"> -->





	<!-- 设置宽度 -->
	<!-- 单位 -->
							<div style="clear: both !important" attrname="录入值"></div>
							<div style="float:left;"> 
								<!-- 文本/日期 --> 
								<!-- 大文本 -->
							<!-- 单选/复选 -->
							<input type="radio" name="46edd24df7a84bf8831b304c33818aef_1" onchange="doSave('N','46edd24df7a84bf8831b304c33818aef',this);" value="1" id="46edd24df7a84bf8831b304c33818aef_1" attrtype="">
									<label for="46edd24df7a84bf8831b304c33818aef_1">1大部分时间感到非常不满意、不幸福　</label>
									<input type="radio" name="46edd24df7a84bf8831b304c33818aef_1" onchange="doSave('N','46edd24df7a84bf8831b304c33818aef',this);" value="2" id="46edd24df7a84bf8831b304c33818aef_2" attrtype="">
									<label for="46edd24df7a84bf8831b304c33818aef_2">2总体来说不满意、不幸福　</label>
									<input type="radio" name="46edd24df7a84bf8831b304c33818aef_1" onchange="doSave('N','46edd24df7a84bf8831b304c33818aef',this);" value="3" id="46edd24df7a84bf8831b304c33818aef_3" attrtype="">
									<label for="46edd24df7a84bf8831b304c33818aef_3">3有些不满意、不幸福　</label>
									<input type="radio" name="46edd24df7a84bf8831b304c33818aef_1" onchange="doSave('N','46edd24df7a84bf8831b304c33818aef',this);" value="4" id="46edd24df7a84bf8831b304c33818aef_4" attrtype="">
									<label for="46edd24df7a84bf8831b304c33818aef_4">4总体来说满意、开心　</label>
									<input type="radio" name="46edd24df7a84bf8831b304c33818aef_1" onchange="doSave('N','46edd24df7a84bf8831b304c33818aef',this);" value="5" id="46edd24df7a84bf8831b304c33818aef_5" attrtype="">
									<label for="46edd24df7a84bf8831b304c33818aef_5">5大部分时间感到满意、幸福　</label>
									<input type="radio" name="46edd24df7a84bf8831b304c33818aef_1" onchange="doSave('N','46edd24df7a84bf8831b304c33818aef',this);" value="6" id="46edd24df7a84bf8831b304c33818aef_6" attrtype="">
									<label for="46edd24df7a84bf8831b304c33818aef_6">6大部分时间感到非常满意、幸福　</label>
									<input type="radio" name="46edd24df7a84bf8831b304c33818aef_1" onchange="doSave('N','46edd24df7a84bf8831b304c33818aef',this);" value="7" id="46edd24df7a84bf8831b304c33818aef_7" attrtype="">
									<label for="46edd24df7a84bf8831b304c33818aef_7">7特别满意，没有比现在更幸福、开心了　</label>
									<!-- 下拉-->
							</div>
								<!-- 
								<div style="clear: both !important" attrName="录入值"></div>
							
								 -->
						<div style="clear: both !important"></div>
			</td>
	 			<!-- 多次录入 -->
	 			</tr>
	 			<!-- 设置moduleCode -->
	 		<tr>
	 				<th style="text-align: left;padding-left: 10px;">
	 					31． 过去2 周，您有多少时间感到缺乏他人的理解 请从下列选项中选择一项：</th>
	 			</tr>
	 			<tr>
	 			<!-- 单次录入 -->
	 			<td>
		 				
<!-- <!doctype html public "-/w3c/dtd xhtml 1.0 transitional/en" "http://www.w3.org/tr/xhtml1/dtd/xhtml1-transitional.dtd"> -->





	<!-- 设置宽度 -->
	<!-- 单位 -->
							<div style="clear: both !important" attrname="录入值"></div>
							<div style="float:left;"> 
								<!-- 文本/日期 --> 
								<!-- 大文本 -->
							<!-- 单选/复选 -->
							<input type="radio" name="2f0243f6a12e44c8be65de99509c2998_1" onchange="doSave('N','2f0243f6a12e44c8be65de99509c2998',this);" value="1" id="2f0243f6a12e44c8be65de99509c2998_1" attrtype="">
									<label for="2f0243f6a12e44c8be65de99509c2998_1">1所有时间　</label>
									<input type="radio" name="2f0243f6a12e44c8be65de99509c2998_1" onchange="doSave('N','2f0243f6a12e44c8be65de99509c2998',this);" value="2" id="2f0243f6a12e44c8be65de99509c2998_2" attrtype="">
									<label for="2f0243f6a12e44c8be65de99509c2998_2">2大部分时间　</label>
									<input type="radio" name="2f0243f6a12e44c8be65de99509c2998_1" onchange="doSave('N','2f0243f6a12e44c8be65de99509c2998',this);" value="3" id="2f0243f6a12e44c8be65de99509c2998_3" attrtype="">
									<label for="2f0243f6a12e44c8be65de99509c2998_3">3很多时间　</label>
									<input type="radio" name="2f0243f6a12e44c8be65de99509c2998_1" onchange="doSave('N','2f0243f6a12e44c8be65de99509c2998',this);" value="4" id="2f0243f6a12e44c8be65de99509c2998_4" attrtype="">
									<label for="2f0243f6a12e44c8be65de99509c2998_4">4有些时间　</label>
									<input type="radio" name="2f0243f6a12e44c8be65de99509c2998_1" onchange="doSave('N','2f0243f6a12e44c8be65de99509c2998',this);" value="5" id="2f0243f6a12e44c8be65de99509c2998_5" attrtype="">
									<label for="2f0243f6a12e44c8be65de99509c2998_5">5少部分时间　</label>
									<input type="radio" name="2f0243f6a12e44c8be65de99509c2998_1" onchange="doSave('N','2f0243f6a12e44c8be65de99509c2998',this);" value="6" id="2f0243f6a12e44c8be65de99509c2998_6" attrtype="">
									<label for="2f0243f6a12e44c8be65de99509c2998_6">6很少时间　</label>
									<input type="radio" name="2f0243f6a12e44c8be65de99509c2998_1" onchange="doSave('N','2f0243f6a12e44c8be65de99509c2998',this);" value="7" id="2f0243f6a12e44c8be65de99509c2998_7" attrtype="">
									<label for="2f0243f6a12e44c8be65de99509c2998_7">7完全没有　</label>
									<!-- 下拉-->
							</div>
								<!-- 
								<div style="clear: both !important" attrName="录入值"></div>
							
								 -->
						<div style="clear: both !important"></div>
			</td>
	 			<!-- 多次录入 -->
	 			</tr>
	 			<!-- 设置moduleCode -->
	 		<tr>
	 				<th style="text-align: left;padding-left: 10px;">
	 					20． 过去2 周，您有多少时间因腹胀而烦恼 请从下列选项中选择一项：</th>
	 			</tr>
	 			<tr>
	 			<!-- 单次录入 -->
	 			<td>
		 				
<!-- <!doctype html public "-/w3c/dtd xhtml 1.0 transitional/en" "http://www.w3.org/tr/xhtml1/dtd/xhtml1-transitional.dtd"> -->





	<!-- 设置宽度 -->
	<!-- 单位 -->
							<div style="clear: both !important" attrname="录入值"></div>
							<div style="float:left;"> 
								<!-- 文本/日期 --> 
								<!-- 大文本 -->
							<!-- 单选/复选 -->
							<input type="radio" name="a701f98b341840b794d3840efd9d1262_1" onchange="doSave('N','a701f98b341840b794d3840efd9d1262',this);" value="1" id="a701f98b341840b794d3840efd9d1262_1" attrtype="">
									<label for="a701f98b341840b794d3840efd9d1262_1">1 所有时间　</label>
									<input type="radio" name="a701f98b341840b794d3840efd9d1262_1" onchange="doSave('N','a701f98b341840b794d3840efd9d1262',this);" value="2" id="a701f98b341840b794d3840efd9d1262_2" attrtype="">
									<label for="a701f98b341840b794d3840efd9d1262_2">2 大部分时间　</label>
									<input type="radio" name="a701f98b341840b794d3840efd9d1262_1" onchange="doSave('N','a701f98b341840b794d3840efd9d1262',this);" value="3" id="a701f98b341840b794d3840efd9d1262_3" attrtype="">
									<label for="a701f98b341840b794d3840efd9d1262_3">3 很多时间　</label>
									<input type="radio" name="a701f98b341840b794d3840efd9d1262_1" onchange="doSave('N','a701f98b341840b794d3840efd9d1262',this);" value="4" id="a701f98b341840b794d3840efd9d1262_4" attrtype="">
									<label for="a701f98b341840b794d3840efd9d1262_4">4 有些时间　</label>
									<input type="radio" name="a701f98b341840b794d3840efd9d1262_1" onchange="doSave('N','a701f98b341840b794d3840efd9d1262',this);" value="5" id="a701f98b341840b794d3840efd9d1262_5" attrtype="">
									<label for="a701f98b341840b794d3840efd9d1262_5">5 少部分时间　</label>
									<input type="radio" name="a701f98b341840b794d3840efd9d1262_1" onchange="doSave('N','a701f98b341840b794d3840efd9d1262',this);" value="6" id="a701f98b341840b794d3840efd9d1262_6" attrtype="">
									<label for="a701f98b341840b794d3840efd9d1262_6">6 很少时间　</label>
									<input type="radio" name="a701f98b341840b794d3840efd9d1262_1" onchange="doSave('N','a701f98b341840b794d3840efd9d1262',this);" value="7" id="a701f98b341840b794d3840efd9d1262_7" attrtype="">
									<label for="a701f98b341840b794d3840efd9d1262_7">7 完全没有　</label>
									<!-- 下拉-->
							</div>
								<!-- 
								<div style="clear: both !important" attrName="录入值"></div>
							
								 -->
						<div style="clear: both !important"></div>
			</td>
	 			<!-- 多次录入 -->
	 			</tr>
	 			</tbody>
 		</table>
     		 </div>
