package wf.training_maisaka.general.domain.job;

import java.util.Collection;

import jp.co.intra_mart.foundation.job_scheduler.Job;
import jp.co.intra_mart.foundation.job_scheduler.JobResult;
import jp.co.intra_mart.foundation.job_scheduler.exception.JobExecuteException;

import wf.training_maisaka.general.domain.repository.HeaderRepository;
import wf.training_maisaka.general.domain.repository.HeaderInfoRepository;
import wf.training_maisaka.general.domain.repository.AttachFileRepository;

import wf.training_maisaka.general.domain.model.HeaderModel;
import wf.training_maisaka.general.domain.model.HeaderInfoModel;
import wf.training_maisaka.general.domain.model.AttachFileModel;

import wf.training_maisaka.general.domain.service.WorkflowService;
import wf.training_maisaka.general.domain.service.EmailService;

public class EmailJob implements Job{
	public JobResult execute() throws JobExecuteException {
		try {
			WorkflowService service = new WorkflowService();

			HeaderRepository headerDB = new HeaderRepository();
			HeaderInfoRepository headerInfoDB = new HeaderInfoRepository();
			AttachFileRepository attachFileDB = new AttachFileRepository();
			
			//String mail_status = "1";

			//Collection<HeaderModel> entityHeader = headerDB.selectData("mail_status", mail_status);
			Collection<HeaderModel> entityHeader = headerDB.selectData("system_matter_id", "ma_8i4aic8v3c1q3lf");
			
			for(HeaderModel item : entityHeader) {
				HeaderInfoModel entityHeaderInfo = headerInfoDB.selectData("system_matter_id", item.getSystem_matter_id()).iterator().next();
				
				Collection<AttachFileModel> entityAttachment = attachFileDB.selectData("system_matter_id", item.getSystem_matter_id());
				
				EmailService emailService = new EmailService();
				String matterId = item.getSystem_matter_id();
				String mailAddress = "dummytest@gmail.com";
				HeaderInfoModel headerInfo = entityHeaderInfo;
				emailService.sendEmail(matterId, mailAddress, headerInfo, entityAttachment);
				
			}
			
			System.out.println("-------- RUNNING JOB EMAIL SUCCESS  -----------");
			
			
		}catch(Exception e) {
			e.printStackTrace();
			throw new JobExecuteException("Error during job execution ", e);
		}
		return JobResult.success("success");
	}

}
