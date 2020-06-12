import {
  get${model.code}List,
  add${model.code},
  delete${model.code},
  edit${model.code},
<#list model.attribute as pro>
  <#if pro.type == "SimpleConfig">
  get${pro.code?cap_first}List,
  <#elseif pro.type = "Reference">
  get${pro.code?cap_first}List,
  </#if>
</#list>
} from '@/api/${model.code?uncap_first}'
import { getToken } from '@/utils/auth'

const objectStore = {
  state: {
    token: getToken(),
    ${model.code?uncap_first}List: {},
  <#list model.attribute as pro>
    <#if pro.type == "SimpleConfig">
    ${pro.code?cap_first}List: {},
    <#elseif pro.type = "Reference">
    ${pro.code?cap_first}List: {},
    </#if>
  </#list>
  },

  mutations: {
    SET_TOKEN: (state, token) => {
      state.token = token
    },
    SET_${model.code?upper_case}_LIST: (state, ${model.code?uncap_first}List) => {
      state.${model.code?uncap_first}List = ${model.code?uncap_first}List
    },

  <#list model.attribute as pro>
    <#if pro.type == "SimpleConfig">
    SET_${improvedNamingStrategy(model.code?cap_first)?upper_case}_${improvedNamingStrategy(pro.code?cap_first)?upper_case}_LIST: (state, ${pro.code?uncap_first}List) => {
      state.${pro.code?uncap_first}List = ${pro.code?uncap_first}List.data
    },
    <#elseif pro.type = "Reference">
    SET_${pro.code?upper_case}_LIST: (state, ${pro.code?uncap_first}List) => {
      state.${pro.code?uncap_first}List = ${pro.code?uncap_first}List.data
    },
    </#if>
  </#list>
  },

  actions: {
    // 获取${model.name}列表
    get${model.code}List({ commit }, params) {
      return new Promise((resolve, reject) => {
        get${model.code}List(params).then(response => {
          commit('SET_${model.code?upper_case}_LIST', response)
          params.callback && params.callback()
        })
      })
    },

<#list model.attribute as pro>
  <#if pro.type == "SimpleConfig">
    // 获取${pro.name}列表
    get${pro.code?cap_first}List({ commit }, params) {
      return new Promise((resolve, reject) => {
        get${pro.code?cap_first}List(params).then(response => {
          commit('SET_${improvedNamingStrategy(model.code?cap_first)?upper_case}_${improvedNamingStrategy(pro.code?cap_first)?upper_case}_LIST', response)
          params.callback && params.callback()
        })
      })
    },
  <#elseif pro.type = "Reference">
    // 获取${pro.name}列表
    get${pro.code?cap_first}List({ commit }, params) {
      return new Promise((resolve, reject) => {
        get${pro.code?cap_first}List(params).then(response => {
          commit('SET_${pro.code?upper_case}_LIST', response)
          params.callback && params.callback()
        })
      })
    },
  </#if>
</#list>
    // 添加
    add${model.code}({ commit }, params) {
      console.log(params.data)
      return new Promise((resolve, reject) => {
        add${model.code}(JSON.stringify(params.data)).then(response => {
          params.callback && params.callback()
        })
      })
    },

    // 编辑
    edit${model.code}({ commit }, params) {
      console.log(params.data)
      return new Promise((resolve, reject) => {
        edit${model.code}(JSON.stringify(params.data)).then(response => {
          params.callback && params.callback()
        })
      })
    },

    // 删除
    delete${model.code}({ commit }, params) {
      console.log(params.data)
      return new Promise((resolve, reject) => {
        delete${model.code}(params.data).then(response => {
          params.callback && params.callback()
        })
      })
    }
  }
}

export default objectStore
