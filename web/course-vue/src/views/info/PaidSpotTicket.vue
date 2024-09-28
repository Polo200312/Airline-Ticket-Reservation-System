<template>
  <div id="spotTickets" v-if="spotTickets.length !== 0">
    <el-card v-for="ticket in spotTickets" :key="ticket.spotTicketId" class="ticket-card">
      <div slot="header" class="clearfix">
        <span>订单号: {{ ticket.spotTicketId }}</span>
      </div>
      <div>
        <el-divider></el-divider>
        <div id="ticketDetails">
          <el-card class="el-card">
            <div slot="header" class="clearfix">
              <div class="order-info-container">
                <span class="order-info">
                  <el-icon><Promotion /></el-icon>景区: {{ ticket.spotName }}
                </span>
                <span class="order-info">
                  <el-icon><Money /></el-icon>金额: {{ ticket.value }}￥
                </span>
                <span class="order-info">
                  <el-icon><Timer /></el-icon>入场时间: {{ ticket.time }}
                </span>
              </div>
            </div>
            <div style="text-align: center">
              <div style="font-weight: bold; font-size: 24px">
                {{ ticket.spotName }}
              </div>
              <div class="dd">
                <span style="font-size: 16px">
                  <el-icon><Clock /></el-icon>参观时间: {{ ticket.time }}
                </span>
              </div>
              <div style="margin-top: 10px; display: flex; justify-content: center">
                <el-button
                  class="action-button"
                  type="success"
                  @click="printSpotTicket(ticket)"
                  :disabled="!canPrintOrRefund(ticket.time)"
                >
                  <el-icon><Printer /></el-icon>打印门票
                </el-button>
                <el-button
                  class="action-button"
                  type="danger"
                  @click="refund(ticket)"
                  :disabled="!canPrintOrRefund(ticket.time)"
                >
                  <el-icon><close /></el-icon>退票
                </el-button>
              </div>
            </div>
          </el-card>
        </div>
      </div>
    </el-card>
    <div class="page-container">
      <el-button class="cancel-ticket-button" type="primary" @click="goBack()"
        ><el-icon><RefreshLeft /></el-icon>返回</el-button
      >
      <el-button class="refresh-button" @click="refresh()"
        ><el-icon><refresh /></el-icon>刷新</el-button
      >
    </div>
  </div>
  <div id="spotTickets" v-if="spotTickets.length === 0">
    <Tips :title="tipTitle" :promptText="tipPromptText" :imageSrc="tipImageSrc" />
    <div class="button-container">
      <el-button class="cancel-ticket-button" @click="goBack()"
        ><el-icon><RefreshLeft /></el-icon>返回</el-button
      >
      <el-button class="refresh-button" @click="refresh()"
        ><el-icon><refresh /></el-icon>刷新</el-button
      >
    </div>
  </div>
</template>

<script lang="ts">
import { defineComponent } from "vue";
import Tips from './Tips.vue';
import {
  type OptionItem,
  type SpotTicketItem,
} from "~/models/general";
import { downloadPost, getAuthHeader } from "~/services/genServ";
import {
  getClientSpotTicketList,
  refundSpotTicket,
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
import { Promotion, Money, Timer, RefreshLeft, Refresh, CircleClose, InfoFilled, Close, Edit, Clock, Printer, } from '@element-plus/icons-vue';

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
    Tips,
    RefreshLeft,
    Refresh,
    InfoFilled,
    CircleClose,
    Close,
    Edit,
    Clock,
    Promotion,
    Money,
    Timer,
    Printer,
  },
  data: () => ({
    clientId: null as number | null,
    spotTickets : [] as SpotTicketItem[],
    tipTitle: "诶~~" as string,
    tipPromptText: "您似乎还没有订单记录呢，快去寻找心仪的出行目的地吧！" as string,
    tipImageSrc: "/OMG.jpg" as string,
  }),
  created(){
    this.query();
  },
  methods: {
    async query(){
      const clientIdStr = this.$route.query.clientId as string;
      this.clientId = Number(clientIdStr);
      let res = await getClientSpotTicketList(this.clientId);
      this.spotTickets = res.data;
      console.log(res.data);
    },
    canPrintOrRefund(ticketTime: string): boolean {
      const ticketDate = new Date(ticketTime).getTime();
      const currentDate = new Date();
      currentDate.setHours(0, 0, 0, 0);
      const currentTimeStamp = currentDate.getTime();
      console.log(ticketDate + " " + currentTimeStamp);
      return ticketDate > currentTimeStamp;
    },
    goBack(){
      this.$router.back();
    },
    refresh(){
      this.query();
    },
    async refund(item : SpotTicketItem){
      let res = await refundSpotTicket({
        spotTicketId: item.spotTicketId,
      });
      if (res.code != 0) {
        message(this, res.msg);
        return;
      } else {
        message(this, "退票成功！");
        this.query();
      }
    },
    printSpotTicket(item : SpotTicketItem){
      const res = downloadPost(
        "/api/spotTicket/getSpotTicketPdf",
        item.spotName + "-" + item.time + item.spotTicketId + ".pdf",
        {
          spotTicketId: item.spotTicketId,
        }
      );
      console.log(res);
    },
  },
});
</script>

<style scoped>
.ticket-card {
  max-width: 1400px; /* 根据实际需要调整 */
  margin: auto;
  margin-top: 10px;
  padding: 20px;
  box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
  border-radius: 8px;
  width: calc(33.33% - 20px); /* 一行显示三列，根据具体布局调整 */
  min-width: 800px; /* 最小宽度，避免内容挤压 */
  box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
  border-radius: 8px;
}

.order-info-container {
  display: flex;
  justify-content: space-between;
  flex-wrap: wrap;
}

.order-info {
  font-size: 16px;
  margin-right: 10px;
}

.dd {
  margin-top: 10px;
}

.page-container {
  text-align: center;
  margin-top: 20px;
}

.back-button {
  margin-right: 10px;
}

.refresh-button {
  margin-top: 20px; /* 可根据需要调整按钮与卡片内容之间的垂直间距 */
  /* 样式设计 */
  background-color: #409eff; /* 按钮背景色 */
  color: #fff; /* 文字颜色 */
  border: none; /* 去除边框 */
  border-radius: 4px; /* 圆角 */
  padding: 10px 20px; /* 按钮内边距 */
  transition: background-color 0.3s ease; /* 过渡效果 */
}

.refresh-button:hover {
  background-color: #66b1ff; /* 按钮悬停时的背景色 */
}

.refresh-button:focus {
  outline: none; /* 移除聚焦时的默认边框 */
}

.cancel-ticket-button {
  background-color: #ff6347;
  color: #fff;
  border: none;
  padding: 12px 24px;
  border-radius: 5px;
  cursor: pointer;
  font-size: 16px;
  margin-top: 20px;
  transition: background-color 0.3s ease; /* 添加过渡效果 */
}

.cancel-ticket-button:hover {
  background-color: #ff3b30;
}

.button-container {
  margin-top: 20px;
  display: flex;
  justify-content: center; /* 水平居中对齐 */
  gap: 10px; /* 调整按钮之间的间距 */
}

.action-button {
  margin: 0 10px;
}
</style>
