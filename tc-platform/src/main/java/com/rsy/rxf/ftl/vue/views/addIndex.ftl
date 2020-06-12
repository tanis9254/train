<!-- 弹窗：新增/编辑${model.name} -->
<template>
  <a-modal
    title="新增${model.name}"
    v-model="show"
    :width="850"
    :centered="true"
    :maskClosable="false"
    :destroyOnClose="true"
    :confirmLoading="confirmLoading"
    @ok="handleOk"
  >
    <a-form class="ant-advanced-search-form" :form="form">
    <#list model.attribute as pro>
      <#if pro.type == 'Text'>
      <a-form-item label="${pro.name}：" :label-col="{ span: 6 }" :wrapper-col="{ span: 16 }">
          <a-input
                  maxlength="255"
                  placeholder="输入${pro.name}"
                  :autosize="{ minRows: 2, maxRows: 4 }"
                  v-decorator="['${pro.code}'<#if pro.required == true>,{rules: [{ required: true, message: '${pro.name}不能为空' }]}</#if>]"
          />
      </a-form-item>
      <#elseif pro.type == 'Reference'>
      <#--是否类型选择框-->
      <#elseif pro.type == 'Boolean'>
      <a-form-item
              label="${pro.name}："
              :label-col="{ span: 6 }"
              :wrapper-col="{ span: 16 }">
          <a-select style="width: 100%"
                    v-decorator="['${pro.code}'<#if pro.required == true>,{rules: [{ required: true, message: '${pro.name}不能为空' }]}</#if>]">
              <a-select-option key="true" value="true">启用</a-select-option>
              <a-select-option key="false" value="false">停用</a-select-option>
          </a-select>
      </a-form-item>
      <#elseif pro.type == 'SimpleConfig'>
      <a-form-item
              label="${pro.name}："
              :label-col="{ span: 6 }"
              :wrapper-col="{ span: 16 }"
              v-if="${pro.code}List.length">
          <a-select
                  style="width: 100%"
                  v-decorator="['${pro.code}'<#if pro.required == true>,{rules: [{ required: true, message: '${pro.name}不能为空' }]}</#if>]">
              <a-select-option
                      v-for="item in ${pro.code}List"
                      :value="item.businessCode"
                      :key="item.businessCode"
              >{{item.businessValue}}</a-select-option>
          </a-select>
      </a-form-item>
      <#elseif pro.type == 'DateTime'>
      <a-row>
          <a-col :span="6" class="form-label">
              <span>*</span>${pro.name}：
          </a-col>
          <a-col :span="8">
              <a-form-item label :label-col="{ span: 6 }" :wrapper-col="{ span: 16 }">
                  <a-date-picker
                          dropdownClassName="limit-minutes-picker"
                          :showTime="showTime"
                          :showToday="false"
                          :disabledDate="disabledDate"
                          :disabledTime="disabledTime"
                          style="width:255px"
                          format="YYYY-MM-DD HH:mm"
                          placeholder="${pro.name}"
                          v-decorator="['${pro.code}'<#if pro.required == true>,{rules: [{ required: true, message: '${pro.name}不能为空' }]}</#if>]"
                  />
              </a-form-item>
          </a-col>
      </a-row>
      <#elseif pro.type == 'Date'>
      <a-row>
          <a-col :span="6" class="form-label">
              <span>*</span>${pro.name}：
          </a-col>
          <a-col :span="8">
              <a-form-item label :label-col="{ span: 6 }" :wrapper-col="{ span: 16 }">
                  <a-date-picker
                          dropdownClassName="limit-minutes-picker"
                          :showTime="showTime"
                          :showToday="false"
                          :disabledDate="disabledDate"
                          :disabledTime="disabledTime"
                          style="width:255px"
                          format="YYYY-MM-DD"
                          placeholder="${pro.name}"
                          v-decorator="['${pro.code}'<#if pro.required == true>,{rules: [{ required: true, message: '${pro.name}不能为空' }]}</#if>]"
                  />
              </a-form-item>
          </a-col>
      </a-row>
      <#elseif pro.type == 'img'>
      <a-form-item label="上传附件" :label-col="{ span: 6 }" :wrapper-col="{ span: 16 }">
          <a-upload
                  name="file"
                  accept=".doc, .docx, image/gif, image/jpeg, image/png, image/jpg"
                  :multiple="false"
                  :data="uploadData"
                  :action="`${host}/annex/getFileUrl`"
                  :fileList="fileList"
                  @preview="handlePreview"
                  @change="onFileChange">
              <a-button v-if="fileList.length < 9">
                  <a-icon type="upload"/>本地上传
              </a-button>
          </a-upload>
          <a-modal
                  :visible="previewVisible"
                  :width="1350"
                  title="预览"
                  :centered="true"
                  :footer="null"
                  wrapClassName="preview-image-modal"
                  @cancel="handleCancelPreview">
              <img alt="example" style="width: 100%" :src="previewImage">
          </a-modal>
      </a-form-item>
      <#else>
      <a-form-item label="${pro.name}：" :label-col="{ span: 6 }" :wrapper-col="{ span: 16 }">
          <a-input
                  maxlength="100"
                  placeholder="输入${pro.name}"
                  v-decorator="['${pro.code}'<#if pro.required == true>,{rules: [{ required: true, message: '${pro.name}不能为空' }]}</#if>]"
          />
      </a-form-item>
      </#if>
    </#list>
    </a-form>
  </a-modal>
