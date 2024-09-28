<template>
  <div class="buy-ticket-modal">
    <img src="/sofa.jpg" width="30" height="30" />
    <span class="newBase_title">选座购票</span>
    <template v-if="currentSegmentIndex !== route.path.length">
      <div
        v-for="(segment, index) in route.path"
        :key="index"
        class="segment-info"
        v-show="index === currentSegmentIndex"
      >
        <div class="bold-text">
          <el-icon><Location /></el-icon>{{ segment.departureAirport }} ------
          <el-icon><LocationFilled /></el-icon>{{ segment.arrivalAirport }}
        </div>
        <div class="text1">
          <el-icon><Timer /></el-icon>{{ segment.startDate }} {{ segment.startTime }} ---
          <el-icon><Timer /></el-icon>{{ segment.endDate }}
          {{ segment.endTime }}
        </div>
        <!--<div v-if="typeof getTariffList(segment.planeId)"></div>-->
        <label>选择服务类型：</label>
        <div class="service-container">
          <div
            v-for="service in serviceMapList[segment.planeId]"
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
            @visible-change="handleVisibleChange($event, segment.planeId)"
          >
            <span class="el-dropdown-link"
              ><el-icon><QuestionFilled /></el-icon>服务内容说明</span
            >
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
        <NewSeatSelection
          :pId="segment.planeId.toString()"
          :type="selectedSeatType.toString()"
          :airport1="route.path[0].departureAirport"
          :airport2="route.path[route.path.length - 1].arrivalAirport"
          :tId="travelRecordId"
          ref="NewSeatSelection"
          v-on:submit="handleBookingComplete"
        />
      </div>
    </template>
    <template v-else>
      <Tips :title="tipTitle" :promptText="tipPromptText" :imageSrc="tipImageSrc" />
    </template>
    <!-- 取消购票按钮 -->
    <el-button
      class="cancel-ticket-button"
      v-if="currentSegmentIndex < route.path.length"
      @click="cancelTicket()"
      ><el-icon><CircleClose /></el-icon>取消购票</el-button
    >
    <el-button
      class="cancel-ticket-button"
      v-else-if="currentSegmentIndex === route.path.length && tNumber > 1"
      @click="nextTicket()"
      ><el-icon><ZoomIn /></el-icon>继续购票</el-button
    >
    <el-button class="cancel-ticket-button" v-else @click="back()"
      ><el-icon><refresh-left /></el-icon>返回</el-button
    >
  </div>
</template>

<script lang="ts">
import NewSeatSelection from './NewSeatSelection.vue';
import Tips from './Tips.vue';
import { defineComponent } from "vue";
import {
  type OptionItem,
  type ClientItem,
  type RouteResponse,
  type TariffItem,
  type RouteSegment,
  type CityItem,
} from "~/models/general";
import { getAuthHeader } from "~/services/genServ";
import {
  cancelTicket,
  getTariffList,
} from "~/services/infoServ";
import { message } from "~/tools/messageBox";
import 'cropperjs/dist/cropper.css'; // 引入 Cropper.js 的样式文件
import VueCropper from 'cropperjs';
import Cropper from "cropperjs";
import { ElDropdown, ElDropdownMenu, ElDropdownItem } from 'element-plus';
import router from '~/router';
import { RefreshLeft, CircleClose, QuestionFilled, Location, LocationFilled, Timer, ZoomIn,} from '@element-plus/icons-vue';

