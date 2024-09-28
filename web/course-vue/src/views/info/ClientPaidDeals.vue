<template>
  <div id="travelRecords" v-if="travelRecordList.length !== 0">
    <el-card
      v-for="record in travelRecordList"
      :key="record.travelRecordId"
      class="record-card"
    >
      <div slot="header" class="clearfix">
        <span>出行记录号: {{ record.travelRecordId }}</span>
        <span
          >{{ record.departureAirportName }} ------ {{ record.arrivalAirportName }}</span
        >
        <el-button
          type="danger"
          v-if="recordExpanded[record.travelRecordId]"
          @click="handleRefundAll(record)"
        >
          <el-icon><CircleClose /></el-icon>全部退票
        </el-button>
        <el-button type="text" class="expand-button" @click="toggleExpanded(record)">
          {{ recordExpanded[record.travelRecordId] ? "收起" : "展开" }}
        </el-button>
      </div>
      <div v-if="recordExpanded[record.travelRecordId]">
        <el-collapse v-model="activeNames" accordion>
          <el-collapse-item
            v-for="(item, index) in dealsList"
            :key="index"
            :title="'第 ' + (index + 1) + ' 程'"
            :name="item.dealId"
          >
            <el-divider></el-divider>
            <!-- 内容部分 -->
            <div slot="title">
              <div class="title-info">
                <div class="info-row">
                  <p>
                    出发地: <span>{{ item.startCity }}</span>
                  </p>
                  <p>
                    目的地: <span>{{ item.endCity }}</span>
                  </p>
                </div>
                <div class="info-row">
                  <p>
                    航空公司: <span>{{ item.airlineCompanyName }}</span>
                  </p>
                  <p>
                    航班状态: <span>{{ item.planeStatus }}</span>
                  </p>
                </div>
                <span
                  v-if="
                    item.planeStatus === '正在值机' ||
                    item.planeStatus === '可正常购票/退票'
                  "
                  style="color: aqua"
                  class="info-tip"
                  ><el-icon><InfoFilled /></el-icon
                  >提示：请您到指定登机口办理登机手续。</span
                >
                <span
                  v-else-if="item.planeStatus === '即将起飞'"
                  style="color: crimson"
                  class="info-tip"
                  ><el-icon><InfoFilled /></el-icon
                  >提示：航班即将起飞，若您还未登机，请通过紧急通道办理登机。祝您旅途愉快！</span
                >
                <span
                  v-else-if="item.planeStatus === '航班已起飞'"
                  style="color: forestgreen"
                  class="info-tip"
                  ><el-icon><InfoFilled /></el-icon
                  >提示：机组成员正在为您的安全保驾护航。</span
                >
                <span
                  v-else-if="item.planeStatus === '航班已安全到达'"
                  style="color: hotpink"
                  class="info-tip"
                  ><el-icon><InfoFilled /></el-icon
                  >提示：您已顺利到达目的地，感谢您的支持和谅解！</span
                >
              </div>
            </div>
            <el-divider></el-divider>
            <div id="dealPaid">
              <el-card class="el-card">
                <div slot="header" class="clearfix">
                  <div class="order-info-container">
                    <span class="order-info">
                      <el-icon><Promotion /></el-icon>航班号: {{ item.planeName }}
                    </span>
                    <span class="order-info">
                      <el-icon><Money /></el-icon>金额：{{ item.value }}￥
                    </span>
                    <span class="order-info">
                      <el-icon><Timer /></el-icon>订单完成时间: {{ item.time }}
                    </span>
                  </div>
                </div>
                <div style="text-align: center">
                  <div style="font-weight: bold; font-size: 24px">
                    {{ item.startCity }} ({{ item.departureAirport }})------
                    {{ item.endCity }}({{ item.arrivalAirport }})
                  </div>
                  <div class="dd">
                    <span style="font-size: 16px">
                      <el-icon><Clock /></el-icon>出发时间:{{ item.startDay }}
                      {{ item.startTime }} &nbsp;&nbsp;<el-icon><Clock /></el-icon
                      >到达时间:{{ item.endDay }} {{ item.endTime }} &nbsp;&nbsp;
                    </span>
                  </div>
                  <div class="dd">
                    <span style="font-size: 16px">
                      座位号 : 第 {{ item.seatRowNumber }} 行 第
                      {{ item.seatColumnNumber }} 列
                    </span>
                  </div>
                  <div style="margin-top: 10px; display: flex; justify-content: center">
                    <el-button
                      class="action-button"
                      v-if="
                        item.planeStatus === '可正常购票/退票' ||
                        item.planeStatus === '余票售罄'
                      "
                      type="primary"
                      @click="change(item)"
                    >
                      <el-icon><Edit /></el-icon>改签
                    </el-button>
                    <el-button
                      class="action-button"
                      type="danger"
                      v-if="
                        item.planeStatus === '可正常购票/退票' ||
                        item.planeStatus === '余票售罄'
                      "
                      @click="refund(item)"
                    >
                      <el-icon><close /></el-icon>退票
                    </el-button>
                    <el-button
                      class="action-button"
                      type="success"
                      v-if="
                        item.planeStatus !== '航班已起飞' &&
                        item.planeStatus !== '航班已安全到达'
                      "
                      @click="printBoardingPass(item)"
                    >
                      <el-icon><Printer /></el-icon>打印登机牌
                    </el-button>
                  </div>
                </div>
              </el-card>
            </div>
          </el-collapse-item>
        </el-collapse>
      </div>
    </el-card>
    <div class="page-container">
      <el-button class="back-button" type="primary" @click="goBack()"
        ><el-icon><RefreshLeft /></el-icon>返回</el-button
      >
      <el-button class="refresh-button" @click="refresh()"
        ><el-icon><refresh /></el-icon>刷新</el-button
      >
    </div>
  </div>
  <div id="travelRecords" v-if="travelRecordList.length === 0">
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
  type ClientItem,
  type DealItem,
  type TravelRecordItem,
} from "~/models/general";
import { downloadPost, getAuthHeader } from "~/services/genServ";
import {
  getClientDealList,
  refundTicket,
  getClientDealListWithTravelRecordId,
  handleRefundAll,
  getClientTravelRecordList,
} from "~/services/infoServ";
import { message } from "~/tools/messageBox";
import 'cropperjs/dist/cropper.css'; // 引入 Cropper.js 的样式文件
import { CollapseModelValue } from 'element-plus';
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
import { Console } from "console";
import { Promotion, Money, Timer, RefreshLeft, Refresh, CircleClose, InfoFilled, Close, Edit, Clock, Printer, } from '@element-plus/icons-vue';

