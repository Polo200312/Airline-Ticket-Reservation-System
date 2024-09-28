<template>
  <div
    class="container"
    v-if="paginatedRoutes.length !== 0 && paginatedRoutes[0].path.length !== 0"
  >
    <img
      src="https://static.thenounproject.com/png/4648873-200.png"
      width="30"
      height="30"
    />
    <span class="newBase_title">搜索结果（共 {{ RoutesList.length }} 条）</span>
    <div class="route-list">
      <el-row>
        <el-col :span="24">
          <div
            v-for="(route, routeIndex) in paginatedRoutes"
            :key="routeIndex"
            class="route-item"
          >
            <div class="city-info">
              <div>
                <el-icon><Location /></el-icon>出发机场:
                {{ route.path[0].departureAirport }}
                <el-button
                  type="primary"
                  class="map-button"
                  @click="
                    openGoogleMaps(
                      route.path[0].departureAirport,
                      route.path[route.path.length - 1].arrivalAirport
                    )
                  "
                >
                  <el-icon><MapLocation /></el-icon>
                </el-button>
              </div>
              <div>
                <el-icon><LocationFilled /></el-icon>到达机场:
                {{ route.path[route.path.length - 1].arrivalAirport }}
              </div>
              <div>
                <el-icon><Money /></el-icon>预计总价格(最低价): {{ route.totalPrice }}￥
              </div>
              <div>
                <el-icon><DataLine /></el-icon>预计总航程: {{ route.totalDistance }}KM
              </div>
              <div>
                <el-icon><Suitcase /></el-icon>预计转乘次数: {{ route.path.length - 1 }}次
              </div>
            </div>
            <route-price
              :price="getTotalPrice(route)"
              @buy="handleBuy(route)"
            ></route-price>
            <div v-for="(segment, index) in route.path" :key="index" class="segment">
              <el-row :gutter="28" class="route-details">
                <el-col :span="4" class="column-center">
                  <div>{{ segment.airlineCompanyName }}</div>
                </el-col>
                <el-col :span="8" class="column-center">
                  <div>
                    <el-icon><Location /></el-icon>{{ segment.departureAirport }}
                  </div>
                  <div>{{ segment.startDate }} {{ segment.startTime }}</div>
                </el-col>
                <el-col :span="4" class="column-center arrow">
                  <i class="el-icon-arrow-right">→→→→→→</i>
                </el-col>
                <el-col :span="8" class="column-center">
                  <div>
                    <el-icon><LocationFilled /></el-icon>{{ segment.arrivalAirport }}
                  </div>
                  <div>{{ segment.endDate }} {{ segment.endTime }}</div>
                </el-col>
                <el-col :span="4" class="column-center">
                  <div>余票:{{ segment.number_rest }}张</div>
                </el-col>
              </el-row>
            </div>
            <el-button @click="handleBuy(route)"
              ><el-icon><finished /></el-icon>购票</el-button
            >
          </div>
        </el-col>
      </el-row>
    </div>
    <!-- 分页控件 -->
    <div class="pagination">
      <el-button @click="previousPage()" :disabled="currentPage === 1"
        ><el-icon><DArrowLeft /></el-icon> 上一页</el-button
      >
      <span> {{ currentPage }} / {{ totalPages }} </span>
      <el-button @click="nextPage()" :disabled="currentPage === totalPages"
        >下一页 <el-icon><DArrowRight /></el-icon>
      </el-button>
    </div>
    <div class="button-container">
      <el-button class="cancel-ticket-button" @click="back()"
        ><el-icon><refresh-left /></el-icon>返回</el-button
      >
      <el-button class="refresh-button" @click="refresh()"
        ><el-icon><refresh /></el-icon>刷新</el-button
      >
    </div>
  </div>
  <div class="container" v-else>
    <Tips :title="tipTitle" :promptText="tipPromptText" :imageSrc="tipImageSrc" />
    <div class="button-container">
      <el-button class="cancel-ticket-button" @click="back()"
        ><el-icon><refresh-left /></el-icon>返回</el-button
      >
      <el-button class="refresh-button" @click="refresh()">刷新</el-button>
    </div>
  </div>
</template>

<script lang="ts">
import { defineComponent } from "vue";
import Tips from './Tips.vue';
import {
  type OptionItem,
  type RouteResponse,
  type CityItem,
} from "~/models/general";
import { getAuthHeader } from "~/services/genServ";
import {
  getDealById,
  getTravelOptions,
  getCityById,
  createNewRecord,
} from "~/services/infoServ";
import { message } from "~/tools/messageBox";
import 'cropperjs/dist/cropper.css'; // 引入 Cropper.js 的样式文件
import VueCropper from 'cropperjs';
import Cropper from "cropperjs";
import { ElDropdown, ElDropdownMenu, ElDropdownItem, localeContextKey } from 'element-plus';
import { DArrowLeft, DArrowRight, Finished, RefreshLeft, Refresh, Location, LocationFilled, Money, DataLine, Suitcase, MapLocation } from '@element-plus/icons-vue';
import { finished } from "stream";

