<template>
  <div class="reschedule-ticket-modal">
    <img src="/sofa.jpg" width="30" height="30" />
    <span class="newBase_title">改签购票</span>
    <template v-if="!checkRebook">
      <div class="segment-info">
        <div class="bold-text">
          {{ plane.departureAirport }} ------ {{ plane.arrivalAirport }}
        </div>
        <div class="text1">
          {{ plane.startDay }} {{ plane.startTime }} --- {{ plane.endDay }}
          {{ plane.endTime }}
        </div>
        <!--<div v-if="typeof getTariffList(plane.planeId)"></div>-->
        <label>选择新服务类型：</label>
        <div class="service-container">
          <div
            v-for="service in serviceList"
            :key="service.tariffId"
            class="newService-item"
          >
            <input
              type="radio"
              :id="String(service.tariffId)"
              name="seatType"
              :value="service.type"
              v-model="selectedSeatType"
            />
            <label :for="String(service.tariffId)">{{ service.type }}</label>
          </div>
        </div>
        <div class="dropdown-container">
          <el-dropdown
            trigger="hover"
            @visible-change="handleVisibleChange($event, plane.planeId)"
          >
            <span class="el-dropdown-link">
              服务内容说明<i class="el-icon-arrow-down el-icon--right"></i>
            </span>
            <template #dropdown>
              <el-dropdown-menu class="custom-dropdown-menu">
                <el-dropdown-item
                  v-for="service in serviceList"
                  :key="service.tariffId"
                  :command="service.tariffId"
                >
                  <div class="service-item">
                    <div class="service-title">{{ service.type }}</div>
                    <div class="service-description">{{ service.description }}</div>
                  </div>
                </el-dropdown-item>
              </el-dropdown-menu>
            </template>
          </el-dropdown>
        </div>
        <SeatSelection
          :pId="plane.planeId.toString()"
          :type="selectedSeatType.toString()"
          :airport1="plane.departureAirport"
          :airport2="plane.arrivalAirport"
          :dId="dealId"
          ref="SeatSelection"
          v-on:submit="handleBookingComplete"
        />
      </div>
    </template>
    <template v-else>
      <Tips :title="tipTitle" :promptText="tipPromptText" :imageSrc="tipImageSrc" />
    </template>
    <!-- 取消改签按钮 -->
    <el-button class="cancel-ticket-button" @click="back()">取消</el-button>
  </div>
</template>

<script lang="ts">
import SeatSelection from './SeatSelection.vue';
import Tips from './Tips.vue';
import { defineComponent } from "vue";
import {
  type OptionItem,
  type ClientItem,
  type RouteResponse,
  type TariffItem,
  type PlaneItem,
} from "~/models/general";
import { getAuthHeader } from "~/services/genServ";
import {
  getTariffList,
  searchForPlaneById,
} from "~/services/infoServ";
import { message } from "~/tools/messageBox";
import 'cropperjs/dist/cropper.css'; // 引入 Cropper.js 的样式文件
import VueCropper from 'cropperjs';
import Cropper from "cropperjs";
import { ElDropdown, ElDropdownMenu, ElDropdownItem } from 'element-plus';
import router from '~/router';

