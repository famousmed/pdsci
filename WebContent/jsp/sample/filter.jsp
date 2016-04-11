<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="any" uri="http://www.anychart.com" %>
<html>
  <head>
      <title>AnyChart external data sample</title>
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
  </head>
  <body>
    
    	
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
		        <chart>
		            <chart_settings>
		                <title>
		                    <text><![CDATA[Product sales by Month]]></text>
		                </title>
		                <axes>
		                    <x_axis>
		                        <title>
		                            <text><![CDATA[Months]]></text>
		                        </title>
		                    </x_axis>
		                    <y_axis>
		                        <title>
		                            <text><![CDATA[Sales]]></text>
		                        </title>
		                    </y_axis>
		                </axes>
		            </chart_settings>
		            <data>
		                <series>
		                    <point name="Jan" y="21" />
		                    <point name="Feb" y="32" />
		                    <point name="Mar" y="43" />
		                    <point name="Apr" y="54" />
		                </series>
		            </data>
		        </chart>
		    </charts>
		</anychart>
		
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
		        <chart>
		            <chart_settings>
		                <title>
		                    <text><![CDATA[Product sales by Month]]></text>
		                </title>
		                <axes>
		                    <x_axis>
		                        <title>
		                            <text><![CDATA[Months]]></text>
		                        </title>
		                    </x_axis>
		                    <y_axis>
		                        <title>
		                            <text><![CDATA[Sales]]></text>
		                        </title>
		                    </y_axis>
		                </axes>
		            </chart_settings>
		            <data>
		                <series>
		                    <point name="Jan" y="21" />
		                    <point name="Feb" y="32" />
		                    <point name="Mar" y="43" />
		                    <point name="Apr" y="54" />
		                </series>
		            </data>
		        </chart>
		    </charts>
		</anychart>
		
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
		        <chart>
		            <chart_settings>
		                <title>
		                    <text><![CDATA[Product sales by Month]]></text>
		                </title>
		                <axes>
		                    <x_axis>
		                        <title>
		                            <text><![CDATA[Months]]></text>
		                        </title>
		                    </x_axis>
		                    <y_axis>
		                        <title>
		                            <text><![CDATA[Sales]]></text>
		                        </title>
		                    </y_axis>
		                </axes>
		            </chart_settings>
		            <data>
		                <series>
		                    <point name="Jan" y="21" />
		                    <point name="Feb" y="32" />
		                    <point name="Mar" y="43" />
		                    <point name="Apr" y="54" />
		                </series>
		            </data>
		        </chart>
		    </charts>
		</anychart>
		
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
		        <chart>
		            <chart_settings>
		                <title>
		                    <text><![CDATA[Product sales by Month]]></text>
		                </title>
		                <axes>
		                    <x_axis>
		                        <title>
		                            <text><![CDATA[Months]]></text>
		                        </title>
		                    </x_axis>
		                    <y_axis>
		                        <title>
		                            <text><![CDATA[Sales]]></text>
		                        </title>
		                    </y_axis>
		                </axes>
		            </chart_settings>
		            <data>
		                <series>
		                    <point name="Jan" y="21" />
		                    <point name="Feb" y="32" />
		                    <point name="Mar" y="43" />
		                    <point name="Apr" y="54" />
		                </series>
		            </data>
		        </chart>
		    </charts>
		</anychart>
		
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
		        <chart>
		            <chart_settings>
		                <title>
		                    <text><![CDATA[Product sales by Month]]></text>
		                </title>
		                <axes>
		                    <x_axis>
		                        <title>
		                            <text><![CDATA[Months]]></text>
		                        </title>
		                    </x_axis>
		                    <y_axis>
		                        <title>
		                            <text><![CDATA[Sales]]></text>
		                        </title>
		                    </y_axis>
		                </axes>
		            </chart_settings>
		            <data>
		                <series>
		                    <point name="Jan" y="21" />
		                    <point name="Feb" y="32" />
		                    <point name="Mar" y="43" />
		                    <point name="Apr" y="54" />
		                </series>
		            </data>
		        </chart>
		    </charts>
		</anychart>
    
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
		        <chart>
		            <chart_settings>
		                <title>
		                    <text><![CDATA[Product sales by Month]]></text>
		                </title>
		                <axes>
		                    <x_axis>
		                        <title>
		                            <text><![CDATA[Months]]></text>
		                        </title>
		                    </x_axis>
		                    <y_axis>
		                        <title>
		                            <text><![CDATA[Sales]]></text>
		                        </title>
		                    </y_axis>
		                </axes>
		            </chart_settings>
		            <data>
		                <series>
		                    <point name="Jan" y="21" />
		                    <point name="Feb" y="32" />
		                    <point name="Mar" y="43" />
		                    <point name="Apr" y="54" />
		                </series>
		            </data>
		        </chart>
		    </charts>
		</anychart>
		
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
		        <chart>
		            <chart_settings>
		                <title>
		                    <text><![CDATA[Product sales by Month]]></text>
		                </title>
		                <axes>
		                    <x_axis>
		                        <title>
		                            <text><![CDATA[Months]]></text>
		                        </title>
		                    </x_axis>
		                    <y_axis>
		                        <title>
		                            <text><![CDATA[Sales]]></text>
		                        </title>
		                    </y_axis>
		                </axes>
		            </chart_settings>
		            <data>
		                <series>
		                    <point name="Jan" y="21" />
		                    <point name="Feb" y="32" />
		                    <point name="Mar" y="43" />
		                    <point name="Apr" y="54" />
		                </series>
		            </data>
		        </chart>
		    </charts>
		</anychart>
		
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
		        <chart>
		            <chart_settings>
		                <title>
		                    <text><![CDATA[Product sales by Month]]></text>
		                </title>
		                <axes>
		                    <x_axis>
		                        <title>
		                            <text><![CDATA[Months]]></text>
		                        </title>
		                    </x_axis>
		                    <y_axis>
		                        <title>
		                            <text><![CDATA[Sales]]></text>
		                        </title>
		                    </y_axis>
		                </axes>
		            </chart_settings>
		            <data>
		                <series>
		                    <point name="Jan" y="21" />
		                    <point name="Feb" y="32" />
		                    <point name="Mar" y="43" />
		                    <point name="Apr" y="54" />
		                </series>
		            </data>
		        </chart>
		    </charts>
		</anychart>
		
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
		        <chart>
		            <chart_settings>
		                <title>
		                    <text><![CDATA[Product sales by Month]]></text>
		                </title>
		                <axes>
		                    <x_axis>
		                        <title>
		                            <text><![CDATA[Months]]></text>
		                        </title>
		                    </x_axis>
		                    <y_axis>
		                        <title>
		                            <text><![CDATA[Sales]]></text>
		                        </title>
		                    </y_axis>
		                </axes>
		            </chart_settings>
		            <data>
		                <series>
		                    <point name="Jan" y="21" />
		                    <point name="Feb" y="32" />
		                    <point name="Mar" y="43" />
		                    <point name="Apr" y="54" />
		                </series>
		            </data>
		        </chart>
		    </charts>
		</anychart>
		
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
		        <chart>
		            <chart_settings>
		                <title>
		                    <text><![CDATA[Product sales by Month]]></text>
		                </title>
		                <axes>
		                    <x_axis>
		                        <title>
		                            <text><![CDATA[Months]]></text>
		                        </title>
		                    </x_axis>
		                    <y_axis>
		                        <title>
		                            <text><![CDATA[Sales]]></text>
		                        </title>
		                    </y_axis>
		                </axes>
		            </chart_settings>
		            <data>
		                <series>
		                    <point name="Jan" y="21" />
		                    <point name="Feb" y="32" />
		                    <point name="Mar" y="43" />
		                    <point name="Apr" y="54" />
		                </series>
		            </data>
		        </chart>
		    </charts>
		</anychart>
		
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
		        <chart>
		            <chart_settings>
		                <title>
		                    <text><![CDATA[Product sales by Month]]></text>
		                </title>
		                <axes>
		                    <x_axis>
		                        <title>
		                            <text><![CDATA[Months]]></text>
		                        </title>
		                    </x_axis>
		                    <y_axis>
		                        <title>
		                            <text><![CDATA[Sales]]></text>
		                        </title>
		                    </y_axis>
		                </axes>
		            </chart_settings>
		            <data>
		                <series>
		                    <point name="Jan" y="21" />
		                    <point name="Feb" y="32" />
		                    <point name="Mar" y="43" />
		                    <point name="Apr" y="54" />
		                </series>
		            </data>
		        </chart>
		    </charts>
		</anychart>
		
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
		        <chart>
		            <chart_settings>
		                <title>
		                    <text><![CDATA[Product sales by Month]]></text>
		                </title>
		                <axes>
		                    <x_axis>
		                        <title>
		                            <text><![CDATA[Months]]></text>
		                        </title>
		                    </x_axis>
		                    <y_axis>
		                        <title>
		                            <text><![CDATA[Sales]]></text>
		                        </title>
		                    </y_axis>
		                </axes>
		            </chart_settings>
		            <data>
		                <series>
		                    <point name="Jan" y="21" />
		                    <point name="Feb" y="32" />
		                    <point name="Mar" y="43" />
		                    <point name="Apr" y="54" />
		                </series>
		            </data>
		        </chart>
		    </charts>
		</anychart>
    
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
		        <chart>
		            <chart_settings>
		                <title>
		                    <text><![CDATA[Product sales by Month]]></text>
		                </title>
		                <axes>
		                    <x_axis>
		                        <title>
		                            <text><![CDATA[Months]]></text>
		                        </title>
		                    </x_axis>
		                    <y_axis>
		                        <title>
		                            <text><![CDATA[Sales]]></text>
		                        </title>
		                    </y_axis>
		                </axes>
		            </chart_settings>
		            <data>
		                <series>
		                    <point name="Jan" y="21" />
		                    <point name="Feb" y="32" />
		                    <point name="Mar" y="43" />
		                    <point name="Apr" y="54" />
		                </series>
		            </data>
		        </chart>
		    </charts>
		</anychart>
		
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
		        <chart>
		            <chart_settings>
		                <title>
		                    <text><![CDATA[Product sales by Month]]></text>
		                </title>
		                <axes>
		                    <x_axis>
		                        <title>
		                            <text><![CDATA[Months]]></text>
		                        </title>
		                    </x_axis>
		                    <y_axis>
		                        <title>
		                            <text><![CDATA[Sales]]></text>
		                        </title>
		                    </y_axis>
		                </axes>
		            </chart_settings>
		            <data>
		                <series>
		                    <point name="Jan" y="21" />
		                    <point name="Feb" y="32" />
		                    <point name="Mar" y="43" />
		                    <point name="Apr" y="54" />
		                </series>
		            </data>
		        </chart>
		    </charts>
		</anychart>
		
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
		        <chart>
		            <chart_settings>
		                <title>
		                    <text><![CDATA[Product sales by Month]]></text>
		                </title>
		                <axes>
		                    <x_axis>
		                        <title>
		                            <text><![CDATA[Months]]></text>
		                        </title>
		                    </x_axis>
		                    <y_axis>
		                        <title>
		                            <text><![CDATA[Sales]]></text>
		                        </title>
		                    </y_axis>
		                </axes>
		            </chart_settings>
		            <data>
		                <series>
		                    <point name="Jan" y="21" />
		                    <point name="Feb" y="32" />
		                    <point name="Mar" y="43" />
		                    <point name="Apr" y="54" />
		                </series>
		            </data>
		        </chart>
		    </charts>
		</anychart>
		
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
		        <chart>
		            <chart_settings>
		                <title>
		                    <text><![CDATA[Product sales by Month]]></text>
		                </title>
		                <axes>
		                    <x_axis>
		                        <title>
		                            <text><![CDATA[Months]]></text>
		                        </title>
		                    </x_axis>
		                    <y_axis>
		                        <title>
		                            <text><![CDATA[Sales]]></text>
		                        </title>
		                    </y_axis>
		                </axes>
		            </chart_settings>
		            <data>
		                <series>
		                    <point name="Jan" y="21" />
		                    <point name="Feb" y="32" />
		                    <point name="Mar" y="43" />
		                    <point name="Apr" y="54" />
		                </series>
		            </data>
		        </chart>
		    </charts>
		</anychart>
		
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
		        <chart>
		            <chart_settings>
		                <title>
		                    <text><![CDATA[Product sales by Month]]></text>
		                </title>
		                <axes>
		                    <x_axis>
		                        <title>
		                            <text><![CDATA[Months]]></text>
		                        </title>
		                    </x_axis>
		                    <y_axis>
		                        <title>
		                            <text><![CDATA[Sales]]></text>
		                        </title>
		                    </y_axis>
		                </axes>
		            </chart_settings>
		            <data>
		                <series>
		                    <point name="Jan" y="21" />
		                    <point name="Feb" y="32" />
		                    <point name="Mar" y="43" />
		                    <point name="Apr" y="54" />
		                </series>
		            </data>
		        </chart>
		    </charts>
		</anychart>
		
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
		        <chart>
		            <chart_settings>
		                <title>
		                    <text><![CDATA[Product sales by Month]]></text>
		                </title>
		                <axes>
		                    <x_axis>
		                        <title>
		                            <text><![CDATA[Months]]></text>
		                        </title>
		                    </x_axis>
		                    <y_axis>
		                        <title>
		                            <text><![CDATA[Sales]]></text>
		                        </title>
		                    </y_axis>
		                </axes>
		            </chart_settings>
		            <data>
		                <series>
		                    <point name="Jan" y="21" />
		                    <point name="Feb" y="32" />
		                    <point name="Mar" y="43" />
		                    <point name="Apr" y="54" />
		                </series>
		            </data>
		        </chart>
		    </charts>
		</anychart>
		
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
		        <chart>
		            <chart_settings>
		                <title>
		                    <text><![CDATA[Product sales by Month]]></text>
		                </title>
		                <axes>
		                    <x_axis>
		                        <title>
		                            <text><![CDATA[Months]]></text>
		                        </title>
		                    </x_axis>
		                    <y_axis>
		                        <title>
		                            <text><![CDATA[Sales]]></text>
		                        </title>
		                    </y_axis>
		                </axes>
		            </chart_settings>
		            <data>
		                <series>
		                    <point name="Jan" y="21" />
		                    <point name="Feb" y="32" />
		                    <point name="Mar" y="43" />
		                    <point name="Apr" y="54" />
		                </series>
		            </data>
		        </chart>
		    </charts>
		</anychart>
    
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
		        <chart>
		            <chart_settings>
		                <title>
		                    <text><![CDATA[Product sales by Month]]></text>
		                </title>
		                <axes>
		                    <x_axis>
		                        <title>
		                            <text><![CDATA[Months]]></text>
		                        </title>
		                    </x_axis>
		                    <y_axis>
		                        <title>
		                            <text><![CDATA[Sales]]></text>
		                        </title>
		                    </y_axis>
		                </axes>
		            </chart_settings>
		            <data>
		                <series>
		                    <point name="Jan" y="21" />
		                    <point name="Feb" y="32" />
		                    <point name="Mar" y="43" />
		                    <point name="Apr" y="54" />
		                </series>
		            </data>
		        </chart>
		    </charts>
		</anychart>
		
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
		        <chart>
		            <chart_settings>
		                <title>
		                    <text><![CDATA[Product sales by Month]]></text>
		                </title>
		                <axes>
		                    <x_axis>
		                        <title>
		                            <text><![CDATA[Months]]></text>
		                        </title>
		                    </x_axis>
		                    <y_axis>
		                        <title>
		                            <text><![CDATA[Sales]]></text>
		                        </title>
		                    </y_axis>
		                </axes>
		            </chart_settings>
		            <data>
		                <series>
		                    <point name="Jan" y="21" />
		                    <point name="Feb" y="32" />
		                    <point name="Mar" y="43" />
		                    <point name="Apr" y="54" />
		                </series>
		            </data>
		        </chart>
		    </charts>
		</anychart>
		
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
		        <chart>
		            <chart_settings>
		                <title>
		                    <text><![CDATA[Product sales by Month]]></text>
		                </title>
		                <axes>
		                    <x_axis>
		                        <title>
		                            <text><![CDATA[Months]]></text>
		                        </title>
		                    </x_axis>
		                    <y_axis>
		                        <title>
		                            <text><![CDATA[Sales]]></text>
		                        </title>
		                    </y_axis>
		                </axes>
		            </chart_settings>
		            <data>
		                <series>
		                    <point name="Jan" y="21" />
		                    <point name="Feb" y="32" />
		                    <point name="Mar" y="43" />
		                    <point name="Apr" y="54" />
		                </series>
		            </data>
		        </chart>
		    </charts>
		</anychart>
		
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
		        <chart>
		            <chart_settings>
		                <title>
		                    <text><![CDATA[Product sales by Month]]></text>
		                </title>
		                <axes>
		                    <x_axis>
		                        <title>
		                            <text><![CDATA[Months]]></text>
		                        </title>
		                    </x_axis>
		                    <y_axis>
		                        <title>
		                            <text><![CDATA[Sales]]></text>
		                        </title>
		                    </y_axis>
		                </axes>
		            </chart_settings>
		            <data>
		                <series>
		                    <point name="Jan" y="21" />
		                    <point name="Feb" y="32" />
		                    <point name="Mar" y="43" />
		                    <point name="Apr" y="54" />
		                </series>
		            </data>
		        </chart>
		    </charts>
		</anychart>
		
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
		        <chart>
		            <chart_settings>
		                <title>
		                    <text><![CDATA[Product sales by Month]]></text>
		                </title>
		                <axes>
		                    <x_axis>
		                        <title>
		                            <text><![CDATA[Months]]></text>
		                        </title>
		                    </x_axis>
		                    <y_axis>
		                        <title>
		                            <text><![CDATA[Sales]]></text>
		                        </title>
		                    </y_axis>
		                </axes>
		            </chart_settings>
		            <data>
		                <series>
		                    <point name="Jan" y="21" />
		                    <point name="Feb" y="32" />
		                    <point name="Mar" y="43" />
		                    <point name="Apr" y="54" />
		                </series>
		            </data>
		        </chart>
		    </charts>
		</anychart>
		
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
		        <chart>
		            <chart_settings>
		                <title>
		                    <text><![CDATA[Product sales by Month]]></text>
		                </title>
		                <axes>
		                    <x_axis>
		                        <title>
		                            <text><![CDATA[Months]]></text>
		                        </title>
		                    </x_axis>
		                    <y_axis>
		                        <title>
		                            <text><![CDATA[Sales]]></text>
		                        </title>
		                    </y_axis>
		                </axes>
		            </chart_settings>
		            <data>
		                <series>
		                    <point name="Jan" y="21" />
		                    <point name="Feb" y="32" />
		                    <point name="Mar" y="43" />
		                    <point name="Apr" y="54" />
		                </series>
		            </data>
		        </chart>
		    </charts>
		</anychart>
		
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
		        <chart>
		            <chart_settings>
		                <title>
		                    <text><![CDATA[Product sales by Month]]></text>
		                </title>
		                <axes>
		                    <x_axis>
		                        <title>
		                            <text><![CDATA[Months]]></text>
		                        </title>
		                    </x_axis>
		                    <y_axis>
		                        <title>
		                            <text><![CDATA[Sales]]></text>
		                        </title>
		                    </y_axis>
		                </axes>
		            </chart_settings>
		            <data>
		                <series>
		                    <point name="Jan" y="21" />
		                    <point name="Feb" y="32" />
		                    <point name="Mar" y="43" />
		                    <point name="Apr" y="54" />
		                </series>
		            </data>
		        </chart>
		    </charts>
		</anychart>
    
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
		        <chart>
		            <chart_settings>
		                <title>
		                    <text><![CDATA[Product sales by Month]]></text>
		                </title>
		                <axes>
		                    <x_axis>
		                        <title>
		                            <text><![CDATA[Months]]></text>
		                        </title>
		                    </x_axis>
		                    <y_axis>
		                        <title>
		                            <text><![CDATA[Sales]]></text>
		                        </title>
		                    </y_axis>
		                </axes>
		            </chart_settings>
		            <data>
		                <series>
		                    <point name="Jan" y="21" />
		                    <point name="Feb" y="32" />
		                    <point name="Mar" y="43" />
		                    <point name="Apr" y="54" />
		                </series>
		            </data>
		        </chart>
		    </charts>
		</anychart>
		
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
		        <chart>
		            <chart_settings>
		                <title>
		                    <text><![CDATA[Product sales by Month]]></text>
		                </title>
		                <axes>
		                    <x_axis>
		                        <title>
		                            <text><![CDATA[Months]]></text>
		                        </title>
		                    </x_axis>
		                    <y_axis>
		                        <title>
		                            <text><![CDATA[Sales]]></text>
		                        </title>
		                    </y_axis>
		                </axes>
		            </chart_settings>
		            <data>
		                <series>
		                    <point name="Jan" y="21" />
		                    <point name="Feb" y="32" />
		                    <point name="Mar" y="43" />
		                    <point name="Apr" y="54" />
		                </series>
		            </data>
		        </chart>
		    </charts>
		</anychart>
		
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
		        <chart>
		            <chart_settings>
		                <title>
		                    <text><![CDATA[Product sales by Month]]></text>
		                </title>
		                <axes>
		                    <x_axis>
		                        <title>
		                            <text><![CDATA[Months]]></text>
		                        </title>
		                    </x_axis>
		                    <y_axis>
		                        <title>
		                            <text><![CDATA[Sales]]></text>
		                        </title>
		                    </y_axis>
		                </axes>
		            </chart_settings>
		            <data>
		                <series>
		                    <point name="Jan" y="21" />
		                    <point name="Feb" y="32" />
		                    <point name="Mar" y="43" />
		                    <point name="Apr" y="54" />
		                </series>
		            </data>
		        </chart>
		    </charts>
		</anychart>
		
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
		        <chart>
		            <chart_settings>
		                <title>
		                    <text><![CDATA[Product sales by Month]]></text>
		                </title>
		                <axes>
		                    <x_axis>
		                        <title>
		                            <text><![CDATA[Months]]></text>
		                        </title>
		                    </x_axis>
		                    <y_axis>
		                        <title>
		                            <text><![CDATA[Sales]]></text>
		                        </title>
		                    </y_axis>
		                </axes>
		            </chart_settings>
		            <data>
		                <series>
		                    <point name="Jan" y="21" />
		                    <point name="Feb" y="32" />
		                    <point name="Mar" y="43" />
		                    <point name="Apr" y="54" />
		                </series>
		            </data>
		        </chart>
		    </charts>
		</anychart>
		
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
		        <chart>
		            <chart_settings>
		                <title>
		                    <text><![CDATA[Product sales by Month]]></text>
		                </title>
		                <axes>
		                    <x_axis>
		                        <title>
		                            <text><![CDATA[Months]]></text>
		                        </title>
		                    </x_axis>
		                    <y_axis>
		                        <title>
		                            <text><![CDATA[Sales]]></text>
		                        </title>
		                    </y_axis>
		                </axes>
		            </chart_settings>
		            <data>
		                <series>
		                    <point name="Jan" y="21" />
		                    <point name="Feb" y="32" />
		                    <point name="Mar" y="43" />
		                    <point name="Apr" y="54" />
		                </series>
		            </data>
		        </chart>
		    </charts>
		</anychart>
		
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
		        <chart>
		            <chart_settings>
		                <title>
		                    <text><![CDATA[Product sales by Month]]></text>
		                </title>
		                <axes>
		                    <x_axis>
		                        <title>
		                            <text><![CDATA[Months]]></text>
		                        </title>
		                    </x_axis>
		                    <y_axis>
		                        <title>
		                            <text><![CDATA[Sales]]></text>
		                        </title>
		                    </y_axis>
		                </axes>
		            </chart_settings>
		            <data>
		                <series>
		                    <point name="Jan" y="21" />
		                    <point name="Feb" y="32" />
		                    <point name="Mar" y="43" />
		                    <point name="Apr" y="54" />
		                </series>
		            </data>
		        </chart>
		    </charts>
		</anychart>
		
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
		        <chart>
		            <chart_settings>
		                <title>
		                    <text><![CDATA[Product sales by Month]]></text>
		                </title>
		                <axes>
		                    <x_axis>
		                        <title>
		                            <text><![CDATA[Months]]></text>
		                        </title>
		                    </x_axis>
		                    <y_axis>
		                        <title>
		                            <text><![CDATA[Sales]]></text>
		                        </title>
		                    </y_axis>
		                </axes>
		            </chart_settings>
		            <data>
		                <series>
		                    <point name="Jan" y="21" />
		                    <point name="Feb" y="32" />
		                    <point name="Mar" y="43" />
		                    <point name="Apr" y="54" />
		                </series>
		            </data>
		        </chart>
		    </charts>
		</anychart>
    
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
		        <chart>
		            <chart_settings>
		                <title>
		                    <text><![CDATA[Product sales by Month]]></text>
		                </title>
		                <axes>
		                    <x_axis>
		                        <title>
		                            <text><![CDATA[Months]]></text>
		                        </title>
		                    </x_axis>
		                    <y_axis>
		                        <title>
		                            <text><![CDATA[Sales]]></text>
		                        </title>
		                    </y_axis>
		                </axes>
		            </chart_settings>
		            <data>
		                <series>
		                    <point name="Jan" y="21" />
		                    <point name="Feb" y="32" />
		                    <point name="Mar" y="43" />
		                    <point name="Apr" y="54" />
		                </series>
		            </data>
		        </chart>
		    </charts>
		</anychart>
		
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
		        <chart>
		            <chart_settings>
		                <title>
		                    <text><![CDATA[Product sales by Month]]></text>
		                </title>
		                <axes>
		                    <x_axis>
		                        <title>
		                            <text><![CDATA[Months]]></text>
		                        </title>
		                    </x_axis>
		                    <y_axis>
		                        <title>
		                            <text><![CDATA[Sales]]></text>
		                        </title>
		                    </y_axis>
		                </axes>
		            </chart_settings>
		            <data>
		                <series>
		                    <point name="Jan" y="21" />
		                    <point name="Feb" y="32" />
		                    <point name="Mar" y="43" />
		                    <point name="Apr" y="54" />
		                </series>
		            </data>
		        </chart>
		    </charts>
		</anychart>
		
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
		        <chart>
		            <chart_settings>
		                <title>
		                    <text><![CDATA[Product sales by Month]]></text>
		                </title>
		                <axes>
		                    <x_axis>
		                        <title>
		                            <text><![CDATA[Months]]></text>
		                        </title>
		                    </x_axis>
		                    <y_axis>
		                        <title>
		                            <text><![CDATA[Sales]]></text>
		                        </title>
		                    </y_axis>
		                </axes>
		            </chart_settings>
		            <data>
		                <series>
		                    <point name="Jan" y="21" />
		                    <point name="Feb" y="32" />
		                    <point name="Mar" y="43" />
		                    <point name="Apr" y="54" />
		                </series>
		            </data>
		        </chart>
		    </charts>
		</anychart>
		
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
		        <chart>
		            <chart_settings>
		                <title>
		                    <text><![CDATA[Product sales by Month]]></text>
		                </title>
		                <axes>
		                    <x_axis>
		                        <title>
		                            <text><![CDATA[Months]]></text>
		                        </title>
		                    </x_axis>
		                    <y_axis>
		                        <title>
		                            <text><![CDATA[Sales]]></text>
		                        </title>
		                    </y_axis>
		                </axes>
		            </chart_settings>
		            <data>
		                <series>
		                    <point name="Jan" y="21" />
		                    <point name="Feb" y="32" />
		                    <point name="Mar" y="43" />
		                    <point name="Apr" y="54" />
		                </series>
		            </data>
		        </chart>
		    </charts>
		</anychart>
		
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
		        <chart>
		            <chart_settings>
		                <title>
		                    <text><![CDATA[Product sales by Month]]></text>
		                </title>
		                <axes>
		                    <x_axis>
		                        <title>
		                            <text><![CDATA[Months]]></text>
		                        </title>
		                    </x_axis>
		                    <y_axis>
		                        <title>
		                            <text><![CDATA[Sales]]></text>
		                        </title>
		                    </y_axis>
		                </axes>
		            </chart_settings>
		            <data>
		                <series>
		                    <point name="Jan" y="21" />
		                    <point name="Feb" y="32" />
		                    <point name="Mar" y="43" />
		                    <point name="Apr" y="54" />
		                </series>
		            </data>
		        </chart>
		    </charts>
		</anychart>
		
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
		        <chart>
		            <chart_settings>
		                <title>
		                    <text><![CDATA[Product sales by Month]]></text>
		                </title>
		                <axes>
		                    <x_axis>
		                        <title>
		                            <text><![CDATA[Months]]></text>
		                        </title>
		                    </x_axis>
		                    <y_axis>
		                        <title>
		                            <text><![CDATA[Sales]]></text>
		                        </title>
		                    </y_axis>
		                </axes>
		            </chart_settings>
		            <data>
		                <series>
		                    <point name="Jan" y="21" />
		                    <point name="Feb" y="32" />
		                    <point name="Mar" y="43" />
		                    <point name="Apr" y="54" />
		                </series>
		            </data>
		        </chart>
		    </charts>
		</anychart>
		
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
		        <chart>
		            <chart_settings>
		                <title>
		                    <text><![CDATA[Product sales by Month]]></text>
		                </title>
		                <axes>
		                    <x_axis>
		                        <title>
		                            <text><![CDATA[Months]]></text>
		                        </title>
		                    </x_axis>
		                    <y_axis>
		                        <title>
		                            <text><![CDATA[Sales]]></text>
		                        </title>
		                    </y_axis>
		                </axes>
		            </chart_settings>
		            <data>
		                <series>
		                    <point name="Jan" y="21" />
		                    <point name="Feb" y="32" />
		                    <point name="Mar" y="43" />
		                    <point name="Apr" y="54" />
		                </series>
		            </data>
		        </chart>
		    </charts>
		</anychart>
    
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
		        <chart>
		            <chart_settings>
		                <title>
		                    <text><![CDATA[Product sales by Month]]></text>
		                </title>
		                <axes>
		                    <x_axis>
		                        <title>
		                            <text><![CDATA[Months]]></text>
		                        </title>
		                    </x_axis>
		                    <y_axis>
		                        <title>
		                            <text><![CDATA[Sales]]></text>
		                        </title>
		                    </y_axis>
		                </axes>
		            </chart_settings>
		            <data>
		                <series>
		                    <point name="Jan" y="21" />
		                    <point name="Feb" y="32" />
		                    <point name="Mar" y="43" />
		                    <point name="Apr" y="54" />
		                </series>
		            </data>
		        </chart>
		    </charts>
		</anychart>
		
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
		        <chart>
		            <chart_settings>
		                <title>
		                    <text><![CDATA[Product sales by Month]]></text>
		                </title>
		                <axes>
		                    <x_axis>
		                        <title>
		                            <text><![CDATA[Months]]></text>
		                        </title>
		                    </x_axis>
		                    <y_axis>
		                        <title>
		                            <text><![CDATA[Sales]]></text>
		                        </title>
		                    </y_axis>
		                </axes>
		            </chart_settings>
		            <data>
		                <series>
		                    <point name="Jan" y="21" />
		                    <point name="Feb" y="32" />
		                    <point name="Mar" y="43" />
		                    <point name="Apr" y="54" />
		                </series>
		            </data>
		        </chart>
		    </charts>
		</anychart>
		
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
		        <chart>
		            <chart_settings>
		                <title>
		                    <text><![CDATA[Product sales by Month]]></text>
		                </title>
		                <axes>
		                    <x_axis>
		                        <title>
		                            <text><![CDATA[Months]]></text>
		                        </title>
		                    </x_axis>
		                    <y_axis>
		                        <title>
		                            <text><![CDATA[Sales]]></text>
		                        </title>
		                    </y_axis>
		                </axes>
		            </chart_settings>
		            <data>
		                <series>
		                    <point name="Jan" y="21" />
		                    <point name="Feb" y="32" />
		                    <point name="Mar" y="43" />
		                    <point name="Apr" y="54" />
		                </series>
		            </data>
		        </chart>
		    </charts>
		</anychart>
		
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
		        <chart>
		            <chart_settings>
		                <title>
		                    <text><![CDATA[Product sales by Month]]></text>
		                </title>
		                <axes>
		                    <x_axis>
		                        <title>
		                            <text><![CDATA[Months]]></text>
		                        </title>
		                    </x_axis>
		                    <y_axis>
		                        <title>
		                            <text><![CDATA[Sales]]></text>
		                        </title>
		                    </y_axis>
		                </axes>
		            </chart_settings>
		            <data>
		                <series>
		                    <point name="Jan" y="21" />
		                    <point name="Feb" y="32" />
		                    <point name="Mar" y="43" />
		                    <point name="Apr" y="54" />
		                </series>
		            </data>
		        </chart>
		    </charts>
		</anychart>
		
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
		        <chart>
		            <chart_settings>
		                <title>
		                    <text><![CDATA[Product sales by Month]]></text>
		                </title>
		                <axes>
		                    <x_axis>
		                        <title>
		                            <text><![CDATA[Months]]></text>
		                        </title>
		                    </x_axis>
		                    <y_axis>
		                        <title>
		                            <text><![CDATA[Sales]]></text>
		                        </title>
		                    </y_axis>
		                </axes>
		            </chart_settings>
		            <data>
		                <series>
		                    <point name="Jan" y="21" />
		                    <point name="Feb" y="32" />
		                    <point name="Mar" y="43" />
		                    <point name="Apr" y="54" />
		                </series>
		            </data>
		        </chart>
		    </charts>
		</anychart>
		
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
		        <chart>
		            <chart_settings>
		                <title>
		                    <text><![CDATA[Product sales by Month]]></text>
		                </title>
		                <axes>
		                    <x_axis>
		                        <title>
		                            <text><![CDATA[Months]]></text>
		                        </title>
		                    </x_axis>
		                    <y_axis>
		                        <title>
		                            <text><![CDATA[Sales]]></text>
		                        </title>
		                    </y_axis>
		                </axes>
		            </chart_settings>
		            <data>
		                <series>
		                    <point name="Jan" y="21" />
		                    <point name="Feb" y="32" />
		                    <point name="Mar" y="43" />
		                    <point name="Apr" y="54" />
		                </series>
		            </data>
		        </chart>
		    </charts>
		</anychart>
		
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
		        <chart>
		            <chart_settings>
		                <title>
		                    <text><![CDATA[Product sales by Month]]></text>
		                </title>
		                <axes>
		                    <x_axis>
		                        <title>
		                            <text><![CDATA[Months]]></text>
		                        </title>
		                    </x_axis>
		                    <y_axis>
		                        <title>
		                            <text><![CDATA[Sales]]></text>
		                        </title>
		                    </y_axis>
		                </axes>
		            </chart_settings>
		            <data>
		                <series>
		                    <point name="Jan" y="21" />
		                    <point name="Feb" y="32" />
		                    <point name="Mar" y="43" />
		                    <point name="Apr" y="54" />
		                </series>
		            </data>
		        </chart>
		    </charts>
		</anychart>
    
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
		        <chart>
		            <chart_settings>
		                <title>
		                    <text><![CDATA[Product sales by Month]]></text>
		                </title>
		                <axes>
		                    <x_axis>
		                        <title>
		                            <text><![CDATA[Months]]></text>
		                        </title>
		                    </x_axis>
		                    <y_axis>
		                        <title>
		                            <text><![CDATA[Sales]]></text>
		                        </title>
		                    </y_axis>
		                </axes>
		            </chart_settings>
		            <data>
		                <series>
		                    <point name="Jan" y="21" />
		                    <point name="Feb" y="32" />
		                    <point name="Mar" y="43" />
		                    <point name="Apr" y="54" />
		                </series>
		            </data>
		        </chart>
		    </charts>
		</anychart>
		
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
		        <chart>
		            <chart_settings>
		                <title>
		                    <text><![CDATA[Product sales by Month]]></text>
		                </title>
		                <axes>
		                    <x_axis>
		                        <title>
		                            <text><![CDATA[Months]]></text>
		                        </title>
		                    </x_axis>
		                    <y_axis>
		                        <title>
		                            <text><![CDATA[Sales]]></text>
		                        </title>
		                    </y_axis>
		                </axes>
		            </chart_settings>
		            <data>
		                <series>
		                    <point name="Jan" y="21" />
		                    <point name="Feb" y="32" />
		                    <point name="Mar" y="43" />
		                    <point name="Apr" y="54" />
		                </series>
		            </data>
		        </chart>
		    </charts>
		</anychart>
		
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
		        <chart>
		            <chart_settings>
		                <title>
		                    <text><![CDATA[Product sales by Month]]></text>
		                </title>
		                <axes>
		                    <x_axis>
		                        <title>
		                            <text><![CDATA[Months]]></text>
		                        </title>
		                    </x_axis>
		                    <y_axis>
		                        <title>
		                            <text><![CDATA[Sales]]></text>
		                        </title>
		                    </y_axis>
		                </axes>
		            </chart_settings>
		            <data>
		                <series>
		                    <point name="Jan" y="21" />
		                    <point name="Feb" y="32" />
		                    <point name="Mar" y="43" />
		                    <point name="Apr" y="54" />
		                </series>
		            </data>
		        </chart>
		    </charts>
		</anychart>
		
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
		        <chart>
		            <chart_settings>
		                <title>
		                    <text><![CDATA[Product sales by Month]]></text>
		                </title>
		                <axes>
		                    <x_axis>
		                        <title>
		                            <text><![CDATA[Months]]></text>
		                        </title>
		                    </x_axis>
		                    <y_axis>
		                        <title>
		                            <text><![CDATA[Sales]]></text>
		                        </title>
		                    </y_axis>
		                </axes>
		            </chart_settings>
		            <data>
		                <series>
		                    <point name="Jan" y="21" />
		                    <point name="Feb" y="32" />
		                    <point name="Mar" y="43" />
		                    <point name="Apr" y="54" />
		                </series>
		            </data>
		        </chart>
		    </charts>
		</anychart>
		
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
		        <chart>
		            <chart_settings>
		                <title>
		                    <text><![CDATA[Product sales by Month]]></text>
		                </title>
		                <axes>
		                    <x_axis>
		                        <title>
		                            <text><![CDATA[Months]]></text>
		                        </title>
		                    </x_axis>
		                    <y_axis>
		                        <title>
		                            <text><![CDATA[Sales]]></text>
		                        </title>
		                    </y_axis>
		                </axes>
		            </chart_settings>
		            <data>
		                <series>
		                    <point name="Jan" y="21" />
		                    <point name="Feb" y="32" />
		                    <point name="Mar" y="43" />
		                    <point name="Apr" y="54" />
		                </series>
		            </data>
		        </chart>
		    </charts>
		</anychart>
		
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
		        <chart>
		            <chart_settings>
		                <title>
		                    <text><![CDATA[Product sales by Month]]></text>
		                </title>
		                <axes>
		                    <x_axis>
		                        <title>
		                            <text><![CDATA[Months]]></text>
		                        </title>
		                    </x_axis>
		                    <y_axis>
		                        <title>
		                            <text><![CDATA[Sales]]></text>
		                        </title>
		                    </y_axis>
		                </axes>
		            </chart_settings>
		            <data>
		                <series>
		                    <point name="Jan" y="21" />
		                    <point name="Feb" y="32" />
		                    <point name="Mar" y="43" />
		                    <point name="Apr" y="54" />
		                </series>
		            </data>
		        </chart>
		    </charts>
		</anychart>
		
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
		        <chart>
		            <chart_settings>
		                <title>
		                    <text><![CDATA[Product sales by Month]]></text>
		                </title>
		                <axes>
		                    <x_axis>
		                        <title>
		                            <text><![CDATA[Months]]></text>
		                        </title>
		                    </x_axis>
		                    <y_axis>
		                        <title>
		                            <text><![CDATA[Sales]]></text>
		                        </title>
		                    </y_axis>
		                </axes>
		            </chart_settings>
		            <data>
		                <series>
		                    <point name="Jan" y="21" />
		                    <point name="Feb" y="32" />
		                    <point name="Mar" y="43" />
		                    <point name="Apr" y="54" />
		                </series>
		            </data>
		        </chart>
		    </charts>
		</anychart>
    
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
		        <chart>
		            <chart_settings>
		                <title>
		                    <text><![CDATA[Product sales by Month]]></text>
		                </title>
		                <axes>
		                    <x_axis>
		                        <title>
		                            <text><![CDATA[Months]]></text>
		                        </title>
		                    </x_axis>
		                    <y_axis>
		                        <title>
		                            <text><![CDATA[Sales]]></text>
		                        </title>
		                    </y_axis>
		                </axes>
		            </chart_settings>
		            <data>
		                <series>
		                    <point name="Jan" y="21" />
		                    <point name="Feb" y="32" />
		                    <point name="Mar" y="43" />
		                    <point name="Apr" y="54" />
		                </series>
		            </data>
		        </chart>
		    </charts>
		</anychart>
		
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
		        <chart>
		            <chart_settings>
		                <title>
		                    <text><![CDATA[Product sales by Month]]></text>
		                </title>
		                <axes>
		                    <x_axis>
		                        <title>
		                            <text><![CDATA[Months]]></text>
		                        </title>
		                    </x_axis>
		                    <y_axis>
		                        <title>
		                            <text><![CDATA[Sales]]></text>
		                        </title>
		                    </y_axis>
		                </axes>
		            </chart_settings>
		            <data>
		                <series>
		                    <point name="Jan" y="21" />
		                    <point name="Feb" y="32" />
		                    <point name="Mar" y="43" />
		                    <point name="Apr" y="54" />
		                </series>
		            </data>
		        </chart>
		    </charts>
		</anychart>
		
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
		        <chart>
		            <chart_settings>
		                <title>
		                    <text><![CDATA[Product sales by Month]]></text>
		                </title>
		                <axes>
		                    <x_axis>
		                        <title>
		                            <text><![CDATA[Months]]></text>
		                        </title>
		                    </x_axis>
		                    <y_axis>
		                        <title>
		                            <text><![CDATA[Sales]]></text>
		                        </title>
		                    </y_axis>
		                </axes>
		            </chart_settings>
		            <data>
		                <series>
		                    <point name="Jan" y="21" />
		                    <point name="Feb" y="32" />
		                    <point name="Mar" y="43" />
		                    <point name="Apr" y="54" />
		                </series>
		            </data>
		        </chart>
		    </charts>
		</anychart>
		
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
		        <chart>
		            <chart_settings>
		                <title>
		                    <text><![CDATA[Product sales by Month]]></text>
		                </title>
		                <axes>
		                    <x_axis>
		                        <title>
		                            <text><![CDATA[Months]]></text>
		                        </title>
		                    </x_axis>
		                    <y_axis>
		                        <title>
		                            <text><![CDATA[Sales]]></text>
		                        </title>
		                    </y_axis>
		                </axes>
		            </chart_settings>
		            <data>
		                <series>
		                    <point name="Jan" y="21" />
		                    <point name="Feb" y="32" />
		                    <point name="Mar" y="43" />
		                    <point name="Apr" y="54" />
		                </series>
		            </data>
		        </chart>
		    </charts>
		</anychart>
		
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
		        <chart>
		            <chart_settings>
		                <title>
		                    <text><![CDATA[Product sales by Month]]></text>
		                </title>
		                <axes>
		                    <x_axis>
		                        <title>
		                            <text><![CDATA[Months]]></text>
		                        </title>
		                    </x_axis>
		                    <y_axis>
		                        <title>
		                            <text><![CDATA[Sales]]></text>
		                        </title>
		                    </y_axis>
		                </axes>
		            </chart_settings>
		            <data>
		                <series>
		                    <point name="Jan" y="21" />
		                    <point name="Feb" y="32" />
		                    <point name="Mar" y="43" />
		                    <point name="Apr" y="54" />
		                </series>
		            </data>
		        </chart>
		    </charts>
		</anychart>
		
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
		        <chart>
		            <chart_settings>
		                <title>
		                    <text><![CDATA[Product sales by Month]]></text>
		                </title>
		                <axes>
		                    <x_axis>
		                        <title>
		                            <text><![CDATA[Months]]></text>
		                        </title>
		                    </x_axis>
		                    <y_axis>
		                        <title>
		                            <text><![CDATA[Sales]]></text>
		                        </title>
		                    </y_axis>
		                </axes>
		            </chart_settings>
		            <data>
		                <series>
		                    <point name="Jan" y="21" />
		                    <point name="Feb" y="32" />
		                    <point name="Mar" y="43" />
		                    <point name="Apr" y="54" />
		                </series>
		            </data>
		        </chart>
		    </charts>
		</anychart>
		
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
		        <chart>
		            <chart_settings>
		                <title>
		                    <text><![CDATA[Product sales by Month]]></text>
		                </title>
		                <axes>
		                    <x_axis>
		                        <title>
		                            <text><![CDATA[Months]]></text>
		                        </title>
		                    </x_axis>
		                    <y_axis>
		                        <title>
		                            <text><![CDATA[Sales]]></text>
		                        </title>
		                    </y_axis>
		                </axes>
		            </chart_settings>
		            <data>
		                <series>
		                    <point name="Jan" y="21" />
		                    <point name="Feb" y="32" />
		                    <point name="Mar" y="43" />
		                    <point name="Apr" y="54" />
		                </series>
		            </data>
		        </chart>
		    </charts>
		</anychart>
    
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
		        <chart>
		            <chart_settings>
		                <title>
		                    <text><![CDATA[Product sales by Month]]></text>
		                </title>
		                <axes>
		                    <x_axis>
		                        <title>
		                            <text><![CDATA[Months]]></text>
		                        </title>
		                    </x_axis>
		                    <y_axis>
		                        <title>
		                            <text><![CDATA[Sales]]></text>
		                        </title>
		                    </y_axis>
		                </axes>
		            </chart_settings>
		            <data>
		                <series>
		                    <point name="Jan" y="21" />
		                    <point name="Feb" y="32" />
		                    <point name="Mar" y="43" />
		                    <point name="Apr" y="54" />
		                </series>
		            </data>
		        </chart>
		    </charts>
		</anychart>
		
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
		        <chart>
		            <chart_settings>
		                <title>
		                    <text><![CDATA[Product sales by Month]]></text>
		                </title>
		                <axes>
		                    <x_axis>
		                        <title>
		                            <text><![CDATA[Months]]></text>
		                        </title>
		                    </x_axis>
		                    <y_axis>
		                        <title>
		                            <text><![CDATA[Sales]]></text>
		                        </title>
		                    </y_axis>
		                </axes>
		            </chart_settings>
		            <data>
		                <series>
		                    <point name="Jan" y="21" />
		                    <point name="Feb" y="32" />
		                    <point name="Mar" y="43" />
		                    <point name="Apr" y="54" />
		                </series>
		            </data>
		        </chart>
		    </charts>
		</anychart>
		
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
		        <chart>
		            <chart_settings>
		                <title>
		                    <text><![CDATA[Product sales by Month]]></text>
		                </title>
		                <axes>
		                    <x_axis>
		                        <title>
		                            <text><![CDATA[Months]]></text>
		                        </title>
		                    </x_axis>
		                    <y_axis>
		                        <title>
		                            <text><![CDATA[Sales]]></text>
		                        </title>
		                    </y_axis>
		                </axes>
		            </chart_settings>
		            <data>
		                <series>
		                    <point name="Jan" y="21" />
		                    <point name="Feb" y="32" />
		                    <point name="Mar" y="43" />
		                    <point name="Apr" y="54" />
		                </series>
		            </data>
		        </chart>
		    </charts>
		</anychart>
		
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
		        <chart>
		            <chart_settings>
		                <title>
		                    <text><![CDATA[Product sales by Month]]></text>
		                </title>
		                <axes>
		                    <x_axis>
		                        <title>
		                            <text><![CDATA[Months]]></text>
		                        </title>
		                    </x_axis>
		                    <y_axis>
		                        <title>
		                            <text><![CDATA[Sales]]></text>
		                        </title>
		                    </y_axis>
		                </axes>
		            </chart_settings>
		            <data>
		                <series>
		                    <point name="Jan" y="21" />
		                    <point name="Feb" y="32" />
		                    <point name="Mar" y="43" />
		                    <point name="Apr" y="54" />
		                </series>
		            </data>
		        </chart>
		    </charts>
		</anychart>
		
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
		        <chart>
		            <chart_settings>
		                <title>
		                    <text><![CDATA[Product sales by Month]]></text>
		                </title>
		                <axes>
		                    <x_axis>
		                        <title>
		                            <text><![CDATA[Months]]></text>
		                        </title>
		                    </x_axis>
		                    <y_axis>
		                        <title>
		                            <text><![CDATA[Sales]]></text>
		                        </title>
		                    </y_axis>
		                </axes>
		            </chart_settings>
		            <data>
		                <series>
		                    <point name="Jan" y="21" />
		                    <point name="Feb" y="32" />
		                    <point name="Mar" y="43" />
		                    <point name="Apr" y="54" />
		                </series>
		            </data>
		        </chart>
		    </charts>
		</anychart>
		
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
		        <chart>
		            <chart_settings>
		                <title>
		                    <text><![CDATA[Product sales by Month]]></text>
		                </title>
		                <axes>
		                    <x_axis>
		                        <title>
		                            <text><![CDATA[Months]]></text>
		                        </title>
		                    </x_axis>
		                    <y_axis>
		                        <title>
		                            <text><![CDATA[Sales]]></text>
		                        </title>
		                    </y_axis>
		                </axes>
		            </chart_settings>
		            <data>
		                <series>
		                    <point name="Jan" y="21" />
		                    <point name="Feb" y="32" />
		                    <point name="Mar" y="43" />
		                    <point name="Apr" y="54" />
		                </series>
		            </data>
		        </chart>
		    </charts>
		</anychart>
		
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
		        <chart>
		            <chart_settings>
		                <title>
		                    <text><![CDATA[Product sales by Month]]></text>
		                </title>
		                <axes>
		                    <x_axis>
		                        <title>
		                            <text><![CDATA[Months]]></text>
		                        </title>
		                    </x_axis>
		                    <y_axis>
		                        <title>
		                            <text><![CDATA[Sales]]></text>
		                        </title>
		                    </y_axis>
		                </axes>
		            </chart_settings>
		            <data>
		                <series>
		                    <point name="Jan" y="21" />
		                    <point name="Feb" y="32" />
		                    <point name="Mar" y="43" />
		                    <point name="Apr" y="54" />
		                </series>
		            </data>
		        </chart>
		    </charts>
		</anychart>
    
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
		        <chart>
		            <chart_settings>
		                <title>
		                    <text><![CDATA[Product sales by Month]]></text>
		                </title>
		                <axes>
		                    <x_axis>
		                        <title>
		                            <text><![CDATA[Months]]></text>
		                        </title>
		                    </x_axis>
		                    <y_axis>
		                        <title>
		                            <text><![CDATA[Sales]]></text>
		                        </title>
		                    </y_axis>
		                </axes>
		            </chart_settings>
		            <data>
		                <series>
		                    <point name="Jan" y="21" />
		                    <point name="Feb" y="32" />
		                    <point name="Mar" y="43" />
		                    <point name="Apr" y="54" />
		                </series>
		            </data>
		        </chart>
		    </charts>
		</anychart>
		
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
		        <chart>
		            <chart_settings>
		                <title>
		                    <text><![CDATA[Product sales by Month]]></text>
		                </title>
		                <axes>
		                    <x_axis>
		                        <title>
		                            <text><![CDATA[Months]]></text>
		                        </title>
		                    </x_axis>
		                    <y_axis>
		                        <title>
		                            <text><![CDATA[Sales]]></text>
		                        </title>
		                    </y_axis>
		                </axes>
		            </chart_settings>
		            <data>
		                <series>
		                    <point name="Jan" y="21" />
		                    <point name="Feb" y="32" />
		                    <point name="Mar" y="43" />
		                    <point name="Apr" y="54" />
		                </series>
		            </data>
		        </chart>
		    </charts>
		</anychart>
		
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
		        <chart>
		            <chart_settings>
		                <title>
		                    <text><![CDATA[Product sales by Month]]></text>
		                </title>
		                <axes>
		                    <x_axis>
		                        <title>
		                            <text><![CDATA[Months]]></text>
		                        </title>
		                    </x_axis>
		                    <y_axis>
		                        <title>
		                            <text><![CDATA[Sales]]></text>
		                        </title>
		                    </y_axis>
		                </axes>
		            </chart_settings>
		            <data>
		                <series>
		                    <point name="Jan" y="21" />
		                    <point name="Feb" y="32" />
		                    <point name="Mar" y="43" />
		                    <point name="Apr" y="54" />
		                </series>
		            </data>
		        </chart>
		    </charts>
		</anychart>
		
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
		        <chart>
		            <chart_settings>
		                <title>
		                    <text><![CDATA[Product sales by Month]]></text>
		                </title>
		                <axes>
		                    <x_axis>
		                        <title>
		                            <text><![CDATA[Months]]></text>
		                        </title>
		                    </x_axis>
		                    <y_axis>
		                        <title>
		                            <text><![CDATA[Sales]]></text>
		                        </title>
		                    </y_axis>
		                </axes>
		            </chart_settings>
		            <data>
		                <series>
		                    <point name="Jan" y="21" />
		                    <point name="Feb" y="32" />
		                    <point name="Mar" y="43" />
		                    <point name="Apr" y="54" />
		                </series>
		            </data>
		        </chart>
		    </charts>
		</anychart>
		
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
		        <chart>
		            <chart_settings>
		                <title>
		                    <text><![CDATA[Product sales by Month]]></text>
		                </title>
		                <axes>
		                    <x_axis>
		                        <title>
		                            <text><![CDATA[Months]]></text>
		                        </title>
		                    </x_axis>
		                    <y_axis>
		                        <title>
		                            <text><![CDATA[Sales]]></text>
		                        </title>
		                    </y_axis>
		                </axes>
		            </chart_settings>
		            <data>
		                <series>
		                    <point name="Jan" y="21" />
		                    <point name="Feb" y="32" />
		                    <point name="Mar" y="43" />
		                    <point name="Apr" y="54" />
		                </series>
		            </data>
		        </chart>
		    </charts>
		</anychart>
		
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
		        <chart>
		            <chart_settings>
		                <title>
		                    <text><![CDATA[Product sales by Month]]></text>
		                </title>
		                <axes>
		                    <x_axis>
		                        <title>
		                            <text><![CDATA[Months]]></text>
		                        </title>
		                    </x_axis>
		                    <y_axis>
		                        <title>
		                            <text><![CDATA[Sales]]></text>
		                        </title>
		                    </y_axis>
		                </axes>
		            </chart_settings>
		            <data>
		                <series>
		                    <point name="Jan" y="21" />
		                    <point name="Feb" y="32" />
		                    <point name="Mar" y="43" />
		                    <point name="Apr" y="54" />
		                </series>
		            </data>
		        </chart>
		    </charts>
		</anychart>
		
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
		        <chart>
		            <chart_settings>
		                <title>
		                    <text><![CDATA[Product sales by Month]]></text>
		                </title>
		                <axes>
		                    <x_axis>
		                        <title>
		                            <text><![CDATA[Months]]></text>
		                        </title>
		                    </x_axis>
		                    <y_axis>
		                        <title>
		                            <text><![CDATA[Sales]]></text>
		                        </title>
		                    </y_axis>
		                </axes>
		            </chart_settings>
		            <data>
		                <series>
		                    <point name="Jan" y="21" />
		                    <point name="Feb" y="32" />
		                    <point name="Mar" y="43" />
		                    <point name="Apr" y="54" />
		                </series>
		            </data>
		        </chart>
		    </charts>
		</anychart>
    
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
		        <chart>
		            <chart_settings>
		                <title>
		                    <text><![CDATA[Product sales by Month]]></text>
		                </title>
		                <axes>
		                    <x_axis>
		                        <title>
		                            <text><![CDATA[Months]]></text>
		                        </title>
		                    </x_axis>
		                    <y_axis>
		                        <title>
		                            <text><![CDATA[Sales]]></text>
		                        </title>
		                    </y_axis>
		                </axes>
		            </chart_settings>
		            <data>
		                <series>
		                    <point name="Jan" y="21" />
		                    <point name="Feb" y="32" />
		                    <point name="Mar" y="43" />
		                    <point name="Apr" y="54" />
		                </series>
		            </data>
		        </chart>
		    </charts>
		</anychart>
		
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
		        <chart>
		            <chart_settings>
		                <title>
		                    <text><![CDATA[Product sales by Month]]></text>
		                </title>
		                <axes>
		                    <x_axis>
		                        <title>
		                            <text><![CDATA[Months]]></text>
		                        </title>
		                    </x_axis>
		                    <y_axis>
		                        <title>
		                            <text><![CDATA[Sales]]></text>
		                        </title>
		                    </y_axis>
		                </axes>
		            </chart_settings>
		            <data>
		                <series>
		                    <point name="Jan" y="21" />
		                    <point name="Feb" y="32" />
		                    <point name="Mar" y="43" />
		                    <point name="Apr" y="54" />
		                </series>
		            </data>
		        </chart>
		    </charts>
		</anychart>
		
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
		        <chart>
		            <chart_settings>
		                <title>
		                    <text><![CDATA[Product sales by Month]]></text>
		                </title>
		                <axes>
		                    <x_axis>
		                        <title>
		                            <text><![CDATA[Months]]></text>
		                        </title>
		                    </x_axis>
		                    <y_axis>
		                        <title>
		                            <text><![CDATA[Sales]]></text>
		                        </title>
		                    </y_axis>
		                </axes>
		            </chart_settings>
		            <data>
		                <series>
		                    <point name="Jan" y="21" />
		                    <point name="Feb" y="32" />
		                    <point name="Mar" y="43" />
		                    <point name="Apr" y="54" />
		                </series>
		            </data>
		        </chart>
		    </charts>
		</anychart>
		
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
		        <chart>
		            <chart_settings>
		                <title>
		                    <text><![CDATA[Product sales by Month]]></text>
		                </title>
		                <axes>
		                    <x_axis>
		                        <title>
		                            <text><![CDATA[Months]]></text>
		                        </title>
		                    </x_axis>
		                    <y_axis>
		                        <title>
		                            <text><![CDATA[Sales]]></text>
		                        </title>
		                    </y_axis>
		                </axes>
		            </chart_settings>
		            <data>
		                <series>
		                    <point name="Jan" y="21" />
		                    <point name="Feb" y="32" />
		                    <point name="Mar" y="43" />
		                    <point name="Apr" y="54" />
		                </series>
		            </data>
		        </chart>
		    </charts>
		</anychart>
		
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
		        <chart>
		            <chart_settings>
		                <title>
		                    <text><![CDATA[Product sales by Month]]></text>
		                </title>
		                <axes>
		                    <x_axis>
		                        <title>
		                            <text><![CDATA[Months]]></text>
		                        </title>
		                    </x_axis>
		                    <y_axis>
		                        <title>
		                            <text><![CDATA[Sales]]></text>
		                        </title>
		                    </y_axis>
		                </axes>
		            </chart_settings>
		            <data>
		                <series>
		                    <point name="Jan" y="21" />
		                    <point name="Feb" y="32" />
		                    <point name="Mar" y="43" />
		                    <point name="Apr" y="54" />
		                </series>
		            </data>
		        </chart>
		    </charts>
		</anychart>
		
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
		        <chart>
		            <chart_settings>
		                <title>
		                    <text><![CDATA[Product sales by Month]]></text>
		                </title>
		                <axes>
		                    <x_axis>
		                        <title>
		                            <text><![CDATA[Months]]></text>
		                        </title>
		                    </x_axis>
		                    <y_axis>
		                        <title>
		                            <text><![CDATA[Sales]]></text>
		                        </title>
		                    </y_axis>
		                </axes>
		            </chart_settings>
		            <data>
		                <series>
		                    <point name="Jan" y="21" />
		                    <point name="Feb" y="32" />
		                    <point name="Mar" y="43" />
		                    <point name="Apr" y="54" />
		                </series>
		            </data>
		        </chart>
		    </charts>
		</anychart>
		
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
		        <chart>
		            <chart_settings>
		                <title>
		                    <text><![CDATA[Product sales by Month]]></text>
		                </title>
		                <axes>
		                    <x_axis>
		                        <title>
		                            <text><![CDATA[Months]]></text>
		                        </title>
		                    </x_axis>
		                    <y_axis>
		                        <title>
		                            <text><![CDATA[Sales]]></text>
		                        </title>
		                    </y_axis>
		                </axes>
		            </chart_settings>
		            <data>
		                <series>
		                    <point name="Jan" y="21" />
		                    <point name="Feb" y="32" />
		                    <point name="Mar" y="43" />
		                    <point name="Apr" y="54" />
		                </series>
		            </data>
		        </chart>
		    </charts>
		</anychart>
    
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
		        <chart>
		            <chart_settings>
		                <title>
		                    <text><![CDATA[Product sales by Month]]></text>
		                </title>
		                <axes>
		                    <x_axis>
		                        <title>
		                            <text><![CDATA[Months]]></text>
		                        </title>
		                    </x_axis>
		                    <y_axis>
		                        <title>
		                            <text><![CDATA[Sales]]></text>
		                        </title>
		                    </y_axis>
		                </axes>
		            </chart_settings>
		            <data>
		                <series>
		                    <point name="Jan" y="21" />
		                    <point name="Feb" y="32" />
		                    <point name="Mar" y="43" />
		                    <point name="Apr" y="54" />
		                </series>
		            </data>
		        </chart>
		    </charts>
		</anychart>
		
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
		        <chart>
		            <chart_settings>
		                <title>
		                    <text><![CDATA[Product sales by Month]]></text>
		                </title>
		                <axes>
		                    <x_axis>
		                        <title>
		                            <text><![CDATA[Months]]></text>
		                        </title>
		                    </x_axis>
		                    <y_axis>
		                        <title>
		                            <text><![CDATA[Sales]]></text>
		                        </title>
		                    </y_axis>
		                </axes>
		            </chart_settings>
		            <data>
		                <series>
		                    <point name="Jan" y="21" />
		                    <point name="Feb" y="32" />
		                    <point name="Mar" y="43" />
		                    <point name="Apr" y="54" />
		                </series>
		            </data>
		        </chart>
		    </charts>
		</anychart>
		
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
		        <chart>
		            <chart_settings>
		                <title>
		                    <text><![CDATA[Product sales by Month]]></text>
		                </title>
		                <axes>
		                    <x_axis>
		                        <title>
		                            <text><![CDATA[Months]]></text>
		                        </title>
		                    </x_axis>
		                    <y_axis>
		                        <title>
		                            <text><![CDATA[Sales]]></text>
		                        </title>
		                    </y_axis>
		                </axes>
		            </chart_settings>
		            <data>
		                <series>
		                    <point name="Jan" y="21" />
		                    <point name="Feb" y="32" />
		                    <point name="Mar" y="43" />
		                    <point name="Apr" y="54" />
		                </series>
		            </data>
		        </chart>
		    </charts>
		</anychart>
		
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
		        <chart>
		            <chart_settings>
		                <title>
		                    <text><![CDATA[Product sales by Month]]></text>
		                </title>
		                <axes>
		                    <x_axis>
		                        <title>
		                            <text><![CDATA[Months]]></text>
		                        </title>
		                    </x_axis>
		                    <y_axis>
		                        <title>
		                            <text><![CDATA[Sales]]></text>
		                        </title>
		                    </y_axis>
		                </axes>
		            </chart_settings>
		            <data>
		                <series>
		                    <point name="Jan" y="21" />
		                    <point name="Feb" y="32" />
		                    <point name="Mar" y="43" />
		                    <point name="Apr" y="54" />
		                </series>
		            </data>
		        </chart>
		    </charts>
		</anychart>
		
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
		        <chart>
		            <chart_settings>
		                <title>
		                    <text><![CDATA[Product sales by Month]]></text>
		                </title>
		                <axes>
		                    <x_axis>
		                        <title>
		                            <text><![CDATA[Months]]></text>
		                        </title>
		                    </x_axis>
		                    <y_axis>
		                        <title>
		                            <text><![CDATA[Sales]]></text>
		                        </title>
		                    </y_axis>
		                </axes>
		            </chart_settings>
		            <data>
		                <series>
		                    <point name="Jan" y="21" />
		                    <point name="Feb" y="32" />
		                    <point name="Mar" y="43" />
		                    <point name="Apr" y="54" />
		                </series>
		            </data>
		        </chart>
		    </charts>
		</anychart>
		
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
		        <chart>
		            <chart_settings>
		                <title>
		                    <text><![CDATA[Product sales by Month]]></text>
		                </title>
		                <axes>
		                    <x_axis>
		                        <title>
		                            <text><![CDATA[Months]]></text>
		                        </title>
		                    </x_axis>
		                    <y_axis>
		                        <title>
		                            <text><![CDATA[Sales]]></text>
		                        </title>
		                    </y_axis>
		                </axes>
		            </chart_settings>
		            <data>
		                <series>
		                    <point name="Jan" y="21" />
		                    <point name="Feb" y="32" />
		                    <point name="Mar" y="43" />
		                    <point name="Apr" y="54" />
		                </series>
		            </data>
		        </chart>
		    </charts>
		</anychart>
		
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
		        <chart>
		            <chart_settings>
		                <title>
		                    <text><![CDATA[Product sales by Month]]></text>
		                </title>
		                <axes>
		                    <x_axis>
		                        <title>
		                            <text><![CDATA[Months]]></text>
		                        </title>
		                    </x_axis>
		                    <y_axis>
		                        <title>
		                            <text><![CDATA[Sales]]></text>
		                        </title>
		                    </y_axis>
		                </axes>
		            </chart_settings>
		            <data>
		                <series>
		                    <point name="Jan" y="21" />
		                    <point name="Feb" y="32" />
		                    <point name="Mar" y="43" />
		                    <point name="Apr" y="54" />
		                </series>
		            </data>
		        </chart>
		    </charts>
		</anychart>
    
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
		        <chart>
		            <chart_settings>
		                <title>
		                    <text><![CDATA[Product sales by Month]]></text>
		                </title>
		                <axes>
		                    <x_axis>
		                        <title>
		                            <text><![CDATA[Months]]></text>
		                        </title>
		                    </x_axis>
		                    <y_axis>
		                        <title>
		                            <text><![CDATA[Sales]]></text>
		                        </title>
		                    </y_axis>
		                </axes>
		            </chart_settings>
		            <data>
		                <series>
		                    <point name="Jan" y="21" />
		                    <point name="Feb" y="32" />
		                    <point name="Mar" y="43" />
		                    <point name="Apr" y="54" />
		                </series>
		            </data>
		        </chart>
		    </charts>
		</anychart>
		
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
		        <chart>
		            <chart_settings>
		                <title>
		                    <text><![CDATA[Product sales by Month]]></text>
		                </title>
		                <axes>
		                    <x_axis>
		                        <title>
		                            <text><![CDATA[Months]]></text>
		                        </title>
		                    </x_axis>
		                    <y_axis>
		                        <title>
		                            <text><![CDATA[Sales]]></text>
		                        </title>
		                    </y_axis>
		                </axes>
		            </chart_settings>
		            <data>
		                <series>
		                    <point name="Jan" y="21" />
		                    <point name="Feb" y="32" />
		                    <point name="Mar" y="43" />
		                    <point name="Apr" y="54" />
		                </series>
		            </data>
		        </chart>
		    </charts>
		</anychart>
		
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
		        <chart>
		            <chart_settings>
		                <title>
		                    <text><![CDATA[Product sales by Month]]></text>
		                </title>
		                <axes>
		                    <x_axis>
		                        <title>
		                            <text><![CDATA[Months]]></text>
		                        </title>
		                    </x_axis>
		                    <y_axis>
		                        <title>
		                            <text><![CDATA[Sales]]></text>
		                        </title>
		                    </y_axis>
		                </axes>
		            </chart_settings>
		            <data>
		                <series>
		                    <point name="Jan" y="21" />
		                    <point name="Feb" y="32" />
		                    <point name="Mar" y="43" />
		                    <point name="Apr" y="54" />
		                </series>
		            </data>
		        </chart>
		    </charts>
		</anychart>
		
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
		        <chart>
		            <chart_settings>
		                <title>
		                    <text><![CDATA[Product sales by Month]]></text>
		                </title>
		                <axes>
		                    <x_axis>
		                        <title>
		                            <text><![CDATA[Months]]></text>
		                        </title>
		                    </x_axis>
		                    <y_axis>
		                        <title>
		                            <text><![CDATA[Sales]]></text>
		                        </title>
		                    </y_axis>
		                </axes>
		            </chart_settings>
		            <data>
		                <series>
		                    <point name="Jan" y="21" />
		                    <point name="Feb" y="32" />
		                    <point name="Mar" y="43" />
		                    <point name="Apr" y="54" />
		                </series>
		            </data>
		        </chart>
		    </charts>
		</anychart>
		
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
		        <chart>
		            <chart_settings>
		                <title>
		                    <text><![CDATA[Product sales by Month]]></text>
		                </title>
		                <axes>
		                    <x_axis>
		                        <title>
		                            <text><![CDATA[Months]]></text>
		                        </title>
		                    </x_axis>
		                    <y_axis>
		                        <title>
		                            <text><![CDATA[Sales]]></text>
		                        </title>
		                    </y_axis>
		                </axes>
		            </chart_settings>
		            <data>
		                <series>
		                    <point name="Jan" y="21" />
		                    <point name="Feb" y="32" />
		                    <point name="Mar" y="43" />
		                    <point name="Apr" y="54" />
		                </series>
		            </data>
		        </chart>
		    </charts>
		</anychart>
		
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
		        <chart>
		            <chart_settings>
		                <title>
		                    <text><![CDATA[Product sales by Month]]></text>
		                </title>
		                <axes>
		                    <x_axis>
		                        <title>
		                            <text><![CDATA[Months]]></text>
		                        </title>
		                    </x_axis>
		                    <y_axis>
		                        <title>
		                            <text><![CDATA[Sales]]></text>
		                        </title>
		                    </y_axis>
		                </axes>
		            </chart_settings>
		            <data>
		                <series>
		                    <point name="Jan" y="21" />
		                    <point name="Feb" y="32" />
		                    <point name="Mar" y="43" />
		                    <point name="Apr" y="54" />
		                </series>
		            </data>
		        </chart>
		    </charts>
		</anychart>
		
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
		        <chart>
		            <chart_settings>
		                <title>
		                    <text><![CDATA[Product sales by Month]]></text>
		                </title>
		                <axes>
		                    <x_axis>
		                        <title>
		                            <text><![CDATA[Months]]></text>
		                        </title>
		                    </x_axis>
		                    <y_axis>
		                        <title>
		                            <text><![CDATA[Sales]]></text>
		                        </title>
		                    </y_axis>
		                </axes>
		            </chart_settings>
		            <data>
		                <series>
		                    <point name="Jan" y="21" />
		                    <point name="Feb" y="32" />
		                    <point name="Mar" y="43" />
		                    <point name="Apr" y="54" />
		                </series>
		            </data>
		        </chart>
		    </charts>
		</anychart>
    
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
		        <chart>
		            <chart_settings>
		                <title>
		                    <text><![CDATA[Product sales by Month]]></text>
		                </title>
		                <axes>
		                    <x_axis>
		                        <title>
		                            <text><![CDATA[Months]]></text>
		                        </title>
		                    </x_axis>
		                    <y_axis>
		                        <title>
		                            <text><![CDATA[Sales]]></text>
		                        </title>
		                    </y_axis>
		                </axes>
		            </chart_settings>
		            <data>
		                <series>
		                    <point name="Jan" y="21" />
		                    <point name="Feb" y="32" />
		                    <point name="Mar" y="43" />
		                    <point name="Apr" y="54" />
		                </series>
		            </data>
		        </chart>
		    </charts>
		</anychart>
		
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
		        <chart>
		            <chart_settings>
		                <title>
		                    <text><![CDATA[Product sales by Month]]></text>
		                </title>
		                <axes>
		                    <x_axis>
		                        <title>
		                            <text><![CDATA[Months]]></text>
		                        </title>
		                    </x_axis>
		                    <y_axis>
		                        <title>
		                            <text><![CDATA[Sales]]></text>
		                        </title>
		                    </y_axis>
		                </axes>
		            </chart_settings>
		            <data>
		                <series>
		                    <point name="Jan" y="21" />
		                    <point name="Feb" y="32" />
		                    <point name="Mar" y="43" />
		                    <point name="Apr" y="54" />
		                </series>
		            </data>
		        </chart>
		    </charts>
		</anychart>
		
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
		        <chart>
		            <chart_settings>
		                <title>
		                    <text><![CDATA[Product sales by Month]]></text>
		                </title>
		                <axes>
		                    <x_axis>
		                        <title>
		                            <text><![CDATA[Months]]></text>
		                        </title>
		                    </x_axis>
		                    <y_axis>
		                        <title>
		                            <text><![CDATA[Sales]]></text>
		                        </title>
		                    </y_axis>
		                </axes>
		            </chart_settings>
		            <data>
		                <series>
		                    <point name="Jan" y="21" />
		                    <point name="Feb" y="32" />
		                    <point name="Mar" y="43" />
		                    <point name="Apr" y="54" />
		                </series>
		            </data>
		        </chart>
		    </charts>
		</anychart>
		
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
		        <chart>
		            <chart_settings>
		                <title>
		                    <text><![CDATA[Product sales by Month]]></text>
		                </title>
		                <axes>
		                    <x_axis>
		                        <title>
		                            <text><![CDATA[Months]]></text>
		                        </title>
		                    </x_axis>
		                    <y_axis>
		                        <title>
		                            <text><![CDATA[Sales]]></text>
		                        </title>
		                    </y_axis>
		                </axes>
		            </chart_settings>
		            <data>
		                <series>
		                    <point name="Jan" y="21" />
		                    <point name="Feb" y="32" />
		                    <point name="Mar" y="43" />
		                    <point name="Apr" y="54" />
		                </series>
		            </data>
		        </chart>
		    </charts>
		</anychart>
		
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
		        <chart>
		            <chart_settings>
		                <title>
		                    <text><![CDATA[Product sales by Month]]></text>
		                </title>
		                <axes>
		                    <x_axis>
		                        <title>
		                            <text><![CDATA[Months]]></text>
		                        </title>
		                    </x_axis>
		                    <y_axis>
		                        <title>
		                            <text><![CDATA[Sales]]></text>
		                        </title>
		                    </y_axis>
		                </axes>
		            </chart_settings>
		            <data>
		                <series>
		                    <point name="Jan" y="21" />
		                    <point name="Feb" y="32" />
		                    <point name="Mar" y="43" />
		                    <point name="Apr" y="54" />
		                </series>
		            </data>
		        </chart>
		    </charts>
		</anychart>
		
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
		        <chart>
		            <chart_settings>
		                <title>
		                    <text><![CDATA[Product sales by Month]]></text>
		                </title>
		                <axes>
		                    <x_axis>
		                        <title>
		                            <text><![CDATA[Months]]></text>
		                        </title>
		                    </x_axis>
		                    <y_axis>
		                        <title>
		                            <text><![CDATA[Sales]]></text>
		                        </title>
		                    </y_axis>
		                </axes>
		            </chart_settings>
		            <data>
		                <series>
		                    <point name="Jan" y="21" />
		                    <point name="Feb" y="32" />
		                    <point name="Mar" y="43" />
		                    <point name="Apr" y="54" />
		                </series>
		            </data>
		        </chart>
		    </charts>
		</anychart>
		
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
		        <chart>
		            <chart_settings>
		                <title>
		                    <text><![CDATA[Product sales by Month]]></text>
		                </title>
		                <axes>
		                    <x_axis>
		                        <title>
		                            <text><![CDATA[Months]]></text>
		                        </title>
		                    </x_axis>
		                    <y_axis>
		                        <title>
		                            <text><![CDATA[Sales]]></text>
		                        </title>
		                    </y_axis>
		                </axes>
		            </chart_settings>
		            <data>
		                <series>
		                    <point name="Jan" y="21" />
		                    <point name="Feb" y="32" />
		                    <point name="Mar" y="43" />
		                    <point name="Apr" y="54" />
		                </series>
		            </data>
		        </chart>
		    </charts>
		</anychart>
    
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
		        <chart>
		            <chart_settings>
		                <title>
		                    <text><![CDATA[Product sales by Month]]></text>
		                </title>
		                <axes>
		                    <x_axis>
		                        <title>
		                            <text><![CDATA[Months]]></text>
		                        </title>
		                    </x_axis>
		                    <y_axis>
		                        <title>
		                            <text><![CDATA[Sales]]></text>
		                        </title>
		                    </y_axis>
		                </axes>
		            </chart_settings>
		            <data>
		                <series>
		                    <point name="Jan" y="21" />
		                    <point name="Feb" y="32" />
		                    <point name="Mar" y="43" />
		                    <point name="Apr" y="54" />
		                </series>
		            </data>
		        </chart>
		    </charts>
		</anychart>
		
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
		        <chart>
		            <chart_settings>
		                <title>
		                    <text><![CDATA[Product sales by Month]]></text>
		                </title>
		                <axes>
		                    <x_axis>
		                        <title>
		                            <text><![CDATA[Months]]></text>
		                        </title>
		                    </x_axis>
		                    <y_axis>
		                        <title>
		                            <text><![CDATA[Sales]]></text>
		                        </title>
		                    </y_axis>
		                </axes>
		            </chart_settings>
		            <data>
		                <series>
		                    <point name="Jan" y="21" />
		                    <point name="Feb" y="32" />
		                    <point name="Mar" y="43" />
		                    <point name="Apr" y="54" />
		                </series>
		            </data>
		        </chart>
		    </charts>
		</anychart>
		
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
		        <chart>
		            <chart_settings>
		                <title>
		                    <text><![CDATA[Product sales by Month]]></text>
		                </title>
		                <axes>
		                    <x_axis>
		                        <title>
		                            <text><![CDATA[Months]]></text>
		                        </title>
		                    </x_axis>
		                    <y_axis>
		                        <title>
		                            <text><![CDATA[Sales]]></text>
		                        </title>
		                    </y_axis>
		                </axes>
		            </chart_settings>
		            <data>
		                <series>
		                    <point name="Jan" y="21" />
		                    <point name="Feb" y="32" />
		                    <point name="Mar" y="43" />
		                    <point name="Apr" y="54" />
		                </series>
		            </data>
		        </chart>
		    </charts>
		</anychart>
		
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
		        <chart>
		            <chart_settings>
		                <title>
		                    <text><![CDATA[Product sales by Month]]></text>
		                </title>
		                <axes>
		                    <x_axis>
		                        <title>
		                            <text><![CDATA[Months]]></text>
		                        </title>
		                    </x_axis>
		                    <y_axis>
		                        <title>
		                            <text><![CDATA[Sales]]></text>
		                        </title>
		                    </y_axis>
		                </axes>
		            </chart_settings>
		            <data>
		                <series>
		                    <point name="Jan" y="21" />
		                    <point name="Feb" y="32" />
		                    <point name="Mar" y="43" />
		                    <point name="Apr" y="54" />
		                </series>
		            </data>
		        </chart>
		    </charts>
		</anychart>
		
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
		        <chart>
		            <chart_settings>
		                <title>
		                    <text><![CDATA[Product sales by Month]]></text>
		                </title>
		                <axes>
		                    <x_axis>
		                        <title>
		                            <text><![CDATA[Months]]></text>
		                        </title>
		                    </x_axis>
		                    <y_axis>
		                        <title>
		                            <text><![CDATA[Sales]]></text>
		                        </title>
		                    </y_axis>
		                </axes>
		            </chart_settings>
		            <data>
		                <series>
		                    <point name="Jan" y="21" />
		                    <point name="Feb" y="32" />
		                    <point name="Mar" y="43" />
		                    <point name="Apr" y="54" />
		                </series>
		            </data>
		        </chart>
		    </charts>
		</anychart>
		
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
		        <chart>
		            <chart_settings>
		                <title>
		                    <text><![CDATA[Product sales by Month]]></text>
		                </title>
		                <axes>
		                    <x_axis>
		                        <title>
		                            <text><![CDATA[Months]]></text>
		                        </title>
		                    </x_axis>
		                    <y_axis>
		                        <title>
		                            <text><![CDATA[Sales]]></text>
		                        </title>
		                    </y_axis>
		                </axes>
		            </chart_settings>
		            <data>
		                <series>
		                    <point name="Jan" y="21" />
		                    <point name="Feb" y="32" />
		                    <point name="Mar" y="43" />
		                    <point name="Apr" y="54" />
		                </series>
		            </data>
		        </chart>
		    </charts>
		</anychart>
		
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
		        <chart>
		            <chart_settings>
		                <title>
		                    <text><![CDATA[Product sales by Month]]></text>
		                </title>
		                <axes>
		                    <x_axis>
		                        <title>
		                            <text><![CDATA[Months]]></text>
		                        </title>
		                    </x_axis>
		                    <y_axis>
		                        <title>
		                            <text><![CDATA[Sales]]></text>
		                        </title>
		                    </y_axis>
		                </axes>
		            </chart_settings>
		            <data>
		                <series>
		                    <point name="Jan" y="21" />
		                    <point name="Feb" y="32" />
		                    <point name="Mar" y="43" />
		                    <point name="Apr" y="54" />
		                </series>
		            </data>
		        </chart>
		    </charts>
		</anychart>
    
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
		        <chart>
		            <chart_settings>
		                <title>
		                    <text><![CDATA[Product sales by Month]]></text>
		                </title>
		                <axes>
		                    <x_axis>
		                        <title>
		                            <text><![CDATA[Months]]></text>
		                        </title>
		                    </x_axis>
		                    <y_axis>
		                        <title>
		                            <text><![CDATA[Sales]]></text>
		                        </title>
		                    </y_axis>
		                </axes>
		            </chart_settings>
		            <data>
		                <series>
		                    <point name="Jan" y="21" />
		                    <point name="Feb" y="32" />
		                    <point name="Mar" y="43" />
		                    <point name="Apr" y="54" />
		                </series>
		            </data>
		        </chart>
		    </charts>
		</anychart>
		
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
		        <chart>
		            <chart_settings>
		                <title>
		                    <text><![CDATA[Product sales by Month]]></text>
		                </title>
		                <axes>
		                    <x_axis>
		                        <title>
		                            <text><![CDATA[Months]]></text>
		                        </title>
		                    </x_axis>
		                    <y_axis>
		                        <title>
		                            <text><![CDATA[Sales]]></text>
		                        </title>
		                    </y_axis>
		                </axes>
		            </chart_settings>
		            <data>
		                <series>
		                    <point name="Jan" y="21" />
		                    <point name="Feb" y="32" />
		                    <point name="Mar" y="43" />
		                    <point name="Apr" y="54" />
		                </series>
		            </data>
		        </chart>
		    </charts>
		</anychart>
		
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
		        <chart>
		            <chart_settings>
		                <title>
		                    <text><![CDATA[Product sales by Month]]></text>
		                </title>
		                <axes>
		                    <x_axis>
		                        <title>
		                            <text><![CDATA[Months]]></text>
		                        </title>
		                    </x_axis>
		                    <y_axis>
		                        <title>
		                            <text><![CDATA[Sales]]></text>
		                        </title>
		                    </y_axis>
		                </axes>
		            </chart_settings>
		            <data>
		                <series>
		                    <point name="Jan" y="21" />
		                    <point name="Feb" y="32" />
		                    <point name="Mar" y="43" />
		                    <point name="Apr" y="54" />
		                </series>
		            </data>
		        </chart>
		    </charts>
		</anychart>
		
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
		        <chart>
		            <chart_settings>
		                <title>
		                    <text><![CDATA[Product sales by Month]]></text>
		                </title>
		                <axes>
		                    <x_axis>
		                        <title>
		                            <text><![CDATA[Months]]></text>
		                        </title>
		                    </x_axis>
		                    <y_axis>
		                        <title>
		                            <text><![CDATA[Sales]]></text>
		                        </title>
		                    </y_axis>
		                </axes>
		            </chart_settings>
		            <data>
		                <series>
		                    <point name="Jan" y="21" />
		                    <point name="Feb" y="32" />
		                    <point name="Mar" y="43" />
		                    <point name="Apr" y="54" />
		                </series>
		            </data>
		        </chart>
		    </charts>
		</anychart>
		
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
		        <chart>
		            <chart_settings>
		                <title>
		                    <text><![CDATA[Product sales by Month]]></text>
		                </title>
		                <axes>
		                    <x_axis>
		                        <title>
		                            <text><![CDATA[Months]]></text>
		                        </title>
		                    </x_axis>
		                    <y_axis>
		                        <title>
		                            <text><![CDATA[Sales]]></text>
		                        </title>
		                    </y_axis>
		                </axes>
		            </chart_settings>
		            <data>
		                <series>
		                    <point name="Jan" y="21" />
		                    <point name="Feb" y="32" />
		                    <point name="Mar" y="43" />
		                    <point name="Apr" y="54" />
		                </series>
		            </data>
		        </chart>
		    </charts>
		</anychart>
		
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
		        <chart>
		            <chart_settings>
		                <title>
		                    <text><![CDATA[Product sales by Month]]></text>
		                </title>
		                <axes>
		                    <x_axis>
		                        <title>
		                            <text><![CDATA[Months]]></text>
		                        </title>
		                    </x_axis>
		                    <y_axis>
		                        <title>
		                            <text><![CDATA[Sales]]></text>
		                        </title>
		                    </y_axis>
		                </axes>
		            </chart_settings>
		            <data>
		                <series>
		                    <point name="Jan" y="21" />
		                    <point name="Feb" y="32" />
		                    <point name="Mar" y="43" />
		                    <point name="Apr" y="54" />
		                </series>
		            </data>
		        </chart>
		    </charts>
		</anychart>
		
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
		        <chart>
		            <chart_settings>
		                <title>
		                    <text><![CDATA[Product sales by Month]]></text>
		                </title>
		                <axes>
		                    <x_axis>
		                        <title>
		                            <text><![CDATA[Months]]></text>
		                        </title>
		                    </x_axis>
		                    <y_axis>
		                        <title>
		                            <text><![CDATA[Sales]]></text>
		                        </title>
		                    </y_axis>
		                </axes>
		            </chart_settings>
		            <data>
		                <series>
		                    <point name="Jan" y="21" />
		                    <point name="Feb" y="32" />
		                    <point name="Mar" y="43" />
		                    <point name="Apr" y="54" />
		                </series>
		            </data>
		        </chart>
		    </charts>
		</anychart>
  </body>
</html>