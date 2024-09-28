<template>
  <div class="modal">
    <el-card id="box-card">
      <div slot="header" class="clearfix">
        <span id="title">航班改签查询</span>
      </div>

      <div class="box-box">
        <el-card class="box-card2">
          <el-row :gutter="20">
            <el-col :span="9"
              ><div class="city1">
                <label class="city-l">{{ startCity() }}</label>
                <div class="airport">{{ deal.departureAirport }}</div>
              </div></el-col
            >
            <el-col :span="6"
              ><div class="from">
                <label>=========></label>
              </div></el-col
            >
            <el-col :span="9"
              ><div class="city1">
                <label class="city-l">{{ endCity() }}</label>
                <div class="airport">{{ deal.arrivalAirport }}</div>
              </div></el-col
            >
          </el-row>
        </el-card>
        <div class="block">
          <span class="demonstration">出发日期 : </span>
          <el-date-picker
            v-model="selectedDate"
            type="date"
            placeholder="请选择出发日期"
            format="YYYY-MM-DD"
            value-format="YYYY-MM-DD"
            :picker-options="pickerOptions"
            :disabled-date="disabledDate"
          >
          </el-date-picker>
        </div>
        <div class="button-container">
          <el-button class="searchButton" type="info" @click="searchHandler(deal)"
            >查询</el-button
          >
          <el-button class="cancel-ticket-button" type="primary" @click="back()"
            >返回</el-button
          >
        </div>
      </div>
    </el-card>
  </div>
</template>

<script lang="ts">
import { defineComponent } from "vue";
import {
  type OptionItem,
  type ClientItem,
  type DealItem,
} from "~/models/general";
import { getAuthHeader } from "~/services/genServ";
import {
  getDealById,
} from "~/services/infoServ";
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
} from "element-plus";

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
  },
  data: () => ({
      dealId:null as number | null,
      deal: {} as DealItem,
      pickerOptions: {
        disabledDate(time: Date) {
          return time.getTime() < Date.now() - 8.64e7;
        },
      },
      selectedDate: '',
  }),
  async created() {
    const dealIdStr = this.$route.query.dealId as string;
    this.dealId = Number(dealIdStr);
    const res = await getDealById(this.dealId);
    this.deal = res.data.info;
  },
  methods:{
    back(){
      this.$router.back();
    },
    searchHandler(deal : DealItem) {
      this.$router.push({path: '/ChangeAnyPlane', query: {dealId : deal.dealId, startCity : this.deal.startCity, endCity : this.deal.endCity, selectedDay : this.selectedDate}});
    },
    startCity(): string {
        return this.deal.startCity;
    },
    endCity(): string {
        return this.deal.endCity;
    },
    getThisDeal(): DealItem {
        return this.deal;
    },
    disabledDate(time: Date) {
      return time.getTime() < Date.now() - 8.64e7 || time.getTime() > Date.now() + 24 * 60 * 60 * 1000 * 30;
    },
  },
});
</script>

<style scoped>
.modal {
  padding: 20px;
  border: 1px solid #ccc;
  border-radius: 5px;
  background-color: #fff;
  max-width: 1600px; /* 根据实际需要调整宽度 */
  margin: 20px auto;
  box-shadow: 0 0 10px rgba(0, 0, 0, 0.1); /* 添加阴影效果 */
}

.modal h2 {
  margin-bottom: 15px;
  font-size: 24px; /* 标题字体大小 */
  color: #333; /* 标题颜色 */
}

.clearfix:before,
.clearfix:after {
  display: table;
  content: "";
}
.clearfix:after {
  clear: both;
}

#box-card {
  width: auto;
  height: 498px;
}

#title {
  font-size: 40px;
}

.box-box {
  padding: 20px;
  background-color: #fff;
  border-radius: 8px;
  box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
}

.box-card2 {
  width: 580px;
  height: 270px;
  margin: auto;
}

.block {
  display: flex;
  align-items: center; /* 垂直对齐元素 */
  justify-content: center; /* 水平居中对齐 */
  gap: 10px; /* 调整文本与日期选择器之间的间距 */
  margin-top: 20px;
}

.button-container {
  margin-top: 20px;
  display: flex;
  justify-content: center; /* 水平居中对齐 */
  gap: 10px; /* 调整按钮之间的间距 */
}

.searchButton {
  background-color: cornflowerblue;
  color: #fff;
  border: none;
  padding: 12px 24px;
  border-radius: 5px;
  cursor: pointer;
  font-size: 16px;
  transition: background-color 0.3s ease; /* 添加过渡效果 */
}

.searchButton:hover {
  background-color: #b730ff;
}

.cancel-ticket-button {
  background-color: #ff6347;
  color: #fff;
  border: none;
  padding: 12px 24px;
  border-radius: 5px;
  cursor: pointer;
  font-size: 16px;
  transition: background-color 0.3s ease; /* 添加过渡效果 */
}

.cancel-ticket-button:hover {
  background-color: #f81408;
}

.demonstration {
  font-size: 16px; /* 设置字体大小 */
  color: #333; /* 设置字体颜色 */
  font-weight: bold; /* 设置字体加粗 */
  margin-right: 15px; /* 设置右边距，确保与 date-picker 有一定间距 */
}

#search {
  float: right;
  margin-left: 100px;
}

.city1 {
  /*background-color: #B3C0D1;*/
  font-size: 50px;
  text-align: center;
  width: 200px;
  height: 120px;
  padding-top: 40%;
}

.airport {
  max-width: 100%;
  font-size: 0.25em;
  color: #666;
}

.city-l {
  display: inline-block;
  height: 100px;
}
.from {
  /*background-color: antiquewhite;*/
  text-align: center;
  height: 120px;
  padding-top: 82%;
}

.ipt {
  padding-left: 10px;
  width: 150px;
}
</style>
