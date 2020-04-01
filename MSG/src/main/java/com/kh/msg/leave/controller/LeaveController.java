package com.kh.msg.leave.controller;

import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.SessionAttributes;
import org.springframework.web.servlet.ModelAndView;

import com.kh.msg.leave.model.service.LeaveService;
import com.kh.msg.leave.model.vo.Leave;
import com.kh.msg.leave.model.vo.LeaveInfoPlus;
import com.kh.msg.leave.model.vo.LeavePlus;
import com.kh.msg.leave.model.vo.LeaveSet;
import com.kh.msg.leave.model.vo.LeaveSum;
import com.kh.msg.leave.model.vo.MyLeave;
import com.kh.msg.member.model.vo.HrMntList;
import com.kh.msg.member.model.vo.Member;

import lombok.extern.slf4j.Slf4j;

@Controller
@Slf4j
@RequestMapping("/leave")
public class LeaveController {

	@Autowired
	LeaveService leaveService;

	@GetMapping("/list.do")
	public ModelAndView leave(ModelAndView mav) {

		log.debug("leaveService={}", leaveService.getClass());

		List<Leave> leaveList = leaveService.selectLeaveList();

		mav.addObject("leaveList", leaveList);

		mav.setViewName("leave/allvacation");

		return mav;
	}

	@GetMapping("/select.do")
	public ModelAndView leave3(ModelAndView mav,
							  HttpSession session) {
		log.debug("leaveService={}", leaveService.getClass());
		List<MyLeave> leaveList4 = leaveService.selectLeaveList4((Member) session.getAttribute("memberLoggedIn"));
		List<LeaveInfoPlus> leaveListInfoPlus = leaveService.selectleaveListInfoPlus((Member) session.getAttribute("memberLoggedIn"));
		LeaveInfoPlus lip = new LeaveInfoPlus();
		int au = 0;
		int ru = 0;
		int fu = 0;
		int fau = 0;
		int su = 0;
		int uu = 0;
		int ou = 0;

		for (int i = 0; i < leaveListInfoPlus.size(); i++) {

			lip.setEmpNo(leaveListInfoPlus.get(i).getEmpNo());
			lip.setDeptName(leaveListInfoPlus.get(i).getDeptName());
			lip.setJobName(leaveListInfoPlus.get(i).getJobName());
			lip.setUserId(leaveListInfoPlus.get(i).getUserId());
			lip.setEmpName(leaveListInfoPlus.get(i).getEmpName());
			lip.setAnnual(leaveListInfoPlus.get(i).getAnnual());
			lip.setReward(leaveListInfoPlus.get(i).getReward());
			if (leaveListInfoPlus.get(i).getVctnCd() == 1) {
				au += leaveListInfoPlus.get(i).getVctnUsed();
			} else if (leaveListInfoPlus.get(i).getVctnCd() == 2) {
				ru += leaveListInfoPlus.get(i).getVctnUsed();
			} else if (leaveListInfoPlus.get(i).getVctnCd() == 3) {
				fu += leaveListInfoPlus.get(i).getVctnUsed();
				;
			} else if (leaveListInfoPlus.get(i).getVctnCd() == 4) {
				fau += leaveListInfoPlus.get(i).getVctnUsed();
			} else if (leaveListInfoPlus.get(i).getVctnCd() == 5) {
				su += leaveListInfoPlus.get(i).getVctnUsed();
			} else if (leaveListInfoPlus.get(i).getVctnCd() == 6) {
				uu += leaveListInfoPlus.get(i).getVctnUsed();
			} else if (leaveListInfoPlus.get(i).getVctnCd() == 7) {
				ou += leaveListInfoPlus.get(i).getVctnUsed();
			}

		}
		lip.setAnnualUsed(au);
		lip.setRewardUsed(ru);
		lip.setFloatingUsed(fu);
		lip.setFamilyeventUsed(fau);
		lip.setSickleaveUsed(su);
		lip.setUnpaidUsed(uu);
		lip.setOtherUsed(ou);
		lip.setAnnualNotUsed(lip.getAnnual() - lip.getAnnualUsed());
		lip.setRewardNotused(lip.getReward()- lip.getRewardUsed());
		
		leaveListInfoPlus.add(lip);

		mav.addObject("leaveList4", leaveList4);
		mav.addObject("leaveListInfoPlus", leaveListInfoPlus);

		mav.setViewName("leave/myvacation");

		return mav;
	}
	@PostMapping("/update.do")
	public ModelAndView leaveModal(ModelAndView mav) {
		
		
		return mav;
	}

	@GetMapping("/update.do")
	public ModelAndView leave2(ModelAndView mav) {

		List<LeaveSet> leaveList2 = leaveService.selectLeaveList2();
		List<LeavePlus> leaveList3 = leaveService.selectLeaveList3();
		List<LeaveSum> listSum = new ArrayList<>();
		int emp = 0;

		for (int i = 0; i < leaveList2.size(); i++) {
			LeaveSum ls = new LeaveSum();
			ls.setVctnNo(leaveList2.get(i).getVctnNo());
			ls.setDeptName(leaveList2.get(i).getDeptName());
			ls.setEmpName(leaveList2.get(i).getEmpName());
			ls.setLongevity(leaveList2.get(i).getLongevity());
			ls.setReward(leaveList2.get(i).getReward());
			ls.setAnnual(leaveList2.get(i).getAnnual());
			ls.setEmpNo(leaveList2.get(i).getEmpNo());

			int ot = 0;
			for (int j = emp; j < leaveList3.size(); j++) {
				if (ls.getEmpNo() == leaveList3.get(j).getEmpNo()) {
					if (leaveList3.get(j).getVctnCd() == 1) {
						ls.setAnnualUsed(leaveList3.get(j).getVctnUsed());
					} else if (leaveList3.get(j).getVctnCd() == 2) {
						ls.setRewardUsed(leaveList3.get(j).getVctnUsed());
					} else {

						ot += leaveList3.get(j).getVctnUsed();
					}

				} else {
					emp = j;
					break;
				}

			}
			ls.setOtherUsed(ot);
			listSum.add(ls);
		}
		System.out.println("listSum" + listSum);

		mav.addObject("listSum", listSum);

		mav.setViewName("leave/vacation");

		return mav;
	}

}
