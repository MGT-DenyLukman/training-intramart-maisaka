package wf.training_maisaka.general.domain.service;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import jp.co.intra_mart.foundation.workflow.plugin.process.matter_end.MatterEndProcessParameter;

import wf.training_maisaka.general.MatterEndProcessService;
import wf.training_maisaka.general.domain.repository.HeaderRepository;
import wf.training_maisaka.general.domain.repository.AgreementDetailTempRepository;
import wf.training_maisaka.general.domain.repository.AgreementDetailRepository;

import java.util.Collection;

import wf.training_maisaka.general.domain.model.HeaderModel;
import wf.training_maisaka.general.domain.model.AgreementDetailModel;
import wf.training_maisaka.general.domain.service.WorkflowService;

@Service("end_service_training_maisaka")
@Transactional(propagation = Propagation.MANDATORY)
public class MatterEndProcessServiceImpl implements MatterEndProcessService {
	
	public boolean execute(final MatterEndProcessParameter parameter) throws Exception {
		System.out.println("MATTER END PROCESS EXECUTE");
		WorkflowService service = new WorkflowService();
		
		HeaderRepository headerDB = new HeaderRepository();
		AgreementDetailRepository agreementDetailDB = new AgreementDetailRepository();
		
		HeaderModel entity_Header = getEntity_Header(parameter.getSystemMatterId());
		AgreementDetailModel entity_Agreement = getEntity_AgreementDetail(parameter.getSystemMatterId());
		service.debug("ENTITY AGREEMENT MATTER END PROCESS", entity_Agreement);
		
		service.debug("parameter matter end", parameter);

		if("mattercomplete".equals(parameter.getLastResultStatus())) {
			entity_Header.setStatus("2");
			entity_Header.setMail_status("1");
			
			
			agreementDetailDB.insertData(entity_Agreement);
			headerDB.updateData(entity_Header);

			service.debug("matter complete", entity_Header);
			return true;
			
		}else if("deny".equals(parameter.getLastResultStatus())) {
			entity_Header.setStatus("99");
			headerDB.updateData(entity_Header);
			
			service.debug("matter complete", entity_Header);
			return true;
		}

		return false;
	}
	
	public HeaderModel getEntity_Header(String system_matter_id) throws Exception {
		HeaderRepository headerDB = new HeaderRepository();
		Collection<HeaderModel> listHeader = headerDB.selectData("system_matter_id", system_matter_id);
		HeaderModel result = listHeader.iterator().next();
		
		return result;
	}

	 private AgreementDetailModel getEntity_AgreementDetail(String system_matter_id) throws Exception {
		 AgreementDetailTempRepository agreementDetailTempDB = new AgreementDetailTempRepository();
		Collection<AgreementDetailModel> listAgreement = agreementDetailTempDB .selectData("system_matter_id", system_matter_id);
		AgreementDetailModel result = listAgreement.iterator().next();
		 	
		 return result;
	 }


}
