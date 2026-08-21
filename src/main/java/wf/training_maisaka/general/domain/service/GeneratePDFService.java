package wf.training_maisaka.general.domain.service;

import java.io.InputStream;
import java.io.FileNotFoundException;

import java.net.URLDecoder;
import java.util.Collection;

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
					+"<link href='ui/css/select2.min.css' rel='stylesheet' />"
				    +"<script src='ui/js/select2.min.js' type='text/javascript'></script>"
				    +"<script src='ui/js/jquery.validate.js' type='text/javascript'></script>"
				    
				    +"<script src='ui/js/script-detail-reapply.js' type='text/javascript'></script>"
				    
				    +"<style>"
				    	+"table tbody tr td:last-child input[type='text'], "
				    	+"table tbody tr td:last-child select,"
				    	+"table tbody tr td:last-child input[type='date'] {"
				    		+"width: 60%;"
				    	+"}"
				    	+"#agreement_summary {"
				    		+"width: 60%;"
				    		+"height: 100px;"
				    	+"}"
				    	
				    	+"#psd_dic_reason {"
				    		+"display: none;"
				    		+"width: 80%;"
				    		+"height: 80px;"
				    	+"}"
				    	+ "</style>"
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
					+ "				}"
					+ ""
					+ "				table td,"
					+ "				table th {"
					+ "						border: 1px solid black;"
					+ "				}"
					+ "		</style>"
					+ "</head>"
					+ ""
					+ "<body>"
					+ "		<h1 class='title'>Purchase Agreement</h1>"
					+ ""
					+ "		<h4>Applicant Information</h4>"
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
						  +"<th><label class='imui-required'>Counter Party (vendor name, etc)</label></th>"
						  +"<td><input name='f_vendor' type='text' placeholder='...' value='"+entityAgreementDetail.getCounter_party()+"' disabled></td>"
						+"</tr>"

						+"<tr>"
						  +"<th><label class='imui-required'>Currency</label></th>"
						  +"<td>"
						  	+"<select name='f_currency' disabled>"
						  		+"<option value='IDR'>IDR</option>"
						  	+"</select>"
						  +"</td>"
						+"</tr>"

						+"<tr>"
						  +"<th><label class='imui-required'>Total Amount (Without Tax)</label></th>"
						  +"<td><input name='f_total_amount' type='text' placeholder='100,000,000.00' value='"+entityAgreementDetail.getTotal_amount_no_tax()+"' disabled></td>"
						+"</tr>"

						+"<tr>"
						  +"<th><label class='imui-required'>Agreement Status</label></th>"
						  +"<td>"
						  		+"<input type='radio' id='one_time' name='f_agreement_status' value='1'"
						  			+"${FormClassRows.f_agreement_status == 1 ? 'checked' : '' }"
						  			+"disabled"
						  		+"/>"
						  		+"<label for='one_time'>One Time/New</label>"
						  		+"<br>"
						  		+"<input type='radio' id='extension' name='f_agreement_status' value='2' "
									  +"${FormClassRows.f_agreement_status == '2_a' || FormClassRows.f_agreement_status == '2_b' ? 'checked' : '' }"
						  			+"disabled"
						  		+"/>"
						  		+"<label for='extension'>Amendment/Extension/Renewal</label>"
						  		+"<br>"
						  		+"<div id='extension-childs' style='padding-left: 2em'>"
									  +"<p>Total Duration from first cooperation until now</p>"
									  +"<input type='radio' id='gt_1' name='f_renewal' value='a'"
									  +"${agreementStatusRenewal == 'a' ? 'checked' : '' }"
						  			+"disabled"
									  +"/>"
									  +"<label for='gt_1'>More than 1 year</label>"
									  +"<input type='radio' id='lte_1' name='f_renewal' value='b'"
									  +"${agreementStatusRenewal == 'b' ? 'checked' : '' }"
						  			+"disabled"
									  +"/>"
									  +"<label for='lte_1'>up to 1 year</label>"
						  		+"</div>"
						  		+"<input type='radio' id='umbrella' name='f_agreement_status' value='3'"
						  			+"${FormClassRows.f_agreement_status == 3 ? 'checked' : '' }"
						  			+"disabled"
						  		+"/>"
						  		+"<label for='umbrella'>Umbrella Agreement</label>"
						  +"</td>"
						+"</tr>"

						+"<tr>"
							+"<th><label class='imui-required'>Include auto extension condition</label></th>"
							+"<td>"
						  		+"<input type='radio' id='auto_extension_y' name='f_auto_extension' value='1' "
						  			+"${FormClassRows.f_is_auto_extension == 1 ? 'checked' : '' }"
						  			+"disabled"
						  		+"/>"
						  		+"<label for='auto_extension_y'>Yes</label>"
						  		+"<br>"
						  		+"<input type='radio' id='auto_extension_n' name='f_auto_extension' value='0'"
						  			+"${FormClassRows.f_is_auto_extension == 0 ? 'checked' : '' }"
						  			+"disabled"
						  		+"/>"
						  		+"<label for='auto_extension_n'>No</label>"
							+"</td>"
						+"</tr>"

						+"<tr>"
							+"<th><label class='imui-required'>Purchase Order Required</label></th>"
							+"<td>"
						  		+"<input type='radio' id='purchase_order_req_y' name='f_purchase_order_req' value='1' "
						  			+"${FormClassRows.f_purchase_order_req == 1 ? 'checked' : '' }"
						  			+"disabled"
						  		+"/>"
						  		+"<label for='purchase_order_req_y'>Yes</label>"
						  		+"<br>"
						  		+"<input type='radio' id='purchase_order_req_n' name='f_purchase_order_req' value='0'"
						  			+"${FormClassRows.f_purchase_order_req == 0 ? 'checked' : '' }"
						  			+"disabled"
						  		+"/>"
						  		+"<label for='purchase_order_req_n'>No</label>"
							+"</td>"
						+"</tr>"

						+"<tr>"
						  +"<th><label class='imui-required'>Title described in Agreement</label></th>"
						  +"<td><input name='f_title' type='text' placeholder='...' value='"+entityAgreementDetail.getTitle_in_agreement()+"' disabled></td>"
						+"</tr>"

						+"<tr class='doublerow'>"
						  +"<th rowspan='2'><label class='imui-required'>Effective Date</label></th>"
						  +"<th><label class='imui-required'>From</label></th>"
						  +"<td>"
						  +"<input id='f_effective_from' name='f_effective_from' type='text' value='"+entityAgreementDetail.getEffective_date_from()+"' disabled>"
							+"<im:calendar floatable='true' altField='#f_effective_from' disabled/>"
						  +"</td>"
						+"</tr>"
						+"<tr class='doublerow'>"
						  +"<th><label class='imui-required'>To</label></th>"
						  +"<td>"
							  +"<input id='f_effective_to'  name='f_effective_to' type='text'  value='${FormClassRows.f_effective_date_to }' disabled>"
							+"<im:calendar floatable='true' altField='#f_effective_to' disabled/>"
						  +"</td>"
						+"</tr>"

						+"<tr>"
							+"<th><label class='imui-required'>Related / Non Related Company</label></th>"
							+"<td>"
						  		+"<input type='radio' id='related_parties_y' name='f_related_company' value='1'"
						  			+"${FormClassRows.f_is_related_comp == 1 ? 'checked' : '' }"
						  			+"disabled"
						  		+"/>"
						  		+"<label for='related_parties_y'>Related Parties [Shareholders (KY, MFTBC, MC, MCAH, Daimler), Subsidiary (i.e. KRM, MKM, BAS, BBD, BMC, etc.), Affiliates (i.e. DSF, BSI, MMKSI, MMKI, etc.)]</label>"
						  		+"<br>"
						  		+"<input type='radio' id='related_parties_n' name='f_related_company' value='0'"
						  			+"${FormClassRows.f_is_related_comp == 0 ? 'checked' : '' }"
						  			+"disabled"
						  		+"/>"
						  		+"<label for='related_parties_n'>Non Related Parties</label>"
						  		+"<br>"
						  		+"<p class='bg-warning'><i>Consult with Legal. SHR may be required</i></p>"
							+"</td>"
						+"</tr>"

						+"<tr class='doublerow'>"
						  +"<th rowspan='2'><label class='imui-required'>Estimated Delivery Schedule</label></th>"
						  +"<th><label class='imui-required'>From</label></th>"
						  +"<td>"
						  +"<input id='f_estimated_delivery_from'  name='f_estimated_delivery_from' type='text' value='${FormClassRows.f_delivery_date_from}' disabled>"
							+"<im:calendar floatable='true' altField='#f_estimated_delivery_from' disabled/>"
						  +"</td>"
						+"</tr>"
						+"<tr class='doublerow'>"
						  +"<th><label class='imui-required'>To</label></th>"
						  +"<td>"
								  +"<input id='f_estimated_delivery_to'  name='f_estimated_delivery_to' type='text' value='${FormClassRows.f_delivery_date_to}' disabled>"
								+"<im:calendar floatable='true' altField='#f_estimated_delivery_to'  disabled/> "
						  +"</td>"
						+"</tr>"
						
						+"<tr>"
						  +"<th><label>Agreement Summary (main points only) (In case of contract in foreign currency need to describe exchange rate)</label></th>"
						  +"<td><textarea id='agreement_summary' name='f_agreement_summary' disabled>${FormClassRows.f_agreement_summary }</textarea></td>"
						+"</tr>"
							
					+"</tbody>"
				+"</table>"

				  +"<header class='imui-chapter-title'>"
					+"<h2>Depreciation Check</h2>"
				+"</header>"

				+"<table id='depreciation_check' class='imui-form tab_header'>"
					+"<tbody>"
						+"<tr>"
						  +"<th><label class='imui-required'>Purchase Category</label></th>"
						  +"<td>"
						  		+"<input type='radio' id='tangible_asset' name='f_purchase_category' value='1'"
						  			+"${FormClassRows.f_purchase_category == 1 ? 'checked' : '' }"
						  			+"disabled"
						  		 +"/>"
						  		+"<label for='tangible_asset'>Tangible Asset</label>"

						  		+"<input type='radio' id='intangible_asset' name='f_purchase_category' value='0'"
						  			+"${FormClassRows.f_purchase_category == 0 ? 'checked' : '' }"
						  			+"disabled"
						  		+"/>"
						  		+"<label for='intangible_asset'>Intangible Asset</label>"

						  		+"<input type='radio' id='non_asset' name='f_purchase_category' value='9'"
						  			+"${FormClassRows.f_purchase_category == 9 ? 'checked' : '' }"
						  			+"disabled"
						  		+"/>"
						  		+"<label for='non_asset'>Non-Asset</label>"
						  +"</td>"
						+"</tr>"
						+"<tr class='depreciation_required_asset'>"
						  +"<th><label class='imui-required'>Starting Usage Date (Required if Asset)</label></th>"
						  +"<td>"
								  +"<input id='f_start_usage_date'  name='f_start_usage_date' type='text' value='${FormClassRows.f_starting_usage_date }'>"
								+"<im:calendar floatable='true' altField='#f_start_usage_date'  disabled/>"
						  +"</td>"
						+"</tr>"
						+"<tr class='depreciation_required_asset'>"
						  +"<th><label class='imui-required'>Deprec Amount/Month (Required if Asset)</label></th>"
						  +"<td><input name='f_deprec_amount_per_month' type='text' placeholder='...' value='${FormClassRows.f_deprec_amount_per_month }' disabled></td>"
						+"</tr>"
					+"</tbody>"
					+"</table>"

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
					+"</table>"
					
					
					  +"<header class='imui-chapter-title'>"
						+"<h2>Estimated Schedule (Payment Conditions)</h2>"
					+"</header>"

					+"<table id='estimated_schedule' class='imui-form tab_header'>"
						+"<tbody>"
							+"<tr>"
								+"<th colspan='2'><label class='imui-required'>Payment (Total Cash flow Impact)</label></th>"
							+"</tr>"
							+"<tr>"
									+"<th><label class='imui-required'>Amount</label></th>"
									+"<th><label class='imui-required'>Date</label></th>"
							+"</tr>"
							+"<c:forEach items='${FormClassRows. d_estimated_schedule_payment}' var='row'>"
								+"<tr>"
										+"<td><input type='text' name='f_es_amount_${row.id }' value='${row.payment_amount }' disabled/></td>"
										+"<td>"
											+"<input type='text' name='f_es_date_${row.id}'  id='f_es_date_${row.id}' value='${fn:replace(row.payment_date, '-', '/')}'  disabled/>"
										+"<im:calendar floatable='true' altField='#f_es_date_${row.id}' disabled/>"
										+"</td>"
								+"</tr>"
							+"</c:forEach>"
							+"<tr>"
									+"<th><label class='imui-required'>Total Amount</label></th>"
							+"</tr>"
							+"<tr>"
									+"<td><input type='text'  name='f_es_total_amount' value='${esTotalAmount }' disabled/></td>"
							+"</tr>"
						+"</tbody>"
					+"</table>"


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
