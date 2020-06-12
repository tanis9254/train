/*
 * Copyright (C) 2017  , All Rights Reserved.
 */

package com.rsy.rxf.springmvc.exception;

import java.security.PrivilegedActionException;

/**
 * @author
 * @Description 业务异常:数据库异常
 * @Date 2017-12-23 10:32
 * @Modified by:
 **/
public class BusinessEsiException extends BusinessException {
    /**
     * 外部服务异常
     */
    public static final Integer EXCEPTION_CODE_ESI_THROW = 5000521;

    /**
     * 外部服务异常
     */
    private static final String EXCEPTION_MSG_ESI_THROW = "【外部服务异常】";

    public Integer getCode() {
        return EXCEPTION_CODE_ESI_THROW;
    }

    /**
     * Constructs a new exception with {@code null} as its detail message.
     * The cause is not initialized, and may subsequently be initialized by a
     * call to {@link #initCause}.
     */
    public BusinessEsiException() {
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
    public BusinessEsiException(String message) {
        super(EXCEPTION_MSG_ESI_THROW + message);
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
    public BusinessEsiException(String message, Throwable cause) {
        super(EXCEPTION_MSG_ESI_THROW + message, cause);
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
    public BusinessEsiException(Throwable cause) {
        super(cause);
    }

    public BusinessEsiException(Integer code, String message) {
        super(code, message);
    }
}