export default defineComponent({
  components: {
    Tips,
    ElDropdown,
    ElDropdownMenu,
    ElDropdownItem,
    DArrowLeft,
    DArrowRight,
    Finished,
    RefreshLeft,
    Refresh,
    Location,
    LocationFilled,
    Money,
    DataLine,
    Suitcase,
    MapLocation,
  },
  data: () => ({
    travelRecordId: 0 as number,
    RoutesList: [] as RouteResponse[],
    paginatedRoutes: [] as RouteResponse[],
    currentPage: 1 as number,
    pageSize: 3 as number, // 每页显示的数量
    totalRoutes: 0 as number,
    selectedCity1Id:  0 as number,
    selectedCity2Id: 0 as number,
    departureCity: {} as CityItem,
    arrivalCity: {} as CityItem,
    departureAirport: "" as string,
    arrivalAirport: "" as string,
    airlineCompanyName: null as string | null,
    viaAirport: null as string | null,
    directFlight: true as boolean,
    totalPages: 0 as number,
    searchType: "" as string,
    selectedDate: '',
    totalPrice: 0 as number,
    tipTitle: "啊哦 o(╥﹏╥)o " as string,
    tipPromptText: "很抱歉，没有为您找到合适的出行路线。请尝试修改您的查询条件！" as string,
    tipImageSrc: "/noRecord.jpg" as string,
    tNumber: 0 as number,
  }),
  created() {
    this.query();
  },
  methods: {
    async query(){
      const selectedCity1IdStr = this.$route.query.selectedCity1Id as string;
      this.selectedCity1Id = Number(selectedCity1IdStr);
      let resq = await getCityById(this.selectedCity1Id);
      this.departureCity = resq.data;
      const selectedCity2IdStr = this.$route.query.selectedCity1Id as string;
      this.selectedCity2Id = Number(selectedCity2IdStr);
      const tNumberStr = this.$route.query.tNumber as string;
      this.tNumber = Number(tNumberStr);
      resq = await getCityById(this.selectedCity2Id);
      this.arrivalCity = resq.data;
      this.departureAirport = this.$route.query.departureAirport as string;
      this.arrivalAirport = this.$route.query.arrivalAirport as string;
      this.airlineCompanyName = this.$route.query.airlineCompanyName as string | null;
      this.viaAirport = this.$route.query.viaAirport as string | null;
      this.directFlight = (this.$route.query.directFlight === "true");
      this.searchType = this.$route.query.searchType as string;
      this.selectedDate = this.$route.query.startDateString as string;
      let res = await getTravelOptions({
        departureAirport: this.departureAirport,
        arrivalAirport: this.arrivalAirport,
        startDateString: this.selectedDate,
        airlineCompanyName: this.airlineCompanyName,
        viaAirport: this.viaAirport,
        directFlight: this.directFlight,
        searchType: this.searchType,
      });
      this.RoutesList = res.data;
      console.log(res.data);
      if( res.data !== null ) {
        this.paginatedRoutes = res.data.slice(0, this.pageSize);
        this.totalRoutes = this.RoutesList.length;
        this.totalPages = this.getTotalPages();
      }
      console.log(this.paginatedRoutes.length);
    },
    refresh(){
      this.query();
    },
    back(){
      this.$router.back();
    },
    previousPage() {
      if (this.currentPage > 1) {
        this.currentPage--;
        this.updatePagination();
      }
    },

    nextPage() {
      if (this.currentPage < this.totalPages) {
        this.currentPage++;
        this.updatePagination();
      }
    },

    updatePagination() {
      const startIndex = (this.currentPage - 1) * this.pageSize;
      this.paginatedRoutes = this.RoutesList.slice(startIndex, startIndex + this.pageSize);
    },

    getTotalPages(): number {
      return Math.ceil(this.totalRoutes / this.pageSize);
    },
    getTotalPrice(route : RouteResponse) : number {
      let tp = 0;
      for (const segment of route.path) {
        tp += segment.price; // 累加每个航段的价格到总价格
      }
      this.totalPrice = tp;
      return tp;
    },
    async handleBuy(route: RouteResponse) {
      // 处理购买按钮点击事件的方法，传递航线数据给新页面
      // 在这里可以实现跳转或者其他购买相关的逻辑
      let res = await createNewRecord({
        departureAirport: this.departureAirport,
        arrivalAirport: this.arrivalAirport,
      });
      console.log(res.data);
      if (res.code != 0) {
        message(this, res.msg);
        return;
      }
      this.travelRecordId = Number(res.data);
      this.$router.push({ path: '/BuyTicket', query: {
        route: JSON.stringify(route) as string,
        travelRecordId: this.travelRecordId,
        tNumber: this.tNumber,
        selectedCity1Id: this.selectedCity1Id,
        selectedCity2Id: this.selectedCity2Id,
        departureAirport: this.departureAirport,
        arrivalAirport: this.arrivalAirport,
        startDateString: this.selectedDate,
        airlineCompanyName: this.airlineCompanyName,
        viaAirport: this.viaAirport,
        directFlight: this.directFlight.toString(),
        searchType: this.searchType,
       }
      });
      console.log("购买航线：", JSON.stringify(route) as string);
    },
    openGoogleMaps(Airport1: string, Airport2: string) {
      // 获取起点和终点
      const departureAirport = Airport1;
      const arrivalAirport = Airport2;

      // 生成Google Maps URL
      const googleMapsUrl = `https://www.google.com/maps/dir/?api=1&origin=${encodeURIComponent(departureAirport)}&destination=${encodeURIComponent(arrivalAirport)}`;

      // 打开新窗口
      window.open(googleMapsUrl, '_blank');
    },
  },
});
</script>

