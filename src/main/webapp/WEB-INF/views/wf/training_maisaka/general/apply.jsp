
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

<%@ page import="java.util.List"%>
<%@ page import="java.util.ArrayList"%>
<%@ page import="java.util.Map"%>
<%@ page import="java.util.HashMap"%>


<imui:head>
	<title>Training Workflow Maisaka</title>
	<workflow:workflowOpenPageCsjs />
	
	<link href="ui/css/select2.min.css" rel="stylesheet" />
    <script src="ui/js/select2.min.js" type="text/javascript"></script>
    <script src="ui/js/jquery.validate.js" type="text/javascript"></script>
    
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
    		display: none;
    		width: 80%;
    		height: 80px;
    	}
    	
    	
    	
    	.bg-warning {
    		background: yellow;
    		width: fit-content;
    	}
    </style>
    
    
    <script type="text/javascript">
		function formatNumberInput($input, maxDecimal) {
			console.log("running")
			  // 入力時にカンマ自動付与
			  $input.on("input", function() {
				var val = $(this).val();
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
				if (val !== formatted) $(this).val(formatted);
			  });
			// キー入力時に数字・制御キー以外をブロック
			  $input.on("keydown", function(e) {
			    var allowed = [8, 9, 13, 27, 37, 38, 39, 40, 46];    // Backspace/Tab/Enter/矢印/Delete
			    if (allowed.indexOf(e.which) !== -1) return;
			    if (e.ctrlKey || e.metaKey) return;                  // Ctrl系ショートカット許可
			    if ((e.which >= 48 && e.which <= 57) || (e.which >= 96 && e.which <= 105)) return; // 数字
			    if (e.which === 190 && $(this).val().indexOf(".") === -1) return;  // 初回.のみ許可
			    e.preventDefault();
			  });
		}
		
		$(function() {
			formatNumberInput($('input[name="f_total_amount"]'), 2);
			formatNumberInput($('input[name="f_deprec_amount_per_month"]'), 2);
		})
    </script>

	<script type="text/javascript">
		//function for attachment
		function callbackSuccess(e, data) {
			var file = data.files[0];
			var fileName = file.name;
			var fileSize = file.size;
			var fileType = file.type;

			//受信した情報
			var receiveFile = data.result[0];
			var receiveFileName = receiveFile.name;
			var receivePhysicalFileName = receiveFile.physicalName;
			var receiveFileSize = receiveFile.size;

			var fileExtension = receiveFileName.split('.').pop().toLowerCase();
			
			$(".file_attachment").prepend("<div class='" + receivePhysicalFileName + "'>"
				+ "<input type='hidden' id='f_upload_file_id' name='f_upload_file_id'>"
				+ "<input type='hidden' value='" + receiveFileName + "' id='f_upload_file_name' name='f_upload_file_name'>"
				+ "<input type='hidden' value='" + receivePhysicalFileName + "' id='f_upload_file_real_name' name='f_upload_file_real_name'>"
				+ "<input type='hidden' value='" + fileExtension + "' id='f_upload_file_type' name='f_upload_file_type'>"
				+ "</div>");
		}
		function callbackRemove(e, data) {
			var file = data.response[0];
			var fileName = file.name;
			$("." + fileName).remove();
		}
		function callbackError(e, data) {
			var file = data.files[0];
			var fileName = file.name;
			var fileSize = file.size;
			var fileType = file.type;
			
		}
	</script>

	<script type="text/javascript">
		$(function(){
			$('input[name="f_agreement_status"]').change(function(){
				if($(this).val() == 2){
					$("#extension-childs").show();
				}else{
					$("#extension-childs").hide();
				}
			})
			
			
			$("table#agreement_detail tr:not(.doublerow) th").attr({
				"colspan": 2,
			})

			$('input[name="f_purchase_category"]').change(function(){
				if($(this).val() != 9){
					$(".depreciation_required_asset").show();
				}else{
					$(".depreciation_required_asset").hide();
				}
			})

			$('input[name="f_agreement_classification"]').change(function(){
				if($(this).val() != 2){
					$(".pd_approval_childrens").show();
				}else{
					$(".pd_approval_childrens").hide();
				}
			})

			$('input[name="f_ec_approval_is_required"]').change(function(){
				if($(this).val() != 0){
					$(".ec_approval_yes_childrens").show();
				}else{
					$(".ec_approval_yes_childrens").hide();
				}
			})

			$('input[name="f_psd_process"]').change(function(){
				if($(this).val() == "DIC"){
					$("#psd_dic_reason").show();
				}else{
					$("#psd_dic_reason").hide();
				}
			})
			
			
		})
	</script>

	
	<!-- 入力バリデーション設定 -->
	<script type="text/javascript">

		var rules = {
			f_vendor: { required: true },
			f_currency : {required : true}, 
			f_total_amount : {required : true}, 
			f_agreement_status : {required : true}, 
			f_renewal : {required: {
				depends: function() {return $('#extension').prop('checked')}
			}},
			f_auto_extension: {required: true},
			f_purchased_order_req: {required: true},
			f_title: {required: true},
			f_effective_from: {required: true},
			f_effective_to: {required: true},
			f_estimated_delivery_from: {required: true},
			f_estimated_delivery_to: {required: true},
			f_start_usage_date: {required: {
				depends: function() {return $('input[name="f_purchase_category"]').val() !=9}
			}},
			f_deprec_amount_per_month: {required: {
				depends: function() {return $('input[name="f_purchase_category"]').val() !=9}
			}}
		};
		
		var messages = {
			f_vendor: {required: "Vendor Nameを入力してください！" },
			f_currency: {required: "Currencyを入力してください！" },
			f_total_amount: {required: "Total Amountを入力してください！" },
			f_agreement_status: {required: "Agreement Statusを入力してください！" },
			f_renewal: {required: "Total Duration を選択してください！" },
			f_auto_etxension: {required: "Auto extensionを選択してください！" },
			f_purchased_order_req: {required: "Purchased Orderを選択してください！" },
			f_title: {required: "Titleを入力してください！" },
			f_effective_from: {required: "Effective Date Fromを入力してください！" },
			f_effective_to: {required: "Effective Date Toを入力してください！" },
			f_estimated_delivery_from: {required: "Estimated Delivery Fromを入力してください！" },
			f_estimated_delivery_to: {required: "Estimated Delivery Toを入力してください！" },
			f_start_usage_date: {required: "Starting Usage Dateを入力してください！" },
			f_deprec_amount_per_month: {required: "Deprec amount/monthを入力してください！" },
		};
		
		$(function(){
			$('#openPage').click(function(){
				console.log($('#openPage').val(), "clicked");
				var valid = imuiValidate("#workflowOpenPageForm", rules, messages);
				
				if(valid){
                    workflowOpenPage('${f:h(ApplyForm.imwPageType)}');
                } else {
                    imuiShowErrorMessage('インプットのエラーが発生しまいした。.', [], true, 2500, false);
				}
			})
		})


	</script>
    >
	

	
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
		imwNextScriptPath="${f:h(ApplyForm.imwCallOriginalPagePath)}">	
				  <header class="imui-chapter-title">
					<h2>Agreement Detail</h2>
				</header>

				<table id="agreement_detail" class="imui-form tab_header">
					<tbody>
						<tr>
						  <th><label class="imui-required">Counter Party (vendor name, etc)</label></th>
						  <td><input name="f_vendor" type="text" placeholder="..."></td>
						</tr>

						<tr>
						  <th><label class="imui-required">Currency</label></th>
						  <td>
						  	<select name="f_currency" disabled>
						  		<option value="IDR">IDR</option>
						  	</select>
						  </td>
						</tr>

						<tr>
						  <th><label class="imui-required">Total Amount (Without Tax)</label></th>
						  <td><input name="f_total_amount" type="text" placeholder="100,000,000.00"></td>
						</tr>

						<tr>
						  <th><label class="imui-required">Agreement Status</label></th>
						  <td>
						  		<input type="radio" id="one_time" name="f_agreement_status" value="1"/>
						  		<label for="one_time">One Time/New</label>
						  		<br>
						  		<input type="radio" id="extension" name="f_agreement_status" value="2" checked/>
						  		<label for="extension">Amendment/Extension/Renewal</label>
						  		<br>
						  		<div id="extension-childs" style="padding-left: 2em">
									  <p>Total Duration from first cooperation until now</p>
									  <input type="radio" id="gt_1" name="f_renewal" value="a" checked/>
									  <label for="gt_1">More than 1 year</label>
									  <input type="radio" id="lte_1" name="f_renewal" value="b"/>
									  <label for="lte_1">up to 1 year</label>
						  		</div>
						  		<input type="radio" id="umbrella" name="f_agreement_status" value="3"/>
						  		<label for="umbrella">Umbrella Agreement</label>
						  </td>
						</tr>

						<tr>
							<th><label class="imui-required">Include auto extension condition</label></th>
							<td>
						  		<input type="radio" id="auto_extension_y" name="f_auto_extension" value="1" checked/>
						  		<label for="auto_extension_y">Yes</label>
						  		<br>
						  		<input type="radio" id="auto_extension_n" name="f_auto_extension" value="0"/>
						  		<label for="auto_extension_n">No</label>
							</td>
						</tr>

						<tr>
							<th><label class="imui-required">Purchase Order Required</label></th>
							<td>
						  		<input type="radio" id="purchase_order_req_y" name="f_purchase_order_req" value="1" checked/>
						  		<label for="purchase_order_req_y">Yes</label>
						  		<br>
						  		<input type="radio" id="purchase_order_req_n" name="f_purchase_order_req" value="0"/>
						  		<label for="purchase_order_req_n">No</label>
							</td>
						</tr>

						<tr>
						  <th><label class="imui-required">Title described in Agreement</label></th>
						  <td><input name="f_title" type="text" placeholder="..."></td>
						</tr>

						<tr class="doublerow">
						  <th rowspan="2"><label class="imui-required">Effective Date</label></th>
						  <th><label class="imui-required">From</label></th>
						  <td>
						  <input id="f_effective_from" name="f_effective_from" type="text"">
							<im:calendar floatable="true" altField="#f_effective_from" />
						  </td>
						</tr>
						<tr class="doublerow">
						  <th><label class="imui-required">To</label></th>
						  <td>
							  <input id="f_effective_to"  name="f_effective_to" type="text"">
							<im:calendar floatable="true" altField="#f_effective_to" />
						  </td>
						</tr>

						<tr>
							<th><label class="imui-required">Related / Non Related Company</label></th>
							<td>
						  		<input type="radio" id="related_parties_y" name="f_related_company" value="1" checked/>
						  		<label for="related_parties_y">Related Parties [Shareholders (KY, MFTBC, MC, MCAH, Daimler), Subsidiary (i.e. KRM, MKM, BAS, BBD, BMC, etc.), Affiliates (i.e. DSF, BSI, MMKSI, MMKI, etc.)]</label>
						  		<br>
						  		<input type="radio" id="related_parties_n" name="f_related_company" value="0"/>
						  		<label for="related_parties_n">Non Related Parties</label>
						  		<br>
						  		<p class="bg-warning"><i>Consult with Legal. SHR may be required</i></p>
							</td>
						</tr>

						<tr class="doublerow">
						  <th rowspan="2"><label class="imui-required">Estimated Delivery Schedule</label></th>
						  <th><label class="imui-required">From</label></th>
						  <td>
						  <input id="f_estimated_delivery_from"  name="f_estimated_delivery_from" type="text">
							<im:calendar floatable="true" altField="#f_estimated_delivery_from" />
						  </td>
						</tr>
						<tr class="doublerow">
						  <th><label class="imui-required">To</label></th>
						  <td>
								  <input id="f_estimated_delivery_to"  name="f_estimated_delivery_to" type="text">
								<im:calendar floatable="true" altField="#f_estimated_delivery_to" />
						  </td>
						</tr>
						
						<tr>
						  <th><label>Agreement Summary (main points only) (In case of contract in foreign currency need to describe exchange rate)</label></th>
						  <td><textarea id="agreement_summary" name="f_agreement_summary"></textarea></td>
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
						  		<input type="radio" id="tangible_asset" name="f_purchase_category" value="1" checked/>
						  		<label for="tangible_asset">Tangible Asset</label>

						  		<input type="radio" id="intangible_asset" name="f_purchase_category" value="0"/>
						  		<label for="intangible_asset">Intangible Asset</label>

						  		<input type="radio" id="non_asset" name="f_purchase_category" value="9"/>
						  		<label for="non_asset">Non-Asset</label>
						  </td>
						</tr>
						<tr class="depreciation_required_asset">
						  <th><label class="imui-required">Starting Usage Date (Required if Asset)</label></th>
						  <td>
								  <input id="f_start_usage_date"  name="f_start_usage_date" type="text">
								<im:calendar floatable="true" altField="#f_start_usage_date" />
						  </td>
						</tr>
						<tr class="depreciation_required_asset">
						  <th><label class="imui-required">Deprec Amount/Month (Required if Asset)</label></th>
						  <td><input name="f_deprec_amount_per_month" type="text" placeholder="..."></td>
						</tr>
					</tbody>
					</table>

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
							<tr>
									<td><input type="text" name="f_es_amount"/></td>
									<td>
										<input type="text" name="f_es_date"  id="f_es_date"/>
									<im:calendar floatable="true" altField="#f_es_date" />
									</td>
							</tr>
							<tr>
									<th><label class="imui-required">Total Amount</label></th>
							</tr>
							<tr>
									<td><input type="number"  name="f_es_total_amount"/></td>
							</tr>
						</tbody>
					</table>
					
					<!-- START COMMENTED -->
					<!-- 
					  <header class="imui-chapter-title">
						<h2>Agreement Classification</h2>
					</header>

					<table id="agreement_classification" class="imui-form tab_header">
						<tbody>
							<tr>
									<th><label class="imui-required">Agreement Classification</label></th>
									<td>
											<input type="radio" id="pd_approval" name="f_agreement_classification" value="1" checked/>
											<label for="pd_approval">PD Approval (either one of condition below)</label>
												<div class="pd_approval_childrens" style="padding-left: 2em">
														<input type="radio" id="gte_1_billion" name="f_agreement_classification_1" value="1" checked/>
														<label for="gte_1_billion">Agreement with amount is equal or more than 1 billion</label>
														<br>
														<input type="radio" id="gte_12_months" name="f_agreement_classification_1" value="2"/>
														<label for="gte_12_months">Period is equal or more than 12 months</label>
														<br>
														<div>
															<input type="radio" id="related_parties" name="f_agreement_classification_1" value="3"/>
															<label for="related_parties">Agreement related to spesific party</label>
															<br>
															<p style="padding-left: 2em"><i>- Bank, Related Parties, Dealer, Consulatant/Lawyer/Appraiser (Vendor head-hunter, ISO Certification, HR system development, etc), Government, Production(Component and Parts), Customer, Etc</i></p>
														</div>

														<input type="radio" id="special_issue" name="f_agreement_classification_1" value="4"/>
														<label for="special_issue">Special issue</label>
														<br>
														<p style="padding-left: 2em"><i>New project/Issue (more than 50 M), Not included in Budget Plan</i></p>

														<input type="radio" id="direct_procurement" name="f_agreement_classification_1" value="5"/>
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
												<input type="radio" id="dic_approval" name="f_agreement_classification" value="2"/>
												<label for="dic_approval">DIC Director Approval</label>
											</div>
									</td>
							</tr>
							<tr>
									<th><label class="imui-required">EC Approval is Required or Not</label></th>
									<td>
											<input type="radio" id="ec_approval_yes" name="f_ec_approval_is_required" value="1" checked/>	
											<label for="ec_approval_yes">Yes</label>
												<div class="ec_approval_yes_childrens" style="padding-left: 2em">
														<input type="radio" id="amount_gte_1_billion" name="f_ec_approval_yes" value="1" checked/>	
														<label for="amount_gte_1_billion">Amount is equal or more than 1 billion</label>
														<br>	
														<input type="radio" id="period_gt_12_month" name="f_ec_approval_yes" value="2"/>	
														<label for="period_gt_12_month">Period is equal or more than 12 months</label>
														<br>	
														<input type="radio" id="escalate_issue" name="f_ec_approval_yes" value="3"/>	
														<label for="escalate_issue">Director believes it is necessary to escalate the issue to EC</label>
												</div>
												<div>
														<input type="radio" id="ec_approval_no" name="f_ec_approval_is_required" value="0"/>	
														<label for="ec_approval_no">No</label>
												</div>
									</td>
							</tr>
						</tbody>
					</table>

					
					  <header class="imui-chapter-title">
						<h2>PSD Check (by UH or DH, PSD)</h2>
					</header>

					<table id="psd_check" class="imui-form tab_header">
						<tbody>
								<tr>
										<th><label class="imui-required">PSD Area or Non-PSD Area (Based on Guideline)</label></th>
										<td>
												<input type="radio" id="psd" name="f_psd_area_bog" value="1" checked/>	
												<label for="psd">PSD (go to #2)</label>
												<br>
												<input type="radio" id="psd_end" name="f_psd_area_bog" value="0"/>	
												<label for="psd_end">Non-PSD (End)</label>
										</td>
								</tr>
								<tr>
										<th><label class="imui-required">In PSD Area, PSD Process or DIC Process</label></th>
										<td>
												<input type="radio" id="psd_2" name="f_psd_process" value="PSD" checked/>	
												<label for="psd_2">PSD (Pitching result attached)</label>
												<br>
												<input type="radio" id="psd_dic" name="f_psd_process" value="DIC"/>	
												<label for="psd_dic">DIC (Please describe the reason in the below)</label>
												<textarea id="psd_dic_reason" name="f_dic_reason"></textarea>
										</td>
								</tr>
						</tbody>
					</table>

					  <header class="imui-chapter-title">
						<h2>Compliance Check By CCO</h2>
					</header>

					<table id="compliance_check" class="imui-form tab_header">
						<tbody>
								<tr>
										<th><label class="imui-required">D / D Process Required</label></th>
										<td>
												<input type="radio" id="dd_process_yes" name="f_dd_process" value="1" checked/>	
												<label for="dd_process_yes">Yes</label>
												<input type="radio" id="dd_process_no" name="f_dd_process" value="0" />	
												<label for="dd_process_no">No</label>
										</td>
								</tr>
								<tr>
										<th><label class="imui-required">Anti Bribery Clause Include</label></th>
										<td>
												<input type="radio" id="anti_bribery_yes" name="f_anti_bribery" value="1" />	
												<label for="anti_bribery_yes">Yes</label>
												<input type="radio" id="anti_bribery_no" name="f_anti_bribery" value="0"  checked/>	
												<label for="anti_bribery_no">No</label>
										</td>
								</tr>
								<tr>
										<th><label class="imui-required">Audit Right Included</label></th>
										<td>
												<input type="radio" id="audit_right_yes" name="f_audit_right" value="1"/>	
												<label for="audit_right_yes">Yes</label>
												<input type="radio" id="audit_right_no" name="f_audit_right" value="0" checked />	
												<label for="audit_right_no">No</label>
										</td>
								</tr>
						</tbody>
					</table>
					
					
					 <div class="imui-form-container-full">
					  <header class="imui-chapter-title">
						<h2>Filled By Legal</h2>
					</header>

					<table id="filled_by_legal" class="imui-form tab_header">
						<tbody>
								<tr>
										<th><label class="imui-required">Agreement Number</label></th>
										<td><input type="text" name="f_agreement_number"/></td>
								</tr>
								<tr>
										<th><label class="imui-required">Agreement Date</label></th>
										<td>
												<input type="text" id="agreement_date"  name="f_agreement_date"/>
												<im:calendar floatable="true" altField="#agreement_date" />
										</td>
								</tr>
						</tbody>
					</table>
					</div>
					
					

					
						<div class="file_attachment">
							<c:forEach items="${FormClassRows.d_list_attachment}" var="attachment">
								<div class="${attachment.file_real_name}">
									<input
											type='hidden'
											value='${attachment.id}'
											id='f_upload_file_id'
											name='f_upload_file_id'
									>
									<input
											type='hidden'
											value="${attachment.file_name}"
											id='f_upload_file_name'
											name='f_upload_file_name'
									>
									<input
											type='hidden'
											value="${attachment.file_real_name}"
											id='f_upload_file_real_name'
											name='f_upload_file_real_name'
									>
									<input
											type='hidden'
											value="${attachment.file_type}" 
											id="f_upload_file_type"
											name="f_upload_file_type"
									>
								</div>
							</c:forEach>
						</div>	
						
					-->
					<!-- END COMMENTED -->
					


			
</workflow:workflowOpenPage>
				
					 <div class="imui-form-container-full">
						  <header class="imui-chapter-title">
							<h2>Upload Document by DIC : Agreement, DD, etc</h2>
						</header>

						<table class="imui-form">
							<tbody>
									<tr>
											<th><label class="imui-required">Upload File</label></th>
										<td>
											<imui:fileUpload
													enableDelete="true"
													uniqueFileName="true"
													storeTo="file_attachment/"
													onSuccess="callbackSuccess"
													onError="callbackError"
													onRemove="callbackRemove"
											/>
										</td>
									</tr>
							</tbody>
						</table>
					</div>
					  <header class="imui-chapter-title">
						<h2>To see the uploaded document</h2>
					</header>

					<table id="uploaded_document" class="imui-form tab_header">
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
	<imart:decision case="0" value="${f:h(ApplyForm.imwPageType)}">	
		<input type="button" value='Apply' id="openPage" name="openPage" class="imui-large-button"
			escapeXml="true" escapeJs="false" />
	</imart:decision>
	<imart:decision case="3" value="${f:h(ApplyForm.imwPageType)}">
		<input type="button" value='Re-Apply' id="openPage" name="openPage" class="imui-large-button"
			escapeXml="true" escapeJs="false" />
	</imart:decision>

</div>

<!-- 戻る用フォーム -->
<form name="backForm" id="backForm" method="POST" action="${f:h(ApplyForm.imwCallOriginalPagePath)}">
    <input type="hidden" name=imwCallOriginalParams value="${f:h(ApplyForm.imwCallOriginalParams)}" />
</form>

    <script src="ui/js/script-detail-reapply-after-load.js" type="text/javascript"></script>