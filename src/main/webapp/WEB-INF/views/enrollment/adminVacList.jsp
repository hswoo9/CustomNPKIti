<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="tiles" uri="http://tiles.apache.org/tags-tiles" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jstl/fmt_rt" %>
<%@ page import="main.web.BizboxAMessage" %>
<%
    String langCode = (String) session.getAttribute("langCode");
    langCode = langCode == null ? "kr" : langCode.toLowerCase();

    String culture = "ko-KR";

    if (langCode.equals("en")) {
        culture = "en-US";
    } else if (langCode.equals("jp")) {
        culture = "ja-JP";
    } else if (langCode.equals("cn")) {
        culture = "zh-CN";
    }
%>

<jsp:useBean id="year" class="java.util.Date" />
<jsp:useBean id="mm" class="java.util.Date" />
<jsp:useBean id="dd" class="java.util.Date" />
<jsp:useBean id="weekDay" class="java.util.Date" />
<jsp:useBean id="nowDate" class="java.util.Date" />
<fmt:formatDate value="${nowDate}" var="nowDate" pattern="yyyy-MM-dd" />
<fmt:formatDate value="${year}" var="year" pattern="yyyy" />
<fmt:formatDate value="${mm}" var="mm" pattern="MM" />
<fmt:formatDate value="${dd}" var="dd" pattern="dd" />
<jsp:useBean id="toDay" class="java.util.Date" />
<script>
    var langCode = "<%=langCode%>";
</script>
<script type="text/javascript" src="<c:url value='/js/common_vacation.js'/>"></script>
<script type="text/javascript" src='<c:url value="/js/ac/ac/acUtil.js"></c:url>'></script>
<script type="text/javascript" src='<c:url value="/js/vacation.js?v=${toDay}"></c:url>'></script>
<style type="text/css">
    .k-header .k-link{
        text-align: center;

    }
    .k-grid-content>table>tbody>tr
    {
        text-align: center;
    }
    .k-grid th.k-header,
    .k-grid-header
    {
        background : #F0F6FD;
    }
    #requestDeptSeq_listbox{
		font-weight: 400 !important;
	}
	#vacKind_listbox{
		font-weight: 400 !important;
	}
	.appDocClass{
		text-decoration: revert;
	}
	.fileBtnDown input[type="button"]{
		background: #1088e3;
	    height: 24px;
	    padding: 0 11px;
	    color: #fff;
	    border: none;
	    font-weight: bold;
	    border-radius: 0px;
	}
</style>

<!-- iframe wrap -->
<div class="iframe_wrap" style="min-width:1100px">

    <!-- 컨텐츠타이틀영역 -->
    <div class="sub_title_wrap">

        <div class="title_div">
            <h4>휴가리스트</h4>
        </div>
    </div>

    <div class="sub_contents_wrap">
        <p class="tit_p mt5 mt20">휴가 관리</p>
        <form id="adminVacSch" name="adminVacSch">
            <div class="top_box" style="margin-bottom: 5px;">
                <dl>
                    <dt class="ar" style="width: 65px">조회년도</dt>
                    <dd>
                        <input type="text" id="selectYr" name="selectYr" value="${year}"
                               style="width: 150px" />
                    </dd>
                    <dt class="ar" style="width: 65px">휴가종류</dt>
                    <dt class="ar">
                        <input type="text" id="vacKind" />

                    </dt>
                    <dt class="ar" style="width: 65px">부서</dt>
                    <dt class="ar">
                        <input type="text" id="requestDeptSeq" />

                    </dt>
                    <dt class="ar" style="width: 65px">이름</dt>
                    <dt class="ar">
                        <input type="text" id="empNameSearch" name="empNameSearch"
                               style="width: 130px;"> <input type="hidden"
                                                             id="empSeqSearch" name="empSeqSearch">
                    </dt>
                    <dd>
                        <input type="button" id="empSearch" value="검색" />
                    </dd>
                </dl>
            </div>
        </form>
        <div id="topGrid" class="com_ta2 mt15"></div>

        <div class="com_ta2 mt15">
            <p class="tit_p mt5 mt20">사용일수 내역</p>
            <div class="top_box">
                <div id="grid"></div>
            </div>
        </div>
    </div>
