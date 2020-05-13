package com.tangxi.security.constant;


/**
 * 账号相关的静态常量
 * @author fei.yao
 * @date 2018/7/21
 */
public class AccountAdminConstant {

    public static final String currentAccountTokenKey = "CURRENT_LOGIN_ACCOUNT:JWT_TOKEN:";

    /**
     * 当前账号的资源树列表缓存KEY
     */
    public static final String currentAccountResourceListKey = "CURRENT_LOGIN_ACCOUNT:RESOURCE_LIST:";

    /**
     * 当前账号的角色列表缓存KEY
     */
    public static final String currentAccountRoleIdListKey = "CURRENT_LOGIN_ACCOUNT:ROLE_ID_LIST:";


    /**
     * 当前账号的机构树列表缓存KEY
     */
    public static final String currentAccountOrgIdListKey = "CURRENT_LOGIN_ACCOUNT:ORG_ID_LIST:";

    /**
     * 当前账号的机构树列表缓存KEY
     */
    public static final String currentAccountOrgListKey = "CURRENT_LOGIN_ACCOUNT:ORG_LIST:";

    /**
     * 当前账号的机构树列表缓存KEY
     */
    public static final String currentAccountAreaKey = "CURRENT_LOGIN_ACCOUNT:AREA:";

    /**
     * 当前账号的组织板块列表缓存key
     */
    public static final String currentAccountPlateKey = "CURRENT_LOGIN_ACCOUNT:PLATE_LIST:";


    /**
     * 当前账号的最叶子节点机构树列表缓存KEY
     */
    public static final String currentAccountChildrenOrgIdListKey = "CURRENT_LOGIN_ACCOUNT:CHILDREN_ORG_ID_LIST:";

    /**
     * 当前账号的机构树下挂角色列表缓存KEY
     */
//    public static final String currentAccountOrgListRoleListKey = "CURRENT_LOGIN_ACCOUNT:ORG_LIST:ROLE_LIST:";

    /**
     * 当前账号的机构树下挂角色分配账号列表缓存KEY
     */
//    public static final String currentAccountOrgListAccountListKey = "CURRENT_LOGIN_ACCOUNT:ORG_LIST:ACCOUNT_LIST:";

    /**
     * 当前账号的医院列表缓存KEY
     */
    public static final String currentAccountHospitalListKey = "CURRENT_LOGIN_ACCOUNT:HOSPITAL_LIST:";

    /**
     * 当前账号的医生缓存KEY
     */
    public static final String currentAccountDoctorKey = "CURRENT_LOGIN_ACCOUNT:DOCTOR:";

    /**
     * 当前账号的角色缓存KEY
     */
    public static final String currentAccountRoleIdKey = "CURRENT_LOGIN_ACCOUNT:ROLE_ID:";

    /**
     * 当前账号的机构缓存KEY
     */
    public static final String currentAccountOrgIdKey = "CURRENT_LOGIN_ACCOUNT:ORG_ID:";

    /**
     * 当前账号的机构的父机机构缓存KEY
     */
    public static final String currentAccountOrgParentIdKey = "CURRENT_LOGIN_ACCOUNT_ORG:PARENT_ID:";

    /**
     * 超级管理员
     */
    public static final Integer ACCOUNT_MRG_TYPE_SUPER_ADMIN = 1;

    /**
     * 二级管理员
     */
    public static final Integer ACCOUNT_MRG_TYPE_SECOND_ADMIN = 2;

    /**
     * 业务员
     */
    public static final Integer ACCOUNT_MRG_TYPE_BUSINESS_ADMIN = 0;


    /**
     * 未知管理员
     */
    public static final Integer ACCOUNT_MRG_TYPE_UNKNOW_ADMIN = -1;

    public static final String ACCOUNT_SOURCE_CODE_PHARMACIST = "PHARMACIST";

    public static final String ACCOUNT_SOURCE_CODE_DOCTOR = "DOCTOR";

    public static final String ACCOUNT_SOURCE_CODE_PLATFORM = "PLATFORM";
}
