<%@ taglib prefix="im" uri="http://www.intra-mart.co.jp/taglib/im-tenant"%>
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
								<c:when test="${FormClassRows.f_agreement_number == ''}">
									<input type="text" name="f_agreement_number" class="${isLegalDisabled}"/>
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
								<c:if test="${FormClassRows.f_agreement_date == ''}">
									<input type="text" id="agreement_date"  name="f_agreement_date" class="${isLegalDisabled}" />
									<im:calendar floatable="true" altField="#agreement_date"/>
								</c:if>
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