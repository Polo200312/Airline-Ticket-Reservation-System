<template>
  <div class="prompt-component">
    <el-card>
      <div slot="header" class="prompt-header">
        {{ title }}
      </div>
      <div class="prompt-content">
        <p>
          <el-icon><info-filled /></el-icon>{{ promptText }}
        </p>
        <el-image
          v-if="imageSrc"
          :src="imageSrc"
          fit="cover"
          class="prompt-image"
        ></el-image>
      </div>
    </el-card>
  </div>
</template>

<script lang="ts">
import { defineComponent } from "vue";
import {
  type OptionItem,
  type ClientItem,
  type RouteResponse,
  type TariffItem,
} from "~/models/general";
import { getAuthHeader } from "~/services/genServ";
import { message } from "~/tools/messageBox";
import 'cropperjs/dist/cropper.css'; // 引入 Cropper.js 的样式文件
import VueCropper from 'cropperjs';
import Cropper from "cropperjs";
import {
  ElDatePicker,
  ElSelect,
  ElOption,
  ElButton,
  ElRadio,
  ElRadioGroup,
  ElForm,
  ElFormItem,
  ElInput,
  ElCard,
  ElRow,
  ElCol,
  ElImage,
} from "element-plus";
import router from '~/router';
import { InfoFilled } from '@element-plus/icons-vue';

export default defineComponent({
  components: {
    ElDatePicker,
    ElSelect,
    ElOption,
    ElButton,
    ElRadio,
    ElRadioGroup,
    ElForm,
    ElFormItem,
    ElInput,
    ElCard,
    ElRow,
    ElCol,
    ElImage,
    InfoFilled,
  },
  props: {
    title: {
      type: String,
      required: true
    },
    promptText: {
      type: String,
      required: true
    },
    imageSrc: {
      type: String,
      required: true
    },
  },

});
</script>

<style scoped>
.prompt-component {
  margin-top: 20px;
  max-width: 600px;
  margin: 20px auto;
  box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
  border-radius: 8px;
  overflow: hidden;
}

.prompt-header {
  font-size: 28px;
  font-weight: bold;
  padding: 15px 20px;
  background-color: #f0f0f0;
  border-bottom: 1px solid #ddd;
  border-radius: 20px; /* 添加圆角 */
}

.prompt-content {
  padding: 20px;
  background-color: #fff;
}

.prompt-content p {
  font-size: 18px;
  line-height: 1.8;
  color: #333;
}

.prompt-image {
  margin-top: 20px;
  border-radius: 4px;
  overflow: hidden;
}

.prompt-component:hover {
  box-shadow: 0 8px 16px rgba(0, 0, 0, 0.2);
  transform: translateY(-2px);
}

/* 按钮样式 */
.el-button {
  margin-top: 15px;
}
</style>
