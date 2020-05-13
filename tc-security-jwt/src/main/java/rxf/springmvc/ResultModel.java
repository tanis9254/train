package rxf.springmvc;

import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;

/**
 * 用来快速返回结果的model对象
 */

@ApiModel(value = "ResultModel", description = "用来快速返回结果的model对象")
public class ResultModel<T> {

    @ApiModelProperty(value = "每页显示条数")
    private Integer size;

    @ApiModelProperty(value = "当前页")
    private Integer current;

    @ApiModelProperty(value = "总页数")
    private Integer pages;

    @ApiModelProperty(value = "总条数")
    private Integer total;

    @ApiModelProperty(value = "是否成功返回")
    private Boolean success;

    @ApiModelProperty(value = "返回的状态码")
    private Integer code;

    @ApiModelProperty(value = "返回消息")
    private String msg;

    @ApiModelProperty(value = "返回标题")
    private String title;

    @ApiModelProperty(value = "返回数据实体")
    private T data;


    public ResultModel() {
    }

    public ResultModel(Boolean success, int size, int current, int pages, int total, String msg, T data) {
        this.success = success;
        this.size = size;
        this.current = current;
        this.pages = pages;
        this.total = total;
        this.msg = msg;
        this.data = data;
    }

    public Integer getSize() {
        return size;
    }

    public void setSize(Integer size) {
        this.size = size;
    }

    public Integer getCurrent() {
        return current;
    }

    public void setCurrent(Integer current) {
        this.current = current;
    }

    public Integer getPages() {
        return pages;
    }

    public void setPages(Integer pages) {
        this.pages = pages;
    }

    public Integer getTotal() {
        return total;
    }

    public void setTotal(Integer total) {
        this.total = total;
    }

    public Boolean getSuccess() {
        return success;
    }

    public void setSuccess(Boolean success) {
        this.success = success;
    }

    public Integer getCode() {
        return code;
    }

    public void setCode(Integer code) {
        this.code = code;
    }

    public String getMsg() {
        return msg;
    }

