/**************************************************
   common.js
   
   [수정내역]
   20180112 -  if ($(".sub_contents").size() == 0) {subHei = $('body').height();} (이준혁)
   20180112 -  $(fucntion 삭제 (이준혁)
   20180305 -  selectmenu 셀렉트박스수정 (이준혁)
**************************************************/

    $(document).ready(function () {
        /*게시판버튼on/off*/
        $(".st_btn a").click(function () {
            if (!$(this).hasClass("on")) {
                $(this).addClass("on");
                $(this).siblings().removeClass("on");
            } else if ($(this).hasClass("on")) {
                $(this).removeClass("on");
            }
        });

        /* 서브상단 신규버튼 시 table 영역 보이기 */
        $(".layer_show button").click(function () {
            $(".com_ta").show();
        });
        $(".layer_hide input").click(function () {
            $(".com_ta").hide();
        });


        // 서브페이지 상세검색 slideToggle
        $(".SearchDetail").hide();
        $(".btn_Detail").click(function () {
            $(".SearchDetail").slideToggle("slow");

            if ($('#all_menu_btn').attr('src') == _g_contextPath_ + '/Images/ico/ico_btn_arr_down01.png') {
                $('#all_menu_btn').attr('src', _g_contextPath_ + '/Images/ico/ico_btn_arr_up01.png');
            } else {
                $('#all_menu_btn').attr('src', _g_contextPath_ + '/Images/ico/ico_btn_arr_down01.png');
            }
        });
        // 업무,할일 좌측 상세검색 slideToggle 로컬코드
        $(".btn_Detail2").click(function () {
            $(".um_dtl").slideToggle("slow");
            if ($('.btn_Detail2 img').attr('src') == _g_contextPath_ + '/Images/ico/ico_btn_arr_down01.png') {
                $('.btn_Detail2 img').attr('src', _g_contextPath_ + '/Images/ico/ico_btn_arr_up01.png');
            } else {
                $('.btn_Detail2 img').attr('src', _g_contextPath_ + '/Images/ico/ico_btn_arr_down01.png');
            }
        });

        // checkbox , radio 숨기기
        $.each($("input[type='checkbox'] , input[type='radio']"), function (idx, val) {
            if ($(this).next().prop("tagName") == 'LABEL') {
                $(this).css("visibility", "hidden");
            }
        });

        // 서브 tab 이동시 상세검색영역 닫기
        $("#tabstrip ul li").click(function () {
            $(".SearchDetail").hide();
        });
    });

    /*시작 jstree 2뎁스**************************************************************/


    //2뎁스 컨트롤 (20170316 허정명 수정)
    $(document).on("click", ".sub_2dep", function (e) {
        e.preventDefault();
        var This = $(this);

        // 다중메뉴 열기
        if (This.hasClass("on")) {
            This.removeClass("on");
            This.next(".sub_2dep_in").stop().slideUp();
        } else {
            This.addClass("on");
            This.next(".sub_2dep_in").stop().slideDown();
        };

        // 자식요소 없을때
        if (This.children().hasClass("non_sub")) {
            This.addClass("on");
        } else {
            $(".non_sub").parent().removeClass('on');
        };

        // 사용자,관리자에 따른 이미지 변경   
        if ($("body").hasClass("admin")) {
            if (This.hasClass("on")) {
                This.find('span').css("background", "#89add1 url(" + _g_contextPath_ + "/Images/bg/sub_2dh_arr_03.png) no-repeat 95% 16px;");
                This.children(".non_sub").css("background", "#89add1");
            } else {
                This.find('span').css("background", "url(" + _g_contextPath_ + "/Images/bg/sub_2dh_arr_01.png) no-repeat 95% 16px;");

            };

        } else {
            if (This.hasClass("on")) {
                This.find('span').css("background", "#d8eafc url(" + _g_contextPath_ + "/Images/bg/sub_2dh_arr_02.png) no-repeat 95% 16px");
                This.children(".non_sub").css("background", "#d8eafc");
            } else {
                This.find('span').css("background", "url(" + _g_contextPath_ + "/Images/bg/sub_2dh_arr_01.png) no-repeat 95% 16px");
            };
        }
    });

    
    /**************************************************************jstree 2뎁스 종료*/

    /*테이블넓이정하기*/
    $(document).ready(function () {
        iframeWid();
        //Mcalendar_size();
        note_size(); //일정_노트
       // subConWid();
        ta_size();
        setTimeout(rec_size, 300);
        //rec_size();
        bdListH(); // 게시판 좌측 리스트 높이
        adminWorkResizeBox()//관리자 > 업무 > 사용자일괄추가
        um_size()
        comp_size()//회사정보관리(관리자)
        docResize(); //전자결재_양식편집팝업
        docHeaderResize(); //전자결재_헤더에 따른 컨텐츠조절
        dalResize(); //근태관리현황
        npDocList(); //서식목록
        $(window).resize(function () {
            note_size(); //일정_노트
            ta_size();
            iframeWid();
            bdListH(); // 게시판 좌측 리스트 높이
            adminWorkResizeBox()//관리자 > 업무 > 사용자일괄추가
            comp_size()//회사정보관리(관리자)
            docResize(); //전자결재_양식편집팝업
            docHeaderResize(); //전자결재_헤더에 따른 컨텐츠조절
            dalResize(); //근태관리현황
            npDocList(); //서식목록
            //subConWid();      
        });

        $("#treeview").click(function () {
            setTimeout(rec_size, 100);
            //rec_size();
        });

    });

    //전자결재_헤더에 따른 컨텐츠조절
    function docHeaderResize() {
        var docHeaderHdi = $('.pop_sign_head').height();
        $('.pop_sign_con').css("paddingTop", docHeaderHdi + "px");
        $('.signline_info_box').css("top", (docHeaderHdi - 42) + 54 + "px");
    }

    //전자결재_양식편집팝업 -퍼블리싱용
    //function docResize() {
    //    var docEditWrapHei = $('html').height();
    //    $('.doc_code_list').height(docEditWrapHei - 178);
   // }

	//전자결재_양식편집팝업
    function docResize() {
        var docEditWrapHei = $('#editorView').height();
        $('.doc_code_list').height(docEditWrapHei - 100);
    }

    // 게시판 좌측 리스트 높이
    function bdListH() {
        var sl_hei = $(".sub_left").height();
        $(".bd_list_box.workcate").height(sl_hei - 167); // 업무카테고리 좌측 리스트 높이
        $(".bd_list_box.bdlist").height(sl_hei - 57); // 게시판관리 좌측 리스트 높이
    }


    // 기록물철별문서
    function ta_size() {
        var scw_wid = $(".sub_contents_wrap").width() - 38;
        var scw_hei = $(".sub_contents_wrap").height();
        var record_wid = $(".sub_left").width();
        $(".sub_con").width(scw_wid - record_wid); //10 => 레프트조절영역
    }

    //회사정보관리
    function comp_size() {
        var scw_wid = $(".sub_contents_wrap").width();
        var record_wid = $(".sub_left").width();
        $(".comp_sub_con").width(scw_wid - record_wid - 13); //회사정보관리 사이즈조정
        $(".comp_sub_con.lineSet").width(scw_wid - record_wid - 3); //결재라인설정 사이즈조정
    }

    function rec_size() {
        var scw_hei = $(".sub_contents_wrap").height();
        //  var tree_hei=$(".treeTop").height();     

        var treetitle_hei = $(".tree_title").height();
        var recordTab_hei = $(".record_tab").height() + 10;
        var recordSea_hei = $(".record_tabSearch").height() + 30;
        var etc_folder_hei = $(".etc_folder").height();
        var sb_btn_top_hei = $(".sb_btn_top").height();

        $(".sub_left").height(scw_hei);

        if ($(".record_tab").length > 0 && $(".record_tabSearch").length > 0) {
            $(".tree_auto").height(scw_hei - recordTab_hei - recordSea_hei - treetitle_hei - etc_folder_hei - sb_btn_top_hei - 11);
        } else if ($(".record_tab").length > 0) {
            $(".tree_auto").height(scw_hei - recordTab_hei - treetitle_hei - etc_folder_hei - sb_btn_top_hei - 11);
        } else if ($(".record_tabSearch").length > 0) {
            $(".tree_auto").height(scw_hei - recordSea_hei - treetitle_hei - etc_folder_hei - sb_btn_top_hei - 11);
        } else {
            $(".tree_auto").height(scw_hei - treetitle_hei - etc_folder_hei - sb_btn_top_hei - 11);
        }

    }
    
    //서식목록
    function npDocList(){
        var scw_hei = 0 ;
        
        if( $(".sub_contents").length > 0 ){
            scw_hei = $(".sub_contents").height();
        }else{
            scw_hei = $("body").height();
        }
        $(".npDocList .jstreeSet").height(scw_hei - 200);
        $(".npDocList .twinbox_td .disInfoBox").height(scw_hei - 185);
    };

    /*업무관리 리스트 사이즈*/
    function um_size() {
        var sccon_hei = $(".sub_con").height() + 65;
        var umTop_hei = $(".um_top").height();

        $(".um_auto").height(sccon_hei - umTop_hei);

    }

    /*아이프레임width값*/
    function iframeWid() {
        var hori_wid = $("#horizontal ").width();
        var sw_wid = $(".side_wrap ").width();
        if ((hori_wid - sw_wid - 8) > 0)
            $(".sub_contents iframe").width(hori_wid - sw_wid - 8);
    }


    // 메인 달력 > 오늘일정
    /*
    function Mcalendar_size(){   
    var Mcalendar_hei=$(".M_calendar").height();
    var Mcalendartitle_hei=$(".M_calendar h2").height();     
    var schedule_hei=$(".schedule_cal").height();
    var today_schtitle_hei=$(".M_today_sch h3").height();       

    $(".M_today_sch ul").height(Mcalendar_hei - Mcalendartitle_hei - schedule_hei - today_schtitle_hei -24);
    }
    */

    // 일정_노트
    function note_size() {
        var conWrapHei = $(".contents_wrap").height();
        var headWrapHei = $(".header_wrap").height();
        var footWrapHei = $(".footer").height();
        var sc_hei = $(".sub_contents").height(conWrapHei - headWrapHei - footWrapHei);

        var sc_wid = $(".sub_contents").width();
        var sct_hei = $(".sub_title_wrap").height();
        //alert(sc_hei);
        //$(".note_con").width(sc_wid-42);
        $(".note_con").height(sc_hei - sct_hei - 150);
        var nt_con_hei = $(".note_con").height();
        //$(".note_right").width(sc_wid-314);
        $(".note_d_con").height(nt_con_hei - 211);
        $("iframe").height();
    }

    //관리자 > 업무 > 사용자일괄추가 로컬버전
    /*
    function adminWorkResizeBox(){
    var scW = $('.sub_contents').width()-40;
    var scH = $('.sub_contents').height()-20;
    var stwH = $('.sub_title_wrap').height();
    
    $('.left_box').width(scW-260);
    $('.left_box, .right_box').height(scH-stwH);
    $('.admin_work_wrap .left_box .sub_contents_border').height(scH-stwH-173);
    $('.admin_work_wrap .right_box .sub_contents_border').height(scH-stwH-30);
    $('.tab_con1, .tab_con2').height(scH-stwH-508);
    }
    */

   
    //관리자 > 업무 > 사용자일괄추가 :: 20170111(허정명)
    function adminWorkResizeBox() {
        var scW = $('.sub_contents').width() - 40;
        var scH = $('.sub_contents').height();
        var stwH = $('.sub_title_wrap').height();
        var tit_pH = $('.admin_work_wrap .tit_p').outerHeight(true);
        var tit_p2H = $('.admin_work_wrap .tit_p2').outerHeight(true);

        $('.left_box').width(scW - 267);
        $('.left_box, .right_box').height(scH - stwH);

        $('.admin_work_wrap').height(scH - stwH - 20);
        $('.admin_work_wrap .left_box .sub_contents_border').height(scH - stwH - 210);

        // 켄도테이블있을때 버전 $('.admin_work_wrap .left_box .sub_contents_border .data_grid .k-grid-content').css("max-height",scH-stwH-270+"px");

        //일반테이블 계산
        $('.admin_work_wrap .left_box .sub_contents_border .com_ta2.scroll').css("max-height", scH - stwH - 248 + "px");

        $('.proj_box .tc_box').outerHeight((scH - stwH - tit_pH - 20) / 3 - tit_p2H);
    }

    //근태현황관리 :: 20170529 (허정명)
    function dalResize() {
        var subHei = $('.sub_contents').height();
        
        /* 개발적용 시 풀어야 함 (퍼블리싱 확인할 때 주석처리) */
        if ($(".sub_contents").size() == 0) {
            subHei = $('body').height();
        }
       
        
        var stwHei = $('.sub_title_wrap').height();
        var tboxHei = $('.top_box').height();
        var locaHei = $('.location_info').height();
        var leftHei = $('.dal_BoxIn .leftHeader').height();
        var rightHei = $('.dal_BoxIn .rightHeader').height();
        var btnDivHei = $('.dal_Box_detail .btn_div').height();
        var dalHei = subHei - (tboxHei+locaHei);
        
        /*기본*/
        $('.dal_Box').height(dalHei - 14);
        $('.dal_BoxIn').height(dalHei);
        //$('.dal_Box_detail').height(dalHei-16);
        $('.dal_Box_detail .ta_Contents').height(dalHei - btnDivHei - 22);
        $('.dal_Box_detail .ta_Contents2').height(dalHei - btnDivHei - 59);
        $('.dal_BoxIn .leftContents').height(dalHei - leftHei - 31);
        $('.dal_BoxIn .rightContents').height(dalHei - rightHei - 14);
        
        /*-----------------------------------------------------------------*/
        /* 사이즈 커스텀 */
       
        /*연차관리*/
        $('.boxHeight').height( subHei - (stwHei + tboxHei) );
        
        /*급여관리 - 급여구분*/
        $('.dal_Box.paystub').height(dalHei - 124);
        $('.paystub .dal_BoxIn').height(dalHei-124);
        $('.paystub .dal_BoxIn .leftContents').height(dalHei - leftHei - 124);
        $('.paystub .dal_BoxIn .rightContents').height(dalHei - rightHei - 124);
        
        /*급여관리 - 월별*/
        $('.dal_Box.paystub2').height(dalHei - 101);
        $('.paystub2 .dal_BoxIn').height(dalHei-100);
        $('.paystub2 .dal_BoxIn .leftContents').height(dalHei - leftHei - 121);

        /*근태관리 - 환경설정 - 근태코드관리*/
        $('.dal_Box.codeadmin').height(dalHei - 90);
        $('.codeadmin .dal_BoxIn').height(dalHei - 133);
        $('.codeadmin .dal_BoxIn .leftContents').height(dalHei - leftHei - 154);
        
        /*전자결재(비영리)- 감사설정*/
        $('.dal_Box.audit').height(dalHei-52);
        $('.audit .dal_BoxIn').height(dalHei - 66);
        $('.audit .dal_BoxIn .leftContents').height(dalHei - leftHei - 87);
        $('.dal_Box.audit + .dal_Box_detail').height(dalHei-42);
        
        /*전자결재(비영리)- 양식목록*/
        $('.dal_Box.npDocList2').height(dalHei-12);
        $('.dal_Box.npDocList2 .dal_BoxIn').height(dalHei - 46);
        $('.dal_Box.npDocList2 .dal_BoxIn .jstreeSet').height(dalHei - 83);
        
        /*전자결재(비영리)- 서식관리*/
        $('.dal_Box.npDocSet').height(dalHei-52);
        $('.npDocSet .dal_BoxIn').height(dalHei - 66);
        $('.npDocSet .dal_BoxIn .leftContents').height(dalHei - leftHei - 87);
        $('.npDocSet.dal_Box_detail').height(dalHei-42);
        
        /*회계 - 마감설정*/
        $('.com_ta2.atCloseSetDocList').height(dalHei - 159);
        $('.dal_Box.atCloseSet').height(dalHei-111);
        $('.atCloseSet .dal_BoxIn').height(dalHei - 106);
        $('.atCloseSet .dal_BoxIn .leftContents').height(dalHei - leftHei - 161);
        $('.atCloseSet .dal_BoxIn .disInfoBox').height(dalHei - 107);
        $('.atCloseSet.dal_Box_detail.boxHeight').height( ( subHei - (stwHei + tboxHei) ) - 36);
        var td0Wid = $('.twinbox.atCloseSet table .twinbox_td').eq(0).width();
        var td1Wid = $('.twinbox.atCloseSet table .twinbox_td').eq(1).width();
        var dalBoxDetail = parseInt( (td1Wid*0.6) + td0Wid ) -1;
        $('.atCloseSet.dal_Box_detail.boxHeight').css("left",dalBoxDetail);
        
        /*회계 - 표준적요설정,증빙유형설정 */
        $('.dal_Box.stExtract').height(dalHei-46);
        $('.stExtract .dal_BoxIn').height(dalHei - 46);
        $('.stExtract .dal_BoxIn .leftContents').height(dalHei - leftHei - 102);
        $('.stExtract .disInfoBox').height(dalHei - 103);
        $('.stExtract.dal_Box_detail.boxHeight').height(dalHei - 2);
        
        
        
        /*-----------------------------------------------------------------*/
    };


    /********************************************************************************************************************
    레프트 리사이징
    ********************************************************************************************************************/

    $(document).ready(function () {
        horResize();
        $(window).resize(function () {
            horResize();
        });

        function horResize() {
        	
            var conWrapHei = $(".contents_wrap").height();
            var headWrapHei = $(".header_wrap").height();
            var footWrapHei = $(".footer").height();        	
        	
            if($(".header_wrap") != null && $(".header_wrap").length > 0){
            	var customTop = $(".header_wrap").offset().top;
    			$("#horizontal").height(conWrapHei - (headWrapHei + footWrapHei + customTop) );
    			$("#oneContents").height(conWrapHei - (headWrapHei + footWrapHei + customTop) );
    			$(".sub_contents").height(conWrapHei - (headWrapHei + footWrapHei + customTop) );
    			$(".footer").css("bottom", customTop);            
        		
        	}else{
                $("#horizontal").height(conWrapHei - headWrapHei - footWrapHei);
                $("#oneContents").height(conWrapHei - headWrapHei - footWrapHei);
        	}
            
        }

        //컨텐츠 분할 레이아웃 사용시
        if ($("#horizontal").kendoSplitter != null) {
            $("#horizontal").kendoSplitter({
                panes: [
                { collapsible: false, min: "180px", max: "400px", size: "248px" },
                { collapsible: false, resizable: true }
            ]
            });
        }

        //컨텐츠 분할 레이아웃 사용안할시(외주,메일 등등)
        if ($("#oneContents").kendoSplitter != null) {
            $("#oneContents").kendoSplitter({
                panes: [
                { collapsible: false, resizable: false }
            ]
            });
        }
   


    /* sub_contents넓이 */
    function subConWid() {
        /*20160803 장지훈 추가 (리사이즈 시 영역 나뉨 현상 수정)*/
        //console.log("subConwid");
        var k_wid = $(".k-splitbar").width();
        if ($(".side_wrap").length > 0) {
            //$(".sub_contents").width($(".sub_wrap").width()-8);
        } else {
            //$(".sub_contents").width($(".sub_wrap").width()-0);
        }
    }

    /********************************************************************************************************************
    sub_nav 커스텀
    ********************************************************************************************************************/

    //2dep 구분 클래스 추가
    $("#sub_nav > li.k-item").addClass("2dep-item");

    //2dep 선택. 형제요소 닫기
    $('.2dep-item').on('click', function () {
        var AllClose = $(this).siblings();
        var treeview = $("#sub_nav").data("kendoTreeView"); //트리데이터 가져오기
        treeview.collapse(AllClose);
    });

    //2dep 선택시 자신만 선언
    $('#sub_nav > .k-item > div').on('click', function () {
        $('.k-item > div').removeClass('on'); //2dep 선언취소
        $('.k-item > .k-group > .k-item > div').removeClass('on'); //3dep 선언취소
        $('.k-item > .k-group > .k-item > .k-group .k-item > div').removeClass('on'); //4dep 선언취소

        $(this).addClass('on');
    });

    //3dep 선택시 자신과 부모 2dep만 선언
    $('#sub_nav > .k-item > .k-group > .k-item > div').on('click', function () {
        $('.k-item > div').removeClass('on'); //2dep 선언취소
        $('.k-item > .k-group > .k-item > div').removeClass('on'); //3dep 선언취소
        $('.k-item > .k-group > .k-item > .k-group .k-item > div').removeClass('on'); //4dep 선언취소

        $(this).parent().parent().parent().children().addClass('on'); //부모 2dep만 선언
        $(this).addClass('on');
    });

    //4dep 선택시 자신과 부모 2dep,3dep만 선언
    $('#sub_nav > .k-item > .k-group > .k-item > .k-group .k-item > div').on('click', function () {
        $('.k-item > div').removeClass('on'); //2dep 선언취소
        $('.k-item > .k-group > .k-item > div').removeClass('on'); //3dep 선언취소
        $('.k-item > .k-group > .k-item > .k-group .k-item > div').removeClass('on'); //4dep 선언취소

        $(this).parent().parent().parent().parent().parent().children().addClass('on'); //부모 2dep 선언
        $(this).parent().parent().parent().children().addClass('on'); //부모 3dep 선언
        $(this).addClass('on');
    });
    /********************************************************************************************************************/



    //바로가기 레이어팝업 온/오프
    $(".btn_link").on("click", function () {
        $('.layer_sel_pop').show();
    }),
    $(".pop_close, .sel_pop_con ul li a").on("click", function () {
        $('.layer_sel_pop').hide();
    });
});



