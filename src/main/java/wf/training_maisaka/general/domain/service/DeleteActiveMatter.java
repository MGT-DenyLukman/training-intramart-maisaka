package wf.training_maisaka.general.domain.service;

import jp.co.intra_mart.foundation.workflow.exception.WorkflowException;
import jp.co.intra_mart.foundation.workflow.listener.IWorkflowActvMatterDeleteListener;

import wf.training_maisaka.general.domain.repository.HeaderRepository;
import wf.training_maisaka.general.domain.model.HeaderModel;

public class DeleteActiveMatter implements IWorkflowActvMatterDeleteListener{

	@Override
	public void execute(final String loginGroupId, final String localeId, final String systemMatterId, final String userDataId) throws WorkflowException {
		try {
			System.out.println("----- WorkflowActvMatterDeleteListener - execute -----");
			System.out.println("LoginGroupId        : " + loginGroupId);
			System.out.println("LocaleId            : " + localeId);
			System.out.println("systemMatterId      : " + systemMatterId);
			System.out.println("userDataId          : " + userDataId);
			System.out.println("----- WorkflowActvMatterDeleteListener - execute -----");
			
			HeaderRepository headerRepository = new HeaderRepository();
			HeaderModel varHeaderData = headerRepository.selectData("system_matter_id", systemMatterId).iterator().next();
			
			varHeaderData.setStatus("90");

			headerRepository.updateData(varHeaderData);

		}catch(Exception e) {
			e.printStackTrace();
		}
	}
}
