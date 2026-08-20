package wf.training_maisaka.general.domain.repository;

import jp.co.intra_mart.foundation.database.SQLManager;
import jp.co.intra_mart.foundation.database.ColumnValues;
import jp.co.intra_mart.foundation.database.SearchCondition;

import java.util.Collection;
import java.util.Date;
import java.util.ArrayList;

import java.text.SimpleDateFormat;

import org.joda.time.LocalDateTime;
import java.sql.Timestamp;


import wf.training_maisaka.general.domain.model.AttachFileModel;

public class AttachFileRepository {
	private String table_name = "wf_attach_file";
	private String select_data_all = "select * from wf_attach_file";
	private String select_data_by_matter_id = "select * from wf_attach_file where system_matter_id = ?";

	public void insertData(AttachFileModel varFileData) throws Exception {
		SQLManager sqlManager = new SQLManager();
		ColumnValues columnVal = this.setData(varFileData, "create");
		
		sqlManager.insert(table_name, columnVal);
		
	}

	public void deleteData(String column, String value) throws Exception {
		SQLManager sqlManager = new SQLManager();
		ArrayList<Object> parameters = new ArrayList<>();
		
		String sql = "delete from " + table_name + " where " + column + " = ?";
		parameters.add(value);
		sqlManager.delete(sql, parameters);
		
	}
	
	public void updateData(AttachFileModel varFileData) throws Exception {
		SQLManager sqlManager = new SQLManager();
		ColumnValues columnVal = this.setData(varFileData, "update");
		SearchCondition searchCondition = new SearchCondition();
	
		searchCondition.addCondition("system_matter_id", varFileData.getSystem_matter_id());
		
		sqlManager.update(table_name, columnVal, searchCondition);
	}
	
	public Collection<AttachFileModel> selectData(String column, String value) throws Exception {
		SQLManager sqlManager = new SQLManager();
		ArrayList<Object> parameters = new ArrayList<>();
		
		String sql_query = this.select_data_all;
		if(!column.isEmpty() || column != null) {
			sql_query = "select * from " + table_name + " where " + column + " = ?";
			parameters.add(value);
		}		
		Collection<AttachFileModel> result =  sqlManager.select(AttachFileModel.class, sql_query, parameters);
		return result;
		
	}

	private	ColumnValues setData(AttachFileModel varFileData, String condition) {
		ColumnValues result = new ColumnValues();

		try {
			
			LocalDateTime now = LocalDateTime.now();
			Timestamp timestamp = Timestamp.valueOf(now.toString("yyyy-MM-dd HH:mm:ss"));
			
			result.add("system_matter_id", varFileData.getSystem_matter_id());
			result.add("user_data_id", varFileData.getUser_data_id());

			result.add("file_name", varFileData.getFile_name());
			result.add("file_real_name", varFileData.getFile_real_name());
			result.add("file_path", varFileData.getFile_path());
			result.add("file_type", varFileData.getFile_type());
			result.add("file_size", Integer.parseInt(varFileData.getFile_size()));
			

			if("create".equals(condition)){
				result.add("created_at", timestamp);
			}

			result.add("updated_at", timestamp);
		}catch(Exception e) {
			e.printStackTrace();
		}
		
		return result;
	}

}
