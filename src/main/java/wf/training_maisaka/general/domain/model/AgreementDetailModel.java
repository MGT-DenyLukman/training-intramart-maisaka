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
