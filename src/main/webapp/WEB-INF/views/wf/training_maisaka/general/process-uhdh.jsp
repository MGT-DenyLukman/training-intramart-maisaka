<%@page pageEncoding="UTF-8" contentType="text/html" isELIgnored="false" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:import url="./process.jsp">
  <c:param name="content">
  		<c:import url="./section-user/approver-uhdh.jsp">
  		
  		</c:import>

  </c:param>
</c:import>

				<script>
					$(function() {
						rules = {}
						messages = {}
						groups = {}
						
						rules.f_psd_area_bog = {required: true, id: false};
						messages.f_psd_area_bog = {required: "チェックしてください"}

						$('input[name="f_psd_area_bog"]').change(function() {
							if(($('input[name="f_psd_area_bog"]')[0]).checked == true){
								$('#f_psd_area_second').show();
								rules.f_psd_process = {required: true, id: false};
								messages.f_psd_process = {required: "チェックしてください"}
							}else{
								$('#f_psd_area_second').hide();
								delete rules.f_psd_process;
								delete messages.f_psd_process;
							}   		
						})

						$('input[name="f_psd_process"]').change(function() {
							if(($('input[name="f_psd_process"]')[1]).checked == true){
								$('#psd_dic_reason').show();
								rules.f_dic_reason = {required: true, id: false}
								messages.f_dic_reason = {required: "入力してください"}
							}else{
								$('#psd_dic_reason').hide();
								delete rules.f_dic_reason;
								delete messages.f_dic_reason;
							}   		
						})
					})
					
					$(document).ready(function() {
							if(($('input[name="f_psd_area_bog"]')[0]).checked == true){
								$('#f_psd_area_second').show();
							}else{
								$('#f_psd_area_second').hide();
							}
							if(($('input[name="f_psd_process"]')[1]).checked == true){
								$('#psd_dic_reason').show();
							}else{
								$('#psd_dic_reason').hide();
							}
						
					})
				</script>