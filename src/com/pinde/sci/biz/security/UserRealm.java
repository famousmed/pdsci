package com.pinde.sci.biz.security;

import org.apache.shiro.authc.*;
import org.apache.shiro.authz.AuthorizationInfo;
import org.apache.shiro.authz.SimpleAuthorizationInfo;
import org.apache.shiro.realm.AuthorizingRealm;
import org.apache.shiro.subject.PrincipalCollection;
import org.apache.shiro.util.ByteSource;

import com.pinde.sci.model.mo.SysUser;


/**
 * <p>User: Zhang Kaitao
 * <p>Date: 14-1-28
 * <p>Version: 1.0
 */
public class UserRealm extends AuthorizingRealm {

    @Override
    protected AuthorizationInfo doGetAuthorizationInfo(PrincipalCollection principals) {
        String userCode = (String)principals.getPrimaryPrincipal();
        SimpleAuthorizationInfo authorizationInfo = new SimpleAuthorizationInfo();
        authorizationInfo.setRoles(null);
        authorizationInfo.setStringPermissions(null);

        return authorizationInfo;
    }

    @SuppressWarnings("unused")
	@Override
    protected AuthenticationInfo doGetAuthenticationInfo(AuthenticationToken token) throws AuthenticationException {

        String userCode = (String)token.getPrincipal();

        SysUser user = new SysUser();
        user.setUserCode("admin");
        user.setUserPasswd("928bfd2577490322a6e19b793691467e");

        if(user == null) {
            throw new UnknownAccountException();//û�ҵ��ʺ�
        }

//        if(Boolean.TRUE.equals(user.getRecordStatus())) {
//            throw new LockedAccountException(); //�ʺ�����
//        }

        //����AuthenticatingRealmʹ��CredentialsMatcher��������ƥ�䣬��������˼ҵĲ��ÿ����Զ���ʵ��
        SimpleAuthenticationInfo authenticationInfo = new SimpleAuthenticationInfo(
                user.getUserCode(), //�û���
                user.getUserPasswd(), //����
                ByteSource.Util.bytes(user.getUserCode()),//salt=username+salt
                getName()  //realm name
        );
        clearCache(authenticationInfo.getPrincipals());

        return authenticationInfo;
    }

    @Override
    public void clearCachedAuthorizationInfo(PrincipalCollection principals) {
        super.clearCachedAuthorizationInfo(principals);
    }

    @Override
    public void clearCachedAuthenticationInfo(PrincipalCollection principals) {
        super.clearCachedAuthenticationInfo(principals);
    }

    @Override
    public void clearCache(PrincipalCollection principals) {
        super.clearCache(principals);
    }

    public void clearAllCachedAuthorizationInfo() {
        getAuthorizationCache().clear();
    }

    public void clearAllCachedAuthenticationInfo() {
        getAuthenticationCache().clear();
    }

    public void clearAllCache() {
        clearAllCachedAuthenticationInfo();
        clearAllCachedAuthorizationInfo();
    }

}

