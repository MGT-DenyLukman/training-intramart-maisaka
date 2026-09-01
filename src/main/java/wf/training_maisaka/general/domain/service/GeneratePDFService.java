package wf.training_maisaka.general.domain.service;

import java.io.InputStream;
import java.io.FileNotFoundException;

import java.net.URLDecoder;
import java.util.Collection;
import java.text.NumberFormat;

import org.apache.commons.io.IOUtils;

import jp.co.intra_mart.foundation.service.client.file.PublicStorage;

import io.woo.htmltopdf.HtmlToPdf;
import io.woo.htmltopdf.HtmlToPdfObject;
import wf.training_maisaka.general.domain.repository.HeaderInfoRepository;
import wf.training_maisaka.general.domain.repository.AgreementDetailTempRepository;
import wf.training_maisaka.general.domain.repository.EstSchedulePaymentRepository;

import wf.training_maisaka.general.domain.model.HeaderInfoModel;
import wf.training_maisaka.general.domain.model.AgreementDetailModel;
import wf.training_maisaka.general.domain.model.EstSchedulePaymentModel;



public class GeneratePDFService {
	public String createPDF(String system_matter_id) throws Exception {
		try {
			HeaderInfoRepository headerInfoDB = new HeaderInfoRepository();
			AgreementDetailTempRepository agreementDetailTempDB = new AgreementDetailTempRepository();
			EstSchedulePaymentRepository estSchedulePayDB = new EstSchedulePaymentRepository();
			
			HeaderInfoModel entityHeaderInfo = headerInfoDB.selectData("system_matter_id", system_matter_id).iterator().next();
			AgreementDetailModel entityAgreementDetail = agreementDetailTempDB.selectData("system_matter_id", system_matter_id).iterator().next();
			Collection<EstSchedulePaymentModel> entityEstSchedulePay = estSchedulePayDB.selectData("system_matter_id", system_matter_id);
			
			String html = ""
					+ "<html>"
					+ "<head>"
					+"		<meta charset='UTF-8'>"
					+"		<link href='ui/css/select2.min.css' rel='stylesheet' />"
				    +"		<script src='ui/js/select2.min.js' type='text/javascript'></script>"
				    +"		<script src='ui/js/jquery.validate.js' type='text/javascript'></script>"
				    
				    +"		<script src='ui/js/script-detail-reapply.js' type='text/javascript'></script>"
				    
					+ "		<style>"
					+ "				.title {"
					+ "						text-align: center;"
					+ "						margin-bottom: 1rem;"
					+ "				}"
					+ "				"
					+ "				table {"
					+ "						border-collapse: collapse;"
					+ "						width: 100%;"
					+ "				}"
					+ ""
					+ "				table th {"
					+ "						text-align: left;"
					+ "						background-color: #ddd;"
					+ "				}"
					+ ""
					+ "				table td,"
					+ "				table th {"
					+ "						border: 1px solid black;"
					+ "						padding:4px;"
					+ "				}"
					+ "				"
					+ "				div.checked {"
					+ "					width: 15px;"
					+ "					height:15px;"
					+ "					background: black;"
					+ "					border-radius:50px;"
					+ "					display:inline-block;"
					+ "					margin: 0px 4px;"
					+ "				}"
					+ "				div.unchecked {"
					+ "					width: 14px;"
					+ "					height:14px;"
					+ "					border: 1px solid black;"
					+ "					border-radius:50px;"
					+ "					display:inline-block;"
					+ "					margin: 0px 4px;"
					+ "				}"
					+ ""
					+ ""
					+ ""
					+ ""
					+ ""
					+ ""
					 +"@page { size: A4; margin: 2cm; @bottom-center { content: 'Page ' counter(page) ' of ' counter(pages); } }"
					+ "				.page-break-before {"
					+ "						page-break-before: always;"
					+ "				}"

					+"table.imui-form:not(#agreement_detail) th {"
						+"width: 250px;"
					+"}"

					+"table.imui-form#agreement_detail th:first-child,"
					+"table.imui-form#agreement_detail th:nth-child(2) {"
						+"width: 125px;"
					+"}"
					
					+"button {"
						+"border-radius:5px;"
						+"border: none;"
						+"padding: 4px 8px;"
					+"}"
					
					
					+"table.imui-form#estimated_schedule tr:not(:first-child) th:first-child,"
					+"table.imui-form#estimated_schedule tr:not(:first-child) td:first-child{"
						+"width: 100px;"
						+"text-align: center;"
					+"}"
					+ "		</style>"
					+ "</head>"
					+ ""
					+ "<body>"
					+ "		<h1 class='title'>Purchase Agreement</h1>"
					+ ""
				  +"<header class='imui-chapter-title'>"
					+"<h2>Application Information</h2>"
				+"</header>"
					+ ""
					+ "		<table id='applicant_information' class='imui-form tab_header'>"
						+"		<tbody>"
								+"		<tr>"
										+"		<th><label>Application Number</label></th>"
										+"		<td>" + entityHeaderInfo.getApplication_number() + "</td>"
										+"		<th><label>Application Date</label></th>"
										+"		<td>" + entityHeaderInfo.getApplication_date() +"</td>"
								+"		</tr>"
								+"		<tr>"
										+"		<th><label>Applicant Number</label></th>"
										+"		<td>" + entityHeaderInfo.getApplicant_number() + "</td>"
										+"		<th><label>Department Name</label></th>"
										+"		<td>" + entityHeaderInfo.getApplicant_department_name()+ "</td>"
								+"		</tr>"
								+"		<tr>"
										+"		<th><label>Applicant Name</label></th>"
										+"		<td>"+ entityHeaderInfo.getApplicant_name() +"</td>"
										+"		<th><label>Position Name</label></th>"
										+"		<td>"+ entityHeaderInfo.getApplicant_position_name()+"		</td>"
								+"		</tr>"
						+"		</tbody>"
				+"		</table>"
				+ ""
				  +"<header class='imui-chapter-title'>"
					+"<h2>Agreement Detail</h2>"
				+"</header>"

				+"<table id='agreement_detail' class='imui-form tab_header'>"
					+"<tbody>"
						+"<tr>"
						  +"<th colspan='2'><label class='imui-required'>Counter Party (vendor name, etc)</label></th>"
						  +"<td>"+entityAgreementDetail.getCounter_party()+"</td>"
						+"</tr>"

						+"<tr>"
						  +"<th colspan='2'><label class='imui-required'>Currency</label></th>"
						  +"<td>IDR</td>"
						+"</tr>"

						+"<tr>"
						  +"<th colspan='2'><label class='imui-required'>Total Amount (Without Tax)</label></th>"
						  +"<td>"+entityAgreementDetail.getTotal_amount_no_tax()+"</td>"
						+"</tr>"
						+"<tr>"
						  +"<th colspan='2'><label class='imui-required'>Agreement Status</label></th>"
						  +"<td>";

						if(entityAgreementDetail.getAgreement_status().equals("1")) {
							html+="One Time";
						}else if(entityAgreementDetail.getAgreement_status().equals("2_a")) {
							html+="Amendment/Extension/Renewal (More than 1 Year)";
						}else if(entityAgreementDetail.getAgreement_status().equals("2_b")) {
							html+="Amendment/Extension/Renewal (Up to 1 Year)";
						}else if(entityAgreementDetail.getAgreement_status().equals("3")) {
							html+="Umbrella Agreement";
						}
			
						  html+="</td>"
						+"</tr>"

						+"<tr>"
							+"<th colspan='2'><label class='imui-required'>Include auto extension condition</label></th>"
							+"<td>";
							if(entityAgreementDetail.getIs_auto_extension().equals("1")) {
								html+="Yes";
							}else if(entityAgreementDetail.getIs_auto_extension().equals("0")) {
								html+="No";
							}
						  
							html+="</td>"
						+"</tr>"

						+"<tr>"
							+"<th colspan='2'><label class='imui-required'>Purchase Order Required</label></th>"
							+"<td>";
							if(entityAgreementDetail.getPurchase_order_req().equals("1")) {
								html+="Yes";
							}else if(entityAgreementDetail.getPurchase_order_req().equals("0")) {
								html+="No";
							}
							html+="</td>"
						+"</tr>"

						+"<tr>"
						  +"<th colspan='2'><label class='imui-required'>Title described in Agreement</label></th>"
						  +"<td>"+entityAgreementDetail.getTitle_in_agreement()+"</td>"
						+"</tr>"

						+"<tr class='doublerow'>"
						  +"<th rowspan='2'><label class='imui-required'>Effective Date</label></th>"
						  +"<th><label class='imui-required'>From</label></th>"
						  +"<td>"
						  +entityAgreementDetail.getEffective_date_from()
							+"<im:calendar floatable='true' altField='#f_effective_from' disabled/>"
						  +"</td>"
						+"</tr>"
						+"<tr class='doublerow'>"
						  +"<th><label class='imui-required'>To</label></th>"
						  +"<td>"
						  +entityAgreementDetail.getEffective_date_to()
						  +"</td>"
						+"</tr>"

						+"<tr>"
							+"<th colspan='2'><label class='imui-required'>Related / Non Related Company</label></th>"
							+"<td>";
							if(entityAgreementDetail.getPurchase_order_req().equals("1")) {
								html+="<label for='related_parties_y'>Related Parties [Shareholders (KY, MFTBC, MC, MCAH, Daimler), Subsidiary (i.e. KRM, MKM, BAS, BBD, BMC, etc.), Affiliates (i.e. DSF, BSI, MMKSI, MMKI, etc.)]</label>";
							}else if(entityAgreementDetail.getPurchase_order_req().equals("0")) {
								html+="<label for='related_parties_n'>Non Related Parties</label>";
							}
							html+="</td>"
						+"</tr>"

						+"<tr class='doublerow'>"
						  +"<th rowspan='2'><label class='imui-required'>Estimated Delivery Schedule</label></th>"
						  +"<th><label class='imui-required'>From</label></th>"
						  +"<td>"
						  +entityAgreementDetail.getDelivery_date_from()
						  +"</td>"
						+"</tr>"
						+"<tr class='doublerow'>"
						  +"<th><label class='imui-required'>To</label></th>"
						  +"<td>"
						  +entityAgreementDetail.getDelivery_date_to()
						  +"</td>"
						+"</tr>"
						
						+"<tr>"
						  +"<th colspan='2'><label>Agreement Summary (main points only) (In case of contract in foreign currency need to describe exchange rate)</label></th>"
						  +"<td>"
						  +entityAgreementDetail.getAgreement_summary()
						  +"</td>"
						+"</tr>"
							
					+"</tbody>"
				+"</table>"

				  +"<header class='imui-chapter-title page-break-before'>"
					+"<h2>Depreciation Check</h2>"
				+"</header>"

				+"<table id='depreciation_check' class='imui-form tab_header'>"
					+"<tbody>"
						+"<tr>"
						  +"<th><label class='imui-required'>Purchase Category</label></th>"
						  +"<td>";
							if(entityAgreementDetail.getPurchase_category().equals("1")) {
						  		html+="<label for='tangible_asset'>Tangible Asset</label>";
							}else if(entityAgreementDetail.getPurchase_category().equals("0")) {
						  		html+="<label for='intangible_asset'>Intangible Asset</label>";
							}else if(entityAgreementDetail.getPurchase_category().equals("9")) {
						  		html+="<label for='non_asset'>Non-Asset</label>";
							}
						  html+="</td>";
						  
						  if(!entityAgreementDetail.getPurchase_category().equals("9")) {
								html+="</tr>"
								+"<tr class='depreciation_required_asset'>"
								  +"<th><label class='imui-required'>Starting Usage Date (Required if Asset)</label></th>"
								  +"<td>"
								  +entityAgreementDetail.getStarting_usage_date()
								  +"</td>"
								+"</tr>"
								+"<tr class='depreciation_required_asset'>"
								  +"<th><label class='imui-required'>Deprec Amount/Month (Required if Asset)</label></th>"
								  +"<td>"
								  +entityAgreementDetail.getDeprec_amount_per_month()
								  +"</td>"
								+"</tr>";
						  }
					html+="</tbody>"
					+"</table>";

					/*
					  +"<header class='imui-chapter-title'>"
						+"<h2>PL Impact</h2>"
					+"</header>"

					+"<table id='pl_impact' class='imui-form tab_header'>"
						+"<tbody>"
							+"<tr>"
									+"<th><label class='imui-required'>Budget PL impact to current FY</label></th>"
									+"<th><label class='imui-required'>Month</label></th>"
									+"<th><label class='imui-required'>PL Impact to current FY</label></th>"
									+"<th><label class='imui-required'>Month</label></th>"
							+"</tr>"
							+"<tr>"
									+"<td><input type='text' name='f_budget_impact_to_fy'/></td>"
									+"<td><input type='text' name='f_budget_impact_month'/></td>"
									+"<td><input type='text' name='f_pl_impact_to_fy'/></td>"
									+"<td><input type='text' name='f_pl_impact_month'/></td>"
							+"</tr>"
						+"</tbody>"
					+"</table>"
					
					
					
					  +"<header class='imui-chapter-title'>"
						+"<h2>Asset</h2>"
					+"</header>"

					+"<table id='asset' class='imui-form tab_header'>"
						+"<tbody>"
							+"<tr>"
									+"<th><label class='imui-required'>Asset Number</label></th>"
									+"<th><label class='imui-required'>Book Value</label></th>"
							+"</tr>"
							+"<tr>"
									+"<td><input type='text' name='f_asset_number'/></td>"
									+"<td><input type='text' name='f_book_value'/></td>"
							+"</tr>"
						+"</tbody>"
					+"</table>";
					 */
					
					
					  html+="<header class='imui-chapter-title'>"
						+"<h2>Estimated Schedule (Payment Conditions)</h2>"
					+"</header>"

					+"<table id='estimated_schedule' class='imui-form tab_header'>"
						+"<tbody>"
							+"<tr>"
								+"<th colspan='2' style='text-align:center'><label class='imui-required'>Payment (Total Cash flow Impact)</label></th>"
							+"</tr>"
							+"<tr>"
									+"<th><label class='imui-required'>Amount</label></th>"
									+"<th><label class='imui-required'>Date</label></th>"
							+"</tr>";
							Integer totalAmount = 0;
							for(EstSchedulePaymentModel row : entityEstSchedulePay){
								totalAmount += Integer.parseInt(row.getPayment_amount().replaceAll(",", ""));
								html+="<tr>"
										+"<td>"
										+row.getPayment_amount()
										+"</td>"
										+"<td>"
										+row.getPayment_date()
										+"</td>"
								+"</tr>";
							}
							html+="<tr>"
									+"<th><label class='imui-required'>Total Amount</label></th>"
							+"</tr>"
							+"<tr>"
									+"<td>"
									+String.format("%,d",totalAmount)
									+"</td>"
							+"</tr>"
						+"</tbody>"
					+"</table>"
						




					  +"<header class='imui-chapter-title'>"
						+"<h2>Agreement Classification</h2>"
					+"</header>"

					+"<table id='agreement_classification' class='imui-form tab_header'>"
						+"<tbody>"
							+"<tr>"
									+"<th><label class='imui-required'>Agreement Classification</label></th>"
									+"<td>";
											if(entityAgreementDetail.getAgreement_classification().equals("1_1")) {
													html+="<label for='gte_1_billion'>Agreement with amount is equal or more than 1 billion</label>";
											}else if(entityAgreementDetail.getAgreement_classification().equals("1_2")) {
													html+="<label for='gte_12_months'>Period is equal or more than 12 months</label>";
											}else if(entityAgreementDetail.getAgreement_classification().equals("1_3")) {
													html+="<label for='related_parties'>Agreement related to spesific party</label>";
													html+="<p style='padding-left: 2em'><i>- Bank, Related Parties, Dealer, Consulatant/Lawyer/Appraiser (Vendor head-hunter, ISO Certification, HR system development, etc), Government, Production(Component and Parts), Customer, Etc</i></p>";
											}else if(entityAgreementDetail.getAgreement_classification().equals("1_4")) {
														html+="<label for='special_issue'>Special issue</label>"
														+"<br>"
														+"<p style='padding-left: 2em'><i>New project/Issue (more than 50 M), Not included in Budget Plan</i></p>";
											}else if(entityAgreementDetail.getAgreement_classification().equals("1_5")) {
														html+="<label for='direct_procurement'>Direct Procurement due to either of the 2 cases below</label>"
														+"<br>"
														+"<div style='padding-left: 2em'>"
															+"<ul style='list-style-type: decimal'>"
																	+"<li><i>Emergency procurement</i></li>"
																	+"<li><i>Spesific Goods / Items (refere to PSD Guideline)</i></li>"
															+"</ul>"
														+"</div> ";
											}else if(entityAgreementDetail.getAgreement_classification().equals("2")) {
												html+="<label for='dic_approval'>DIC Director Approval</label>";
											}
									html+="</td>"
							+"</tr>"
							+"<tr>"
									+"<th><label class='imui-required'>EC Approval is Required or Not</label></th>"
									+"<td>";
											if(entityAgreementDetail.getEc_approval_is_req().equals("1_1")) {
														html+="<label for='amount_gte_1_billion'>Amount is equal or more than 1 billion</label>";
											}else if(entityAgreementDetail.getEc_approval_is_req().equals("1_2")) {
														html+="<label for='period_gt_12_month'>Period is equal or more than 12 months</label>";
											}else if(entityAgreementDetail.getEc_approval_is_req().equals("1_2")) {
														html+="<label for='escalate_issue'>Director believes it is necessary to escalate the issue to EC</label>";
											}else if(entityAgreementDetail.getEc_approval_is_req().equals("0")) {
														html+="<label for='ec_approval_no'>No</label>";

											}
									html+="</td>"
							+"</tr>"
						+"</tbody>"
					+"</table>"

					+"<c:if test='${FormClassRows.f_purchase_order_req == 1}'>"
					+"<div id='section-psd-check'>"
					  +"<header class='imui-chapter-title'>"
						+"<h2>PSD Check (by UH or DH, PSD)</h2>"
					+"</header>"

					+"<table id='psd_check' class='imui-form tab_header'>"
						+"<tbody>"
								+"<tr>"
										+"<th><label class='imui-required'>PSD Area or Non-PSD Area (Based on Guideline)</label></th>"
										+"<td>";
												if(entityAgreementDetail.getIs_psd_area().equals("1")) {
													html+="<div class='checked'></div>";
												}else {
													html+="<div class='unchecked'></div>";
												}
												html+="<label for='psd'>PSD (go to #2)</label><br>";

												if(entityAgreementDetail.getIs_psd_area().equals("0")) {
													html+="<div class='checked'></div>";
												}else {
													html+="<div class='unchecked'></div>";
												}
												html+="<label for='psd_end'>Non-PSD (End)</label>"
										+"</td>"
								+"</tr>"
								+"<tr id='f_psd_area_second'>"
										+"<th><label class='imui-required'>In PSD Area, PSD Process or DIC Process</label></th>"
										+"<td>";
												if(entityAgreementDetail.getPsd_or_dic().equals("PSD")) {
													html+="<div class='checked'></div>";
												}else {
													html+="<div class='unchecked'></div>";
												}
												html+="<label for='psd_2'>PSD (Pitching result attached)</label>"
												+"<br>";
												if(entityAgreementDetail.getPsd_or_dic().equals("DIC")) {
													html+="<div class='checked'></div>";
												}else {
													html+="<div class='unchecked'></div>";
												}
												html+="<label for='psd_dic'>DIC (Please describe the reason in the below)</label>"
												+"<br>";
												if(entityAgreementDetail.getPsd_or_dic().equals("DIC")) {
													html+= "<label>"+entityAgreementDetail.getDic_reason()+"</label>";
												}
										html+="</td>"
								+"</tr>"
						+"</tbody>"
					+"</table>"
				+"</div>"
				+"</c:if>"

				+"<div id='section-cco'>"
					  +"<header class='imui-chapter-title'>"
						+"<h2>Compliance Check By CCO</h2>"
					+"</header>"

					+"<table id='compliance_check' class='imui-form tab_header'>"
						+"<tbody>"
								+"<tr>"
										+"<th><label class='imui-required'>D / D Process Required</label></th>"
										+"<td>";
												if(entityAgreementDetail.getIs_dd_req().equals("1")) {
													html+="<div class='checked'></div>";
												}else {
													html+="<div class='unchecked'></div>";
												}
												html+="<label for='dd_process_yes'>Yes</label>";

												if(entityAgreementDetail.getIs_dd_req().equals("0")) {
													html+="<div class='checked'></div>";
												}else {
													html+="<div class='unchecked'></div>";
												}
												html+="<label for='dd_process_no'>No</label>"
										+"</td>"
								+"</tr>"
								+"<tr>"
										+"<th><label class='imui-required'>Anti Bribery Clause Include</label></th>"
										+"<td>";
												if(entityAgreementDetail.getIs_anti_bribery().equals("1")) {
													html+="<div class='checked'></div>";
												}else {
													html+="<div class='unchecked'></div>";
												}
												html+="<label for='anti_bribery_yes'>Yes</label>";

												if(entityAgreementDetail.getIs_anti_bribery().equals("0")) {
													html+="<div class='checked'></div>";
												}else {
													html+="<div class='unchecked'></div>";
												}
												html+="<label for='anti_bribery_no'>No</label>"
										+"</td>"
								+"</tr>"
								+"<tr>"
										+"<th><label class='imui-required'>Audit Right Included</label></th>"
										+"<td>";
												if(entityAgreementDetail.getIs_audit_right().equals("1")) {
													html+="<div class='checked'></div>";
												}else {
													html+="<div class='unchecked'></div>";
												}
												html+="<label for='audit_right_yes'>Yes</label>";

												if(entityAgreementDetail.getIs_audit_right().equals("0")) {
													html+="<div class='checked'></div>";
												}else {
													html+="<div class='unchecked'></div>";
												}
												html+="<label for='audit_right_no'>No</label>"
										+"</td>"
								+"</tr>"
						+"</tbody>"
					+"</table>"
				+"</div>"
					
					
				+"<div id='section-legal'>"
					  +"<header class='imui-chapter-title'>"
						+"<h2>Filled By Legal</h2>"
					+"</header>"

					+"<table id='filled_by_legal' class='imui-form tab_header'>"
						+"<tbody>"
								+"<tr>"
										+"<th><label class='imui-required'>Agreement Number</label></th>"
										+"<td>"
											+"<label>"+entityAgreementDetail.getAgreement_number()+"</label>"
										+"</td>"
								+"</tr>"
								+"<tr>"
										+"<th><label class='imui-required'>Agreement Date</label></th>"
										+"<td>"
											+"<label>"+entityAgreementDetail.getAgreement_date().replaceAll("-", "/")+"</label>"
										+"</td>"
								+"</tr>"
						+"</tbody>"
					+"</table>"
				+"</div>"




					+ "</body>"
					+ "</html";
			
			InputStream success_pdf = HtmlToPdf.create().object(HtmlToPdfObject.forHtml(html)).convert();
			
			String dirName = "generated_pdf";
			String filePathName = dirName + "/" + system_matter_id +".pdf";
			PublicStorage createNewDir = new PublicStorage(dirName);
			PublicStorage PDFFilePath = new PublicStorage(filePathName);
			
			createNewDir.makeDirectories();
			
			PDFFilePath.save(IOUtils.toByteArray(success_pdf));
			
			return filePathName;
			
		}catch(Exception e) {
			e.printStackTrace();
			
			return "";
		}
		
	}
}