/*헤더공통***************************************************************************************************/

    $(document).ready(function () {

            /*더보기열기닫기*/
            $(".top_menu .more_btn > a").click(function () {
                if (!$(this).parent().hasClass("on")) {
                    $(".more_div").show();
                    $(this).parent().addClass("on");
                } else if ($(this).parent().hasClass("on")) {
                    $(".more_div").hide();
                    $(this).parent().removeClass("on");
                }
            });

            $(".more_div").mouseover(function () {
                $(".more_div").show();
                $(".top_menu .more_btn > a").parent().addClass("on");
            });
            $(".more_div").mouseout(function () {
                $(".more_div").hide();
                $(".top_menu .more_btn > a").parent().removeClass("on");
            });


            /*메뉴내용 더보기 팝업으로 복사*/
            $("#more_div_ul").html("");
            var menuCln = $(".top_menu ul li").clone();
            $("#more_div_ul").html(menuCln); //.html();

            mainMenuSize();
        });

        
        $(window).resize(function () {
            mainMenuSize();
        });
        
        /*메인메뉴 resizing, 더보기고정, 더보기 내용추가*/
        function mainMenuSize() {
            $(".top_menu ul li").css("display", "block");
            $("#more_div_ul").children().css("display", "none");
            
            var tmliSize = $(".top_menu ul li").size();
            var sumT = 0;
            var curWid;
            var curNum;
            var menuWid;

            var htoWid = $(".header_top_wrap").width(); 
            var htpWid = $(".header_top").width();
            var mbWid = $(".top_menu .more_btn").width();
            var h1Wid = $(".header_top h1").width();
            var comWid = $(".com_btn").width();
            var mPad = htoWid - htpWid;
            menuWid = htoWid - mPad - mbWid - h1Wid - comWid - 50;
        
        if(navigator.userAgent.match(/iPad/i)){
            menuWid = 1024 - mPad - mbWid - h1Wid - comWid - 50;

        }

            for (var i = 0; i < tmliSize; i++) {
                curWid = $(".top_menu ul li").eq(i).width();
                sumT += curWid;

                if (sumT < menuWid) { curNum = i + 1; }
            }

            if (tmliSize > curNum) {
                $(".top_menu ul li").eq(curNum - 1).nextAll("li").css("display", "none");
                $("#more_div_ul li").eq(curNum - 1).nextAll("li").css("display", "block");
                $(".top_menu ul li").eq(curNum - 1).nextAll("li").addClass("t_li");
                $("#more_div_ul li").eq(curNum - 1).nextAll("li").addClass("m_li");
                $(".top_menu .more_btn").show();
            } else {
                $(".top_menu .more_btn").removeClass("on");
                $(".top_menu .more_btn").hide();
                $(".more_div").hide();
            }

          if (sumT < menuWid + 150 && $(".m_li").size() == 1 )
          {
             $(".t_li").css("display", "block");    
              $(".top_menu .more_btn").hide();
          }

            $(".header_top .nav").css("visibility","visible");
            $(".header_top_wrap").css("overflow","inherit");    
         }
     

