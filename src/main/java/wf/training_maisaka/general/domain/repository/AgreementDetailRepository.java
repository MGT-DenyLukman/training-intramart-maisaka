package wf.training_maisaka.general.domain.repository;

import jp.co.intra_mart.foundation.database.SQLManager;
//import jp.co.intra_mart.foundation.database.SearchCondition;
import jp.co.intra_mart.foundation.database.ColumnValues;


import org.joda.time.LocalDateTime;
import java.sql.Timestamp;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.Collection;
import java.util.ArrayList;

import wf.training_maisaka.general.domain.model.AgreementDetailModel;
import wf.training_maisaka.general.domain.service.WorkflowService;

public class AgreementDetailRepository {
	private String table_name = "wf_agreement_detail";
	private String select_data_by_matter_id = "select * from wf_agreement_detail where system_matter_id = ?";
	private String select_data_all = "select * from wf_agreement_detail";
	
	
	public void insertData(AgreementDetailModel varAgreementDetailData) throws Exception {
		SQLManager sqlManager = new SQLManager();
		ColumnValues columnVal = this.setData(varAgreementDetailData, "create");
		
		sqlManager.insert(table_name, columnVal);
	}


	private	ColumnValues setData(AgreementDetailModel varAgreementDetailData, String condition) {
		WorkflowService service = new WorkflowService();
		ColumnValues result = new ColumnValues();
		service.debug("varAgreementDetailData", varAgreementDetailData);

		 	try {
		
				 SimpleDateFormat SDF = new SimpleDateFormat("yyyy/MM/dd");
				Date effectiveFrom = SDF.parse(varAgreementDetailData.getEffective_date_from().replaceAll("-", "/"));
				 Date effectiveTo = SDF.parse(varAgreementDetailData.getEffective_date_to().replaceAll("-", "/"));
				 Date estimatedDeliveryFrom = SDF.parse(varAgreementDetailData.getDelivery_date_from().replaceAll("-", "/"));
				 Date estimatedDeliveryTo = SDF.parse(varAgreementDetailData.getDelivery_date_to().replaceAll("-", "/"));
//				 Date startingUsageDate = SDF.parse(varAgreementDetailData.getStarting_usage_date());
		
				LocalDateTime now = LocalDateTime.now();
				Timestamp timestamp = Timestamp.valueOf(now.toString("yyyy-MM-dd HH:mm:ss"));
				
				result.add("system_matter_id", varAgreementDetailData.getSystem_matter_id());
				result.add("user_data_id", varAgreementDetailData.getUser_data_id());
				
				
				result.add("counter_party", varAgreementDetailData.getCounter_party());
				result.add("currency", varAgreementDetailData.getCurrency());
				result.add("total_amount_no_tax", varAgreementDetailData.getTotal_amount_no_tax());
				result.add("agreement_status", varAgreementDetailData.getAgreement_status());
				result.add("is_auto_extension", varAgreementDetailData.getIs_auto_extension());
				result.add("purchase_order_req", varAgreementDetailData.getPurchase_order_req());
				result.add("title_in_agreement", varAgreementDetailData.getTitle_in_agreement());
				result.add("effective_date_from", effectiveFrom);
				result.add("effective_date_to", effectiveTo);
				result.add("is_related_comp", varAgreementDetailData.getIs_related_comp());
				result.add("delivery_date_from", estimatedDeliveryFrom);
				result.add("delivery_date_to", estimatedDeliveryTo);
				result.add("agreement_summary", varAgreementDetailData.getAgreement_summary());
				result.add("purchase_category", varAgreementDetailData.getPurchase_category());
				 if(varAgreementDetailData.getStarting_usage_date() != null) {
					 Date startingUsageDate = SDF.parse(varAgreementDetailData.getStarting_usage_date().replaceAll("-", "/"));
					result.add("starting_usage_date", startingUsageDate);
				 }
				result.add("deprec_amount_per_month", varAgreementDetailData.getDeprec_amount_per_month());
				
				
				//multiple branch
				result.add("agreement_classification", varAgreementDetailData.getAgreement_classification());
				result.add("ec_approval_is_req", varAgreementDetailData.getEc_approval_is_req());

				if("create".equals(condition)){
					result.add("created_at", timestamp);
				}

				result.add("updated_at", timestamp);
		
			} catch (Exception e) {
				// TODO 自動生成された catch ブロック
				e.printStackTrace();
			}
		return result;
	}
	
	public Collection<AgreementDetailModel> selectData(String column, String value) throws Exception {
		try {
			SQLManager sqlManager = new SQLManager();
			ArrayList<Object> parameters = new ArrayList<>();
			
			String select_query = this.select_data_all;
			
			if("system_matter_id".equals(column)) {
				select_query = this.select_data_by_matter_id;
				parameters.add(value);
			}			
			
			Collection<AgreementDetailModel> result = sqlManager.select(AgreementDetailModel.class, select_query, parameters);
			
			return result;
		} catch(Exception e) {
			throw new Exception("Error in select data agreement detail", e);
		}
	}
}
