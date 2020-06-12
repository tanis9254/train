package com.rsy.rxf.springmvc;

/**
 * 分页返回结果
 * Created by fai.yao on 16/10/25.
 */
public class PageResponse<T>  {

	/**
	 * 总条数
	 */
	private Integer total;

	/**
	 * 总页数
	 */
	private Integer totalPage;

	/**
	 * 数据集
	 */
	private T resultData;

	public T getResultData() {
		return resultData;
	}

	public void setResultData(T resultData) {
		this.resultData = resultData;
	}

	public Integer getTotal() {
		return total;
	}

	public void setTotal(Integer total) {
		this.total = total;
	}

	public Integer getTotalPage() {
		return totalPage;
	}

	public void setTotalPage(Integer totalPage) {
		this.totalPage = totalPage;
	}
}