/*앱다운로드팝업 열기닫기*/
function appdown_open() {
    $(".pop_appdown").show();
}

function appdown_clo() {
    $(".pop_appdown").hide();
}


/*메일 관리자에서 사용(20160511)*/
/*테이블  자동 말줄임 넓이값구하기 */
function mxWid(){
    var boWid=$(".mx_ta").width();
    var sum = 0;
    
    for (i=0; i <=$(".mx_ta  colgroup").children().size() ; i++ ){
        var otherW = $(".mx_ta  colgroup").children().eq(i).width();
        sum+=otherW;
    }
    
    mxWidr= boWid - sum
    $(".mx").css("maxWidth", mxWidr-90 );
}

function mxWid2(){
    var boWid=$(".mx_ta").width();
    var sum = 0;
    
    for (i=0; i <=$(".mx_ta  colgroup").children().size() ; i++ ){
        var otherW = $(".mx_ta  colgroup").children().eq(i).width();
        sum+=otherW;
    }
    
    mxWidr= boWid - sum
    $(".mx").css("maxWidth", mxWidr-30 );
}


/*게시판 스트라이프*/
$(document).ready(function () {
    stripe_fn();
 });
function stripe_fn(){
        var spSize = $(".stripe_blue").size();
        for (z=0; z<= spSize; z++)
        {
            $(".stripe_blue").eq(z).addClass("ct"+z);
            var trSize= $(".stripe_blue.ct"+z+" table tr td").parent().size();
            for (t=0; t<= trSize; t++)
                {
                    if (t%2==1)
                    {
                        $(".stripe_blue.ct"+z+" table tr td").parent().eq(t).addClass("even");
                        
                    }   
                    $(".stripe_blue.ct"+z+" table tr td table tr td").parent().removeClass("even");
                }
        }
    }

