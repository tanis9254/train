<!-- 弹窗：${model.name}详情-->
<template>
  <a-modal title="${model.name}详情" v-model="show" :centered="true" :width="850" :zIndex="1006">
  <#list model.attribute as pro>
  <#if pro.type == "SimpleConfig">
  <#elseif pro.type == "Reference">
  <#elseif pro.type == "img">
  <a-row>
      <a-col :span="19" :offset="4">
          <annex-preview :fileList="${model.code?uncap_first}Detail.annexVOList"/>
      </a-col>
  </a-row>
  <#else>
  <a-row class="row-detail">
      <a-col :span="4" class="text-align-right bold">${pro.name}：</a-col>
      <a-col :span="20" class="bold">{{${model.code?uncap_first}Detail.${pro.code}}}</a-col>
  </a-row>
  </#if>
</#list>
    <div
      slot="footer"
      class="popup-footer"
      style="margin-top: 20px;">
      <a-button type="default" v-if="canEdit" @click="editMeeting">编辑</a-button>
    </div>
  </a-modal>
</template>

<script>
import { Modal, Upload } from 'ant-design-vue'
import AnnexPreview from '@/components/common/annexPreview/index2'
import { get${model.code}Detail } from '@/api/${module.code?uncap_first}/${model.code?uncap_first}'
import moment from 'moment'
import { mapGetters } from 'vuex'
export default {
  data() {
    return {
      show: false,
      hideOperateBtn: false,
      previewVisible: false,
      // fileList: [],
      ${model.code?uncap_first}Detail: {
        annexVOList: []
      }
    }
  },
  computed: {
    canEdit() {
      return true
    },
    ...mapGetters('account', ['userInfo'])
  },
  components: {
    AModal: Modal,
    AUpload: Upload,
    AnnexPreview
  },
  methods: {
    open(id) {
      get${model.code}Detail(id).then(res => {
        this.show = true
        res.createAt = moment(res.createAt).format('YYYY-MM-DD HH:mm')
        if (!res.annexVOList) {
          res.annexVOList = []
        }
        this.${model.code?uncap_first}Detail = res
      })
    },
    editMeeting() {
      // 编辑时关闭详情
      this.show = false
      this.$emit('update', this.${model.code?uncap_first}Detail.id)
    }
  }
}
</script>
<style lang="scss" scoped>
.row-detail {
  margin-bottom: 10px;
  span {
    font-size: 16px;
  }
}
/* IE浏览器下 ”~“ 偏上显示 */
.symbol {
  font-family: Arial, Helvetica, sans-serif;
}
</style>
