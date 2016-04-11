<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib prefix="any" uri="http://www.anychart.com" %>
<any:chart width="100%" height="400px">
		 <charts>
			<chart plot_type="CategorizedVertical">
			<!-- <data_plot_settings default_series_type="Bar" enable_3d_mode="false"  z_aspect="2">
			<bar_series point_padding="0.2" group_padding="0.5">
			<tooltip_settings enabled="true" />
			</bar_series>
			</data_plot_settings> -->
			 <data_plot_settings default_series_type="Line" >
			<bar_series point_padding="0.2" group_padding="0.5">
			<tooltip_settings enabled="true" />
			</bar_series>
			</data_plot_settings>
			<chart_settings>
			<title enabled="true">
			<text>学习进度统计图</text><!--标题-->
			<font family="Microsoft YaHei" color="#404040" size="18" bold="True" italic="False" underline="False" render_as_html="False" />
			</title>
			<axes>
			<x_axis>
			<title>
              <text>学校</text>
              <font family="Microsoft YaHei" color="#404040" size="16" bold="True" italic="False" underline="False" render_as_html="False" />
            </title>
            <c:if test="${fn:length(orgList)> 5 }">
            <zoom enabled="true" inside="true"   visible_range="5" />
            </c:if>
            <labels>
            <font family="Microsoft YaHei" color="#404040" size="14" bold="false" italic="False" underline="False" render_as_html="False" /> 
            </labels> 
			</x_axis>
			<y_axis>
			<title>
              <text>完成人数</text>
              <font family="Microsoft YaHei" color="#404040" size="16" bold="True" italic="False" underline="False" render_as_html="False" />
            </title>  
			<zero_line color="Red" opacity="0.5" /><!-- Y轴  颜色  透明度-->
			<labels>
			<format><![CDATA[{%Value}{numDecimals:0}]]></format>
			<font family="Microsoft YaHei" color="#404040" size="14" bold="false" italic="False" underline="False" render_as_html="False" />
			</labels>
			</y_axis>
			</axes>
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
	            <item source="Series" /> 
	          </items> 
	        </legend>
	         <chart_background enabled="true">  
			    <border enabled="false">  
			      <fill enabled="false" />  
			    </border>  
			  </chart_background>
			</chart_settings>
			<data>
				<c:forEach items="${courseList }" var="course">
				<series name="${course.courseName }">
				<c:forEach items="${orgList }" var="org">
				<point name="${org.orgName}" y="${orgAndCourseMap[org.orgFlow][course.courseFlow] }" />
				</c:forEach>
				</series>
				</c:forEach>
			</data>
			</chart>
		</charts>
</any:chart>