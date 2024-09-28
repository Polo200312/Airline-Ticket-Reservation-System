<template>
  <div class="edit-client">
    <el-card class="box-card">
      <div slot="header" class="clearfix">
        <span
          ><el-icon><Checked /></el-icon>请填写机场信息</span
        >
      </div>
      <el-form ref="flightForm" label-width="120px" class="new-client-form">
        <el-form-item label="城市名称">
          <el-input v-model="airportName" placeholder="请输入机场名称"></el-input>
        </el-form-item>
        <el-form-item label="所属城市">
          <el-input v-model="cityName" placeholder="请输入所属城市"></el-input>
        </el-form-item>
        <el-form-item label="纬度">
          <el-input v-model="airportX" placeholder="请输入纬度"></el-input>
        </el-form-item>
        <el-form-item label="经度">
          <el-input v-model="airportY" placeholder="请输入经度"></el-input>
        </el-form-item>
        <el-form-item label="运营状态">
          <el-select v-model="airportStatus" placeholder="请选择运营状态">
            <el-option label="正常运营" value="正常运营"></el-option>
            <el-option label="即将停止运营" value="即将停止运营"></el-option>
          </el-select>
        </el-form-item>
        <el-form-item label="机场简介">
          <el-input
            v-model="airportIntroduction"
            placeholder="请输入机场简介"
            type="textarea"
            :rows="5"
            autosize
            maxlength="1000"
            show-word-limit
          ></el-input>
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
  type AirportItem,
} from "~/models/general";
import { getAuthHeader } from "~/services/genServ";
import {
  addAirport,
} from "~/services/infoServ";
import { message } from "~/tools/messageBox";
import 'cropperjs/dist/cropper.css'; // 引入 Cropper.js 的样式文件
import VueCropper from 'cropperjs';
import Cropper from "cropperjs";
import {Male, Female, Checked} from '@element-plus/icons-vue'

export default defineComponent({
  data: () => ({
    airportName: "" as string,
    cityName: "" as string,
    airportIntroduction: "" as string,
    airportX: 0 as number,
    airportY: 0 as number,
    airportStatus: "" as string,
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
      if (this.airportName == "" || this.airportName == undefined) {
        message(this, "国家名称为空,请填写！");
        return;
      }
      if (this.cityName == "" || this.cityName == undefined) {
        message(this, "所属城市为空,请填写！");
        return;
      }
      if (this.airportIntroduction == "" || this.airportIntroduction == undefined) {
        message(this, "机场简介为空,请填写！");
        return;
      }
      if (this.airportStatus == "" || this.airportStatus == undefined) {
        message(this, "机场状态为空,请填写！");
        return;
      }
      if (this.airportX == undefined) {
        message(this, "纬度为空,请填写！");
        return;
      }
      if (this.airportY == undefined) {
        message(this, "经度为空,请填写！");
        return;
      }
      let res= await addAirport({
        airportName: this.airportName,
        cityName: this.cityName,
        airportIntroduction: this.airportIntroduction,
        airportStatus: this.airportStatus,
        airportX: this.airportX,
        airportY: this.airportY,
      });
      if (res.code != 0) {
        message(this, res.msg);
        return;
      } else {
        message(this, "添加机场信息成功！");
        this.airportName = "";
        this.cityName = "",
        this.airportIntroduction = "",
        this.airportStatus = "",
        this.airportX = 0,
        this.airportY = 0,
        this.query();
      }
    },

    resetForm() {
      // 重置表单
      this.airportName = "";
      this.cityName = "",
      this.airportIntroduction = "",
      this.airportStatus = "",
      this.airportX = 0,
      this.airportY = 0,
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
  margin-top: -300px;
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
