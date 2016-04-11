<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@include file="/jsp/common/doctype.jsp" %>
<html>
<head>
<jsp:include page="/jsp/common/htmlhead.jsp">
	<jsp:param name="basic" value="true"/>
	<jsp:param name="jbox" value="true"/>
	<jsp:param name="jquery_form" value="true"/>
	<jsp:param name="jquery_ui_tooltip" value="true"/>
	<jsp:param name="jquery_ui_combobox" value="true"/>
	<jsp:param name="jquery_ui_sortable" value="false"/>
	<jsp:param name="jquery_cxselect" value="false"/>
	<jsp:param name="jquery_scrollTo" value="false"/>
	<jsp:param name="jquery_jcallout" value="false"/>
	<jsp:param name="jquery_validation" value="true"/>
	<jsp:param name="jquery_datePicker" value="true"/>
	<jsp:param name="jquery_fullcalendar" value="false"/>
	<jsp:param name="jquery_fngantt" value="false"/>
	<jsp:param name="jquery_fixedtableheader" value="true"/>
	<jsp:param name="jquery_placeholder" value="true"/>
	<jsp:param name="jquery_iealert" value="false"/>
</jsp:include>
<script type="text/javascript">
	 function save(){
		var ret = testPatientCode();
		if(ret){
			var form = $("#saveForm");
			if(form.validationEngine("validate")){
				jboxConfirm("确认该次入库操作？",function(){
					var url = "<s:url value='/gcp/drug/saveDrugIn'/>";
					jboxSubmit(form,url,function(resp){
						if(resp=='${GlobalConstant.SAVE_SUCCESSED}'){
							jboxTip('${GlobalConstant.SAVE_SUCCESSED}');
							window.parent.frames['mainIframe'].location.reload(true);
							jboxClose();
						}else if(resp!="${GlobalConstant.SAVE_FAIL}"){
							jboxInfo(resp);
						}
					},function(){
						jboxTip('${GlobalConstant.SAVE_FAIL}');
					},false);
				},null);
			}
		}

	} 
	
	function shCode(){
		if( $("input[name='code']:checked").val()=="y"){
			$("#code_title").show();
			$(".code_content").show();
		}else{
			$("#code_title").hide();
			$(".code_content").hide();
			$("#code_content").attr("colspan","2");
		}
	}
	
	function testPatientCode(){
		result = true;
		var patientCode=new Array;//所有编码的集合
			var count=0;//计算出的编码总数
			var input =$("#drugPack");
			if(input.val()!=""){
				//检查格式
				if(input.val().match(/(((,|-)[^0-9]))|([^0-9](,|-))|([^0123456789,-])|(-\d+-)|(^[^0-9])|([^0-9]$)/g)!=null){
					jboxTip("请正确填写[编码分配]\n格式为：1-20,21,22,30-40等内容.");
					input.focus();
					return false;
				}
				//解析字符串
				var temp=input.val().match(/(\d+-\d+(?=,|$))|(\d+)/g);
				if (temp==null){
					jboxTip("请正确填写[编码分配]\n格式为：1-20,21,22,30-40等内容.");
					input.focus();
					result = false;
				}
				var content="";
				for(var j=0;j<temp.length;j++){
					//分析每组数据
					ind=temp[j].indexOf("-");
					if (ind<0){
						//单个值
						var k=parseInt(temp[j]);
						//检查 重复
						if(patientCode[k]==null||patientCode[k]==0){
							//加入集合
							patientCode[k]=1;
							count++;
							content=content+","+k;
						}else{
							//有重复,警告
							jboxTip("编号 "+k+" 重复指定");
							input.focus();
							result = false;
						}
					}else{
						//范围
						var t=temp[j].split("-");
						var startn,endn;
						startn=parseInt(t[0]);
						endn=parseInt(t[1]);
						if(endn<=startn){
							jboxTip("请正确填写[编码分配]\n格式为：1-20,21,22,30-40等内容.");
							input.focus();
							result = false;
						}
						for (k=startn;k<=endn;k++){
							//检查 重复
							if(patientCode[k]==null||patientCode[k]==0){
								//加入集合
								patientCode[k]=1;
								count++;
								content=content+","+k;
							}else{
								//有重复,警告
								jboxTip("编号"+k+"重复指定");
								input.focus();
								result = false;
							}
						}
					}
				}
				content=(content).slice(-(content.length-1));
			}
		return result;
	}
	
	function doClose(){
		jboxClose();
	}
</script>
</head>
<body>
	<div class="mainright">
	<div class="content">
			<div class="title1 clearfix">
				<form id="saveForm"  method="post" style="position: relative;"> 
				<input type="hidden" name="drugFlow" value='${drug.drugFlow}'/>
				<input type="hidden" name="projFlow" value='${drug.projFlow}'/>
				<table width="100%" cellpadding="0" cellspacing="0" class="basic" style="min-width: 680px;">
					<tr>
					   <th colspan="4" style="text-align: left;padding-left: 10px;">药物入库信息</th>
					</tr>
					<tr>
					   <td style="text-align: right">药物名称：</td>
					   <td>
					      ${drug.drugName }
					   </td>
					   <td style="text-align: right">规&#12288;&#12288;格：</td>
					   <td>
					      ${drug.spec }
					   </td>
					</tr>
					 <tr>
					   <td style="text-align: right">有无编码：</td>
					   <td>
					       <input type="radio" name="code" id="code_y" onchange="shCode();" value="y" checked/><label for="code_y">有</label>
					       &nbsp;<input type="radio" name="code" id="code_n" onchange="shCode();" value="n" /><label for="code_n">无</label>
					   </td>
					   <td id="code_title" style="text-align: right">药物编码：</td>
					   <td id="code_content">
					      <input class="code_content xltext validate[required]" type="text" id="drugPack" name="drugPack" onblur="testPatientCode();" value="${drugIn.drugPack }" />
					   	  <span class="code_content red">*</span>
					   </td>
					 </tr>
					 <tr>
					   <td style="text-align: right">入库日期：</td>
					   <td>
					      <input type="text" name="inDate" value="${pdfn:getCurrDate() }" class="xltext validate[required]" onClick="WdatePicker({dateFmt:'yyyy-MM-dd'})"/>
					      <span class="red">*</span>
					   </td>
					   <td style="text-align: right">入库数量：</td>
					   <td>
					      <input type="text" name="drugAmount" value="${drugIn.drugAmount }"class="xltext validate[custom[number]]"/>
					   </td>
					 </tr>
					 
					 <tr>
					 <td style="text-align: right">批&#12288;&#12288;号：</td>
					   <td>
					      <input type="text" name="lotNo" value="${drugIn.lotNo }"class="xltext validate[required]"/><span class="red">*</span>
					   </td>
					   <td colspan="2"></td>
					 </tr>
					
				</table>
			</form>
		</div>
		<div style="width: 100%;" align="center" >
			<input class="search" type="button" value="保&#12288;存" onclick="save()"  />
			<input class="search" type="button" value="关&#12288;闭" onclick="doClose()"  />
		</div>
</div></div>
</body>
</html>