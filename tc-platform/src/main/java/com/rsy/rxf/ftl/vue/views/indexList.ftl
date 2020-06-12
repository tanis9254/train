<!-- 页面：${model.name}列表 -->
<template>
    <section class="container">
        <sub-title :color="`#ff0f40`" :margin="`15px 0`">${model.name}管理</sub-title>
        <a-layout>
            <a-layout-content class="overflow-hidden">
                <div class="flex-container" :class="show${model.code}Radio?'space-between':'flex-end'">
                    <a-radio-group v-model="${model.code?uncap_first}Radio" v-show="show${model.code}Radio">
                        <a-radio-button value="ALL">全部</a-radio-button>
                        <#--<a-radio-button value="AUDIT">待审批</a-radio-button>-->
                    </a-radio-group>
                    <ul class="g-handle-list">
                        <li class="handle-item">
                            <a @click="add${model.code}">
                                <a-icon type="plus-circle"/>新增
                            </a>
                        </li>
                        <li class="handle-item">
                          <a @click="edit${model.code}('')">
                            <a-icon type="form"/>编辑
                          </a>
                        </li>
                    </ul>
                </div>
                <a-divider/>
                <!-- 表格 -->
                <a-table
                        :rowSelection="{selectedRowKeys: selectedRowKeys, onChange: onSelectChange}"
                        :rowKey="record => record.id"
                        :columns="columns"
                        :dataSource="data"
                        :loading="loading"
                        :pagination="false"
                        @change="pageChange"
                >
                    <template slot="view" slot-scope="text,record">
                        <a-button class="table-operate-btn view-btn" @click="viewDetail(record.id)">查看</a-button>
                        <a-button class="table-operate-btn edit-btn" @click="edit${model.code}(record.id)">编辑</a-button>
                        <a-button class="table-operate-btn del-btn" @click="del${model.code}(record)">删除</a-button>
                    </template>
                </a-table>
                <no-data :show="!data.length"/>
                <a-pagination
                        v-show="total > 0"
                        :pageSizeOptions="pageSizeOptions"
                        :total="total"
                        showSizeChanger
                        showQuickJumper
                        :pageSize="pageSize"
                        :current="(current+1)"
                        @change="pageChange"
                        @showSizeChange="onShowSizeChange"
                ></a-pagination>
            </a-layout-content>
        </a-layout>
        <add-${model.code?uncap_first} ref="add${model.code}Modal" @refresh="fetchData"/>
        <${model.code?uncap_first}-detail ref="${model.code?uncap_first}DetailModal" @refresh="fetchData" @update="edit${model.code}"/>
    </section>
