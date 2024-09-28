<template>
  <div class="edit-flight">
    <el-card class="box-card">
      <div slot="header" class="clearfix">
        <span>编辑航班信息</span>
      </div>
      <el-form ref="flightForm" label-width="120px" class="new-flight-form">
        <el-form-item label="航班名称">
          <el-input v-model="planeName" placeholder="请输入航班名称"></el-input>
        </el-form-item>
        <el-form-item label="航空公司">
          <el-input v-model="airlineCompanyName" placeholder="请输入航空公司名"></el-input>
        </el-form-item>
        <el-form-item label="起飞机场">
          <el-input v-model="departureAirport" placeholder="请输入起飞机场"></el-input>
        </el-form-item>
        <el-form-item label="到达机场">
          <el-input v-model="arrivalAirport" placeholder="请输入到达机场"></el-input>
        </el-form-item>
        <el-form-item label="起始城市">
          <el-input v-model="startCity" placeholder="请输入起始城市"></el-input>
        </el-form-item>
        <el-form-item label="终点城市">
          <el-input v-model="endCity" placeholder="请输入终点城市"></el-input>
        </el-form-item>
        <el-form-item label="起飞日期">
          <el-date-picker
            v-model="startDay"
            type="date"
            placeholder="选择日期"
            :disabled-date="disabledDate"
          ></el-date-picker>
        </el-form-item>
        <el-form-item label="到达日期">
          <el-date-picker
           v-model="endDay"
           type="date"
           placeholder="选择日期"
           :disabled-date="disabledDate"
          ></el-date-picker>
       </el-form-item>
       <el-form-item label="起飞时间">
          <el-time-picker
            v-model="startTime"
            format="HH:mm:ss"
            value-format="HH:mm:ss"
            placeholder="选择时间"
          ></el-time-picker>
        </el-form-item>
        <el-form-item label="到达时间">
          <el-time-picker
            v-model="endTime"
            format="HH:mm:ss"
            value-format="HH:mm:ss"
            placeholder="选择时间"
          ></el-time-picker>
        </el-form-item>
        <el-form-item label="总座位数">
          <el-input
            v-model="number_all"
            placeholder="请输入总座位数"
            type="number"
            :min="1"
          ></el-input>
        </el-form-item>
        <el-form-item label="剩余座位数">
          <el-input
            v-model="number_rest"
            placeholder="请输入剩余座位数"
            type="number"
            :min="0"
          ></el-input>
        </el-form-item>
        <el-form-item
          v-for="(service, index) in serviceList"
          :key="index"
          :label="`服务类型 ${index + 1}`"
        >
          <el-row>
            <el-col :span="9">
              <el-input
                v-model="service.type"
                :placeholder="`服务类型 ${index + 1} 的类型`"
              ></el-input>
            </el-col>
            <el-col :span="5">
              <el-input
                v-model="service.price"
                :placeholder="`价格`"
                type="number"
              ></el-input>
            </el-col>
            <el-col :span="10">
              <el-input
                v-model="service.description"
                :placeholder="`服务类型 ${index + 1} 的描述`"
                clearable: true
              ></el-input>
            </el-col>
          </el-row>
        </el-form-item>

        <!-- 添加/删除服务类型的按钮 -->
        <el-form-item>
          <el-button type="primary" @click="addService()">添加服务类型</el-button>
          <el-button type="danger" @click="removeService()" v-if="serviceList.length > 1"
           >删除最后一个服务类型</el-button
          >
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
  ElDatePicker,
  ElOption,
  ElInputNumber,
  ElMenu, ElSubMenu, ElMenuItemGroup, ElMenuItem, ElDialog,
} from "element-plus";
import {
  type TariffItem,
  type AirlineCompanyItem,
  type PlaneItem,
} from "~/models/general";
import { getAuthHeader } from "~/services/genServ";
import {
  changePlaneSave,
  getTariffList,
  getAirlineCompanyIntroduceData,
  getPlaneByName,
} from "~/services/infoServ";
import { message } from "~/tools/messageBox";
import 'cropperjs/dist/cropper.css'; // 引入 Cropper.js 的样式文件
import VueCropper from 'cropperjs';
import Cropper from "cropperjs";
import { type SpotItem } from '~/models/general';

