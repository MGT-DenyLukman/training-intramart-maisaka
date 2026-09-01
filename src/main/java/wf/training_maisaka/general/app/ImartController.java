package wf.training_maisaka.general.app;

import jp.co.intra_mart.foundation.context.Contexts;
import jp.co.intra_mart.foundation.user_context.model.UserContext;
import jp.co.intra_mart.foundation.user_context.model.UserProfile;
import jp.co.intra_mart.foundation.user_context.model.UserCategory;
import jp.co.intra_mart.foundation.user_context.model.Department;
import jp.co.intra_mart.foundation.user_context.model.DepartmentPost;

import jp.co.intra_mart.foundation.workflow.application.general.ActvMatter;
import jp.co.intra_mart.foundation.workflow.application.general.ActvMatterNode;
import jp.co.intra_mart.foundation.workflow.application.model.MatterNodeModel;
import jp.co.intra_mart.foundation.workflow.application.model.ProcessTargetModel;

import jp.co.intra_mart.foundation.service.client.file.PublicStorage;

import java.io.FileNotFoundException;
import java.net.URLDecoder;
import java.net.URL;
import java.net.HttpURLConnection;

import java.util.List;
import java.util.ArrayList;
import java.util.Collection;
import java.util.Map;
import java.util.HashMap;
import java.text.SimpleDateFormat;
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;

import java.io.BufferedReader;
import java.io.InputStreamReader;

import javax.servlet.http.HttpServletRequest;
import org.springframework.web.servlet.HandlerMapping;


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
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.GetMapping;
//import org.springframework.web.servlet.HandlerMapping;

import edu.emory.mathcs.backport.java.util.Arrays;

import wf.training_maisaka.general.domain.repository.HeaderInfoRepository;
import wf.training_maisaka.general.domain.repository.AttachFileRepository;

import wf.training_maisaka.general.domain.model.EstSchedulePaymentModel;
import wf.training_maisaka.general.domain.model.HeaderInfoModel;
import wf.training_maisaka.general.domain.model.AttachFileModel;

import wf.training_maisaka.general.domain.service.WorkflowService;
import wf.training_maisaka.general.domain.service.GeneratePDFService;

@Controller("training_maisaka_new")
@RequestMapping("training_maisaka/")
public class ImartController {