export default defineComponent({
  components: {
    SeatSelection,
    Tips,
    ElDropdown,
    ElDropdownMenu,
    ElDropdownItem,
  },
  data: () => ({
      selectedSeatType: "经济座" as String,
      plane: {} as PlaneItem,
      planeId: null as number | null,
      dealId: 0 as number,
      dropdownVisible: false as boolean,
      serviceList: [] as TariffItem[],
      checkRebook: false as boolean,
      tipTitle: "改签成功！٩(๑>◡<๑)۶ " as string,
      tipPromptText: "已为您改签!请前往个人订单查看！" as string,
      tipImageSrc: "/rebook.jpg" as string,
  }),
  // 在目标页面中使用 JSON.parse 解析字符串为对象
  async created(){
    const dealIdStr = this.$route.query.dealId as String;
    this.dealId = Number(dealIdStr);
    const planeIdStr = this.$route.query.planeId as String;
    this.planeId = Number(planeIdStr);
    let res = await searchForPlaneById(this.planeId);
    this.plane = this.plane = res.data.info;
    this.getTariffList(this.plane.planeId);
  },
  methods: {
    async getTariffList(planeId: number){
      let res = await getTariffList(planeId);
      this.serviceList = res.data;
      console.log(this.serviceList);
    },
    handleCommand(command: any) {
        message(this,'click on item ' + command);
      },
    handleVisibleChange(event: any, planeId: number) {
      this.dropdownVisible = !this.dropdownVisible;
      console.log(this.dropdownVisible);
      console.log(planeId);
      this.getTariffList(planeId);
    },
    back(){
      this.$router.back();
    },
    handleBookingComplete(data: object) {
      // 购票完成后的处理逻辑
      // 滚动到下一段航程
      if(typeof data === 'number'){
        this.checkRebook = !this.checkRebook;
      }
      console.log(this.checkRebook);
    },
  },
});
</script>

<style scoped>
.reschedule-ticket-modal {
  padding: 20px;
  border: 1px solid #ccc;
  border-radius: 5px;
  background-color: #fff;
  max-width: 1600px; /* 根据实际需要调整宽度 */
  margin: 20px auto;
  box-shadow: 0 0 10px rgba(0, 0, 0, 0.1); /* 添加阴影效果 */
}

.reschedule-ticket-modal h2 {
  margin-bottom: 15px;
  font-size: 24px; /* 标题字体大小 */
  color: #333; /* 标题颜色 */
}

.segment-info {
  border: 1px solid #ccc;
  border-radius: 5px;
  padding: 15px;
  margin-bottom: 15px;
  background-color: #f9f9f9;
}

.segment-info > div {
  margin-bottom: 10px;
}

.segment-info label {
  font-weight: bold;
  margin-right: 10px;
}

.segment-info input[type="radio"] {
  margin-right: 10px;
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

.newBase_title {
  margin-top: 12px;
  margin-left: 8px;
  font-family: SourceHanSansCN-Medium;
  font-size: 25px;
  color: #202020;
  letter-spacing: 0;
  font-weight: bold;
}

.bold-text {
  font-weight: bold; /* 设置字体加粗 */
  line-height: 1.5; /* 设置行间距增大 */
  font-size: 1.8em;
}

.text1 {
  line-height: 1.2; /* 设置行间距增大 */
  font-size: 1.2em;
}

.dropdown-container {
  display: flex;
  position: relative;
  width: 105.33px; /* 根据实际需要调整宽度 */
  height: 30px;
}

.el-dropdown-link {
  cursor: pointer;
  display: inline-block;
  padding: 4px 10px;
  border: 1px solid #ebeef5;
  border-radius: 4px;
  background-color: #f5f7fa;
  color: #606266;
  transition: background-color 0.3s, border-color 0.3s, color 0.3s;
}

.el-dropdown-link:hover {
  background-color: #e6f7ff;
  border-color: #91d5ff;
  color: #409eff;
}

.el-dropdown-menu {
  padding: 8px 0;
  border: 1px solid #dcdfe6;
  border-radius: 4px;
  box-shadow: 0 2px 12px 0 rgba(0, 0, 0, 0.1);
  background-color: #fff;
  z-index: 1000; /* 确保菜单在顶层显示 */
}

.el-dropdown-item {
  padding: 10px 20px;
  font-size: 14px;
  color: #606266;
  transition: background-color 0.3s;
}

.el-dropdown-item:hover {
  background-color: #f5f7fa;
}

.service-item {
  padding: 8px 16px;
}

.service-container {
  display: grid;
  grid-template-columns: repeat(auto-fill, minmax(120px, 1fr)); /* 设置列宽 */
  gap: 20px; /* 列间隔 */
}

.newService-item {
  display: flex;
  align-items: center; /* 垂直居中对齐 */
}

.service-title {
  font-weight: bold;
  margin-bottom: 4px;
}

.service-description {
  color: #909399;
}

.custom-dropdown-menu {
  z-index: 3000 !important;
}
</style>