export default defineComponent({
  data: () => ({
    info: {} as AirlineCompanyItem,
    airlineCompanyId: null as number | null,
    planeId: 0 as number,
    planeName: "" as string,
    airlineCompanyName: "" as string,
    arrivalAirport: "" as string,
    departureAirport: "" as string,
    startCity: "" as string,
    endCity: "" as string,
    startDay: "" as string,
    endDay: "" as string,
    startTime: "" as string,
    endTime: "" as string,
    number_all: 0 as number,
    number_rest: 0 as number,
    serviceList: [] as TariffItem[],
    flight: {} as PlaneItem,
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
  },
  async created(){
    this.query();
  },
  methods: {
    async query() {
      const planeIdStr = this.$route.query.planeId as string;
      this.planeId = Number(planeIdStr);
      this.planeName = this.$route.query.planeName as string;
      let res = await getAirlineCompanyIntroduceData(this.airlineCompanyId);
      this.info = res.data.info;
      this.airlineCompanyId = this.info.airlineCompanyId;
      this.airlineCompanyName = this.info.name;
      this.getTariffList(this.planeId);
      res = await getPlaneByName(this.planeName);
      this.flight = res.data.info;
      this.departureAirport = this.flight.departureAirport;
      this.arrivalAirport = this.flight.arrivalAirport;
      this.startDay = this.flight.startDay;
      this.endDay = this.flight.endDay;
      this.startTime = this.flight.startTime;
      this.endTime = this.flight.endTime;
      this.startCity = this.flight.startCity;
      this.endCity = this.flight.endCity;
      this.number_all = this.flight.number_all;
      this.number_rest = this.flight.number_rest;
    },
    async getTariffList(planeId: number){
      let res = await getTariffList(planeId);
      this.serviceList = res.data;
      console.log(this.serviceList);
    },
    async submitForm() {
      // 提交表单的逻辑，这里可以发送请求将数据提交到后端
      let ids = this.serviceList.map(service => service.tariffId);
      let types = this.serviceList.map(service => service.type);
      let prices = this.serviceList.map(service => service.price);
      let descriptions = this.serviceList.map(service => service.description);
      if (this.planeName == "" || this.planeName == undefined) {
        message(this, "航班名称为空,请填写！");
        return;
      }
      if (this.startCity == "" || this.startCity == undefined) {
        message(this, "起始城市为空,请填写！");
        return;
      }
      if (this.endCity == "" || this.endCity == undefined) {
        message(this, "终点城市为空,请填写！");
        return;
      }
      if (this.departureAirport == "" || this.departureAirport == undefined) {
        message(this, "起飞机场为空,请填写！");
        return;
      }
      if (this.arrivalAirport == "" || this.arrivalAirport == undefined) {
        message(this, "到达机场为空,请填写！");
        return;
      }
      if (this.startDay == "" || this.startDay == undefined) {
        message(this, "起飞日期为空,请填写！");
        return;
      }
      if (this.endDay == "" || this.endDay == undefined) {
        message(this, "到达日期为空,请填写！");
        return;
      }
      if (this.startTime == "" || this.startTime == undefined) {
        message(this, "起飞时间为空,请填写！");
        return;
      }
      if (this.endDay == "" || this.endDay == undefined) {
        message(this, "到达时间为空,请填写！");
        return;
      }
      if (types.length === 0) {
        message(this, "至少需要提供一种类型的服务！");
        return;
      }
      if (prices.length === 0) {
        message(this, "至少需要提供一种类型的服务价格！");
        return;
      }
      if (descriptions.length === 0) {
        message(this, "至少需要提供一种类型的服务描述！");
        return;
      }

      if (this.startCity === this.endCity) {
        message(this, "起降城市不能相同！");
        return;
      }
      if (this.departureAirport === this.arrivalAirport) {
        message(this, "起降机场不能相同！");
        return;
      }

      // 将选中的日期字符串转换为日期对象
      const dateObj1 = new Date(this.startDay);
      // 格式化选中的日期为 yyyy-MM-dd 格式
      const formattedDate1 = this.formatDate(dateObj1);

      const dateObj2 = new Date(this.endDay);

      const formattedDate2 = this.formatDate(dateObj2);

      // 将起飞和到达的日期、时间组合成完整的 Date 对象进行比较
      const startDateTime = new Date(`${formattedDate1}T${this.startTime}`);
      const endDateTime = new Date(`${formattedDate2}T${this.endTime}`);

      console.log(startDateTime);
      console.log(endDateTime);
      if (endDateTime <= startDateTime) {
        message(this, "到达时间必须晚于起飞时间！");
        return;
      }
      let res= await changePlaneSave({
        planeId: this.planeId,
        planeName: this.planeName,
        startCity: this.startCity,
        endCity: this.endCity,
        startTime: this.startTime,
        endTime: this.endTime,
        startDay: formattedDate1,
        endDay: formattedDate2,
        departureAirport: this.departureAirport,
        arrivalAirport: this.arrivalAirport,
        number_all: this.number_all,
        number_rest: this.number_rest,
        types: types,
        prices: prices,
        descriptions: descriptions,
        ids: ids,
      });
      if (res.code != 0) {
        message(this, res.msg);
        return;
      } else {
        message(this, "修改成功！");
        this.planeName = "";
        this.startCity = "";
        this.endCity = "";
        this.startTime = "";
        this.endTime = "";
        this.startDay = "";
        this.endDay = "";
        this.departureAirport = "";
        this.arrivalAirport = "";
        this.number_all = 0;
        this.number_rest = 0;
        this.serviceList = [] as TariffItem[];
        this.query();
      }
    },

    formatDate(date: Date) {
      if (!(date instanceof Date)) return '';
      const year = date.getFullYear();
      let month = '' + (date.getMonth() + 1);
      let day = '' + date.getDate();
      if (month.length < 2) month = '0' + month;
      if (day.length < 2) day = '0' + day;
      return [year, month, day].join('-');
    },

    resetForm() {
      // 重置表单
      this.info = {} as AirlineCompanyItem;
      this.airlineCompanyId = null as number | null;
      this.planeName = "" as string;
      this.airlineCompanyName = "" as string;
      this.arrivalAirport = "" as string;
      this.departureAirport = "" as string;
      this.startCity = "" as string;
      this.endCity = "" as string;
      this.startDay = "" as string;
      this.endDay = "" as string;
      this.startTime = "" as string;
      this.endTime = "" as string;
      this.number_all = 0 as number;
      this.number_rest = 0 as number;
      this.serviceList = [] as TariffItem[];
      this.query();
    },
    back() {
      this.$router.back();
    },
    // 添加/删除服务类型的方法
    addService() {
      this.serviceList.push({ tariffId: -1, planeId: this.planeId, type: '', price: 0, description: '' });
    },
    disabledDate(time: Date) {
      return time.getTime() < Date.now() || time.getTime() > Date.now() + 24 * 60 * 60 * 1000 * 60;
    },
    removeService() {
      this.serviceList.pop();
    },
  },
});
</script>

<style scoped>
.edit-flight {
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

.new-flight-form {
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
