package org.zerock.controller;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.nio.file.Files;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.UUID;

import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.zerock.domain.AttachFileDTO;

import lombok.extern.log4j.Log4j;
import net.coobird.thumbnailator.Thumbnailator;

@Controller
@Log4j
public class UploadController {
	
	@GetMapping("/uploadForm")
	public void uploadForm() {
		
		log.info("upload form");
	}
	
	@PostMapping("/uploadFormAction")
	public void uploadFormPost(MultipartFile[] uploadFile, Model model) {
		
		for (MultipartFile multipartFile : uploadFile) {
			
			String uploadFolder = "D:\\folderForPractice";
			
			log.info("--------------------------------------------------------------------");
			log.info("UploadFormPost => File Name : " + multipartFile.getOriginalFilename());
			log.info("UploadFormPost => File Size : " + multipartFile.getSize());
			
			File saveFile = new File(uploadFolder, multipartFile.getOriginalFilename());
			
			try {
				multipartFile.transferTo(saveFile);
			}catch(Exception e) {
				log.error(e.getMessage());
			}
		}
	}
	
	@GetMapping("/uploadAjax")
	public void uploadAjax() {
		
		log.info("upload ajax");
	}
	
	
//	@PostMapping("/uploadAjaxAction")
//	public void uploadAjaxPost(MultipartFile[] uploadFile) {
//		
//		//make folder
//		String uploadFolder = "D:\\folderForPractice";
//		File uploadPath = new File(uploadFolder, getFolder());
//		log.info("upload path : " + uploadPath);
//		
//		if(!uploadPath.exists()) uploadPath.mkdirs();
//		
//		for (MultipartFile multipartFile : uploadFile) {
//			
//			
//			log.info("--------------------------------------------------------------------");
//			log.info("UploadFormPost => File Name : " + multipartFile.getOriginalFilename());
//			log.info("UploadFormPost => File Size : " + multipartFile.getSize());
//			
//			//UUID : Universally Unique Identifier
//			UUID uuid = UUID.randomUUID();
//			String uploadFileName = uuid.toString() + "_" + multipartFile.getOriginalFilename();
//			log.info(uploadFileName);
//			
//			try {
//				File saveFile = new File(uploadFolder, uploadFileName);
//				multipartFile.transferTo(saveFile);
//				// check image type file
//				if (checkImageType(saveFile)) {
//					FileOutputStream thumbnail = 
//							new FileOutputStream(
//									new File(uploadPath,"s_" + uploadFileName));
//					
//					Thumbnailator
//					.createThumbnail(multipartFile.getInputStream(),thumbnail,100,100);
//					
//					thumbnail.close();
//				}
//			}catch(Exception e) {
//				log.error(e.getMessage());
//			}
//		}
//	}
	
	@PostMapping(value = "/uploadAjaxAction" ,
			produces = MediaType.APPLICATION_JSON_UTF8_VALUE)
	@ResponseBody
	public ResponseEntity<List<AttachFileDTO>> uploadAjaxPost(MultipartFile[] uploadFiles){
		
		List<AttachFileDTO> list = new ArrayList<>();
		String uploadFolder = "D:\\folderForPractice";
		
		// make folder
		String uploadFolderPath = getFolder();
		File uploadPath = new File(uploadFolder, uploadFolderPath);
		
		if (!uploadPath.exists()) uploadPath.mkdirs();
		
		for (MultipartFile uploadFile : uploadFiles) {
			AttachFileDTO attachDTO = new AttachFileDTO();
			
			String uploadFileName = uploadFile.getOriginalFilename();
			log.info("uploadAjaxPost => uploadFileName : ");
			attachDTO.setFileName(uploadFileName);
			
			UUID uuid = UUID.randomUUID();
			
			uploadFileName = uuid.toString() + "_" + uploadFileName;
			
			try {
				File saveFile = new File(uploadPath, uploadFolderPath);
				uploadFile.transferTo(saveFile);
				
				attachDTO.setUuid(uuid.toString());
				attachDTO.setUploadPath(uploadFolderPath);
				
				// check image type file
				if (checkImageType(saveFile)) {
					attachDTO.setImage(true);
				
					FileOutputStream thumbnail = 
							new FileOutputStream(new File(uploadPath, "s_" + uploadFileName));
				
					Thumbnailator.createThumbnail(uploadFile.getInputStream(), thumbnail, 100, 100);
					
					thumbnail.close();
				}
				list.add(attachDTO);
				
			} catch (Exception e) {
				log.error("uploadAjaxPost Error : " + e.getMessage());
			}			
		}
		return new ResponseEntity<>(list, HttpStatus.OK);
	}
	
	
	// folder name 을 년/월/일 로 자동으로 생성하여 저장해줌
	private String getFolder() {
		
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		
		Date date = new Date();
		
		String str = sdf.format(date);
		
		return str.replace("-", File.separator);
	}
	
	// file 객체의 path 를 probe(조사)하여 contentType 의 시작부분이 image인지 출력
	private boolean checkImageType(File file) {
		
		try {
			String contentType = Files.probeContentType(file.toPath());
			
			return contentType.startsWith("image");
		} catch (IOException e) {
			e.printStackTrace();
		}
		
		return false;
	}
}
