<template>
  <div class="modal">
    <el-card>
      <el-row :gutter="24">
        <el-col :span="1">
          <div style="margin-top: 7px; margin-right: 3px"><div id="img"></div></div>
        </el-col>

        <el-col class="col" :span="4">
          <span style="font-size: 20px">{{ plane.startCity }}</span
          ><span style="font-size: 10px">&nbsp;&nbsp;({{ plane.departureAirport }})</span
          ><br />
          <span style="font-size: 10px">{{ plane.startDay }} {{ plane.startTime }}</span>
        </el-col>

        <el-col class="col" :span="2">
          <span> ---- </span>
        </el-col>

        <el-col class="col" :span="4">
          <span style="font-size: 20px">{{ plane.endCity }}</span
          ><span style="font-size: 10px">&nbsp;&nbsp;({{ plane.arrivalAirport }})</span
          ><br />
          <span style="font-size: 10px">{{ plane.endDay }} {{ plane.endTime }}</span>
        </el-col>

        <el-col :span="1">
          <div>&nbsp;</div>
        </el-col>

        <el-col class="col" :span="4">
          <span style="font-size: 16px">航班状态: {{ plane.planeStatus }}</span>
        </el-col>

        <el-col class="col" :span="4">
          <span style="font-size: 16px">剩余票数: {{ plane.number_rest }}</span>
        </el-col>

        <el-col class="col" :span="4">
          <el-button
            style="background-color: #8d9fb7; border-color: #8d9fb7"
            type="info"
            :disabled="buy"
            @click="changeTicket()"
            >购票</el-button
          >
        </el-col>
      </el-row>
    </el-card>
  </div>
</template>

<script lang="ts">
import { defineComponent } from "vue";
import {
  type OptionItem,
  type ClientItem,
  type DealItem,
  type PlaneItem,
} from "~/models/general";
import { getAuthHeader } from "~/services/genServ";
import {
  searchForPlaneById,
} from "~/services/infoServ";
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
  ElTabs,
  ElTabPane,
} from "element-plus";
import { message } from "~/tools/messageBox";
import 'cropperjs/dist/cropper.css'; // 引入 Cropper.js 的样式文件
import VueCropper from 'cropperjs';
import Cropper from "cropperjs";

export default defineComponent({
  name: 'ChangeAnyPlaneIn' as string,
  components:{
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
    ElTabs,
    ElTabPane,
  },
  props: {
    pId: {
      type: String,
      required: true
    },
    dId: {
      type: String, // 假设 dealId 是一个字符串类型的属性
      required: true
    }
  },
  watch: {
    pId: {
      immediate: true, // 立即执行一次
      handler(newVal, oldVal) {
        this.planeId = newVal;
      }
    },
    dId: {
      immediate: true, // 立即执行一次
      handler(newVal, oldVal) {
        this.dealId = newVal;
      }
    },
  },
  data: () => ({
    planeId: null as number | null,
    dealId: null as number | null,
    plane: {} as PlaneItem,
    remainingTickets: 0 as number,
    buy: true as boolean,
  }),
  async created(){
    await this.query();
    this.shouldShowBuyButton();
  },
  methods: {
    shouldShowBuyButton(){
      // 根据剩余票数来判断是否显示购票按钮
      if (this.plane && this.plane.number_rest !== undefined && this.plane.number_rest !== 0 && this.plane.planeStatus === "可正常购票/退票") {
        this.buy = false;
      }else{
        this.buy = true;
      }
    },
    async query(){
      this.planeId = Number(this.pId);
      this.dealId = Number(this.dId);
      let res = await searchForPlaneById(
        this.planeId,
      );
      this.plane = res.data.info;
      console.log(this.plane);
      this.remainingTickets = res.data.info.number_rest;
    },
    changeTicket() {
      this.$router.push({ path: "/ChangeTicket", query: {dealId: this.dealId, planeId: this.planeId } });
    },
  },
});
</script>

<style scoped>
#img {
  width: 30px;
  height: 30px;
  background-size: 100% 100%;
  background-image: url("https://static.thenounproject.com/png/5109422-200.png");
}

.modal {
  padding: 20px;
  border: 1px solid #ccc;
  border-radius: 5px;
  background-color: #fff;
  max-width: 1600px; /* 根据实际需要调整宽度 */
  margin: 20px auto;
  box-shadow: 0 0 10px rgba(0, 0, 0, 0.1); /* 添加阴影效果 */
}
</style>
