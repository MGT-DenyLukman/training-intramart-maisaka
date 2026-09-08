<%@ taglib prefix="f" uri="http://terasoluna.org/functions"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="imsp" uri="http://www.intra-mart.co.jp/taglib/imsp"%>
<div id="section-cco">
	  <header class="ui-bar ui-bar-b">
		<h2>Compliance Check By CCO</h2>
	</header>

	<div id="compliance_check" class="ui-body ui-body-b">
				<imsp:fieldContain label="D / D Process Required :">
					<div>
							<input type="radio" id="dd_process_yes" name="f_dd_process" value="1" class="section_cco ${isCCODisabled }"
							data-role="none"
							${FormClassRows.f_dd_process == 1 ? "checked" : "" }
							 />	
							<label for="dd_process_yes">Yes</label>
							<input type="radio" id="dd_process_no" name="f_dd_process" value="0"  class="section_cco ${isCCODisabled }"
							data-role="none"
							${FormClassRows.f_dd_process == 0 ? "checked" : "" }
							/>	
							<label for="dd_process_no">No</label>
					</div>
				</imsp:fieldContain>
				<imsp:fieldContain label="Anti Bribery Clause Include :">
						<div>
								<input type="radio" id="anti_bribery_yes" name="f_anti_bribery" value="1"  class="section_cco ${isCCODisabled }"
								data-role="none"
								${FormClassRows.f_anti_bribery == 1 ? "checked" : "" }
								/>	
								<label for="anti_bribery_yes">Yes</label>
								<input type="radio" id="anti_bribery_no" name="f_anti_bribery" value="0"   class="section_cco ${isCCODisabled }"
								data-role="none"
								${FormClassRows.f_anti_bribery == 0 ? "checked" : "" }
								/>	
								<label for="anti_bribery_no">No</label>
						</div>
				</imsp:fieldContain>
				<imsp:fieldContain label="Audit Right Included :">
						<div>
								<input type="radio" id="audit_right_yes" name="f_audit_right" value="1"  class="section_cco ${isCCODisabled }"
								data-role="none"
								${FormClassRows.f_audit_right == 1 ? "checked" : "" }
								/>	
								<label for="audit_right_yes">Yes</label>
								<input type="radio" id="audit_right_no" name="f_audit_right" value="0" class="section_cco ${isCCODisabled }"
								data-role="none"
								${FormClassRows.f_audit_right == 0 ? "checked" : "" }
								 />	
								<label for="audit_right_no">No</label>
						</div>
				</imsp:fieldContain>
				<c:if test="${isCCODisabled != 'unclickable' }">
						<div class="error_message"></div>
				</c:if>
	</div>
</div>