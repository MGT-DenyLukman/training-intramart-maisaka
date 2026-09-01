<%@ taglib prefix="im" uri="http://www.intra-mart.co.jp/taglib/im-tenant"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="f" uri="http://terasoluna.org/functions"%>
<div id="section-legal">
	  <header class="imui-chapter-title">
		<h2>Filled By Legal</h2>
	</header>

	<table id="filled_by_legal" class="imui-form tab_header">
		<tbody>
				<tr>
						<th><label class="imui-required">Agreement Number</label></th>
						<td>
							<c:choose>
								<c:when test="${isLegalDisabled != 'unclickable'}">
									<input type="text" name="f_agreement_number" class="${isLegalDisabled}" value="${f:h(FormClassRows.f_agreement_number) }"/>
								</c:when>
								<c:otherwise>
									<label>${f:h(FormClassRows.f_agreement_number) }</label>
								</c:otherwise>
							</c:choose>
							<div class="error_message"></div>
						</td>
				</tr>
				<tr>
						<th><label class="imui-required">Agreement Date</label></th>
						<td>
							<c:choose>
								<c:when test="${isLegalDisabled != 'unclickable'}">
									<input type="text" id="agreement_date"  name="f_agreement_date" class="${isLegalDisabled}" value="${f:h(FormClassRows.f_agreement_date.replaceAll('-','/')) }"/>
									<im:calendar floatable="true" altField="#agreement_date"/>
								</c:when>
								<c:otherwise>
									<label>${f:h(FormClassRows.f_agreement_date.replaceAll("-","/")) }</label>
								</c:otherwise>
							</c:choose>
							<div class="error_message"></div>
						</td>
				</tr>
		</tbody>
	</table>
</div>