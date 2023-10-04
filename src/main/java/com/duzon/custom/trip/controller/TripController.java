package com.duzon.custom.trip.controller;

import java.util.Locale;
import java.util.Map;

import javax.naming.NoPermissionException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.duzon.custom.common.utiles.EgovUserDetailsHelper;
import com.duzon.custom.trip.service.TripService;

import bizbox.orgchart.service.vo.LoginVO;

@Controller
public class TripController {
	private static final Logger logger = LoggerFactory.getLogger(TripController.class);
	
	@Autowired private TripService tripService;
	
	/**
	 * @MethodName : manageTripArea
	 * @Author     : pjm
	 * @Since      : 2019. 5. 22.
	 * @Detail     : 출장지관리
	 */
	@RequestMapping(value = "/trip/manageTripArea", method = RequestMethod.GET)
	public String manageTripArea(Locale locale, Model model, HttpServletRequest servletRequest) throws NoPermissionException {
		logger.info("manageTripArea");
		return "/trip/manageTripArea";
	}

	/**
	 * @MethodName : selectTripAreaList
	 * @author : pjm
	 * @since : 2019. 5. 22.
	 * 설명 : 출장지관리 리스트
	 */
	@RequestMapping(value = "/trip/selectTripAreaList")
	@ResponseBody
	public Map<String, Object> selectTripAreaList(@RequestParam Map<String, Object> map){
		logger.info("selectTripAreaList");
		LoginVO loginVO = (LoginVO)EgovUserDetailsHelper.getAuthenticatedUser();
		map.put("groupSeq", loginVO.getGroupSeq());
		map.put("compSeq", loginVO.getOrganId());
		map.put("deptSeq", loginVO.getOrgnztId());
		map.put("empSeq", loginVO.getUniqId());
		map.put("langCode", loginVO.getLangCode());
		return tripService.selectTripAreaList(map);
	}
	
	/**
	 * @MethodName : selectTripAreaDetail
	 * @author : pjm
	 * @since : 2019. 5. 22.
	 * 설명 : 출장지관리 디테일
	 */
	@RequestMapping(value = "/trip/selectTripAreaDetail")
	@ResponseBody
	public Map<String, Object> selectTripAreaDetail(@RequestParam Map<String, Object> map){
		logger.info("selectTripAreaDetail");
		LoginVO loginVO = (LoginVO)EgovUserDetailsHelper.getAuthenticatedUser();
		map.put("groupSeq", loginVO.getGroupSeq());
		map.put("compSeq", loginVO.getOrganId());
		map.put("deptSeq", loginVO.getOrgnztId());
		map.put("empSeq", loginVO.getUniqId());
		map.put("langCode", loginVO.getLangCode());
		return tripService.selectTripAreaDetail(map);
	}
	
	/**
	 * @MethodName : insertTripArea
	 * @author : pjm
	 * @since : 2019. 5. 22.
	 * 설명 : 출장지관리 저장
	 */
	@RequestMapping(value = "/trip/insertTripArea", method = RequestMethod.POST)
	@ResponseBody
	public boolean insertTripArea(@RequestParam Map<String, Object> map){
		logger.info("insertTripArea");
		LoginVO loginVO = (LoginVO)EgovUserDetailsHelper.getAuthenticatedUser();
		map.put("groupSeq", loginVO.getGroupSeq());
		map.put("compSeq", loginVO.getOrganId());
		map.put("deptSeq", loginVO.getOrgnztId());
		map.put("empSeq", loginVO.getUniqId());
		map.put("langCode", loginVO.getLangCode());
		return tripService.insertTripArea(map);
	}
	
