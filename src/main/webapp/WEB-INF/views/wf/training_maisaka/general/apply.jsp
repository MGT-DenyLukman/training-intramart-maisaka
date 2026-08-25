
<!-- 申請画面：PC購入申請の入力フォーム -->
<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="imui" uri="http://www.intra-mart.co.jp/taglib/imui"%>
<%@ taglib prefix="imart" uri="http://www.intra-mart.co.jp/taglib/core/standard"%>
<%@ taglib prefix="workflow" uri="http://www.intra-mart.co.jp/taglib/imw/workflow"%>
<%@ taglib prefix="form"   uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="f" uri="http://terasoluna.org/functions"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jstl/core"%>
<%@ taglib prefix="im" uri="http://www.intra-mart.co.jp/taglib/im-tenant"%>

<%@ page import="java.util.List"%>
<%@ page import="java.util.ArrayList"%>
<%@ page import="java.util.Map"%>
<%@ page import="java.util.HashMap"%>


<imui:head>
	<title>Training Workflow Maisaka</title>
	<workflow:workflowOpenPageCsjs />
	
	<link href="ui/css/select2.min.css" rel="stylesheet" />
    <script src="ui/js/select2.min.js" type="text/javascript"></script>
    <script src="ui/js/jquery.validate.js" type="text/javascript"></script>
    
    <style>
    	table.imui-form:not(#agreement_detail) th {
    		width: 250px;
    	}

    	table tbody tr td:last-child input[type="text"], 
    	table tbody tr td:last-child select,
    	table tbody tr td:last-child input[type="date"] {
    		width: 60%;
    	}
    	#agreement_summary {
    		width: 60%;
    		height: 100px;
    	}
    	
    	#psd_dic_reason {
    		display: none;
    		width: 80%;
    		height: 80px;
    	}
    	
    	
    	
    	.bg-warning {
    		background: yellow;
    		width: fit-content;
    	}
    	
    	
    	#payment-schedule-label,
    	#payment-schedule-button {
    		display: inline-block;
    	}
    	
    	div.dependent-checkbox {
    		display:none;
    	}
    	
    	div.row-payment__amount {
    		display: flex;
    		gap: .5rem;
    	}

		/* Target the actual error text label instead of the input box */
		label.error:not(:empty) {
		    color: #d61657 !important;
		    
		    /* FIX: 'flex' forces the whole message block onto its own new line under the input */
		    display: flex !important; 
		    align-items: center;
		    
		    vertical-align: middle;
		    margin-top:5px !important;
		    clear: both;           /* Prevents floating elements from wrapping around it */
		}
		
		/* Inject your exact custom sprite icon code before the text */
		label.error:not(:empty)::before {
		    content: "" !important;
		    display: inline-block;
		    vertical-align: middle;
		    margin-top:0px;
		    margin-right:5px;
		    
		    /* Your exact custom asset dimensions and coordinate properties */
		    background: transparent url(ui/images/d.png) no-repeat -74px -162px !important;
		    width: 18px;
		    height: 18px;
		    flex-shrink: 0;      /* Prevents the icon sprite from squeezing on narrow rows */
		}
		
		label.error:empty {
		    display: none !important;
		}
		
		#upload_file {
			position: absolute;
			z-index: -1;
		}
    	
    </style>
    
    
    <script type="text/javascript">

		var rules = {
			f_vendor: { required: true },
			f_currency : {required : true}, 
			f_total_amount : {required : true}, 
			f_agreement_status : {required : true}, 
			f_renewal : {required: {
				depends: function() {return $('#extension').prop('checked')}
			}},
			f_auto_extension: {required: true},
			f_purchased_order_req: {required: true},
			f_title: {required: true},
			f_effective_from: {required: true},
			f_effective_to: {required: true},
			f_estimated_delivery_from: {required: true},
			f_estimated_delivery_to: {required: true},
			f_agreement_summary: {id:false},
			f_start_usage_date: {required: {
				depends: function() {return $('input[name="f_purchase_category"]').val() !=9}
			}},
			f_deprec_amount_per_month: {required: {
				depends: function() {return $('input[name="f_purchase_category"]').val() !=9}
			}},
			
			
		};
		
		
		
		var messages = {
			f_vendor: {required: "Vendor Nameを入力してください！" },
			f_currency: {required: "Currencyを入力してください！" },
			f_total_amount: {required: "Total Amountを入力してください！" },
			f_agreement_status: {required: "Agreement Statusを入力してください！" },
			f_renewal: {required: "Total Duration を選択してください！" },
			f_auto_extension: {required: "Auto extensionを選択してください！" },
			f_purchased_order_req: {required: "Purchased Orderを選択してください！" },
			f_title: {required: "Titleを入力してください！" },
			f_effective_from: {required: "Effective Date Fromを入力してください！" },
			f_effective_to: {required: "Effective Date Toを入力してください！" },
			f_estimated_delivery_from: {required: "Estimated Delivery Fromを入力してください！" },
			f_estimated_delivery_to: {required: "Estimated Delivery Toを入力してください！" },
			f_start_usage_date: {required: "Starting Usage Dateを入力してください！" },
			f_deprec_amount_per_month: {required: "Deprec amount/monthを入力してください！" },

		};

    	function formatOutputNumber($element, value,  maxDecimal){
    		if(parseInt(value) < 1000) {
				$element.val(value)
    		}else{
				var val = value;
				var cleaned = val.replace(/[^\d.]/g, "");            // 数字と.以外を除去

				var dotIndex = cleaned.indexOf(".");
				if (dotIndex !== -1) {                               // 最初の.だけ残す
				  cleaned = cleaned.substring(0, dotIndex)
						  + "." + cleaned.substring(dotIndex + 1).replace(/\./g, "");
				}
				if (maxDecimal !== undefined && cleaned.indexOf(".") !== -1) {
				  var p = cleaned.split(".");                        // 小数桁数制限
				  if (p[1].length > maxDecimal) cleaned = p[0] + "." + p[1].substring(0, maxDecimal);
				}
				var formatted = cleaned.replace(/\B(?=(\d{3})+(?!\d))/g, ",");  // カンマ
				if (val !== formatted) $element.val(formatted);
    			
    		}
    	}
    	
		function formatNumberInput($input, maxDecimal) {
			  // 入力時にカンマ自動付与
			  $input.on("input", function() {
				var val = $(this).val();
				var cleaned = val.replace(/[^\d.]/g, "");            // 数字と.以外を除去

				var dotIndex = cleaned.indexOf(".");
				if (dotIndex !== -1) {                               // 最初の.だけ残す
				  cleaned = cleaned.substring(0, dotIndex)
						  + "." + cleaned.substring(dotIndex + 1).replace(/\./g, "");
				}
				if (maxDecimal !== undefined && cleaned.indexOf(".") !== -1) {
				  var p = cleaned.split(".");                        // 小数桁数制限
				  if (p[1].length > maxDecimal) cleaned = p[0] + "." + p[1].substring(0, maxDecimal);
				}
				var formatted = cleaned.replace(/\B(?=(\d{3})+(?!\d))/g, ",");  // カンマ
				if (val !== formatted) $(this).val(formatted);
			  });
			// キー入力時に数字・制御キー以外をブロック
			  $input.on("keydown", function(e) {
			    var allowed = [8, 9, 13, 27, 37, 38, 39, 40, 46];    // Backspace/Tab/Enter/矢印/Delete
			    if (allowed.indexOf(e.which) !== -1) return;
			    if (e.ctrlKey || e.metaKey) return;                  // Ctrl系ショートカット許可
			    if ((e.which >= 48 && e.which <= 57) || (e.which >= 96 && e.which <= 105)) return; // 数字
			    if (e.which === 190 && $(this).val().indexOf(".") === -1) return;  // 初回.のみ許可
			    e.preventDefault();
			  });
		}
		
		$(function() {
			formatNumberInput($('input[name="f_total_amount"]'), 2);
			formatNumberInput($('input[name="f_deprec_amount_per_month"]'), 2);
			formatNumberInput($('table#estimated_schedule tbody tr.row-payment input[name^="f_es_amount"]'), 2)		
		})
    </script>

	<script type="text/javascript">
		//function for attachment
		function triggerRequiredCheck() {
			var countUploadedFiles = $('.f_upload_file_id').length

			console.log("COUNT UPLOADED FILES", countUploadedFiles);
			if(countUploadedFiles > 0){
				$('#upload_file').val(countUploadedFiles);
			}else{
				$('#upload_file').val("");
			}
			
			workflowValidate();
			
		}

		function callbackSuccess(e, data) {
			console.log("UPLOADED FILE", data)
			var file = data.files[0];
			var fileName = file.name;
			var fileSize = file.size;
			var fileType = file.type;

			//受信した情報
			var receiveFile = data.result[0];
			var receiveFileName = receiveFile.name;
			var receivePhysicalFileName = receiveFile.physicalName;
			var receiveFileSize = receiveFile.size;

			var fileExtension = receiveFileName.split('.').pop().toLowerCase();
			
			$(".file_attachment").prepend("<div class='" + receivePhysicalFileName + "'>"
				+ "<input type='hidden' value='0' id='f_upload_file_id' name='f_upload_file_id' class='f_upload_file_id'>"
				+ "<input type='hidden' value='" + receiveFileName + "' id='f_upload_file_name' name='f_upload_file_name'>"
				+ "<input type='hidden' value='" + receivePhysicalFileName + "' id='f_upload_file_real_name' name='f_upload_file_real_name'>"
				+ "<input type='hidden' value='" + fileSize + "' id='f_upload_file_size' name='f_upload_file_size'>"
				+ "<input type='hidden' value='" + fileExtension + "' id='f_upload_file_type' name='f_upload_file_type'>"
				+ "</div>");
			
				triggerRequiredCheck();
			
		}
		function callbackRemove(e, data) {
			console.log("REMOVED FILE", data)
			var file = data.response[0];
			var fileName = file.name;
			$("." + fileName).remove();

				triggerRequiredCheck();
		}
		function callbackError(e, data) {
			console.log("ERROR FILE", data)
			var file = data.files[0];
			var fileName = file.name;
			var fileSize = file.size;
			var fileType = file.type;
			
			triggerRequiredCheck();
		}
	</script>

	<script type="text/javascript">
		$(function(){
			$('input[name="f_agreement_status"]').change(function(){
				if($(this).val() == 2){
					$("#extension-childs").show();
				}else{
					$("#extension-childs").hide();
				}
			})
			
			
			$("table#agreement_detail tr:not(.doublerow) th").attr({
				"colspan": 2,
			})

			$('input[name="f_purchase_category"]').change(function(){
				if($(this).val() != 9){
					$(".depreciation_required_asset").show();
				}else{
					$(".depreciation_required_asset").hide();
				}
			})

			$('input[name="f_agreement_classification"]').change(function(){
				if($(this).val() != 2){
					$(".pd_approval_childrens").show();
				}else{
					$(".pd_approval_childrens").hide();
				}
			})

			$('input[name="f_ec_approval_is_required"]').change(function(){
				if($(this).val() != 0){
					$(".ec_approval_yes_childrens").show();
				}else{
					$(".ec_approval_yes_childrens").hide();
				}
			})

			$('input[name="f_psd_process"]').change(function(){
				if($(this).val() == "DIC"){
					$("#psd_dic_reason").show();
				}else{
					$("#psd_dic_reason").hide();
				}
			})
			
			
			// toggle div section depends on checkbox
			$('input[name="f_checkbox_toggle"]').on("change", function() {
					const checkedValues = $('input[name="f_checkbox_toggle"]:checked').map(function() {
						return $(this).val()
					}).get();
					
					$('div.dependent-checkbox').each(function() {
						if(checkedValues.includes($(this).attr('id'))) {
							$(this).show();
						}else{
							$(this).hide();
						}
					})
					
					delete rules.f_budget_impact_to_fy;
					delete rules.f_budget_impact_month;
					delete rules.f_pl_impact_to_fy;
					delete rules.f_pl_impact_month;

					delete rules.f_asset_number;
					delete rules.f_book_value;

					delete rules.f_es_amount_1;
					delete rules.f_es_date_1;
					delete rules.f_es_total_amount;

					delete messages.f_budget_impact_to_fy;
					delete messages.f_budget_impact_month;
					delete messages.f_pl_impact_to_fy;
					delete messages.f_pl_impact_month;

					delete messages.f_asset_number;
					delete messages.f_book_value;

					delete messages.f_es_amount_1;
					delete messages.f_es_date_1;
					delete messages.f_es_total_amount;
					// section-impact
					if (checkedValues.includes('section-pl-impact')) {
					    rules.f_budget_impact_to_fy = {required: true};
					    rules.f_budget_impact_month = {required: true};
					    rules.f_pl_impact_to_fy = {required: true};
					    rules.f_pl_impact_month = {required: true};
					    
					    messages = {
					    		...messages,
								f_budget_impact_to_fy: {required: "Budget PL impact to current FY入力してください！"},
								f_budget_impact_month: {required: "Monthを入力してください！"},
								f_pl_impact_to_fy: {required: "PL Impact to current FYを入力してください！"},
								f_pl_impact_month: {required: "Monthを入力してください！"},
					    }
					}
					// section-asset
					if (checkedValues.includes('section-asset')) {
					    rules.f_asset_number = {required: true};
					    rules.f_book_value = {required: true};
					    
					    messages = {
					    		...messages,
								f_asset_number: {required: "Asset Numberを入力してください！"},
								f_book_value: {required: "Book Valueを入力してください！"},
					    }
					}
					// section-est-payment
					if (checkedValues.includes('section-payment')) {
					    rules.f_es_amount_1 = {required: true};
					    rules.f_es_date_1 = {required: true, id:false, validDate: true};
					    rules.f_es_total_amount = {required: true};
					    
					    messages = {
					    		...messages,
								f_es_amount_1: {required: "estimated amount を入力してください！"},
								f_es_date_1: {required: "estimated date を入力してください！"},
								f_es_total_amount: {required: "estimated total amount を入力してください！"},
					    		
					    }
					}			
					console.log("RULES when change checkbox", rules);
					console.log("MESSAGES when change checkbox", messages);
				})
			
			
			
		})
	</script>


	<!-- add row function -->
    <script type="text/javascript">
    	function calculateTotalAmount() {
    		var rows = Array.from($('table#estimated_schedule tbody tr.row-payment input[name^="f_es_amount"]'));

    		let totalAmount = 0;
    		rows.forEach((item) => {
    			if(item.value){
					totalAmount += parseInt(item.value.replaceAll(",", ""))
    			}
    		})
    		
    		formatOutputNumber( $('table#estimated_schedule tbody input[name="f_es_total_amount"]'), totalAmount.toString(), 2);
    		$('table#estimated_schedule tbody input[name="f_es_total_amount"]').parents('td').find('.error_message').empty();
    		$('table#estimated_schedule tbody input[name="f_es_total_amount"]').removeClass('imui-validation-error');
		

    	}
    	
    	/*
    	function refreshSequenceRowPayment() {

    			var idx = 1;
    			const esAmountStr = "f_es_amount_";
				$('table#estimated_schedule tbody input[name^="f_es_amount"]').each(function() {
					if(idx > 1) {
						$(this).attr('name', esAmountStr + idx);
						$(this).attr('id', esAmountStr + idx);
					}
					idx += 1;
				})

				var idx = 2;
    			const esDateStr = "f_es_date_";
				$('table#estimated_schedule tbody input[name^="f_es_date"].imuiCalendar').each(function() {
						$(this).attr('name', esDateStr + idx);
						$(this).attr('id', esDateStr + idx);
					idx += 1;
				})

				var idx = 2;
				$('table#estimated_schedule tbody input[type="hidden"][name^="f_es_date_"]').each(function() {
					$(this).attr('name', esDateStr + idx + "_hidden");
					$(this).attr('id', esDateStr + idx + "_hidden");
					idx += 1;
				})
				
				console.log("SEQUENCE ROW PAYMENT REFRESHED");
    		
    	}
    	*/
    
    	function deleteRowPayment(e) {
    		const closestTr = e.target.closest("tr");
    		
    		const elAmount = closestTr.querySelector('input[name^="f_es_amount"]');
    		const elDate = closestTr.querySelector('input[name^="f_es_date"][type="text"]');

			delete rules[$(elAmount).attr('name')]
			delete messages[$(elAmount).attr('name')]

			delete rules[$(elDate).attr('name')]
			delete messages[$(elDate).attr('name')]
			
			closestTr.remove();
			
			//refreshSequenceRowPayment();

			calculateTotalAmount();
    	}
    	
    	// add row
    	$(function(){
    		$('#payment-schedule-button').click(() => {
    			
    			const lastElNameSplited = $('table#estimated_schedule tbody input[name^="f_es_amount"]:last').attr("name").split("_");
    			console.log(lastElNameSplited);
    			const counter = parseInt(lastElNameSplited.pop()) + 1;
    			console.log(counter);

    			const esAmountNameOrId = "f_es_amount_" + counter;
    			const esDateNameOrId = "f_es_date_" + counter;
				var htmlStr = '<tr class="row-payment">'
				htmlStr += '<td><div class="row-payment__amount"><input oninput="calculateTotalAmount()" type="text" name=' +esAmountNameOrId+' >'
				htmlStr += '<select name="f_amount_curreny_' + counter + '" class="select-currency">'
				htmlStr += 	'<option value="IDR">IDR</option>'
				htmlStr += 	'<option value="JPY">JPY</option>'
				htmlStr += '</select>'
				htmlStr += '</div>'
				htmlStr += '<div class="error_message"></td>'
				htmlStr += '<td>'
				 htmlStr += "<input type='text' class='imuiCalendar' name='" +esDateNameOrId+"'"
				  + "value='' style='height:20px;'"
				  + "id='" +esDateNameOrId + "'>"
				  + "<input type='hidden' id='"+esDateNameOrId+"_hidden' name='"+esDateNameOrId+"_hidden'><div class='error_message'></div>"
				htmlStr += '</td>'
				htmlStr += '<td><button onclick="deleteRowPayment(event)">Remove</button></td>'
				htmlStr += "</tr>"
				
				$('table#estimated_schedule tbody tr.row-payment:last').after(htmlStr);
				
				//$("table#estimated_schedule tbody tr.row-payment:last .imuiCalendar").imuiCalendar(
				$("table#estimated_schedule tbody .imuiCalendar").imuiCalendar(
						{
							"altField":"#f_es_date_" + counter ,
							"nextText":"来月",
							"format":"yyyy\/MM\/dd",
							"dayNames":["日曜日","月曜日","火曜日","水曜日","木曜日","金曜日","土曜日"],
							"dayNamesShort":["日","月","火","水","木","金","土"],
							"prevText":"先月",
							"url":"calendar\/tag\/caljson",
							"currentText":"現在",
							"calendarId":"JPN_CAL",
							"firstDay":0,
							"closeText":"閉じる",
							"dayNamesMin":["日","月","火","水","木","金","土"],
							"monthNamesShort":["1","2","3","4","5","6","7","8","9","10","11","12"],
							"monthNames":["1月","2月","3月","4月","5月","6月","7月","8月","9月","10月","11月","12月"]
						}
					);

				rules[$("table#estimated_schedule tbody tr.row-payment:last td:first-child input").attr('name')] = {required: true};
				messages[$("table#estimated_schedule tbody tr.row-payment:last td:first-child input").attr('name')] ={required: "estimated amount を入力してください！"} ;

				rules[$("table#estimated_schedule tbody tr.row-payment:last .imuiCalendar").attr('name')] = {required: true, id:false, validDate: true};
				messages[$("table#estimated_schedule tbody tr.row-payment:last .imuiCalendar").attr('name')] ={required: "estimated date を入力してください！"} ;
				

				console.log("RULES from add row", rules);
				console.log("MESSAGES from add row", messages);
				$('table#estimated_schedule tbody tr.row-payment input[name^="f_es_amount"]').each(function() {
					formatNumberInput($(this), 2); 
				})
    		})
    		
    		
    	})
    </script>

	
	<!-- 入力バリデーション設定 -->
	<script type="text/javascript">
				//var valid = imuiValidate("#workflowOpenPageForm", rules, messages);

		
		function workflowValidate() {
				$('.error_message').empty();
				
				rules.f_effective_from = {
						...rules.f_effective_from,
						id: false,
						validDate: true,
						startDateLessThan: 'input[name="f_effective_to"]',
				}

				rules.f_effective_to = {
						...rules.f_effective_to,
						id: false,
						validDate: true,
						endDateGreaterThan: 'input[name="f_effective_from"]',
				}

				rules.f_estimated_delivery_from = {
						...rules.f_estimated_delivery_from,
						id: false,
						validDate: true,
						startDateLessThan: 'input[name="f_estimated_delivery_to"]',
				}

				rules.f_estimated_delivery_to = {
						...rules.f_estimated_delivery_to,
						id: false,
						validDate: true,
						endDateGreaterThan: 'input[name="f_estimated_delivery_from"]',
				}
				
				rules.f_start_usage_date = {
						...rules.f_start_usage_date,
						id: false,
						validDate: true,
				}
				
				rules.upload_file = {
						required: true,
				}
				
				messages.upload_file = {required:"upload file required"};
				

				var validator = $('#workflowOpenPageForm').validate({
					rules: rules,
					messages: messages,
					errorPlacement: function(error, element) {
						var $element = $(element);
						var error_message = error.get(0);
						if($element.attr('id') == 'upload_file'){
							$('#section-upload').find('.error_message').html(error_message);
						}else{
							$element.parents('td').find('.error_message').html(error_message);
						}
					},
					highlight: function(element, errorClass, validClass) {
						var $element = $(element);
						
						$element.addClass('imui-validation-error');
					},
					unhighlight: function(element, errorClass, validClass) {
						var $element = $(element);
						
						$element.removeClass('imui-validation-error');
						$element.parents('td').find('.error_message').empty();
					}
				})

				var message_startDateLessThan = "開始日は終了日より後に設定できません。 ";
				var message_endDateGreaterThan = "終了日は開始日より前に設定できません。 ";
				var message_validDate = "有効な日付を入力してください。(yyyy/MM/dd)";
				var message_ensureUploadedFileExist = "file is required!";
				
				
				$.validator.messages.startDateLessThan = message_startDateLessThan;
				$.validator.messages.endDateGreaterThan = message_endDateGreaterThan;
				$.validator.messages.validDate = message_validDate;
				$.validator.messages.ensureUploadedFileExist = message_ensureUploadedFileExist;
				
				$.validator.addMethod("startDateLessThan", function(value, element, params) {
					if(this.optional(element)) {
						return true;
					}
					
					console.log("PARAMS", params)
					
					var endDateValue = $(params).val();
					if(!endDateValue) return true;
					
					var startDate = new Date(value.replace(/\//g, '-'));
					var endDate = new Date(endDateValue.replace(/\//g, '-'));
					
					return startDate <= endDate;
				});
				

				$.validator.addMethod("endDateGreaterThan", function(value, element, params) {
					if(this.optional(element)) {
						return true;
					}
					var startDateValue = $(params).val();
					if(!startDateValue) return true;
					
					var startDate = new Date(startDateValue.replace(/\//g, '-'));
					var endDate = new Date(value.replace(/\//g, '-'));

					
					return  endDate >= startDate;
				});
				
				$.validator.addMethod("validDate", function(value, element) {
					if(this.optional(element)){
						return true;
					}
					
					var splitted = value.split("/");
					var year = parseInt(splitted[0], 10);
					var month = parseInt(splitted[1], 10) - 1;
					var day = parseInt(splitted[2], 10);
					
					var date = new Date(year, month, day);

					return date.getFullYear() === year && date.getMonth() === month && date.getDate() === day
				});

				console.log(validator)
				
				return validator.form();
			
		}
		
		
		
		$(function(){

			$('#openPage').click(function(){
				imuiResetForm("#workflowOpenPageForm");
				

				if(workflowValidate()){
                    workflowOpenPage('${f:h(ApplyForm.imwPageType)}');
                } else {
                    //imuiShowErrorMessage('インプットのエラーが発生しまいした。.', [], true, 2500, false);
                    
                    
				}
			})
		})


	</script>
	

	
	<!-- CSS Scripts -->
    <style type="text/css">
        
    </style>
</imui:head>

<workflow:workflowUserContentsAuth imwApplyBaseDate='${f:h(ApplyForm.imwApplyBaseDate)}'
            imwAuthUserCode = '${f:h(ApplyForm.imwAuthUserCode)}'
            imwFlowId='${f:h(ApplyForm.imwFlowId)}'
            imwNodeId ='${f:h(ApplyForm.imwNodeId)}'
            imwPageType = '${f:h(ApplyForm.imwPageType)}'
            imwSystemMatterId='${f:h(ApplyForm.imwSystemMatterId)}'
            imwUserDataId='${f:h(ApplyForm.imwUserDataId)}'/>
            

<div class="imui-title-small-window">
	<h1>Training Workflow Maisaka</h1>
</div>
<div class="imui-toolbar-wrap">
 	<div class="imui-toolbar-inner">
		<ul class="imui-list-toolbar">
			<li>
				<a href="javascript:void(0);" id="back">
					<span class="im-ui-icon-common-16-back"></span>
				</a>
			</li>
		</ul>
	</div>
</div>


	<imui:tabs selected="0">
		<imui:tabItem title="購入承認権" >
			<div class="imui-form-container">
		<!-- ワークフロー連携フォーム -->
<workflow:workflowOpenPage name="workflowOpenPageForm"
		id="workflowOpenPageForm"
		method="POST"
		target="_top"
		imwUserDataId="${f:h(ApplyForm.imwUserDataId)}"
		imwSystemMatterId="${f:h(ApplyForm.imwSystemMatterId)}"
		imwAuthUserCode="${f:h(ApplyForm.imwAuthUserCode)}"
		imwApplyBaseDate="${f:h(ApplyForm.imwApplyBaseDate)}"
		imwNodeId="${f:h(ApplyForm.imwNodeId)}"
		imwFlowId="${f:h(ApplyForm.imwFlowId)}"
		imwCallOriginalParams="${f:h(ApplyForm.imwCallOriginalParams)}"
		imwNextScriptPath="${f:h(ApplyForm.imwCallOriginalPagePath)}"
		>	

			<div>
				  <header class="imui-chapter-title">
					<h2>Applicant Information</h2>
				</header>
				
				<table id="applicant_information" class="imui-form tab_header">
					<tbody>
						<tr>
							<th><label>Application Number</label></th>
							<td><input name="f_application_number" value="${FormClassRow.f_application_number }" class="imui-text-readonly input_text_100"></td>
							<th><label>Application Date</label></th>
							<td><input name="f_application_date" value="${FormClassRow.f_application_date }" class="imui-text-readonly input_text_100"></td>
						</tr>
						<tr>
							<th><label>Applicant Number</label></th>
							<td><input name="f_applicant_number" value="${FormClassRow.f_applicant_number }" class="imui-text-readonly input_text_100"></td>
							<th><label>Department Name</label></th>
							<td>
								<input name="f_applicant_dept_name" value="${FormClassRow.f_applicant_dept_name }" class="imui-text-readonly input_text_100">
								<div class="error_message"><label class="error">${dept_name_err_message }</label></div>
							</td>
						</tr>
						<tr>
							<th><label>Applicant Name</label></th>
							<td><input name="f_applicant_name" value="${FormClassRow.f_applicant_name }" class="imui-text-readonly input_text_100"></td>
							<th><label>Position Name</label></th>
							<td>
								<input name="f_applicant_pos_name" value="${FormClassRow.f_applicant_pos_name }" class="imui-text-readonly input_text_100">
								<div class="error_message"><label class="error">${pos_name_err_message }</label></div>
							</td>
						</tr>
					</tbody>
				</table>
			</div>

			<div>
				  <header class="imui-chapter-title">
					<h2>Agreement Detail</h2>
				</header>

				<table id="agreement_detail" class="imui-form tab_header">
					<tbody>
						<tr>
						  <th><label class="imui-required">Counter Party (vendor name, etc)</label></th>
						  <td>
						  <input name="f_vendor" type="text" placeholder="...">
							<div class="error_message"></div>
						  </td>
						</tr>

						<tr>
						  <th><label class="imui-required">Currency</label></th>
						  <td>
						  	<select name="f_currency" disabled>
						  		<option value="IDR">IDR</option>
						  	</select>
						  </td>
						</tr>

						<tr>
						  <th><label class="imui-required">Total Amount (Without Tax)</label></th>
						  <td>
						  <input name="f_total_amount" type="text" placeholder="100,000,000.00">
							<div class="error_message"></div>
						  </td>
						</tr>

						<tr>
						  <th><label class="imui-required">Agreement Status</label></th>
						  <td>
						  		<input type="radio" id="one_time" name="f_agreement_status" value="1"/>
						  		<label for="one_time">One Time/New</label>
						  		<br>
						  		<input type="radio" id="extension" name="f_agreement_status" value="2" checked/>
						  		<label for="extension">Amendment/Extension/Renewal</label>
						  		<br>
						  		<div id="extension-childs" style="padding-left: 2em">
									  <p>Total Duration from first cooperation until now</p>
									  <input type="radio" id="gt_1" name="f_renewal" value="a" checked/>
									  <label for="gt_1">More than 1 year</label>
									  <input type="radio" id="lte_1" name="f_renewal" value="b"/>
									  <label for="lte_1">up to 1 year</label>
						  		</div>
						  		<input type="radio" id="umbrella" name="f_agreement_status" value="3"/>
						  		<label for="umbrella">Umbrella Agreement</label>
						  </td>
						</tr>

						<tr>
							<th><label class="imui-required">Include auto extension condition</label></th>
							<td>
						  		<input type="radio" id="auto_extension_y" name="f_auto_extension" value="1" checked/>
						  		<label for="auto_extension_y">Yes</label>
						  		<br>
						  		<input type="radio" id="auto_extension_n" name="f_auto_extension" value="0"/>
						  		<label for="auto_extension_n">No</label>
							</td>
						</tr>

						<tr>
							<th><label class="imui-required">Purchase Order Required</label></th>
							<td>
						  		<input type="radio" id="purchase_order_req_y" name="f_purchase_order_req" value="1" checked/>
						  		<label for="purchase_order_req_y">Yes</label>
						  		<br>
						  		<input type="radio" id="purchase_order_req_n" name="f_purchase_order_req" value="0"/>
						  		<label for="purchase_order_req_n">No</label>
							</td>
						</tr>

						<tr>
						  <th><label class="imui-required">Title described in Agreement</label></th>
						  <td>
						  <input name="f_title" type="text" placeholder="...">
							<div class="error_message"></div>
						  </td>
						</tr>

						<tr class="doublerow">
						  <th rowspan="2"><label class="imui-required">Effective Date</label></th>
						  <th><label class="imui-required">From</label></th>
						  <td>
						  <input id="f_effective_from" name="f_effective_from" type="text">
							<im:calendar floatable="true" altField="#f_effective_from" />
							<div class="error_message"></div>
						  </td>
						</tr>
						<tr class="doublerow">
						  <th><label class="imui-required">To</label></th>
						  <td>
							  <input id="f_effective_to"  name="f_effective_to" type="text">
							<im:calendar floatable="true" altField="#f_effective_to" />
							<div class="error_message"></div>
						  </td>
						</tr>

						<tr>
							<th><label class="imui-required">Related / Non Related Company</label></th>
							<td>
						  		<input type="radio" id="related_parties_y" name="f_related_company" value="1" checked/>
						  		<label for="related_parties_y">Related Parties [Shareholders (KY, MFTBC, MC, MCAH, Daimler), Subsidiary (i.e. KRM, MKM, BAS, BBD, BMC, etc.), Affiliates (i.e. DSF, BSI, MMKSI, MMKI, etc.)]</label>
						  		<br>
						  		<input type="radio" id="related_parties_n" name="f_related_company" value="0"/>
						  		<label for="related_parties_n">Non Related Parties</label>
						  		<br>
						  		<p class="bg-warning"><i>Consult with Legal. SHR may be required</i></p>
							</td>
						</tr>

						<tr class="doublerow">
						  <th rowspan="2"><label class="imui-required">Estimated Delivery Schedule</label></th>
						  <th><label class="imui-required">From</label></th>
						  <td>
						  <input id="f_estimated_delivery_from"  name="f_estimated_delivery_from" type="text">
							<im:calendar floatable="true" altField="#f_estimated_delivery_from" />
							<div class="error_message"></div>
						  </td>
						</tr>
						<tr class="doublerow">
						  <th><label class="imui-required">To</label></th>
						  <td>
								  <input id="f_estimated_delivery_to"  name="f_estimated_delivery_to" type="text">
								<im:calendar floatable="true" altField="#f_estimated_delivery_to" />
								<div class="error_message"></div>
						  </td>
						</tr>
						
						<tr>
						  <th><label>Agreement Summary (main points only) (In case of contract in foreign currency need to describe exchange rate)</label></th>
						  <td>
								  <textarea id="agreement_summary" name="f_agreement_summary"></textarea>
								<div class="error_message"></div>
						  </td>
						</tr>
							
					</tbody>
				</table>
		</div>
		


			<div>
				  <header class="imui-chapter-title">
					<h2>Depreciation Check</h2>
				</header>

				<table id="depreciation_check" class="imui-form tab_header">
					<tbody>
						<tr>
						  <th><label class="imui-required">Purchase Category</label></th>
						  <td>
						  		<input type="radio" id="tangible_asset" name="f_purchase_category" value="1" checked/>
						  		<label for="tangible_asset">Tangible Asset</label>

						  		<input type="radio" id="intangible_asset" name="f_purchase_category" value="0"/>
						  		<label for="intangible_asset">Intangible Asset</label>

						  		<input type="radio" id="non_asset" name="f_purchase_category" value="9"/>
						  		<label for="non_asset">Non-Asset</label>
						  </td>
						</tr>
						<tr class="depreciation_required_asset">
						  <th><label class="imui-required">Starting Usage Date (Required if Asset)</label></th>
						  <td>
								  <input id="f_start_usage_date"  name="f_start_usage_date" type="text">
								<im:calendar floatable="true" altField="#f_start_usage_date" />
								<div class="error_message"></div>
							  </td>
						</tr>
						<tr class="depreciation_required_asset">
						  <th><label class="imui-required">Deprec Amount/Month (Required if Asset)</label></th>
						  <td>
						  <input name="f_deprec_amount_per_month" type="text" placeholder="...">
							<div class="error_message"></div>
						</td>
						</tr>
					</tbody>
					</table>
				</div>
				
			<div id="section-checkbox">
				<header class="imui-chapter-title">
						<h2>Checkbox Toggle</h2>
				</header>
				
					<table class="imui-form tab_header">
							<tbody>
								<tr>
										<th>
												<label>Check item that need to be filled</label>
										</th>
										<td>
											<label><input type="checkbox" name="f_checkbox_toggle" value="section-pl-impact" id="checkbox-section-pl-impact">PL Impact</label> <br>
											<label><input type="checkbox" name="f_checkbox_toggle" value="section-asset" id="checkbox-section-asset"> Asset</label> <br>
											<label><input type="checkbox" name="f_checkbox_toggle" value="section-payment" id="checkbox-section-payment"> Payment</label> <br>
											<label><input type="checkbox" name="f_checkbox_toggle" value="section-upload" id="checkbox-section-upload"> Upload</label> <br>
										</td>
								</tr>
							</tbody>
					</table>
			</div>

				<div id="section-pl-impact" class="dependent-checkbox">
					  <header class="imui-chapter-title">
						<h2>PL Impact</h2>
					</header>

					<table id="pl_impact" class="imui-form tab_header">
						<tbody>
							<tr>
									<th><label class="imui-required">Budget PL impact to current FY</label></th>
									<th><label class="imui-required">Month</label></th>
									<th><label class="imui-required">PL Impact to current FY</label></th>
									<th><label class="imui-required">Month</label></th>
							</tr>
							<tr>
									<td>
										<input type="text" name="f_budget_impact_to_fy"/>
										<div class="error_message"></div>
									</td>
									<td>
											<select name="f_budget_impact_month">
													<c:forEach var="i" begin="1" end="12">
													<option value="${i}">${i}月</option> 
													</c:forEach>
											</select>
									</td>
									<td>
										<input type="text" name="f_pl_impact_to_fy"/>
										<div class="error_message"></div>
									</td>
									<td>
											<select name="f_pl_impact_month">
													<c:forEach var="i" begin="1" end="12">
													<option value="${i}">${i}月</option> 
													</c:forEach>
											</select>
									</td>
							</tr>
						</tbody>
					</table>
			</div>
					
					
					
				<div id="section-asset" class="dependent-checkbox">
					  <header class="imui-chapter-title">
						<h2>Asset</h2>
					</header>

					<table id="asset" class="imui-form tab_header">
						<tbody>
							<tr>
									<th><label class="imui-required">Asset Number</label></th>
									<th><label class="imui-required">Book Value</label></th>
							</tr>
							<tr>
									<td>
										<input type="text" name="f_asset_number"/>
										<div class="error_message"></div>
									</td>
									<td>
										<input type="text" name="f_book_value"/>
										<div class="error_message"></div>
									</td>
							</tr>
						</tbody>
					</table>
			</div>
					
					
					<div id="section-payment" class="dependent-checkbox">
					  <header class="imui-chapter-title">
						<h2>Estimated Schedule (Payment Conditions)</h2>
					</header>

					<table id="estimated_schedule" class="imui-form tab_header">
						<tbody>
							<tr>
								<th colspan="3"><label class="imui-required" id="payment-schedule-label">Payment (Total Cash flow Impact)</label></th>
							</tr>
							<tr class="row-header">
									<th><label class="imui-required">Amount</label></th>
									<th><label class="imui-required">Date</label></th>
									<th><label class=""><button id="payment-schedule-button">+ Add Row</button></label></th>
							</tr>
							<tr class="row-payment">
									<td>
										<div class="row-payment__amount">
										<input oninput="calculateTotalAmount()" type="text" name="f_es_amount_1"/>
										<select name="f_amount_currency_1" class="select-currency">
												<option value="IDR">IDR</option>
												<option value="JPY">JPY</option>
										</select>
										</div>
										<div class="error_message"></div>
									</td>
									<td>
										<input type="text" name="f_es_date_1"  id="f_es_date_1"/>
									<im:calendar floatable="true" altField="#f_es_date_1" />
										<div class="error_message"></div>
									</td>
									<td></td>
							</tr>
							<tr>
									<th><label class="imui-required">Total Amount</label></th>
							</tr>
							<tr>
									<td>
									<input type="text"  name="f_es_total_amount" readonly/>
										<div class="error_message"></div>
									</td>
							</tr>
						</tbody>
					</table>
				</div>
					
					<div>
					  <header class="imui-chapter-title">
						<h2>Agreement Classification</h2>
					</header>

					<table id="agreement_classification" class="imui-form tab_header">
						<tbody>
							<tr>
									<th><label class="imui-required">Agreement Classification</label></th>
									<td>
											<input type="radio" id="pd_approval" name="f_agreement_classification" value="1" checked/>
											<label for="pd_approval">PD Approval (either one of condition below)</label>
												<div class="pd_approval_childrens" style="padding-left: 2em">
														<input type="radio" id="gte_1_billion" name="f_agreement_classification_1" value="1" checked/>
														<label for="gte_1_billion">Agreement with amount is equal or more than 1 billion</label>
														<br>
														<input type="radio" id="gte_12_months" name="f_agreement_classification_1" value="2"/>
														<label for="gte_12_months">Period is equal or more than 12 months</label>
														<br>
														<div>
															<input type="radio" id="related_parties" name="f_agreement_classification_1" value="3"/>
															<label for="related_parties">Agreement related to spesific party</label>
															<br>
															<p style="padding-left: 2em"><i>- Bank, Related Parties, Dealer, Consulatant/Lawyer/Appraiser (Vendor head-hunter, ISO Certification, HR system development, etc), Government, Production(Component and Parts), Customer, Etc</i></p>
														</div>

														<input type="radio" id="special_issue" name="f_agreement_classification_1" value="4"/>
														<label for="special_issue">Special issue</label>
														<br>
														<p style="padding-left: 2em"><i>New project/Issue (more than 50 M), Not included in Budget Plan</i></p>

														<input type="radio" id="direct_procurement" name="f_agreement_classification_1" value="5"/>
														<label for="direct_procurement">Direct Procurement due to either of the 2 cases below</label>
														<br>
														<div style="padding-left: 2em">
															<ul style="list-style-type: decimal">
																	<li><i>Emergency procurement</i></li>
																	<li><i>Spesific Goods / Items (refere to PSD Guideline)</i></li>
															</ul>
														</div> 
												</div>
											<div>
												<input type="radio" id="dic_approval" name="f_agreement_classification" value="2"/>
												<label for="dic_approval">DIC Director Approval</label>
											</div>
									</td>
							</tr>
							<tr>
									<th><label class="imui-required">EC Approval is Required or Not</label></th>
									<td>
											<input type="radio" id="ec_approval_yes" name="f_ec_approval_is_required" value="1" checked/>	
											<label for="ec_approval_yes">Yes</label>
												<div class="ec_approval_yes_childrens" style="padding-left: 2em">
														<input type="radio" id="amount_gte_1_billion" name="f_ec_approval_yes" value="1" checked/>	
														<label for="amount_gte_1_billion">Amount is equal or more than 1 billion</label>
														<br>	
														<input type="radio" id="period_gt_12_month" name="f_ec_approval_yes" value="2"/>	
														<label for="period_gt_12_month">Period is equal or more than 12 months</label>
														<br>	
														<input type="radio" id="escalate_issue" name="f_ec_approval_yes" value="3"/>	
														<label for="escalate_issue">Director believes it is necessary to escalate the issue to EC</label>
												</div>
												<div>
														<input type="radio" id="ec_approval_no" name="f_ec_approval_is_required" value="0"/>	
														<label for="ec_approval_no">No</label>
												</div>
									</td>
							</tr>
						</tbody>
					</table>
				</div>

					
					<div>
					  <header class="imui-chapter-title">
						<h2>PSD Check (by UH or DH, PSD)</h2>
					</header>

					<table id="psd_check" class="imui-form tab_header">
						<tbody>
								<tr>
										<th><label class="imui-required">PSD Area or Non-PSD Area (Based on Guideline)</label></th>
										<td>
												<input type="radio" id="psd" name="f_psd_area_bog" value="1" checked/>	
												<label for="psd">PSD (go to #2)</label>
												<br>
												<input type="radio" id="psd_end" name="f_psd_area_bog" value="0"/>	
												<label for="psd_end">Non-PSD (End)</label>
										</td>
								</tr>
								<tr>
										<th><label class="imui-required">In PSD Area, PSD Process or DIC Process</label></th>
										<td>
												<input type="radio" id="psd_2" name="f_psd_process" value="PSD" checked/>	
												<label for="psd_2">PSD (Pitching result attached)</label>
												<br>
												<input type="radio" id="psd_dic" name="f_psd_process" value="DIC"/>	
												<label for="psd_dic">DIC (Please describe the reason in the below)</label>
												<textarea id="psd_dic_reason" name="f_dic_reason"></textarea>
										</td>
								</tr>
						</tbody>
					</table>
					</div>

					<div>
					  <header class="imui-chapter-title">
						<h2>Compliance Check By CCO</h2>
					</header>

					<table id="compliance_check" class="imui-form tab_header">
						<tbody>
								<tr>
										<th><label class="imui-required">D / D Process Required</label></th>
										<td>
												<input type="radio" id="dd_process_yes" name="f_dd_process" value="1" checked/>	
												<label for="dd_process_yes">Yes</label>
												<input type="radio" id="dd_process_no" name="f_dd_process" value="0" />	
												<label for="dd_process_no">No</label>
										</td>
								</tr>
								<tr>
										<th><label class="imui-required">Anti Bribery Clause Include</label></th>
										<td>
												<input type="radio" id="anti_bribery_yes" name="f_anti_bribery" value="1" />	
												<label for="anti_bribery_yes">Yes</label>
												<input type="radio" id="anti_bribery_no" name="f_anti_bribery" value="0"  checked/>	
												<label for="anti_bribery_no">No</label>
										</td>
								</tr>
								<tr>
										<th><label class="imui-required">Audit Right Included</label></th>
										<td>
												<input type="radio" id="audit_right_yes" name="f_audit_right" value="1"/>	
												<label for="audit_right_yes">Yes</label>
												<input type="radio" id="audit_right_no" name="f_audit_right" value="0" checked />	
												<label for="audit_right_no">No</label>
										</td>
								</tr>
						</tbody>
					</table>
					</div>
					
					
				 <div class="imui-form-container-full">
					  <header class="imui-chapter-title">
						<h2>Filled By Legal</h2>
					</header>

					<table id="filled_by_legal" class="imui-form tab_header">
						<tbody>
								<tr>
										<th><label class="imui-required">Agreement Number</label></th>
										<td><input type="text" name="f_agreement_number"/></td>
								</tr>
								<tr>
										<th><label class="imui-required">Agreement Date</label></th>
										<td>
												<input type="text" id="agreement_date"  name="f_agreement_date"/>
												<im:calendar floatable="true" altField="#agreement_date" />
										</td>
								</tr>
						</tbody>
					</table>
				</div>
					
					

					<!-- START COMMENTED -->
					<!-- 
					-->
					<!-- END COMMENTED -->
					
						<div class="file_attachment">
						</div>	
						
					


			
</workflow:workflowOpenPage>
				
					 <div id="section-upload" class="dependent-checkbox imui-form-container-full">
						  <header class="imui-chapter-title">
							<h2>Upload Document by DIC : Agreement, DD, etc</h2>
						</header>

						<table class="imui-form">
							<tbody>
									<tr>
											<th><label class="imui-required">Upload File</label></th>
										<td>
											<imui:fileUpload
													enableDelete="true"
													uniqueFileName="true"
													storeTo="file_attachment/"
													onSuccess="callbackSuccess"
													onError="callbackError"
													onRemove="callbackRemove"
											/>
											<div class="error_message"></div>
										</td>
									</tr>
							</tbody>
						</table>
					  <header class="imui-chapter-title">
						<h2>To see the uploaded document</h2>
					</header>

					<table id="uploaded_document" class="imui-form tab_header">
					</table>
					</div>
			</div>
		</imui:tabItem>

		<imui:tabItem title="その他" >
			<!-- 
			<div class="imui-form-container">
				
			</div> 
			-->
			
		</imui:tabItem>
	</imui:tabs>

<!-- アクションボタン（Apply/Re-ApplyはpageTypeで分岐） -->
<div class="imui-operation-parts">
	<c:if test="${empty dept_name_err_message  && empty pos_name_err_message }">
	<imart:decision case="0" value="${f:h(ApplyForm.imwPageType)}">	
		<input type="button" value='Apply' id="openPage" name="openPage" class="imui-large-button"
			escapeXml="true" escapeJs="false" />
	</imart:decision>
	<imart:decision case="3" value="${f:h(ApplyForm.imwPageType)}">
		<input type="button" value='Re-Apply' id="openPage" name="openPage" class="imui-large-button"
			escapeXml="true" escapeJs="false" />
	</imart:decision>
	</c:if>

</div>

<!-- 戻る用フォーム -->
<form name="backForm" id="backForm" method="POST" action="${f:h(ApplyForm.imwCallOriginalPagePath)}">
    <input type="hidden" name=imwCallOriginalParams value="${f:h(ApplyForm.imwCallOriginalParams)}" />
</form>


    <script src="ui/js/script-detail-reapply-after-load.js" type="text/javascript"></script>