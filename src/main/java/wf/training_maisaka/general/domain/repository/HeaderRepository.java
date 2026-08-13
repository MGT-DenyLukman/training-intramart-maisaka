package wf.training_maisaka.general.domain.repository;

import jp.co.intra_mart.foundation.database.SQLManager;
import jp.co.intra_mart.foundation.database.ColumnValues;
import jp.co.intra_mart.foundation.database.SearchCondition;

import org.joda.time.LocalDateTime;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.Collection;

import wf.training_maisaka.general.domain.model.HeaderModel;

public class HeaderRepository {

	private String table_name = "wf_header";
	private String select_data_all = "select * from wf_header";
	private String select_data_by_matter_id = "select * from wf_header where system_matter_id = ?";

	public void insertData(HeaderModel varHeaderData) throws Exception {
		SQLManager sqlManager = new SQLManager();
		ColumnValues columnVal = this.setData(varHeaderData, "create");
		
		sqlManager.insert(table_name, columnVal);
		
	}
	
	public void updateData(HeaderModel varHeaderData) throws Exception {
		SQLManager sqlManager = new SQLManager();
		ColumnValues columnVal = this.setData(varHeaderData, "update");
		SearchCondition searchCondition = new SearchCondition();
		
		searchCondition.addCondition("system_matter_id", varHeaderData.getSystem_matter_id());
		
		sqlManager.update(table_name, columnVal, searchCondition);
	}
	
	public Collection<HeaderModel> selectData(String column, String value) throws Exception {
		SQLManager sqlManager = new SQLManager();
		ArrayList<Object> parameters = new ArrayList<>();
		
		String sql_query = this.select_data_all;
		if("system_matter_id".equals(column)) {
			sql_query = this.select_data_by_matter_id;
			parameters.add(value);
		}
		
		Collection<HeaderModel> result =  sqlManager.select(HeaderModel.class, sql_query, parameters);
		return result;
		
	}

	private	ColumnValues setData(HeaderModel varHeaderData, String condition) {
		ColumnValues result = new ColumnValues();
		
		LocalDateTime now = LocalDateTime.now();
		Timestamp timestamp = Timestamp.valueOf(now.toString("yyyy-MM-dd HH:mm:ss"));
		
		result.add("system_matter_id", varHeaderData.getSystem_matter_id());
		result.add("user_data_id", varHeaderData.getUser_data_id());

		result.add("status", varHeaderData.getStatus());
		result.add("mail_status", varHeaderData.getMail_status());
		

		if("create".equals(condition)){
			result.add("created_at", timestamp);
		}

		result.add("updated_at", timestamp);
		
		return result;
	}
}
