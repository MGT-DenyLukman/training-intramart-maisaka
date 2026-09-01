<%@ taglib prefix="f" uri="http://terasoluna.org/functions"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<div id="section-psd-check">
	  <header class="imui-chapter-title">
		<h2>PSD Check (by UH or DH, PSD)</h2>
	</header>

	<table id="psd_check" class="imui-form tab_header">
		<tbody>
				<tr>
						<th><label class="imui-required">PSD Area or Non-PSD Area (Based on Guideline)</label></th>
						<td>
								<input type="radio" id="psd" name="f_psd_area_bog" value="1"
								${FormClassRows.f_psd_area_bog == 1 ? "checked" : "" }
								 class="${isUHDHDisabled}"/>	
								<label for="psd">PSD (go to #2)</label>
								<br>
								<input type="radio" id="psd_end" name="f_psd_area_bog" value="0"
								${FormClassRows.f_psd_area_bog == 0 ? "checked" : "" }
								 class="${isUHDHDisabled}"/>	
								<label for="psd_end">Non-PSD (End)</label>
								<div class="error_message"></div>
						</td>
				</tr>
				<tr id="f_psd_area_second">
						<th><label class="imui-required">In PSD Area, PSD Process or DIC Process</label></th>
						<td>
								<input type="radio" id="psd_2" name="f_psd_process" value="PSD"
								${FormClassRows.f_psd_process == "PSD" ? "checked" : "" }
								class="${isUHDHDisabled}"/>	
								<label for="psd_2">PSD (Pitching result attached)</label>
								<br>
								<input type="radio" id="psd_dic" name="f_psd_process" value="DIC" 
								${FormClassRows.f_psd_process == "DIC" ? "checked" : "" }
								class="${isUHDHDisabled}"/>	
								<label for="psd_dic">DIC (Please describe the reason in the below)</label>
								<c:choose>
									<c:when test="${isUHDHDisabled == 'unclickable'}">
										<br><label>${f:h(FormClassRows.f_dic_reason)}</label>
									</c:when>
									<c:otherwise>
										<textarea id="psd_dic_reason" name="f_dic_reason"  
										class="${isUHDHDisabled}"></textarea>
									</c:otherwise>
								</c:choose>
								<div class="error_message"></div>
						</td>
				</tr>
		</tbody>
	</table>
</div>