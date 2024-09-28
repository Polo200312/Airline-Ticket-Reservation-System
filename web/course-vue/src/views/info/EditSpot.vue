<template>
  <div class="edit-client">
    <el-card class="box-card">
      <div slot="header" class="clearfix">
        <span
          ><el-icon><Checked /></el-icon>编辑景点信息</span
        >
      </div>
      <el-form ref="flightForm" label-width="120px" class="new-client-form">
        <el-form-item label="景点名称">
          <el-input v-model="name" placeholder="请输入机场名称"></el-input>
        </el-form-item>
        <el-form-item label="所属城市">
          <el-input v-model="cityName" placeholder="请输入所属城市"></el-input>
        </el-form-item>
        <el-form-item label="星级">
          <el-rate
            v-model="rating"
            allow-half
            clearable
            :texts="['0', '0.5', '1', '1.5', '2', '2.5', '3', '3.5', '4', '4.5']"
          ></el-rate>
        </el-form-item>
        <el-form-item label="景点类型">
          <el-input v-model="category" placeholder="请输入景点类型"></el-input>
        </el-form-item>
        <el-form-item label="位置">
          <el-input v-model="location" placeholder="请输入位置"></el-input>
        </el-form-item>
        <el-form-item label="开放时间">
          <el-input v-model="openingHours" placeholder="请输入开放时间"></el-input>
        </el-form-item>
        <el-form-item label="票价（￥/位）">
          <el-input v-model="ticketPrice" placeholder="请输入票价（￥/位）"></el-input>
        </el-form-item>
        <el-form-item label="景点描述">
          <el-input
            type="textarea"
            :rows="5"
            autosize
            maxlength="1000"
            show-word-limit
            v-model="description"
            placeholder="景点描述"
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
  type SpotItem,
} from "~/models/general";
import { getAuthHeader } from "~/services/genServ";
import {
  changeSpotSave,
  getSpotInfo,
} from "~/services/infoServ";
import { message } from "~/tools/messageBox";
import 'cropperjs/dist/cropper.css'; // 引入 Cropper.js 的样式文件
import VueCropper from 'cropperjs';
import Cropper from "cropperjs";
import {Male, Female, Checked} from '@element-plus/icons-vue'

export default defineComponent({
  data: () => ({
    info: {} as SpotItem,
    spotId: 0 as number,
    name: "" as string,
    category: "" as string,
    rating: 5 as number,
    location: "" as string,
    openingHours: "" as string,
    ticketPrice: "" as string,
    description: "" as string,
    cityName: "" as string,
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
      const spotIdStr = this.$route.query.spotId as string;
      this.spotId = Number(spotIdStr);
      this.name = this.$route.query.spotName as string;
      let res = await getSpotInfo(this.spotId);
      this.info = res.data.info;
      this.name = this.info.name;
      this.category = this.info.category;
      this.rating = Number(this.info.rating);
      this.location = this.info.location;
      this.openingHours = this.info.openingHours;
      this.ticketPrice = this.info.ticketPrice;
      this.description = this.info.description;
      this.cityName = this.info.cityName;
    },
    async submitForm() {
      // 提交表单的逻辑，这里可以发送请求将数据提交到后端
      if (this.name == "" || this.name == undefined) {
        message(this, "景点名称为空,请填写！");
        return;
      }
      if (this.cityName == "" || this.cityName == undefined) {
        message(this, "所属城市为空,请填写！");
        return;
      }
      if (this.rating == undefined) {
        message(this, "星级为空,请填写！");
        return;
      }
      if (this.category == "" || this.category == undefined) {
        message(this, "景点类型为空,请填写！");
        return;
      }
      if (this.location == "" || this.location == undefined) {
        message(this, "位置为空,请填写！");
        return;
      }
      if (this.location == "" || this.location == undefined) {
        message(this, "位置为空,请填写！");
        return;
      }
      if (this.openingHours == "" || this.openingHours == undefined) {
        message(this, "开放时间为空,请填写！");
        return;
      }
      if (this.ticketPrice == "" || this.ticketPrice == undefined) {
        message(this, "票价为空,请填写！");
        return;
      }
      if (this.description == "" || this.description == undefined) {
        message(this, "描述为空,请填写！");
        return;
      }
      let res= await changeSpotSave({
        spotId: this.spotId,
        name: this.name,
        rating: this.rating.toString(),
        category: this.category,
        location: this.location,
        openingHours: this.openingHours,
        ticketPrice: this.ticketPrice,
        description: this.description,
        cityName: this.cityName,
      });
      if (res.code != 0) {
        message(this, res.msg);
        return;
      } else {
        message(this, "修改成功！");
        this.name = "";
        this.info = {} as SpotItem;
        this.category = "";
        this.rating = 5;
        this.location = "";
        this.openingHours = "";
        this.ticketPrice = "";
        this.description = "";
        this.cityName = "";
        this.query();
      }
    },

    resetForm() {
      // 重置表单
      this.name = "";
        this.info = {} as SpotItem;
        this.category = "";
        this.rating = 5;
        this.location = "";
        this.openingHours = "";
        this.ticketPrice = "";
        this.description = "";
        this.cityName = "";
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
  margin-top: -50px;
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
