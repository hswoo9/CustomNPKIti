
//////////////////////////// keno 제거버전 js입니다 ////////////////////////////////////

// 20170302 - sub_nav 커스텀, 컨텐츠 분할 레이아웃 사용시, 컨텐츠 분할 레이아웃 사용안할시(외주,메일 등등)   스크립트 삭제

//////////////////////////////////////////////////////////////////
/**************************************************
   common2.js
   
   [수정내역]
   20170426 - 새로고침시 헤더 떨어지는 현상 고정 (이준혁)
                - 헤더 더보기 메뉴 하나일시 바로 나오게끔 수정 (이준혁)
   20170518 - 스크롤시 jqueryui 셀렉트 옵션 닫기 추가 (이준혁)
   20170613 - jqueryui 셀렉트 ie,크롬 사이즈가 상이한 오류 수정 (이준혁)
  
**************************************************/
/******/

$(function(){
	$(document).ready(function(){
		/*게시판버튼on/off*/
		$(".st_btn a").click(function(){
			if (!$(this).hasClass("on")){
				$(this).addClass("on");
				$(this).siblings().removeClass("on");
			}else if ($(this).hasClass("on")){
				$(this).removeClass("on");
			}
		});

		/* 서브상단 신규버튼 시 table 영역 보이기 */
		$( ".layer_show button" ).click(function() {							  
			$( ".com_ta" ).show();
		});
		$( ".layer_hide input" ).click(function() {							  
			  $( ".com_ta" ).hide();
		});


	   // 서브페이지 상세검색 slideToggle
		$(".SearchDetail").hide();
		$(".btn_Detail").click(function(){
		  $(".SearchDetail").slideToggle("slow");
		  
			 if($('#all_menu_btn').attr('src')== _g_contextPath_ + '/Images/ico/ico_btn_arr_down01.png'){
				$('#all_menu_btn').attr('src', _g_contextPath_ + '/Images/ico/ico_btn_arr_up01.png');
			}else{
				$('#all_menu_btn').attr('src', _g_contextPath_ + '/Images/ico/ico_btn_arr_down01.png');
			}
	   });
	   // 업무,할일 좌측 상세검색 slideToggle 로컬코드
        $(".btn_Detail2").click(function(){
            $(".um_dtl").slideToggle("slow");
            if($('.btn_Detail2 img').attr('src')== _g_contextPath_ + '/Images/ico/ico_btn_arr_down01.png'){
                $('.btn_Detail2 img').attr('src', _g_contextPath_ + '/Images/ico/ico_btn_arr_up01.png');
            }else{
                $('.btn_Detail2 img').attr('src', _g_contextPath_ + '/Images/ico/ico_btn_arr_down01.png');
            }
       });
        
       // checkbox , radio 숨기기
    	$.each($("input[type='checkbox'] , input[type='radio']"), function(idx,val) {
    		if($(this).next().prop("tagName") == 'LABEL' ){
    			$(this).css("visibility","hidden");
    		}
    		
    	});


	   // 팝업창 닫기	  
	   //$('.clo').click(function() {
		//	$('.pop_wrap').hide();
		//  });

		// 서브 tab 이동시 상세검색영역 닫기
		$("#tabstrip ul li").click(function(){
			$(".SearchDetail").hide();								
		});
	});
	

/*시작 jstree 2뎁스**************************************************************/
	//2뎁스 컨트롤 (20170316 허정명 수정)
	$(document).on("click",".sub_2dep",function(e){
		e.preventDefault();
        var This = $(this);
            
        // 다중메뉴 열기
        if(This.hasClass("on")){
            This.removeClass("on");
            This.next(".sub_2dep_in").stop().slideUp();
        }else{
            This.addClass("on");
            This.next(".sub_2dep_in").stop().slideDown();
        };
        
        // 자식요소 없을때
        if(This.children().hasClass("non_sub")){
            This.addClass("on");
        }else{
            $(".non_sub").parent().removeClass('on')
        }; 
        
        // 사용자,관리자에 따른 이미지 변경   
        if($("body").hasClass("admin")){
            if(This.hasClass("on")){
                 This.find('span').css("background","#89add1 url(" + _g_contextPath_ + "/Images/bg/sub_2dh_arr_03.png) no-repeat 95% 16px;");
            }else{
                 This.find('span').css("background","url(" + _g_contextPath_ + "/Images/bg/sub_2dh_arr_01.png) no-repeat 95% 16px;");
            };
        
        }else{
           if(This.hasClass("on")){
                 This.find('span').css("background","#d8eafc url(" + _g_contextPath_ + "/Images/bg/sub_2dh_arr_02.png) no-repeat 95% 16px");
           }else{
                 This.find('span').css("background","url(" + _g_contextPath_ + "/Images/bg/sub_2dh_arr_01.png) no-repeat 95% 16px");
           };
           
        }
    });
    /**************************************************************jstree 2뎁스 종료*/

/*테이블넓이정하기*/
$(document).ready(function() {
	iframeWid();
	//Mcalendar_size();
	note_size();//일정_노트
	subConWid();
	ta_size();
	setTimeout(rec_size,300);
	//rec_size();
	bdListH();// 게시판 좌측 리스트 높이
	adminWorkResizeBox()//관리자 > 업무 > 사용자일괄추가
	um_size()
	comp_size()//회사정보관리(관리자)
	docResize();//전자결재_양식편집팝업
	$(window).resize(function() {
		note_size();//일정_노트
		ta_size();
		iframeWid();
		bdListH();// 게시판 좌측 리스트 높이
		adminWorkResizeBox()//관리자 > 업무 > 사용자일괄추가
		comp_size()//회사정보관리(관리자)
		docResize();//전자결재_양식편집팝업
		//subConWid();		
	});

	$("#treeview").click(function() {
		setTimeout(rec_size,100);
		//rec_size();
	});

});

//전자결재_헤더에 따른 컨텐츠조절
function docHeaderResize(){
    var docHeaderHdi = $('.pop_sign_head').height();
    $('.pop_sign_con').css("paddingTop",docHeaderHdi+"px");
    $('.signline_info_box').css("top",(docHeaderHdi-42) + 54 +"px");
}

//전자결재_양식편집팝업
function docResize(){
    var docEditWrapHei = $('html').height();
    $('.doc_code_list').height(docEditWrapHei-178);
}

// 게시판 좌측 리스트 높이
function bdListH(){
     var sl_hei=$(".sub_left").height();
     $(".bd_list_box.workcate").height(sl_hei-167);// 업무카테고리 좌측 리스트 높이
     $(".bd_list_box.bdlist").height(sl_hei-57);// 게시판관리 좌측 리스트 높이
}


// 기록물철별문서
function ta_size(){
	 var scw_wid=$(".sub_contents_wrap").width() - 38;
	 var scw_hei=$(".sub_contents_wrap").height();
	 var record_wid=$(".sub_left").width();
	 $(".sub_con").width(scw_wid - record_wid ); //10 => 레프트조절영역
}

//회사정보관리
function comp_size(){
     var scw_wid=$(".sub_contents_wrap").width();
     var record_wid=$(".sub_left").width();
     $(".comp_sub_con").width(scw_wid - record_wid - 13 ); //회사정보관리 사이즈조정
}

function rec_size(){	 
	var scw_hei=$(".sub_contents_wrap").height();
//	var tree_hei=$(".treeTop").height();	 

	var treetitle_hei=$(".tree_title").height();
	var recordTab_hei=$(".record_tab").height() + 10;
	var recordSea_hei=$(".record_tabSearch").height() + 30;
	var etc_folder_hei=$(".etc_folder").height();
	var sb_btn_top_hei=$(".sb_btn_top").height();	

	$(".sub_left").height(scw_hei);	

	if ($(".record_tab").length > 0 && $(".record_tabSearch").length > 0)
	{
		$(".tree_auto").height(scw_hei - recordTab_hei - recordSea_hei - treetitle_hei - etc_folder_hei - sb_btn_top_hei -11);
	} else if($(".record_tab").length > 0 )
	{
		$(".tree_auto").height(scw_hei - recordTab_hei - treetitle_hei - etc_folder_hei - sb_btn_top_hei -11);
	} else if($(".record_tabSearch").length > 0 )
	{
		$(".tree_auto").height(scw_hei - recordSea_hei - treetitle_hei - etc_folder_hei - sb_btn_top_hei -11);
	} else {
		$(".tree_auto").height(scw_hei - treetitle_hei - etc_folder_hei - sb_btn_top_hei -11);
	}

}

/*업무관리 리스트 사이즈*/
function um_size(){
var sccon_hei = $(".sub_con").height() + 65;	
var umTop_hei = $(".um_top").height();	

$(".um_auto").height(sccon_hei-umTop_hei);	

}

/*아이프레임width값*/
function iframeWid(){
	var hori_wid=$("#horizontal ").width();
	var sw_wid=$(".side_wrap ").width();
	if((hori_wid - sw_wid -8) > 0)
		$(".sub_contents iframe").width( hori_wid - sw_wid -8 );
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
function note_size(){
	var conWrapHei =$(".contents_wrap").height();
	var headWrapHei =$(".header_wrap").height();
	var footWrapHei =$(".footer").height();
	var sc_hei=$(".sub_contents").height(conWrapHei-headWrapHei-footWrapHei);
					
    var sc_wid=$(".sub_contents").width();
    var sct_hei=$(".sub_title_wrap").height();
	//alert(sc_hei);
   //$(".note_con").width(sc_wid-42);
    $(".note_con").height(sc_hei-sct_hei-150);
    var nt_con_hei=$(".note_con").height();
    //$(".note_right").width(sc_wid-314);
    $(".note_d_con").height(nt_con_hei-211);
	$("iframe").height();
}


//관리자 > 업무 > 사용자일괄추가 :: 20170111(허정명)
function adminWorkResizeBox(){
    var scW = $('.sub_contents').width()-40;
    var scH = $('.sub_contents').height();
    var stwH = $('.sub_title_wrap').height();
    var tit_pH = $('.admin_work_wrap .tit_p').outerHeight(true);
    var tit_p2H = $('.admin_work_wrap .tit_p2').outerHeight(true);
    
    $('.left_box').width(scW-267);
    $('.left_box, .right_box').height(scH-stwH);
    
    $('.admin_work_wrap').height(scH-stwH-20);
    $('.admin_work_wrap .left_box .sub_contents_border').height(scH-stwH-210);
    
    // 켄도테이블있을때 버전 $('.admin_work_wrap .left_box .sub_contents_border .data_grid .k-grid-content').css("max-height",scH-stwH-270+"px");
    
    //일반테이블 계산
    $('.admin_work_wrap .left_box .sub_contents_border .com_ta2.scroll').css("max-height",scH-stwH-248+"px");
    
    $('.proj_box .tc_box').outerHeight((scH-stwH-tit_pH-20)/3 - tit_p2H);
}


//팝업 중 취소버튼 클릭 이벤트 (일정 > 폴더변경팝업 참고)
 $(".gray_btn").click(function(){
	$(this).closest("[data-role=window]").kendoWindow("close");
  });


/********************************************************************************************************************
레프트 리사이징
********************************************************************************************************************/

$(document).ready(function() {
		horResize();
	$(window).resize(function() { 
			horResize();
	});

    function horResize(){
		var conWrapHei =$(".contents_wrap").height();
		var headWrapHei =$(".header_wrap").height();
		var footWrapHei =$(".footer").height();
		$("#horizontal").height(conWrapHei-headWrapHei-footWrapHei);
		$("#oneContents").height(conWrapHei-headWrapHei-footWrapHei);
		//var subWrapWid =$(".sub_wrap").width();
		//$(".sub_contents").width(subWrapWid-7);
	}	
});


/* sub_contents넓이 */
function subConWid(){
	/*20160803 장지훈 추가 (리사이즈 시 영역 나뉨 현상 수정)*/
	//console.log("subConwid");
	var k_wid=$(".k-splitbar").width();
	 if ($(".side_wrap").length > 0) 
	 {
		 //$(".sub_contents").width($(".sub_wrap").width()-8);
	 }else {
		//$(".sub_contents").width($(".sub_wrap").width()-0);
	 }
}


//바로가기 레이어팝업 온/오프
	$(".btn_link").on("click",function(){
		$('.layer_sel_pop').show();
	}),
	$(".pop_close, .sel_pop_con ul li a").on("click",function(){
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
 /*
	for (i=0;i <= $(".pop_wrap").size() ; i++)
	{

	 var popWid = $(".pop_wrap").eq(i).outerWidth();
	 var popHei = $(".pop_wrap").eq(i).outerHeight();

	$(".pop_wrap").eq(i).css("top","50%").css("left","50%").css("marginLeft",-popWid/2).css("marginTop",-popHei/2);

	}
*/	
	
	var pwd_head_Hei =$(".pop_auto_hei > .pop_head").height();
	var pwd_foot_Hei = $(".pop_auto_hei > .pop_foot").height();
	var pwd_con_Hei = $(".pop_auto_hei > .pop_con").height();
	
	$(".pop_auto_hei > .pop_con").css("overflow-y", "auto");
	if ($(".pop_auto_hei > .pop_con").height() >= $(window).height()-pwd_head_Hei-pwd_foot_Hei-200)
	{	
		$(".pop_auto_hei > .pop_con").css("height", $(window).height()-pwd_head_Hei-pwd_foot_Hei-200);
		
	} else	{
			$(".pop_auto_hei > .pop_con").css("height", "auto");
	}

	/*if ($(window).scrollTop() >= $(document).height() - $(window).height())
	{	
		$(".pop_auto_hei > .pop_con").css("overflow","auto");
		
	} else	{
		$(".pop_auto_hei > .pop_con").css("height", $(window).height()-pwd_head_Hei-pwd_foot_Hei-200);
		
	} 테스트예정 170323*/

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
				
		if($(window).height() >= $(document).height() )
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
		var th_txt =	$(this).text();
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

	if ((document.documentElement.innerHTML || document.documentElement.innerText).indexOf('jquery-ui.min.js') > -1) {
	  $( ".selectmenu" ).selectmenu();
	
		$.each($('select'), function () {
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
					$.each($('select'), function () {
						$(this).selectmenu({ width : $(this).width() + 9});
					});
				}

				if (Browser.chm) {
					$.each($('select'), function () {
						$(this).selectmenu({ width : $(this).width() + 17});
					});
				}
	}

	$("div").scroll(function(){
		$(".selectmenu").selectmenu("close");
	});
	$("iframe").scroll(function(){
		$(".selectmenu").selectmenu("close");
	});


});

//////////////////////////////////////////////////////////////////
//게시판 view 넓이계산
$(document).ready(function(){
    boardViewContents();
    
    $(window).resize(function() {
         boardViewContents();     
    });
});
function boardViewContents(){
    var viewBoxWid = $(".sub_contents_wrap").width()-34;
    $(".text_view_box").width(viewBoxWid);
};
//////////////////////////////////////////////////////////////////