
<!-- 申請画面：PC購入申請の入力フォーム -->
<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="imui" uri="http://www.intra-mart.co.jp/taglib/imui"%>
<%@ taglib prefix="imart" uri="http://www.intra-mart.co.jp/taglib/core/standard"%>
<%@ taglib prefix="workflow" uri="http://www.intra-mart.co.jp/taglib/imw/workflow"%>
<%@ taglib prefix="form"   uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="f" uri="http://terasoluna.org/functions"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jstl/core"%>
<%@ taglib prefix="im" uri="http://www.intra-mart.co.jp/taglib/im-tenant"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<%@ page import="java.util.List"%>
<%@ page import="java.util.ArrayList"%>
<%@ page import="java.util.Map"%>
<%@ page import="java.util.HashMap"%>


<imui:head>
	<title>Training Workflow Maisaka</title>
	<workflow:workflowOpenPageCsjs />
	
	<link href="ui/css/select2.min.css" rel="stylesheet" />
	<link href="ui/css/table-style.css" rel="stylesheet" />
    <script src="ui/js/select2.min.js" type="text/javascript"></script>
    <script src="ui/js/jquery.validate.js" type="text/javascript"></script>
    
    <script src="ui/js/script-detail-reapply.js" type="text/javascript"></script>
    
    <style>
    	table tbody tr td:last-child input[type="text"], 
    	table tbody tr td:last-child select,
    	table tbody tr td:last-child input[type="date"] {
    		width: 60%;
    	}
    	
    	#section-pl-impact {
    		overflow-x: auto;
    	}

    	#agreement_summary {
    		width: 60%;
    		height: 100px;
    	}
    	
    	#psd_dic_reason {
    		width: 80%;
    		height: 80px;
    	}

    	#agreement_classification th,
    	#section-psd-check table th,
    	#section-cco table th,
    	#section-legal table th{
    		width: 250px;
    	}
    	
    	
    	
    	.bg-warning {
    		background: yellow;
    		width: fit-content;
    	}
    </style>
    


	

	
	<!-- CSS Scripts -->
    <style type="text/css">
        
    </style>
</imui:head>

<workflow:workflowUserContentsAuth imwApplyBaseDate='${f:h(ApplyForm.imwApplyBaseDate)}'
            imwAuthUserCode = '${f:h(ApplyForm.imwAuthUserCode)}'
            imwFlowId='${f:h(ApplyForm.imwFlowId)}'
            imwNodeId ='${f:h(ApplyForm.imwNodeId)}'
            imwPageType = '${f:h(ApplyForm.imwPageType)}'
            imwSystemMatterId='${f:h(ApplyForm.imwSystemMatterId)}'
            imwUserDataId='${f:h(ApplyForm.imwUserDataId)}'/>
            

<div class="imui-title-small-window">
	<h1>Training Workflow Maisaka</h1>
</div>
<div class="imui-toolbar-wrap">
 	<div class="imui-toolbar-inner">
		<ul class="imui-list-toolbar">
			<li>
				<a href="javascript:void(0);" id="back">
					<span class="im-ui-icon-common-16-back"></span>
				</a>
			</li>
		</ul>
	</div>
</div>


	<imui:tabs selected="0">
		<imui:tabItem title="購入承認権" >
			<div class="imui-form-container">
		<!-- ワークフロー連携フォーム -->
