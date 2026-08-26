package wf.training_maisaka.general.domain.model;

public class AgreementDetailModel {

	private String id;
	private String system_matter_id;
	private String user_data_id;

	private String counter_party ;
	private String currency ;
	private String total_amount_no_tax ;
	private String agreement_status ;
	private String is_auto_extension ;
	private String purchase_order_req ;
	private String title_in_agreement ;
	private String effective_date_from ;
	private String effective_date_to ;
	private String is_related_comp ;
	private String delivery_date_from ;
	private String delivery_date_to ;
	private String agreement_summary ;
	private String purchase_category ;
	private String starting_usage_date ;
	private String deprec_amount_per_month ;
	
	private String agreement_classification;
	private String ec_approval_is_req;
	
	private String is_psd_area;
	private String psd_or_dic;
	private String dic_reason;
	
	private String is_dd_req;
	private String is_anti_bribery;
	private String is_audit_right;
	
	private String agreement_number;
	private String agreement_date;
	
	
	private String created_at;
	private String updated_at;

	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getSystem_matter_id() {
		return system_matter_id;
	}
	public void setSystem_matter_id(String system_matter_id) {
		this.system_matter_id = system_matter_id;
	}
	public String getUser_data_id() {
		return user_data_id;
	}
	public void setUser_data_id(String user_data_id) {
		this.user_data_id = user_data_id;
	}
	public String getCounter_party() {
		return counter_party;
	}
	public void setCounter_party(String counter_party) {
		this.counter_party = counter_party;
	}
	public String getCurrency() {
		return currency;
	}
	public void setCurrency(String currency) {
		this.currency = currency;
	}
	public String getTotal_amount_no_tax() {
		return total_amount_no_tax;
	}
	public void setTotal_amount_no_tax(String total_amount_no_tax) {
		this.total_amount_no_tax = total_amount_no_tax;
	}
	public String getAgreement_status() {
		return agreement_status;
	}
	public void setAgreement_status(String agreement_status) {
		this.agreement_status = agreement_status;
	}
	public String getIs_auto_extension() {
		return is_auto_extension;
	}
	public void setIs_auto_extension(String is_auto_extension) {
		this.is_auto_extension = is_auto_extension;
	}
	public String getPurchase_order_req() {
		return purchase_order_req;
	}
	public void setPurchase_order_req(String purchase_order_req) {
		this.purchase_order_req = purchase_order_req;
	}
	public String getTitle_in_agreement() {
		return title_in_agreement;
	}
	public void setTitle_in_agreement(String title_in_agreement) {
		this.title_in_agreement = title_in_agreement;
	}
	public String getEffective_date_from() {
		return effective_date_from;
	}
	public void setEffective_date_from(String effective_date_from) {
		this.effective_date_from = effective_date_from;
	}
	public String getEffective_date_to() {
		return effective_date_to;
	}
	public void setEffective_date_to(String effective_date_to) {
		this.effective_date_to = effective_date_to;
	}
	public String getIs_related_comp() {
		return is_related_comp;
	}
	public void setIs_related_comp(String is_related_comp) {
		this.is_related_comp = is_related_comp;
	}
	public String getDelivery_date_from() {
		return delivery_date_from;
	}
	public void setDelivery_date_from(String delivery_date_from) {
		this.delivery_date_from = delivery_date_from;
	}
	public String getDelivery_date_to() {
		return delivery_date_to;
	}
	public void setDelivery_date_to(String delivery_date_to) {
		this.delivery_date_to = delivery_date_to;
	}
	public String getAgreement_summary() {
		return agreement_summary;
	}
	public void setAgreement_summary(String agreement_summary) {
		this.agreement_summary = agreement_summary;
	}
	public String getPurchase_category() {
		return purchase_category;
	}
	public void setPurchase_category(String purchase_category) {
		this.purchase_category = purchase_category;
	}
	public String getStarting_usage_date() {
		return starting_usage_date;
	}
	public void setStarting_usage_date(String starting_usage_date) {
		this.starting_usage_date = starting_usage_date;
	}
	public String getDeprec_amount_per_month() {
		return deprec_amount_per_month;
	}
	public void setDeprec_amount_per_month(String deprec_amount_per_month) {
		this.deprec_amount_per_month = deprec_amount_per_month;
	}
	public String getAgreement_classification() {
		return agreement_classification;
	}
	public void setAgreement_classification(String agreement_classification) {
		this.agreement_classification = agreement_classification;
	}
	public String getEc_approval_is_req() {
		return ec_approval_is_req;
	}
	public void setEc_approval_is_req(String ec_approval_is_req) {
		this.ec_approval_is_req = ec_approval_is_req;
	}
	public String getIs_psd_area() {
		return is_psd_area;
	}
	public void setIs_psd_area(String is_psd_area) {
		this.is_psd_area = is_psd_area;
	}
	public String getPsd_or_dic() {
		return psd_or_dic;
	}
	public void setPsd_or_dic(String psd_or_dic) {
		this.psd_or_dic = psd_or_dic;
	}
	public String getDic_reason() {
		return dic_reason;
	}
	public void setDic_reason(String dic_reason) {
		this.dic_reason = dic_reason;
	}
	public String getIs_dd_req() {
		return is_dd_req;
	}
	public void setIs_dd_req(String is_dd_req) {
		this.is_dd_req = is_dd_req;
	}
	public String getIs_anti_bribery() {
		return is_anti_bribery;
	}
	public void setIs_anti_bribery(String is_anti_bribery) {
		this.is_anti_bribery = is_anti_bribery;
	}
	public String getIs_audit_right() {
		return is_audit_right;
	}
	public void setIs_audit_right(String is_audit_right) {
		this.is_audit_right = is_audit_right;
	}
	public String getAgreement_number() {
		return agreement_number;
	}
	public void setAgreement_number(String agreement_number) {
		this.agreement_number = agreement_number;
	}
	public String getAgreement_date() {
		return agreement_date;
	}
	public void setAgreement_date(String agreement_date) {
		this.agreement_date = agreement_date;
	}
	public String getCreated_at() {
		return created_at;
	}
	public void setCreated_at(String created_at) {
		this.created_at = created_at;
	}
	public String getUpdated_at() {
		return updated_at;
	}
	public void setUpdated_at(String updated_at) {
		this.updated_at = updated_at;
	}
}
