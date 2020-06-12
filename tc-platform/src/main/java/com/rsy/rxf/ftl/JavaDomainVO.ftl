package ${project.basePackage}.vo.business.${model.domain.name?uncap_first};

import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
import java.io.Serializable;
import java.util.*;
<#list model.attribute as pro>
    <#if pro.type == 'Double' >
import java.math.BigDecimal;
        <#break>
    </#if>
</#list>

import org.apache.commons.lang3.builder.ReflectionToStringBuilder;
import org.apache.commons.lang3.builder.ToStringStyle;



/**
 * ${model.displayName}VO
 *
 * Created by Recloud
 */
@ApiModel(value = "${model.name?cap_first}VO", description = "${model.displayName}")
public class ${model.name?cap_first}VO implements Serializable{

    /**
     * 主键ID
     */
	@ApiModelProperty(value = "ID")
    private Long id;

    /**
     * 创建时间
     */
	@ApiModelProperty(value = "创建时间")
    private Date createTime;

    /**
     * 创建人
     */
	@ApiModelProperty(value = "创建人")
    private Long creator;

    /**
     * 最后更新时间
     */
	@ApiModelProperty(value = "最后更新时间")
    private Date updateTime;
    /**
     * 更新人
     */
	@ApiModelProperty(value = "更新人")
    private Long updator;

<#list model.attribute as pro>
	/**
	 * ${pro.displayName}
	 * ${pro.memo}
	 */
	@ApiModelProperty(value = "${pro.displayName}:${pro.memo}")
    <#if pro.type == 'DateTime' || pro.type == 'Date'>
	private Date ${pro.name?uncap_first};
	private Date ${pro.name?uncap_first}Start;
	private Date ${pro.name?uncap_first}End;
    <#elseif pro.type == 'Text'>
	private String ${pro.name};
    <#elseif pro.type == 'Reference' >
	private Long ${pro.name}Id;
	@ApiModelProperty(value = "${pro.displayName}名称:${pro.memo}")
	private String ${pro.name}Name;
    <#elseif pro.type == 'SimpleConfig' >
	private String ${pro.name}Code;
	@ApiModelProperty(value = "${pro.displayName}名称:${pro.memo}")
	private String ${pro.name}Name;
    <#elseif pro.type == 'Files' >
	private Long ${pro.name}Id;
    <#elseif pro.type == 'Double' >
	private BigDecimal ${pro.name};
    <#else>
	private ${pro.type} ${pro.name?uncap_first};
    </#if>
</#list>


	public Long getId() {
		return id;
	}

	public void setId(Long id) {
		this.id = id;
	}

	public Date getCreateTime() {
		return createTime;
	}

	public void setCreateTime(Date createTime) {
		this.createTime = createTime;
	}

	public Long getCreator() {
		return creator;
	}

	public void setCreator(Long creator) {
		this.creator = creator;
	}

	public Date getUpdateTime() {
		return updateTime;
	}

	public void setUpdateTime(Date updateTime) {
		this.updateTime = updateTime;
	}

	public Long getUpdator() {
		return updator;
	}

	public void setUpdator(Long updator) {
		this.updator = updator;
	}

<#list model.attribute as pro>
    <#if pro.type == 'DateTime' || pro.type == 'Date'>
	public Date get${pro.name?cap_first}(){
		return ${pro.name};
	}
	public void set${pro.name?cap_first}(Date ${pro.name}) {
		this.${pro.name} = ${pro.name};
	}

	public Date get${pro.name?cap_first}End(){
		return ${pro.name}End;
	}
	public void set${pro.name?cap_first}End(Date ${pro.name}End) {
		this.${pro.name}End = ${pro.name}End;
	}

	public Date get${pro.name?cap_first}Start(){
		return ${pro.name}Start;
	}
	public void set${pro.name?cap_first}Start(Date ${pro.name}Start) {
		this.${pro.name}Start = ${pro.name}Start;
	}
    <#elseif pro.type == 'Text'>
	public String get${pro.name?cap_first}(){
		return ${pro.name};
	}
	public void set${pro.name?cap_first}(String ${pro.name}) {
		this.${pro.name} = ${pro.name};
	}
    <#elseif pro.type == 'Reference' >
	public Long get${pro.name?cap_first}Id(){
		return ${pro.name}Id;
	}
	public void set${pro.name?cap_first}Id(Long ${pro.name}Id) {
		this.${pro.name}Id = ${pro.name}Id;
	}
	public String get${pro.name?cap_first}Name(){
		return ${pro.name}Name;
	}
	public void set${pro.name?cap_first}Name(String ${pro.name}Name) {
		this.${pro.name}Name = ${pro.name}Name;
	}
    <#elseif pro.type == 'SimpleConfig' >
	public String get${pro.name?cap_first}Code(){
		return ${pro.name}Code;
	}
	public void set${pro.name?cap_first}Code(String ${pro.name}Code) {
		this.${pro.name}Code = ${pro.name}Code;
	}
	public String get${pro.name?cap_first}Name(){
		return ${pro.name}Name;
	}
	public void set${pro.name?cap_first}Name(String ${pro.name}Name) {
		this.${pro.name}Name = ${pro.name}Name;
	}
    <#elseif pro.type == 'Files' >
	public Long get${pro.name?cap_first}Id(){
		return ${pro.name}Id;
	}
	public void set${pro.name?cap_first}Id(Long ${pro.name}Id) {
		this.${pro.name}Id = ${pro.name}Id;
	}
	public String get${pro.name?cap_first}Name(){
		return ${pro.name}Name;
	}
	public void set${pro.name?cap_first}Name(String ${pro.name}Name) {
		this.${pro.name}Name = ${pro.name}Name;
	}
    <#elseif pro.type == 'Double'>
	public BigDecimal get${pro.name?cap_first}(){
		return ${pro.name};
	}
	public void set${pro.name?cap_first}(BigDecimal ${pro.name}) {
		this.${pro.name} = ${pro.name};
	}
    <#else>
	public ${pro.type} get${pro.name?cap_first}(){
		return ${pro.name};
	}
	public void set${pro.name?cap_first}(${pro.type} ${pro.name}) {
		this.${pro.name} = ${pro.name};
	}
    </#if>

</#list>

    @Override
    public String toString() {
        return ReflectionToStringBuilder.toString(this, ToStringStyle.SHORT_PREFIX_STYLE);
    }
}
