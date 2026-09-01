<%@page pageEncoding="UTF-8" contentType="text/html" isELIgnored="false" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<style>
	#compliance_check tr:last-child {
		display: none;
	}
</style>
<c:import url="./process.jsp">
  <c:param name="content">
		<c:if test="${FormClassRows.f_purchase_order_req == 1}">
			<c:import url="./section-user/approver-uhdh.jsp"></c:import>
		</c:if>
		<c:import url="./section-user/approver-cco.jsp"></c:import>
		<c:import url="./section-user/approver-legal.jsp"></c:import>
  </c:param>
</c:import>


<script>
	rules = {}
	messages = {}
	
	rules.f_agreement_number = {
			required: true,
			id: false,
	}
	rules.f_agreement_date = {
			required: true,
			validDate: true,
			id: false,
	}
	messages.f_agreement_number = {required: "Agreement Numberを入力してください"}
	messages.f_agreement_date = {required: "Agreement Dateを入力してください"}

	
</script>