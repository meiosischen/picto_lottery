package com.picto.util;

import java.util.Collection;

/**
 * Created by wujigang on 2016/5/22.
 */
public class ListUtil {
    public static boolean isEmptyList(Collection c) {
        return null == c || c.size() <= 0;
    }
}