<style scoped>
.newBase_title {
  margin-top: 12px;
  margin-left: 8px;
  font-family: SourceHanSansCN-Medium;
  font-size: 25px;
  color: #202020;
  letter-spacing: 0;
  font-weight: bold;
}

.container {
  max-width: 800px;
  margin: 0 auto;
  padding: 20px;
  font-family: Arial, sans-serif; /* 设置整体字体 */
  background-color: #f0f0f0; /* 设置背景颜色 */
  margin-top: 20px;
}

.route-list {
  margin-top: 20px;
}

.route-item {
  border: 1px solid #ccc;
  border-radius: 5px;
  padding: 15px;
  margin-bottom: 20px;
  background-color: #fff;
  box-shadow: 0 2px 5px rgba(0, 0, 0, 0.1); /* 添加阴影效果 */
}

.city-info {
  position: relative;
  background-color: #f0f0f0;
  padding: 10px;
  border-radius: 5px;
  margin-bottom: 10px;
}

.map-button {
  position: absolute;
  top: 10px; /* 离顶部的距离 */
  right: 10px; /* 离右边的距离 */
  z-index: 10; /* 确保按钮在最上层 */
  padding: 6px 12px; /* 按钮的内边距 */
  background-color: #c3d5dc; /* 淡蓝色背景 */
  color: #000;
}

.map-button:hover {
  background-color: #6aa5d5; /* 淡蓝色的悬停效果 */
}

.city-info > div {
  margin-bottom: 5px;
}

.route-details {
  display: flex;
  flex-wrap: wrap;
  margin-top: 10px;
}

.segment {
  flex: 1 1 calc(50% - 10px); /* 让 segment 横向两列显示 */
  padding: 10px;
  margin-bottom: 5px;
  background-color: #f9f9f9;
  border-radius: 3px;
}

.segment-info {
  flex: 1;
  display: flex;
  flex-direction: column;
}

.segment-info > div {
  margin-bottom: 5px;
}

.arrow {
  display: flex;
  align-items: center;
  justify-content: center;
  height: 100%;
}

.arrow i {
  font-size: 24px; /* 调整箭头图标的大小 */
  color: #ccc; /* 箭头图标的颜色 */
}

.arrow-icon {
  height: 1em; /* 高度与文字相同 */
  width: auto; /* 自动调整宽度以保持比例 */
  vertical-align: middle; /* 图片与文字对齐 */
  margin-right: 4px; /* 右侧外边距，控制图片与文字间的距离（对于上一页按钮） */
  margin-left: 4px; /* 左侧外边距，控制图片与文字间的距离（对于下一页按钮） */
}

.pagination {
  margin-top: 20px;
  text-align: center;
}

.pagination button {
  margin: 0 5px;
  cursor: pointer;
  background-color: #0044ff76;
  color: #fff;
  border: none;
  padding: 8px 15px;
  border-radius: 3px;
  transition: background-color 0.3s ease;
}

.pagination button:hover {
  background-color: #0056b3;
}

.button-container {
  display: flex;
  justify-content: space-between; /* 将按钮分散到容器的两端 */
  align-items: center; /* 垂直居中对齐 */
  margin-top: 20px; /* 使按钮容器距离上面的内容有一定间距 */
}

.cancel-ticket-button {
  background-color: #ff6347;
  color: #fff;
  border: none;
  padding: 12px 25px;
  border-radius: 5px;
  cursor: pointer;
  font-size: 18px;
  margin-left: 10px;
  transition: background-color 0.3s ease;
}

.refresh-button {
  background-color: #d0eaff; /* 淡蓝色背景 */
  color: #000; /* 黑色字体 */
  border: none;
  padding: 12px 25px;
  border-radius: 5px;
  cursor: pointer;
  font-size: 18px;
  margin-right: 10px; /* 使按钮之间有间距 */
  transition: background-color 0.3s ease;
}

.refresh-button:hover {
  background-color: #a0c6e5; /* 淡蓝色的悬停效果 */
}

.cancel-ticket-button:hover {
  background-color: #ff3b30;
}

.column-center {
  display: flex;
  flex-direction: column;
  justify-content: center;
  align-items: center;
}
</style>
