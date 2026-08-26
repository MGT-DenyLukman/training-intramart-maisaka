package wf.training_maisaka.general.app;


import java.util.Collection;



//import wf.training_maisaka.general.domain.model.DetailTableModel;
//import wf.path_test.general.domain.model.AttachmentModel;
import wf.training_maisaka.general.domain.model.EstSchedulePaymentModel;
import wf.training_maisaka.general.domain.model.AttachFileModel;

public class ImartForm extends ImartWorkflowForm {
	private String f_id;
	private String f_system_matter_id;
	private String f_user_data_id;
	
	private String f_application_number;
	private String f_application_date;
	private String f_applicant_number;
	private String f_applicant_dept_name;
	private String f_applicant_name;
	private String f_applicant_pos_name;

	private String f_counter_party ;
	private String f_currency ;
	private String f_total_amount_no_tax ;
	private String f_agreement_status ;
	private String f_is_auto_extension ;
	private String f_purchase_order_req ;
	private String f_title_in_agreement ;
	private String f_effective_date_from ;
	private String f_effective_date_to ;
	private String f_is_related_comp ;
	private String f_delivery_date_from ;
	private String f_delivery_date_to ;
	private String f_agreement_summary ;
	private String f_purchase_category ;
	private String f_starting_usage_date ;
	private String f_deprec_amount_per_month ;
	
	// multiple data
	
	private String f_budget_pl_impact;
	private String f_budget_pl_month;
	private String f_pl_impact;
	private String f_pl_month;
	
	private String f_asset_number;
	private String f_book_value;
	
	private Collection<EstSchedulePaymentModel> d_estimated_schedule_payment;
	
	private Collection<AttachFileModel> d_file_attachment;
	
	
	//multiple branch
	private String f_agreement_classification;
	private String f_ec_approval_is_req;
	
	
	//multiple user
	private String f_psd_area_bog;
	private String f_psd_process;
	private String f_dic_reason;
	
	private String f_dd_process;
	private String f_anti_bribery;
	private String f_audit_right;
	
	private String f_agreement_number;
	private String f_agreement_date;
	
	
	
	public String getF_application_number() {
		return f_application_number;
	}
	public void setF_application_number(String f_application_number) {
		this.f_application_number = f_application_number;
	}
	public String getF_application_date() {
		return f_application_date;
	}
	public void setF_application_date(String f_application_date) {
		this.f_application_date = f_application_date;
	}
	public String getF_applicant_number() {
		return f_applicant_number;
	}
	public void setF_applicant_number(String f_applicant_number) {
		this.f_applicant_number = f_applicant_number;
	}
	public String getF_applicant_dept_name() {
		return f_applicant_dept_name;
	}
	public void setF_applicant_dept_name(String f_applicant_dept_name) {
		this.f_applicant_dept_name = f_applicant_dept_name;
	}
	public String getF_applicant_name() {
		return f_applicant_name;
	}
	public void setF_applicant_name(String f_applicant_name) {
		this.f_applicant_name = f_applicant_name;
	}
	public String getF_applicant_pos_name() {
		return f_applicant_pos_name;
	}
	public void setF_applicant_pos_name(String f_applicant_pos_name) {
		this.f_applicant_pos_name = f_applicant_pos_name;
	}

	

