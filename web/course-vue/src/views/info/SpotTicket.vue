<template>
  <div class="buy-ticket-page">
    <el-card class="box-card">
      <div slot="header" class="clearfix">
        <span
          ><el-icon><info-filled /></el-icon>为前往
          {{ spotName }} 购票（最多提前7天购票）</span
        >
      </div>

      <el-form ref="form" label-width="120px" class="form-container">
        <el-form-item label="购票数量">
          <el-input-number v-model="numberOfTickets" :min="1" :max="10"></el-input-number>
        </el-form-item>

        <el-form-item label="入场时间">
          <el-card class="date-selection-card">
            <div class="date-selection">
              <el-date-picker
                v-model="selectedDate"
                type="date"
                placeholder="请选择日期"
                :disabled-date="disabledDate"
              >
              </el-date-picker>
            </div>
          </el-card>
        </el-form-item>

        <el-form-item label="总票价">
          <span>{{ totalPrice() }} ￥</span>
        </el-form-item>

        <el-form-item>
          <el-button type="primary" @click="submitForm"
            ><el-icon><success-filled /></el-icon>确认</el-button
          >
          <el-button @click="resetForm"
            ><el-icon><refresh-left /></el-icon>重置</el-button
          >
        </el-form-item>
      </el-form>
    </el-card>
  </div>
</template>

<script lang="ts">
import { defineComponent } from "vue";
import {
  type OptionItem,
  type SpotItem,
} from "~/models/general";
import { getAuthHeader } from "~/services/genServ";
import {
  purchaseSpotTicket,
  getSpotData,
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
  ElImage,
  ElTable,
  ElPagination,
  ElCarousel,
  ElCarouselItem,
} from "element-plus";
import {SuccessFilled, RefreshLeft, InfoFilled,} from '@element-plus/icons-vue'

export default defineComponent({
  components: {
    ElTable,
    ElImage,
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
    ElPagination,
    ElCarousel,
    ElCarouselItem,
    SuccessFilled,
    RefreshLeft,
    InfoFilled,
  },
  data: () => ({
    spotName: "",
    spotId: null as number | null,
    spot : {} as SpotItem,
    value: 0 as number,
    numberOfTickets: 1 as number,
    selectedDate: '',
    ticketPrice: 0 as number,
  }),
  created(){
    this.query();
  },
  methods: {
    async query(){
      const spotIdStr = this.$route.query.spotId as string;
      this.spotId = Number(spotIdStr);
      this.spotName = this.$route.query.spotName as string;
      let res = await getSpotData(this.spotName);
      this.spot = res.data.info;
      this.value = this.extractPrice(this.spot.ticketPrice);
    },
    extractPrice(priceString: string): number {
      // 正则表达式提取数字部分
      const match = priceString.match(/(\d+(\.\d+)?)/);

      // 匹配成功
      if (match) {
        return parseFloat(match[0]);
      }

      // 没有找到数字，返回 NaN
      return NaN;
    },
    totalPrice(){
      return this.numberOfTickets * this.value;
    },
    async submitForm() {
      const dateObj = new Date(this.selectedDate);

      // 格式化选中的日期为 yyyy-MM-dd 格式
      const formattedDate = this.formatDate(dateObj);
      console.log(formattedDate);
        let res = await purchaseSpotTicket({
            dateString : formattedDate,
            value : this.value,
            spotName : this.spotName,
            numberOfTickets : this.numberOfTickets,
        });
        if(res.code != 0){
          message(this, res.msg);
          return;
        }else{
          message(this, "购票成功！");
          this.resetForm();
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
      this.spotName = "",
      this.spotId = null as number | null,
      this.spot = {} as SpotItem,
      this.value = 0 as number,
      this.numberOfTickets = 1 as number,
      this.selectedDate = ''
      this.query();
    },
    disabledDate(time: Date) {
      return time.getTime() < Date.now() - 8.64e7 || time.getTime() > Date.now() + 24 * 60 * 60 * 1000 * 7;
    },
  },
});
</script>

<style scoped>
.buy-ticket-page {
  max-width: 600px;
  margin: 50px auto;
}

.form-container {
  margin-top: 20px;
}
</style>
