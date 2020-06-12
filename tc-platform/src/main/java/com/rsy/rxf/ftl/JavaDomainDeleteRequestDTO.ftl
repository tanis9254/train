package ${project.basePackage}.dto.business.${model.domain.name?uncap_first}.request;


import java.io.Serializable;
import java.util.Objects;

/**
 * ${model.displayName}DeleteRequestDTO
 * 删除${model.displayName} 请求DTO
 *
 * Created by Recloud
 */
public class ${model.name?cap_first}DeleteRequestDTO implements Serializable{

    /**
	 * 删除请求id串
	 * 多个用","分隔
	 *
	 */
    private String idArrayStr;

    public String getIdArrayStr() {
        return idArrayStr;
    }

    public void setIdArrayStr(String idArrayStr) {
        this.idArrayStr = idArrayStr;
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) {
            return true;
        }
        if (!(o instanceof ${model.name?cap_first}DeleteRequestDTO)) {
            return false;
        }
        ${model.name?cap_first}DeleteRequestDTO that = (${model.name?cap_first}DeleteRequestDTO) o;
        return Objects.equals(idArrayStr, that.idArrayStr);
    }

    @Override
    public int hashCode() {
        return Objects.hash(idArrayStr);
    }

}
