<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="any" uri="http://www.anychart.com" %>
    <any:chart width="700px" height="300px">
  <charts>
    <chart plot_type="Pie">
    <data_plot_settings enable_3d_mode="true">
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
        <series name="series1" type="Pie">
         <c:forEach items="${eduStudyStatusEnumList}" var="sEnum" varStatus="status">
         <c:set var="myColor"/>
         <c:choose>
         	<c:when test="${status.first }"><c:set var="myColor" value="#80c2f2"/></c:when>
         	<c:when test="${status.last }"><c:set var="myColor" value="#f5a566"/></c:when>
         	<c:otherwise><c:set var="myColor" value="#ff7d7d"/></c:otherwise>
         </c:choose>
          <point name="${sEnum.name }" y="${countMap[sEnum.id] }"  color="${myColor }" />
          </c:forEach>
        </series>
      </data>
     <chart_settings>
		<title enabled="true" padding="15">
			<text>学习进度统计图</text>
			<font family="Microsoft YaHei" color="#404040" size="18" bold="True" italic="False" underline="False" render_as_html="False" /> 
		</title>
		<legend enabled="true"  position="Right"  align="Center" ignore_auto_item="true" padding="15"> 
          <format>{%Icon} {%Name}</format>
          <font family="Microsoft YaHei" color="#404040"  size="14" bold="false" italic="False" underline="False" render_as_html="False" /> 
          <template> 
          </template> 
          <title enabled="true" padding="10"> 
            <text>统计项目</text> 
            <font family="Microsoft YaHei" color="#404040"  size="14" bold="True" italic="False" underline="False" render_as_html="False" />
          </title> 
          <columns_separator enabled="false" /> 
          <background> 
            <inside_margin left="10" right="10" /> 
          </background> 
          <items> 
            <item source="Points" /> 
          </items> 
        </legend>
        <chart_background enabled="true">  
			    <border enabled="false">  
			      <fill enabled="false" />  
			    </border>  
			  </chart_background> 
	</chart_settings>
    </chart>
  </charts>
</any:chart>