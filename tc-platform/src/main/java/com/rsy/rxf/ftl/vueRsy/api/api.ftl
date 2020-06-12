import request from '@/utils/request'

/**
 * 获取列表
 * @param {*} params
 */
export function get${model.code}List(params) {
  return request({
    url: '/business/${module.code?uncap_first}/${model.code?uncap_first}/list',
    method: 'get',
    params
  })
}

/**
 * 添加
 * @param {*} params
 */
export function add${model.code}(params) {
  return request({
    url: '/business/${module.code?uncap_first}/${model.code?uncap_first}',
    method: 'post',
    isJSON: true,
    data: params
  })
}

/**
 * 编辑
 * @param {*} params
 */
export function edit${model.code}(params) {
  return request({
    url: '/business/${module.code?uncap_first}/${model.code?uncap_first}/' + JSON.parse(params).id,
    method: 'put',
    isJSON: true,
    data: params
  })
}

/**
 * 删除
 * @param {*} params
 */
export function delete${model.code}(params) {
  return request({
    url: '/business/${module.code?uncap_first}/${model.code?uncap_first}/' + params,
    method: 'DELETE',
    isJSON: true
  })
}

<#list model.attribute as pro>
    <#if pro.type == "SimpleConfig">
/**
 * 获取${pro.name}列表
 * @param {*} params
 */
export function get${pro.code?cap_first}List(params) {
  return request({
    url: '/admin/dict/dictionaryItem/listAll/${improvedNamingStrategy(model.code?cap_first)?upper_case}_${improvedNamingStrategy(pro.code?cap_first)?upper_case}',
    method: 'get',
    params
  })
}
    <#elseif pro.type = "Reference">
/**
 * 获取${pro.name}列表
 * @param {*} params
 */
export function get${pro.code?cap_first}List(params) {
  return request({
    url: '/admin/dict/dictionaryItem/listAll/${improvedNamingStrategy(model.code?cap_first)?upper_case}_${improvedNamingStrategy(pro.code?cap_first)?upper_case}',
    method: 'get',
    params
  })
}
    </#if>
</#list>
