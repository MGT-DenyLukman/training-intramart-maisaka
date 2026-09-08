<%@ taglib prefix="imsp" uri="http://www.intra-mart.co.jp/taglib/imsp"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="f" uri="http://terasoluna.org/functions"%>
<div id="section-legal">
	  <header class="ui-bar ui-bar-b">
		<h2>Filled By Legal</h2>
	</header>

	<div id="filled_by_legal" class="ui-body ui-body-b">
				<imsp:fieldContain label="Agreement Number :">
							<c:choose>
								<c:when test="${isLegalDisabled != 'unclickable'}">
									<input type="text" name="f_agreement_number" class="${isLegalDisabled}" value="${f:h(FormClassRows.f_agreement_number) }"/>
								</c:when>
								<c:otherwise>
									<div class="ui-field-contain custom-readonly" >
										<label>${f:h(FormClassRows.f_agreement_number) }</label>
									</div>
								</c:otherwise>
							</c:choose>
							<div class="error_message"></div>
				</imsp:fieldContain>
				<imsp:fieldContain label="Agreement Date :">
							<c:choose>
								<c:when test="${isLegalDisabled != 'unclickable'}">
									<input type="text" id="agreement_date"  name="f_agreement_date" class="${isLegalDisabled}" value="${f:h(FormClassRows.f_agreement_date.replaceAll('-','/')) }" placeholder="choose date ..." onclick="toggleCalendar()"/>
									<div class="error_message"></div>
									<div id="calendar" style="display: none">
										<imsp:calendar name="pick_agreement_date" format="yyyy/MM/dd" />
									</div>
								</c:when>
								<c:otherwise>
									<div class="ui-field-contain custom-readonly" >
										<label>${f:h(FormClassRows.f_agreement_date.replaceAll("-","/")) }</label>
									</div>
								</c:otherwise>
							</c:choose>
				</imsp:fieldContain>
	</div>
<script>
  function toggleCalendar(){
	  $("#calendar").toggle();
  }
  function onSelectDate(dateValue, elementName) {
	  if(elementName == 'pick_agreement_date'){
		 $('input[name="f_agreement_date"]').val(dateValue); 
		 
		  $('input[name="f_agreement_date"]').parents('div[data-role="fieldcontain"]').find(".error_message").empty()
		 
		 toggleCalendar();
	  }
  }
  
</script>
</div>