export default defineComponent ({
  name: "DealPaid",
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
    planeId: null as number | null,
    dealId: null as number | null,
    dealsList: [] as DealItem[],
    travelRecordList: [] as TravelRecordItem[],
    recordExpanded: {} as Record<string, boolean>,
    activeNames: [],
    tipTitle: "诶~~" as string,
    tipPromptText: "您似乎还没有订单记录呢，快去寻找心仪的出行目的地吧！" as string,
    tipImageSrc: "/OMG.jpg" as string,
  }),
  created() {
    this.query();
  },
  methods:{
    async query(){
      const clientIdStr = this.$route.query.clientId as string;
      this.clientId = Number(clientIdStr);
      let res = await getClientDealList(this.clientId);
      const temp = res.data as DealItem[];
      console.log(temp);
      this.dealsList = temp.filter(item => item.status === "已付款");
      console.log(this.dealsList);
      res = await getClientTravelRecordList(this.clientId);
      this.travelRecordList = res.data;
      console.log(this.travelRecordList);
      this.travelRecordList = this.travelRecordList.filter(item => item.status === "已付款").sort((a, b) => b.travelRecordId - a.travelRecordId);
    },
    change(item : DealItem){
      this.$router.push({path:'/ChangePlane',query:{
        dealId: item.dealId,
      }});
    },
    goBack(){
      this.$router.back();
    },
    refresh(){
      this.query();
    },
    async refund(item : DealItem){
      let res = await refundTicket({
        clientId: item.clientId,
        planeId: item.planeId,
        dealId: item.dealId,
      });
      if (res.code != 0) {
        message(this, res.msg);
        return;
      } else {
        message(this, "退票成功！");
        this.query();
      }
    },
    printBoardingPass(item : DealItem){
      const res = downloadPost(
        "/api/client/getFlightTicketPdf",
        item.planeName + ".pdf",
        {
          dealId: item.dealId,
        }
      );
      console.log(res);
    },
    async handleRefundAll(record: TravelRecordItem) {
      let res = await handleRefundAll({
        travelRecordId: record.travelRecordId,
        clientId: this.clientId,
      });
      if (res.code != 0) {
        message(this, res.msg);
        return;
      } else {
        message(this, "退票成功！");
        this.query();
      }
    },
    async toggleExpanded(record: TravelRecordItem) {
      let res = await getClientDealListWithTravelRecordId({
        travelRecordId: record.travelRecordId,
        clientId: this.clientId,
      });
      this.dealsList = res.data;
      this.dealsList = this.dealsList.filter(item => item.status === '已付款');
      this.recordExpanded[record.travelRecordId] = !this.recordExpanded[record.travelRecordId];
    },
  }
});
</script>