/********************************************************************************************************************
레이어팝업위치설정
********************************************************************************************************************/

function pop_position(){
   
    var pwd_head_Hei =$(".pop_auto_hei > .pop_head").height();
    var pwd_foot_Hei = $(".pop_auto_hei > .pop_foot").height();
    var pwd_con_Hei = $(".pop_auto_hei > .pop_con").height();
    
    $(".pop_auto_hei > .pop_con").css("overflow-y", "auto");
    if ($(".pop_auto_hei > .pop_con").height() >= $(window).height()-pwd_head_Hei-pwd_foot_Hei-200)
    {   
        $(".pop_auto_hei > .pop_con").css("height", $(window).height()-pwd_head_Hei-pwd_foot_Hei-200);        
    } else  {
            $(".pop_auto_hei > .pop_con").css("height", "auto");
    }
  

    for (i=0;i <= $(".pop_wrap2").size() ; i++)
    {
         var popWid = $(".pop_wrap_dir").eq(i).outerWidth();
         var popHei = $(".pop_wrap_dir").eq(i).outerHeight();
        $(".pop_wrap_dir").eq(i).css("top","50%").css("left","50%").css("marginLeft",-popWid/2).css("marginTop",-popHei/2);

        var popWid2 = $(".pop_auto_hei").eq(i).outerWidth();
         var popHei2 = $(".pop_auto_hei").eq(i).outerHeight();
        $(".pop_auto_hei").eq(i).css("top","50%").css("left","50%").css("marginLeft",-popWid2/2).css("marginTop",-popHei2/2);
    }
}


