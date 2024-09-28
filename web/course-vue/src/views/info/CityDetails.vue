<template>
  <div class="user-details">
    <el-card class="box-card">
      <div slot="header" class="header-section clearfix">
        <span class="header-title"
          ><el-icon><View /></el-icon>{{ info.cityName }} - 详情</span
        >
        <div class="button-group">
          <el-button class="edit-button" type="primary" size="default" @click="editCity">
            <el-icon><edit-pen /></el-icon>编辑城市信息
          </el-button>
          <el-button class="back-button" @click="back"
            ><el-icon><refresh-left /></el-icon>返回</el-button
          >
        </div>
      </div>
      <div>
        <el-form label-width="120px" class="flight-info-form">
          <el-form-item label="城市ID">
            <span>{{ info.cityId }}</span>
          </el-form-item>
          <el-form-item label="城市名称">
            <span>{{ info.cityName }}</span>
          </el-form-item>
          <el-form-item label="所属国家">
            <span>{{ info.nationName }}</span>
          </el-form-item>
          <el-form-item label="时区">
            <span>{{ info.timeZone }}</span>
          </el-form-item>
          <el-form-item label="纬度">
            <span>{{ info.cityX }}</span>
          </el-form-item>
          <el-form-item label="经度">
            <span>{{ info.cityY }}</span>
          </el-form-item>
          <el-form-item label="搜索次数">
            <span>{{ info.searchTimes }}</span>
          </el-form-item>
        </el-form>
      </div>
    </el-card>
  </div>
</template>

<script lang="ts">
import { defineComponent } from "vue";
import {
  ElSelect,
  ElButton,
  ElForm,
  ElFormItem,
  ElInput,
  ElCard,
  ElRow,
  ElCol,
  ElImage,
  ElTable,
} from "element-plus";
import {
  type OptionItem,
  type CityItem,
} from "~/models/general";
import { getAuthHeader } from "~/services/genServ";
import {
  getCityInfo,
} from "~/services/infoServ";
import { message } from "~/tools/messageBox";
import 'cropperjs/dist/cropper.css'; // 引入 Cropper.js 的样式文件
import VueCropper from 'cropperjs';
import Cropper from "cropperjs";
import {View, EditPen, CirclePlus, RefreshLeft,} from '@element-plus/icons-vue'

export default defineComponent({
  components: {
    ElTable,
    ElImage,
    ElSelect,
    ElButton,
    ElForm,
    ElFormItem,
    ElInput,
    ElCard,
    ElRow,
    ElCol,
    View,
    EditPen,
    CirclePlus,
    RefreshLeft,
  },
  data: () => ({
    info: {} as CityItem,
    cityId: null as number | null,
  }),
  created() {
    this.query();
  },
  methods: {
    async query() {
      const cityIdStr = this.$route.query.cityId as string;
      this.cityId = Number(cityIdStr);
      let res = await getCityInfo(this.cityId);
      this.info = res.data.info;
      console.log(this.info);
    },
    editCity() {
      this.$router.push({ path: '/EditCity', query: { cityId: this.info.cityId, cityName: this.info.cityName } });
    },
    back(){
      this.$router.back();
    },
  },

});
</script>

<style scoped>
.user-details {
  margin-top: 10px;
  display: flex;
  justify-content: center;
  align-items: center;
  min-height: 100vh;
  background-color: #f5f7fa;
  padding: 20px;
}

.box-card {
  max-width: 800px;
  width: 100%;
  padding: 20px;
  margin-top: -200px;
  background-color: #fff;
  border-radius: 10px;
  box-shadow: 0 4px 12px rgba(0, 0, 0, 0.1);
}

.flight-info-form {
  border: 1px solid #dcdfe6;
  border-radius: 8px;
  padding: 15px;
  background-color: #fff;
}

.el-form-item {
  margin-bottom: 20px;
}

.el-form-item span {
  font-weight: 500;
  color: #606266;
}

.el-form-item::after {
  content: "";
  display: block;
  clear: both;
}

.el-form-item label {
  font-size: 1.2em;
  font-weight: bold;
  color: #409eff;
}

.flight-info-form .el-form-item:last-child {
  margin-bottom: 0;
}

.el-card__header {
  font-size: 20px;
  font-weight: 700;
  color: #333;
  padding: 0 10px;
  border-bottom: 1px solid #ebeef5;
  position: relative;
}

.el-card__header span {
  vertical-align: middle;
}

.el-button {
  border-radius: 6px;
}

.el-button-primary {
  background-color: #409eff;
  border-color: #409eff;
}

.el-button-primary:hover {
  background-color: #66b1ff;
  border-color: #66b1ff;
}

.header-section {
  display: flex;
  align-items: center;
  justify-content: space-between;
  padding: 10px 20px;
  background-color: #f5f5f5;
  border-bottom: 1px solid #dcdcdc;
  border-radius: 5px 5px 0 0;
}

.header-title {
  font-size: 20px;
  font-weight: bold;
  color: #333;
}

.button-group {
  display: flex;
  gap: 10px;
}

.edit-button {
  background-color: #409eff;
  border-color: #409eff;
  color: white;
  border-radius: 5px;
  transition: all 0.3s ease;
}

.edit-button:hover {
  background-color: #66b1ff;
  border-color: #66b1ff;
}

.back-button {
  background-color: #909399;
  border-color: #909399;
  color: white;
  border-radius: 5px;
  transition: all 0.3s ease;
}

.back-button:hover {
  background-color: #e63c0d;
  border-color: #a6a9ad;
}
</style>