<style scoped>
/* 外部容器样式 */
#travelRecords {
  padding: 20px;
  border: 1px solid #ccc;
  border-radius: 5px;
  background-color: #fff;
  max-width: 1600px; /* 根据实际需要调整宽度 */
  margin: 20px auto;
  box-shadow: 0 0 10px rgba(0, 0, 0, 0.1); /* 添加阴影效果 */
}

/* 单个记录卡片样式 */
.record-card {
  max-width: 1400px; /* 根据实际需要调整 */
  margin: auto;
  padding: 20px;
  box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
  border-radius: 8px;
  width: calc(33.33% - 20px); /* 一行显示三列，根据具体布局调整 */
  min-width: 800px; /* 最小宽度，避免内容挤压 */
  box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
  border-radius: 8px;
}

/* 卡片头部样式 */
.clearfix {
  padding: 10px;
  border-bottom: 1px solid #f0f0f0;
  display: flex;
  justify-content: space-between;
  align-items: center;
}

.clearfix::after {
  content: "";
  display: table;
  clear: both;
}

.order-info-container {
  display: flex;
  justify-content: space-between;
  width: 100%;
}

.order-info {
  width: 33%;
  text-align: center; /* 可根据需要调整对齐方式 */
  font-size: 12px;
  margin-right: 10px;
}

/* 展开按钮样式 */
.expand-button {
  font-size: 14px;
  color: #409eff;
  cursor: pointer;
}

.action-button {
  float: right;
  padding: 3px 10px;
  font-size: 12px;
}

/* 内容部分整体样式 */
.el-collapse-item__wrap {
  padding: 10px;
}

/* 折叠项标题样式 */
.el-collapse-item__header {
  padding: 10px;
  background-color: #f5f7fa;
  border-radius: 4px;
  cursor: pointer;
}

/* 折叠项标题内部样式 */
.el-collapse-item__header p {
  margin: 5px 0;
  font-size: 14px;
}

/* 分割线样式 */
.el-divider {
  margin: 10px 0;
}

.title-info {
  font-size: 14px;
  padding: 10px 80px;
}

.info-row {
  display: flex;
  justify-content: space-between;
  margin-bottom: 8px;
}

.info-row p {
  margin: 0;
}

.info-row p span {
  font-weight: bold;
}

.info-tip {
  display: block;
  font-size: 1.2em;
  margin-top: 10px;
}

/* 订单卡片样式 */
#dealPaid .el-card {
  margin-bottom: 10px;
  border: 1px solid #ebeef5;
  border-radius: 4px;
  box-shadow: 0 2px 12px 0 rgba(0, 0, 0, 0.1);
}

/* 订单卡片头部样式 */
#dealPaid .el-card__header {
  padding: 10px;
  background-color: #f5f7fa;
  border-radius: 4px 4px 0 0;
}

/* 订单详细信息样式 */
#dealPaid .el-card__body {
  padding: 10px;
}

/* 按钮样式 */
.dd {
  margin-top: 10px;
  font-size: 10px;
}

.dd el-button {
  margin-left: 10px;
}

/* 响应式调整 */
@media (max-width: 1200px) {
  .record-card {
    width: calc(50% - 20px);
  }
}

@media (max-width: 768px) {
  .record-card {
    width: 100%;
  }
}

.page-container {
  position: relative;
  margin-top: 10px; /* 可根据需要调整距离上方内容的间距 */
  text-align: center; /* 让内容水平居中 */
}

.back-button {
  margin-top: 20px; /* 可根据需要调整按钮与卡片内容之间的垂直间距 */
  /* 样式设计 */
  background-color: #ff4040; /* 按钮背景色 */
  color: #fff; /* 文字颜色 */
  border: none; /* 去除边框 */
  border-radius: 4px; /* 圆角 */
  padding: 10px 20px; /* 按钮内边距 */
  transition: background-color 0.3s ease; /* 过渡效果 */
}

.back-button:hover {
  background-color: #66b1ff; /* 按钮悬停时的背景色 */
}

.back-button:focus {
  outline: none; /* 移除聚焦时的默认边框 */
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

.button-container {
  margin-top: 20px;
  display: flex;
  justify-content: center; /* 水平居中对齐 */
  gap: 10px; /* 调整按钮之间的间距 */
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
</style>
