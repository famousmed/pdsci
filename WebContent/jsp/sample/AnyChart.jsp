<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="any" uri="http://www.anychart.com" %>
<html>
  <head>
      <title>AnyChart external data sample</title>
  </head>
  <body> 
    <any:chart width="550px" height="400px">
    	<anychart>
			<settings>
			    <context_menu version_info="false" about_anychart="false" print_chart="false" save_as_image="true" save_as_pdf="false">
			      <save_as_image_item_text><![CDATA[另存为图片]]></save_as_image_item_text>
			      <print_chart_item_text><![CDATA[打 印 ]]></print_chart_item_text>
			      <save_as_pdf_item_text><![CDATA[导出PDF]]></save_as_pdf_item_text>
			    </context_menu>
			    <image_export url="<s:url value='/jsp/common/AnyChartPNGSaver.jsp'/>" use_title_as_file_name="true" />
			    <animation enabled="true" /> 
			  </settings>
		    <charts>
    <chart plot_type="CategorizedBySeriesVertical">
      <data_plot_settings default_series_type="Bar">
        <bar_series point_padding="-0.4" group_padding="10">
          <tooltip_settings enabled="True" />
        </bar_series>
      </data_plot_settings>
      <data>
        <series name="">
          <point name="John" y="10000" />
          <point name="Jake" y="12000" />
          <point name="Peter" y="18000" />
          <point name="James" y="11000" />
          <point name="1" y="9000" />
          <point name="2" y="10000" />
          <point name="3" y="12000" />
          <point name="4" y="17000" />
          <point name="5" y="11000" />
          <point name="6" y="9000" />
          <point name="7" y="10000" />
          <point name="8" y="12000" />
          <point name="9" y="18000" />
          <point name="10" y="11000" />
          <point name="11" y="9000" />
          <point name="12" y="10000" />
          <point name="13" y="12000" />
          <point name="14" y="18000" />
          <point name="15" y="11000" />
          <point name="16" y="9000" />
          <point name="17" y="10000" />
          <point name="18" y="12000" />
          <point name="19" y="18000" />
          <point name="20" y="11000" />
          <point name="21" y="9000" />
        </series>
      </data>
      <chart_settings>
        <title enabled="False" />
        <axes>
          <y_axis>
            <title>
              <text>Sales</text>
            </title>
            <labels>
              <format>{%Value}{numDecimals:0}</format>
            </labels>
          </y_axis>
          <x_axis>
            <title>
              <text>年龄</text>
            </title>
          </x_axis>
        </axes>
      </chart_settings>
    </chart>
  </charts>
		</anychart>
    </any:chart>
  </body>
</html>