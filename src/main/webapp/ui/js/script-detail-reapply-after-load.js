
// ============================ START when on load detail or process =============================
	
		$(document).ready(function() {
			if($('input[name="f_agreement_status"]')[1].checked == true){
				$("#extension-childs").show();
			}else{
				$("#extension-childs").hide();
			}

			if($('input[name="f_purchase_category"]')[2].checked == false){
				$(".depreciation_required_asset").show();
			}else{
				$(".depreciation_required_asset").hide();
			}
			
			if(($('input[name="f_agreement_classification"]')[0]).checked == true){
				$(".pd_approval_childrens").show();
			}else{
				$(".pd_approval_childrens").hide();
			}

			if(($('input[name="f_ec_approval_is_required"]')[0]).checked == true){
				$(".ec_approval_yes_childrens").show();
			}else{
				$(".ec_approval_yes_childrens").hide();
			}

    		if(($('input[name="f_psd_area_bog"]')[0]).checked == true){
				$('#f_psd_area_second').show();
			}else{
				$('#f_psd_area_second').hide();
    		}   		

    		if(($('input[name="f_psd_process"]')[1]).checked == true){
				$('#psd_dic_reason').show();
			}else{
				$('#psd_dic_reason').hide();
    		}   		

		})

// ============================ END when on load detail or process =============================

		console.log("script from external reapply detail no tame")