/*윈도우팝업 하단버튼 하단고정 visible*/
$(document).ready(function() {
        if($(".pop_wrap .pop_foot_bg").length > 0) {                
        }else if($(".pop_wrap > .pop_foot").length > 0){
            $(".pop_wrap").append("<div class='pop_foot_bg'></div>");
        } 

        pb_btn();   

        $(window).resize(function() { 
            pb_btn();
        });
    });

$(window).scroll(function(){
    if($(window).scrollTop() == $(document).height() - $(window).height()){
        $(".pop_wrap .pop_foot").css("bottom","1px");
    } else {
        $(".pop_wrap .pop_foot").css("bottom","0px");
    }   
});

function pb_btn(){

	var pw_hei = $(".pop_wrap").height();
    var pw_wid = $(".pop_wrap").width();
    $(".pop_wrap > .pop_foot").width(pw_wid);
                
        if($(window).scrollTop() == $(document).height() - $(window).height())
        {   
            $(".pop_wrap > .pop_foot").css("position","static");    
            $(".pop_wrap .pop_foot_bg").css("display","none");
        } else {
            $(".pop_wrap > .pop_foot").css("position","fixed");
            $(".pop_wrap .pop_foot_bg").css("display","block");
            $(".pop_wrap.no_foot > .pop_foot").css("position","static");
            $(".pop_wrap.no_foot .pop_foot_bg").css("display","none");
        }   
}



