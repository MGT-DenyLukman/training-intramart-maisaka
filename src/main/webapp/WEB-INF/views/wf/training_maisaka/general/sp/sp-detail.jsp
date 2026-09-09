
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
<%@ taglib prefix="imsp" uri="http://www.intra-mart.co.jp/taglib/imsp"%>
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

    	table.imui-form#estimated_schedule tr:not(:first-child) th:first-child,
    	table.imui-form#estimated_schedule tr:not(:first-child) td:first-child{
    		width: 150px;
    		text-align: center;
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
								<label>${f:h(FormClassRows.f_counter_party) }</label>
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
					<imsp:fieldContain label="Agreement Status :">
						<div class="ui-field-contain custom-readonly" >
						  		<input type="radio" id="one_time" name="f_agreement_status" value="1"
						  			data-role="none"
						  			${FormClassRows.f_agreement_status == 1 ? "checked" : "" }
						  			class="unclickable"
						  		/>
						  		<label for="one_time">One Time/New</label>
						  		<br>
						  		<input type="radio" id="extension" name="f_agreement_status" value="2" 
						  			data-role="none"
									  ${FormClassRows.f_agreement_status == "2_a" || FormClassRows.f_agreement_status == "2_b" ? "checked" : "" }
						  			class="unclickable"
						  		/>
						  		<label for="extension">Amendment/Extension/Renewal</label>
						  		<br>
						  		<div id="extension-childs" style="padding-left: 2em">
									  <p>Total Duration from first cooperation until now</p>
									  <input type="radio" id="gt_1" name="f_renewal" value="a"
						  			data-role="none"
									  ${agreementStatusRenewal == "a" ? "checked" : "" }
						  			class="unclickable"
									  />
									  <label for="gt_1">More than 1 year</label>
									  <input type="radio" id="lte_1" name="f_renewal" value="b"
						  			data-role="none"
									  ${agreementStatusRenewal == "b" ? "checked" : "" }
						  			class="unclickable"
									  />
									  <label for="lte_1">up to 1 year</label>
						  		</div>
						  		<input type="radio" id="umbrella" name="f_agreement_status" value="3"
						  			data-role="none"
						  			${FormClassRows.f_agreement_status == 3 ? "checked" : "" }
						  			class="unclickable"
						  		/>
						  		<label for="umbrella">Umbrella Agreement</label>
						</div>
					</imsp:fieldContain>
					<imsp:fieldContain label="Include auto extension condition :">
						<div class="ui-field-contain custom-readonly" >
						  		<input type="radio" id="auto_extension_y" name="f_auto_extension" value="1" 
						  			data-role="none"
						  			${FormClassRows.f_is_auto_extension == 1 ? "checked" : "" }
						  			class="unclickable"
						  		/>
						  		<label for="auto_extension_y">Yes</label>
						  		<input type="radio" id="auto_extension_n" name="f_auto_extension" value="0"
						  			data-role="none"
						  			${FormClassRows.f_is_auto_extension == 0 ? "checked" : "" }
						  			class="unclickable"
						  		/>
						  		<label for="auto_extension_n">No</label>
						  	</div>
					</imsp:fieldContain>
					<imsp:fieldContain label="Purchase Order Required : ">
						<div class="ui-field-contain custom-readonly" >
						  		<input type="radio" id="purchase_order_req_y" name="f_purchase_order_req" value="1" 
						  			data-role="none"
						  			${FormClassRows.f_purchase_order_req == 1 ? "checked" : "" }
						  			class="unclickable"
						  		/>
						  		<label for="purchase_order_req_y">Yes</label>
						  		<input type="radio" id="purchase_order_req_n" name="f_purchase_order_req" value="0"
						  			data-role="none"
						  			${FormClassRows.f_purchase_order_req == 0 ? "checked" : "" }
						  			class="unclickable"
						  		/>
						  		<label for="purchase_order_req_n">No</label>
						  	</div>
					</imsp:fieldContain>
					<imsp:fieldContain label="Title described in Agreement :">
						<div class="ui-field-contain custom-readonly" >
								<label>${f:h(FormClassRows.f_title_in_agreement) }</label>
						</div>
					</imsp:fieldContain>
					<imsp:fieldContain label="Effective Date From:">
						<div class="ui-field-contain custom-readonly" >
							  <label>${f:h(FormClassRows.f_effective_date_from) }</label>
						</div>
					</imsp:fieldContain>
					<imsp:fieldContain label="Effective Date To :">
						<div class="ui-field-contain custom-readonly" >
							  <label>${f:h(FormClassRows.f_effective_date_to) }</label>
						</div>
					</imsp:fieldContain>
					<imsp:fieldContain label="Related / Non Related Company :">
						<div class="ui-field-contain custom-readonly" >
						  		<input type="radio" id="related_parties_y" name="f_related_company" value="1"
						  			data-role="none"
						  			${FormClassRows.f_is_related_comp == 1 ? "checked" : "" }
						  			class="unclickable"
						  		/>
						  		<label for="related_parties_y">Related Parties [Shareholders (KY, MFTBC, MC, MCAH, Daimler), Subsidiary (i.e. KRM, MKM, BAS, BBD, BMC, etc.), Affiliates (i.e. DSF, BSI, MMKSI, MMKI, etc.)]</label>
						  		<br>
						  		<input type="radio" id="related_parties_n" name="f_related_company" value="0"
						  			data-role="none"
						  			${FormClassRows.f_is_related_comp == 0 ? "checked" : "" }
						  			class="unclickable"
						  		/>
						  		<label for="related_parties_n">Non Related Parties</label>
						  		<br>
						  		<p class="bg-warning"><i>Consult with Legal. SHR may be required</i></p>
						</div>
					</imsp:fieldContain>
					<imsp:fieldContain label="Estimated Delivery Schedule From:">
						<div class="ui-field-contain custom-readonly" >
							  <label>${f:h(FormClassRows.f_delivery_date_from) }</label>
						</div>
					</imsp:fieldContain>
					<imsp:fieldContain label="Estimated Delivery Schedule To:">
						<div class="ui-field-contain custom-readonly" >
							  <label>${f:h(FormClassRows.f_delivery_date_to) }</label>
						</div>
					</imsp:fieldContain>
					<imsp:fieldContain label="Agreement Summary (main points only) (In case of contract in foreign currency need to describe exchange rate) :">
						<div class="ui-field-contain custom-readonly" >
							<label>${f:h(FormClassRows.f_agreement_summary) }</label>
					  </div>
					</imsp:fieldContain>
				</div>
				</imsp:collapsible>
				
				<imsp:collapsible title="Depreciation Check" dataTheme="b" contentTheme="b">
					<imsp:fieldContain label="Purchase Category :">
						<div class="ui-field-contain custom-readonly" >
						  		<input type="radio" id="tangible_asset" name="f_purchase_category" value="1"
						  		 data-role="none"
						  			${FormClassRows.f_purchase_category == 1 ? "checked" : "" }
						  			class="unclickable"
						  		 />
						  		<label for="tangible_asset">Tangible Asset</label>

						  		<input type="radio" id="intangible_asset" name="f_purchase_category" value="0"
						  		 data-role="none"
						  			${FormClassRows.f_purchase_category == 0 ? "checked" : "" }
						  			class="unclickable"
						  		/>
						  		<label for="intangible_asset">Intangible Asset</label>

						  		<input type="radio" id="non_asset" name="f_purchase_category" value="9"
						  		 data-role="none"
						  			${FormClassRows.f_purchase_category == 9 ? "checked" : "" }
						  			class="unclickable"
						  		/>
						  		<label for="non_asset">Non-Asset</label>
						  </div>
						 </imsp:fieldContain>
						<imsp:fieldContain label="Starting Usage Date (Required if Asset) :" class="depreciation_required_asset">
								<label>${f:h(FormClassRows.f_starting_usage_date) }</label>
						</imsp:fieldContain>
						<imsp:fieldContain label="Deprec Amount/Month (Required if Asset) :" class="depreciation_required_asset">
								<label>${f:h(FormClassRows.f_deprec_amount_per_month) }</label>
						</imsp:fieldContain>
				</imsp:collapsible>
				<imsp:collapsible title="Estimated Schedule (Payment Conditions)" dataTheme="b" contentTheme="b">
					<table id="estimated_schedule" class="imui-form tab_header">
						<tbody>
							<tr class="ui-body-b">
								<th colspan="2"><label class="imui-required ">Payment (Total Cash flow Impact)</label></th>
							</tr>
							<tr>
									<th class="ui-body-b"><label class="imui-required">Amount</label></th>
									<th class="ui-body-b"><label class="imui-required">Date</label></th>
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
									<th class="ui-body-b"><label class="imui-required">Total Amount</label></th>
							</tr>
							<tr>
									<td>
											<label>${f:h(esTotalAmount) }</label>
									</td>
							</tr>
						</tbody>
					</table>
				</imsp:collapsible>

				<imsp:collapsible title="Agreement Classification" dataTheme="b" contentTheme="b">
					<imsp:fieldContain label="Agreement Classification">
									<div>
											<input type="radio" id="pd_approval" name="f_agreement_classification" value="1" 
											data-role="none"
											${agreementClassification == 1 ? "checked" : ""}
											class="unclickable"
											/>
											<label for="pd_approval">PD Approval (either one of condition below)</label>
												<div class="pd_approval_childrens" style="padding-left: 2em">
														<input type="radio" id="gte_1_billion" name="f_agreement_classification_1" value="1"
														data-role="none"
														${agreementClassificationChildren == 1 ? "checked" : ""}
														class="unclickable"
														/>
														<label for="gte_1_billion">Agreement with amount is equal or more than 1 billion</label>
														<br>
														<input type="radio" id="gte_12_months" name="f_agreement_classification_1" value="2"
														data-role="none"
														${agreementClassificationChildren == 2 ? "checked" : ""}
														class="unclickable"
														/>
														<label for="gte_12_months">Period is equal or more than 12 months</label>
														<br>
														<div>
															<input type="radio" id="related_parties" name="f_agreement_classification_1" value="3"
															data-role="none"
															${agreementClassificationChildren == 3 ? "checked" : ""}
															class="unclickable"
															/>
															<label for="related_parties">Agreement related to spesific party</label>
															<br>
															<p style="padding-left: 2em"><i>- Bank, Related Parties, Dealer, Consulatant/Lawyer/Appraiser (Vendor head-hunter, ISO Certification, HR system development, etc), Government, Production(Component and Parts), Customer, Etc</i></p>
														</div>

														<input type="radio" id="special_issue" name="f_agreement_classification_1" value="4"
															data-role="none"
															${agreementClassificationChildren == 4 ? "checked" : ""}
															class="unclickable"
														/>
														<label for="special_issue">Special issue</label>
														<br>
														<p style="padding-left: 2em"><i>New project/Issue (more than 50 M), Not included in Budget Plan</i></p>

														<input type="radio" id="direct_procurement" name="f_agreement_classification_1" value="5"
															data-role="none"
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
												data-role="none"
												${agreementClassification == 2 ? "checked" : ""}
												class="unclickable"
												/>
												<label for="dic_approval">DIC Director Approval</label>
											</div>
										</div>
					</imsp:fieldContain>
					<imsp:fieldContain label="EC Approval is Required or Not">
									<div>
											<input type="radio" id="ec_approval_yes" name="f_ec_approval_is_required" value="1"
												data-role="none"
												${ecApprovalIsReq == 1 ? "checked" : ""}
												class="unclickable"
											/>	
											<label for="ec_approval_yes">Yes</label>
												<div class="ec_approval_yes_childrens" style="padding-left: 2em">
														<input type="radio" id="amount_gte_1_billion" name="f_ec_approval_yes" value="1" 
															data-role="none"
															${ecApprovalIsReqYesChildren == 1 ? "checked" : ""}
															class="unclickable"
														/>	
														<label for="amount_gte_1_billion">Amount is equal or more than 1 billion</label>
														<br>	
														<input type="radio" id="period_gt_12_month" name="f_ec_approval_yes" value="2"
															data-role="none"
															${ecApprovalIsReqYesChildren == 2 ? "checked" : ""}
															class="unclickable"
														/>	
														<label for="period_gt_12_month">Period is equal or more than 12 months</label>
														<br>	
														<input type="radio" id="escalate_issue" name="f_ec_approval_yes" value="3"
															data-role="none"
															${ecApprovalIsReqYesChildren == 3 ? "checked" : ""}
															class="unclickable"
														/>	
														<label for="escalate_issue">Director believes it is necessary to escalate the issue to EC</label>
												</div>
												<div>
														<input type="radio" id="ec_approval_no" name="f_ec_approval_is_required" value="0"
															data-role="none"
															${ecApprovalIsReq == 0 ? "checked" : ""}
															class="unclickable"
														/>	
														<label for="ec_approval_no">No</label>
												</div>
									</div>
					</imsp:fieldContain>
				</imsp:collapsible>
				


				<c:if test="${FormClassRows.f_purchase_order_req == 1}">
					<c:import url="./section-user/sp-approver-uhdh.jsp"></c:import>
				</c:if>
				<c:import url="./section-user/sp-approver-cco.jsp"></c:import>
				<c:import url="./section-user/sp-approver-legal.jsp"></c:import>

				
			</div>
					
					


			