export default defineComponent({
  components: {
    NewSeatSelection,
    Tips,
    ElDropdown,
    ElDropdownMenu,
    ElDropdownItem,
    RefreshLeft,
    CircleClose,
    QuestionFilled,
    Location,
    LocationFilled,
    Timer,
    ZoomIn,
  },
  data: () => ({
      selectedSeatType: "经济座" as String,
      route: {} as RouteResponse,
      planeId: null as number | null,
      travelRecordId: 0 as number,
      dropdownVisible: false as boolean,
      serviceList: [] as TariffItem[],
      serviceMapList: [] as TariffItem[][],
      currentSegmentIndex: 0 as number,
      tipTitle: "您的购票已完成！ (*^▽^*) " as string,
      tipPromptText: "我们将继续竭诚为您服务!祝您旅途愉快!" as string,
      tipImageSrc: "/success.jpg" as string,
      tNumber: 0 as number,
      selectedCity1Id:  0 as number,
      selectedCity2Id: 0 as number,
      departureCity: {} as CityItem,
      arrivalCity: {} as CityItem,
      departureAirport: "" as string,
      arrivalAirport: "" as string,
      airlineCompanyName: null as string | null,
      viaAirport: null as string | null,
      directFlight: true as boolean,
      selectedDate: '',
      searchType: "" as string,
  }),
  // 在目标页面中使用 JSON.parse 解析字符串为对象
  async created(){
    if (typeof this.$route.query.route  === 'string') {
      this.route = JSON.parse(this.$route.query.route);
      console.log(this.route);
      const travelRecordIdStr = this.$route.query.travelRecordId as String;
      this.travelRecordId = Number(travelRecordIdStr);
      const selectedCity1IdStr = this.$route.query.selectedCity1Id as string;
      this.selectedCity1Id = Number(selectedCity1IdStr);
      const selectedCity2IdStr = this.$route.query.selectedCity1Id as string;
      this.selectedCity2Id = Number(selectedCity2IdStr);
      const tNumberStr = this.$route.query.tNumber as string;
      this.tNumber = Number(tNumberStr);
      this.departureAirport = this.$route.query.departureAirport as string;
      this.arrivalAirport = this.$route.query.arrivalAirport as string;
      this.airlineCompanyName = this.$route.query.airlineCompanyName as string | null;
      this.viaAirport = this.$route.query.viaAirport as string | null;
      this.directFlight = (this.$route.query.directFlight === "true");
      this.searchType = this.$route.query.searchType as string;
      this.selectedDate = this.$route.query.startDateString as string;
    // 现在 this.route 是一个对象，可以直接访问其属性
    }
    const planeIds = this.route.path.map(segment => segment.planeId);
    for (const planeId of planeIds) {
      this.getTariffList(planeId);
    }
  },
  methods: {
    async getTariffList(planeId: number){
      let res = await getTariffList(planeId);
      this.serviceList = res.data;
      this.serviceMapList[planeId] = this.serviceList;
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
      router.push("/Search");
    },
    async cancelTicket(){
      let res = await cancelTicket(this.travelRecordId);
      if (res.code != 0) {
        message(this, res.msg);
        return;
      } else {
        message(this, "取消创建订单");
      }
      this.$router.back();
    },
    nextTicket(){
      this.tNumber = this.tNumber - 1;
      this.$router.push({ path: '/SearchPlane', query: {
        selectedCity1Id: this.selectedCity1Id,
        selectedCity2Id: this.selectedCity2Id,
        departureAirport: this.departureAirport,
        arrivalAirport: this.arrivalAirport,
        startDateString: this.selectedDate,
        airlineCompanyName: this.airlineCompanyName,
        viaAirport: this.viaAirport,
        directFlight: this.directFlight.toString(),
        searchType: this.searchType,
        tNumber: this.tNumber,
       }
      });
    },
    handleBookingComplete(data: object) {
      // 购票完成后的处理逻辑
      // 滚动到下一段航程
      if(typeof data === 'number'){
        this.currentSegmentIndex = this.currentSegmentIndex + data;
      }
      console.log(this.currentSegmentIndex);
    },
  },
});
</script>

<style scoped>
.buy-ticket-modal {
  padding: 20px;
  border: 1px solid #ccc;
  border-radius: 5px;
  background-color: #fff;
  max-width: 1600px; /* 根据实际需要调整宽度 */
  margin: 20px auto;
  box-shadow: 0 0 10px rgba(0, 0, 0, 0.1); /* 添加阴影效果 */
}

.buy-ticket-modal h2 {
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
  width: 120px; /* 根据实际需要调整宽度 */
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
