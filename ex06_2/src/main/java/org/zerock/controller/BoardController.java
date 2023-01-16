package org.zerock.controller;

import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.List;

import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
import org.zerock.domain.BoardAttachVO;
import org.zerock.domain.BoardVO;
import org.zerock.domain.Criteria;
import org.zerock.domain.PageDTO;
import org.zerock.service.BoardService;

import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;

@Controller
@Log4j
@RequestMapping("/board/*")
@AllArgsConstructor
public class BoardController {
	
	private BoardService service;
	
//	@GetMapping("/list")
//	public void list(Model model) {
//		
//		log.info("list...........................................................");
//		
//		model.addAttribute("list",service.getList());
//	}
	@GetMapping("/list")
	public void list(Criteria cri, Model model) {
		
		log.info("list : "+cri);
		model.addAttribute("list",service.getList(cri));
//		model.addAttribute("pageMaker",new PageDTO(cri, 123));
		
		int total = service.getTotal(cri);
		
		log.info("total : "+total);
		
		model.addAttribute("pageMaker",new PageDTO(cri, total));
	}
	
	
	
	
	
	@PostMapping("/register")
	@PreAuthorize("isAuthenticated()") // 로그인을 통해 인증이 되야만 해당 매핑 기능 사용 가능
	public String register(BoardVO board, RedirectAttributes rttr) {
		
		log.info("register : "+board);
		
		if(board.getAttachList() != null) {
			board.getAttachList().forEach(attach -> log.info(attach));
		}
		
		service.register(board);
		rttr.addFlashAttribute("result",board.getBno());
		
		return "redirect:/board/list";
	}
	// 연결을 위한 임시 매핑 주소
	@GetMapping("/register")
	@PreAuthorize("isAuthenticated()")
	public void register() {
		log.info("register GetMapping..............................................");
	}
	
	
	
	
										// ModelAttribute(이름) 클래스 객체 => Mapping 되면서 날라온
	@GetMapping({"/get","/modify"})		// 데이터들을 자동으로 객체에 담아 이름으로 Model 에 담김
	public void get(@RequestParam("bno") Long bno, @ModelAttribute("cri") Criteria cri, 
			Model model) {
		
		log.info("get or modify....................................................");
		model.addAttribute("board",service.get(bno));
	}
	
	
	
	
	
	@PostMapping("/modify")
	public String modify(BoardVO board, RedirectAttributes rttr, Criteria cri) {
		
		log.info("modify : " + board);
		
		if (service.modify(board)) {
			rttr.addFlashAttribute("result", "modify");
		}
		
		return "redirect:/board/list" + cri.getListLink();
	}
	
	
	
	
	
	@PostMapping("/remove")
	public String remove(@RequestParam("bno") Long bno, RedirectAttributes rttr,
		// @ModelAttribute("cri") 
		Criteria cri) {
		log.info("remove..........................................."+bno);
		
		List<BoardAttachVO> attachList = service.getAttachList(bno);
		
		
		if (service.remove(bno)) {
			deleteFiles(attachList);
			rttr.addFlashAttribute("result", "remove");
		}
		
//		rttr.addAttribute("pageNum",cri.getPageNum());
//		rttr.addAttribute("amount",cri.getAmount());
//		rttr.addAttribute("type",cri.getType());
//		rttr.addAttribute("keyword",cri.getKeyword());
		
		
		return "redirect:/board/list" + cri.getListLink();
	}
	
	
	
	
	
	@GetMapping(value = "/getAttachList",
				produces = MediaType.APPLICATION_JSON_UTF8_VALUE)
	@ResponseBody
	public ResponseEntity<List<BoardAttachVO>> getAttachList(Long bno) {
		
		log.info("getAttachList : " + bno);
		
		return new ResponseEntity<>(service.getAttachList(bno), HttpStatus.OK);
	}
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	private void deleteFiles(List<BoardAttachVO> attachList) {
		
		if (attachList == null || attachList.size() == 0) return;
		
		log.info("deleteFiles...................................");
		log.info("attachList : " + attachList);
		
		attachList.forEach(attach -> {
			try {
				Path file = Paths.get(
						"D:\\folderForPractice\\" + attach.getUploadPath()
						+ "\\" + attach.getUuid()
						+ "_" + attach.getFileName()
				);
				
				Files.deleteIfExists(file);
				
				if (Files.probeContentType(file).startsWith("image")) {
					Path thumbNail = Paths.get(
							"D:\\folderForPractice\\" + attach.getUploadPath()
							+ "\\s_" + attach.getUuid()
							+ "_" + attach.getFileName()
					);
					
					Files.delete(thumbNail);
				}
				
			}catch(Exception e) {
				e.printStackTrace();
			}
		});
	}
}
