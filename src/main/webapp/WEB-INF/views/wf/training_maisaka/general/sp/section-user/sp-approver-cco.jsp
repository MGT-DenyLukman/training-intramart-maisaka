<div id="section-cco">
	  <header class="imui-chapter-title">
		<h2>Compliance Check By CCO</h2>
	</header>

	<table id="compliance_check" class="imui-form tab_header">
		<tbody>
				<tr>
						<th><label class="imui-required">D / D Process Required</label></th>
						<td>
								<input type="radio" id="dd_process_yes" name="f_dd_process" value="1" class="section_cco ${isCCODisabled }"
								${FormClassRows.f_dd_process == 1 ? "checked" : "" }
								 />	
								<label for="dd_process_yes">Yes</label>
								<input type="radio" id="dd_process_no" name="f_dd_process" value="0"  class="section_cco ${isCCODisabled }"
								${FormClassRows.f_dd_process == 0 ? "checked" : "" }
								/>	
								<label for="dd_process_no">No</label>
						</td>
				</tr>
				<tr>
						<th><label class="imui-required">Anti Bribery Clause Include</label></th>
						<td>
								<input type="radio" id="anti_bribery_yes" name="f_anti_bribery" value="1"  class="section_cco ${isCCODisabled }"
								${FormClassRows.f_anti_bribery == 1 ? "checked" : "" }
								/>	
								<label for="anti_bribery_yes">Yes</label>
								<input type="radio" id="anti_bribery_no" name="f_anti_bribery" value="0"   class="section_cco ${isCCODisabled }"
								${FormClassRows.f_anti_bribery == 0 ? "checked" : "" }
								/>	
								<label for="anti_bribery_no">No</label>
						</td>
				</tr>
				<tr>
						<th><label class="imui-required">Audit Right Included</label></th>
						<td>
								<input type="radio" id="audit_right_yes" name="f_audit_right" value="1"  class="section_cco ${isCCODisabled }"
								${FormClassRows.f_audit_right == 1 ? "checked" : "" }
								/>	
								<label for="audit_right_yes">Yes</label>
								<input type="radio" id="audit_right_no" name="f_audit_right" value="0" class="section_cco ${isCCODisabled }"
								${FormClassRows.f_audit_right == 0 ? "checked" : "" }
								 />	
								<label for="audit_right_no">No</label>
						</td>
				</tr>
				<c:if test="${isCCODisabled != 'unclickable' }">
				<tr>
					<td><label>&nbsp;</label></td>
					<td>
						<div class="error_message"></div>
					</td>
				</tr>
				</c:if>
		</tbody>
	</table>
</div>