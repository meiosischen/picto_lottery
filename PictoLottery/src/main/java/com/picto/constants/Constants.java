package com.picto.constants;

/**
 * Created by wujigang on 2016/5/22.
 */
public interface Constants {
	int OPERATION_TYPE_LOTTERY = 1;// 抽奖
	int OPERATION_TYPE_EXCHANGED = 2;// 兑换

	/* *
	 * daily lottery limitation 1: 1 time/day 2: 2 times/day n: n times/day
	 */
	int OPERATION_LOTTERY_LIMIT = 2;

	String ENV_DEV = "test";// 测试环境
	String ENV_PROD = "prod";// 生产环境

	int COUPON_STATE_EFFECTED = 1;
	int COUPON_STATE_EXCHANGED = 2;

	/* *
	 * 1. do lottery with total number 2. do lottery with rest number Default: 1
	 */
	int LOTTERY_ALGO = 2;

	String CHARSET = "UTF-8";

	String testOpenid = "TEST555511118888";

}