</div>

<!-- 사원검색팝업 -->
<div class="pop_wrap_dir" id="empPopUp" style="width: 600px; margin: auto;">
    <div class="pop_head">
        <h1>사원 선택</h1>
    </div>
    <div class="pop_con">
        <div class="top_box">
            <dl>
                <dt class="ar" style="width: 65px;">성명</dt>
                <dd>
                    <input type="text" id="emp_name" style="width: 120px" />
                </dd>
                <dd>
                    <input type="button" onclick="empGridReload();" id="searchButton"
                           value="검색" />
                </dd>
            </dl>
        </div>
        <div class="com_ta mt15" style="">
            <div id="empGrid"></div>
        </div>
    </div>
    <!-- //pop_con -->

    <div class="pop_foot">
        <div class="btn_cen pt12">
            <input type="button" class="gray_btn" id="cancle" value="닫기" />
        </div>
    </div>
    <!-- //pop_foot -->
</div>
<!-- //pop_wrap -->

<!-- 개인휴가현황 팝업창 -->
<div class="pop_wrap_dir" id="bottomPopup" style="width: 1200px; margin: auto;">
    <div class="pop_head">
        <h1>특별휴가 목록</h1>
    </div>
    <input type="hidden" id="empSeqPopup" />
    <input type="hidden" id="deptNamePopup" />
	<div class="pop_con" style="padding-bottom: 0px;">
		<div class="top_box">
		    <dl>
		        <dt class="ar" style="width: 65px;">시작일</dt>
		        <dd>
		            <input type="text" id="sDt" style="width: 120px" value="${year}-01-01"/>
		        </dd>
		         <dt class="ar" style="width: 65px;">종료일</dt>
		        <dd>
		            <input type="text" id="eDt" style="width: 120px" value="${year}-12-31"/>
		        </dd>
		    </dl>
		</div>
	</div>
    <div class="pop_con" style="padding-top: 0px;">
        <div class="com_ta mt15">
            <div id="empKindsGrid"></div>
        </div>
    </div>
    <div class="pop_con">
        <h1>사용이력</h1>
        <input type="hidden" id="speclSn" />
        <div class="com_ta mt15">
			<div id="bottomGrid" class="com_ta2 mt15"></div>
        </div>
    </div>
    <div class="pop_foot">
        <div class="btn_cen pt12">
            <input type="button" class="gray_btn" id="bottomCancle" value="닫기" />
        </div>
    </div>
</div>
<!-- 미제출 증빙파일 리스트 -->
<div class="pop_wrap_dir" id="fileCountPopUp" style="width: 1000px; text-align: center;">
	<div class="pop_head">
		<h1>미등록 목록</h1>
	</div>
	<div class="pop_con">
		<div class="top_box">
		</div>
		<div class="com_ta mt15" style="">
			<div id="fileGrid"></div>
		</div>
	</div>
	<div class="pop_foot">
		<div class="btn_cen pt12">
			<input type="button" class="gray_btn" id="countCancle" value="닫기" />
		</div>
	</div>
