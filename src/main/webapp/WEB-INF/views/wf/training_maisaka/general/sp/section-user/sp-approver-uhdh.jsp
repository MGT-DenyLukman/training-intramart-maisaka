<%@ taglib prefix="f" uri="http://terasoluna.org/functions"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="imsp" uri="http://www.intra-mart.co.jp/taglib/imsp"%>
<div id="section-psd-check">
			<div class="ui-bar ui-bar-b">
				<h3>PSD Check (by UH or DH, PSD)</h3>
			</div>
			<div class="ui-body ui-body-b">
				<imsp:fieldContain label="PSD Area or Non-PSD Area (Based on Guideline) :">
						<div>
								<input type="radio" id="psd" name="f_psd_area_bog" value="1"
								data-role="none"
								${FormClassRows.f_psd_area_bog == 1 ? "checked" : "" }
								 class="${isUHDHDisabled}"/>	
								<label for="psd">PSD (go to #2)</label>
								<br>
								<input type="radio" id="psd_end" name="f_psd_area_bog" value="0"
								data-role="none"
								${FormClassRows.f_psd_area_bog == 0 ? "checked" : "" }
								 class="${isUHDHDisabled}"/>	
								<label for="psd_end">Non-PSD (End)</label>
								<div class="error_message"></div>
						</div>
				</imsp:fieldContain>
				<div id="f_psd_area_second">
				<imsp:fieldContain label="In PSD Area, PSD Process or DIC Process">
						<div>
								<input type="radio" id="psd_2" name="f_psd_process" value="PSD"
								data-role="none"
								${FormClassRows.f_psd_process == "PSD" ? "checked" : "" }
								class="${isUHDHDisabled}"/>	
								<label for="psd_2">PSD (Pitching result attached)</label>
								<br>
								<input type="radio" id="psd_dic" name="f_psd_process" value="DIC" 
								data-role="none"
								${FormClassRows.f_psd_process == "DIC" ? "checked" : "" }
								class="${isUHDHDisabled}"/>	
								<label for="psd_dic">DIC (Please describe the reason in the below) :</label>
								<c:choose>
									<c:when test="${isUHDHDisabled == 'unclickable'}">
										<br><label>${f:h(FormClassRows.f_dic_reason)}</label>
									</c:when>
									<c:otherwise>
										<textarea id="psd_dic_reason" name="f_dic_reason"  
										data-role="none"
										class="${isUHDHDisabled}"></textarea>
									</c:otherwise>
								</c:choose>
								<div class="error_message"></div>
						</div>
				</imsp:fieldContain>
				</div>
			</div>
</div>