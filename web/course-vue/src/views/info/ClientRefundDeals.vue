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
        <el-button type="text" class="expand-button" @click="toggleExpanded(record)">
          {{ recordExpanded[record.travelRecordId] ? "收起" : "展开" }}
        </el-button>
      </div>
      <div v-if="recordExpanded[record.travelRecordId]">
        <el-collapse v-model="activeNames" accordion>
          <el-collapse-item
            v-for="(item, index) in dealsList"
            :key="index"
            :title="'第' + (index + 1) + '程'"
            :name="item.dealId"
          >
            <!-- 内容部分 -->
            <template slot="title">
              <div class="title-info">
                <p>出发地: {{ item.startCity }}</p>
                <p>目的地: {{ item.endCity }}</p>
                <p>航空公司: {{ item.airlineCompanyName }}</p>
                <p>客户ID: {{ item.clientId }}</p>
              </div>
            </template>
            <el-divider></el-divider>
            <div id="dealPaid">
              <el-card class="el-card">
                <div slot="header" class="clearfix">
                  <div class="order-info-container">
                    <span class="order-info"> 订单号: {{ item.dealId }} </span>
                    <span class="order-info"> 金额：{{ item.value }}￥ </span>
                    <span class="order-info"> 订单完成时间: {{ item.time }} </span>
                    <span class="order-info"> 订单状态: {{ item.status }} </span>
                  </div>
                </div>
              </el-card>
            </div>
          </el-collapse-item>
        </el-collapse>
      </div>
    </el-card>
    <div class="page-container">
      <el-button class="back-button" type="primary" @click="goBack()">返回</el-button>
    </div>
  </div>
  <div id="travelRecords" v-else>
    <Tips :title="tipTitle" :promptText="tipPromptText" :imageSrc="tipImageSrc" />
    <el-button class="cancel-ticket-button" @click="goBack()">返回</el-button>
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
import { getAuthHeader } from "~/services/genServ";
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
  async created() {
    const clientIdStr = this.$route.query.clientId as string;
    this.clientId = Number(clientIdStr);
    let res = await getClientDealList(this.clientId);
    const temp = res.data as DealItem[];
    this.dealsList = temp;
    console.log(this.dealsList);
    res = await getClientTravelRecordList(this.clientId);
    this.travelRecordList = res.data;
    this.travelRecordList = this.travelRecordList.filter(item => item.status === "已退款" || item.status === "已部分退款").sort((a, b) => b.travelRecordId - a.travelRecordId);
  },
  methods:{
    async toggleExpanded(record: TravelRecordItem) {
      let res = await getClientDealListWithTravelRecordId({
        travelRecordId: record.travelRecordId,
        clientId: this.clientId,
      });
      this.dealsList = res.data;
      console.log(this.dealsList);
      //this.dealsList = this.dealsList.filter(item => item.status === '已付款');
      this.recordExpanded[record.travelRecordId] = !this.recordExpanded[record.travelRecordId];
    },
    goBack(){
      this.$router.back();
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
  max-width: 1200px; /* 根据实际需要调整 */
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
  width: 25%;
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
  background-color: #409eff; /* 按钮背景色 */
  color: #fff; /* 文字颜色 */
  border: none; /* 去除边框 */
  border-radius: 4px; /* 圆角 */
  padding: 10px 20px; /* 按钮内边距 */
  transition: background-color 0.3s ease; /* 过渡效果 */
}

.cancel-ticket-button:hover {
  background-color: #ff3b30;
}

.back-button:hover {
  background-color: #66b1ff; /* 按钮悬停时的背景色 */
}

.back-button:focus {
  outline: none; /* 移除聚焦时的默认边框 */
}
</style>