/*셀렉트박스 js*/
$(document).ready(function() {
        $(document).mouseup(function (e){
        var container = $(".select_list");
        if( container.has(e.target).length === 0)
            container.hide();
        });

        select_cus();
    
        $(window).resize(function() { 
            select_cus();
        });
    });

function select_cus() {
    $(".select_list").css("display","none");
    for (i=0; i < $(".select_div").size() ; i++ )
    {
        $(".select_div").eq(i).children(".tit").width($(".select_div").eq(i).width()-2);
    }
    
    $(".select_div .arr").click(function(){
        $(this).prev(".tit").click();
    });
    $(".select_list ul li").click(function(){
        var th_txt =    $(this).text();
        $(this).parent().parent().prev().prev(".tit").val(th_txt);
        $(this).parent().parent(".select_list").slideUp(200);
    });
    $(".select_div .tit").click(function(){
        if (!$(this).parent().hasClass("disa"))
        {
            $(this).parent().children(".select_list").slideDown(200);
        }
    });
}


/*셀렉트박스jquery-ui js*/
$(document).ready(function(){
    select_menu();
    
    $(window).resize(function() {
         select_menu();     
    });
});

function select_menu() {
if ((document.documentElement.innerHTML || document.documentElement.innerText).indexOf('jquery-ui.min.js') > -1) {
      $( ".selectmenu" ).selectmenu();
    
        $.each($('.selectmenu'), function () {
                $(this).selectmenu({ width : $(this).width() + 31});
            });
            var Browser = {
                    chk : navigator.userAgent.toLowerCase()
                }             
                Browser = {
                    ie9 : Browser.chk.indexOf('msie 9') != -1,
                    ie10 : Browser.chk.indexOf('msie 10') != -1,
                    ie11 : Browser.chk.indexOf('msie 11') != -1,
                    chm : Browser.chk.indexOf('chrome') != -1
                }
                  
                if ((Browser.ie9) || (Browser.ie10)) {
                    $.each($('.selectmenu'), function () {
                        $(this).selectmenu({ width : $(this).width() + 9});
                    });
                }

                if (Browser.chm) {
                    $.each($('.selectmenu'), function () {
                        $(this).selectmenu({ width : $(this).width() + 17});
                    });
                }
    

    $("div").scroll(function(){
        $(".selectmenu").selectmenu("close");
    });
    $("iframe").scroll(function(){
        $(".selectmenu").selectmenu("close");
    });
    $(window).resize(function(){
        $(".selectmenu").selectmenu("close");
    });
    $( ".selectmenu.up" ).selectmenu({
      position: { at: "center top-30" }
    });

    if($(".selectmenu.skip").css("display") == "none"){
        $(".selectmenu.skip").next("span").css("display","none");
    }

 }
}

