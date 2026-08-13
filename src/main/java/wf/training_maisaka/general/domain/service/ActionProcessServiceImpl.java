package wf.training_maisaka.general.domain.service;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;


import jp.co.intra_mart.common.aid.jdk.java.util.LocaleUtil;
import jp.co.intra_mart.foundation.security.message.MessageManager;
import jp.co.intra_mart.foundation.workflow.plugin.process.action.ActionProcessParameter;
import jp.co.intra_mart.foundation.workflow.util.WorkflowNumberingManager;
import jp.co.intra_mart.foundation.workflow.exception.WorkflowException;
import jp.co.intra_mart.foundation.workflow.exception.WorkflowExternalException;

import java.util.Map;

import wf.training_maisaka.general.ActionProcessService;

import wf.training_maisaka.general.domain.repository.HeaderRepository;
import wf.training_maisaka.general.domain.repository.AgreementDetailTempRepository;

import wf.training_maisaka.general.domain.model.HeaderModel;
import wf.training_maisaka.general.domain.model.AgreementDetailModel;

import com.fasterxml.jackson.databind.ObjectMapper;
import java.text.SimpleDateFormat;
import java.util.Date;


@Service("service_training_maisaka")
@Transactional(propagation = Propagation.MANDATORY)
public class ActionProcessServiceImpl implements ActionProcessService{
	@Override
	public final String apply(final ActionProcessParameter parameter, final Map<String, Object> userParameter) throws Exception{
		System.out.println("MASUK APPLY");
		String number = null;
		try {
			HeaderRepository headerDB = new HeaderRepository();
			AgreementDetailTempRepository agreementDetailTempDB = new AgreementDetailTempRepository();
			
			HeaderModel entity_Header = getEntity_Header(parameter, userParameter);
			AgreementDetailModel entity_AgreementDetail = getEntity_AgreementDetail(parameter, userParameter);
			
			headerDB.insertData(entity_Header);
			agreementDetailTempDB.insertData(entity_AgreementDetail);
			
			number = WorkflowNumberingManager.getNumber();

        } catch (final WorkflowException e) {
        	e.printStackTrace();
            throw new WorkflowExternalException(MessageManager.getInstance().getMessage(LocaleUtil.toLocale(parameter.getLocaleId()), "SAMPLE.IMW.ERR.003"));
            
        }
		return number;
	}

	@Override
	public final String reapply(final ActionProcessParameter parameter, final Map<String, Object> userParameter) throws Exception{
		System.out.println("MASUK RE-APPLY");
		try {
			HeaderRepository headerDB = new HeaderRepository();
			AgreementDetailTempRepository agreementDetailTempDB = new AgreementDetailTempRepository();
			
			HeaderModel entity_Header = getEntity_Header(parameter, userParameter);
			AgreementDetailModel entity_AgreementDetail = getEntity_AgreementDetail(parameter, userParameter);
			
			headerDB.updateData(entity_Header);
			agreementDetailTempDB.updateData(entity_AgreementDetail);
			

        } catch (final WorkflowException e) {
        	e.printStackTrace();
            throw new WorkflowExternalException(MessageManager.getInstance().getMessage(LocaleUtil.toLocale(parameter.getLocaleId()), "SAMPLE.IMW.ERR.003"));
            
        }
		return null;
	}


	 private HeaderModel getEntity_Header(final ActionProcessParameter parameter, final Map<String, Object> userParameter) {
		 	HeaderModel result = new HeaderModel();
		 	
		 	result.setSystem_matter_id(parameter.getSystemMatterId());
		 	result.setUser_data_id(parameter.getUserDataId());
		 	result.setStatus("1");
		 	result.setMail_status("0");
		 	
		 	return result;
	 }

	 private AgreementDetailModel getEntity_AgreementDetail(final ActionProcessParameter parameter, final Map<String, Object> userParameter) {
		 AgreementDetailModel result = new AgreementDetailModel();
		 try {
		 	
		 	// agreement status 
		 	String agreementStatus = getEntity_TryCatch_UserParameter(userParameter, "f_agreement_status");
		 	if("2".equals(agreementStatus)) {
		 		String agreementStatusRenewal = getEntity_TryCatch_UserParameter(userParameter, "f_renewal");
		 		agreementStatus += "_" + agreementStatusRenewal;
		 	}
		 	
		 	//currency
		 	String currency = "IDR"; //フォームでdisabledから、設定が必要
		 	

		 	
		 	result.setSystem_matter_id(parameter.getSystemMatterId());
		 	result.setUser_data_id(parameter.getUserDataId());
		 	
		 	
			result.setCounter_party(getEntity_TryCatch_UserParameter(userParameter, "f_vendor"));
			result.setCurrency(currency);
			result.setTotal_amount_no_tax(getEntity_TryCatch_UserParameter(userParameter, "f_total_amount"));
			result.setAgreement_status(agreementStatus);
			result.setIs_auto_extension(getEntity_TryCatch_UserParameter(userParameter, "f_auto_extension"));
			result.setPurchase_order_req(getEntity_TryCatch_UserParameter(userParameter, "f_purchase_order_req"));
			result.setTitle_in_agreement(getEntity_TryCatch_UserParameter(userParameter, "f_title"));
			result.setEffective_date_from(getEntity_TryCatch_UserParameter(userParameter, "f_effective_from"));
			result.setEffective_date_to(getEntity_TryCatch_UserParameter(userParameter, "f_effective_to"));
			result.setIs_related_comp(getEntity_TryCatch_UserParameter(userParameter, "f_related_company"));
			result.setDelivery_date_from(getEntity_TryCatch_UserParameter(userParameter, "f_estimated_delivery_from"));
			result.setDelivery_date_to(getEntity_TryCatch_UserParameter(userParameter, "f_estimated_delivery_to"));
			result.setAgreement_summary(getEntity_TryCatch_UserParameter(userParameter, "f_agreement_summary"));
			result.setPurchase_category(getEntity_TryCatch_UserParameter(userParameter, "f_purchase_category"));
			result.setStarting_usage_date(getEntity_TryCatch_UserParameter(userParameter, "f_start_usage_date"));
			result.setDeprec_amount_per_month(getEntity_TryCatch_UserParameter(userParameter, "f_deprec_amount_per_month"));
		 }catch(Exception e) {
			 e.printStackTrace();
		 }
		 	
		 	return result;
	 }
	 
	 private String getEntity_TryCatch_UserParameter(final Map<String, Object> userParameter, String input_form) {
		 try {
			 return userParameter.get(input_form).toString();
		 } catch(Exception e) {
			 e.printStackTrace();
			 return "";
		 }
	 }
 }