	/**
	 * @MethodName : updateTripArea
	 * @author : pjm
	 * @since : 2019. 5. 22.
	 * 설명 : 출장지관리 수정
	 */
	@RequestMapping(value = "/trip/updateTripArea")
	@ResponseBody
	public boolean updateTripArea(@RequestParam Map<String, Object> map){
		logger.info("updateTripArea");
		LoginVO loginVO = (LoginVO)EgovUserDetailsHelper.getAuthenticatedUser();
		map.put("groupSeq", loginVO.getGroupSeq());
		map.put("compSeq", loginVO.getOrganId());
		map.put("deptSeq", loginVO.getOrgnztId());
		map.put("empSeq", loginVO.getUniqId());
		map.put("langCode", loginVO.getLangCode());
		return tripService.updateTripArea(map);
	}
	
	/**
	 * @MethodName : selectTripAreaDetail
	 * @author : pjm
	 * @since : 2019. 5. 22.
	 * 설명 : 출장지관리 삭제
	 */
	@RequestMapping(value = "/trip/deleteTripArea")
	@ResponseBody
	public Map<String, Object> deleteTripArea(@RequestParam Map<String, Object> map){
		logger.info("deleteTripArea");
		LoginVO loginVO = (LoginVO)EgovUserDetailsHelper.getAuthenticatedUser();
		map.put("groupSeq", loginVO.getGroupSeq());
		map.put("compSeq", loginVO.getOrganId());
		map.put("deptSeq", loginVO.getOrgnztId());
		map.put("empSeq", loginVO.getUniqId());
		map.put("langCode", loginVO.getLangCode());
		return tripService.deleteTripArea(map);
	}
	
	/**
	 * @MethodName : manageTripPositionGroup
	 * @Author     : pjm
	 * @Since      : 2019. 5. 22.
	 * @Detail     : 직책그룹관리
	 */
	@RequestMapping(value = "/trip/manageTripPositionGroup", method = RequestMethod.GET)
	public String manageTripPositionGroup(Locale locale, Model model, HttpServletRequest servletRequest) throws NoPermissionException {
		logger.info("manageTripPositionGroup");
		return "/trip/manageTripPositionGroup";
	}
	
	/**
	 * @MethodName : selectTripPositionGroupList
	 * @author : pjm
	 * @since : 2019. 5. 22.
	 * 설명 : 직책그룹관리 리스트
	 */
	@RequestMapping(value = "/trip/selectTripPositionGroupList")
	@ResponseBody
	public Map<String, Object> selectTripPositionGroupList(@RequestParam Map<String, Object> map){
		logger.info("selectTripPositionGroupList");
		LoginVO loginVO = (LoginVO)EgovUserDetailsHelper.getAuthenticatedUser();
		map.put("groupSeq", loginVO.getGroupSeq());
		map.put("compSeq", loginVO.getOrganId());
		map.put("deptSeq", loginVO.getOrgnztId());
		map.put("empSeq", loginVO.getUniqId());
		map.put("langCode", loginVO.getLangCode());
		return tripService.selectTripPositionGroupList(map);
	}
	
	/**
	 * @MethodName : selectTripPositionGroupDetail
	 * @author : pjm
	 * @since : 2019. 5. 22.
	 * 설명 : 직책그룹관리 디테일
	 */
	@RequestMapping(value = "/trip/selectTripPositionGroupDetail")
	@ResponseBody
	public Map<String, Object> selectTripPositionGroupDetail(@RequestParam Map<String, Object> map){
		logger.info("selectTripPositionGroupDetail");
		LoginVO loginVO = (LoginVO)EgovUserDetailsHelper.getAuthenticatedUser();
		map.put("groupSeq", loginVO.getGroupSeq());
		map.put("compSeq", loginVO.getOrganId());
		map.put("deptSeq", loginVO.getOrgnztId());
		map.put("empSeq", loginVO.getUniqId());
		map.put("langCode", loginVO.getLangCode());
		return tripService.selectTripPositionGroupDetail(map);
	}
	
