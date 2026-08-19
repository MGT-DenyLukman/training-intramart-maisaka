package wf.training_maisaka.general.app;

import jp.co.intra_mart.foundation.context.Contexts;
import jp.co.intra_mart.foundation.user_context.model.UserContext;
import jp.co.intra_mart.foundation.user_context.model.UserProfile;
import jp.co.intra_mart.foundation.user_context.model.UserCategory;
import jp.co.intra_mart.foundation.user_context.model.Department;
import jp.co.intra_mart.foundation.user_context.model.DepartmentPost;


import java.util.List;
import java.util.Collection;
import java.util.Map;
import java.util.HashMap;
import java.text.SimpleDateFormat;
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;


//import java.io.FileNotFoundException;
//import java.net.URLDecoder;
//import java.util.ArrayList;
//import java.util.Collection;
//import java.util.List;

//import javax.servlet.http.HttpServletRequest;

//import jp.co.intra_mart.foundation.service.client.file.PublicStorage;
import jp.co.intra_mart.foundation.service.client.information.Identifier;
import jp.co.intra_mart.foundation.workflow.code.PageType;

//import com.fasterxml.jackson.databind.ObjectMapper;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
//import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
//import org.springframework.web.bind.annotation.ResponseBody;
//import org.springframework.web.servlet.HandlerMapping;

import edu.emory.mathcs.backport.java.util.Arrays;
//import wf.training_test.general.domain.repository.*;
//import wf.training_test.general.domain.service.*;
//import wf.training_test.general.domain.model.*;
import wf.training_maisaka.general.domain.model.EstSchedulePaymentModel;
import wf.training_maisaka.general.domain.model.HeaderModel;
import wf.training_maisaka.general.domain.repository.HeaderRepository;
import wf.training_maisaka.general.domain.service.WorkflowService;

@Controller("training_maisaka_new")
@RequestMapping("training_maisaka/")
public class ImartController {

	@RequestMapping(value = "apply")
	public final String apply(final Model model, final ImartForm ApplyForm) throws Exception {
		WorkflowService service = new WorkflowService();
		
		if (PageType.pageTyp_App.toString().equals(ApplyForm.getImwPageType())) {
			String userDataId = "";
			final Identifier identifier = new Identifier();
			userDataId = identifier.get();
			
			ApplyForm.setImwUserDataId(userDataId);
			

			// START set applicant information
			ImartForm FormClassRow = new ImartForm();
			UserContext userContext = Contexts.get(UserContext.class);
			UserProfile userProfile = userContext.getUserProfile();
			List<DepartmentPost> deptPost = userContext.getAllPosts();
			Department dept = userContext.getCurrentDepartment();
			
			service.debug("DEPT CONTROLLER", dept);
			service.debug("DEPT POST CONTROLLER", deptPost);

			
			FormClassRow.setF_applicant_name(userProfile.getUserName());
			FormClassRow.setF_applicant_number(userProfile.getUserCd());

			LocalDate today = LocalDate.now();
			
			
			DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy/MM/dd");
			String formattedDate = today.format(formatter);

			FormClassRow.setF_application_date(formattedDate);
			if(dept != null) {
				FormClassRow.setF_applicant_dept_name(dept.getDepartmentName());
			}else {
				model.addAttribute("dept_name_err_message", "please set user department");
			}
			if(deptPost.size() > 0) {
				String post = "";
				for(DepartmentPost item : deptPost) {
					post += item.getPostName();
				}
				if(!post.isEmpty()) {
					FormClassRow.setF_applicant_pos_name(post);
				}			
			}else {
					model.addAttribute("pos_name_err_message", "please set user position");
			}

			HeaderRepository headerDB = new HeaderRepository();
			HeaderModel varHeaderMaxId = headerDB.getMaxId();
			service.debug("varHeaderMaxId", varHeaderMaxId);
			FormClassRow.setF_application_number("PI-" + String.format("%06d", (Integer.parseInt(varHeaderMaxId.getId()) + 1)));

			model.addAttribute("FormClassRow", FormClassRow);
			// END set applicant information

			model.addAttribute("ApplyForm", ApplyForm);
			return "wf/training_maisaka/general/apply.jsp";
			
		} else if (PageType.pageTyp_UnApp.toString().equals(ApplyForm.getImwPageType())) {
			return "wf/training_maisaka/general/apply.jsp";
		
		} else {
			WorkflowService Service = new WorkflowService();
			ImartForm FormClassRows = new ImartForm();
			FormClassRows = Service.getAgreementDetailTemp("system_matter_id", ApplyForm.getImwSystemMatterId());
			
			//check if agreement_status has "_"
			String agreementStatus = FormClassRows.getF_agreement_status();
			String agreementStatusRenewal = "";
			if(agreementStatus.contains("_")) {
				agreementStatusRenewal = agreementStatus.split("_")[1];
			}

			model.addAttribute("FormClassRows", FormClassRows);
			model.addAttribute("agreementStatus", agreementStatus);
			model.addAttribute("agreementStatusRenewal", agreementStatusRenewal);
			model.addAttribute("ApplyForm", ApplyForm);
			return "wf/training_maisaka/general/reapply.jsp";
			
		}
	}

