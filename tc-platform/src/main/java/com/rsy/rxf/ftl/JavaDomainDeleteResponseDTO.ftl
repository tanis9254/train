package ${project.basePackage}.dto.business.${model.domain.name?uncap_first}.response;


import java.io.Serializable;
import java.util.Objects;
import java.util.List;

/**
 * ${model.displayName}DeleteResponseDTO
 * 删除${model.displayName} 响应DTO
 *
 * Created by Recloud
 */
public class ${model.name?cap_first}DeleteResponseDTO implements Serializable{

    /**
	 * 删除状态 是否成功
	 *
	 */
    private Boolean status;

    /**
	 * idList 导致删除失败的idList
	 *
	 */
    private List<String> idList;

    public Boolean getStatus() {
        return status;
    }

    public void setStatus(Boolean status) {
        this.status = status;
    }

    public List<String> getIdList() {
        return idList;
    }

    public void setIdList(List<String> idList) {
        this.idList = idList;
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) {
            return true;
        }
        if (!(o instanceof ${model.name?cap_first}DeleteResponseDTO)) {
            return false;
        }
        ${model.name?cap_first}DeleteResponseDTO that = (${model.name?cap_first}DeleteResponseDTO) o;
        return Objects.equals(status, that.status) &&
            Objects.equals(idList, that.idList);
    }

    @Override
    public int hashCode() {
        return Objects.hash(status, idList);
    }

}