</template>
<script>
import { Pagination, Divider, Modal } from 'ant-design-vue'
import NoData from '@/components/common/noData'
import SubTitle from "@/components/common/subTitle";
import Add${model.code} from './add${model.code}'
import ${model.code}Detail from './${model.code?uncap_first}Detail'
import { get${model.code}List, delete${model.code} } from '@/api/${module.code?uncap_first}/${model.code?uncap_first}'
<#list model.attribute as pro>
<#if pro.type == "SimpleConfig">
import { get${pro.code?cap_first}List} from '@/api/${module.code?uncap_first}/${model.code?uncap_first}'
</#if>
</#list>
import { mapMutations, mapGetters } from 'vuex'
import moment from 'moment'
// 表格
const columns = [

<#list model.attribute as pro>
  <#if pro.visible>
  <#if pro.type == 'Text'>
  {
    title: "${pro.name}",
    dataIndex: "${pro.code}",
    scopedSlots: { customRender: "${pro.code}" },
    align: 'center'
  },
  <#else>
  {
    title: "${pro.name}",
    dataIndex: "${pro.code}",
    scopedSlots: { customRender: "${pro.code}" },
    align: 'center'
  },
  </#if>
  </#if>
 </#list>
  {
    title: "操作",
    dataIndex: "applyPeople",
    scopedSlots: { customRender: "view" },
    align: 'center'
  }
];
export default {
  data() {
    return {
      show: true,
      data: [],
      columns,
      pageSizeOptions: ['10', '20', '30', '40', '50'],
      pageSize: 10,
      current: 0,
      total: 3,
      selectedRowKeys: [], // Check here to configure the default column
      loading: false,
      ${model.code?uncap_first}Radio: 'ALL',
      ${model.code?uncap_first}Status: ''

    }
  },
  computed: {
    hasSelected() {
      return this.selectedRowKeys.length > 0;
    },
    formItemLayout() {
      const { formLayout } = this;
      return formLayout === 'horizontal' ? {
        labelCol: { span: 6 },
        wrapperCol: { span: 14 },
      } : {};
    },
    // 判断是否显示radio
    show${model.code}Radio() {
      return false
    },
    ...mapGetters('account', ['userInfo', 'account'])
  },
  <#--监听radio状态-->
  watch: {
    ${model.code?uncap_first}Radio(newVal) {
      if (newVal) {
        this.current = 0
        this.${model.code?uncap_first}Status = newVal === 'ALL' ? '' : ''
        this.fetchData()
      }
    }
  },
  components: {
    ADivider: Divider,
    APagination: Pagination,
    Add${model.code},
    ${model.code}Detail,
    SubTitle,
    NoData
  },
  mounted() {
    this.fetchData()
    this.getDataDictionaryApi()
  },
  methods: {
    async getDataDictionaryApi() {
    <#list model.attribute as pro>
    <#if pro.type == "SimpleConfig">
      let ${pro.code}List = await get${pro.code?cap_first}List({ type: '${"${pro.code}"?replace("([a-z])([A-Z]+)","$1_$2","r")?lower_case}' });
      this.set${pro.code?cap_first}List(${pro.code}List)
    </#if>
    </#list>
    },
    fetchData() {
      this.loading = true
      const sortParams = [{ 'property': 'createAt'}]
      const params = {
        limit: this.pageSize,
        page: this.current,
        searchCondition: {
        },
        sortCondition: JSON.stringify(sortParams)
      }
      this.selectedRowKeys = []
      get${model.code}List(params).then(res => {
        this.loading = false
        let content = res.content
        this.data = content
        this.total = ~~res.total
      })
    },
    // 每页条数切换
    onShowSizeChange(current, pageSize) {
      this.pageSize = pageSize
      this.fetchData()
    },
    onSelectChange(selectedRowKeys) {
      this.selectedRowKeys = selectedRowKeys
    },
    // 查看详情
    viewDetail(id) {
      this.$refs.${model.code?uncap_first}DetailModal.open(id)
    },
    // 页码点击
    pageChange(current) {
      this.current = current - 1
      this.fetchData()
    },
    add${model.code}() {
      this.$refs.add${model.code}Modal.open()
    },
    edit${model.code}(id) {
      let ${model.code?uncap_first}Id = ''
      if (id) {
        ${model.code?uncap_first}Id = id
        this.$refs.add${model.code}Modal.open(true, ${model.code?uncap_first}Id)
        return
      }
      if (this.selectedRowKeys.length !== 1) {
        this.$message.warn('请选择一行数据编辑')
      } else {
        this.$refs.add${model.code}Modal.open(true, this.selectedRowKeys[0])
      }
    },
    del${model.code}(record) {
      let _this = this
      Modal.confirm({
        title: '提示',
        content: '确定要删除${model.name}吗?',
        centered: true,
        onOk() {
          delete${model.code}({
            id: record.id
          }).then(res => {
            _this.$message.success('已成功删除')
            _this.fetchData()
          })
        }
      })
    },
    ...mapMutations('dictionaryManage', {
    <#list model.attribute as pro>
    <#if pro.type == "SimpleConfig">
      set${pro.code?cap_first}List: '${"set${pro.code?cap_first}List"?replace("([a-z])([A-Z]+)","$1_$2","r")?upper_case}'
    </#if>
    </#list>
    })
  }
};
</script>

<style lang="scss" scoped>
    .container {
        margin: 0 17px 10px 11px;
    .ant-layout-content {
        background-color: #ffffff;
        border-radius: 5px;
        border: solid 1px #e5e5e5;
    }
    }
    .space-between {
        justify-content: space-between;
    }
</style>
