package ${project.basePackage}.dto.business.${model.domain.name?uncap_first}.request;


import java.io.Serializable;
import java.util.Objects;
import ${project.basePackage}.dto.business.${model.domain.name?uncap_first}.${model.name?cap_first}DTO;

/**
 * ${model.displayName}ListRequestDTO
 * 列表${model.displayName} 请求DTO
 *
 * Created by Recloud
 */
public class ${model.name?cap_first}ListRequestDTO implements Serializable{

    /**
	 * 页码
	 *
	 */
    private Integer page;

    /**
	 * 条数
	 *
	 */
    private Integer limit;

    /**
	 * 请求参数
	 *
	 */
    private ${model.name?cap_first}DTO searchCondition;

    public Integer getPage() {
        return page;
    }

    public void setPage(Integer page) {
        this.page = page;
    }

    public Integer getLimit() {
        return limit;
    }

    public void setLimit(Integer limit) {
        this.limit = limit;
    }

    public ${model.name?cap_first}DTO getSearchCondition() {
        return searchCondition;
    }

    public void setSearchCondition(${model.name?cap_first}DTO searchCondition) {
        this.searchCondition = searchCondition;
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) {
            return true;
        }
        if (!(o instanceof ${model.name?cap_first}ListRequestDTO)) {
            return false;
        }
        ${model.name?cap_first}ListRequestDTO that = (${model.name?cap_first}ListRequestDTO) o;
        return Objects.equals(page, that.page) &&
            Objects.equals(limit, that.limit) &&
            Objects.equals(searchCondition, that.searchCondition);
    }

    @Override
    public int hashCode() {
        return Objects.hash(page, limit, searchCondition);
    }
}
