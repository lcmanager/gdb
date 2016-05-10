<#--
 #%L
 Game Database Control
 %%
 Copyright (C) 2016 LCManager Group
 %%
 Licensed under the Apache License, Version 2.0 (the "License");
 you may not use this file except in compliance with the License.
 You may obtain a copy of the License at
 
      http://www.apache.org/licenses/LICENSE-2.0
 
 Unless required by applicable law or agreed to in writing, software
 distributed under the License is distributed on an "AS IS" BASIS,
 WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 See the License for the specific language governing permissions and
 limitations under the License.
 #L%
-->

<!-- HTML structure macros. -->
<#macro bootstrap>
	<meta encoding="UTF-8">

	<#if dev!false>
		<!-- CSS -->
		<!-- Bootstrap -->
		<link rel="stylesheet" href="${context}/css/bootstrap.css">
		<link rel="stylesheet" href="${context}/css/bootstrap-theme.css">

		<!-- JavaScript -->
		<!-- jQuery -->
		<script src="${context}/js/jquery.js"></script>
		<!-- AngularJS -->
		<script src="${context}/js/angular.js"></script>
		<script src="${context}/js/angular-animate.js"></script>
		<script src="${context}/js/angular-resource.js"></script>
		<!-- Bootstrap -->
		<script src="${context}/js/bootstrap.js"></script>
	<#else>
		<!-- CSS -->
		<!-- Bootstrap -->
		<link rel="stylesheet" href="${context}/css/bootstrap.min.css">
		<link rel="stylesheet" href="${context}/css/bootstrap-theme.min.css">

		<!-- JavaScript -->
		<!-- jQuery -->
		<script src="${context}/js/jquery.min.js"></script>
		<!-- AngularJS -->
		<script src="${context}/js/angular.min.js"></script>
		<script src="${context}/js/angular-animate.min.js"></script>
		<script src="${context}/js/angular-resource.min.js"></script>
		<!-- Bootstrap -->
		<script src="${context}/js/bootstrap.min.js"></script>
	</#if>
</#macro>
<#macro head>
	<!-- GDB Stuff -->
	<!-- CSS -->
	<link rel="stylesheet" href="${context}/css/main.css">

	<!-- JavaScript -->
	<script src="${context}/js/constants.js"></script>
	<script src="${context}/js/gdb.js"></script>
</#macro>
<#macro body>
	<noscript>
		<div class="container" style="z-index: 100000; position: fixed; top: 20px; left: 20px">
			<div class="alert alert-danger">
				<strong>JavaScript disabled!</strong> Please enable JavaScript to view this site correctly!
			</div>
		</div>
	</noscript>
</#macro>
<#macro tail>
</#macro>

<!-- GDB macros. -->
<#macro init>
	<script>
		if (!('Constants' in window)) {
			window.Constants = {};
		}
		Constants.context = '${context}';
	</script>

	<script>
		angular.module('gdbApp', []).factory('csrf', function() {
			return {
				parameterName : '${_csrf.parameterName}',
				token : '${_csrf.token}'
			};
		});
	</script>
</#macro>
<#macro csrf>
	<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
</#macro>
