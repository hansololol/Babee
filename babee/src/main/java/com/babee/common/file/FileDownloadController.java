package com.babee.common.file;

import java.io.File;
import java.io.FileInputStream;
import java.io.OutputStream;

import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import net.coobird.thumbnailator.Thumbnails;

@Controller
public class FileDownloadController {

	private static String CURR_IMAGE_REPO_PATH_GOODS = "C:/shopping/file_repo";
	private static String CURR_IMAGE_REPO_PATH_REVIEW = "C:/shopping/review";
	private static String CURR_IMAGE_REPO_PATH_DIARY = "C:/shopping/diary";

	
	@RequestMapping("/download.do")
	protected void download(@RequestParam("fileName") String fileName,
		                 	@RequestParam("goods_id") String goods_id,
			                 HttpServletResponse response) throws Exception {
		OutputStream out = response.getOutputStream();
		String filePath=CURR_IMAGE_REPO_PATH_GOODS+"\\"+goods_id+"\\"+fileName;
		File image=new File(filePath);

		response.setHeader("Cache-Control","no-cache");
		response.addHeader("Content-disposition", "attachment; fileName="+fileName);
		FileInputStream in=new FileInputStream(image); 
		byte[] buffer=new byte[1024*8];
		while(true){
			int count=in.read(buffer);
			if(count==-1)  
				break;
			out.write(buffer,0,count);
		}
		in.close();
		out.close();
	}
	
	
	@RequestMapping("/thumbnails.do")
	protected void thumbnails(@RequestParam("fileName") String fileName,
                            	@RequestParam("goods_id") String goods_id, @RequestParam(value="fileType", required=false) String fileType,
			                 HttpServletResponse response) throws Exception {
		OutputStream out = response.getOutputStream();
		String filePath;
		
		/*if(fileType !=null ? fileType.equals("review"):false) {
		filePath=CURR_IMAGE_REPO_PATH_REVIEW+"/"+goods_id+"/"+fileName;
		} else {
		filePath=CURR_IMAGE_REPO_PATH_GOODS+"/"+goods_id+"/"+fileName;
		}
		*/
		
		switch(fileType != null ? fileType:"null") {
			case "review" :
						filePath = CURR_IMAGE_REPO_PATH_REVIEW+"/"+goods_id+"/"+fileName;
						break;
			
			case "diary" :
						filePath = CURR_IMAGE_REPO_PATH_DIARY+"/"+goods_id+"/"+fileName;
						break;
			default :
				filePath=CURR_IMAGE_REPO_PATH_GOODS+"/"+goods_id+"/"+fileName;
				break;
		}
		
		File image=new File(filePath);
		if (image.exists()) { 	
			Thumbnails.of(image).size(200,200).outputFormat("jpg").toOutputStream(out);
		}
		byte[] buffer = new byte[1024 * 8];
		out.write(buffer);
		out.close();
	}
}
