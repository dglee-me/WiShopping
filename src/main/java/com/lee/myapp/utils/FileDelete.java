package com.lee.myapp.utils;

import java.io.File;

import org.apache.tomcat.jni.OS;

public class FileDelete {
	
	public static boolean isWindows() {
        return OS.IS_WIN64;
    }
	
	public static void deleteFile(String fileName) {
		fileName = fileName.replace("/", "\\").replace("\\imgUpload", "C:\\Users\\dlald\\eclipse-workspace\\.metadata\\.plugins\\org.eclipse.wst.server.core\\tmp0\\wtpwebapps\\WiShopping\\resources\\imgUpload");
		
		File file = new File(fileName);
		
		if(file.exists()) {
			if(file.delete()) {
				System.out.println("This file delete success");
			}else {
				System.out.println("This file delete fail");
			}
		}else {
			System.out.println("This file is not exist");
		}
	}
	
}