<workflow:workflowOpenPage name="workflowOpenPageForm"
		id="workflowOpenPageForm"
		method="POST"
		target="_top"
		imwUserDataId="${f:h(ApplyForm.imwUserDataId)}"
		imwSystemMatterId="${f:h(ApplyForm.imwSystemMatterId)}"
		imwAuthUserCode="${f:h(ApplyForm.imwAuthUserCode)}"
		imwApplyBaseDate="${f:h(ApplyForm.imwApplyBaseDate)}"
		imwNodeId="${f:h(ApplyForm.imwNodeId)}"
		imwFlowId="${f:h(ApplyForm.imwFlowId)}"
		imwCallOriginalParams="${f:h(ApplyForm.imwCallOriginalParams)}"
		imwNextScriptPath="${f:h(ApplyForm.imwCallOriginalPagePath)}"
		>	

			<div>
				  <header class="imui-chapter-title">
					<h2>Applicant Information</h2>
				</header>
				
				<table id="applicant_information" class="imui-form tab_header">
					<tbody>
						<tr>
							<th><label>Application Number</label></th>
							<td>
								<label>${f:h(FormClassRows.f_application_number) }</label>
							</td>
							<th><label>Application Date</label></th>
							<td>
								<label>${f:h(FormClassRows.f_application_date) }</label>
							</td>
						</tr>
						<tr>
							<th><label>Applicant Number</label></th>
							<td>
								<label>${f:h(FormClassRows.f_application_number) }</label>
							</td>
							<th><label>Department Name</label></th>
							<td>
								<label>${f:h(FormClassRows.f_applicant_dept_name) }</label>
								<div class="error_message"><label class="error">${dept_name_err_message }</label></div>
							</td>
						</tr>
						<tr>
							<th><label>Applicant Name</label></th>
							<td>
								<label>${f:h(FormClassRows.f_applicant_name) }</label>
							</td>
							<th><label>Position Name</label></th>
							<td>
								<label>${f:h(FormClassRows.f_applicant_pos_name) }</label>
								<div class="error_message"><label class="error">${pos_name_err_message }</label></div>
							</td>
						</tr>
					</tbody>
				</table>
			</div>
				  <header class="imui-chapter-title">
					<h2>Agreement Detail</h2>
				</header>

				<table id="agreement_detail" class="imui-form tab_header">
					<tbody>
						<tr>
						  <th><label class="imui-required">Counter Party (vendor name, etc)</label></th>
						  <td>
								<label>${f:h(FormClassRows.f_counter_party) }</label>
						  </td>
						</tr>

						<tr>
						  <th><label class="imui-required">Currency</label></th>
						  <td>
						  	<select name="f_currency" >
						  		<option value="IDR">IDR</option>
						  	</select>
						  </td>
						</tr>

						<tr>
						  <th><label class="imui-required">Total Amount (Without Tax)</label></th>
						  <td>
								<label>${f:h(FormClassRows.f_total_amount_no_tax) }</label>
						  </td>
						</tr>

						<tr>
						  <th><label class="imui-required">Agreement Status</label></th>
						  <td>
						  		<input type="radio" id="one_time" name="f_agreement_status" value="1"
						  			${FormClassRows.f_agreement_status == 1 ? "checked" : "" }
						  			
						  		/>
						  		<label for="one_time">One Time/New</label>
						  		<br>
						  		<input type="radio" id="extension" name="f_agreement_status" value="2" 
									  ${FormClassRows.f_agreement_status == "2_a" || FormClassRows.f_agreement_status == "2_b" ? "checked" : "" }
						  			
						  		/>
						  		<label for="extension">Amendment/Extension/Renewal</label>
						  		<br>
						  		<div id="extension-childs" style="padding-left: 2em">
									  <p>Total Duration from first cooperation until now</p>
									  <input type="radio" id="gt_1" name="f_renewal" value="a"
									  ${agreementStatusRenewal == "a" ? "checked" : "" }
						  			
									  />
									  <label for="gt_1">More than 1 year</label>
									  <input type="radio" id="lte_1" name="f_renewal" value="b"
									  ${agreementStatusRenewal == "b" ? "checked" : "" }
						  			
									  />
									  <label for="lte_1">up to 1 year</label>
						  		</div>
						  		<input type="radio" id="umbrella" name="f_agreement_status" value="3"
						  			${FormClassRows.f_agreement_status == 3 ? "checked" : "" }
						  			
						  		/>
						  		<label for="umbrella">Umbrella Agreement</label>
						  </td>
						</tr>

						<tr>
							<th><label class="imui-required">Include auto extension condition</label></th>
							<td>
						  		<input type="radio" id="auto_extension_y" name="f_auto_extension" value="1" 
						  			${FormClassRows.f_is_auto_extension == 1 ? "checked" : "" }
						  			
						  		/>
						  		<label for="auto_extension_y">Yes</label>
						  		<br>
						  		<input type="radio" id="auto_extension_n" name="f_auto_extension" value="0"
						  			${FormClassRows.f_is_auto_extension == 0 ? "checked" : "" }
						  			
						  		/>
						  		<label for="auto_extension_n">No</label>
							</td>
						</tr>

						<tr>
							<th><label class="imui-required">Purchase Order Required</label></th>
							<td>
						  		<input type="radio" id="purchase_order_req_y" name="f_purchase_order_req" value="1" 
						  			${FormClassRows.f_purchase_order_req == 1 ? "checked" : "" }
						  			
						  		/>
						  		<label for="purchase_order_req_y">Yes</label>
						  		<br>
						  		<input type="radio" id="purchase_order_req_n" name="f_purchase_order_req" value="0"
						  			${FormClassRows.f_purchase_order_req == 0 ? "checked" : "" }
						  			
						  		/>
						  		<label for="purchase_order_req_n">No</label>
							</td>
						</tr>

						<tr>
						  <th><label class="imui-required">Title described in Agreement</label></th>
						  <td>
								<label>${f:h(FormClassRows.f_title_in_agreement) }</label>
						  </td>
						</tr>

						<tr class="doublerow">
						  <th rowspan="2"><label class="imui-required">Effective Date</label></th>
						  <th><label class="imui-required">From</label></th>
						  <td>
								<label>${f:h(FormClassRows.f_effective_date_from) }</label>
						  </td>
						</tr>
						<tr class="doublerow">
						  <th><label class="imui-required">To</label></th>
						  <td>
								<label>${f:h(FormClassRows.f_effective_date_to) }</label>
						  </td>
						</tr>

						<tr>
							<th><label class="imui-required">Related / Non Related Company</label></th>
							<td>
						  		<input type="radio" id="related_parties_y" name="f_related_company" value="1"
						  			${FormClassRows.f_is_related_comp == 1 ? "checked" : "" }
						  			
						  		/>
						  		<label for="related_parties_y">Related Parties [Shareholders (KY, MFTBC, MC, MCAH, Daimler), Subsidiary (i.e. KRM, MKM, BAS, BBD, BMC, etc.), Affiliates (i.e. DSF, BSI, MMKSI, MMKI, etc.)]</label>
						  		<br>
						  		<input type="radio" id="related_parties_n" name="f_related_company" value="0"
						  			${FormClassRows.f_is_related_comp == 0 ? "checked" : "" }
						  			
						  		/>
						  		<label for="related_parties_n">Non Related Parties</label>
						  		<br>
						  		<p class="bg-warning"><i>Consult with Legal. SHR may be required</i></p>
							</td>
						</tr>

						<tr class="doublerow">
						  <th rowspan="2"><label class="imui-required">Estimated Delivery Schedule</label></th>
						  <th><label class="imui-required">From</label></th>
						  <td>
								<label>${f:h(FormClassRows.f_delivery_date_from) }</label>
						  </td>
						</tr>
						<tr class="doublerow">
						  <th><label class="imui-required">To</label></th>
						  <td>
								<label>${f:h(FormClassRows.f_delivery_date_to) }</label>
						  </td>
						</tr>
						
						<tr>
						  <th><label>Agreement Summary (main points only) (In case of contract in foreign currency need to describe exchange rate)</label></th>
						  <td>
								<label>${f:h(FormClassRows.f_agreement_summary) }</label>
						  </td>
						</tr>
							
					</tbody>
				</table>

				  <header class="imui-chapter-title">
					<h2>Depreciation Check</h2>
				</header>

				<table id="depreciation_check" class="imui-form tab_header">
					<tbody>
						<tr>
						  <th><label class="imui-required">Purchase Category</label></th>
						  <td>
						  		<input type="radio" id="tangible_asset" name="f_purchase_category" value="1"
						  			${FormClassRows.f_purchase_category == 1 ? "checked" : "" }
						  			
						  		 />
						  		<label for="tangible_asset">Tangible Asset</label>

						  		<input type="radio" id="intangible_asset" name="f_purchase_category" value="0"
						  			${FormClassRows.f_purchase_category == 0 ? "checked" : "" }
						  			
						  		/>
						  		<label for="intangible_asset">Intangible Asset</label>

						  		<input type="radio" id="non_asset" name="f_purchase_category" value="9"
						  			${FormClassRows.f_purchase_category == 9 ? "checked" : "" }
						  			
						  		/>
						  		<label for="non_asset">Non-Asset</label>
						  </td>
						</tr>
						<tr class="depreciation_required_asset">
						  <th><label class="imui-required">Starting Usage Date (Required if Asset)</label></th>
						  <td>
								<label>${f:h(FormClassRows.f_starting_usage_date) }</label>
						  </td>
						</tr>
						<tr class="depreciation_required_asset">
						  <th><label class="imui-required">Deprec Amount/Month (Required if Asset)</label></th>
						  <td>
								<label>${f:h(FormClassRows.f_deprec_amount_per_month) }</label>
						  </td>
						</tr>
					</tbody>
					</table>

					<!-- START COMMENTED -->
					<!-- 
				<div id="section-pl-impact">
					  <header class="imui-chapter-title">
						<h2>PL Impact</h2>
					</header>

				
					<table id="pl_impact" class="imui-form tab_header">
						<tbody>
							<tr>
									<th><label class="imui-required">Budget PL impact to current FY</label></th>
									<th><label class="imui-required">Month</label></th>
									<th><label class="imui-required">PL Impact to current FY</label></th>
									<th><label class="imui-required">Month</label></th>
							</tr>
							<tr>
									<td><input type="text" name="f_budget_impact_to_fy"/></td>
									<td><input type="text" name="f_budget_impact_month"/></td>
									<td><input type="text" name="f_pl_impact_to_fy"/></td>
									<td><input type="text" name="f_pl_impact_month"/></td>
							</tr>
						</tbody>
					</table>
				</div>
					
					
					
					  <header class="imui-chapter-title">
						<h2>Asset</h2>
					</header>

					<table id="asset" class="imui-form tab_header">
						<tbody>
							<tr>
									<th><label class="imui-required">Asset Number</label></th>
									<th><label class="imui-required">Book Value</label></th>
							</tr>
							<tr>
									<td><input type="text" name="f_asset_number"/></td>
									<td><input type="text" name="f_book_value"/></td>
							</tr>
						</tbody>
					</table>
					-->
					<!-- END COMMENTED -->
					
					
					  <header class="imui-chapter-title">
						<h2>Estimated Schedule (Payment Conditions)</h2>
					</header>

					<table id="estimated_schedule" class="imui-form tab_header">
						<tbody>
							<tr>
								<th colspan="2"><label class="imui-required">Payment (Total Cash flow Impact)</label></th>
							</tr>
							<tr>
									<th><label class="imui-required">Amount</label></th>
									<th><label class="imui-required">Date</label></th>
							</tr>
							<c:forEach items="${FormClassRows. d_estimated_schedule_payment}" var="row">
								<tr>
										<td>
												<label>${f:h(row.payment_amount) }</label>
										</td>
										<td>
												<label>${f:h(row.payment_date.replaceAll("-", "/")) }</label>
										</td>
								</tr>
							</c:forEach>
							<tr>
									<th><label class="imui-required">Total Amount</label></th>
							</tr>
							<tr>
									<td>
											<label>${f:h(esTotalAmount) }</label>
									</td>
							</tr>
						</tbody>
					</table>
					
					  <header class="imui-chapter-title">
						<h2>Agreement Classification</h2>
					</header>

					<table id="agreement_classification" class="imui-form tab_header">
						<tbody>
							<tr>
									<th><label class="imui-required">Agreement Classification</label></th>
									<td>
											<input type="radio" id="pd_approval" name="f_agreement_classification" value="1" 
											${agreementClassification == 1 ? "checked" : ""}
											
											/>
											<label for="pd_approval">PD Approval (either one of condition below)</label>
												<div class="pd_approval_childrens" style="padding-left: 2em">
														<input type="radio" id="gte_1_billion" name="f_agreement_classification_1" value="1"
														${agreementClassificationChildren == 1 ? "checked" : ""}
														
														/>
														<label for="gte_1_billion">Agreement with amount is equal or more than 1 billion</label>
														<br>
														<input type="radio" id="gte_12_months" name="f_agreement_classification_1" value="2"
														${agreementClassificationChildren == 2 ? "checked" : ""}
														
														/>
														<label for="gte_12_months">Period is equal or more than 12 months</label>
														<br>
														<div>
															<input type="radio" id="related_parties" name="f_agreement_classification_1" value="3"
															${agreementClassificationChildren == 3 ? "checked" : ""}
															
															/>
															<label for="related_parties">Agreement related to spesific party</label>
															<br>
															<p style="padding-left: 2em"><i>- Bank, Related Parties, Dealer, Consulatant/Lawyer/Appraiser (Vendor head-hunter, ISO Certification, HR system development, etc), Government, Production(Component and Parts), Customer, Etc</i></p>
														</div>

														<input type="radio" id="special_issue" name="f_agreement_classification_1" value="4"
															${agreementClassificationChildren == 4 ? "checked" : ""}
															
														/>
														<label for="special_issue">Special issue</label>
														<br>
														<p style="padding-left: 2em"><i>New project/Issue (more than 50 M), Not included in Budget Plan</i></p>

														<input type="radio" id="direct_procurement" name="f_agreement_classification_1" value="5"
															${agreementClassificationChildren == 5 ? "checked" : ""}
															
														/>
														<label for="direct_procurement">Direct Procurement due to either of the 2 cases below</label>
														<br>
														<div style="padding-left: 2em">
															<ul style="list-style-type: decimal">
																	<li><i>Emergency procurement</i></li>
																	<li><i>Spesific Goods / Items (refere to PSD Guideline)</i></li>
															</ul>
														</div> 
												</div>
											<div>
												<input type="radio" id="dic_approval" name="f_agreement_classification" value="2"
												${agreementClassification == 2 ? "checked" : ""}
												
												/>
												<label for="dic_approval">DIC Director Approval</label>
											</div>
									</td>
							</tr>
							<tr>
									<th><label class="imui-required">EC Approval is Required or Not</label></th>
									<td>
											<input type="radio" id="ec_approval_yes" name="f_ec_approval_is_required" value="1"
												${ecApprovalIsReq == 1 ? "checked" : ""}
												
											/>	
											<label for="ec_approval_yes">Yes</label>
												<div class="ec_approval_yes_childrens" style="padding-left: 2em">
														<input type="radio" id="amount_gte_1_billion" name="f_ec_approval_yes" value="1" 
															${ecApprovalIsReqYesChildren == 1 ? "checked" : ""}
															
														/>	
														<label for="amount_gte_1_billion">Amount is equal or more than 1 billion</label>
														<br>	
														<input type="radio" id="period_gt_12_month" name="f_ec_approval_yes" value="2"
															${ecApprovalIsReqYesChildren == 2 ? "checked" : ""}
															
														/>	
														<label for="period_gt_12_month">Period is equal or more than 12 months</label>
														<br>	
														<input type="radio" id="escalate_issue" name="f_ec_approval_yes" value="3"
															${ecApprovalIsReqYesChildren == 3 ? "checked" : ""}
															
														/>	
														<label for="escalate_issue">Director believes it is necessary to escalate the issue to EC</label>
												</div>
												<div>
														<input type="radio" id="ec_approval_no" name="f_ec_approval_is_required" value="0"
															${ecApprovalIsReq == 0 ? "checked" : ""}
															
														/>	
														<label for="ec_approval_no">No</label>
												</div>
									</td>
							</tr>
						</tbody>
					</table>

					<c:if test="${FormClassRows.f_purchase_order_req == 1}">
					<div id="section-psd-check">
					  <header class="imui-chapter-title">
						<h2>PSD Check (by UH or DH, PSD)</h2>
					</header>

					<table id="psd_check" class="imui-form tab_header">
						<tbody>
								<tr>
										<th><label class="imui-required">PSD Area or Non-PSD Area (Based on Guideline)</label></th>
										<td>
												<input type="radio" id="psd" name="f_psd_area_bog" value="1"
												
												${FormClassRows.f_psd_area_bog == 1 ? "checked" : "" }
												 ${isUHDHDisabled}/>	
												<label for="psd">PSD (go to #2)</label>
												<br>
												<input type="radio" id="psd_end" name="f_psd_area_bog" value="0"
												
												${FormClassRows.f_psd_area_bog == 0 ? "checked" : "" }
												 ${isUHDHDisabled}/>	
												<label for="psd_end">Non-PSD (End)</label>
												<div class="error_message"></div>
										</td>
								</tr>
								<tr id="f_psd_area_second">
										<th><label class="imui-required">In PSD Area, PSD Process or DIC Process</label></th>
										<td>
												<input type="radio" id="psd_2" name="f_psd_process" value="PSD"
												
												${FormClassRows.f_psd_process == "PSD" ? "checked" : "" }
												${isUHDHDisabled}/>	
												<label for="psd_2">PSD (Pitching result attached)</label>
												<br>
												<input type="radio" id="psd_dic" name="f_psd_process" value="DIC" 
												
												${FormClassRows.f_psd_process == "DIC" ? "checked" : "" }
												${isUHDHDisabled}/>	
												<label for="psd_dic">DIC (Please describe the reason in the below)</label>
												<textarea id="psd_dic_reason" name="f_dic_reason"  ${isUHDHDisabled} >${FormClassRows.f_dic_reason}</textarea>
												<div class="error_message"></div>
										</td>
								</tr>
						</tbody>
					</table>
				</div>
				</c:if>

				<div id="section-cco">
					  <header class="imui-chapter-title">
						<h2>Compliance Check By CCO</h2>
					</header>

					<table id="compliance_check" class="imui-form tab_header">
						<tbody>
								<tr>
										<th><label class="imui-required">D / D Process Required</label></th>
										<td>
												<input type="radio" id="dd_process_yes" name="f_dd_process" value="1" class="section_cco"
												
												${FormClassRows.f_dd_process == 1 ? "checked" : "" }
												 ${isCCODisabled}/>	
												<label for="dd_process_yes">Yes</label>
												<input type="radio" id="dd_process_no" name="f_dd_process" value="0"  class="section_cco"
												
												${FormClassRows.f_dd_process == 0 ? "checked" : "" }
												${isCCODisabled} />	
												<label for="dd_process_no">No</label>
										</td>
								</tr>
								<tr>
										<th><label class="imui-required">Anti Bribery Clause Include</label></th>
										<td>
												<input type="radio" id="anti_bribery_yes" name="f_anti_bribery" value="1"  class="section_cco"
												
												${FormClassRows.f_anti_bribery == 1 ? "checked" : "" }
												${isCCODisabled} />	
												<label for="anti_bribery_yes">Yes</label>
												<input type="radio" id="anti_bribery_no" name="f_anti_bribery" value="0"   class="section_cco"
												
												${FormClassRows.f_anti_bribery == 0 ? "checked" : "" }
												${isCCODisabled}/>	
												<label for="anti_bribery_no">No</label>
										</td>
								</tr>
								<tr>
										<th><label class="imui-required">Audit Right Included</label></th>
										<td>
												<input type="radio" id="audit_right_yes" name="f_audit_right" value="1"  class="section_cco"
												
												${FormClassRows.f_audit_right == 1 ? "checked" : "" }
												${isCCODisabled}/>	
												<label for="audit_right_yes">Yes</label>
												<input type="radio" id="audit_right_no" name="f_audit_right" value="0" class="section_cco"
												
												${FormClassRows.f_audit_right == 0 ? "checked" : "" }
												 ${isCCODisabled} />	
												<label for="audit_right_no">No</label>
										</td>
								</tr>
								<tr>
									<th><label>&nbsp;</label></th>
									<td>
										<div class="error_message"></div>
									</td>
								</tr>
						</tbody>
					</table>
				</div>
					
					
				<div id="section-legal">
					  <header class="imui-chapter-title">
						<h2>Filled By Legal</h2>
					</header>

					<table id="filled_by_legal" class="imui-form tab_header">
						<tbody>
								<tr>
										<th><label class="imui-required">Agreement Number</label></th>
										<td>
											<label>${f:h(FormClassRows.f_agreement_number) }</label>
											<div class="error_message"></div>
										</td>
								</tr>
								<tr>
										<th><label class="imui-required">Agreement Date</label></th>
										<td>
											<label>${f:h(FormClassRows.f_agreement_date) }</label>
												<div class="error_message"></div>
										</td>
								</tr>
						</tbody>
					</table>
				</div>
					
					


			
</workflow:workflowOpenPage>
				
					 <div class="imui-form-container-full">
						  <header class="imui-chapter-title">
							<h2>To see the uploaded document</h2>
						</header>

						<table id="uploaded_document" class="imui-form tab_header">
							<tbody>
									<c:forEach items="${FormClassRows.d_file_attachment}" var="row">
										<tr><td><a href="training_maisaka/download/${row.file_real_name}?token=${FormClassRows.f_download_token_request}">${row.file_name}</a></td></tr>
									</c:forEach>
							</tbody>
						</table>
				</div>
		</imui:tabItem>

		<imui:tabItem title="その他" >
			<!-- 
			<div class="imui-form-container">
				
			</div> 
			-->
			
		</imui:tabItem>
	</imui:tabs>

<!-- アクションボタン（Apply/Re-ApplyはpageTypeで分岐） -->
<div class="imui-operation-parts">
	<imart:decision case="5" value="${f:h(ApplyForm.imwPageType)}">	
		<input type="button" value='Confirm' id="openPage" name="openPage" class="imui-large-button"
			escapeXml="true" escapeJs="false" />
	</imart:decision>
		<input type="button" value='PDF' id="generatePDF" name="generatePDF" class="imui-large-button"
			escapeXml="true" escapeJs="false" />
</div>

<!-- 戻る用フォーム -->
<form name="backForm" id="backForm" method="POST" action="${f:h(ApplyForm.imwCallOriginalPagePath)}">
    <input type="hidden" name=imwCallOriginalParams value="${f:h(ApplyForm.imwCallOriginalParams)}" />
</form>

	<script>
    	function formatOutputNumber($element, value,  maxDecimal){
    		if(parseInt(value) < 1000) {
				$element.val(value)
    		}else{
				var val = value;
				var cleaned = val.replace(/[^\d.]/g, "");            // 数字と.以外を除去

				var dotIndex = cleaned.indexOf(".");
				if (dotIndex !== -1) {                               // 最初の.だけ残す
				  cleaned = cleaned.substring(0, dotIndex)
						  + "." + cleaned.substring(dotIndex + 1).replace(/\./g, "");
				}
				if (maxDecimal !== undefined && cleaned.indexOf(".") !== -1) {
				  var p = cleaned.split(".");                        // 小数桁数制限
				  if (p[1].length > maxDecimal) cleaned = p[0] + "." + p[1].substring(0, maxDecimal);
				}
				var formatted = cleaned.replace(/\B(?=(\d{3})+(?!\d))/g, ",");  // カンマ
				if (val !== formatted) $element.val(formatted);
    			
    		}
    	}
    	
    	$(document).ready(function(){
			const val = "${esTotalAmount}";
    		formatOutputNumber($('input[name="f_es_total_amount"]'), val,   2)
    	})
    	
    	$(function(){
    		$('#openPage').click(function(){
    			workflowOpenPage('${f:h(ApplyForm.imwPageType)}');
    		})
    		
    		$("#generatePDF").click(function() {
    			console.log("generated PDF button clicked");	
    			
    			$.ajax({
    				type: "POST",
    				url: "training_maisaka/generatepdf",
    				data: {
    					system_matter_id: '${f:h(ApplyForm.imwSystemMatterId)}',
    					token: '${f:h(FormClassRows.f_download_token_request)}',
    				},
    				success: function(response) {
    					console.log("success response: ", response);
    					window.location.href = "/imart/training_maisaka/downloadpdf/${f:h(ApplyForm.imwSystemMatterId)}?token=${f:h(FormClassRows.f_download_token_request)}";
    				},
    				error: function(xhr, status, e) {
    					console.log("AJAX ERROR : ", e);
    				}
    			})
    		})
    	})
	</script>

    <script src="ui/js/script-prevent-default-radio.js" type="text/javascript"></script>