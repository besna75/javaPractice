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
 * FileUpload API�� ����ϴ� HttpServletRequestWrapper Ŭ�����μ�
 * HttpServletRequest�� ����� API�� ����ϱ� ���� �����̴�.
 */
public class FileUploadRequestWrapper extends HttpServletRequestWrapper {
    
    private boolean multipart = false;
    
    //�Ķ�����̸�, �Ķ���Ͱ� �迭 �� ���� �����Ѵ�. 
    private HashMap parameterMap; //��Ƽ��Ʈ�� true �ΰ�� parameterMap�� �����Ȱ� ����
    
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
    private void parsing //Ŭ���̾�Ʈ ��û�� ��Ƽ��Ʈ ���� �˻��ϴ� �޼ҵ�,,��Ƽ��Ʈ�ΰ�� �ʵ尪�� true �� �����Ѵ�.
    (HttpServletRequest request, int threshold, int max, String repositoryPath) throws FileUploadException {
        
        if (FileUpload.isMultipartContent(request)) {//�� �������� ���ڵ� Ÿ��(multipart/form-data)���� �����ߴ��� �Ǵ�
            multipart = true;
            
            parameterMap = new java.util.HashMap();
            fileItemMap = new java.util.HashMap();
            //DiskFileUpload Ŭ����������ؼ� ���������� ������ ������ ��ũ�� �����Ҽ� �ֵ��� ����
            DiskFileUpload diskFileUpload = new DiskFileUpload();//���ڵ� Ÿ���϶� DiskFileUpload()��ü����
            if (threshold != -1) {
                diskFileUpload.setSizeThreshold(threshold); //setSizeThreshold()�޸𸮿� �����Ҽ� �ִ� �ִ� ũ�� (����Ʈ����)
            }
            diskFileUpload.setSizeMax(max);//setSizeMax() �ִ�� ���ε� �Ҽ��ִ� ����ũ��(����Ʈ ����)
            if (repositoryPath != null) {
                diskFileUpload.setRepositoryPath(repositoryPath);//setRepositoryPath()�����ӽ����� ���丮 ����
            }
            
            java.util.List list = diskFileUpload.parseRequest(request);//parseRequest()���������� ������ ������ ����
            for (int i = 0 ; i < list.size() ; i++) {
                FileItem fileItem = (FileItem) list.get(i); //������ fileItem����� ����Ͽ� ���Ϲ� �Ķ���͸� ó���Ѵ�.
                String name = fileItem.getFieldName();//getFieldName() �Ķ������ �̸��� ���Ѵ�.
                
                if (fileItem.isFormField()) {//isFormField() ������ �ƴ� �Ϲ� ���� �Է� �Ķ������ ��� true ����
                    String value = fileItem.getString(); //�⺻ �ɸ��ͼ��� �̿��Ͽ� �Ķ�̰��� ���Ѵ�.
                    String[] values = (String[]) parameterMap.get(name); //���ε��� ������ byte �迭�� ���Ѵ�.
                    if (values == null) {
                        values = new String[] { value };
                    } else {
                        String[] tempValues = new String[values.length + 1];
                        System.arraycopy(values, 0, tempValues, 0, 1);
                        tempValues[tempValues.length - 1] = value;
                        values = tempValues;
                    }
                    parameterMap.put(name, values); //put()���ҽ� ����
                } else {
                    fileItemMap.put(name, fileItem);
                }
            }
            addTo(); // request �Ӽ����� �����Ѵ�.
        }
    }
    
    public boolean isMultipartContent() { //��Ƽ��Ʈ ���ڵ�Ÿ�� �Ǵ�
        return multipart;
    }
    
    public String getParameter(String name) { //��Ƽ��Ʈ�� false �ΰ�� getParameter()�޼ҵ尪 ����
//    	FileUploadRequestWrapperũ�������� �������̵��ؼ� ����
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
    
    public Map getParameterMap() {//FileUploadRequestWrapperũ�������� �������̵��ؼ� ����
        if (multipart)
            return parameterMap;
        else
            return super.getParameterMap();
    }
    
    //������ �Ķ���� �̸��� ���õ� FileItem �� �����Ѵ�.
    public FileItem getFileItem(String name) {
        if (multipart)
            return (FileItem) fileItemMap.get(name);
        else
            return null;
    }
    
    
    //�ӽ÷� ���� ���ε� ������ �����Ѵ�.
    public void delete() {	
        if (multipart) {
            Iterator fileItemIter = fileItemMap.values().iterator();
            while( fileItemIter.hasNext()) {
                FileItem fileItem = (FileItem)fileItemIter.next();
                fileItem.delete();
            }
        }
    }
    
    //Wrapper ��ü ��ü�� request �Ӽ��� ����
    public void addTo() { 
        super.setAttribute(FileUploadRequestWrapper.class.getName(), this);
    }
    
    //������ request �Ӽ��� ����� FileUploadRequestWrapper�� �����Ѵ�. �������� �ʴ°�� null ����
    public static FileUploadRequestWrapper 
                  getFrom(HttpServletRequest request) {
        return (FileUploadRequestWrapper)
            request.getAttribute(FileUploadRequestWrapper.class.getName());
    }

    //  ������ request �� Wrapper�� �Ӽ����� �����ϰ� �ִ� ��쿡 true ����
    public static boolean hasWrapper(HttpServletRequest request) { 
        if (FileUploadRequestWrapper.getFrom(request) == null) {
            return false;
        } else {
            return true;
        }
    }
}