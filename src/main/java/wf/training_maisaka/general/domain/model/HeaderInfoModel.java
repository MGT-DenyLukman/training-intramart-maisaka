package wf.training_maisaka.general.domain.model;

public class HeaderInfoModel {
	private String id;
	private String system_matter_id;
	private String user_data_id;
	
	private String application_number;
	private String application_date;
	private String applicant_number;
	private String applicant_name;
	private String applicant_department_name;
	private String applicant_position_name;
	
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
	public String getApplication_number() {
		return application_number;
	}
	public void setApplication_number(String application_number) {
		this.application_number = application_number;
	}
	public String getApplication_date() {
		return application_date;
	}
	public void setApplication_date(String application_date) {
		this.application_date = application_date;
	}
	public String getApplicant_number() {
		return applicant_number;
	}
	public void setApplicant_number(String applicant_number) {
		this.applicant_number = applicant_number;
	}
	public String getApplicant_name() {
		return applicant_name;
	}
	public void setApplicant_name(String applicant_name) {
		this.applicant_name = applicant_name;
	}
	public String getApplicant_department_name() {
		return applicant_department_name;
	}
	public void setApplicant_department_name(String applicant_department_name) {
		this.applicant_department_name = applicant_department_name;
	}
	public String getApplicant_position_name() {
		return applicant_position_name;
	}
	public void setApplicant_position_name(String applicant_position_name) {
		this.applicant_position_name = applicant_position_name;
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
