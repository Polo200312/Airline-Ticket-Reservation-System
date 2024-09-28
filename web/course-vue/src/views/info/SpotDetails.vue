<template>
  <div class="user-details">
    <el-card class="box-card">
      <div slot="header" class="header-section clearfix">
        <span class="header-title"
          ><el-icon><View /></el-icon>{{ info.name }} - 详情</span
        >
        <div class="button-group">
          <el-button class="edit-button" type="primary" size="default" @click="editSpot">
            <el-icon><edit-pen /></el-icon>编辑景点信息
          </el-button>
          <el-button
            class="delete-button"
            type="warning"
            size="default"
            @click="deleteSpot"
          >
            <el-icon><circle-close /></el-icon>删除景点
          </el-button>
          <el-button class="back-button" @click="back"
            ><el-icon><refresh-left /></el-icon>返回</el-button
          >
        </div>
      </div>
      <div>
        <el-form label-width="120px" class="flight-info-form">
          <el-form-item label="景点ID">
            <span>{{ info.spotId }}</span>
          </el-form-item>
          <el-form-item label="景点名称">
            <span>{{ info.name }}</span>
          </el-form-item>
          <el-form-item label="所在城市">
            <span>{{ info.cityName }}</span>
          </el-form-item>
          <el-form-item label="景点类型">
            <span>{{ info.category }}</span>
          </el-form-item>
          <el-form-item label="星级">
            <span>{{ info.rating }}</span>
          </el-form-item>
          <el-form-item label="位置">
            <span>{{ info.location }}</span>
          </el-form-item>
          <el-form-item label="开放时间">
            <span>{{ info.openingHours }}</span>
          </el-form-item>
          <el-form-item label="票价（￥/位）">
            <span>{{ info.ticketPrice }}</span>
          </el-form-item>
          <el-form-item label="景点描述">
            <span>{{ info.description }}</span>
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
  type SpotItem,
} from "~/models/general";
import { getAuthHeader } from "~/services/genServ";
import {
  getSpotInfo,
  deleteSpot,
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
    info: {} as SpotItem,
    spotId: null as number | null,
  }),
  created() {
    this.query();
  },
  methods: {
    async query() {
      const spotIdStr = this.$route.query.spotId as string;
      this.spotId = Number(spotIdStr);
      let res = await getSpotInfo(this.spotId);
      this.info = res.data.info;
      console.log(this.info);
    },
    editSpot() {
      this.$router.push({ path: '/EditSpot', query: { spotId: this.info.spotId, spotName: this.info.name } });
    },
    async deleteSpot() {
      let res = await deleteSpot(this.spotId);
      if (res.code == 0){
        message(this, `删除成功！`);
        this.$router.back();
      }
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
  margin-top: -5px;
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