	/**
	 * @MethodName : insertTripPositionGroup
	 * @author : pjm
	 * @since : 2019. 5. 22.
	 * 설명 : 직책그룹관리 저장
	 */
	@RequestMapping(value = "/trip/insertTripPositionGroup", method = RequestMethod.POST)
	@ResponseBody
	public boolean insertTripPositionGroup(@RequestParam Map<String, Object> map){
		logger.info("insertTripPositionGroup");
		LoginVO loginVO = (LoginVO)EgovUserDetailsHelper.getAuthenticatedUser();
		map.put("groupSeq", loginVO.getGroupSeq());
		map.put("compSeq", loginVO.getOrganId());
		map.put("deptSeq", loginVO.getOrgnztId());
		map.put("empSeq", loginVO.getUniqId());
		map.put("langCode", loginVO.getLangCode());
		return tripService.insertTripPositionGroup(map);
	}
	
	/**
	 * @MethodName : updateTripPositionGroup
	 * @author : pjm
	 * @since : 2019. 5. 22.
	 * 설명 : 직책그룹관리 수정
	 */
	@RequestMapping(value = "/trip/updateTripPositionGroup")
	@ResponseBody
	public boolean updateTripPositionGroup(@RequestParam Map<String, Object> map){
		logger.info("updateTripPositionGroup");
		LoginVO loginVO = (LoginVO)EgovUserDetailsHelper.getAuthenticatedUser();
		map.put("groupSeq", loginVO.getGroupSeq());
		map.put("compSeq", loginVO.getOrganId());
		map.put("deptSeq", loginVO.getOrgnztId());
		map.put("empSeq", loginVO.getUniqId());
		map.put("langCode", loginVO.getLangCode());
		return tripService.updateTripPositionGroup(map);
	}
	
	/**
	 * @MethodName : deleteTripPositionGroup
	 * @author : pjm
	 * @since : 2019. 5. 22.
	 * 설명 : 직책그룹관리 삭제
	 */
	@RequestMapping(value = "/trip/deleteTripPositionGroup")
	@ResponseBody
	public Map<String, Object> deleteTripPositionGroup(@RequestParam Map<String, Object> map){
		logger.info("deleteTripPositionGroup");
		LoginVO loginVO = (LoginVO)EgovUserDetailsHelper.getAuthenticatedUser();
		map.put("groupSeq", loginVO.getGroupSeq());
		map.put("compSeq", loginVO.getOrganId());
		map.put("deptSeq", loginVO.getOrgnztId());
		map.put("empSeq", loginVO.getUniqId());
		map.put("langCode", loginVO.getLangCode());
		return tripService.deleteTripPositionGroup(map);
	}
	
	/**
	 * @MethodName : manageTripTrans
	 * @Author     : pjm
	 * @Since      : 2019. 5. 22.
	 * @Detail     : 교통수단관리
	 */
	@RequestMapping(value = "/trip/manageTripTrans", method = RequestMethod.GET)
	public String manageTripTrans(Locale locale, Model model, HttpServletRequest servletRequest) throws NoPermissionException {
		logger.info("manageTripTrans");
		return "/trip/manageTripTrans";
	}
	
	/**
	 * @MethodName : selectTripTransList
	 * @author : pjm
	 * @since : 2019. 5. 22.
	 * 설명 : 교통수단관리 리스트
	 */
	@RequestMapping(value = "/trip/selectTripTransList")
	@ResponseBody
	public Map<String, Object> selectTripTransList(@RequestParam Map<String, Object> map){
		logger.info("selectTripTransList");
		LoginVO loginVO = (LoginVO)EgovUserDetailsHelper.getAuthenticatedUser();
		map.put("groupSeq", loginVO.getGroupSeq());
		map.put("compSeq", loginVO.getOrganId());
		map.put("deptSeq", loginVO.getOrgnztId());
		map.put("empSeq", loginVO.getUniqId());
		map.put("langCode", loginVO.getLangCode());
		return tripService.selectTripTransList(map);
	}
	
