package rxf.springmvc;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.dao.DuplicateKeyException;
import org.springframework.http.HttpStatus;
import org.springframework.http.converter.HttpMessageNotReadableException;
import org.springframework.validation.ObjectError;
import org.springframework.web.bind.MethodArgumentNotValidException;
import org.springframework.web.bind.annotation.ControllerAdvice;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.ResponseStatus;
import rxf.springmvc.exception.*;

import java.util.List;

/**
 * 集中处理RestAPI的异常
 */
@ControllerAdvice
public class RestApiExceptionHandler {

    private static final Logger LOGGER = LoggerFactory.getLogger(RestApiExceptionHandler.class);

    @ExceptionHandler(MethodArgumentNotValidException.class)
    @ResponseStatus(value = HttpStatus.BAD_REQUEST)
    @ResponseBody
    public ErrorResponse handleInvalidRequestError(MethodArgumentNotValidException ex) {

        LOGGER.error("", ex);

        List<ObjectError> errorList = ex.getBindingResult().getAllErrors();


        String message = "";
        if (errorList.size() > 0) {
            for (ObjectError error : errorList) {
                message += ";" + error.getDefaultMessage();
            }
        }
        message = message.replaceFirst(";", "");
        return new ErrorResponse("001", message);
    }

    @ExceptionHandler(HttpMessageNotReadableException.class)
    @ResponseBody
    public ResultModel handleHttpMessageNotReadableException(HttpMessageNotReadableException ex) {
        LOGGER.error("", ex);
        return ResultModel.failure(BusinessException.EXCEPTION_CODE_PARAMETER_THROW, BusinessException.msg(BusinessException.EXCEPTION_CODE_PARAMETER_THROW) + "输入的请求参数有误,请核实后重新输入");
    }

    @ExceptionHandler(BusinessException.class)
    @ResponseBody
    public ResultModel handleBusinessException(BusinessException be) {
        LOGGER.error(be.getMessage(), be);
        return ResultModel.failure(be.getCode(), be.getMessage());
    }

    @ExceptionHandler(BusinessDataCouplingException.class)
    @ResponseBody
    public ResultModel handleBusinessException(BusinessDataCouplingException be) {
        LOGGER.error(be.getMessage(), be);
        return ResultModel.failure(be.getCode(), be.getMessage());
    }

    @ExceptionHandler(BusinessDataNotExistException.class)
    @ResponseBody
    public ResultModel handleBusinessException(BusinessDataNotExistException be) {
        LOGGER.error(be.getMessage(), be);
        return ResultModel.failure(be.getCode(), be.getMessage());
    }

    @ExceptionHandler(BusinessDataRepeatException.class)
    @ResponseBody
    public ResultModel handleBusinessException(BusinessDataRepeatException be) {
        LOGGER.error(be.getMessage(), be);
        return ResultModel.failure(be.getCode(), be.getMessage());
    }

    @ExceptionHandler(BusinessDataUnreasonableException.class)
    @ResponseBody
    public ResultModel handleBusinessException(BusinessDataUnreasonableException be) {
        LOGGER.error(be.getMessage(), be);
        return ResultModel.failure(be.getCode(), be.getMessage());
    }

    @ExceptionHandler(BusinessDbException.class)
    @ResponseBody
    public ResultModel handleBusinessException(BusinessDbException be) {
        LOGGER.error(be.getMessage(), be);
        return ResultModel.failure(be.getCode(), be.getMessage());
    }

    @ExceptionHandler(BusinessEsiException.class)
    @ResponseBody
    public ResultModel handleBusinessException(BusinessEsiException be) {
        LOGGER.error(be.getMessage(), be);
        return ResultModel.failure(be.getCode(), be.getMessage());
    }

    @ExceptionHandler(BusinessParameterException.class)
    @ResponseBody
    public ResultModel handleBusinessException(BusinessParameterException be) {
        LOGGER.error(be.getMessage(), be);
        return ResultModel.failure(be.getCode(), be.getMessage());
    }

    @ExceptionHandler(BusinessPermissionDenyException.class)
    @ResponseBody
    public ResultModel handleBusinessException(BusinessPermissionDenyException be) {
        LOGGER.error(be.getMessage(), be);
        return ResultModel.failure(be.getCode(), be.getMessage());
    }

    @ExceptionHandler(Exception.class)
    @ResponseBody
    public ResultModel handleException(Exception e) {
        LOGGER.error(RestConstant.MSG_FAILURE, e);
        return ResultModel.failure();
    }

    @ExceptionHandler(DuplicateKeyException.class)
    @ResponseBody
    public ResultModel handleDuplicateKeyException(DuplicateKeyException e) {
        LOGGER.error(RestConstant.MSG_FAILURE, e);
        return ResultModel.failure(BusinessException.EXCEPTION_CODE_DATA_REPEAT, BusinessException.msg(BusinessException.EXCEPTION_CODE_DATA_REPEAT) + "不可重复插入数据，请确认属性唯一！");
    }


    @ExceptionHandler(RuntimeException.class)
    @ResponseBody
    public ResultModel handleUnexpectedServerError(RuntimeException re) {
        LOGGER.error(RestConstant.MSG_FAILURE, re);
        return ResultModel.failure();
    }

}
