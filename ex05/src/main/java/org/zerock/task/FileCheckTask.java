package org.zerock.task;

import java.io.File;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.List;
import java.util.stream.Collectors;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Component;
import org.zerock.domain.BoardAttachVO;
import org.zerock.mapper.BoardAttachMapper;

import lombok.Setter;
import lombok.extern.log4j.Log4j;

@Log4j
@Component
public class FileCheckTask {

	@Setter(onMethod_ = { @Autowired })
	private BoardAttachMapper attachMapper;
	
	private String getFolderYesterDay() {
		
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		
		Calendar cal = Calendar.getInstance();
		
		cal.add(Calendar.DATE, -1);
		
		String str = sdf.format(cal.getTime());
		
		return str.replace("-", File.separator);
	}
	
	// Unix 계열에서 사용된 스케줄러 프로그램 이름
	@Scheduled(cron="0 " // seconds(0 ~ 59)
			+ "0 " // minutes(0 ~ 59)
			+ "2 " // hours(0 ~ 59)
			+ "* " // day(1 ~ 31)
			+ "* " // seconds(1 ~ 12)
			+ "*") // seconds(1 ~ 7)
	public void checkFiles() throws Exception {
		
		log.warn("File Check Task Run......................................");
		log.warn(new Date());
		
		// file list in database
		List<BoardAttachVO> fileList = attachMapper.getOldFiles();
		
		// ready for check file in directoy with database file list
		List<Path> fileListPaths = fileList.stream()
				.map(vo -> Paths.get("D:\\folderForPractice", 
									vo.getUploadPath(),
									vo.getUuid() + "_" + vo.getFileName()))
					.collect(Collectors.toList());
		
		// image file has thumnail file
		fileList.stream().filter(vo -> vo.isFileType() == true)
			.map(vo -> Paths.get("D:\\folderForPractice", 
								vo.getUploadPath(),
								"s_" + vo.getUuid() + "_" + vo.getFileName()))
				.forEach(p -> fileListPaths.add(p));
		
		log.warn("===========================================================");
		
		fileListPaths.forEach(p -> log.warn(p));
		
		// files in yesterday directory
		File targetDir = Paths.get("D:\\folderForPractice", getFolderYesterDay())
								.toFile();
		
		File[] removeFiles = targetDir.listFiles(
				file -> fileListPaths.contains(file.toPath()) == false);
		
		log.warn("============================================================");
		for (File file : removeFiles) log.warn(file.getAbsolutePath());
	}
}
