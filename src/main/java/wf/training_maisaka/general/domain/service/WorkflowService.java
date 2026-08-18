package wf.training_maisaka.general.domain.service;

import java.util.Collection;
import java.util.ArrayList;

import wf.training_maisaka.general.app.ImartForm;
import wf.training_maisaka.general.domain.repository.AgreementDetailTempRepository;
import wf.training_maisaka.general.domain.repository.EstSchedulePaymentRepository;
import wf.training_maisaka.general.domain.model.EstSchedulePaymentModel;
import wf.training_maisaka.general.domain.model.AgreementDetailModel;

import com.fasterxml.jackson.databind.ObjectMapper;

public class WorkflowService {
	
	public ImartForm getAgreementDetailTemp(String column, String value) {
		ImartForm result = new ImartForm();
		try {
		
		AgreementDetailTempRepository agreementDetailTempDB = new AgreementDetailTempRepository();
		EstSchedulePaymentRepository estSchPayDB = new EstSchedulePaymentRepository();
		Collection<AgreementDetailModel> agreementDetailTempData = agreementDetailTempDB.selectData(column, value);

		AgreementDetailModel entityData = agreementDetailTempData.iterator().next();
		
			this.debug("get temp data", entityData);
		
			String effectiveFrom = entityData.getEffective_date_from().replaceAll("-", "/");
			String effectiveTo = entityData.getEffective_date_to().replaceAll("-", "/");
			String deliveryFrom = entityData.getDelivery_date_from().replaceAll("-", "/");
			String deliveryTo = entityData.getDelivery_date_to().replaceAll("-", "/");
		
			result.setF_counter_party(entityData.getCounter_party());
			result.setF_currency(entityData.getCurrency());
			result.setF_total_amount_no_tax(entityData.getTotal_amount_no_tax());
			result.setF_agreement_status(entityData.getAgreement_status());
			result.setF_is_auto_extension(entityData.getIs_auto_extension());
			result.setF_purchase_order_req(entityData.getPurchase_order_req());
			result.setF_title_in_agreement(entityData.getTitle_in_agreement());
			result.setF_effective_date_from(effectiveFrom);
			result.setF_effective_date_to(effectiveTo);
			result.setF_is_related_comp(entityData.getIs_related_comp());
			result.setF_delivery_date_from(deliveryFrom);
			result.setF_delivery_date_to(deliveryTo);
			result.setF_agreement_summary(entityData.getAgreement_summary());
			result.setF_purchase_category(entityData.getPurchase_category());
			if(entityData.getStarting_usage_date() != null) {
				String startingUsageDate = entityData.getStarting_usage_date().replaceAll("-", "/");
				result.setF_starting_usage_date(startingUsageDate);
				
			}
			result.setF_deprec_amount_per_month(entityData.getDeprec_amount_per_month());
			
			
			//multiple data
			Collection<EstSchedulePaymentModel> entityEstSchData = estSchPayDB.selectData(column, value);

			result.setD_estimated_schedule_payment(entityEstSchData);

			
		}catch(Exception e) {
			 e.printStackTrace();
		}
		
		return  result;
	}
	
	public void debug(String title, Object obj) {
		try {
			// ========= START DEBUGGING =========
			System.out.println("");
			System.out.println("");
			System.out.println("===" + title  +" START DEBUGGING ===");
			ObjectMapper mapper = new ObjectMapper();
			System.out.println(mapper.writeValueAsString(obj));
			System.out.println("===" + title  +" END DEBUGGING ===");
			System.out.println("");
			System.out.println("");
			// ========= END DEBUGGING =========
			
		} catch(Exception e) {
			e.printStackTrace();
		}
	}

}
