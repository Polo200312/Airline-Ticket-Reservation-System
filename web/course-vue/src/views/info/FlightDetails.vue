<template>
  <div class="flight-details">
    <el-card class="box-card">
      <div slot="header" class="header-section clearfix">
        <span class="header-title">{{ flight.planeName }} - 详情</span>
        <div class="button-group">
          <el-button
            class="edit-button"
            type="primary"
            size="default"
            @click="editFlight"
          >
            编辑航班信息
          </el-button>
          <el-button
            class="delete-button"
            type="warning"
            size="default"
            @click="deleteFlight"
          >
            <el-icon><circle-close /></el-icon>删除航班
          </el-button>
          <el-button class="back-button" @click="back">返回</el-button>
        </div>
      </div>
      <div>
        <el-form label-width="120px" class="flight-info-form">
          <el-form-item label="航班ID">
            <span>{{ flight.planeId }}</span>
          </el-form-item>
          <el-form-item label="航空公司">
            <span>{{ flight.airlineCompanyName }}</span>
          </el-form-item>
          <el-form-item label="起飞机场">
            <span>{{ flight.departureAirport }}</span>
          </el-form-item>
          <el-form-item label="到达机场">
            <span>{{ flight.arrivalAirport }}</span>
          </el-form-item>
          <el-form-item label="起始城市">
            <span>{{ flight.startCity }}</span>
          </el-form-item>
          <el-form-item label="终点城市">
            <span>{{ flight.endCity }}</span>
          </el-form-item>
          <el-form-item label="起飞日期">
            <span>{{ flight.startDay }}</span>
          </el-form-item>
          <el-form-item label="起飞时间">
            <span>{{ flight.startTime }}</span>
          </el-form-item>
          <el-form-item label="到达日期">
            <span>{{ flight.endDay }}</span>
          </el-form-item>
          <el-form-item label="到达时间">
            <span>{{ flight.endTime }}</span>
          </el-form-item>
          <el-form-item label="总座位数">
            <span>{{ flight.number_all }}</span>
          </el-form-item>
          <el-form-item label="剩余座位数">
            <span>{{ flight.number_rest }}</span>
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
  type AirlineCompanyItem,
  type PlaneItem,
} from "~/models/general";
import { getAuthHeader } from "~/services/genServ";
import {
  deletePlane,
  getPlaneByName,
  getAirlineCompanyIntroduceData,
} from "~/services/infoServ";
import { message } from "~/tools/messageBox";
import 'cropperjs/dist/cropper.css'; // 引入 Cropper.js 的样式文件
import VueCropper from 'cropperjs';
import Cropper from "cropperjs";
import { type SpotItem } from '~/models/general';

export default defineComponent({
  name: "FlightDetails",
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
  },
  data: () => ({
    info: {} as AirlineCompanyItem,
    airlineCompanyId: null as number | null,
    planeName: "" as string,
    searchQuery: "" as string,
    flight: {} as PlaneItem,
  }),
  created() {
    this.query();
  },
  methods: {
    async query() {
      this.planeName = this.$route.query.planeName as string;
      let res = await getAirlineCompanyIntroduceData(this.airlineCompanyId);
      this.info = res.data.info;
      this.airlineCompanyId = this.info.airlineCompanyId;
      res = await getPlaneByName(this.planeName);
      this.flight = res.data.info;
    },
    editFlight() {
      this.$router.push({ path: '/EditFlight', query: { planeId: this.flight.planeId, planeName: this.flight.planeName } });
    },
    async deleteFlight() {
        let res = await deletePlane(this.flight.planeId);
        if (res.code != 0) {
        message(this, res.msg);
        return;
      } else {
        message(this, "删除成功！");
        this.$router.push({path:'/FlightsManagement'});
      }
    },
    back(){
      this.$router.back();
    },
  },

});
</script>

<style scoped>
.flight-details {
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
