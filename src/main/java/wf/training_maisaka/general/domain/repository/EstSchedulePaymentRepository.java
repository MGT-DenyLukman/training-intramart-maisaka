package wf.training_maisaka.general.domain.repository;

import jp.co.intra_mart.foundation.database.SQLManager;
import jp.co.intra_mart.foundation.database.ColumnValues;
import jp.co.intra_mart.foundation.database.SearchCondition;

import org.joda.time.LocalDateTime;
import java.sql.Timestamp;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.Collection;
import java.util.ArrayList;


import wf.training_maisaka.general.domain.model.EstSchedulePaymentModel;
import wf.training_maisaka.general.domain.service.WorkflowService;;

public class EstSchedulePaymentRepository {
	private String table_name = "wf_agreement_est_schedule";
	private String select_data_by_matter_id = "select * from " + table_name + " where system_matter_id = ?";
	private String select_data_all = "select * from " + table_name ;
	
	public void insertData(EstSchedulePaymentModel varEstSchedulePayData) throws Exception {
		SQLManager sqlManager = new SQLManager();
		ColumnValues columnVal = this.setData(varEstSchedulePayData, "create");
		
		sqlManager.insert(table_name, columnVal);
	}
	
	public void deleteData(String column, String value) throws Exception {
		SQLManager sqlManager = new SQLManager();
		ArrayList<Object> parameters = new ArrayList<>();
		
		String sql = "delete from " + table_name + " where " + column + " = ?";
		parameters.add(value);
		sqlManager.delete(sql, parameters);
		
	}


	private	ColumnValues setData(EstSchedulePaymentModel varEstSchedulePayData, String condition) {
		WorkflowService service = new WorkflowService();
		ColumnValues result = new ColumnValues();
		service.debug("varEstSchedulePayData", varEstSchedulePayData);

		 	try {
		
				 SimpleDateFormat SDF = new SimpleDateFormat("yyyy/MM/dd");
				Date paymentDate = SDF.parse(varEstSchedulePayData.getPayment_date().replaceAll("-", "/"));
		
				LocalDateTime now = LocalDateTime.now();
				Timestamp timestamp = Timestamp.valueOf(now.toString("yyyy-MM-dd HH:mm:ss"));
				
				result.add("system_matter_id", varEstSchedulePayData.getSystem_matter_id());
				result.add("user_data_id", varEstSchedulePayData.getUser_data_id());
				
				result.add("payment_amount", varEstSchedulePayData.getPayment_amount());
				result.add("payment_date", paymentDate);

				if("create".equals(condition)){
					result.add("created_at", timestamp);
				}

				result.add("updated_at", timestamp);
		
			} catch (Exception e) {
				// TODO 自動生成された catch ブロック
				e.printStackTrace();
			}
		return result;
	}

	public Collection<EstSchedulePaymentModel> selectData(String column, String value) throws Exception {
		SQLManager sqlManager = new SQLManager();
		ArrayList<Object> parameters = new ArrayList<>();
		
		String sql = this.select_data_all;
		if("system_matter_id".equals(column)){
			sql = this.select_data_by_matter_id;
			parameters.add(value);
		}
		
		Collection<EstSchedulePaymentModel> result = sqlManager.select(EstSchedulePaymentModel.class, sql, parameters);
		return result;
	}

}