//////////////////////////////////////////////////////////////////
//게시판 view 넓이계산
$(document).ready(function(){
    boardViewContents();
    
    $(window).resize(function() {
         boardViewContents();     
    });
});
function boardViewContents(){
    var viewBoxWid = $(".iframe_wrap").width()-27;
      $(".text_view_box").width(viewBoxWid);
};
//////////////////////////////////////////////////////////////////
//스크롤End일때 이벤트 
$.fn.scrollEnd = function(callback, timeout) {          
    $(this).scroll(function(){
        var $this = $(this);
        if ($this.data('scrollTimeout')) {
        clearTimeout($this.data('scrollTimeout'));
    };
    $this.data('scrollTimeout', setTimeout(callback,timeout));
  });
};
//////////////////////////////////////////////////////////////////



//탭 리뉴얼
	$(document).ready(function() {
		
		tab_nor_Fn();
		nexpre();
		$(window).resize(function() {
			tab_nor_Fn();
		});

	});

		function tab_nor_Fn(num){
			$(".tab"+num).show();
			$(".tab"+num).siblings().hide();
			
			var inx = num -1
	
			$(".tab_nor li").eq(inx).addClass("on");
			$(".tab_nor li").eq(inx).siblings().removeClass("on");


		var tnWid =	$(".tab_nor").width();
		var tnliSize = $(".tab_nor ul li").outerWidth();
		var sumT = 0;
        var curWid;

		  for (var i = 0; i < tnliSize; i++) {
				curWid = $(".tab_nor ul li").eq(i).outerWidth();
				sumT += curWid;
		}

		if (sumT > tnWid){
			$(".tab_nor .nex").show();
			if ($(".tab_nor .nex").hasClass("end"))
			{
				$(".tab_nor .nex").hide();
			}
			} else {
			$(".tab_nor .nex").hide();
			}

		}

		function nexpre(){
			var count = 0;
			var moveLeft = 0;	
			$(".tab_nor .nex").click(function(){
				count++;
				var licurWid = $(".tab_nor ul li").eq(count-1).outerWidth();
				moveLeft += licurWid;

				$(".tab_nor ul").css("left",- moveLeft + 25);
				$(".tab_nor .pre").show();

				var lastIdx = $(".tab_nor ul li:last").index();

				if (count == lastIdx )
				{	
					$(".tab_nor .nex").addClass("end");
					$(".tab_nor .nex").hide();
				}
			});
			
			$(".tab_nor .pre").click(function(){
				count--;
				var licurWid2 = $(".tab_nor ul li").eq(count).outerWidth();
				//moveLeft +1;
				moveLeft -= licurWid2

				$(".tab_nor ul").css("left",-moveLeft + 25);
				//alert(moveLeft);

				if (count == 0)
				{
					$(".tab_nor .pre").hide();
					$(".tab_nor ul").css("left",-moveLeft);
				}

				var lastIdxPre = $(".tab_nor ul li:last").index()-1;

				if (count == lastIdxPre )
				{
					$(".tab_nor .nex").removeClass("end");
					$(".tab_nor .nex").show();
				}	
			});
			
		}
//탭리뉴얼 끝


//////////////////////////////////////////////////////////////////
//BASE64
var enc64List, dec64List;

function initDz64() {
    enc64List = new Array();
    dec64List = new Array();
    var i;
    for (i = 0; i < 26; i++) {
        enc64List[enc64List.length] = String.fromCharCode(65 + i);
    }
    for (i = 0; i < 26; i++) {
        enc64List[enc64List.length] = String.fromCharCode(97 + i);
    }
    for (i = 0; i < 10; i++) {
        enc64List[enc64List.length] = String.fromCharCode(48 + i);
    }
    enc64List[enc64List.length] = "+";
    enc64List[enc64List.length] = "/";
    for (i = 0; i < 128; i++) {
        dec64List[dec64List.length] = -1;
    }
    for (i = 0; i < 64; i++) {
        dec64List[enc64List[i].charCodeAt(0)] = i;
    }
}
 
