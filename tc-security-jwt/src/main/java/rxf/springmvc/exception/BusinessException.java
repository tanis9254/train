/*
 * Copyright (C) 2017  , All Rights Reserved.
 */

package rxf.springmvc.exception;

import java.security.PrivilegedActionException;
import java.util.HashMap;

/**
 * @author
 * @Description 业务异常
 * @Date 2017-12-23 10:32
 * @Modified by:
 **/
public class BusinessException extends RuntimeException {

    /**
     * 数据权限不足
     */
    public static final Integer EXCEPTION_CODE_DATA_PERMISSION_DENY = 5000502;
    /**
     * 数据不存在
     */
    public static final Integer EXCEPTION_CODE_DATA_NOT_EXIST = 5000503;
    /**
     * 数据不合理
     */
    public static final Integer EXCEPTION_CODE_DATA_UNREASONABLE = 5000504;
    /**
     * 数据重复
     */
    public static final Integer EXCEPTION_CODE_DATA_REPEAT = 5000505;
    /**
     * 数据耦合
     */
    public static final Integer EXCEPTION_CODE_DATA_COUPLING = 5000506;
    /**
     * 数据库异常
     */
    public static final Integer EXCEPTION_CODE_DATABASE_THROW = 5000511;
    /**
     * 外部服务异常
     */
    public static final Integer EXCEPTION_CODE_ESI_THROW = 5000521;
    /**
     * 请求参数异常
     */
    public static final Integer EXCEPTION_CODE_PARAMETER_THROW = 5000531;


    public static final HashMap<Integer, String> MSG = new HashMap<Integer, String>() {{
        put(EXCEPTION_CODE_PARAMETER_THROW, "【参数异常】");
        put(EXCEPTION_CODE_DATA_PERMISSION_DENY, "【数据权限不足】");
        put(EXCEPTION_CODE_DATA_NOT_EXIST, "【数据不存在】");
        put(EXCEPTION_CODE_DATA_UNREASONABLE, "【数据不合理】");
        put(EXCEPTION_CODE_DATA_REPEAT, "【数据重复】");
        put(EXCEPTION_CODE_DATA_COUPLING, "【数据耦合】");
        put(EXCEPTION_CODE_DATABASE_THROW, "【数据库异常】");
        put(EXCEPTION_CODE_ESI_THROW,"【外部服务异常】");

    }};

    public static String msg(Integer exceptionCode) {
        return MSG.get(exceptionCode);
    }

    private Integer code;

    public Integer getCode() {
        return code;
    }

    public void setCode(Integer code) {
        this.code = code;
    }

    public BusinessException(Integer code, String message) {
        super(message);
        this.code = code;
    }

    /**
     * Constructs a new exception with {@code null} as its detail message.
     * The cause is not initialized, and may subsequently be initialized by a
     * call to {@link #initCause}.
     */
    public BusinessException() {
        super();
    }

    /**
     * Constructs a new exception with the specified detail message.  The
     * cause is not initialized, and may subsequently be initialized by
     * a call to {@link #initCause}.
     *
     * @param message the detail message. The detail message is saved for
     *                later retrieval by the {@link #getMessage()} method.
     */
    public BusinessException(String message) {
        super(message);
    }

    /**
     * Constructs a new exception with the specified detail message and
     * cause.  <p>Note that the detail message associated with
     * {@code cause} is <i>not</i> automatically incorporated in
     * this exception's detail message.
     *
     * @param message the detail message (which is saved for later retrieval
     *                by the {@link #getMessage()} method).
     * @param cause   the cause (which is saved for later retrieval by the
     *                {@link #getCause()} method).  (A <tt>null</tt> value is
     *                permitted, and indicates that the cause is nonexistent or
     *                unknown.)
     * @since 1.4
     */
    public BusinessException(String message, Throwable cause) {
        super(message, cause);
    }

    /**
     * Constructs a new exception with the specified cause and a detail
     * message of <tt>(cause==null ? null : cause.toString())</tt> (which
     * typically contains the class and detail message of <tt>cause</tt>).
     * This constructor is useful for exceptions that are little more than
     * wrappers for other throwables (for example, {@link
     * PrivilegedActionException}).
     *
     * @param cause the cause (which is saved for later retrieval by the
     *              {@link #getCause()} method).  (A <tt>null</tt> value is
     *              permitted, and indicates that the cause is nonexistent or
     *              unknown.)
     * @since 1.4
     */
    public BusinessException(Throwable cause) {
        super(cause);
    }
}
