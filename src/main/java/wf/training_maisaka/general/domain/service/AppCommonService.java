package wf.training_maisaka.general.domain.service;
import java.io.IOException;
import java.io.InputStream;
import java.io.UnsupportedEncodingException;
import java.util.Map;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import jp.co.intra_mart.foundation.http.ResponseUtil;
import jp.co.intra_mart.foundation.service.client.file.PublicStorage;
import jp.co.intra_mart.foundation.service.client.file.Storage;

import org.springframework.core.io.ClassPathResource;
import org.springframework.core.io.Resource;
import org.springframework.stereotype.Component;
import org.terasoluna.gfw.common.exception.SystemException;
import org.terasoluna.gfw.web.download.AbstractFileDownloadView;

@Component("AppCommonService.Downloadview")
public class AppCommonService extends AbstractFileDownloadView  {
	
		@Override
	   protected InputStream getInputStream(Map<String, Object> model,HttpServletRequest request) throws IOException{
			final Storage<?> storage = (Storage<?>) model.get("storage");
			
			return storage.open();
	   }
		
		@Override
		protected void addResponseHeader(final Map<String, Object> model, final HttpServletRequest request, final HttpServletResponse response) {
			final String disposition;
			
	        try {
	        	final String fileName = (String) model.get("downloadFileName");
	            disposition = ResponseUtil.encodeFileName(request, "UTF-8", fileName);
	        } catch (final UnsupportedEncodingException e) {
	            throw new SystemException("download view error code", e);
	        }
	        
	        response.setHeader("Content-Disposition", "attachment;" + disposition);
	        response.setContentType("application/force-download");
	    }	

}
