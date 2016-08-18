package com.picto.service.impl;

import java.io.File;
import java.io.UnsupportedEncodingException;
import java.security.NoSuchAlgorithmException;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import jxl.SheetSettings;
import jxl.Workbook;
import jxl.format.Alignment;
import jxl.format.Border;
import jxl.format.BorderLineStyle;
import jxl.format.UnderlineStyle;
import jxl.format.VerticalAlignment;
import jxl.write.Label;
import jxl.write.WritableCellFormat;
import jxl.write.WritableFont;
import jxl.write.WritableSheet;
import jxl.write.WritableWorkbook;

import com.picto.constants.Constants;
import com.picto.dao.CouponDao;
import com.picto.dao.CouponTypeDao;
import com.picto.dao.DiscountProductDao;
import com.picto.entity.*;
import com.picto.util.DateUtil;
import com.picto.util.SecurityUtil;

import org.apache.commons.lang.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.picto.dao.AccountDao;
import com.picto.dao.MerchantDao;
import com.picto.service.AccountService;

@Service
public class AccountServiceImpl implements AccountService {

	@Autowired
	private AccountDao accountDao;
	@Autowired
	private MerchantDao merchantDao;
	@Autowired
	private CouponTypeDao couponTypeDao;
	@Autowired
	private CouponDao couponDao;
	@Autowired
	private DiscountProductDao discountProductDao;

	@Transactional
	public void merchantRegister(HttpServletRequest request) {
		Account account = validateMerchantRegisterParam(request);
		// 先创建商户信息
		Merchant merchant = new Merchant();
		merchant.setMerchantName(account.getAccountName());
		merchant.setCreateTime(new Date());
		// TODO 商户默认状态
		merchant.setState(1);
		merchantDao.addMerchant(merchant);
		
		// 更新抽奖链接地址
		merchant.setLotteryLink("http://www.mr-prize.com/welcome.do?merchantId=" + merchant.getId());
		merchant.setMainAdvert("/images/advert_top.jpg");
		merchant.setBannerAdvert("/images/advert_bottom.jpg");
		merchant.setQueryAdvert("/images/advert_bottom.jpg");
		merchant.setSaveType(1);
		merchantDao.updateMerchant(merchant);
		
		// 再把商户ID保存到账户中，然后创建账户，同一事务出错回滚
		account.setMerchantId(merchant.getId());
		accountDao.addAccount(account);

		//生成默认的奖项和优惠产品
		createDefaultLotteryData(merchant);
	}

	/**
	 * 验证参数有效性
	 */
	private Account validateMerchantRegisterParam(HttpServletRequest request){
		// TODO 方法太长，后期拆开
		// TODO 异常捕捉未明确，暂时先抛运行时异常
		// TODO 验证码验证
		
		Account account = new Account();
		
		// 账户名
		String accountName = request.getParameter("accountName");
		if(StringUtils.isBlank(accountName))
			throw new RuntimeException("账户名为空");
		if(null != accountDao.queryAccountByAccountName(accountName))
			throw new RuntimeException("同名账户已存在");
		account.setAccountName(accountName);
		
		// 密码
		String accountPwd = request.getParameter("accountPwd");
		String confirmPwd = request.getParameter("confirmPwd");
		if(StringUtils.isBlank(accountPwd) || StringUtils.isBlank(confirmPwd))
			throw new RuntimeException("密码为空");
		if(!accountPwd.equals(confirmPwd))
			throw new RuntimeException("密码不一致");
		// TODO 密码可靠性验证（长度，复杂度）
		// TODO 密码存储方式（MD5或其他加密）
		try {
			account.setAccountPwd(SecurityUtil.getMD5Code(accountPwd));
		} catch (NoSuchAlgorithmException e) {
			throw new RuntimeException("md5加密失败");
		}

		// TODO 账户默认状态
		account.setState(1);
		
		// 创建时间|更新时间
		Date now = new Date();
		account.setCreateTime(now);
		return account;
	}

