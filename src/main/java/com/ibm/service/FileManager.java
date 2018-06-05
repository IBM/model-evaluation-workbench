/*
 * Copyright 2017 IBM Corp. All Rights Reserved.
 *
 * Licensed under the Apache License, Version 2.0 (the "License"); you may not use this file except in compliance with
 * the License. You may obtain a copy of the License at
 *
 * http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software distributed under the License is distributed on
 * an "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied. See the License for the
 * specific language governing permissions and limitations under the License.
 */
package com.ibm.service;


import java.io.BufferedOutputStream;
import java.io.BufferedReader;
import java.io.File;
import java.io.FileOutputStream;
import java.io.FileReader;
import java.io.IOException;
import java.io.InputStream;
import java.util.ArrayList;
import java.util.List;

import org.springframework.web.multipart.MultipartFile;

import com.ibm.watson.developer_cloud.conversation.v1.ConversationService;

import au.com.bytecode.opencsv.CSVReader;



/**
 * Integration test for the {@link ConversationService}.
 */
public class FileManager {


  /**
   * save File.
   *
   * @throws IOException the IOException 
   */
  public static File saveFile(MultipartFile file,String rootPath) throws IOException {
  
	    File dir = new File(rootPath + File.separator + "uploadedfile");
	    if (!dir.exists()) {
	        dir.mkdirs();
	    }
	 
	    File serverFile = new File(dir.getAbsolutePath() + File.separator + file.getOriginalFilename());
	 
	    try {
	        try (InputStream is = file.getInputStream();
	                BufferedOutputStream stream = new BufferedOutputStream(new FileOutputStream(serverFile))) {
	            int i;
	            //write file to server
	            while ((i = is.read()) != -1) {
	                stream.write(i);
	            }
	            stream.flush();
	        }
	    } catch (IOException e) {
	    	e.printStackTrace();
	    	throw e;
	    }
	    //System.out.println(response);
	    return serverFile;
  }

  
  /**
   * parseCSVFile
   *
   * 
   */
  public static List<String> parseCSVFile(File serverFile)  {
	    List<String> messages = new ArrayList<String>(); 
	    String message; 
	    String[] nextLine;

	    try {
	        try (FileReader fileReader = new FileReader(serverFile);
	        	CSVReader reader = new CSVReader(fileReader, ';', '\'');) {
	            while ((nextLine = reader.readNext()) != null) {
	                System.out.println("content : ");
	                message = "";
	                for(int i=0;i<nextLine.length;i++){
	                    System.out.println(nextLine[i]);
	                    message +=   nextLine[i].toString();
	                }
	                messages.add(message);
                    System.out.println("message :: "+ message );
	            }
	        }
	    } catch (IOException e) {
	        System.out.println("error while reading csv : " + e.getMessage());
	    } 
		return messages;  
	}


  /**
   * parseJSONFile
   *
   * 
   */
  public static String parseJSONFile(File serverFile)  {
      StringBuilder result = new StringBuilder();
	  try {
        	BufferedReader br = new BufferedReader(new FileReader(serverFile));
            String line = br.readLine();
            while (line != null) {
            	result.append(line);
                line = br.readLine();
            }
        } catch(Exception e) {
            e.printStackTrace();
        }
        return result.toString();
    }  
  
	    
}
