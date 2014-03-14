package image;


import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletRequestWrapper;

import org.apache.commons.fileupload.FileUpload;
import org.apache.commons.fileupload.DiskFileUpload;
import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.FileUploadException;

import java.util.Map;
import java.util.HashMap;
import java.util.Enumeration;
import java.util.Iterator;

/**
 * FileUpload API를 사용하는 HttpServletRequestWrapper 클래스로서
 * HttpServletRequest에 기반한 API를 사용하기 위한 래퍼이다.
 */
public class FileUploadRequestWrapper extends HttpServletRequestWrapper {
    
    private boolean multipart = false;
    
    //파라미터이름, 파라미터값 배열 의 쌍을 저장한다. 
    private HashMap parameterMap; //멀티파트가 true 인경우 parameterMap에 저정된값 리턴
    
    private HashMap fileItemMap;
    
    public FileUploadRequestWrapper(HttpServletRequest request) 
    throws FileUploadException{
        this(request, -1, -1, null);
    }
    
    public FileUploadRequestWrapper(HttpServletRequest request,
        int threshold, int max, String repositoryPath) throws FileUploadException {
        super(request);
        
        parsing(request, threshold, max, repositoryPath);
    }
    private void parsing //클라이언트 요청이 멀티파트 인지 검사하는 메소드,,멀티파트인경우 필드값을 true 로 변경한다.
    (HttpServletRequest request, int threshold, int max, String repositoryPath) throws FileUploadException {
        
        if (FileUpload.isMultipartContent(request)) {//웹 브라우저가 인코딩 타입(multipart/form-data)으로 전송했는지 판단
            multipart = true;
            
            parameterMap = new java.util.HashMap();
            fileItemMap = new java.util.HashMap();
            //DiskFileUpload 클래스를사용해서 웹브라우저가 전송한 파일을 디스크에 저장할수 있도록 지원
            DiskFileUpload diskFileUpload = new DiskFileUpload();//인코딩 타입일때 DiskFileUpload()객체생성
            if (threshold != -1) {
                diskFileUpload.setSizeThreshold(threshold); //setSizeThreshold()메모리에 저장할수 있는 최대 크기 (바이트단위)
            }
            diskFileUpload.setSizeMax(max);//setSizeMax() 최대로 업로드 할수있는 파일크기(바이트 단위)
            if (repositoryPath != null) {
                diskFileUpload.setRepositoryPath(repositoryPath);//setRepositoryPath()파일임시저장 디렉토리 지정
            }
            
            java.util.List list = diskFileUpload.parseRequest(request);//parseRequest()웹브라우저가 전송한 데이터 추출
            for (int i = 0 ; i < list.size() ; i++) {
                FileItem fileItem = (FileItem) list.get(i); //리턴한 fileItem목록을 사용하여 파일및 파라미터를 처리한다.
                String name = fileItem.getFieldName();//getFieldName() 파라미터의 이름을 구한다.
                
                if (fileItem.isFormField()) {//isFormField() 파일이 아닌 일반 적인 입력 파라미터일 경우 true 리턴
                    String value = fileItem.getString(); //기본 케릭터셋을 이용하여 파라미값을 구한다.
                    String[] values = (String[]) parameterMap.get(name); //업로드한 파일을 byte 배열로 구한다.
                    if (values == null) {
                        values = new String[] { value };
                    } else {
                        String[] tempValues = new String[values.length + 1];
                        System.arraycopy(values, 0, tempValues, 0, 1);
                        tempValues[tempValues.length - 1] = value;
                        values = tempValues;
                    }
                    parameterMap.put(name, values); //put()리소스 저장
                } else {
                    fileItemMap.put(name, fileItem);
                }
            }
            addTo(); // request 속성으로 설정한다.
        }
    }
    
    public boolean isMultipartContent() { //멀티파트 인코딩타입 판단
        return multipart;
    }
    
    public String getParameter(String name) { //멀티파트가 false 인경우 getParameter()메소드값 리턴
//    	FileUploadRequestWrapper크래스에서 오버라이딩해서 구현
        if (multipart) {
            String[] values = (String[])parameterMap.get(name);
            if (values == null) return null;
            return values[0];
        } else
            return super.getParameter(name);
    }
    
    public String[] getParameterValues(String name) {
        if (multipart)
            return (String[])parameterMap.get(name);
        else
            return super.getParameterValues(name);
    }
    
    public Enumeration getParameterNames() {  
        if (multipart) {
            return new Enumeration() {
                Iterator iter = parameterMap.keySet().iterator();
                
                public boolean hasMoreElements() {
                    return iter.hasNext();
                }
                public Object nextElement() {
                    return iter.next();
                }
            };
        } else {
            return super.getParameterNames();
        }
    }
    
    public Map getParameterMap() {//FileUploadRequestWrapper크래스에서 오버라이딩해서 구현
        if (multipart)
            return parameterMap;
        else
            return super.getParameterMap();
    }
    
    //지정한 파라미터 이름과 관련된 FileItem 을 리턴한다.
    public FileItem getFileItem(String name) {
        if (multipart)
            return (FileItem) fileItemMap.get(name);
        else
            return null;
    }
    
    
    //임시로 사용된 업로드 파일을 삭제한다.
    public void delete() {	
        if (multipart) {
            Iterator fileItemIter = fileItemMap.values().iterator();
            while( fileItemIter.hasNext()) {
                FileItem fileItem = (FileItem)fileItemIter.next();
                fileItem.delete();
            }
        }
    }
    
    //Wrapper 객체 자체를 request 속성에 저장
    public void addTo() { 
        super.setAttribute(FileUploadRequestWrapper.class.getName(), this);
    }
    
    //지정한 request 속성에 저장된 FileUploadRequestWrapper를 리턴한다. 존재하지 않는경우 null 리턴
    public static FileUploadRequestWrapper 
                  getFrom(HttpServletRequest request) {
        return (FileUploadRequestWrapper)
            request.getAttribute(FileUploadRequestWrapper.class.getName());
    }

    //  지정한 request 가 Wrapper를 속성으로 포함하고 있는 경우에 true 리턴
    public static boolean hasWrapper(HttpServletRequest request) { 
        if (FileUploadRequestWrapper.getFrom(request) == null) {
            return false;
        } else {
            return true;
        }
    }
}