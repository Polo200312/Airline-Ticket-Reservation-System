<template>
  <div class="edit-client">
    <el-card class="box-card">
      <div slot="header" class="clearfix">
        <span
          ><el-icon><Checked /></el-icon>请填写城市信息</span
        >
      </div>
      <el-form ref="flightForm" label-width="120px" class="new-client-form">
        <el-form-item label="城市名称">
          <el-input v-model="name" placeholder="请输入城市名称"></el-input>
        </el-form-item>
        <el-form-item label="所属国家">
          <el-input v-model="nationName" placeholder="请输入所属国家"></el-input>
        </el-form-item>
        <el-form-item label="时区">
          <el-input v-model="timeZone" placeholder="请输入时区"></el-input>
        </el-form-item>
        <el-form-item label="纬度">
          <el-input v-model="cityX" placeholder="请输入纬度"></el-input>
        </el-form-item>
        <el-form-item label="经度">
          <el-input v-model="cityY" placeholder="请输入经度"></el-input>
        </el-form-item>
        <el-form-item>
          <el-button type="primary" @click="submitForm()">提交</el-button>
          <el-button @click="resetForm()">重置</el-button>
          <el-button @click="back()">返回</el-button>
        </el-form-item>
      </el-form>
    </el-card>
  </div>
</template>

<script lang="ts">
import { defineComponent } from "vue";
import {
  ElButton,
  ElForm,
  ElFormItem,
  ElInput,
  ElCard,
  ElMenu, ElSubMenu, ElMenuItemGroup, ElMenuItem, ElDialog,
} from "element-plus";
import {
  type TariffItem,
  type CityItem,
} from "~/models/general";
import { getAuthHeader } from "~/services/genServ";
import {
  addCity,
  getCityInfo,
} from "~/services/infoServ";
import { message } from "~/tools/messageBox";
import 'cropperjs/dist/cropper.css'; // 引入 Cropper.js 的样式文件
import VueCropper from 'cropperjs';
import Cropper from "cropperjs";
import {Male, Female, Checked} from '@element-plus/icons-vue'

export default defineComponent({
  data: () => ({
    name: "" as string,
    nationName: "" as string,
    timeZone: "" as string,
    cityX: 0 as number,
    cityY: 0 as number,
  }),
  components: {
    ElMenu,
    ElSubMenu,
    ElMenuItemGroup,
    ElMenuItem,
    VueCropper,
    ElDialog,
    ElButton,
    ElInput,
    ElFormItem,
    ElForm,
    Male,
    Female,
    Checked,
  },
  async created(){
    this.query();
  },
  methods: {
    async query() {

    },
    async submitForm() {
      // 提交表单的逻辑，这里可以发送请求将数据提交到后端
      if (this.name == "" || this.name == undefined) {
        message(this, "国家名称为空,请填写！");
        return;
      }
      if (this.nationName == "" || this.nationName == undefined) {
        message(this, "所属国家为空,请填写！");
        return;
      }
      if (this.timeZone == "" || this.timeZone == undefined) {
        message(this, "时区为空,请填写！");
        return;
      }
      if (this.cityX == undefined) {
        message(this, "纬度为空,请填写！");
        return;
      }
      if (this.cityY == undefined) {
        message(this, "经度为空,请填写！");
        return;
      }
      let res= await addCity({
        name: this.name,
        nationName: this.nationName,
        timeZone: this.timeZone,
        cityX: this.cityX,
        cityY: this.cityY,
      });
      if (res.code != 0) {
        message(this, res.msg);
        return;
      } else {
        message(this, "添加城市信息成功！");
        this.name = "";
        this.name = "";
        this.nationName = "",
        this.timeZone = "",
        this.cityX = 0,
        this.cityY = 0,
        this.query();
      }
    },

    resetForm() {
      // 重置表单
      this.name = "";
      this.nationName = "",
      this.timeZone = "",
      this.cityX = 0,
      this.cityY = 0,
      this.query();
    },
    back() {
      this.$router.back();
    },
  },
});
</script>

<style scoped>
.edit-client {
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
  margin-top: -400px;
  background-color: #fff;
  border-radius: 10px;
  box-shadow: 0 4px 12px rgba(0, 0, 0, 0.1);
}

.new-client-form {
  margin-top: 20px;
}

.el-form-item {
  margin-bottom: 20px;
}

.el-form-item label {
  color: #333;
  font-weight: 600;
}

.el-input,
.el-date-picker,
.el-time-picker,
.el-select {
  width: 100%;
}

.el-input input {
  border-radius: 6px;
  padding: 10px;
  border: 1px solid #dcdfe6;
}

.el-button {
  margin-right: 10px;
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

.el-button-danger {
  background-color: #f56c6c;
  border-color: #f56c6c;
}

.el-button-danger:hover {
  background-color: #ff7878;
  border-color: #ff7878;
}

.el-card__header {
  font-size: 20px;
  font-weight: 700;
  color: #333;
  padding: 0 10px;
  border-bottom: 1px solid #ebeef5;
}

.el-row {
  margin-bottom: 10px;
}

.el-col {
  padding-right: 10px;
}

.el-col:last-child {
  padding-right: 0;
}

.el-form-item:last-child {
  margin-bottom: 0;
  text-align: right;
}
</style>
