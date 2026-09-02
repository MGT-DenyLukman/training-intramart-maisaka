package com.example.workflow.api;

import jp.co.intra_mart.foundation.context.Contexts;
import jp.co.intra_mart.foundation.context.model.AccountContext;
import jp.co.intra_mart.foundation.workflow.application.process.ApplyManager;
import jp.co.intra_mart.foundation.workflow.plugin.process.action.ActionProcessParameter;
import jp.co.intra_mart.foundation.workflow.application.model.param.ApplyParam;
import jp.co.intra_mart.foundation.web_api_maker.annotation.POST;
import jp.co.intra_mart.foundation.web_api_maker.annotation.GET;
import jp.co.intra_mart.foundation.web_api_maker.annotation.Path;
import jp.co.intra_mart.foundation.web_api_maker.annotation.IMAuthentication;
import jp.co.intra_mart.foundation.web_api_maker.annotation.BasicAuthentication;
import javax.servlet.http.HttpServletRequest;
import jp.co.intra_mart.foundation.service.client.information.Identifier;
import jp.co.intra_mart.foundation.workflow.application.model.ApplyResultModel;

import wf.training_maisaka.general.domain.service.ActionProcessServiceImpl;

import com.example.workflow.api.WorkflowApplyRequest;

import wf.training_maisaka.general.domain.service.WorkflowService;

import java.util.HashMap;
import java.util.Map;
import com.fasterxml.jackson.databind.ObjectMapper;

@IMAuthentication
public class WorkflowApiService {
	
	@Path("/workflow/test-get")
	@GET
	public Map<String, Object> testGet() {
		Map<String, Object> response = new HashMap<>();
		try {
			System.out.println("SUCCESS access");
			
			response.put("success", true);
		}catch(Exception e) {
			response.put("success", false);
			response.put("message", e.getMessage());
		}
		
		return response;
	}

