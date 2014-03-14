package image;


import javax.imageio.ImageIO; //ImageReader 및 ImageWriter 를 검색하는 정적인  메소드를 보관 유지해, 간단한  코드  복호화를 실행하는 클래스입니다. 
import java.awt.image.BufferedImage;
import java.awt.Graphics2D;

import java.io.File;
import java.io.InputStream;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;

public class ImageUtil {
    
    public static final int SAME = -1; //SAME 원본이미지의 크기를 갖는다.
    public static final int RATIO = 0; //폭의 크기에 변화 비율에 맞춰 높이의 크기를 변경한다.
    
    //src 는 원본이미지, dest 썸네일 이미지
    /*
     * 원본 이미지를 File로 전달받은 경우 InputStream 으로 변환하여  resize()메소드를 호출한다.
     * */
    public static void resize(File src, File dest, 
                              int width, int height) throws IOException {
        FileInputStream srcIs = null;
        try {
            srcIs = new FileInputStream(src);
            ImageUtil.resize(srcIs, dest, width, height);
        } finally {
            if (srcIs != null) try { srcIs.close(); } catch(IOException ex) {}
        }
    }

    public static void resize(InputStream src, File dest, int width, int height) throws IOException {
        BufferedImage srcImg = ImageIO.read(src);	//원본 이미지에 해당하는 BufferedImage 객체를 생성해서 srcImg 에 할당.
        int srcWidth = srcImg.getWidth();  //원본 이미지의 폭
        int srcHeight = srcImg.getHeight(); //원본 이미지의 높이
        
        int destWidth = -1, destHeight = -1;	//새로생성할 이미지의 폭과 높이 
        
        if (width == SAME) {
            destWidth = srcWidth;
        } else if (width > 0) {
            destWidth = width;
        }
        
        if (height == SAME) {
            destHeight = srcHeight;
        } else if (height > 0) {
            destHeight = height;
        }
        
        if (width == RATIO && height == RATIO) {
            destWidth = srcWidth;
            destHeight = srcHeight;
        } else if (width == RATIO) {
            double ratio = ((double)destHeight) / ((double)srcHeight);
            destWidth = (int)((double)srcWidth * ratio);
        } else if (height == RATIO) {
            double ratio = ((double)destWidth) / ((double)srcWidth);
            destHeight = (int)((double)srcHeight * ratio);
        }
        
        /*새로 생성할 이미지에 해당하는 BufferedImage 객체를 생성해서 destImg 에 할당한다.  
         * */
        BufferedImage destImg = new BufferedImage(
             destWidth, destHeight, BufferedImage.TYPE_3BYTE_BGR);
        Graphics2D g = destImg.createGraphics(); 
        g.drawImage(srcImg, 0, 0, destWidth, destHeight, null);
        
        ImageIO.write(destImg, "jpg", dest);	//새로생성한 이미지파일 저장
    }
}