	/**
	 * 生成默认的奖项和优惠产品
	 * @param merchant
	 */
	private void createDefaultLotteryData(Merchant merchant) {
		Date current = new Date();
		int n = 3;
		//默认的奖项
		List<CouponType> couponTypes = new ArrayList<CouponType>(n);
		CouponType c1 = new CouponType();
		c1.setName("全单5折");
		c1.setIcon("/images/50off.png");
		c1.setTotalNum(2);
		c1.setRestNum(2);
		c1.setIsImmediate(true);
		c1.setResetInterval(1);
		couponTypes.add(c1);

		CouponType c2 = new CouponType();
		c2.setName("现金折扣");
		c2.setIcon("/images/cashDeduction.png");
		c2.setTotalNum(20);
		c2.setRestNum(220);
		c2.setIsImmediate(true);
		c2.setResetInterval(3);
		couponTypes.add(c2);


		CouponType c3 = new CouponType();
		c3.setName("新品赠送");
		c3.setIcon("/images/newProduct.png");
		c3.setTotalNum(20);
		c3.setRestNum(20);
		c3.setIsImmediate(false);
		c3.setResetInterval(3);
		couponTypes.add(c3);


		//默认的优惠产品
		List<DiscountProduct> discountProducts = new ArrayList<DiscountProduct>(n);
		DiscountProduct d1 = new DiscountProduct();
		d1.setName("全单5折");
		d1.setIcon("/images/50off.png");
		d1.setDiscount("全单5折");
		d1.setUseMsg("请凭小票兑换");
		d1.setLimitMsg("仅限当天使用,每次消费时限用一张电子优惠券,活动最终解释权归本店所有");
		d1.setValidity(2);
		discountProducts.add(d1);

		DiscountProduct d2 = new DiscountProduct();
		d2.setName("现金折扣");
		d2.setIcon("/images/cashDeduction.png");
		d2.setDiscount("立减10元");
		d2.setUseMsg("请凭小票兑换");
		d2.setLimitMsg("仅限当天使用,每次消费时限用一张电子优惠券,活动最终解释权归本店所有");
		d2.setValidity(48);
		discountProducts.add(d2);

		DiscountProduct d3 = new DiscountProduct();
		d3.setName("新品赠送");
		d3.setIcon("/images/newProduct.png");
		d3.setDiscount("立减15元");
		d3.setUseMsg("请下次消费时使用");
		d3.setLimitMsg("仅限当天使用,每次消费时限用一张电子优惠券,活动最终解释权归本店所有");
		d3.setValidity(48);
		discountProducts.add(d3);

		for (int i = 0; i < n; i++) {
			CouponType c = couponTypes.get(i);
			c.setMerchantId(merchant.getId());
			c.setVersion(1);
			c.setState(1);
			c.setCreateTime(current);
			couponTypeDao.addCouponType(c);

			DiscountProduct d = discountProducts.get(i);
			d.setMerchantId(merchant.getId());
			d.setIsShared(false);
			d.setIsSendout(false);
			d.setState(1);
			d.setCreateTime(current);
			discountProductDao.add(d);

			CouponTypeDiscountRel rel = new CouponTypeDiscountRel();
			rel.setCouponTypeId(c.getId());
			rel.setDiscountProductId(d.getId());
			discountProductDao.addCouponTypeDiscountRel(rel);
		}
	}

	@Transactional
	public void login(HttpServletRequest request) {
		checkValidCode(request);
		String accountName = request.getParameter("accountName");
		if(StringUtils.isBlank(accountName))
			throw new RuntimeException("用户名为空");
		String accountPwd = request.getParameter("accountPwd");
		if(StringUtils.isBlank(accountPwd))
			throw new RuntimeException("密码为空");
		try {
			accountPwd = SecurityUtil.getMD5Code(accountPwd);
		} catch (NoSuchAlgorithmException e) {
			throw new RuntimeException("md5加密失败");
		}
		// 更新
		Account account = accountDao.queryAccountByNamePwd(accountName, accountPwd);
		if(null == account){
			throw new RuntimeException("登录失败，用户名或密码错误");
		}
		Date now = new Date();
		account.setUpdateTime(now);
		account.setLastLoginTime(now);
		accountDao.updateAccount(account);
		request.getSession().setAttribute(Constants.SESSION_ACCOUNT, account);
	}

	@Transactional
	public void modifyPwd(HttpServletRequest request) {
		Account account = (Account) request.getSession().getAttribute(Constants.SESSION_ACCOUNT);
		if(null == account)
			throw new RuntimeException("尚未登录");
		checkValidCode(request);
		String accountPwd = request.getParameter("accountPwd");
		if(StringUtils.isBlank(accountPwd))
			throw new RuntimeException("原密码为空");
		String newPwd = request.getParameter("newPwd");
		if(StringUtils.isBlank(newPwd))
			throw new RuntimeException("新密码为空");
		String confirmPwd = request.getParameter("confirmPwd");
		if(StringUtils.isBlank(newPwd))
			throw new RuntimeException("新密码为空");
		if(!newPwd.equals(confirmPwd))
			throw new RuntimeException("两次密码不一致");
		
		try {
			accountPwd = SecurityUtil.getMD5Code(accountPwd);
			newPwd = SecurityUtil.getMD5Code(newPwd);
		} catch (NoSuchAlgorithmException e) {
			throw new RuntimeException("md5加密失败");
		}		
		// 判断密码是否正确
		account = accountDao.queryAccountByNamePwd(account.getAccountName(), accountPwd);
		if(null == account)
			throw new RuntimeException("原密码错误");
		
		account.setAccountPwd(newPwd);
		account.setUpdateTime(new Date());
		accountDao.updateAccount(account);
	}
	
