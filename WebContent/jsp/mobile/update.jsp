<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
 <?xml version="1.0" encoding="UTF-8"?>
<response>
	<resultId>${responseMap['resultId'] }</resultId>
	<resultType>${reqCode}</resultType>
	<resultName>${responseMap['resultName'] }</resultName>
	<data>
		<updateInfo>
			<c:if test="${responseMap['appType'] == 'ios' }">
			<versionName>${sysCfgMap['edc_app_ios_version_name']}</versionName>
			<path>${sysCfgMap['edc_app_ios_update_path']  }</path>
			</c:if>
			<c:if test="${responseMap['appType'] == 'android' }">
			<versionCode>${sysCfgMap['edc_app_android_version_code']}</versionCode>
			<path>${sysCfgMap['edc_app_android_update_path']  }</path>
			</c:if>
			<appType>${responseMap['appType'] }</appType>
			<description>软件升级</description>
		</updateInfo>
	</data>
</response>
