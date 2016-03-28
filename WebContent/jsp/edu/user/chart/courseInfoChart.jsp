<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib prefix="any" uri="http://www.anychart.com" %>
<any:chart width="100%" height="400px">
		 <charts>
			<chart plot_type="CategorizedVertical">
			<data_plot_settings default_series_type="Bar" enable_3d_mode="false"  z_aspect="2">
			<bar_series point_padding="0.2" group_padding="0.5">
			<tooltip_settings enabled="true" />
			</bar_series>
			</data_plot_settings>
			<chart_settings>
			<title enabled="true">
			<text>课程信息统计图</text><!--标题-->
			<font family="Microsoft YaHei" color="#404040" size="18" bold="True" italic="False" underline="False" render_as_html="False" /> 
			</title>
			<axes>
			<x_axis>
			  <title>
              	<text>课程</text>
              	<font family="Microsoft YaHei" color="#404040" size="16" bold="True" italic="False" underline="False" render_as_html="False" /> 
              </title>
            <zoom enabled="true" inside="true"   visible_range="5" />
            <labels>
            <font family="Microsoft YaHei" color="#404040" size="14" bold="false" italic="False" underline="False" render_as_html="False" /> 
            </labels>
			</x_axis>
			<y_axis >
			 <title>
              <text>人数</text>
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
				<series name="学习人数" color="#80c2f2">
				<c:forEach items="${courseList }" var="course">
				<point name="${course.courseName}" y="${studentCountMap[course.courseFlow] }" />
				</c:forEach>
				</series>
				
				<series name="完成人数" color="#f5a566">
				<c:forEach items="${courseList }" var="course">
				<point name="${course.courseName}" y="${studyFinishCountMap[course.courseFlow] }" />
				</c:forEach>
				</series>
				
				<series name="未完成人数" color="#ff7d7d">
				<c:forEach items="${courseList }" var="course">
				<point name="${course.courseName}" y="${studyNotFinishCountMap[course.courseFlow] }" />
				</c:forEach>
				</series>
				
			</data>
			</chart>
		</charts>
</any:chart>