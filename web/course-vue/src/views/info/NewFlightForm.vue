<template>
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
      v-for="(service, index) in services"
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
      <el-button type="primary" @click="addService()"><el-icon><plus /></el-icon>添加服务类型</el-button>
      <el-button type="danger" @click="removeService()" v-if="services.length > 1"
        ><el-icon><minus /></el-icon>删除最后一个服务类型</el-button
      >
    </el-form-item>

    <el-form-item>
      <el-button type="primary" @click="submitForm()"><el-icon><upload /></el-icon>提交</el-button>
      <el-button @click="resetForm()"><el-icon><refresh-left /></el-icon>重置</el-button>
      <el-button @click="back()"><el-icon><refresh /></el-icon>返回</el-button>
    </el-form-item>
  </el-form>
</template>

<script lang="ts">
import { defineComponent } from "vue";
import {
  type OptionItem,
  type AirlineCompanyItem,
} from "~/models/general";
import { getAuthHeader } from "~/services/genServ";
import {
  getDealById,
  getTravelOptions,
  getCityById,
  getAirlineCompanyIntroduceData,
  addPlane,
} from "~/services/infoServ";
import { message } from "~/tools/messageBox";
import 'cropperjs/dist/cropper.css'; // 引入 Cropper.js 的样式文件
import VueCropper from 'cropperjs';
import Cropper from "cropperjs";
import { ElMenu, ElSubMenu, ElMenuItemGroup, ElMenuItem, ElDialog, ElButton, ElForm, ElFormItem, ElInput } from 'element-plus';
import 'element-plus/theme-chalk/el-input.css'; // 根据你的主题选择正确的样式文件路径
import 'element-plus/theme-chalk/el-form-item.css'; // 同样根据主题选择正确的样式文件路径
import 'element-plus/theme-chalk/el-form.css';
import {Plus, Minus, Upload, Refresh, RefreshLeft,} from '@element-plus/icons-vue'

export default defineComponent({
  data: () => ({
    info: {} as AirlineCompanyItem,
    airlineCompanyId: null as number | null,
    planeName: "" as string,
    planeStatus: "可正常购票/退票" as string,
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
    services: [{ type: '' as string, price: '' as number | string , description: '' as string}], // 初始至少有一个服务类型
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
    Plus, 
    Minus,
    Upload,
    Refresh,
    RefreshLeft
  },
  created(){
    this.query();
  },
  methods: {
    async query(){
      let res = await getAirlineCompanyIntroduceData(this.airlineCompanyId);
      this.info = res.data.info;
      this.airlineCompanyId = this.info.airlineCompanyId;
      this.airlineCompanyName = this.info.name;
    },
    async submitForm() {
      // 提交表单的逻辑，这里可以发送请求将数据提交到后端
      let types = this.services.map(service => service.type);
      let prices = this.services.map(service => service.price);
      let descriptions = this.services.map(service => service.description);
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

      let res= await addPlane({
        airlineCompanyId: this.airlineCompanyId,
        planeName: this.planeName,
        planeStatus: this.planeStatus,
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
      });
      if (res.code != 0) {
        message(this, res.msg);
        return;
      } else {
        message(this, "添加成功！");
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
        this.services = [{ type: '' as string, price: '' as number | string, description: '' as string}];
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
      this.planeStatus = "可正常购票/退票" as string;
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
      this.services = [{ type: '' as string, price: '' as number | string , description: '' as string}];
      this.query();
    },
    back() {
      this.$router.back();
    },
    // 添加/删除服务类型的方法
    addService() {
      this.services.push({ type: '', price: 0, description: '' });
    },
    disabledDate(time: Date) {
      return time.getTime() < Date.now() || time.getTime() > Date.now() + 24 * 60 * 60 * 1000 * 60;
    },
    removeService() {
      this.services.pop();
    },
  },
});
</script>

<style scoped>
.new-flight-form {
  max-width: 500px;
  margin: auto;
  padding: 20px;
}
</style>