	@RequestMapping(value = "apply")
	public final String apply(final Model model, final ImartForm ApplyForm, final HttpServletRequest request) throws Exception {
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

			HeaderInfoRepository headerInfoDB = new HeaderInfoRepository();
			HeaderInfoModel varHeaderInfoMaxId = headerInfoDB.getMaxId();
			FormClassRow.setF_application_number("PI-" + String.format("%06d", (Integer.parseInt(varHeaderInfoMaxId.getId()) + 1)));

			model.addAttribute("FormClassRow", FormClassRow);
			// END set applicant information

			model.addAttribute("ApplyForm", ApplyForm);
			return "wf/training_maisaka/general/apply.jsp";
			
		} else if (PageType.pageTyp_UnApp.toString().equals(ApplyForm.getImwPageType())) {
			return "wf/training_maisaka/general/apply.jsp";

		} else {
			// REAPPLY
			WorkflowService Service = new WorkflowService();
			ImartForm FormClassRows = new ImartForm();
			FormClassRows = Service.getDataForForm("system_matter_id", ApplyForm.getImwSystemMatterId(), request);
			
			//check if agreement_status has "_"
			String agreementStatus = FormClassRows.getF_agreement_status();
			String agreementStatusRenewal = "";
			if(agreementStatus.contains("_")) {
				agreementStatusRenewal = agreementStatus.split("_")[1];
			}

			UserContext userContext = Contexts.get(UserContext.class);
			UserProfile userProfile = userContext.getUserProfile();
			List<DepartmentPost> deptPost = userContext.getAllPosts();
			Department dept = userContext.getCurrentDepartment();
			
			service.debug("DEPT CONTROLLER", dept);
			service.debug("DEPT POST CONTROLLER", deptPost);

			
			FormClassRows.setF_applicant_name(userProfile.getUserName());
			FormClassRows.setF_applicant_number(userProfile.getUserCd());

			LocalDate today = LocalDate.now();
			
			
			DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy/MM/dd");
			String formattedDate = today.format(formatter);

			FormClassRows.setF_application_date(formattedDate);
			if(dept != null) {
				FormClassRows.setF_applicant_dept_name(dept.getDepartmentName());
			}else {
				model.addAttribute("dept_name_err_message", "please set user department");
			}
			if(deptPost.size() > 0) {
				String post = "";
				for(DepartmentPost item : deptPost) {
					post += item.getPostName();
				}
				if(!post.isEmpty()) {
					FormClassRows.setF_applicant_pos_name(post);
				}			
			}else {
					model.addAttribute("pos_name_err_message", "please set user position");
			}

			int esTotalAmount = 0;
			for(EstSchedulePaymentModel item : FormClassRows.getD_estimated_schedule_payment()) {
				Integer amount = Integer.parseInt(item.getPayment_amount().replace(",",""));
				esTotalAmount += amount;
			}

			//check if agreement_classification or ec_approval_is_req contain "_"
			String agreementClassification = FormClassRows.getF_agreement_classification();
			String agreementClassificationChildren = "";
			if(agreementClassification.contains("_")) {
				agreementClassificationChildren = agreementClassification.split("_")[1];
				agreementClassification = agreementClassification.split("_")[0];
			}

			String ecApprovalIsReq = FormClassRows.getF_ec_approval_is_req();
			String ecApprovalIsReqYesChildren = "";
			if(ecApprovalIsReq.contains("_")) {
				ecApprovalIsReqYesChildren = ecApprovalIsReq.split("_")[1];
				ecApprovalIsReq = ecApprovalIsReq.split("_")[0];
			}

			model.addAttribute("esTotalAmount", esTotalAmount);
			model.addAttribute("FormClassRows", FormClassRows);
			model.addAttribute("agreementStatus", agreementStatus);
			model.addAttribute("agreementStatusRenewal", agreementStatusRenewal);
			model.addAttribute("agreementClassification", agreementClassification);
			model.addAttribute("agreementClassificationChildren", agreementClassificationChildren);
			model.addAttribute("ecApprovalIsReq", ecApprovalIsReq);
			model.addAttribute("ecApprovalIsReqYesChildren", ecApprovalIsReqYesChildren);
			model.addAttribute("ApplyForm", ApplyForm);
			Service.debug("APPLY FORM", ApplyForm);
			return "wf/training_maisaka/general/reapply.jsp";
			
		}
	}

	@RequestMapping({"detail", "confirm"})
	public final String detail(final Model model, final ImartForm ApplyForm, final HttpServletRequest request) throws Exception {
		
		try {
			WorkflowService Service = new WorkflowService();
			Service.debug("ApplyForm detail / confirm controller", ApplyForm);
			ImartForm FormClassRows = new ImartForm();
			FormClassRows = Service.getDataForForm("system_matter_id", ApplyForm.getImwSystemMatterId(), request);
			
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
			
			//check if agreement_classification or ec_approval_is_req contain "_"
			String agreementClassification = FormClassRows.getF_agreement_classification();
			String agreementClassificationChildren = "";
			if(agreementClassification.contains("_")) {
				agreementClassificationChildren = agreementClassification.split("_")[1];
				agreementClassification = agreementClassification.split("_")[0];
			}

			String ecApprovalIsReq = FormClassRows.getF_ec_approval_is_req();
			String ecApprovalIsReqYesChildren = "";
			if(ecApprovalIsReq.contains("_")) {
				ecApprovalIsReqYesChildren = ecApprovalIsReq.split("_")[1];
				ecApprovalIsReq = ecApprovalIsReq.split("_")[0];
			}
			
			//download token

			Service.debug("FormClassRows detail controller", FormClassRows);
			model.addAttribute("FormClassRows", FormClassRows);
			model.addAttribute("agreementStatus", agreementStatus);
			model.addAttribute("agreementStatusRenewal", agreementStatusRenewal);
			model.addAttribute("agreementClassification", agreementClassification);
			model.addAttribute("agreementClassificationChildren", agreementClassificationChildren);
			model.addAttribute("ecApprovalIsReq", ecApprovalIsReq);
			model.addAttribute("ecApprovalIsReqYesChildren", ecApprovalIsReqYesChildren);
			model.addAttribute("esTotalAmount", esTotalAmount);
			model.addAttribute("ApplyForm", ApplyForm);
		} catch(Exception e) {
			System.out.println("Error page detail : " + e);
			e.printStackTrace();
		}
		
		return "wf/training_maisaka/general/detail.jsp";
	}

	@RequestMapping(value = "process")
	public final String process(final Model model, final ImartForm ApplyForm, final HttpServletRequest request) throws Exception {
		
		try {
			WorkflowService Service = new WorkflowService();
			ImartForm FormClassRows = new ImartForm();
			FormClassRows = Service.getDataForForm("system_matter_id", ApplyForm.getImwSystemMatterId(), request);
			
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

			//check if agreement_classification or ec_approval_is_req contain "_"
			String agreementClassification = FormClassRows.getF_agreement_classification();
			String agreementClassificationChildren = "";
			if(agreementClassification.contains("_")) {
				agreementClassificationChildren = agreementClassification.split("_")[1];
				agreementClassification = agreementClassification.split("_")[0];
			}

			String ecApprovalIsReq = FormClassRows.getF_ec_approval_is_req();
			String ecApprovalIsReqYesChildren = "";
			if(ecApprovalIsReq.contains("_")) {
				ecApprovalIsReqYesChildren = ecApprovalIsReq.split("_")[1];
				ecApprovalIsReq = ecApprovalIsReq.split("_")[0];
			}
			
			
			//check which node
			Service.debug("ApplyForm process controller", ApplyForm);
			/*
			ActvMatterNode actvMatterNode = new ActvMatterNode( ApplyForm.getImwSystemMatterId());

			MatterNodeModel matterNodeModel =  actvMatterNode.getMatterNode(ApplyForm.getImwNodeId());
			String nodeName = matterNodeModel.getNodeName();
			
			ProcessTargetModel processTargetModel[] = actvMatterNode.getExecProcessTargetList(ApplyForm.getImwNodeId());
			
			Integer count = 0;
			for(ProcessTargetModel item : processTargetModel) {
				Service.debug(count.toString(), item);
				count += 1;
			}
			*/
			
			String isUHDHDisabled = "unclickable";
			String isCCODisabled = "unclickable";
			String isLegalDisabled = "unclickable";

			if("approver_uhdh".equals(ApplyForm.getImwNodeId())) {
				isUHDHDisabled = "";
			}
			else if("approver_cco".equals(ApplyForm.getImwNodeId())) {
				isCCODisabled = "";
			}else if("approver_legal".equals(ApplyForm.getImwNodeId())) {
				isLegalDisabled = "";
			}
			
			

			Service.debug("FormClassRows process controller", FormClassRows);
			model.addAttribute("FormClassRows", FormClassRows);
			model.addAttribute("agreementStatus", agreementStatus);
			model.addAttribute("agreementStatusRenewal", agreementStatusRenewal);
			model.addAttribute("agreementClassification", agreementClassification);
			model.addAttribute("agreementClassificationChildren", agreementClassificationChildren);
			model.addAttribute("ecApprovalIsReq", ecApprovalIsReq);
			model.addAttribute("ecApprovalIsReqYesChildren", ecApprovalIsReqYesChildren);
			model.addAttribute("esTotalAmount", esTotalAmount);
			model.addAttribute("ApplyForm", ApplyForm);
			
			model.addAttribute("isUHDHDisabled", isUHDHDisabled);
			model.addAttribute("isCCODisabled", isCCODisabled);
			model.addAttribute("isLegalDisabled", isLegalDisabled);

			if("approver_uhdh".equals(ApplyForm.getImwNodeId())) {
				return "wf/training_maisaka/general/process-uhdh.jsp";
			}
			else if("approver_cco".equals(ApplyForm.getImwNodeId())) {
				return "wf/training_maisaka/general/process-cco.jsp";
			}else if("approver_legal".equals(ApplyForm.getImwNodeId())) {
				return "wf/training_maisaka/general/process-legal.jsp";
			}else {
				return "wf/training_maisaka/general/process-final.jsp";
			}

		} catch(Exception e) {
			System.out.println("Error page process : " + e);
			e.printStackTrace();
		}
		
		return "wf/training_maisaka/general/process.jsp";
	}

	@RequestMapping(value = "download/**")
	public String download(final Model model, HttpServletRequest request) throws Exception {
		
		try {
			WorkflowService service = new WorkflowService();

		String clientToken = request.getParameter("token");
		String sessionToken = request.getSession(false).getAttribute("download_token_request").toString();

		Boolean checkToken = service.compareClientTokenAndSession(clientToken, sessionToken);
		
		if(!checkToken) {
			return "Token is invalid";
		}

		String urlStr = (String) request.getAttribute(HandlerMapping.PATH_WITHIN_HANDLER_MAPPING_ATTRIBUTE);
		
		String fileRealName = urlStr.substring(urlStr.lastIndexOf('/') + 1);

		
		AttachFileRepository attachFileDB = new AttachFileRepository();
		List<AttachFileModel> rowsFile = new ArrayList<AttachFileModel>(attachFileDB.selectData("file_real_name", fileRealName));
		
		
		service.debug("entity", rowsFile.get(0));

		String fileName = rowsFile.get(0).getFile_name();
		String fileRealPath = rowsFile.get(0).getFile_path();
		String fileDecode = URLDecoder.decode(fileRealPath.toString(), "UTF-8");
		
		final PublicStorage storage = new PublicStorage(fileDecode);
		if (!storage.isFile()) {
			
			throw new FileNotFoundException("Could not find a file");
		}
		
		model.addAttribute("downloadFileName", fileName);
		model.addAttribute("storage", storage);
		}catch(Exception e) {
			e.printStackTrace();
		}
		return "AppCommonService.Downloadview";
	}
	
	@RequestMapping(value = "downloadpdf/**")
	public String downloadPDF(final Model  model, HttpServletRequest request) throws Exception {
		try {

		WorkflowService Service = new WorkflowService();

		String clientToken = request.getParameter("token");
		String sessionToken = request.getSession(false).getAttribute("download_token_request").toString();

		Boolean checkToken = Service.compareClientTokenAndSession(clientToken, sessionToken);
		
		if(!checkToken) {
			return "Token is invalid";
		}
		
		
		String urlStr = (String) request.getAttribute(HandlerMapping.PATH_WITHIN_HANDLER_MAPPING_ATTRIBUTE);
		String systemMatterId = urlStr.substring(urlStr.lastIndexOf('/') + 1);
		
		HeaderInfoRepository headerInfoDB = new HeaderInfoRepository();
		HeaderInfoModel entityHeaderInfo = headerInfoDB.selectData("system_matter_id", systemMatterId).iterator().next();
		
		String fileName  = entityHeaderInfo.getApplication_number() + ".pdf";

		String file_decode = URLDecoder.decode("/generated_pdf/" + systemMatterId + ".pdf", "UTF-8");
		final PublicStorage storage = new PublicStorage(file_decode);
		
		if(!storage.isFile()) {
			throw new FileNotFoundException("Could not find a file");
		}
		
		model.addAttribute("downloadFileName", fileName);
		model.addAttribute("storage", storage);
				
			
		}catch(Exception e) {
			e.printStackTrace();
			return "error when download generated pdf";
		}
		return "AppCommonService.Downloadview";
	}
	
	@PostMapping("generatepdf")
	@ResponseBody
	public String generatePDF(final Model model, final HttpServletRequest request) throws Exception {
		try {
			WorkflowService Service = new WorkflowService();

			String clientToken = request.getParameter("token");
			String sessionToken = request.getSession(false).getAttribute("download_token_request").toString();

			Boolean checkToken = Service.compareClientTokenAndSession(clientToken, sessionToken);
			
			if(!checkToken) {
				return "Token is invalid";
			}

			String matterId =request.getParameter("system_matter_id");
			
			GeneratePDFService generatePDFService = new GeneratePDFService();
			
			generatePDFService.createPDF(matterId);
			return "success";
			
		}catch(Exception e) {
			e.printStackTrace();
			
			return "error: " + e.getMessage();
		}
		
		
	}
	

	@GetMapping("getRegionData")
	@ResponseBody
	public String getRegionData(final HttpServletRequest request) throws Exception {
		String keyword = request.getParameter("keyword");
		
		try {
			String apiUrl = "https://konoland-api.vercel.app/search?q=" + keyword;
			
			URL url = new URL(apiUrl);
			HttpURLConnection conn = (HttpURLConnection) url.openConnection();
			
			conn.setRequestMethod("GET");
			conn.setConnectTimeout(5000);
			conn.setReadTimeout(5000);
			
			int responseCode = conn.getResponseCode();

			BufferedReader bufferedReader = new BufferedReader(new InputStreamReader(responseCode == HttpURLConnection.HTTP_OK ? conn.getInputStream() : conn.getErrorStream()));
			
			String inputLine;
			StringBuilder response = new StringBuilder();
			
			while((inputLine = bufferedReader.readLine()) != null) {
				response.append(inputLine);
			}
			bufferedReader.close();
			conn.disconnect();
			
			return response.toString();

		}catch(Exception e){
			e.printStackTrace();
			return "error : " + e.getMessage();
		}
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

