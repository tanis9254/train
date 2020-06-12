<template>
    <div class="app-container">
        <div class="filter-container">
            <el-input style="width: 120px;" v-model="param.searchCondition.name" class="filter-item" placeholder="名称">
            </el-input>
        <#--搜索条件-->
<#assign x=0/>
<#list model.attribute as pro>
    <#if pro.search || pro.index == 0>
    <#--日期搜索框-->
        <#if pro.type == 'Date'>
        <el-date-picker
                v-model="${pro.code}"
                type="daterange"
                style="width:240px;"
                range-separator="-"
                start-placeholder="开始日期"
                end-placeholder="结束日期"
                format="yyyy-MM-dd"
                value-format="yyyy-MM-dd">
        </el-date-picker>
        <#--日期时间搜索框-->
        <#elseif pro.type == 'DateTime'>
        <el-date-picker
                v-model="${pro.code}"
                type="daterange"
                style="width:240px;"
                range-separator="-"
                start-placeholder="开始时间"
                end-placeholder="结束时间"
                format="yyyy-MM-dd HH:mm"
                value-format="yyyy-MM-dd HH:mm">
        </el-date-picker>
        <#--是否类型选择框-->
        <#elseif pro.type == 'Boolean'>
        <el-select style="width:120px;" v-model="param.searchCondition.${pro.code}" placeholder="是否启用">
            <el-option label="全部" value=""></el-option>
            <el-option label="启用" value="true"></el-option>
            <el-option label="停用" value="false"></el-option>
        </el-select>
        <#--引用类型选择框-->
        <#elseif pro.type == 'Reference'>
        <el-select style="width:250px;" v-model="param.searchCondition.${pro.code}" placeholder="请选择${pro.name}"
                   filterable>
            <el-option label="全部" :value="null"></el-option>
            <el-option
                    v-for="${pro.code?uncap_first} in ${pro.code?uncap_first}List"
                    :key="${pro.code?uncap_first}.id"
                    :label="${pro.code?uncap_first}.code"
                    :value="${pro.code?uncap_first}.id">
            </el-option>
        </el-select>
        <#--数据字段类型选择框-->
        <#elseif pro.type == 'SimpleConfig'>
        <el-select style="width:120px;" v-model="param.searchCondition.${pro.code}Code"
                   placeholder="${pro.name}">
            <el-option label="全部" :value="null"></el-option>
            <el-opti
                    v-for="${pro.code} in ${pro.code}List"
                    :key="${pro.code}.id"
                    :label="${pro.code}.code"
                    :value="${pro.code}.code">
            </el-opti>
        </el-select>
        <#else >
        <el-input style="width: 120px;" v-model="param.searchCondition.${pro.code}" class="filter-item"
                  placeholder="${pro.name}"></el-input>
        </#if>
        <#assign x=x+1 />
        <#if x%3==0>
        </#if>
    </#if>
