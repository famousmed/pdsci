package com.pinde.sci.biz.security;

import org.apache.shiro.crypto.RandomNumberGenerator;
import org.apache.shiro.crypto.SecureRandomNumberGenerator;
import org.apache.shiro.crypto.hash.SimpleHash;
import org.apache.shiro.util.ByteSource;

/**
 * <p>
 * User: Zhang Kaitao
 * <p>
 * Date: 14-1-28
 * <p>
 * Version: 1.0
 */
public class PasswordHelper {

	private static String algorithmName = "md5";
	private static int hashIterations = 2;

	/**
	 * �������
	 * @param userFlow �û���ˮ��
	 * @param userPasswd �û���д������
	 * @return
	 */
	public static String encryptPassword(String userFlow, String userPasswd) {

		String newPassword = new SimpleHash(algorithmName, userPasswd,ByteSource.Util.bytes(userFlow), hashIterations).toHex();

		return newPassword;
	}
}