	/**
	 * @MethodName : selectTripTransDetail
	 * @author : pjm
	 * @since : 2019. 5. 22.
	 * 설명 : 교통수단관리 디테일
	 */
	@RequestMapping(value = "/trip/selectTripTransDetail")
	@ResponseBody
	public Map<String, Object> selectTripTransDetail(@RequestParam Map<String, Object> map){
		logger.info("selectTripTransDetail");
		LoginVO loginVO = (LoginVO)EgovUserDetailsHelper.getAuthenticatedUser();
		map.put("groupSeq", loginVO.getGroupSeq());
		map.put("compSeq", loginVO.getOrganId());
		map.put("deptSeq", loginVO.getOrgnztId());
		map.put("empSeq", loginVO.getUniqId());
		map.put("langCode", loginVO.getLangCode());
		return tripService.selectTripTransDetail(map);
	}
	
	/**
	 * @MethodName : insertTripTrans
	 * @author : pjm
	 * @since : 2019. 5. 22.
	 * 설명 : 교통수단관리 저장
	 */
	@RequestMapping(value = "/trip/insertTripTrans", method = RequestMethod.POST)
	@ResponseBody
	public boolean insertTripTrans(@RequestParam Map<String, Object> map){
		logger.info("insertTripTrans");
		LoginVO loginVO = (LoginVO)EgovUserDetailsHelper.getAuthenticatedUser();
		map.put("groupSeq", loginVO.getGroupSeq());
		map.put("compSeq", loginVO.getOrganId());
		map.put("deptSeq", loginVO.getOrgnztId());
		map.put("empSeq", loginVO.getUniqId());
		map.put("langCode", loginVO.getLangCode());
		return tripService.insertTripTrans(map);
	}
	
	/**
	 * @MethodName : updateTripTrans
	 * @author : pjm
	 * @since : 2019. 5. 22.
	 * 설명 : 교통수단관리 수정
	 */
	@RequestMapping(value = "/trip/updateTripTrans")
	@ResponseBody
	public boolean updateTripTrans(@RequestParam Map<String, Object> map){
		logger.info("updateTripTrans");
		LoginVO loginVO = (LoginVO)EgovUserDetailsHelper.getAuthenticatedUser();
		map.put("groupSeq", loginVO.getGroupSeq());
		map.put("compSeq", loginVO.getOrganId());
		map.put("deptSeq", loginVO.getOrgnztId());
		map.put("empSeq", loginVO.getUniqId());
		map.put("langCode", loginVO.getLangCode());
		return tripService.updateTripTrans(map);
	}
	
	/**
	 * @MethodName : deleteTripTrans
	 * @author : pjm
	 * @since : 2019. 5. 22.
	 * 설명 : 교통수단관리 삭제
	 */
	@RequestMapping(value = "/trip/deleteTripTrans")
	@ResponseBody
	public boolean deleteTripTrans(@RequestParam Map<String, Object> map){
		logger.info("deleteTripTrans");
		LoginVO loginVO = (LoginVO)EgovUserDetailsHelper.getAuthenticatedUser();
		map.put("groupSeq", loginVO.getGroupSeq());
		map.put("compSeq", loginVO.getOrganId());
		map.put("deptSeq", loginVO.getOrgnztId());
		map.put("empSeq", loginVO.getUniqId());
		map.put("langCode", loginVO.getLangCode());
		return tripService.deleteTripTrans(map);
	}
	
	/**
	 * @MethodName : manageTripCost
	 * @Author     : pjm
	 * @Since      : 2019. 5. 22.
	 * @Detail     : 출장비단가관리
	 */
	@RequestMapping(value = "/trip/manageTripCost", method = RequestMethod.GET)
	public String manageTripCost(Locale locale, Model model, HttpServletRequest servletRequest) throws NoPermissionException {
		logger.info("manageTripCost");
		return "/trip/manageTripCost";
	}
	
