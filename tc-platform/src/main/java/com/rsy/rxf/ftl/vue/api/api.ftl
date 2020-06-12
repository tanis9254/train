import network from '@/api/axios'

/**
 * 获取列表
 * @param {*} params
 */
export const get${model.code}List = params => network.post('/business/${module.code?uncap_first}/${model.code?uncap_first}/list', params, { _useForm: false })

/**
 * 获取${model.name}列表
 * @param {*} params
 */
export const get${model.code}Detail = id => network.get(`/business/${module.code?uncap_first}/${model.code?uncap_first}/${r'${id}'}`, {})

/**
 * 添加
 * @param {*} params
 */
export const add${model.code} = params => network.post('/business/${module.code?uncap_first}/${model.code?uncap_first}', params, { _useForm: true })

/**
 * 编辑
 * @param {*} params
 */
export const edit${model.code} = params => network.put('/business/${module.code?uncap_first}/${model.code?uncap_first}/${r'${id}'}', params, { _useForm: false })

/**
 * 删除
 * @param {*} params
 */
export const delete${model.code} = params => network.delete('/business/${module.code?uncap_first}/${model.code?uncap_first}/' + params, {}, { _useForm: false })

<#list model.attribute as pro>
    <#if pro.type == "SimpleConfig">
/**
 * 获取${pro.name}列表
 * @param {*} params
 */
export const get${pro.code?cap_first}List = params => network.post('/platform/datadictionary/typelist', params, { _useForm: true })

    <#elseif pro.type = "Reference">
/**
 * 获取${pro.name}列表
 * @param {*} params
 */
export const get${pro.code?cap_first}List = params => network.get('/business/${pro.reference.module.code?uncap_first}/${pro.reference.code?uncap_first}/list', params, { _useForm: false })
    </#if>
</#list>
