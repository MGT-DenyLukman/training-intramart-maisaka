
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

		})

// ============================ END when on load detail or process =============================

		console.log("script from external reapply detail no tame")