	/**
	 * @MethodName : selectTripCostList
	 * @author : pjm
	 * @since : 2019. 5. 22.
	 * 설명 : 출장비단가관리 리스트
	 */
	@RequestMapping(value = "/trip/selectTripCostList")
	@ResponseBody
	public Map<String, Object> selectTripCostList(@RequestParam Map<String, Object> map){
		logger.info("selectTripCostList");
		LoginVO loginVO = (LoginVO)EgovUserDetailsHelper.getAuthenticatedUser();
		map.put("groupSeq", loginVO.getGroupSeq());
		map.put("compSeq", loginVO.getOrganId());
		map.put("deptSeq", loginVO.getOrgnztId());
		map.put("empSeq", loginVO.getUniqId());
		map.put("langCode", loginVO.getLangCode());
		return tripService.selectTripCostList(map);
	}
	
	/**
	 * @MethodName : selectTripCostDetail
	 * @author : pjm
	 * @since : 2019. 5. 22.
	 * 설명 : 출장비단가관리 디테일
	 */
	@RequestMapping(value = "/trip/selectTripCostDetail")
	@ResponseBody
	public Map<String, Object> selectTripCostDetail(@RequestParam Map<String, Object> map){
		logger.info("selectTripCostDetail");
		LoginVO loginVO = (LoginVO)EgovUserDetailsHelper.getAuthenticatedUser();
		map.put("groupSeq", loginVO.getGroupSeq());
		map.put("compSeq", loginVO.getOrganId());
		map.put("deptSeq", loginVO.getOrgnztId());
		map.put("empSeq", loginVO.getUniqId());
		map.put("langCode", loginVO.getLangCode());
		return tripService.selectTripCostDetail(map);
	}
	
	/**
	 * @MethodName : tripPositionGroupPop
	 * @Author     : pjm
	 * @Since      : 2019. 5. 22.
	 * @Detail     : 출장직무그룹검색팝업
	 */
	@RequestMapping(value = "/trip/pop/tripPositionGroupPop")
	public ModelAndView tripPositionGroupPop(Map<String, Object> map, HttpServletRequest servletRequest){
		logger.info("tripPositionGroupPop");
		LoginVO loginVO = (LoginVO)EgovUserDetailsHelper.getAuthenticatedUser();
		map.put("groupSeq", loginVO.getGroupSeq());
		map.put("compSeq", loginVO.getOrganId());
		map.put("deptSeq", loginVO.getOrgnztId());
		map.put("empSeq", loginVO.getUniqId());
		map.put("langCode", loginVO.getLangCode());
		
		String searchWord = servletRequest.getParameter("searchWord");		
		String domesticDiv = servletRequest.getParameter("domesticDiv");
		if(map.get("domesticDiv") != null){
			domesticDiv = map.get("domesticDiv").toString();
		} 
		String costDiv = servletRequest.getParameter("costDiv");
		if(map.get("costDiv") != null){
			costDiv = map.get("costDiv").toString();
		}
		
		map.put("domesticDiv", domesticDiv);
		map.put("costDiv", costDiv);
		map.put("pgroupname", searchWord);
		
		// 직급그룹목록 저장
		ModelAndView view = new ModelAndView();
		view.addObject("tripPositionGroupListPop", tripService.selectTripPositionGroupListPop(map));
		view.addObject("langCode", loginVO.getLangCode());
		view.addObject("domesticDiv", domesticDiv);
		view.addObject("costDiv", costDiv);
		view.addObject("searchWord", searchWord);
		
		view.setViewName("/trip/pop/tripPositionGroupPop");
		return view;
	}
	
