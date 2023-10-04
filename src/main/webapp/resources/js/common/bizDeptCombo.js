function fnBizComboBoxInit(id){
	
	if($('#'+id)){
		var bizList = fnGetBizList();
		bizList.unshift({biz_name : "전체", biz_seq : ""});
		var itemType = $("#" + id).kendoComboBox({
			dataSource : bizList,
			dataTextField: "biz_name",
			dataValueField: "biz_seq",
			index: 0,
			change:function(){
				fnBizChange();
			}
	    });
	}
}
function fnGetBizList(){
 
	var result = {};
	var params = {};
    var opt = {
    		url     : _g_contextPath_ + "/common/getBizList",
            async   : false,
            data    : params,
            successFn : function(data){
            	result = data.allBiz;
            }
    };
    acUtil.ajax.call(opt);
	return result;
}

function fnBizChange(){
	var obj = $('#bizName').data('kendoComboBox');
	fnTpfDeptComboBoxInit('deptName');
	/* $('#txtDeptCd').val(obj._old);
	$('#txtDeptName').val(obj._prev); */
	$('#bizSeq').val(obj._old);
}

function fnTpfDeptComboBoxInit(id){
	
	if($('#'+id)){
		var deptList = fnTpfGetDeptList();
		deptList.unshift({dept_name : "전체", dept_name : "전체"});
		var itemType = $("#" + id).kendoComboBox({
			dataSource : deptList,
			dataTextField: "dept_name",
			dataValueField: "dept_name",
			index: 0,
			change:function(){
				fnDeptChange();
			}
	    });
	}
}
function fnTpfGetDeptList(){
 
	var result = {};
	var params = {
			
			bizSeq : $('#bizName').val()
			
	};
    var opt = {
    		url     : _g_contextPath_ + "/common/getDeptList",
            async   : false,
            data    : params,
            successFn : function(data){
            	result = data.allDept;
            }
    };
    acUtil.ajax.call(opt);
	return result;
}

function fnDeptChange(){
	var obj = $('#deptName').data('kendoComboBox');
	/* $('#txtDeptCd').val(obj._old);
	$('#txtDeptName').val(obj._prev); */
	$('#deptSeq').val(obj._old);
}