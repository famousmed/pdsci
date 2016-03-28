<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>江苏省住院医师规范化培训管理平台</title>
<jsp:include page="/jsp/jsres/htmlhead-jsres.jsp">
	<jsp:param name="basic" value="true"/>
	<jsp:param name="jbox" value="true"/>
	<jsp:param name="font" value="true"/>
</jsp:include>
<script type="text/javascript">
</script>
</head>
<body>
	<div class="infoAudit">
			<div class="div_table">
			<h4>基本信息</h4>
			<table border="0" cellpadding="0" cellspacing="0" class="base_info">
			<colgroup>
				<col width="15%"/>
				<col width="30%"/>
				<col width="15%"/>
				<col width="21%"/>
				<col width="19%"/>
			</colgroup>
			<tbody>
			    <tr>
			    	<th>姓&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;名：</th>
			        <td>艾雨超</td>
			        <th>性&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;别：</th>
			        <td>男</td>
			        <td rowspan="5"></td>
			    </tr>
			    <tr>
			    	<th>证件类型：</th>
			        <td>身份证</td>
			        <th>证&nbsp;&nbsp;件&nbsp;&nbsp;号：</th>
			        <td>3205861991021354</td>
				</tr>
			    <tr>
			    	<th>民&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;族：</th>
			        <td>汉族</td>
			        <th>生&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;日：</th>
			        <td>1991-02-13</td>
			        
			    </tr>
			    <tr>
			    	<th>手&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;机：</th>
			        <td>13912634845</td>
			        <th>固定电话：</th>
			        <td>0512-65436949</td>
               </tr>
			    <tr>
			    	<th>计算机能力：</th>
			        <td>其它</td>
			        <th>外语能力：</th>
			        <td>四级</td>
			    </tr>
			    <tr>
			    	<th>电子邮箱：</th>
			        <td colspan="4">mlqc901@163.com</td>
			    </tr>
			    <tr>
			    	<th>人员类型：</th>
			        <td>单位人</td>
			        <th>工作单位：</th>
			        <td colspan="2">苏州九龙医院</td>
			    </tr>
			    <tr>
			    	<th>本人通讯地址：</th>
			        <td colspan="4"></td>
			    </tr>
			    <tr>
			    	<th>紧急联系人：</th>
			        <td></td>
			        <th>联系人手机：</th>
			        <td colspan="2"></td>
			    </tr>
			    <tr>
			    	<th>紧急联系人地址：</th>
			        <td colspan="4"></td>
			    </tr>
			 </tbody>
		</table>
	</div>
	<div class="div_table">
		<h4>教育情况</h4>		
		<table border="0" cellpadding="0" cellspacing="0" class="base_info">
			<colgroup>
				<col width="15%"/>
				<col width="30%"/>
				<col width="15%"/>
				<col width="40%"/>
			</colgroup>
			<tbody>
			     <tr>
			    	<th>毕业院校：</th>
			        <td colspan="4">徐州医学院</td>
			    </tr>
			     <tr>
			    	<th>毕业专业：</th>
			        <td>麻醉学</td>
			        <th>毕业时间：</th>
			        <td colspan="2">2013-06-28</td>
			    </tr>
			    <tr>
			    	<th>最高学历：</th>
			        <td>本科</td>
			        <th>毕业证书编号：</th>
			        <td colspan="2">10313120125019<a style="color:#459ae9;float:right;margin-right:30px;">查看学历证书</a></td>			       
			    </tr>
			    <tr>
			    	<th>最高学位：</th>
			        <td>学士</td>
			        <th>学院证书编号：</th>
			        <td colspan="2">1031342013001549<a style="color:#459ae9;float:right;margin-right:30px;">查看学位证书</a></td>	      
			    </tr>
			 </tbody>
		</table></div>
		<div class="div_table">	
		<h4>现有资格信息</h4>
		<table border="0" align="center" cellpadding="0" cellspacing="0" class="base_info">
		<colgroup>
				<col width="15%"/>
				<col width="30%"/>
				<col width="15%"/>
				<col width="40%"/>
			</colgroup>
			<tbody>
			    <tr>
			    	<th>专业技术资格：</th>
			        <td>无</td>
			        <th>取得日期：</th>
			        <td colspan="2">无</td>
			    </tr>
			     <tr>
			    	<th>执业资格材料：</th>
			        <td>无</td>
			        <th>资格材料编码：</th>
			        <td colspan="2">无</td>
			    </tr>
			     <tr>
			    	<th>执业类别：</th>
			        <td>无</td>
			        <th>执业类别：</th>
			        <td colspan="2">无</td>
			    </tr>
			  </tbody>
			</table>
		</div>
		
		
		<div class="btn_info">
			<c:if test="${'audit'==param.type }">
			<input type="button" style="width:100px;" class="btn_blue" onclick="" value="通过"></input>
			<input type="button" style="width:100px;" class="btn_red" onclick="" value="不通过"></input>
			</c:if>
			<input type="button" style="width:100px;" class="btn_grey" onclick="javascript:jboxClose();" value="关闭"></input>
		</div>
	</div>
</body>
</html>