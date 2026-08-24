package wf.training_maisaka.general.domain.service;

import java.net.URLDecoder;
import java.util.Collection;

import jp.co.intra_mart.foundation.mail.javamail.StandardMail;
import jp.co.intra_mart.foundation.mail.javamail.JavaMailSender;
import jp.co.intra_mart.foundation.mail.javamail.ExtendedMail;

import jp.co.intra_mart.foundation.service.client.file.PublicStorage;

import wf.training_maisaka.general.domain.model.HeaderInfoModel;
import wf.training_maisaka.general.domain.model.AttachFileModel;

public class EmailService {
	
	public void sendEmail(String matterId, String mailAddress, HeaderInfoModel  headerInfo, Collection<AttachFileModel> entityAttachment) throws Exception {
		try {
			//StandardMail mail = new StandardMail();
			ExtendedMail mail = new ExtendedMail();
			
			String mailBody = ""
					+ "Dear Mr./Mrs./Ms."
					+ "\r\n"
					+ ""
					+ "Application Number "
					+ headerInfo.getApplication_number()
					+ "has been applied."
					+ ""
					+ "\r\n"
					+ "the detail can be seen in this attachment file or directly check on the system"
					+ ""
					+ "\r\n";
			
			mail.setFrom("mailTesting@gmail.com", "Email Notification");
			mail.setSubject("Testing email with attachment");
			mail.setText(mailBody);
			
			String fileName = headerInfo.getApplication_number() + ".pdf";
			//PublicStorage file = new PublicStorage(fileName);
			String file = URLDecoder.decode("/generated_pdf/" + headerInfo.getSystem_matter_id() + ".pdf", "UTF-8");
			
			PublicStorage storage = new PublicStorage(file);
			
			if(storage.isFile()) {
				//mail.addAttachment(fileName, file);
				mail.addAttachmentStorage(fileName, storage);
			}
			
			//add attachment files from wf_attach_file
			for(AttachFileModel item : entityAttachment) {
				String getFileName = item.getFile_name();
				String getFilePath = item.getFile_path();
				
				String getFile = URLDecoder.decode(getFilePath, "UTF-8");
				
				PublicStorage setStorage = new PublicStorage(getFile);
				
				if(setStorage.isFile()) {
					mail.addAttachmentStorage(getFileName, setStorage);
				}
			}

			mail.addTo(mailAddress);
			
			
			
			//Execute mail
			JavaMailSender sender = new JavaMailSender(mail);
			sender.send();
			
			
		}catch(Exception e) {
			e.printStackTrace();
		}

	}

}
