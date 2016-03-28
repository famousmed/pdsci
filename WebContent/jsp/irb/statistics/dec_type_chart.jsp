<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="any" uri="http://www.anychart.com" %>
<html>
  <body>
    <any:chart width="550px" height="300px">
  <charts>
    <chart plot_type="Pie">
    <data_plot_settings enable_3d_mode="True">
		<pie_series>
			<tooltip_settings enabled="true">
<format>
{%Name}
	数量：{%YValue}{numDecimals:0} 
</format>

			</tooltip_settings>
			<label_settings enabled="true">
				<background enabled="false"/>
				<position anchor="Center" valign="Center" halign="Center" padding="20"/>
				<font color="White">
					<effects>
						<drop_shadow enabled="true" distance="2" opacity="0.5" blur_x="2" blur_y="2"/>
					</effects>
				</font>
				<format>{%YPercentOfSeries}</format>
			</label_settings>

		</pie_series>
	</data_plot_settings>
      <data>
        <series name="Year 2003" palette="Default">
         <c:forEach items="${irbDecisionEnumList}" var="type" >
          <point name="${type.name }" y="${decCountMap[type.id] }" />
          </c:forEach>
        </series>
      </data>
     <chart_settings>
		<title enabled="true" padding="15">
			<text>决定情况</text>
		</title>
	</chart_settings>
    </chart>
  </charts>
</any:chart></body></html>