</template>

<script>
import { Modal, DatePicker, Upload } from 'ant-design-vue'
import { mapGetters } from 'vuex'
import { objArryDeepCopy, objDeepCopy } from '@/plugins/utils'
import { add${model.code}, edit${model.code}, get${model.code}Detail} from '@/api/${module.code?uncap_first}/${model.code?uncap_first}'
import moment from 'moment'
import debounce from 'lodash/debounce'
import AnnexPreview from '@/components/common/annexPreview/index2'
import mixins from '@/mixins/mixin'
export default {
  data() {
    return {
    <#list model.attribute as pro>
    <#if pro.type == "SimpleConfig">
    <#elseif pro.type == "Reference">
    <#elseif pro.type == "img">
      annexUrl: '', // 附件地址
      fileList = [],
    </#if>
    </#list>
      show: false,
      form: this.$form.createForm(this),
      formLayout: "horizontal",
      dataSource: [],
      deptValue: [],
      data: [],
      fetching: false,
      annexUrl: '', // 附件地址
      uploadData: {}, // 附件上传额外参数
      operate: 'ADD',
      id: '',
      value: '',
      searchResult: [],
      host: process.env.API,
      checkLeader: false,
      moment: moment,
      confirmLoading: false,
      showTime: {
        minuteStep: 30,
        format: 'HH:mm'
      }
    };
  },
  mixins: [mixins],
  computed: {
    formItemLayout() {
      const { formLayout } = this;
      return formLayout === 'horizontal'
        ? {
          labelCol: { span: 6 },
          wrapperCol: { span: 18 }
        }
        : {}
    },
  <#list model.attribute as pro>
  <#if pro.type == "SimpleConfig">
    ...mapGetters('dictionaryManage', ['${pro.code}List']),
  </#if>
  </#list>
    ...mapGetters('account', ['deptUserList', 'userInfo', 'allUserList'])
  },
  components: {
    AModal: Modal,
    ADatePicker: DatePicker,
    AUpload: Upload,
    ARangePicker: DatePicker.RangePicker,
    AnnexPreview
  },
  mounted() {
    // 附件上传额外参数
    this.uploadData.uid = this.userInfo.id
  },
  methods: {
    range(start, end) {
      const result = [];
      for (let i = start; i < end; i++) {
        result.push(i);
      }
      return result;
    },
    disabledDate(current) {
      return false
    },
    disabledTime(current) {
      return false
    },

  <#list model.attribute as pro>
  <#if pro.type == "Reference">
  </#if>
  </#list>
    // 必填项去空格
    trimStr() {
    },
    // 添加${model.name}
    handleOk() {
      this.trimStr()
      this.form.validateFields((err, values) => {
        if (!err) {
          const params = objArryDeepCopy(values)
          if (this.operate === 'ADD') {
            // 添加${model.name}提交数据
            this.confirmLoading = true
            add${model.code}(params).then(res => {
              this.confirmLoading = false
              this.$message.success('添加成功')
              this.show = false
              this.$emit('refresh')
            }).catch(e => {
              this.confirmLoading = false
            })
          } else {
            // 编辑${model.name}提交数据
            this.confirmLoading = true
            update${model.code}(this.id, params).then(res => {
              this.$message.success('编辑成功')
              this.confirmLoading = false
              this.show = false
              this.$emit('refresh')
            }).catch(e => {
              this.confirmLoading = false
            })
          }
        }
      })
    },
    open(edit = false, id = '') {
      this.confirmLoading = false
      // form-item不能通过v-model实现双向绑定，需要通过setFieldValue给表单赋值
      if (!edit) {
        this.show = true
        this.operate = 'ADD'
        <#list model.attribute as pro>
        <#if pro.type == "img">
        this.fileList = [] // 清空已选附件
        this.annexUrl = ''
        </#if>
        </#list>
        this.form.resetFields() // 重置表单
      } else {
        this.operate = 'EDIT'
        this.id = id
        get${model.code}Detail(id).then(res => {
          this.show = true
          this.annexUrl = res.annexUrl
          let annexList = []
          let fileList = []
          if (res.annexVOList && res.annexVOList.length) {
            // annexList = res.annexUrl.split(',')
            res.annexVOList.map((item, index) => {
              fileList.push({
                uid: item.id,
                name: item.fileName,
                status: 'done',
                url: item.annexUrl
              })
            })
          }
          this.fileList = fileList

          this.$nextTick(() => {
            this.form.setFieldsValue({
              <#list model.attribute as pro>
              <#if pro.type == "Date" || pro.type == 'DateTime'>
              ${pro.code}: moment(res.${pro.code}),
              <#else>
              ${pro.code}: res.${pro.code},
              </#if>
              </#list>
            })
          })
        })
      }
    },
    // 关闭图片预览弹窗
    handleCancel() {
      this.previewVisible = false
    },
    // 上传的附件预览，由于附件有可能是编辑时带过来的，直接从url里获取
    // handlePreview(file) {
    //   if (file.url || file.response) {
    //     window.open(file.url || file.response.data.url)
    //   }
    // },
    // 附件上传回调函数
    onFileChange(files, type) {
      this.fileList = files.fileList
      let fileList = files.fileList
      let fileUrlStr = ''
      if (fileList.length) {
        fileList.map((item, i) => {
          if (item.response) { // 可能reponse并未返回
            let { code, data } = item.response
            if (code === 0) {
              if (fileUrlStr == '') {
                fileUrlStr += data.url
              } else {
                fileUrlStr += `,${r'${data.url}'}`
              }
            }
          }
          // 如果是编辑时自带的图片
          if (item.url) {
            if (fileUrlStr == '') {
              fileUrlStr += item.url
            } else {
              fileUrlStr += `,${r'${item.url}'}`
            }
          }
        })
      }
      this.annexUrl = fileUrlStr
    }
  }
}
</script>
<style lang="scss" scoped>
.form-label {
  font-size: 16px;
  text-align: right;
  line-height: 36px;
  color: rgba(0, 0, 0, 0.85);
  span {
    display: inline-block;
    margin-right: 4px;
    content: "*";
    font-family: SimSun;
    line-height: 1;
    font-size: 14px;
    color: #f5222d;
  }
}
>>> .ant-calendar-time-picker-select:last-child {
  overflow: hidden !important;
  height: 260px;
}
</style>