    public void setMsg(String msg) {
        this.msg = msg;
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public void setData(T data) {
        this.data = data;
    }

    public T getData() {
        return data;
    }

    public Boolean isSuccess() {
        return getSuccess();
    }

    public ResultModel(Boolean success, Integer code, String msg, String title, T data) {
        this.success = success;
        this.code = code;
        this.msg = msg;
        this.title = title;
        this.data = data;
    }

    /**
     * 成功返回结果集
     *
     * @param data
     * @return
     */
    public static ResultModel success(Object data) {
        return new ResultModel<>(RestConstant.HTTP_SUCCESS, RestConstant.DEFAULT_SUCCESS_CODE, RestConstant.DEFAULT_MSG, RestConstant.DEFAULT_TITLE, data);
    }

    public static ResultModel success(String msg) {
        return new ResultModel<>(RestConstant.HTTP_SUCCESS, RestConstant.DEFAULT_SUCCESS_CODE, msg, RestConstant.DEFAULT_TITLE, RestConstant.DEFAULT_DATA);
    }

    public static ResultModel success(String title, String msg, Object data) {
        return new ResultModel<>(RestConstant.HTTP_SUCCESS, RestConstant.DEFAULT_SUCCESS_CODE, msg, title, data);
    }

    public static ResultModel success(String msg, Object data) {
        return new ResultModel<>(RestConstant.HTTP_SUCCESS, RestConstant.DEFAULT_SUCCESS_CODE, msg, RestConstant.DEFAULT_TITLE, data);
    }

    /**
     * 失败返回结果集
     *
     * @param msg
     * @return
     */
    public static ResultModel failure(String msg) {
        return new ResultModel<>(RestConstant.HTTP_FAILURE, RestConstant.DEFAULT_FAILURE_CODE, msg, RestConstant.DEFAULT_TITLE, RestConstant.DEFAULT_DATA);
    }

    public static ResultModel failure(Object data) {
        return new ResultModel<>(RestConstant.HTTP_FAILURE, RestConstant.DEFAULT_FAILURE_CODE, RestConstant.DEFAULT_MSG, RestConstant.DEFAULT_TITLE, data);
    }

    public static ResultModel failure(String msg, Object data) {
        return new ResultModel<>(RestConstant.HTTP_FAILURE, RestConstant.DEFAULT_FAILURE_CODE, msg, RestConstant.DEFAULT_TITLE, data);
    }

    public static ResultModel failure(Integer code, String msg) {
        return new ResultModel<>(RestConstant.HTTP_FAILURE, code, msg, RestConstant.DEFAULT_TITLE, RestConstant.DEFAULT_DATA);
    }

    public static ResultModel failure() {
        return new ResultModel<>(RestConstant.HTTP_FAILURE, RestConstant.DEFAULT_FAILURE_CODE, RestConstant.MSG_FAILURE, RestConstant.DEFAULT_TITLE, RestConstant.DEFAULT_DATA);
    }


    /**
     * 查询数据成功返回结果集
     *
     * @param data
     * @return
     */
    public static ResultModel selectSuccess(Object data) {
        return new ResultModel<>(RestConstant.HTTP_SUCCESS, RestConstant.DEFAULT_SUCCESS_CODE, RestConstant.SELECT_MSG_SUCCESS, RestConstant.DEFAULT_TITLE, data);
    }

    /*public static ResultModel selectPaginationSuccess(Page pagination, Object data) {
        return new ResultModel<>(RestConstant.HTTP_SUCCESS, pagination.getSize(), pagination.getCurrent(), pagination.getPages(), pagination.getTotal(), RestConstant.SELECT_MSG_SUCCESS, data);
    }*/


    /**
     * 查询数据失败
     *
     * @return
     */
    public static ResultModel selectFailure() {
        return new ResultModel<>(RestConstant.HTTP_FAILURE, RestConstant.DEFAULT_FAILURE_CODE, RestConstant.SELECT_MSG_FAILURE, RestConstant.DEFAULT_TITLE, RestConstant.DEFAULT_DATA);
    }

    /**
     * 新增数据成功
     *
     * @return
     */
    public static ResultModel createSuccess() {
        return new ResultModel<>(RestConstant.HTTP_SUCCESS, RestConstant.DEFAULT_SUCCESS_CODE, RestConstant.CREATE_MSG_SUCCESS, RestConstant.DEFAULT_TITLE, RestConstant.DEFAULT_DATA);
    }

    public static ResultModel createSuccess(Object data) {
        return new ResultModel<>(RestConstant.HTTP_SUCCESS, RestConstant.DEFAULT_SUCCESS_CODE, RestConstant.CREATE_MSG_SUCCESS, RestConstant.DEFAULT_TITLE, data);
    }


    /**
     * 新增数据失败
     *
     * @return
     */
    public static ResultModel createFailure() {
        return new ResultModel<>(RestConstant.HTTP_FAILURE, RestConstant.DEFAULT_FAILURE_CODE, RestConstant.CREATE_MSG_FAILURE, RestConstant.DEFAULT_TITLE, RestConstant.DEFAULT_DATA);
    }

    /**
     * 更新数据成功返回结果集
     *
     * @return
     */
    public static ResultModel updateSuccess() {
        return new ResultModel<>(RestConstant.HTTP_SUCCESS, RestConstant.DEFAULT_SUCCESS_CODE, RestConstant.UPDATE_MSG_SUCCESS, RestConstant.DEFAULT_TITLE, RestConstant.DEFAULT_DATA);
    }

    public static ResultModel updateSuccess(Object data) {
        return new ResultModel<>(RestConstant.HTTP_SUCCESS, RestConstant.DEFAULT_SUCCESS_CODE, RestConstant.UPDATE_MSG_SUCCESS, RestConstant.DEFAULT_TITLE, data);
    }

    public static ResultModel updateSuccess(Object data, String title) {
        return new ResultModel<>(RestConstant.HTTP_SUCCESS, RestConstant.DEFAULT_SUCCESS_CODE, RestConstant.UPDATE_MSG_SUCCESS, title, data);
    }


    /**
     * 更新数据失败
     *
     * @return
     */
    public static ResultModel updateFailure() {
        return new ResultModel<>(RestConstant.HTTP_FAILURE, RestConstant.DEFAULT_FAILURE_CODE, RestConstant.UPDATE_MSG_FAILURE, RestConstant.DEFAULT_TITLE, RestConstant.DEFAULT_DATA);
    }

    public static ResultModel updateFailure(String msg) {
        return new ResultModel<>(RestConstant.HTTP_FAILURE, RestConstant.DEFAULT_FAILURE_CODE, msg, RestConstant.DEFAULT_TITLE, RestConstant.DEFAULT_DATA);
    }

    /**
     * 删除数据成功
     *
     * @return
     */
    public static ResultModel deleteSuccess() {
        return new ResultModel<>(RestConstant.HTTP_SUCCESS, RestConstant.DEFAULT_SUCCESS_CODE, RestConstant.DELETE_MSG_SUCCESS, RestConstant.DELETE_TITLE_SUCCESS, RestConstant.DEFAULT_DATA);
    }

    public static ResultModel deleteSuccess(Object data) {
        return new ResultModel<>(RestConstant.HTTP_SUCCESS, RestConstant.DEFAULT_SUCCESS_CODE, RestConstant.DELETE_MSG_SUCCESS, RestConstant.DELETE_TITLE_SUCCESS, data);
    }

    /**
     * 删除数据失败
     *
     * @return
     */
    public static ResultModel deleteFailure() {
        return new ResultModel<>(RestConstant.HTTP_FAILURE, RestConstant.DEFAULT_FAILURE_CODE, RestConstant.DELETE_MSG_FAILURE, RestConstant.DELETE_TITLE_FAILURE, RestConstant.DEFAULT_DATA);
    }

    public static ResultModel deleteFailure(String msg) {
        return new ResultModel<>(RestConstant.HTTP_FAILURE, RestConstant.DEFAULT_FAILURE_CODE, msg, RestConstant.DELETE_TITLE_FAILURE, RestConstant.DEFAULT_DATA);
    }

    public static ResultModel deleteFailure(String title, String msg) {
        return new ResultModel<>(RestConstant.HTTP_FAILURE, RestConstant.DEFAULT_FAILURE_CODE, msg, title, RestConstant.DEFAULT_DATA);
    }


    public Boolean hashListData() {
        return this.isSuccess() && (this.getTotal() != null && !"0".equals(this.getTitle()));
    }


}