</#list>
            <el-button class="filter-item" @click="search()" type="primary" icon="el-icon-search">搜索</el-button>
            <el-button class="filter-item" @click="resetSearch()" type="danger" icon="el-icon-refresh">重置</el-button>
            <el-button class="filter-item" type="primary" icon="el-icon-plus" @click="edit()">新增</el-button>
            <el-button class="filter-item" type="danger" icon="el-icon-delete" @click="deleteMulti()">批量删除</el-button>
        </div>

        <el-table
                @selection-change="handleSelectionChange"
                :data="${model.code?uncap_first}List.data"
                v-loading="listLoading"
                border
                style="width: 100%">
            <el-table-column type="selection" width="55"></el-table-column>
        <#list model.attribute as pro>
            <el-table-column type="${pro.code}" label="${pro.name}"></el-table-column>
        </#list>
            <template slot-scope="scope">
                <el-button type="primary" size="mini" @click="edit(scope.row)">修改</el-button>
                <el-button type="danger" size="mini" @click="delete(scope.row.id)">删除</el-button>
            </template>
            </el-table-column>
        </el-table>

        <div class="pagination-container">
            <el-pagination background @size-change="handleSizeChange" @current-change="handleCurrentChange"
                           :current-page="param.page" :page-sizes="[10,20,30, 50]" :page-size="param.limit"
                           layout="total, sizes, prev, pager, next, jumper"
                           :total="${model.code?uncap_first}List.total">
            </el-pagination>
        </div>
        <el-dialog
                :title="mTitle"
                :close-on-click-modal=false
                :visible.sync="dialogVisible">
            <el-form :model="mObject" :rules="rules" ref="mObject" label-width="120px">

            <#list model.attribute as pro>
                <#if pro.type == 'Date'>
                <el-form-item label="${pro.name}" prop="${pro.code}">
                    <el-date-picker
                            v-model="mObject.${pro.code}"
                            type="date"
                            placeholder="选择日期"
                            format="yyyy-MM-dd"
                            value-format="yyyy-MM-dd">
                    </el-date-picker>
                </el-form-item>
                <#elseif pro.type == 'DateTime'>
                <el-form-item label="${pro.name}" prop="${pro.code}">
                    <el-date-picker
                            v-model="mObject.${pro.code}"
                            type="date"
                            placeholder="选择时间"
                            format="yyyy-MM-dd HH:mm"
                            value-format="yyyy-MM-dd HH:mm">
                    </el-date-picker>
                </el-form-item>
                <#elseif pro.type == 'Reference'>
                <el-form-item label="所属${pro.name}" prop="${pro.code}Id">
                    <el-select style="width:250px;" v-model="mObject.${pro.code}Id" placeholder="请选择${pro.name}"
                               filterable
                               @change="change${pro.code?cap_first}()">
                        <el-option
                                v-for="${pro.code} in ${pro.code}List"
                                :key="${pro.code}.id"
                                :label="${pro.code}.code"
                                :value="${pro.code}.id">
                        </el-option>
                    </el-select>
                </el-form-item>
                <#elseif pro.type="SimpleConfig">
                <el-form-item label="${pro.name}" prop="${pro.code}Code">
                    <el-select style="width:120px;" v-model="mObject.${pro.code}Code"
                               placeholder="请选择${pro.name}">
                        <el-option
                                v-for="${pro.code} in ${pro.code}List"
                                :key="${pro.code}.id"
                                :label="${pro.code}.code"
                                :value="${pro.code}.code">
                        </el-option>
                    </el-select>
                </el-form-item>
                <#elseif pro.type="img">
                <el-form-item label="${pro.name}" prop="${pro.code}">
                    <el-upload
                            class="pic-uploader"
                            :multiple="false"
                            :show-file-list="false"
                            :action="attachmentUploadUrl"
                            :auto-upload="true"
                            :data="upLoadData"
                            :headers="headersData"
                            :onSuccess="uploadImgSuccess"
                            accept="image/*">
                        <img v-if="mObject.${pro.code}" :src="mObject.${pro.code}" class="logo">
                        <i v-else class="el-icon-plus logo-uploader-icon"></i>
                    </el-upload>
                </el-form-item>
                <#else>
                <el-form-item label="${pro.name}" prop="${pro.code}">
                    <el-input v-model="mObject.${pro.code}"></el-input>
                </el-form-item>
                </#if>
            </#list>
            </el-form>
            <div slot="footer" class="dialog-footer">
                <el-button @click="dialogVisible = false">取 消</el-button>
                <el-button type="primary" @click="submitForm">确 定</el-button>
            </div>
        </el-dialog>
    </div>
</template>

<style lang="scss">
    .pic-uploader .el-upload {
        border: 1px dashed #d9d9d9;
        border-radius: 6px;
        cursor: pointer;
        position: relative;
        overflow: hidden;
    }

    .pic-uploader .el-upload:hover {
        border-color: #409EFF;
    }

    .logo-uploader-icon {
        font-size: 28px;
        color: #8c939d;
        width: 120px;
        height: 120px;
        line-height: 120px;
        text-align: center;
    }

    .logo {
        width: 120px;
        height: 120px;
        display: block;
    }
</style>

<script>
import { mapState } from 'vuex'
import { getToken } from '@/utils/auth'
import { getConstants } from '@/utils/constants'

