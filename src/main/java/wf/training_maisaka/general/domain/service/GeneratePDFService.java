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
					+ "						background-color: #ddd;"
					+ "				}"
					+ ""
					+ "				table td,"
					+ "				table th {"
					+ "						border: 1px solid black;"
					+ "						pading: 4px;"
					+ "				}"
					+ ""
					+ ""
					+ ""
					+ ""
					+ "				table#agreement_detail td {"
					+ "						width: 600px;"
					+ "				}"
					+ ""
					+ ""
					 +"@page { size: A4; margin: 2cm; @bottom-center { content: 'Page ' counter(page) ' of ' counter(pages); } }"
					+ "				.page-break-before {"
					+ "						page-break-before: always;"
					+ "				}"
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
								+"<th colspan='2'><label class='imui-required'>Payment (Total Cash flow Impact)</label></th>"
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
