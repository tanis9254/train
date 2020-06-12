package ${project.basePackage}.dto.business.${model.domain.name?uncap_first}.response;


import java.io.Serializable;
import java.util.Objects;
import ${project.basePackage}.dto.business.${model.domain.name?uncap_first}.${model.name?cap_first}DTO;

/**
 * ${model.displayName}UpdateResponseDTO
 * 更新${model.displayName} 响应DTO
 *
 * Created by Recloud
 */
public class ${model.name?cap_first}UpdateResponseDTO implements Serializable{

    /**
	 * 更新状态 是否成功
	 *
	 */
    private Boolean status;

    /**
	 * 更新 响应实体
	 *
	 */
    private ${model.name?cap_first}DTO ${model.name?uncap_first}DTO;

    public ${model.name?cap_first}UpdateResponseDTO() {
    }

    public ${model.name?cap_first}UpdateResponseDTO(Boolean status) {
        this.status = status;
    }

    public ${model.name?cap_first}UpdateResponseDTO(${model.name?cap_first}DTO ${model.name?uncap_first}DTO) {
        this.${model.name?uncap_first}DTO = ${model.name?uncap_first}DTO;
    }

    public ${model.name?cap_first}UpdateResponseDTO(Boolean status, ${model.name?cap_first}DTO ${model.name?uncap_first}DTO) {
        this.status = status;
        this.${model.name?uncap_first}DTO = ${model.name?uncap_first}DTO;
    }

    public Boolean getStatus() {
        return status;
    }

    public void setStatus(Boolean status) {
        this.status = status;
    }

    public ${model.name?cap_first}DTO get${model.name?cap_first}DTO() {
        return ${model.name?uncap_first}DTO;
    }

    public void set${model.name?cap_first}DTO(${model.name?cap_first}DTO ${model.name?uncap_first}DTO) {
        this.${model.name?uncap_first}DTO = ${model.name?uncap_first}DTO;
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) {
            return true;
        }
        if (!(o instanceof ${model.name?cap_first}UpdateResponseDTO)) {
            return false;
        }
        ${model.name?cap_first}UpdateResponseDTO that = (${model.name?cap_first}UpdateResponseDTO) o;
        return Objects.equals(${model.name?uncap_first}DTO, that.${model.name?uncap_first}DTO) &&
            Objects.equals(status, that.status);
    }

    @Override
    public int hashCode() {
        return Objects.hash(status, ${model.name?uncap_first}DTO);
    }

}
