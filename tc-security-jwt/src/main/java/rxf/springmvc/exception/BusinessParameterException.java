/*
 * Copyright (C) 2017  , All Rights Reserved.
 */

package rxf.springmvc.exception;

import java.security.PrivilegedActionException;

/**
 * @author
 * @Description 业务异常:请求参数异常
 * @Date 2017-12-23 10:32
 * @Modified by:
 **/
public class BusinessParameterException extends BusinessException {

    /**
     * 请求参数异常
     */
    public static final Integer EXCEPTION_CODE_PARAMETER_THROW = 5000531;

    /**
     * 请求参数异常
     */
    private static final String EXCEPTION_MSG_PARAMETER_THROW = "【参数异常】";

    private Integer code = EXCEPTION_CODE_PARAMETER_THROW;

    public Integer getCode() {
        return code;
    }

    /**
     * Constructs a new exception with {@code null} as its detail message.
     * The cause is not initialized, and may subsequently be initialized by a
     * call to {@link #initCause}.
     */
    public BusinessParameterException() {
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
    public BusinessParameterException(String message) {
        super(EXCEPTION_MSG_PARAMETER_THROW + message);
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
    public BusinessParameterException(String message, Throwable cause) {
        super(EXCEPTION_MSG_PARAMETER_THROW + message, cause);
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
    public BusinessParameterException(Throwable cause) {
        super(cause);
    }

    public BusinessParameterException(Integer code, String message) {
        super(code, message);
    }
}