export default {
  data() {
    return {
      listLoading: false,
      param: { page: 1, limit: 10, searchCondition: {}},
      dialogVisible: false,
      mObject: {
      },
      mTitle: '',

      attachmentUploadUrl: getConstants().ATTACHMENT_UPLOAD_URL,
      attachmentUrl: getConstants().ATTACHMENT_URL,
      upLoadData: {
        file_id: 0
      },
      headersData: { Authorization: getToken() },

      rules: {
      <#list model.attribute as pro>
        <#if pro.required == true>
        ${pro.code}: [
          { required: true, message: '请填入${pro.name}', trigger: 'blur' }
        ]
        </#if>
      </#list>
      }
    }
  },
  filters: {
  },
  created() {
    this.get${model.code}List()
  <#list model.attribute as pro>
    <#if pro.type == "SimpleConfig">
    this.get${pro.code?cap_first}List()
    <#elseif pro.type == "Reference">
    this.get${pro.code?cap_first}List()
    </#if>
  </#list>
  },
  computed: mapState({

    ${model.code?uncap_first}List: state => state.${model.code?uncap_first}.${model.code?uncap_first}List,
  <#list model.attribute as pro>
    <#if pro.type == "SimpleConfig">
    ${pro.code?uncap_first}List: state => state.${model.code?uncap_first}.${pro.code?uncap_first}List,
    <#elseif pro.type == "Reference">
    ${pro.code?uncap_first}List: state => state.${model.code?uncap_first}.${pro.code?uncap_first}List,
    </#if>
  </#list>
  }),
  methods: {
    get${model.code}List() {

  <#list model.attribute as pro>
    <#if pro.type == "Date">
      if (this.${pro.code}) {
        this.param.searchCondition.${pro.code}Start = moment(this.${pro.code}[0]).format('YYYY-MM-DD')
        this.param.searchCondition.${pro.code}End = moment(this.${pro.code}[1]).format('YYYY-MM-DD')
      }
    <#elseif pro.type == "DateTime">
      if (this.${pro.code}) {
        this.param.searchCondition.${pro.code}Start = moment(this.${pro.code}[0]).format('YYYY-MM-DD HH:mm')
        this.param.searchCondition.${pro.code}End = moment(this.${pro.code}[1]).format('YYYY-MM-DD HH:mm')
      }
    </#if>
  </#list>
      this.listLoading = true
      this.$store.dispatch('get${model.code}List', { params: this.param }).then(() => {
        this.listLoading = false
      })
    },
    search() {
      this.param.page = 1
      this.get${model.code}List()
    },
    resetSearch() {
      this.param.page = 1
      this.param.searchCondition = {}
      this.get${model.code}List()
    },
    handleSizeChange(size) {
      this.param.limit = size
      this.get${model.code}List()
    },
    handleCurrentChange(page) {
      this.param.page = page
      this.get${model.code}List()
    },
    handleSelectionChange(val) {
      this.selectedRows = val
    },

    // 编辑/新增
    edit(row) {
      this.mTitle = '编辑'
      if (!row) {
        this.mTitle = '新增'
        row = {
          sign: '',
          img: ''
        }
      }
      this.mObject = Object.assign({}, row)
      this.dialogVisible = true
      this.$nextTick(() => {
        this.$refs['mObject'].clearValidate()
      })
    },
    // 提交表单
    submitForm() {
      this.$refs['mObject'].validate((valid) => {
        if (valid) {
          if (this.mObject.id) {
            this.$store.dispatch('edit${model.code}', { data: this.mObject, callback: () => {
              this.dialogVisible = false
              this.get${model.code}List()
            } })
          } else {
            this.$store.dispatch('add${model.code}', { data: this.mObject, callback: () => {
              this.dialogVisible = false
              this.get${model.code}List()
            } })
          }
        } else {
          return false
        }
      })
    },
    // 删除${model.name}
    delete${model.code}(id) {
      this.$confirm('此操作将永久删除该数据, 是否继续?', '提示', {
        confirmButtonText: '确定',
        cancelButtonText: '取消',
        type: 'warning'
      }).then(() => {
        this.$store.dispatch('delete${model.code}', { data: id, callback: () => {
          this.get${model.code}List()
        } })
      })
    },
    // 批量删除${model.name}
    deleteMulti() {
      const idsArr = []
      for (const row of this.selectedRows) {
        idsArr.push(row.id)
      }
      if (!idsArr.length) {
        this.$message({
          type: 'error',
          message: '请先选择需要删除的项!',
          duration: 3 * 1000
        })
        return false
      }
      this.delete${model.code}({ id: idsArr.join(',') })
    },
  <#list model.attribute as pro>
    <#if pro.type == "SimpleConfig">
    get${pro.code?cap_first}List() {
      this.$store.dispatch('get${pro.code?cap_first}List', { params: {}})
    },
    <#elseif pro.type == "Reference">
    get${pro.code?cap_first}List() {
      this.$store.dispatch('get${pro.code?cap_first}List', { params: { page: 0, limit: 10000, searchCondition: {}}})
    },
    <#elseif pro.type == "img">
    upload${pro.code?cap_first}Success(response, file, fileList) {
      if (response.success) {
        this.mObject.${pro.code} = this.attachmentUrl + response.data
      }
    }
    </#if>
  </#list>
  }
}
</script>
