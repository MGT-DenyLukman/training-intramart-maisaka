<%@page pageEncoding="UTF-8" contentType="text/html" isELIgnored="false" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:import url="./sp-process.jsp">
  <c:param name="content">
		<c:if test="${FormClassRows.f_purchase_order_req == 1}">
			<c:import url="./section-user/sp-approver-uhdh.jsp"></c:import>
		</c:if>
		<c:import url="./section-user/sp-approver-cco.jsp"></c:import>
		<c:import url="./section-user/sp-approver-legal.jsp"></c:import>
  </c:param>
</c:import>

<script>
	rules = {}
	messages = {}
</script>