</div>
<jsp:include page="/WEB-INF/views/templates/common/commonForm.jsp" flush="true"></jsp:include>
<script type="text/javascript">

    // global Values
    var parameters = [];
    parameters.deptName = null;
    parameters.empSeq = null;
    parameters.year = null;

    //년월 달력 초기화
    $("#selectYr").kendoDatePicker({
        // defines the start view
        start : "decade",

        // defines when the calendar should return date
        depth : "decade",

        // display month and year in the input
        format : "yyyy",
        parseFormats : [ "yyyy" ],

        // specifies that DateInput is used for masking the input element
        culture : "ko-KR",
        dateInput : true,
        change : function(e){
        	$("#bottomGrid").empty();
        	$("#bottomGrid").css("height", "0");
        	subGrid();
		}
    });
    
    $("#sDt").kendoDatePicker({
        // defines the start view
        start : "month",

        // defines when the calendar should return date
        depth : "month",

        // display month and year in the input
        format : "yyyy-MM-dd",
        parseFormats : [ "yyyy-MM-dd" ],

        // specifies that DateInput is used for masking the input element
        culture : "ko-KR",
        dateInput : true,
        change : function(e){
        	$("#bottomGrid").empty();
        	
        	var selectNum = $("#empKindsGrid").data("kendoGrid").select();
        	console.log(selectNum);
        	callSpcVacList($("#empSeqPopup").val(), $("#deptNamePopup").val(), "", $("#sDt").val(), $("#eDt").val());
		}
    });
  var check;
    $("#eDt").kendoDatePicker({
        // defines the start view
        start : "month",

        // defines when the calendar should return date
        depth : "month",

        // display month and year in the input
        format : "yyyy-MM-dd",
        parseFormats : [ "yyyy-MM-dd" ],

        // specifies that DateInput is used for masking the input element
        culture : "ko-KR",
        dateInput : true,
        change : function(e){
        	$("#bottomGrid").empty();
        	
        	var selectNum = $("#empKindsGrid").data("kendoGrid").select();
        	check = $("#empKindsGrid").data("kendoGrid");
        	console.log(selectNum);
        	callSpcVacList($("#empSeqPopup").val(), $("#deptNamePopup").val(), "", $("#sDt").val(), $("#eDt").val());
		}
    });
    
    var empSeq = "<c:out value='${loginVO.uniqId}'/>";
    var year = '${year}';

    //사원 검색 엔터키
    $(document).keypress(function(e) {
        if (e.keyCode == 13) {
            e.preventDefault();
        }
    });

    $("#empNameSearch").keydown(function(keyNum) { //현재의 키보드의 입력값을 keyNum으로 받음
        if (keyNum.keyCode == 13) { // keydown으로 발생한 keyNum의 숫자체크 // 숫자가 enter의 아스키코드 13과 같으면 // 기존에 정의된 클릭함수를 호출
            $("#empSearch").click();
        }
    });

    //사원 검색 팝업창
    $(document).keypress(function(e) {
        if (e.keyCode == 13) {
            e.preventDefault();
        }
    });

    $("#emp_name").keydown(function(keyNum) { //현재의 키보드의 입력값을 keyNum으로 받음
        if (keyNum.keyCode == 13) { // keydown으로 발생한 keyNum의 숫자체크 // 숫자가 enter의 아스키코드 13과 같으면 // 기존에 정의된 클릭함수를 호출
            $("#searchButton").click();
        }
    });

    //사원검색
    var empWindow = $("#empPopUp");

    //검색ID
    empSearch = $("#empSearch");
    //검색 클릭(팝업호출)
    empSearch.click(function() {
        empWindow.data("kendoWindow").open();
        $("#emp_name").val($("#empNameSearch").val());
        empGridReload();
        empSearch.fadeOut();
    });

    //특별휴가 목록 팝업
    var bottomPopup = $("#bottomPopup");
    bottomPopup.kendoWindow({
        width : "1200px",
        height : "770px",
        visible : false,
        actions : [ "Close" ],
        close : onClose
    }).data("kendoWindow").center();
    $("#bottomCancle").click(function() {
    	//휴가별 상세내역
    	$("#bottomGrid").empty();
        bottomPopup.data("kendoWindow").close();
    });
    
    //특별휴가 내역 상세보기 클릭 팝업창
    function openBottomPopup(empSeq, deptName){
    	$("#empSeqPopup").val(empSeq);
    	$("#deptNamePopup").val(deptName);
    	callEmpKindsGrid(empSeq, "${year}");    	
    	//시작일 종료일 넣어주기
    	callSpcVacList(empSeq, deptName, "", $("#sDt").val(), $("#eDt").val());
    	bottomPopup.data("kendoWindow").open();
    }
    
    
    //사원 검색
    function empGridReload() {
        $("#empGrid").data('kendoGrid').dataSource.read();
    }

    //팝업 X 닫기버튼 이벤트
    function onClose() {
        gridReload();
        empSearch.fadeIn();
    }

    //닫기 이벤트
    $("#cancle").click(function() {
        gridReload();
        empWindow.data("kendoWindow").close();
    });

    //팝업 초기화
    empWindow.kendoWindow({
        width : "700px",
        height : "750px",
        visible : false,
        actions : [ "Close" ],
        close : onClose
    }).data("kendoWindow").center();
    //사원검색끝

    var vacKind = [
        {"code": "0", "code_kr":"연가"},
        {"code": "1", "code_kr":"특별휴가"}
    ];

    $(function(){
        mainGrid();

        empGrid();
        //부서 콤보박스 초기화
        fnTpfDeptComboBoxInit('requestDeptSeq');

        $("#vacKind").kendoComboBox({
            dataTextField : "code_kr",
            dataValueField : "code",
            index : 0,
            dataSource : vacKind,
            change:function(e){
            	$("#bottomGrid").empty();
            	$("#bottomGrid").css("height", "0");
                subGrid();
            }
        });

        subGrid();
        $(".k-input").attr("readonly", "readonly");
        
        var myfileCount = $("#fileCountPopUp");
		myfileCount.kendoWindow({
			 width:  "1000px",
			 height: "400px",
		     visible:  false,
		     actions: ["Close"]
		}).data("kendoWindow").center();
		
		$("#countCancle").click(function() {
			myfileCount.data("kendoWindow").close();
		});
		
    });

    //부서 콤보박스
    function fnTpfDeptComboBoxInit(id) {
        if ($('#' + id)) {
            var deptList = fnTpfGetDeptList();
            deptList.unshift({
                dept_name : '전체',
                dept_value : ""
            });
            var itemType = $("#" + id).kendoComboBox({
                dataSource : deptList,
                dataTextField : "dept_name",
                dataValueField : "dept_value",
                index : 0,
                change : function() {
                    fnDeptChange(this.value());
                    $("#deptSeq").val(this.value());
                    parameters.deptName = this.value();
                    parameters.empSeq = null;
                    $("#empNameSearch").val("");

                    subGrid();
                }
            });
        }
    }


    function fnTpfGetDeptList() {
        var result = {};
        var params = {};
        var opt = {
            url : "<c:url value='/vcatn/getAllDept'/>",
            async : false,
            data : params,
            successFn : function(data) {
                result = data.list;
            }
        };
        acUtil.ajax.call(opt);
        return result;
    }

    function fnDeptChange(e) {
        var obj = $('#requestDeptSeq').data('kendoComboBox');
    }

    function gridReload() {
        $('#grid').data('kendoGrid').dataSource.read();
    }

    var dataSource = new kendo.data.DataSource({
        serverPaging : true,
        pageSize : 10,
        transport : {
            read : {
                url : "<c:url value='/vacation/getUseDeptList'/>",
                dataType : "json",
                type : 'post'
            },
            parameterMap : function(data, operation) {
                data.empSeq = empSeq;
                return data;
            }
        },
        schema : {
            data : function(response) {
                return response.list;
            },
            total : function(response) {
                return response.list.length;
            }
        }
    });

    /* 데이터 없을 시 첫번째 그리드 처리 함수 */
    function gridDataBound(e) {
        var grid = e.sender;
        if (grid.dataSource.total() == 0) {
            var colCount = grid.columns.length;
            $(e.sender.wrapper)
                .find('tbody')
                .append(
                    '<tr class="kendo-data-row"><td colspan="100%" class="no-data">데이터가 없습니다.</td></tr>');
        }
    };
    function mainGrid() {
        //캔도 그리드 기본
        var grid = $("#topGrid").kendoGrid(
            {
                dataSource : dataSource,
                height : 250,
                dataBound : function(e) {
                    this.fitColumns();
                    gridDataBound(e);
                },
                sortable : true,
                pageable : {
                    refresh : true,
                    pageSizes : [ 10, 20, 30, 50, 100 ],
                    buttonCount : 5
                },
                persistSelection : true,
                selectable : "multiple",
                columns : [
                    {
                        field : "dept_name",
                        title : "부서"
                    }, {
                        field : "grp_cnt",
                        title : "총계"
                    }, {
                        field : "",
                        title : "미생성",
                        template : function(){
                            return 0;
                        }
                    }, {
                        field : "",
                        title : "사용대기",
                        template : function(){
                            return 0;
                        }
                    }, {
                        field : "grp_cnt",
                        title : "확정"
                    }],
                change : function(e) {
                    codeGridClick(e)
                }
            }).data("kendoGrid");

        grid.table.on("click", ".checkbox", selectRow);

        var checkedIds = {};

        // on click of the checkbox:
        function selectRow() {

            var checked = this.checked, row = $(this).closest("tr"), grid = $(
                '#grid').data("kendoGrid"), dataItem = grid.dataItem(row);

            checkedIds[dataItem.CODE_CD] = checked;
            if (checked) {
                //-select the row
                row.addClass("k-state-selected");
            } else {
                //-remove selection
                row.removeClass("k-state-selected");
            }

        }
        function codeGridClick() {
            var rows = grid.select();
            var record;
            rows.each(function() {
                record = grid.dataItem($(this));
                year = record.APPLY_YR;
                subGrid(record);
            });

        }
    }


    kendo.ui.Grid.fn.fitColumns = function(parentColumn) {
        var grid = this;
        var columns = grid.columns;
        if (parentColumn && parentColumn.columns)
            columns = parentColumn.columns;
        columns.forEach(function(col) {
            if (col.columns)
                return grid.fitColumns(col);
            grid.autoFitColumn(col);
        });
        grid.expandToFit();
    }
    kendo.ui.Grid.fn.expandToFit = function() {
        var $gridHeaderTable = this.thead.closest('table');
        var gridDataWidth = $gridHeaderTable.width();
        var gridWrapperWidth = $gridHeaderTable.closest('.k-grid-header-wrap')
            .innerWidth();
        // Since this is called after column auto-fit, reducing size
        // of columns would overflow data.
        if (gridDataWidth >= gridWrapperWidth) {
            return;
        }

        var $headerCols = $gridHeaderTable.find('colgroup > col');
        var $tableCols = this.table.find('colgroup > col');

        var sizeFactor = (gridWrapperWidth / gridDataWidth);
        $headerCols.add($tableCols).not('.k-group-col').each(function() {
            var currentWidth = $(this).width();
            var newWidth = (currentWidth * sizeFactor);
            $(this).css({
                width : newWidth
            });
        });
    }

    function generatedColumn(){
        if($("#vacKind").val() == 0){
            return [
            {
                field : "deptName",
                title : "부서"
            }, {
                field : "dp_name",
                title : "직급"
            }, {
                field : "empName",
                title : "이름"
            }, {
                field : "join_day",
                title : "입사일"
            }, {
                field : "join_day",
                title : "적용기간",
                columns : [
                	{
                        field : "",
                        title : "시작일자",
                        template : function(row){
                        	return $("#selectYr").val() + "0101";
                        }
                    }, {
                        field : "",
                        title : "종료일자",
                        template : function(row){
                        	return $("#selectYr").val() + "1231";
                        }
                    }
                ]
            }, {
                field : "",
                title : "부여",
                columns : [
	               {
                       field : "YRVAC_FRST_ALWNC_DAYCNT",
                       title : "기본",
                   }, {
                       field : "",
                       title : "가산일수",
                   }, {
                       field : "YRVAC_MDTN_ALWNC_DAYCNT",
                       title : "기본조정",
               	   }]
            }, {
                field : "",
                title : "소진",
                columns : [
                	{
                        field : "useDay",
                        title : "사용",
                    }, {
                        field : "",
                        title : "사용조정",
                    }
                ]
            }, {
                field : "YRVAC_REMNDR_DAYCNT",
                title : "잔여연차",
                template : function(e){
                	var result = "";
                	if(e.YRVAC_REMNDR_DAYCNT != null){
                		result = e.YRVAC_REMNDR_DAYCNT;
                	}
                	if(e.useDay != null){
                		result = Number(e.YRVAC_REMNDR_DAYCNT) - Number(e.useDay);
                	}
                	return result;
                }
            }/*, {
                field : "USE_YN",
                title : "상태",
                template : function(e){
                    if(e.YRVAC_FRST_ALWNC_DAYCNT != null){
                        return "확정";
                    } else {
                        return "미확정";
                    }
                }
            }*/];
        } else if($("#vacKind").val() == 1){
            return [
                {
                    field : "dept_name",
                    title : "부서"
                }, {
                    field : "dp_name",
                    title : "직급"
                }, {
                    field : "emp_name",
                    title : "이름"
                }, {
                    field : "join_day",
                    title : "입사일"
                }, {
                    field : "spc_cnt",
                    title : "기본",
                }, {
                    field : "spc_sum",
                    title : "일수",
                }, {
                    field : "uploadCount",
                    title : "미등록파일수",
                    template : function(e){
                    	return "<a href=\"javascript: fileCountPopUp('"+ e.emp_seq +"');\" class='appDocClass' style='color: red;'>[ " + e.uploadCount + " 건 ]</a>";
                    }
                }, {
                    field : "",
                    title : "내역",
                    template : function(e){
                        //return "<a href=\"javascript:callSpcVacList("+ e.emp_seq +", '" + e.dept_name + "');\" class='appDocClass'>[ 상세보기 ]</a>";
                        return "<a href=\"javascript:openBottomPopup("+ e.emp_seq +", '" + e.dept_name + "');\" class='appDocClass'>[ 상세보기 ]</a>";
                    }
                }, {
                    field : "",
                    title : "증빙파일",
                    template : function(e){
                    	var key = e.SPECL_SN;
                    	if(key != null){
                    		return "<a href=\"javascript:zipFileDownload('" + e.emp_seq + "','" + e.emp_name + "');\" class='appDocClass'>[ 다운로드 ]</a>";	
                    	}else{
                    		return "";
                    	}
                        
                    }
                }];
        }
    }

    function subGrid(e) {
        var parentDeptSeq = null;
        if(e != null){
            parentDeptSeq = e.parent_dept_seq;
        }

        console.log(parameters);

        var subDataSource = new kendo.data.DataSource({
            serverPaging : true,
            pageSize : 10,
            transport : {
                read : {
                    url : "<c:url value='/vacation/getUseVacList'/>",
                    dataType : "json",
                    type : 'post'
                },
                parameterMap : function(data, operation) {
                    data.vacKind = $("#vacKind").val();
                    data.empSeq = empSeq;
                    data.year = year;
                    data.parentDeptSeq = parentDeptSeq;
                    data.deptName = parameters.deptName;
                    data.srchEmpSeq = parameters.empSeq;
                    data.year = $("#selectYr").val();
                    data.isAdmin = "true";
                    return data;
                }
            },
            schema : {
                data : function(response) {
                    return response.list;
                },
                total : function(response) {
                    return response.list.length;
                }
            }
        });

        var columns = generatedColumn();

        $("#grid").empty();
        var grid = $("#grid").kendoGrid(
            {
                dataSource : subDataSource,
                height : 350,
                dataBound : function(e) {
                    this.fitColumns();
                    gridDataBound(e);
                },
                sortable : true,
                pageable : {
                    refresh : true,
                    pageSizes : [ 10, 20, 30, 50, 100 ],
                    buttonCount : 5
                },
                persistSelection : true,
                selectable : "multiple",
                columns : columns,
                change : function(e) {
                    codeGridClick(e)
                }
            }).data("kendoGrid");

        grid.table.on("click", ".checkbox", selectRow);

        var checkedIds = {};

        // on click of the checkbox:
        function selectRow() {

            var checked = this.checked, row = $(this).closest("tr"), grid = $(
                '#grid').data("kendoGrid"), dataItem = grid.dataItem(row);

            checkedIds[dataItem.CODE_CD] = checked;
            if (checked) {
                row.addClass("k-state-selected");
            } else {
                row.removeClass("k-state-selected");
            }

        }
        function codeGridClick() {
            var rows = grid.select();
            var record;
            rows.each(function() {
                record = grid.dataItem($(this));
            });

        }
    }

    function subGridReload(){
        $("#grid").data('kendoGrid').dataSource.read();
    }

    function fn_useTime(useTime){
        var usTm = Number(useTime)/60;
        return usTm;
    }

    //사원팝업 ajax 끝
    function empGrid() {
        //사원 팝업그리드 초기화
        var grid = $("#empGrid")
            .kendoGrid(
                {
                    dataSource : empDataSource,
                    height : 500,
                    sortable : true,
                    pageable : {
                        refresh : true,
                        pageSizes : true,
                        buttonCount : 5
                    },
                    persistSelection : true,
                    selectable : "multiple",
                    columns : [
                        {
                            field : "emp_name",
                            title : "이름",
                        },
                        {
                            field : "dept_name",
                            title : "부서",
                        },
                        {
                            field : "position",
                            title : "직급",
                        },
                        {
                            field : "duty",
                            title : "직책",
                        },
                        {
                            title : "선택",
                            template : '<input type="button" id="" class="text_blue" onclick="empSelect(this);" value="선택">'
                        } ],
                    change : function(e) {
                        codeGridClick(e)
                    }
                }).data("kendoGrid");

        grid.table.on("click", ".checkbox", selectRow);

        var checkedIds = {};
        function selectRow() {

            var checked = this.checked, row = $(this).closest("tr"), grid = $(
                '#grid').data("kendoGrid"), dataItem = grid.dataItem(row);

            checkedIds[dataItem.CODE_CD] = checked;
            if (checked) {
                //-select the row
                row.addClass("k-state-selected");
            } else {
                //-remove selection
                row.removeClass("k-state-selected");
            }

        }
        //사원팝업 grid 클릭이벤트
        function codeGridClick() {
            var rows = grid.select();
            var record;
            rows.each(function() {
                record = grid.dataItem($(this));
            });
            subReload(record);
        }
    }

    //선택 클릭이벤트
    function empSelect(e) {
        //선택row
        var row = $("#empGrid").data("kendoGrid").dataItem($(e).closest("tr"));
        //사원명 셋팅
        $('#empNameSearch').val(row.emp_name);
        $("#empName").val(row.emp_name);
        //사원seq 셋팅
        $('#empSeqSearch').val(row.emp_seq);
        $("#empSeq").val(row.emp_seq);
        parameters.empSeq = row.emp_seq;
        //사원부서seq 셋팅
        $("#deptSeq").val(row.dept_seq);
        //부서명 셋팅
        $("#requestDeptSeq").val(row.dept_name);
        parameters.deptName = row.dept_name;
        var requestDeptSeq = $('#requestDeptSeq').data('kendoComboBox').value(row.dept_name);

        //팝업ID
        var empWindow = $("#empPopUp");
        //닫기 이벤트
        empWindow.data("kendoWindow").close();
        subGrid();
    }

    //사원팝업 ajax
    var empDataSource = new kendo.data.DataSource({
        serverPaging : true,
        pageSize : 10,
        transport : {
            read : {
                url : "<c:url value='/common/empInformation'/>",
                dataType : "json",
                type : 'post'
            },
            parameterMap : function(data, operation) {
                data.emp_name = $('#emp_name').val();
                data.dept_name = $('#requestDeptSeq').val();
                data.notIn = 'ok';
                return data;
            }
        },
        schema : {
            data : function(response) {
                return response.list;
            },
            total : function(response) {
                return response.totalCount;
            }
        }
    });
    
    function fileCountPopUp(empSeq){
    	$("#fileGrid").empty();
    	callSelectFileUploadList('N', empSeq, 'fileGrid');
		$("#fileCountPopUp").data("kendoWindow").open();
	}
</script>