	/**
	 * 判断验证码是否正确
	 * @param request
	 */
	private void checkValidCode(HttpServletRequest request) {
		// 会话中的code
		String sessionValidCode = (String) request.getSession().getAttribute(Constants.SESSION_VERICODE);
		// 传过来的code
		String validCode = request.getParameter("validCode");
		// 验证参数
		if(StringUtils.isBlank(validCode) || !validCode.equalsIgnoreCase(sessionValidCode))
			throw new RuntimeException("验证码错误");
	}

	public void couponStatistic(HttpServletRequest request) {
//		String path = "D:/DOCS/bill";
		String path = "/data/files";
		Account account = (Account) request.getSession().getAttribute(Constants.SESSION_ACCOUNT);
		Integer merchantId = account.getMerchantId();
		if(null == merchantId || 0 == merchantId.intValue())
			throw new RuntimeException("商户ID为空");
		
		Date current = new Date();
        Date currMonthFirstTime = DateUtil.getMonthFirstTime(current, -1);
        Date currMonthEndTime = DateUtil.getMonthLastTime(current, -1);
        
        String[] title = new String[]{"序号", "优惠产品名称", "优惠码", "是否外发优惠", "派发时间", "兑换时间"};
    	Merchant merchant = merchantDao.queryMerchantById(merchantId);
		List<String[]> result = new ArrayList<String[]>();
		result.add(title);
		File file = new File(path + File.separator + merchant.getMerchantName() + DateUtil.formatDate(currMonthFirstTime, "yyyyMM") + ".xls");
		List<DiscountProduct> products = discountProductDao.queryDiscountByMerchantId(merchant.getId());
		int i = 0;
		for(DiscountProduct product: products){
    		List<Coupon> coupons = couponDao.queryExchangedCouponsByDiscountProductIdAndTime(merchant.getId(), product.getId(), null, currMonthFirstTime, currMonthEndTime);
    		for(Coupon coupon : coupons){
    			String[] cp = new String[6];
	    		cp[0] = "" + i++;
	    		cp[1] = coupon.getName();
	    		cp[2] = coupon.getSerialNumber();
    			cp[3] = null != product.getIsSendout() && product.getIsSendout() ?"是":"否";
    			if(null != coupon.getCreateTime())
    			cp[4] = DateUtil.formatDate(coupon.getCreateTime(), "yyyyMMdd HH:mm:ss");
    			
    			if(null != coupon.getState() && Constants.COUPON_STATE_EXCHANGED == coupon.getState().intValue() && null != coupon.getCreateTime())
    				cp[5] = DateUtil.formatDate(coupon.getUpdateTime(), "yyyyMMdd HH:mm:ss");
    			
    			result.add(cp);
    		}
    		try {
				buildExcel(file, result);
			} catch (Exception e) {
				e.printStackTrace();
			}

    	}
		
	}
	

	/**
	 * 写Excel
	 * @param file
	 * @param result
	 * @throws Exception
	 */
	private void buildExcel(File file, List<String[]> result) throws Exception{
		WritableWorkbook wwb = Workbook.createWorkbook(file);
		try {
			WritableSheet sheet = wwb.createSheet("账户统计", 0);
			// 写表头
			SheetSettings setting = sheet.getSettings();
			// 冻结表头
			setting.setVerticalFreeze(1);
			WritableCellFormat wcf = new WritableCellFormat();
			// 设置边框;
			wcf.setBorder(Border.ALL, BorderLineStyle.THIN);
			// 设置文字居中对齐方式;
			wcf.setAlignment(Alignment.CENTRE);
			// 设置垂直居中;
			wcf.setVerticalAlignment(VerticalAlignment.CENTRE);
			WritableFont font = new WritableFont(WritableFont.createFont("宋体"), 10, WritableFont.BOLD, false, UnderlineStyle.NO_UNDERLINE);
			wcf.setFont(font);
			
			String[] titles = result.get(0);
			for(int i = 0; i < titles.length; i++){
				sheet.setColumnView(i, 30);
				sheet.addCell(new Label(i, 0, titles[i], wcf));
			}
			// 设置行高
			sheet.setRowView(0, 350, false);
			for (int i = 1; i < result.size(); i++) {
				String[] contents = result.get(i);
				for(int j = 0; j < contents.length; j++){
					sheet.addCell(new Label(j, i, contents[j]));
				}
			}
			
			wwb.write();
		} catch (Exception e) {
			throw e;
		} finally {
			wwb.close();
		}
		
	}
}
