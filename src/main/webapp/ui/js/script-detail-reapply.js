
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
		})





// ============================ START attachment =============================


		//function for attachment
		function callbackSuccess(e, data) {
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
				+ "<input type='hidden' id='f_upload_file_id' name='f_upload_file_id'>"
				+ "<input type='hidden' value='" + receiveFileName + "' id='f_upload_file_name' name='f_upload_file_name'>"
				+ "<input type='hidden' value='" + receivePhysicalFileName + "' id='f_upload_file_real_name' name='f_upload_file_real_name'>"
				+ "<input type='hidden' value='" + fileExtension + "' id='f_upload_file_type' name='f_upload_file_type'>"
				+ "</div>");
		}
		function callbackRemove(e, data) {
			var file = data.response[0];
			var fileName = file.name;
			$("." + fileName).remove();
		}
		function callbackError(e, data) {
			var file = data.files[0];
			var fileName = file.name;
			var fileSize = file.size;
			var fileType = file.type;
			
		}
// ============================ END attachment =============================







		
		






// ============================ START when apply =============================

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
			
			
		})

		


		/*
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
			f_start_usage_date: {required: {
				depends: function() {return $('input[name="f_purchase_category"]').val() !=9}
			}},
			f_deprec_amount_per_month: {required: {
				depends: function() {return $('input[name="f_purchase_category"]').val() !=9}
			}}
		};
		
		var messages = {
			f_vendor: {required: "Vendor Nameを入力してください！" },
			f_currency: {required: "Currencyを入力してください！" },
			f_total_amount: {required: "Total Amountを入力してください！" },
			f_agreement_status: {required: "Agreement Statusを入力してください！" },
			f_renewal: {required: "Total Duration を選択してください！" },
			f_auto_etxension: {required: "Auto extensionを選択してください！" },
			f_purchased_order_req: {required: "Purchased Orderを選択してください！" },
			f_title: {required: "Titleを入力してください！" },
			f_effective_from: {required: "Effective Date Fromを入力してください！" },
			f_effective_to: {required: "Effective Date Toを入力してください！" },
			f_estimated_delivery_from: {required: "Estimated Delivery Fromを入力してください！" },
			f_estimated_delivery_to: {required: "Estimated Delivery Toを入力してください！" },
			f_start_usage_date: {required: "Starting Usage Dateを入力してください！" },
			f_deprec_amount_per_month: {required: "Deprec amount/monthを入力してください！" },
		};
		
		$(function(){
			$('#openPage').click(function(){
				console.log($('#openPage').val(), "clicked");
				var valid = imuiValidate("#workflowOpenPageForm", rules, messages);
				
				if(valid){
                    workflowOpenPage('${f:h(ApplyForm.imwPageType)}');
                } else {
                    imuiShowErrorMessage('インプットのエラーが発生しまいした。.', [], true, 2500, false);
				}
			})
		})
		*/

// ============================ END when apply =============================




		console.log("script from external")