function DzEnc(str) {
//  initDz64();
//  var c, d, e, end = 0;
//  var u, v, w, x;
//  var ptr = -1;
//  var input = str.split("");
//  var output = "";
//  while(end == 0) {
//      c = (typeof input[++ptr] != "undefined") ? input[ptr].charCodeAt(0) : 
//          ((end = 1) ? 0 : 0);
//      d = (typeof input[++ptr] != "undefined") ? input[ptr].charCodeAt(0) : 
//          ((end += 1) ? 0 : 0);
//      e = (typeof input[++ptr] != "undefined") ? input[ptr].charCodeAt(0) : 
//          ((end += 1) ? 0 : 0);
//      u = enc64List[c >> 2];
//      v = enc64List[(0x00000003 & c) << 4 | d >> 4];
//      w = enc64List[(0x0000000F & d) << 2 | e >> 6];
//      x = enc64List[e & 0x0000003F];
//      if (end >= 1) {x = "=";}
//      if (end == 2) {w = "=";}
//      if (end < 3) {output += u + v + w + x;}
//  }
//  var formattedOutput = "";
//  var lineLength = 76;
//  while (output.length > lineLength) {
//   formattedOutput += output.substring(0, lineLength) + "\n";
//   output = output.substring(lineLength);
//  }
//  formattedOutput += output;
//  return formattedOutput;
	
	return Base64.encode(str);
}








var Base64 = {

		// private property
		_keyStr : "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/=",

		// public method for encoding
		encode : function (input) {
			var output = "";
			var chr1, chr2, chr3, enc1, enc2, enc3, enc4;
			var i = 0;

			input = Base64._utf8_encode(input);

			while (i < input.length) {

				chr1 = input.charCodeAt(i++);
				chr2 = input.charCodeAt(i++);
				chr3 = input.charCodeAt(i++);

				enc1 = chr1 >> 2;
				enc2 = ((chr1 & 3) << 4) | (chr2 >> 4);
				enc3 = ((chr2 & 15) << 2) | (chr3 >> 6);
				enc4 = chr3 & 63;

				if (isNaN(chr2)) {
					enc3 = enc4 = 64;
				} else if (isNaN(chr3)) {
					enc4 = 64;
				}

				output = output +
				this._keyStr.charAt(enc1) + this._keyStr.charAt(enc2) +
				this._keyStr.charAt(enc3) + this._keyStr.charAt(enc4);

			}

			return output;
		},

		// public method for decoding
		decode : function (input) {
			var output = "";
			var chr1, chr2, chr3;
			var enc1, enc2, enc3, enc4;
			var i = 0;

			input = input.replace(/[^A-Za-z0-9\+\/\=]/g, "");

			while (i < input.length) {

				enc1 = this._keyStr.indexOf(input.charAt(i++));
				enc2 = this._keyStr.indexOf(input.charAt(i++));
				enc3 = this._keyStr.indexOf(input.charAt(i++));
				enc4 = this._keyStr.indexOf(input.charAt(i++));

				chr1 = (enc1 << 2) | (enc2 >> 4);
				chr2 = ((enc2 & 15) << 4) | (enc3 >> 2);
				chr3 = ((enc3 & 3) << 6) | enc4;

				output = output + String.fromCharCode(chr1);

				if (enc3 != 64) {
					output = output + String.fromCharCode(chr2);
				}
				if (enc4 != 64) {
					output = output + String.fromCharCode(chr3);
				}

			}

			output = Base64._utf8_decode(output);

			return output;

		},

		// private method for UTF-8 encoding
		_utf8_encode : function (string) {
			string = string.replace(/\r\n/g,"\n");
			var utftext = "";

			for (var n = 0; n < string.length; n++) {

				var c = string.charCodeAt(n);

				if (c < 128) {
					utftext += String.fromCharCode(c);
				}
				else if((c > 127) && (c < 2048)) {
					utftext += String.fromCharCode((c >> 6) | 192);
					utftext += String.fromCharCode((c & 63) | 128);
				}
				else {
					utftext += String.fromCharCode((c >> 12) | 224);
					utftext += String.fromCharCode(((c >> 6) & 63) | 128);
					utftext += String.fromCharCode((c & 63) | 128);
				}

			}

			return utftext;
		},

		// private method for UTF-8 decoding
		_utf8_decode : function (utftext) {
			var string = "";
			var i = 0;
			var c = c1 = c2 = 0;

			while ( i < utftext.length ) {

				c = utftext.charCodeAt(i);

				if (c < 128) {
					string += String.fromCharCode(c);
					i++;
				}
				else if((c > 191) && (c < 224)) {
					c2 = utftext.charCodeAt(i+1);
					string += String.fromCharCode(((c & 31) << 6) | (c2 & 63));
					i += 2;
				}
				else {
					c2 = utftext.charCodeAt(i+1);
					c3 = utftext.charCodeAt(i+2);
					string += String.fromCharCode(((c & 15) << 12) | ((c2 & 63) << 6) | (c3 & 63));
					i += 3;
				}

			}

			return string;
		}

	}