	/**
	 * @MethodName : tripAreaPop
	 * @Author     : pjm
	 * @Since      : 2019. 5. 22.
	 * @Detail     : 출장지검색팝업
	 */
	@RequestMapping("/trip/pop/tripAreaPop")
	public ModelAndView tripAreaPop(Map<String, Object> map, HttpServletRequest servletRequest){
		LoginVO loginVO = (LoginVO)EgovUserDetailsHelper.getAuthenticatedUser();
		map.put("groupSeq", loginVO.getGroupSeq());
		map.put("compSeq", loginVO.getOrganId());
		map.put("deptSeq", loginVO.getOrgnztId());
		map.put("empSeq", loginVO.getUniqId());
		map.put("langCode", loginVO.getLangCode());
		
		//langCode 설정
		HttpSession session = servletRequest.getSession();
		String langCode = (session.getAttribute("langCode") == null ? "kr" : (String)session.getAttribute("langCode")).toLowerCase();
		map.put("langCode", langCode);
		
		String searchWord = servletRequest.getParameter("searchWord");
		String domesticDiv = servletRequest.getParameter("domesticDiv");
		if(map.get("domesticDiv") != null){
			domesticDiv = map.get("domesticDiv").toString();
		} 
		String costDiv = servletRequest.getParameter("costDiv");
		if(map.get("costDiv") != null){
			costDiv = map.get("costDiv").toString();
		}
		String localYn = servletRequest.getParameter("localYn");
		if(map.get("localYn") != null){
			localYn = map.get("localYn").toString();
		}
		
		map.put("domesticDiv", domesticDiv);
		map.put("costDiv", costDiv);
		map.put("localYn", localYn);
		map.put("areaname", searchWord);
		
		// 출장지목록 저장
		ModelAndView view = new ModelAndView();
		view.addObject("tripAreaListPop", tripService.selectTripAreaListPop(map));		
		view.addObject("langCode", langCode);
		view.addObject("domesticDiv", domesticDiv);
		view.addObject("costDiv", costDiv);
		view.addObject("localYn", localYn);
		view.addObject("searchWord", searchWord);
		view.setViewName("/trip/pop/tripAreaPop");
		return view;
	}
	
	/**
	 * @MethodName : insertTripCost
	 * @author : pjm
	 * @since : 2019. 5. 22.
	 * 설명 : 출장비단가관리 저장
	 */
	@RequestMapping(value = "/trip/insertTripCost", method = RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> insertTripCost(@RequestParam Map<String, Object> map){
		logger.info("insertTripCost");
		LoginVO loginVO = (LoginVO)EgovUserDetailsHelper.getAuthenticatedUser();
		map.put("groupSeq", loginVO.getGroupSeq());
		map.put("compSeq", loginVO.getOrganId());
		map.put("deptSeq", loginVO.getOrgnztId());
		map.put("empSeq", loginVO.getUniqId());
		map.put("langCode", loginVO.getLangCode());
		return tripService.insertTripCost(map);
	}
	
	/**
	 * @MethodName : updateTripCost
	 * @author : pjm
	 * @since : 2019. 5. 22.
	 * 설명 : 출장비단가관리 수정
	 */
	@RequestMapping(value = "/trip/updateTripCost")
	@ResponseBody
	public Map<String, Object> updateTripCost(@RequestParam Map<String, Object> map){
		logger.info("updateTripCost");
		LoginVO loginVO = (LoginVO)EgovUserDetailsHelper.getAuthenticatedUser();
		map.put("groupSeq", loginVO.getGroupSeq());
		map.put("compSeq", loginVO.getOrganId());
		map.put("deptSeq", loginVO.getOrgnztId());
		map.put("empSeq", loginVO.getUniqId());
		map.put("langCode", loginVO.getLangCode());
		return tripService.updateTripCost(map);
	}
	
	/**
	 * @MethodName : deleteTripCost
	 * @author : pjm
	 * @since : 2019. 5. 22.
	 * 설명 : 출장비단가관리 삭제
	 */
	@RequestMapping(value = "/trip/deleteTripCost")
	@ResponseBody
	public boolean deleteTripCost(@RequestParam Map<String, Object> map){
		logger.info("deleteTripCost");
		LoginVO loginVO = (LoginVO)EgovUserDetailsHelper.getAuthenticatedUser();
		map.put("groupSeq", loginVO.getGroupSeq());
		map.put("compSeq", loginVO.getOrganId());
		map.put("deptSeq", loginVO.getOrgnztId());
		map.put("empSeq", loginVO.getUniqId());
		map.put("langCode", loginVO.getLangCode());
		return tripService.deleteTripCost(map);
	}
}
