package wf.training_maisaka.general.domain.model;

public class EstSchedulePaymentModel {
	private String id;
	private String system_matter_id;
	private String user_data_id;
	private String payment_amount;
	private String payment_date;
	
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
	public String getPayment_amount() {
		return payment_amount;
	}
	public void setPayment_amount(String payment_amount) {
		this.payment_amount = payment_amount;
	}
	public String getPayment_date() {
		return payment_date;
	}
	public void setPayment_date(String payment_date) {
		this.payment_date = payment_date;
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