    @Path("/workflow/apply")
    @POST
    public Map<String, Object> applyWorkflow(HttpServletRequest request) {
        Map<String, Object> response = new HashMap<>();
        
        try {
        	WorkflowService service = new WorkflowService();
            // ログインユーザコンテキストを取得
            AccountContext accountContext = Contexts.get(AccountContext.class);
            String userCd = accountContext.getUserCd();

			final Identifier identifier = new Identifier();
			String userDataId = identifier.get();
			
            
            service.debug("accountContext workflowApiService", accountContext);
            WorkflowApplyRequest entity = new WorkflowApplyRequest();
         // Read array / list parameters from JSON
            ObjectMapper mapper = new ObjectMapper();
            Map<String, Object> jsonData = mapper.readValue(request.getInputStream(), Map.class);

            service.debug("REQUEST", jsonData);
            
            /*
         // ==========================================
         // 1. IMW Prefix Keys (Sorted First)
         // ==========================================
         /*
         userParameter.put("imwApplyBaseDate", jsonData.get("imwApplyBaseDate"));
         userParameter.put("imwAuthUserCode", jsonData.get("imwAuthUserCode"));
         userParameter.put("imwCallOriginalParams", jsonData.get("imwCallOriginalParams"));
         userParameter.put("imwFlowId", jsonData.get("imwFlowId"));
         userParameter.put("imwNextScriptPath", jsonData.get("imwNextScriptPath"));
         userParameter.put("imwNodeId", jsonData.get("imwNodeId"));
         userParameter.put("imwOpenPageFormName", jsonData.get("imwOpenPageFormName"));
         userParameter.put("imwOpenPageFormTarget", jsonData.get("imwOpenPageFormTarget"));
         userParameter.put("imwPageType", jsonData.get("imwPageType"));
         userParameter.put("imwPageTypeTempSave", jsonData.get("imwPageTypeTempSave"));
         userParameter.put("imwSystemMatterId", jsonData.get("imwSystemMatterId"));
         userParameter.put("imwUserDataId", jsonData.get("imwUserDataId"));
         */
			ApplyParam applyParam = new ApplyParam();
			applyParam.setFlowId((String) jsonData.get("flowId"));
			applyParam.setMatterName((String) jsonData.get("matterName"));
			//applyParam.setApplyAuthUserCode((String) jsonData.get("authUserCd"));
			applyParam.setApplyAuthUserCode((String) jsonData.get("imwAuthUserCode"));
			applyParam.setApplyExecuteUserCode((String) jsonData.get("imwAuthUserCode"));
			applyParam.setApplyBaseDate((String) jsonData.get("imwApplyBaseDate"));
			applyParam.setUserDataId(userDataId);
			
            
            
            
            
            
            // 2. 申請処理実行
            //ApplyManager applyManager = new ApplyManager();
            Map<String, Object> userParameter = new HashMap<>();


         // ==========================================
         // 2. Standard Application / Custom Form Keys
         // ==========================================
         userParameter.put("f_agreement_classification", jsonData.get("f_agreement_classification"));
         userParameter.put("f_agreement_classification_1", jsonData.get("f_agreement_classification_1"));
         userParameter.put("f_agreement_status", jsonData.get("f_agreement_status"));
         userParameter.put("f_agreement_summary", jsonData.get("f_agreement_summary"));
         userParameter.put("f_amount_currency_1", jsonData.get("f_amount_currency_1"));
         userParameter.put("f_applicant_dept_name", jsonData.get("f_applicant_dept_name"));
         userParameter.put("f_applicant_name", jsonData.get("f_applicant_name"));
         userParameter.put("f_applicant_number", jsonData.get("f_applicant_number"));
         userParameter.put("f_applicant_pos_name", jsonData.get("f_applicant_pos_name"));
         userParameter.put("f_application_date", jsonData.get("f_application_date"));
         userParameter.put("f_application_number", jsonData.get("f_application_number"));
         userParameter.put("f_asset_number", jsonData.get("f_asset_number"));
         userParameter.put("f_auto_extension", jsonData.get("f_auto_extension"));
         userParameter.put("f_book_value", jsonData.get("f_book_value"));
         userParameter.put("f_budget_impact_month", jsonData.get("f_budget_impact_month"));
         userParameter.put("f_budget_impact_to_fy", jsonData.get("f_budget_impact_to_fy"));
         userParameter.put("f_deprec_amount_per_month", jsonData.get("f_deprec_amount_per_month"));
         userParameter.put("f_ec_approval_is_required", jsonData.get("f_ec_approval_is_required"));
         userParameter.put("f_ec_approval_yes", jsonData.get("f_ec_approval_yes"));
         userParameter.put("f_effective_from", jsonData.get("f_effective_from"));
         userParameter.put("f_effective_to", jsonData.get("f_effective_to"));
         userParameter.put("f_es_amount_1", jsonData.get("f_es_amount_1"));
         userParameter.put("f_es_date_1", jsonData.get("f_es_date_1"));
         userParameter.put("f_es_total_amount", jsonData.get("f_es_total_amount"));
         userParameter.put("f_estimated_delivery_from", jsonData.get("f_estimated_delivery_from"));
         userParameter.put("f_estimated_delivery_to", jsonData.get("f_estimated_delivery_to"));
         userParameter.put("f_pl_impact_month", jsonData.get("f_pl_impact_month"));
         userParameter.put("f_pl_impact_to_fy", jsonData.get("f_pl_impact_to_fy"));
         userParameter.put("f_purchase_category", jsonData.get("f_purchase_category"));
         userParameter.put("f_purchase_order_req", jsonData.get("f_purchase_order_req"));
         userParameter.put("f_related_company", jsonData.get("f_related_company"));
         userParameter.put("f_renewal", jsonData.get("f_renewal"));
         userParameter.put("f_start_usage_date", jsonData.get("f_start_usage_date"));
         userParameter.put("f_title", jsonData.get("f_title"));
         userParameter.put("f_total_amount", jsonData.get("f_total_amount"));
         userParameter.put("f_upload_file_id", jsonData.get("f_upload_file_id"));
         userParameter.put("f_upload_file_name", jsonData.get("f_upload_file_name"));
         userParameter.put("f_upload_file_real_name", jsonData.get("f_upload_file_real_name"));
         userParameter.put("f_upload_file_size", jsonData.get("f_upload_file_size"));
         userParameter.put("f_upload_file_type", jsonData.get("f_upload_file_type"));
         userParameter.put("f_vendor", jsonData.get("f_vendor"));
         userParameter.put("upload_file", jsonData.get("upload_file"));

			ApplyManager applyManager = new ApplyManager();
			applyManager.apply(applyParam, userParameter);

            response.put("success", true);
            response.put("message", "Application completed successfully.");
        } catch (Exception e) {
        	System.out.println("FAILESS POST API");
            response.put("success", false);
            e.printStackTrace();
            response.put("error", "ERRORR");
        }

        return response;
    }
}