	@RequestMapping(value = "detail")
	public final String detail(final Model model, final ImartForm ApplyForm) throws Exception {
		
		try {
			WorkflowService Service = new WorkflowService();
			ImartForm FormClassRows = new ImartForm();
			FormClassRows = Service.getAgreementDetailTemp("system_matter_id", ApplyForm.getImwSystemMatterId());
			
			//check if agreement_status has "_"
			String agreementStatus = FormClassRows.getF_agreement_status();
			String agreementStatusRenewal = "";
			if(agreementStatus.contains("_")) {
				agreementStatusRenewal = agreementStatus.split("_")[1];
			}
			
			//Service.debug("FormClassRows est sch pay Detail", FormClassRows.getD_estimated_schedule_payment());

			int esTotalAmount = 0;
			for(EstSchedulePaymentModel item : FormClassRows.getD_estimated_schedule_payment()) {
				Integer amount = Integer.parseInt(item.getPayment_amount().replace(",",""));
				esTotalAmount += amount;
			}

			model.addAttribute("FormClassRows", FormClassRows);
			model.addAttribute("agreementStatus", agreementStatus);
			model.addAttribute("agreementStatusRenewal", agreementStatusRenewal);
			model.addAttribute("esTotalAmount", esTotalAmount);
			model.addAttribute("ApplyForm", ApplyForm);
		} catch(Exception e) {
			System.out.println("Error page detail : " + e);
			e.printStackTrace();
		}
		
		return "wf/training_maisaka/general/detail.jsp";
	}

	@RequestMapping(value = "process")
	public final String process(final Model model, final ImartForm ApplyForm) throws Exception {
		try {
			WorkflowService Service = new WorkflowService();
			ImartForm FormClassRows = new ImartForm();
			FormClassRows = Service.getAgreementDetailTemp("system_matter_id", ApplyForm.getImwSystemMatterId());
			
			Service.debug("Apply Form process controller", ApplyForm);
			Service.debug("FormClassRows process controller", FormClassRows);
			
			//check if agreement_status has "_"
			String agreementStatus = FormClassRows.getF_agreement_status();
			String agreementStatusRenewal = "";
			if(agreementStatus.contains("_")) {
				agreementStatusRenewal = agreementStatus.split("_")[1];
			}
			
			
			UserContext userContext = Contexts.get(UserContext.class);
//			UserProfile userProfile = userContext.getUserProfile();
			List<UserCategory> userCategories = userContext.getUserCategoryList();
			
			if(userCategories != null) {
				for(UserCategory item :userCategories) {
					Service.debug("user categoris controller", item);
				}
			}
			
			

			model.addAttribute("FormClassRows", FormClassRows);
			model.addAttribute("agreementStatus", agreementStatus);
			model.addAttribute("agreementStatusRenewal", agreementStatusRenewal);
			model.addAttribute("ApplyForm", ApplyForm);
		} catch(Exception e) {
			System.out.println("Error page detail : " + e);
			e.printStackTrace();
		}
		
		return "wf/training_maisaka/general/process.jsp";
	}

