package com.pinde.sci.util;

import java.awt.Color;
import java.awt.Image;
import java.awt.image.BufferedImage;
import java.awt.Graphics2D;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;

import javax.swing.ImageIcon;

import com.sun.image.codec.jpeg.ImageFormatException;
import com.sun.image.codec.jpeg.JPEGCodec;
import com.sun.image.codec.jpeg.JPEGImageEncoder;

public class PicZoom {
	
   private static final int WIDTH = 100; //����ͼ���
   static final int HEIGHT = 100;//����ͼ�߶�	
    public static BufferedImage zoom(String srcFileName) {
        //ʹ��Դͼ���ļ�������ImageIcon����
        ImageIcon imgIcon = new ImageIcon(srcFileName);
        //�õ�Image����
        Image img = imgIcon.getImage();

        return zoom(img);
    }
    public static BufferedImage zoom(byte[] imageData) {
        //ʹ��Դͼ���ļ�������ImageIcon����
        ImageIcon imgIcon = new ImageIcon(imageData);
        //�õ�Image����
        Image img = imgIcon.getImage();

        return zoom(img);
    }
    
    public static BufferedImage zoom(Image srcImage) {
        //����һ��Ԥ�����ͼ�����͵�BufferedImage����
        BufferedImage buffImg = new BufferedImage(WIDTH, HEIGHT, BufferedImage.TYPE_INT_RGB);
//        buffImg.flush();                                        
        //����Graphics2D����������BufferedImage�����ϻ�ͼ��
        Graphics2D g = buffImg.createGraphics();
        
        //����ͼ�������ĵĵ�ǰ��ɫΪ��ɫ��
        g.setColor(Color.WHITE);
        //��ͼ�������ĵĵ�ǰ��ɫ���ָ���ľ�������
        g.fillRect(0, 0, WIDTH, HEIGHT);
        //�������ŵĴ�С��BufferedImage�����ϻ���ԭʼͼ��
        g.drawImage(srcImage, 0, 0, WIDTH, HEIGHT, null);
        //�ͷ�ͼ��������ʹ�õ�ϵͳ��Դ��
        g.dispose();
        //ˢ�´� Image ��������ʹ�õ����п��ع�����Դ.
        srcImage.flush();
        
        return buffImg;
    }
    public static void main(String[] args) throws ImageFormatException, IOException { 
    	  BufferedImage buffImg  = PicZoom.zoom("D:\\20151016140021.jpg");
    	 JPEGImageEncoder jpgEncoder = JPEGCodec.createJPEGEncoder(new FileOutputStream("D:\\thu.jpg"));  
         //����BufferedImage����JPEG�����������  
         jpgEncoder.encode(buffImg);  
	}
}