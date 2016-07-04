package com.picto.service.impl;

import java.security.NoSuchAlgorithmException;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import com.picto.dao.CouponTypeDao;
import com.picto.dao.DiscountProductDao;
import com.picto.entity.*;
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
}
