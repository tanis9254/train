package ${project.basePackage}.po.business.${model.domain.name?uncap_first};

import java.io.Serializable;
<#list model.attribute as pro>
	<#if pro.type == 'Date' || pro.type == 'DateTime'>
import java.util.*;
		<#break>
	</#if>
</#list>
<#list model.attribute as pro>
	<#if pro.type == 'Double' >
import java.math.BigDecimal;
		<#break>
	</#if>
</#list>
import com.baomidou.mybatisplus.enums.FieldStrategy;


import org.apache.commons.lang3.builder.ReflectionToStringBuilder;
import org.apache.commons.lang3.builder.ToStringStyle;

import com.baomidou.mybatisplus.annotations.TableField;
import com.baomidou.mybatisplus.annotations.TableName;

import com.baomidou.mybatisplus.mapper.SqlCondition;
import com.rsy.rxf.po.BaseEntity;


/**
 * ${model.displayName}
 *
 * Created by Recloud
 */
@TableName("${improvedNamingStrategy(model.name?cap_first)}")
public class ${model.name?cap_first}  extends BaseEntity<${model.name?cap_first}>  {
    public static final String PROPERTY_ID = "id";
	public static final String COLUMN_ID = "id";

    public static final String PROPERTY_CTEATOR = "creator";
	public static final String COLUMN_CTEATOR = "creator";

	public static final String PROPERTY_UPDATOR = "updator";
	public static final String COLUMN_UPDATOR = "updator";

	public static final String PROPERTY_CREATE_TIME = "createTime";
	public static final String COLUMN_CREATE_TIME = "create_time";

	public static final String PROPERTY_UPDATE_TIME = "updateTime";
	public static final String COLUMN_UPDATE_TIME = "update_time";

<#list model.attribute as pro>
	<#if pro.type == 'Reference' || pro.type == 'Files'>
    public static final String PROPERTY_${improvedNamingStrategy(pro.name)?upper_case}_ID = "${pro.name}Id";
	public static final String COLUMN_${improvedNamingStrategy(pro.name)?upper_case}_ID = "${improvedNamingStrategy(pro.name?cap_first)}_id";
	<#elseif pro.type == 'SimpleConfig'>
    public static final String PROPERTY_${improvedNamingStrategy(pro.name)?upper_case}_CODE = "${pro.name}Code";
    public static final String COLUMN_${improvedNamingStrategy(pro.name)?upper_case}_CODE = "${improvedNamingStrategy(pro.name?cap_first)}";
	<#else>
    public static final String PROPERTY_${improvedNamingStrategy(pro.name)?upper_case} = "${pro.name}";
	public static final String COLUMN_${improvedNamingStrategy(pro.name)?upper_case} = "${improvedNamingStrategy(pro.name?cap_first)}";
	</#if>

</#list>


<#list model.attribute as pro>

	/**
	 * ${pro.displayName}
	 * ${pro.memo}
	 */
	<#if pro.persist>
		<#if pro.required>
			<#if pro.type == 'Reference'>
	@TableField(value="${improvedNamingStrategy(pro.name?cap_first)}_id" ,strategy = FieldStrategy.NOT_NULL)
			<#else>
	@TableField(value="${improvedNamingStrategy(pro.name?cap_first)}" ,strategy = FieldStrategy.NOT_NULL)
			</#if>
		<#else>
			<#if pro.type == 'Reference'>
    @TableField(value="${improvedNamingStrategy(pro.name?cap_first)}_id")
			<#else>
    @TableField(value="${improvedNamingStrategy(pro.name?cap_first)}")
			</#if>
		</#if>
	<#else>
	@TableField(exist = false)
	</#if>
	<#if pro.type == 'Date'>
	private Date ${pro.name};
	<#elseif pro.type == 'DateTime'>
	private Date ${pro.name};
	<#elseif pro.type == 'Text'>
	private String ${pro.name};
	<#elseif pro.type == 'String'>
	private String ${pro.name};
	<#elseif pro.type == 'Reference' >
	private Long ${pro.name}Id;
	<#elseif pro.type == 'SimpleConfig' >
	private String ${pro.name}Code;
	<#elseif pro.type == 'Files' >
	private Long ${pro.name}Id;
	@TableField(exist = false)
	private String ${pro.name}Name;
	<#elseif pro.type == 'Double' >
	private BigDecimal ${pro.name};
	<#else>
	private ${pro.type} ${pro.name};
	</#if>

</#list>

<#list model.attribute as pro>
	<#if pro.type == 'DateTime'>
	public Date get${pro.name?cap_first}(){
		return ${pro.name};
	}
	public void set${pro.name?cap_first}(Date ${pro.name}) {
		this.${pro.name} = ${pro.name};
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
	<#elseif pro.type == 'SimpleConfig' >
	public String get${pro.name?cap_first}Code(){
		return ${pro.name}Code;
	}
	public void set${pro.name?cap_first}Code(String ${pro.name}Code) {
		this.${pro.name}Code = ${pro.name}Code;
	}
	<#elseif pro.type == 'Files' >
	public Long get${pro.name?cap_first}Id(){
		return ${pro.name}Id;
	}
	public void set${pro.name?cap_first}Id(Long ${pro.name}Id) {
		this.${pro.name}Id = ${pro.name}Id;
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
