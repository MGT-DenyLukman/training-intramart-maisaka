package wf.training_maisaka.general.domain.repository;

import jp.co.intra_mart.foundation.database.SQLManager;
import jp.co.intra_mart.foundation.database.ColumnValues;
import jp.co.intra_mart.foundation.database.SearchCondition;

import java.text.SimpleDateFormat;
import java.util.Date;

import org.joda.time.LocalDateTime;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.Collection;

import wf.training_maisaka.general.domain.model.HeaderInfoModel;

public class HeaderInfoRepository {

	private String table_name = "wf_header_info_application";
	private String select_data_all = "select * from wf_header_info_application";
	private String select_data_by_matter_id = "select * from wf_header_info_application where system_matter_id = ?";

	public void insertData(HeaderInfoModel varHeaderData) throws Exception {
		SQLManager sqlManager = new SQLManager();
		ColumnValues columnVal = this.setData(varHeaderData, "create");
		
		sqlManager.insert(table_name, columnVal);
		
	}
	
	public void updateData(HeaderInfoModel varHeaderData) throws Exception {
		SQLManager sqlManager = new SQLManager();
		ColumnValues columnVal = this.setData(varHeaderData, "update");
		SearchCondition searchCondition = new SearchCondition();
		
		searchCondition.addCondition("system_matter_id", varHeaderData.getSystem_matter_id());
		
		sqlManager.update(table_name, columnVal, searchCondition);
	}
	
	public Collection<HeaderInfoModel> selectData(String column, String value) throws Exception {
		SQLManager sqlManager = new SQLManager();
		ArrayList<Object> parameters = new ArrayList<>();
		
		String sql_query = this.select_data_all;
		if("system_matter_id".equals(column)) {
			sql_query = this.select_data_by_matter_id;
			parameters.add(value);
		}
		
		Collection<HeaderInfoModel> result =  sqlManager.select(HeaderInfoModel.class, sql_query, parameters);
		return result;
		
	}

	private	ColumnValues setData(HeaderInfoModel varHeaderData, String condition) {
		ColumnValues result = new ColumnValues();

		try {
				
			 SimpleDateFormat SDF = new SimpleDateFormat("yyyy/MM/dd");
			Date applicationDate = SDF.parse(varHeaderData.getApplication_date().replaceAll("-", "/"));
			
			LocalDateTime now = LocalDateTime.now();
			Timestamp timestamp = Timestamp.valueOf(now.toString("yyyy-MM-dd HH:mm:ss"));
			
			result.add("system_matter_id", varHeaderData.getSystem_matter_id());
			result.add("user_data_id", varHeaderData.getUser_data_id());

			result.add("application_number", varHeaderData.getApplication_number());
			result.add("application_date", applicationDate);
			result.add("applicant_number", varHeaderData.getApplicant_number());
			result.add("applicant_name", varHeaderData.getApplicant_name());
			result.add("applicant_department_name", varHeaderData.getApplicant_department_name());
			result.add("applicant_position_name", varHeaderData.getApplicant_position_name());
			

			if("create".equals(condition)){
				result.add("created_at", timestamp);
			}

			result.add("updated_at", timestamp);
		}catch(Exception e) {
			e.printStackTrace();
		}
		
		return result;
	}

	/*
	public HeaderInfoModel getMaxId() throws Exception {
		SQLManager sqlManager = new SQLManager();
		ArrayList<Object> parameters = new ArrayList<>();
		
		String sql_query = "select max(id) as id from " + this.table_name;
		
		Collection<HeaderInfoModel> result =  sqlManager.select(HeaderInfoModel.class, sql_query, parameters);
		return result.iterator().next();
		
	}
	*/
}