	/*
	@RequestMapping(value = "detail")
	public final String detail(final Model model, final ImartForm ApplyForm) throws Exception {
		
		try {
			WorkflowService Service = new WorkflowService();
			ImartForm FormClassRows = new ImartForm();
			FormClassRows = Service.getInfoTemp(ApplyForm.getImwSystemMatterId(), "system_matter_id");
			
			//Set master Data
			Collection<VendorModel> vendorList = Service.getVendorList();

			model.addAttribute("vendorList", vendorList);
			model.addAttribute("FormClassRows", FormClassRows);
			model.addAttribute("ApplyForm", ApplyForm);
		} catch(Exception e) {
			System.out.println("Error approve : " + e);
		}
		
		return "wf/training_test/general/detail.jsp";
	}
	

	@RequestMapping(value = "download/**")
	public String download(final Model model, HttpServletRequest request) throws Exception {
		

		String urlStr = (String) request.getAttribute(HandlerMapping.PATH_WITHIN_HANDLER_MAPPING_ATTRIBUTE);
		
		String fileId = urlStr.substring(urlStr.lastIndexOf('/') + 1);

		
		AttachmentRepository FileRepository = new AttachmentRepository();
		List<AttachmentModel> rowsFile = new ArrayList<AttachmentModel>(FileRepository.SelectTempInfo(fileId.toString(), "id"));
		String fileName = rowsFile.get(0).getFile_name();
		String fileRealPath = rowsFile.get(0).getFile_path();
		String fileDecode = URLDecoder.decode(fileRealPath.toString(), "UTF-8");
		
		final PublicStorage storage = new PublicStorage(fileDecode);
		if (!storage.isFile()) {
			
			throw new FileNotFoundException("Could not find a file");
		}
		
		model.addAttribute("download_file_name", fileName);
		model.addAttribute("storage", storage);
		return "DownloadAttachmentService.Downloadview";
	}

	@PostMapping("ajaxtest")
	@ResponseBody
	public String ajaxtest(final HttpServletRequest request) throws Exception {
	    
	    String MatterId = request.getParameter("system_matter_id");
	    
	    try {
	        
	        System.out.println(" ----- Success ---- Matter_ID :" + MatterId);

	        return "success";
	    } catch (Exception e) {
	        
	        e.printStackTrace();  
	        return "error: " + e.getMessage();
	    }
	    
	}

	

	@PostMapping("generatepdf")
	@ResponseBody
	public String generatepdf(final HttpServletRequest request) throws Exception {
	   
	    String MatterId = request.getParameter("system_matter_id");
	    
	    try {
	        GeneratePDFService pdfGenerate = new GeneratePDFService();
	        
	        pdfGenerate.createPDF(MatterId);
	        

	        return "success";
	    } catch (Exception e) {
	    	
	        e.printStackTrace();  
	        return "error: " + e.getMessage();
	    }
	    
	}
	

	@RequestMapping(value = "downloadpdf/**")
	public String downloadpdf(final Model model, HttpServletRequest request) throws Exception {
		
		
		String urlStr = (String) request.getAttribute(HandlerMapping.PATH_WITHIN_HANDLER_MAPPING_ATTRIBUTE);
		String fileName = urlStr.substring(urlStr.lastIndexOf('/') + 1);

		//System.out.println("Data File Name : "+fileName );

		String file_decode = URLDecoder.decode("generate_pdf/" + fileName, "UTF-8");
		final PublicStorage storage = new PublicStorage(file_decode);
		if (!storage.isFile()) {
			
			throw new FileNotFoundException("Could not find a file");
		}
		
		model.addAttribute("download_file_name", fileName);
		model.addAttribute("storage", storage);
		
		return "DownloadAttachmentServicePathTest.Downloadview";
	}
	*/



}