</workflow:workflowOpenPage>
				
					 <div class="imui-form-container-full">
						  <header class="imui-chapter-title">
							<h2>To see the uploaded document</h2>
						</header>

						<table id="uploaded_document" class="imui-form tab_header">
							<tbody>
									<c:forEach items="${FormClassRows.d_file_attachment}" var="row">
										<tr><td><a target="_blank" href="agreement/download/${row.file_real_name}?token=${FormClassRows.f_download_token_request}">${row.file_name}</a></td></tr>
									</c:forEach>
							</tbody>
						</table>
				</div>

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
    				url: "agreement/generatepdf",
    				data: {
    					system_matter_id: '${f:h(ApplyForm.imwSystemMatterId)}',
    					token: '${f:h(FormClassRows.f_download_token_request)}',
    				},
    				success: function(response) {
    					console.log("success response: ", response);
    					window.location.href = "/imartlast/agreement/downloadpdf/${f:h(ApplyForm.imwSystemMatterId)}?token=${f:h(FormClassRows.f_download_token_request)}";
    				},
    				error: function(xhr, status, e) {
    					console.log("AJAX ERROR : ", e);
    				}
    			})
    		})
    	})
	</script>

    <script src="ui/js/script-prevent-default-radio.js" type="text/javascript"></script>