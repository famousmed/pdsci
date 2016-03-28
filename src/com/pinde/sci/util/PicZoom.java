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
	
   private static final int WIDTH = 100; //缩略图宽度
   static final int HEIGHT = 100;//缩略图高度	
    public static BufferedImage zoom(String srcFileName) {
        //使用源图像文件名创建ImageIcon对象。
        ImageIcon imgIcon = new ImageIcon(srcFileName);
        //得到Image对象。
        Image img = imgIcon.getImage();

        return zoom(img);
    }
    public static BufferedImage zoom(byte[] imageData) {
        //使用源图像文件名创建ImageIcon对象。
        ImageIcon imgIcon = new ImageIcon(imageData);
        //得到Image对象。
        Image img = imgIcon.getImage();

        return zoom(img);
    }
    
    public static BufferedImage zoom(Image srcImage) {
        //构造一个预定义的图像类型的BufferedImage对象。
        BufferedImage buffImg = new BufferedImage(WIDTH, HEIGHT, BufferedImage.TYPE_INT_RGB);
//        buffImg.flush();                                        
        //创建Graphics2D对象，用于在BufferedImage对象上绘图。
        Graphics2D g = buffImg.createGraphics();
        
        //设置图形上下文的当前颜色为白色。
        g.setColor(Color.WHITE);
        //用图形上下文的当前颜色填充指定的矩形区域。
        g.fillRect(0, 0, WIDTH, HEIGHT);
        //按照缩放的大小在BufferedImage对象上绘制原始图像。
        g.drawImage(srcImage, 0, 0, WIDTH, HEIGHT, null);
        //释放图形上下文使用的系统资源。
        g.dispose();
        //刷新此 Image 对象正在使用的所有可重构的资源.
        srcImage.flush();
        
        return buffImg;
    }
    public static void main(String[] args) throws ImageFormatException, IOException { 
    	  BufferedImage buffImg  = PicZoom.zoom("D:\\20151016140021.jpg");
    	 JPEGImageEncoder jpgEncoder = JPEGCodec.createJPEGEncoder(new FileOutputStream("D:\\thu.jpg"));  
         //编码BufferedImage对象到JPEG数据输出流。  
         jpgEncoder.encode(buffImg);  
	}
}