	public String getF_id() {
		return f_id;
	}
	public void setF_id(String f_id) {
		this.f_id = f_id;
	}
	public String getF_system_matter_id() {
		return f_system_matter_id;
	}
	public void setF_system_matter_id(String f_system_matter_id) {
		this.f_system_matter_id = f_system_matter_id;
	}
	public String getF_user_data_id() {
		return f_user_data_id;
	}
	public void setF_user_data_id(String f_user_data_id) {
		this.f_user_data_id = f_user_data_id;
	}
	public String getF_counter_party() {
		return f_counter_party;
	}
	public void setF_counter_party(String f_counter_party) {
		this.f_counter_party = f_counter_party;
	}
	public String getF_currency() {
		return f_currency;
	}
	public void setF_currency(String f_currency) {
		this.f_currency = f_currency;
	}
	public String getF_total_amount_no_tax() {
		return f_total_amount_no_tax;
	}
	public void setF_total_amount_no_tax(String f_total_amount_no_tax) {
		this.f_total_amount_no_tax = f_total_amount_no_tax;
	}
	public String getF_agreement_status() {
		return f_agreement_status;
	}
	public void setF_agreement_status(String f_agreement_status) {
		this.f_agreement_status = f_agreement_status;
	}
	public String getF_is_auto_extension() {
		return f_is_auto_extension;
	}
	public void setF_is_auto_extension(String f_is_auto_extension) {
		this.f_is_auto_extension = f_is_auto_extension;
	}
	public String getF_purchase_order_req() {
		return f_purchase_order_req;
	}
	public void setF_purchase_order_req(String f_purchase_order_req) {
		this.f_purchase_order_req = f_purchase_order_req;
	}
	public String getF_title_in_agreement() {
		return f_title_in_agreement;
	}
	public void setF_title_in_agreement(String f_title_in_agreement) {
		this.f_title_in_agreement = f_title_in_agreement;
	}
	public String getF_effective_date_from() {
		return f_effective_date_from;
	}
	public void setF_effective_date_from(String f_effective_date_from) {
		this.f_effective_date_from = f_effective_date_from;
	}
	public String getF_effective_date_to() {
		return f_effective_date_to;
	}
	public void setF_effective_date_to(String f_effective_date_to) {
		this.f_effective_date_to = f_effective_date_to;
	}
	public String getF_is_related_comp() {
		return f_is_related_comp;
	}
	public void setF_is_related_comp(String f_is_related_comp) {
		this.f_is_related_comp = f_is_related_comp;
	}
	public String getF_delivery_date_from() {
		return f_delivery_date_from;
	}
	public void setF_delivery_date_from(String f_delivery_date_from) {
		this.f_delivery_date_from = f_delivery_date_from;
	}
	public String getF_delivery_date_to() {
		return f_delivery_date_to;
	}
	public void setF_delivery_date_to(String f_delivery_date_to) {
		this.f_delivery_date_to = f_delivery_date_to;
	}
	public String getF_agreement_summary() {
		return f_agreement_summary;
	}
	public void setF_agreement_summary(String f_agreement_summary) {
		this.f_agreement_summary = f_agreement_summary;
	}
	public String getF_purchase_category() {
		return f_purchase_category;
	}
	public void setF_purchase_category(String f_purchase_category) {
		this.f_purchase_category = f_purchase_category;
	}
	public String getF_starting_usage_date() {
		return f_starting_usage_date;
	}
	public void setF_starting_usage_date(String f_starting_usage_date) {
		this.f_starting_usage_date = f_starting_usage_date;
	}
	public String getF_deprec_amount_per_month() {
		return f_deprec_amount_per_month;
	}
	public void setF_deprec_amount_per_month(String f_deprec_amount_per_month) {
		this.f_deprec_amount_per_month = f_deprec_amount_per_month;
	}
	
	
	//multiple data
	public String getF_budget_pl_impact() {
		return f_budget_pl_impact;
	}
	public void setF_budget_pl_impact(String f_budget_pl_impact) {
		this.f_budget_pl_impact = f_budget_pl_impact;
	}
	public String getF_budget_pl_month() {
		return f_budget_pl_month;
	}
	public void setF_budget_pl_month(String f_budget_pl_month) {
		this.f_budget_pl_month = f_budget_pl_month;
	}
	public String getF_pl_impact() {
		return f_pl_impact;
	}
	public void setF_pl_impact(String f_pl_impact) {
		this.f_pl_impact = f_pl_impact;
	}
	public String getF_pl_month() {
		return f_pl_month;
	}
	public void setF_pl_month(String f_pl_month) {
		this.f_pl_month = f_pl_month;
	}
	
	
	
	public String getF_asset_number() {
		return f_asset_number;
	}
	public void setF_asset_number(String f_asset_number) {
		this.f_asset_number = f_asset_number;
	}
	public String getF_book_value() {
		return f_book_value;
	}
	public void setF_book_value(String f_book_value) {
		this.f_book_value = f_book_value;
	}
	public Collection<EstSchedulePaymentModel> getD_estimated_schedule_payment() {
		return d_estimated_schedule_payment;
	}
	public void setD_estimated_schedule_payment(Collection<EstSchedulePaymentModel> d_estimated_schedule_payment) {
		this.d_estimated_schedule_payment = d_estimated_schedule_payment;
	}
	public Collection<AttachFileModel> getD_file_attachment() {
		return d_file_attachment;
	}
	public void setD_file_attachment(Collection<AttachFileModel> d_file_attachment) {
		this.d_file_attachment = d_file_attachment;
	}
	public String getF_agreement_classification() {
		return f_agreement_classification;
	}
	public void setF_agreement_classification(String f_agreement_classification) {
		this.f_agreement_classification = f_agreement_classification;
	}
	public String getF_ec_approval_is_req() {
		return f_ec_approval_is_req;
	}
	public void setF_ec_approval_is_req(String f_ec_approval_is_req) {
		this.f_ec_approval_is_req = f_ec_approval_is_req;
	}
	public String getF_psd_area_bog() {
		return f_psd_area_bog;
	}
	public void setF_psd_area_bog(String f_psd_area_bog) {
		this.f_psd_area_bog = f_psd_area_bog;
	}
	public String getF_psd_process() {
		return f_psd_process;
	}
	public void setF_psd_process(String f_psd_process) {
		this.f_psd_process = f_psd_process;
	}
	public String getF_dic_reason() {
		return f_dic_reason;
	}
	public void setF_dic_reason(String f_dic_reason) {
		this.f_dic_reason = f_dic_reason;
	}
	public String getF_dd_process() {
		return f_dd_process;
	}
	public void setF_dd_process(String f_dd_process) {
		this.f_dd_process = f_dd_process;
	}
	public String getF_anti_bribery() {
		return f_anti_bribery;
	}
	public void setF_anti_bribery(String f_anti_bribery) {
		this.f_anti_bribery = f_anti_bribery;
	}
	public String getF_audit_right() {
		return f_audit_right;
	}
	public void setF_audit_right(String f_audit_right) {
		this.f_audit_right = f_audit_right;
	}
	public String getF_agreement_number() {
		return f_agreement_number;
	}
	public void setF_agreement_number(String f_agreement_number) {
		this.f_agreement_number = f_agreement_number;
	}
	public String getF_agreement_date() {
		return f_agreement_date;
	}
	public void setF_agreement_date(String f_agreement_date) {
		this.f_agreement_date = f_agreement_date;
	}


}


