package image;


import javax.imageio.ImageIO; //ImageReader �� ImageWriter �� �˻��ϴ� ������  �޼ҵ带 ���� ������, ������  �ڵ�  ��ȣȭ�� �����ϴ� Ŭ�����Դϴ�. 
import java.awt.image.BufferedImage;
import java.awt.Graphics2D;

import java.io.File;
import java.io.InputStream;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;

public class ImageUtil {
    
    public static final int SAME = -1; //SAME �����̹����� ũ�⸦ ���´�.
    public static final int RATIO = 0; //���� ũ�⿡ ��ȭ ������ ���� ������ ũ�⸦ �����Ѵ�.
    
    //src �� �����̹���, dest ����� �̹���
    /*
     * ���� �̹����� File�� ���޹��� ��� InputStream ���� ��ȯ�Ͽ�  resize()�޼ҵ带 ȣ���Ѵ�.
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
        BufferedImage srcImg = ImageIO.read(src);	//���� �̹����� �ش��ϴ� BufferedImage ��ü�� �����ؼ� srcImg �� �Ҵ�.
        int srcWidth = srcImg.getWidth();  //���� �̹����� ��
        int srcHeight = srcImg.getHeight(); //���� �̹����� ����
        
        int destWidth = -1, destHeight = -1;	//���λ����� �̹����� ���� ���� 
        
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
        
        /*���� ������ �̹����� �ش��ϴ� BufferedImage ��ü�� �����ؼ� destImg �� �Ҵ��Ѵ�.  
         * */
        BufferedImage destImg = new BufferedImage(
             destWidth, destHeight, BufferedImage.TYPE_3BYTE_BGR);
        Graphics2D g = destImg.createGraphics(); 
        g.drawImage(srcImg, 0, 0, destWidth, destHeight, null);
        
        ImageIO.write(destImg, "jpg", dest);	//���λ����� �̹������� ����
    }
}