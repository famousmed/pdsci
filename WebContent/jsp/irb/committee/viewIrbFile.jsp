<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@include file="/jsp/common/doctype.jsp" %>
<html>
<head>
<jsp:include page="/jsp/common/htmlhead.jsp">
	<jsp:param name="basic" value="true"/>
	<jsp:param name="jbox" value="true"/>
	<jsp:param name="jquery_form" value="false"/>
	<jsp:param name="jquery_ui_tooltip" value="true"/>
	<jsp:param name="jquery_ui_combobox" value="false"/>
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
	function view() {
		
	}
</script>
</head>
<body>
<div class="mainright">
	<div class="content">
	<div class="title1 clearfix">
		<div class="content">
			<table>
				<tr>
					<td width="300px">
						<table class="xllist" width="300px">
							<thead>
								<tr>
									<th width="30px"></th>
									<th>文件名称</th>
								</tr>
								<tr><td>1</td><td style="text-align: left;"><a href="javascript:view();">临床试验申请表（原件）</a></td></tr>
								<tr><td>2</td><td style="text-align: left;"><a href="javascript:view();">未签字的临床研究协议</a></td></tr>
								<tr><td>3</td><td style="text-align: left;"><a href="javascript:view();">临床委托书（包括与CRO、研究机构）</a></td></tr>
								<tr><td>4</td><td style="text-align: left;"><a href="javascript:view();">国家食品药品监督管理局（CFDA）新药临床研究批件（Ⅳ期可免）</a></td></tr>
								<tr><td>5</td><td style="text-align: left;"><a href="javascript:view();">牵头单位伦理委员会批件；</a></td></tr>
								<tr><td>6</td><td style="text-align: left;"><a href="javascript:view();">多中心研究单位一览表</a></td></tr>
								<tr><td>7</td><td style="text-align: left;"><a href="javascript:view();">申办者资质/CRO（营业执照、生产许可证、GMP证书）</a></td></tr>
								<tr><td>8</td><td style="text-align: left;"><a href="javascript:view();">药品注册证书</a></td></tr>
								<tr><td>9</td><td style="text-align: left;"><a href="javascript:view();">药检报告</a></td></tr>
								<tr><td>10</td><td style="text-align: left;"><a href="javascript:view();">临床研究方案（请注明版本编号和日期，有申办者、研究者共同签字或盖章）</a></td></tr>
								<tr><td>11</td><td style="text-align: left;"><a href="javascript:view();">病例报告表（请注明版本号和日期）</a></td></tr>
								<tr><td>12</td><td style="text-align: left;"><a href="javascript:view();">知情同意书（请注明版本号和日期）</a></td></tr>
								<tr><td>13</td><td style="text-align: left;"><a href="javascript:view();">研究者手册（请注明版本号和日期，IV期须提供药物说明书）；</a></td></tr>
								<tr><td>14</td><td style="text-align: left;"><a href="javascript:view();">主要研究者简历（GCP复印件）；</a></td></tr>
								<tr><td>15</td><td style="text-align: left;"><a href="javascript:view();">研究者履历及相关文件（所有研究者）；</a></td></tr>
								<tr><td>16</td><td style="text-align: left;"><a href="javascript:view();">临床试验有关的实验室检测正常值范围；</a></td></tr>
							</tbody>
						</table>
					</td>
					<td valign="top" style="height: 600px">
						<embed src="<s:url value='/jsp/irb/meeting/123.swf'/>" width="650" height="100%"
			                 play="true" 
			                 ALIGN="middle" 
			                 loop="true" 
			                 quality="high"
			                 type="application/x-shockwave-flash"
			                 flashvars="zoomtype=3"
			                 pluginspage="http://www.macromedia.com/go/getflashplayer">
			          </embed>
								</td>
				</tr>
			</table>
			<div class="button" style="width: 900px;">
				<input type="button" class="search" onclick="jboxClose();" value="关闭">
			</div>
		</div>
	</div>
	</div></div>
</body>
</html>