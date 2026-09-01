<%@page pageEncoding="UTF-8" contentType="text/html" isELIgnored="false" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:import url="./process.jsp">
  <c:param name="content">
		<c:if test="${FormClassRows.f_purchase_order_req == 1}">
			<c:import url="./section-user/approver-uhdh.jsp">
			</c:import>
		</c:if>
		<c:import url="./section-user/approver-cco.jsp"></c:import>
  </c:param>
</c:import>

<script>
	rules = {}
	messages = {}

	rules.f_dd_process = {required: true, id: false};
	messages.f_dd_process = {required: "チェックしてください"}

	rules.f_anti_bribery = {required: true, id: false};
	messages.f_anti_bribery = {required: "チェックしてください"}

	rules.f_audit_right = {required: true, id: false};
	messages.f_audit_right = {required: "チェックしてください"}
</script>