package ${project.basePackage}.dto.business.${model.domain.name?uncap_first}.response;


import java.io.Serializable;
import java.util.Objects;
import java.util.List;
import ${project.basePackage}.dto.business.${model.domain.name?uncap_first}.${model.name?cap_first}DTO;

/**
 * ${model.displayName}ListResponseDTO
 * 列表${model.displayName} 响应DTO
 *
 * Created by Recloud
 */
public class ${model.name?cap_first}ListResponseDTO implements Serializable{

    /**
     * 总条数
     */
    private Integer total;

    /**
     * 总页数
     */
    private Integer totalPage;

    /**
	 * 响应实体
	 *
	 */
    private List<${model.name?cap_first}DTO> ${model.name?uncap_first}DTOList;

    public ${model.name?cap_first}ListResponseDTO() {
    }

    public ${model.name?cap_first}ListResponseDTO(List<${model.name?cap_first}DTO> ${model.name?uncap_first}DTOList) {
        this.${model.name?uncap_first}DTOList = ${model.name?uncap_first}DTOList;
    }

    public List<${model.name?cap_first}DTO> get${model.name?cap_first}DTOList() {
        return ${model.name?uncap_first}DTOList;
    }

    public void set${model.name?cap_first}DTOList(List<${model.name?cap_first}DTO> ${model.name?uncap_first}DTOList) {
        this.${model.name?uncap_first}DTOList = ${model.name?uncap_first}DTOList;
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

    @Override
    public boolean equals(Object o) {
        if (this == o) {
            return true;
        }
        if (!(o instanceof ${model.name?cap_first}ListResponseDTO)) {
            return false;
        }
        ${model.name?cap_first}ListResponseDTO that = (${model.name?cap_first}ListResponseDTO) o;
        return Objects.equals(total, that.total) &&
            Objects.equals(totalPage, that.totalPage) &&
            Objects.equals(${model.name?uncap_first}DTOList, that.${model.name?uncap_first}DTOList);
    }

    @Override
    public int hashCode() {
        return Objects.hash(total, totalPage, ${model.name?uncap_first}DTOList);
    }
}
