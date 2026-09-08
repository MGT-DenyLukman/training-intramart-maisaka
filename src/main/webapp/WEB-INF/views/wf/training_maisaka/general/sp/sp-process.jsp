
<!-- 申請画面：PC購入申請の入力フォーム -->
<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8" isELIgnored="false"%>
<%@ taglib prefix="imui" uri="http://www.intra-mart.co.jp/taglib/imui"%>
<%@ taglib prefix="imart" uri="http://www.intra-mart.co.jp/taglib/core/standard"%>
<%@ taglib prefix="workflowSmartphone" uri="http://www.intra-mart.co.jp/taglib/imw/workflow-smartphone" %>
<%@ taglib prefix="form"   uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="f" uri="http://terasoluna.org/functions"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jstl/core"%>
<%@ taglib prefix="imsp" uri="http://www.intra-mart.co.jp/taglib/imsp"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<%@ page import="java.util.List"%>
<%@ page import="java.util.ArrayList"%>
<%@ page import="java.util.Map"%>
<%@ page import="java.util.HashMap"%>


<imui:head>
	<title>Training Workflow Maisaka</title>
	<workflowSmartphone:spWorkflowOpenPageCsjs />
	
	<link href="ui/css/select2.min.css" rel="stylesheet" />
	<link href="ui/css/table-style.css" rel="stylesheet" />

    <script src="ui/js/select2.min.js" type="text/javascript"></script>
    <script src="ui/js/jquery.validate.js" type="text/javascript"></script>
    <script src="ui/js/script-detail-reapply.js" type="text/javascript"></script>

	<link rel="stylesheet" href="ui/jq/jquery-ui.css">
	<link href="ui/css/select2-4013.min.css" rel="stylesheet" />
	<link href="ui/css/select2.min.css" rel="stylesheet" />
	<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css"
    integrity="sha512-iecdLmaskl7CVkqkXNQ/ZH/XLlvWZOJyj7Yy7tcenmpD1ypASozpmT/E0iPtmFIB46ZmdtAc9eNBvH0H/ZpiBw==" crossorigin="anonymous" referrerpolicy="no-referrer" />
	<script src="ui/jq/jquery-ui.js"></script>
	<script src="ui/js/select2-4013.min.js"></script>
	<script src="ui/libs/jquery-validation-1.9.0/jquery.validate.js"></script>
	<script src="ui/js/select2.min.js"></script>
	<script src="ui/js/jquery.validate.js"></script>
    
    <style>
    	table tbody tr td:last-child input[type="text"], 
    	table tbody tr td:last-child select,
    	table tbody tr td:last-child input[type="date"] {
    		width: 60%;
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

		/* Target the actual error text label instead of the input box */
		label.error:not(:empty) {
		    color: #d61657 !important;
		    
		    /* FIX: 'flex' forces the whole message block onto its own new line under the input */
		    display: flex !important; 
		    align-items: center;
		    
		    vertical-align: middle;
		    margin-top:5px !important;
		    clear: both;           /* Prevents floating elements from wrapping around it */
		}
		
		/* Inject your exact custom sprite icon code before the text */
		label.error:not(:empty)::before {
		    content: "" !important;
		    display: inline-block;
		    vertical-align: middle;
		    margin-top:0px;
		    margin-right:5px;
		    
		    /* Your exact custom asset dimensions and coordinate properties */
		    background: transparent url(ui/images/d.png) no-repeat -74px -162px !important;
		    width: 18px;
		    height: 18px;
		    flex-shrink: 0;      /* Prevents the icon sprite from squeezing on narrow rows */
		}
		
		label.error:empty {
		    display: none !important;
		}
    </style>
    
    <style>
    	.ui-body-d {
    		min-height: 80vh !important;
    	}
    	.ui-content {
    		padding: 0px;
    	}
    </style>


	

	
	<!-- CSS Scripts -->
    <style type="text/css">
        
    </style>
    
    
    <script type="text/javascript">
    	$(function(){
			$('#back').click(function() {
				$('#backForm').submit();
				return false;
			});
    		
    	})
    </script>

    
</imui:head>

<workflowSmartphone:spWorkflowUserContentsAuth imwApplyBaseDate='${f:h(ApplyForm.imwApplyBaseDate)}'
            imwAuthUserCode = '${f:h(ApplyForm.imwAuthUserCode)}'
            imwFlowId='${f:h(ApplyForm.imwFlowId)}'
            imwNodeId ='${f:h(ApplyForm.imwNodeId)}'
            imwPageType = '${f:h(ApplyForm.imwPageType)}'
            imwSystemMatterId='${f:h(ApplyForm.imwSystemMatterId)}'
            imwUserDataId='${f:h(ApplyForm.imwUserDataId)}'/>
            


	<div data-theme="a" data-role="header" data-position="fixed">
		<a data-role="button" data-icon="back" id="back" class="back">Back</a>
		<h1>Training Maisaka Workflow</h1>
	</div>
	<div data-role="content">

		<!-- ワークフロー連携フォーム -->
<workflowSmartphone:spWorkflowOpenPage name="workflowOpenPageForm"
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

			<div class="ui-corner-all custom-corners">
				<div class="ui-bar ui-bar-b">
					<h3>Applicant Information</h3>
				</div>
				<div class="ui-body ui-body-b" style="overflow-x:scroll">
					<imsp:fieldContain label="Application Number :">
						<div class="ui-field-contain custom-readonly" >
							<input type="text" id="type_scm" name="type_scm" value="${FormClassRows.f_application_number}" placeholder="Type..." readonly />
						</div>
					</imsp:fieldContain>
					<imsp:fieldContain label="Application Date :">
						<div class="ui-field-contain custom-readonly" >
							<input type="text" id="type_scm" name="type_scm" value="${FormClassRows.f_application_date}" placeholder="Type..." readonly />
						</div>
					</imsp:fieldContain>
					<imsp:fieldContain label="Applicant Number :">
						<div class="ui-field-contain custom-readonly" >
							<input type="text" id="f_applicant_number" name="f_applicant_number" value="${FormClassRows.f_applicant_number}" placeholder="Type..." readonly />
						</div>
					</imsp:fieldContain>
					<imsp:fieldContain label="Department Name :">
						<div class="ui-field-contain custom-readonly" >
							<input type="text" id="f_applicant_dept_name" name="f_applicant_dept_name" value="${FormClassRows.f_applicant_dept_name}" placeholder="Type..." readonly />
						</div>
					</imsp:fieldContain>
					<imsp:fieldContain label="Applicant Name :">
						<div class="ui-field-contain custom-readonly" >
							<input type="text" id="f_applicant_name" name="f_applicant_name" value="${FormClassRows.f_applicant_name}" placeholder="Type..." readonly />
						</div>
					</imsp:fieldContain>
					<imsp:fieldContain label="Position Name :">
						<div class="ui-field-contain custom-readonly" >
							<input type="text" id="f_applicant_pos_name" name="f_applicant_pos_name" value="${FormClassRows.f_applicant_pos_name}" placeholder="Type..." readonly />
						</div>
					</imsp:fieldContain>
				</div>
			</div>

			<div class="ui-corner-all custom-corners">
				<imsp:collapsible title="Agreement Detail" dataTheme="b" contentTheme="b">
				<div class="ui-body ui-body-b" style="overflow-x:scroll">
					<imsp:fieldContain label="Counter Party (vendor name, etc) :">
						<div class="ui-field-contain custom-readonly" >
							<input type="text" id="f_counter_party" name="f_counter_party" value="${FormClassRows.f_counter_party}" placeholder="Type..." readonly />
						</div>
					</imsp:fieldContain>
					<imsp:fieldContain label="Currency :">
						<div class="ui-field-contain custom-readonly" >
							<!--  <input type="text" id="f_currency" name="f_currency" value="${FormClassRows.f_currency}" placeholder="Type..." readonly />-->
								<label>${f:h(FormClassRows.f_currency) }</label>
						</div>
					</imsp:fieldContain>
					<imsp:fieldContain label="Total Amount :">
						<div class="ui-field-contain custom-readonly" >
								<label>${f:h(FormClassRows.f_total_amount_no_tax) }</label>
						</div>
					</imsp:fieldContain>
					<imsp:controlGroup label="要素のグルーピング">
						  <imsp:radioButton name="radios" label="ラジオ1" value="1" />
						  <imsp:radioButton name="radios" label="ラジオ2" value="2" />
						  <imsp:radioButton name="radios" label="ラジオ3" value="3" checked="<%=true%>" />
					</imsp:controlGroup>  
					<imsp:fieldContain label="Agreement Status :">
						<div class="ui-field-contain custom-readonly" >
						  		<input type="radio" id="one_time" name="f_agreement_status" value="1"
						  			${FormClassRows.f_agreement_status == 1 ? "checked" : "" }
						  			class="unclickable"
						  		/>
						  		<label for="one_time">One Time/New</label>
						  		<br>
						  		<input type="radio" id="extension" name="f_agreement_status" value="2" 
									  ${FormClassRows.f_agreement_status == "2_a" || FormClassRows.f_agreement_status == "2_b" ? "checked" : "" }
						  			class="unclickable"
						  		/>
						  		<label for="extension">Amendment/Extension/Renewal</label>
						  		<br>
						  		<div id="extension-childs" style="padding-left: 2em">
									  <p>Total Duration from first cooperation until now</p>
									  <input type="radio" id="gt_1" name="f_renewal" value="a"
									  ${agreementStatusRenewal == "a" ? "checked" : "" }
						  			class="unclickable"
									  />
									  <label for="gt_1">More than 1 year</label>
									  <input type="radio" id="lte_1" name="f_renewal" value="b"
									  ${agreementStatusRenewal == "b" ? "checked" : "" }
						  			class="unclickable"
									  />
									  <label for="lte_1">up to 1 year</label>
						  		</div>
						  		<input type="radio" id="umbrella" name="f_agreement_status" value="3"
						  			${FormClassRows.f_agreement_status == 3 ? "checked" : "" }
						  			class="unclickable"
						  		/>
						  		<label for="umbrella">Umbrella Agreement</label>
						</div>
					</imsp:fieldContain>
				</div>
				</imsp:collapsible>
			</div>
<!--
				  <header class="imui-chapter-title">
					<h2>Agreement Detail</h2>
				</header>

				<table id="agreement_detail" class="imui-form tab_header">
					<tbody>

						<tr>
						  <th><label class="imui-required">Total Amount (Without Tax)</label></th>
						  <td>
						  </td>
						</tr>

						<tr>
						  <th><label class="imui-required">Agreement Status</label></th>
						  <td>
						  		<input type="radio" id="one_time" name="f_agreement_status" value="1"
						  			${FormClassRows.f_agreement_status == 1 ? "checked" : "" }
						  			class="unclickable"
						  		/>
						  		<label for="one_time">One Time/New</label>
						  		<br>
						  		<input type="radio" id="extension" name="f_agreement_status" value="2" 
									  ${FormClassRows.f_agreement_status == "2_a" || FormClassRows.f_agreement_status == "2_b" ? "checked" : "" }
						  			class="unclickable"
						  		/>
						  		<label for="extension">Amendment/Extension/Renewal</label>
						  		<br>
						  		<div id="extension-childs" style="padding-left: 2em">
									  <p>Total Duration from first cooperation until now</p>
									  <input type="radio" id="gt_1" name="f_renewal" value="a"
									  ${agreementStatusRenewal == "a" ? "checked" : "" }
						  			class="unclickable"
									  />
									  <label for="gt_1">More than 1 year</label>
									  <input type="radio" id="lte_1" name="f_renewal" value="b"
									  ${agreementStatusRenewal == "b" ? "checked" : "" }
						  			class="unclickable"
									  />
									  <label for="lte_1">up to 1 year</label>
						  		</div>
						  		<input type="radio" id="umbrella" name="f_agreement_status" value="3"
						  			${FormClassRows.f_agreement_status == 3 ? "checked" : "" }
						  			class="unclickable"
						  		/>
						  		<label for="umbrella">Umbrella Agreement</label>
						  </td>
						</tr>

						<tr>
							<th><label class="imui-required">Include auto extension condition</label></th>
							<td>
						  		<input type="radio" id="auto_extension_y" name="f_auto_extension" value="1" 
						  			${FormClassRows.f_is_auto_extension == 1 ? "checked" : "" }
						  			class="unclickable"
						  		/>
						  		<label for="auto_extension_y">Yes</label>
						  		<br>
						  		<input type="radio" id="auto_extension_n" name="f_auto_extension" value="0"
						  			${FormClassRows.f_is_auto_extension == 0 ? "checked" : "" }
						  			class="unclickable"
						  		/>
						  		<label for="auto_extension_n">No</label>
							</td>
						</tr>

						<tr>
							<th><label class="imui-required">Purchase Order Required</label></th>
							<td>
						  		<input type="radio" id="purchase_order_req_y" name="f_purchase_order_req" value="1" 
						  			${FormClassRows.f_purchase_order_req == 1 ? "checked" : "" }
						  			class="unclickable"
						  		/>
						  		<label for="purchase_order_req_y">Yes</label>
						  		<br>
						  		<input type="radio" id="purchase_order_req_n" name="f_purchase_order_req" value="0"
						  			${FormClassRows.f_purchase_order_req == 0 ? "checked" : "" }
						  			class="unclickable"
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
						  			class="unclickable"
						  		/>
						  		<label for="related_parties_y">Related Parties [Shareholders (KY, MFTBC, MC, MCAH, Daimler), Subsidiary (i.e. KRM, MKM, BAS, BBD, BMC, etc.), Affiliates (i.e. DSF, BSI, MMKSI, MMKI, etc.)]</label>
						  		<br>
						  		<input type="radio" id="related_parties_n" name="f_related_company" value="0"
						  			${FormClassRows.f_is_related_comp == 0 ? "checked" : "" }
						  			class="unclickable"
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
						  			class="unclickable"
						  		 />
						  		<label for="tangible_asset">Tangible Asset</label>

						  		<input type="radio" id="intangible_asset" name="f_purchase_category" value="0"
						  			${FormClassRows.f_purchase_category == 0 ? "checked" : "" }
						  			class="unclickable"
						  		/>
						  		<label for="intangible_asset">Intangible Asset</label>

						  		<input type="radio" id="non_asset" name="f_purchase_category" value="9"
						  			${FormClassRows.f_purchase_category == 9 ? "checked" : "" }
						  			class="unclickable"
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
											class="unclickable"
											/>
											<label for="pd_approval">PD Approval (either one of condition below)</label>
												<div class="pd_approval_childrens" style="padding-left: 2em">
														<input type="radio" id="gte_1_billion" name="f_agreement_classification_1" value="1"
														${agreementClassificationChildren == 1 ? "checked" : ""}
														class="unclickable"
														/>
														<label for="gte_1_billion">Agreement with amount is equal or more than 1 billion</label>
														<br>
														<input type="radio" id="gte_12_months" name="f_agreement_classification_1" value="2"
														${agreementClassificationChildren == 2 ? "checked" : ""}
														class="unclickable"
														/>
														<label for="gte_12_months">Period is equal or more than 12 months</label>
														<br>
														<div>
															<input type="radio" id="related_parties" name="f_agreement_classification_1" value="3"
															${agreementClassificationChildren == 3 ? "checked" : ""}
															class="unclickable"
															/>
															<label for="related_parties">Agreement related to spesific party</label>
															<br>
															<p style="padding-left: 2em"><i>- Bank, Related Parties, Dealer, Consulatant/Lawyer/Appraiser (Vendor head-hunter, ISO Certification, HR system development, etc), Government, Production(Component and Parts), Customer, Etc</i></p>
														</div>

														<input type="radio" id="special_issue" name="f_agreement_classification_1" value="4"
															${agreementClassificationChildren == 4 ? "checked" : ""}
															class="unclickable"
														/>
														<label for="special_issue">Special issue</label>
														<br>
														<p style="padding-left: 2em"><i>New project/Issue (more than 50 M), Not included in Budget Plan</i></p>

														<input type="radio" id="direct_procurement" name="f_agreement_classification_1" value="5"
															${agreementClassificationChildren == 5 ? "checked" : ""}
															class="unclickable"
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
												class="unclickable"
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
												class="unclickable"
											/>	
											<label for="ec_approval_yes">Yes</label>
												<div class="ec_approval_yes_childrens" style="padding-left: 2em">
														<input type="radio" id="amount_gte_1_billion" name="f_ec_approval_yes" value="1" 
															${ecApprovalIsReqYesChildren == 1 ? "checked" : ""}
															class="unclickable"
														/>	
														<label for="amount_gte_1_billion">Amount is equal or more than 1 billion</label>
														<br>	
														<input type="radio" id="period_gt_12_month" name="f_ec_approval_yes" value="2"
															${ecApprovalIsReqYesChildren == 2 ? "checked" : ""}
															class="unclickable"
														/>	
														<label for="period_gt_12_month">Period is equal or more than 12 months</label>
														<br>	
														<input type="radio" id="escalate_issue" name="f_ec_approval_yes" value="3"
															${ecApprovalIsReqYesChildren == 3 ? "checked" : ""}
															class="unclickable"
														/>	
														<label for="escalate_issue">Director believes it is necessary to escalate the issue to EC</label>
												</div>
												<div>
														<input type="radio" id="ec_approval_no" name="f_ec_approval_is_required" value="0"
															${ecApprovalIsReq == 0 ? "checked" : ""}
															class="unclickable"
														/>	
														<label for="ec_approval_no">No</label>
												</div>
									</td>
							</tr>
						</tbody>
					</table>
					
					<div id="container-multi-user-input">
					  ${param.content}
					</div>
					
					-->
					
					
					

					
						
					


			
	</workflowSmartphone:spWorkflowOpenPage>
				
				<div class="ui-body ui-body-b" style="overflow-x:scroll">
					  <header class="imui-chapter-title">
						<h2>To see the uploaded document</h2>
					</header>

						<table id="uploaded_document" class="imui-form tab_header">
							<tbody>
									<c:forEach items="${FormClassRows.d_file_attachment}" var="row">
										<tr><td><a target="_blank" href="agreement/download/${row.file_real_name}?token=${f:h(FormClassRows.f_download_token_request)}">${row.file_name}</a></td></tr>
										<!-- 
										<tr><td>
											<imsp:download style="form" method="POST" path="${f:h(row.file_path)}" fileName="${f:h(row.file_name)}">
											  <input type="submit" value="${f:h(row.file_name) }" data-icon="arrow-d" />
											</imsp:download>
										</td></tr>
										-->
									</c:forEach>
							</tbody>
						</table>
					</div>

		<fieldset>
			<button type="button" value='Process' id="openPage" name="openPage" data-theme="b">Process</button>
		</fieldset>

	<!-- End Footer -->
	<form name="backForm" id="backForm" method="POST" action='${f:h(ApplyForm.imwCallOriginalPagePath)}' data-ajax="false">
		<input type="hidden" name=imwCallOriginalParams value='${f:h(ApplyForm.imwCallOriginalParams)}' />
	</form>
</div>


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
    		
    		
    		$("input[type='radio'].unclickable").click((event) => event.preventDefault());
    		$("input[type='text'].unclickable").css({display: "none"})
    		$("textarea.unclickable").css({display: "none"})
    	})
	</script>

	<script type="text/javascript">
				//var valid = imuiValidate("#workflowOpenPageForm", rules, messages);

		
		function workflowValidate(rules, messages) {
				$('.error_message').empty();
				
				$('.unclickable').each((idx, element) => {
					rules[$(element).attr('name')] = {id: false}
				})
				
				

				var validator = $('#workflowOpenPageForm').validate({
					rules: rules,
					messages: messages,
					//groups: groups,
					errorPlacement: function(error, element) {
						var $element = $(element);
						var error_message = error.get(0);
						if($element.attr('id') == 'upload_file'){
							$('#section-upload').find('.error_message').html(error_message);
						} else if($element.hasClass("section_cco")){
							$element.parents("table").find(".error_message").html(error_message);
						} else if($element.attr("type") == 'checkbox' || $element.attr("type") == 'radio'){
							$element.parent().find(".error_message").html(error_message);
						}else{
							$element.parents('td').find('.error_message').html(error_message);
						}
					},
					highlight: function(element, errorClass, validClass) {
						var $element = $(element);
						
						if($element.attr("type") == 'checkbox' || $element.attr("type") == 'radio'){
							$('input[name="'+$element.attr("name")+'"]').addClass("imui-validation-error");
						}else{
							$element.addClass('imui-validation-error');
						}
					},
					unhighlight: function(element, errorClass, validClass) {
						var $element = $(element);
						
						if($element.attr("type") == 'checkbox' || $element.attr("type") == 'radio'){
							$('input[name="'+$element.attr("name")+'"]').removeClass("imui-validation-error");
						}else{
							$element.removeClass('imui-validation-error');
							
						}
					}
				})

				var message_validDate = "有効な日付を入力してください。(yyyy/MM/dd)";
				var message_ensureUploadedFileExist = "file is required!";
				
				
				$.validator.messages.validDate = message_validDate;
				$.validator.messages.ensureUploadedFileExist = message_ensureUploadedFileExist;
				

				
				$.validator.addMethod("validDate", function(value, element) {
					if(this.optional(element)){
						return true;
					}
					
					var splitted = value.split("/");
					var year = parseInt(splitted[0], 10);
					var month = parseInt(splitted[1], 10) - 1;
					var day = parseInt(splitted[2], 10);
					
					var date = new Date(year, month, day);

					return date.getFullYear() === year && date.getMonth() === month && date.getDate() === day
				});

				console.log(validator)
				
				return validator.form();
			
		}

		$(function(){
			$('.back').click(function(){
				$('#backForm').submit();
				return false;
			});

			$('#openPage').click(function(){
				console.log("LKFDJSLJ")

				if(workflowValidate(rules, messages)){
                    workflowOpenPage4Sp('${f:h(ApplyForm.imwPageType)}');
					return false;
                } else {
                    //imuiShowErrorMessage('インプットのエラーが発生しまいした。.', [], true, 2500, false);
                    
                    
				}
			})
		})


	</script>