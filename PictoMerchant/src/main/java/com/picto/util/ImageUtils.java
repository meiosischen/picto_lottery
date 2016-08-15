package com.picto.util;

import java.awt.Color;
import java.awt.Font;
import java.awt.Graphics2D;
import java.awt.RenderingHints;
import java.awt.image.BufferedImage;
import java.util.Random;

import javax.imageio.ImageIO;
import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.picto.constants.Constants;

public class ImageUtils {

    /**
     * 生成图形验证码
     * @return
     */
	public static String generateVerifyImage(HttpServletRequest req, HttpServletResponse resp) {
		/** 验证码图片的宽度 */
		int width = 80;
		/** 验证码图片的高度 */
		int height = 26;
		/** 验证码字符个数 */
		int codeCount = 4;
		// 字符间距
		int x = width / (codeCount + 2);
		// 字体高度
		int fontHeight = height - 2;
		;
		int codeY = height - 4;

		Font font = new Font("Comic Sans MS Italic", Font.PLAIN | Font.ITALIC, fontHeight);

		// 定义图像buffer
		BufferedImage buffImg = new BufferedImage(width, height, BufferedImage.TYPE_INT_RGB);
		Graphics2D g = buffImg.createGraphics();
		g.setRenderingHint(RenderingHints.KEY_ANTIALIASING, RenderingHints.VALUE_ANTIALIAS_ON);
		// 创建一个随机数生成器类
		Random random = new Random();

		// 将图像填充为白色
		g.setColor(Color.WHITE);
		g.fillRect(0, 0, width, height);

		// 设置字体。
		g.setFont(font);

		// 画边框。
		g.setColor(Color.BLACK);

		// randomCode用于保存随机产生的验证码，以便用户登录后进行验证。
		StringBuffer code = new StringBuffer();
		int red = 0, green = 0, blue = 0;
		int distance = 0;
		int dx = 0;
		
		
		// 随机产生codeCount数字的验证码。避免相邻颜色相近
		for (int i = 0; i < codeCount; i++) {
			int feed = 255;
			// 得到随机产生的验证码数字。
			String strRand = String.valueOf(alpha());
			// 产生随机的颜色分量来构造颜色值，这样输出的每位数字的颜色值都将不同。

			feed = red>200?255-red : 255;
			red = random.nextInt(feed);
			
			feed = red>200?255-green : 255;
			green = random.nextInt(feed);

			feed = red>200?255-blue : 255;
			blue = random.nextInt(feed);

			distance = random.nextInt(8);

			// 用随机产生的颜色将验证码绘制到图像中。
			g.setColor(new Color(red, green, blue));
			if (0 == i) {
				dx = (i + 1) * x - 6;
			} else {
				dx = (i + 1) * x - distance;
			}
			g.drawString(strRand, dx, codeY);

//			System.out.print(strRand + "[" + red + ":" + green + ":" + blue + "(" + distance +")],");
			// 将产生的四个随机数组合在一起。
			code.append(strRand);
		}
//		System.out.println("");
		// 将四位数字的验证码保存到Session中。
		HttpSession session = req.getSession();
		session.setAttribute(Constants.SESSION_VERICODE, code.toString());

		// 禁止图像缓存。
		resp.setHeader("Pragma", "no-cache");
		resp.setHeader("Cache-Control", "no-cache");
		resp.setDateHeader("Expires", 0);

		// 设置响应的类型格式为图片格式
		resp.setContentType("image/jpeg");

		// 将图像输出到Servlet输出流中。
		try {
			ServletOutputStream out = resp.getOutputStream();
			ImageIO.write(buffImg, "jpeg", out);
//			out.close();
		} catch (Exception e) {
			e.printStackTrace();
		}

		return code.toString();
	}
    
    private static final Random RANDOM = new Random();
    //定义验证码字符.去除了O和I等容易混淆的字母
    public static final char ALPHA[]={'A','B','C','D','E','F','G','H','G','K','M','N','P','Q','R','S','T','U','V','W','X','Y'
            ,'a','c','d','e','f','h','k','m','n','p','r','s','t','u','v','w','x','y','3','4','5','6','7','8'};

    /**
     * 产生两个数之间的随机数
     * @param min 小数
     * @param max 比min大的数
     * @return int 随机数字
     */
    public static int num(int min, int max)
    {
        return min + RANDOM.nextInt(max - min);
    }

    /**
     * 产生0--num的随机数,不包括num
     * @param num 数字
     * @return int 随机数字
     */
    public static int num(int num)
    {
        return RANDOM.nextInt(num);
    }

    public static char alpha()
    {
        return ALPHA[num(0, ALPHA.length)];
    }
    
    public static String rand(int length)
    {
    	char[] str = new char[length];
    	
    	for(int i=0; i<length; ++i)
    	{
    		str[i] = alpha();
    	}
    	
    	return new String(str);
    }
}
