<template>
  <div class="base_form">
    <div class="base_header">
      <div class="blue_column"></div>
      <div class="base_title">系统主页</div>
    </div>
    <div style="padding-bottom: 20px">
      <div style="margin: 10px 0">
        <el-carousel
          :interval="3000"
          type="card"
          :height="imgHeight"
          indicator-position="outside"
        >
          <el-carousel-item v-for="(item, index) in carouselItems" :key="index">
            <div v-if="item.type === 'image'" style="text-align: center">
              <img
                :src="item.src"
                ref="imgH"
                alt=""
                @load="imgLoad"
                style="width: 90%; height: 100%; object-fit: cover; cursor: pointer"
                @click="handleImageClick(index)"
              />
            </div>
          </el-carousel-item>
        </el-carousel>
      </div>

      <!-- Modal Dialog for Image -->
      <div v-if="showImageModal" class="modal">
        <span class="close" @click="closeModal()">&times;</span>
        <el-image class="modal-content" :src="selectedImageSrc" lazy />
      </div>
    </div>
    <div>
      <div
        style="
          margin: 10px 0;
          padding: 20px;
          background-color: #fff;
          border-radius: 10px;
          font-family: 'Arial', sans-serif;
        "
      >
        <div
          style="
            padding: 10px 0;
            font-size: 28px;
            color: #67c23a;
            font-family: 'Times New Roman', serif;
          "
        >
          <el-icon><fold /></el-icon>公告列表
        </div>
        <el-collapse v-model="active">
          <el-collapse-item
            v-for="(item, index) in urgentNotices"
            :key="index"
            :title="item.title"
            :name="'Urgent-' + index"
          >
            <template slot="title">
              <span style="font-size: 18px; color: #666">{{ item.title }}</span>
            </template>
            <div style="color: #888">{{ item.content }}</div>
          </el-collapse-item>
          <el-collapse-item
            v-for="(item, index) in normalNotices"
            :key="index"
            :title="item.title"
          >
            <template slot="title">
              <span style="font-size: 18px; color: #666">{{ item.title }}</span>
            </template>
            <div style="color: #888">{{ item.content }}</div>
          </el-collapse-item>
        </el-collapse>
      </div>

      <div style="margin: 10px 0">
        <div
          style="
            display: flex;
            justify-content: space-between;
            align-items: center;
            padding: 20px 10px;
            font-size: 28px;
            background-color: #fff;
            border-radius: 10px;
            color: #3f5efb;
            font-family: 'Verdana', sans-serif;
          "
        >
          <div>
            <el-icon><picture-rounded /></el-icon>热门旅游景点
          </div>
          <el-input
            v-model="searchQuery"
            placeholder="输入景点名称进行搜索"
            clearable
            @clear="clearSearch"
            style="max-width: 300px"
          >
            <template #prepend>
              <el-icon><Search /></el-icon>
            </template>
            <template #append>
              <el-button
                type="primary"
                @click="searchSpot"
                :disabled="userInfo.roles != 'ROLE_CLIENT'"
                >搜索</el-button
              >
            </template>
          </el-input>
        </div>
        <el-card
          v-for="spot in paginatedSpots"
          :key="spot.spotId"
          style="margin: 10px 0; font-family: 'Arial', sans-serif"
        >
          <div style="display: flex">
            <div style="width: 310px">
              <img
                :src="`${spot.name}.jpg`"
                alt=""
                style="width: 100%; height: 160px; border-radius: 10px"
              />
            </div>
            <div style="padding-left: 50px; flex: 1">
              <div
                style="
                  display: flex;
                  justify-content: space-between;
                  border-bottom: 1px solid #ddd;
                  width: 100%;
                  padding-bottom: 10px;
                "
              >
                <div>
                  <span
                    style="font-size: 24px; cursor: pointer"
                    :style="{
                      color: isHovering ? '#1e90ff' : '#000000',
                      textDecoration: isHovering ? 'underline' : 'none',
                    }"
                    @mouseover="isHovering = true"
                    @mouseleave="isHovering = false"
                    @click="userInfo.roles === 'ROLE_CLIENT' ? goToSpot(spot.name) : null"
                  >
                    {{ spot.name }}
                  </span>
                  <span style="margin-left: 20px">{{ spot.category }}</span>
                  <span style="margin-left: 20px">{{ spot.rating }} / 5 星</span>
                </div>
                <el-button
                  type="primary"
                  class="map-button"
                  @click="openGoogleMaps(spot.name)"
                >
                  <el-icon><MapLocation /></el-icon>
                </el-button>
              </div>
              <div style="line-height: 30px">
                <div><b style="margin-right: 10px">位置：</b>{{ spot.location }}</div>
                <div>
                  <b style="margin-right: 10px">开放时间：</b>{{ spot.openingHours }}
                </div>
                <div>
                  <b style="margin-right: 10px">门票价格：</b>{{ spot.ticketPrice }}
                </div>
                <div><b style="margin-right: 10px">简介：</b>{{ spot.description }}</div>
              </div>
            </div>
          </div>
        </el-card>
      </div>

      <div style="padding: 10px; background-color: #fff; border-radius: 10px">
        <el-pagination
          @size-change="handleSizeChange"
          @current-change="handleCurrentChange"
          :current-page="pageNum"
          :page-size="pageSize"
          layout="total, prev, pager, next"
          background
          :total="total"
        >
        </el-pagination>
      </div>
    </div>
  </div>
</template>
<script lang="ts">
import { defineComponent } from "vue";
import * as echarts from "echarts";
import { getMainPageData } from "~/services/mainServ";
import { type ChartItem, type UserOnlineItem, type SpotItem} from "~/models/general";
import {
  getSpotList,
} from "~/services/infoServ";
import {
  ElCard,
  ElPagination,
  ElButton,
  ElImage,
  ImageProps,
  ElInput,
  ElIcon,
} from "element-plus";
import { useAppStore } from "~/stores/app";
import { mapState } from "pinia";
import {Fold, PictureRounded, MapLocation,} from '@element-plus/icons-vue'
import { userInfo } from "os";
var echart = echarts;
var onlineUserChart: any;
var userTypeChart: any;
var requestChart: any;
var operateChart: any;

export default defineComponent({
  components: {
    ElCard,
    ElPagination,
    Fold,
    PictureRounded,
    ElButton,
    MapLocation,
    ElImage,
    ElInput,
    ElIcon,
  },
  //数据
  data: () => ({
    onlineUser: {} as UserOnlineItem,
    userTypeList: [],
    requestData: {} as ChartItem,
    operateData: {} as ChartItem,
    tableData: [],
    total: 0,
    pageNum: 1 as number,
    pageSize: 3 as number,
    name: "",
    notices: [
      { id: 1, title: "今日推荐", content: "新的网红景点等您打卡---到达世界最高城：理塘！" },
      { id: 2, title: "紧急事项", content: "伦敦希思罗机场因大雪等异常天气暂时停飞。" },
      { id: 3, title: "名人名言", content: "What can I say,mamba out. --- Kobe Bean Bryant" },
    ],
    active: '0',
    imgHeight:'0',
    carouselItems: [
      { type: 'image', src: 'Climb.jpg' },
      { type: 'image', src: 'Town.jpg' },
      { type: 'image', src: '琅琊山.jpg' },
      { type: 'image', src: '艾雷德尔之烬.jpg' },
      // Add more images or videos as needed
    ],
    showImageModal: false as boolean,
    selectedImageSrc: '' as string,
    spotsList: [] as SpotItem[],
    isHovering: false as boolean,
    searchQuery: "" as string,
  }),
  async created() {
    await this.doQuery();
  },
  mounted () {
    this.imgLoad();
    window.addEventListener("resize",this.imgLoad,false);
  },
  destroyed(){
     window.removeEventListener("resize",this.imgLoad,false);
  },

  computed: {
    ...mapState(useAppStore, ["userInfo"]),
    // 计算属性，根据当前页码和每页显示数量计算出当前页应显示的景点数据
    paginatedSpots() {
      const start = (this.pageNum - 1) * this.pageSize;
      const end = this.pageNum * this.pageSize;
      return this.spotsList.slice(start, end);
    },
    urgentNotices() {
      return this.notices.filter(item => item.title === '紧急事项');
    },
    normalNotices() {
      return this.notices.filter(item => item.title !== '紧急事项');
    },
  },
  methods: {
    //请求后台页面显示的所有数据
    async doQuery() {
      const res = await getMainPageData();
      this.onlineUser = res.data.onlineUser;
      this.userTypeList = res.data.userTypeList;
      this.requestData = res.data.requestData;
      this.operateData = res.data.operateData;

      const Spotres = await getSpotList(0);
      this.spotsList = Spotres.data;
      this.total = this.spotsList.length;
      console.log(this.spotsList);
      //this.drawEcharts();
    },
    clearSearch() {
      this.searchQuery = "";
    },
    searchSpot() {
      this.$router.push({ path: '/SpotShow', query: { spotName: this.searchQuery } });
      this.pageNum = 1;
    },
    goToSpot(spotName: string) {
      this.$router.push({ path: '/SpotShow', query: { spotName: spotName } });
      this.pageNum = 1;
    },
    closeModal() {
      this.showImageModal = false;
    },
    imgLoad(){
      this.$nextTick(()=>{
        const imgRefs = this.$refs.imgH as HTMLImageElement[];
        if (imgRefs && imgRefs.length > 0) {
          this.imgHeight = `${imgRefs[0].height}px`;
          // console.log(this.imgHeight);
        }
      })
    },
    handleImageClick(index: number) {
      this.selectedImageSrc = this.carouselItems[index].src;
      console.log(this.selectedImageSrc);
      this.showImageModal = true;
    },
     // 处理每页条目数量变化
    handleSizeChange(pageSize: number) {
      this.pageSize = pageSize; // 更新每页显示条目数量
      this.pageNum = 1; // 重置页码为1
    },
    // 处理当前页码变化
    handleCurrentChange(pageNum: number) {
      this.pageNum = pageNum; // 更新当前页码
    },
    openGoogleMaps(spotName: string) {
      // 获取景点名称
      const destination = spotName;

      // 生成Google Maps URL
      const googleMapsUrl = `https://www.google.com/maps/search/?api=1&query=${encodeURIComponent(destination)}`;

      // 打开新窗口
      window.open(googleMapsUrl, '_blank');
    },
  },
});
</script>
<style scoped>
.image-container {
  display: flex;
  flex-wrap: wrap;
  justify-content: center;
}

.image-container img {
  width: 200px;
  height: auto;
  margin: 10px;
  cursor: pointer;
}

.modal {
  display: block;
  position: fixed;
  z-index: 999;
  left: 50%; /* 水平居中 */
  top: 50%; /* 垂直居中 */
  transform: translate(-50%, -50%); /* 通过transform属性进行居中 */
  width: 60%;
  height: 60%;
  max-width: 80%; /* 最大宽度为页面宽度的80% */
  max-height: 80%; /* 最大高度为页面高度的80% */
  overflow: auto;
  background-color: rgba(0, 0, 0, 0.9); /* 半透明黑色背景 */
}

.modal-content {
  position: absolute; /* 绝对定位 */
  top: 50%; /* 将顶部定位在模态框的中间 */
  left: 50%; /* 将左侧定位在模态框的中间 */
  transform: translate(-50%, -50%); /* 使用transform来将元素向左上角移动其自身的50% */
  display: block;
  max-width: 95%; /* 设置最大宽度为95%，以适应不同尺寸的图片 */
  max-height: 90%; /* 设置最大高度为90%，以适应不同尺寸的图片 */
  object-fit: contain; /* 图片适应模态框大小，保持宽高比 */
}

.close {
  color: white;
  font-size: 35px;
  font-weight: bold;
  position: absolute;
  top: 15px;
  right: 35px;
  cursor: pointer;
}

.pieChart {
  width: 580px;
  height: 280px;
  margin: 0px auto;
}

.upPart {
  display: flex;
  flex-direction: row;
  margin-top: 2px;
}

.main-one {
  background: white;
  width: 45%;
  height: 350px;
  margin-left: 50px;
  margin-right: 50px;
}

.main-two {
  background: white;
  width: 45%;
  height: 350px;
}

.downPart {
  display: flex;
  flex-direction: row;
  margin-top: 10px;
}

.main-three {
  background: white;
  width: 45%;
  height: 350px;
  margin-left: 50px;
  margin-right: 50px;
}

.main-four {
  background: white;
  width: 45%;
  height: 350px;
}

.header {
  margin-top: 20px;
  margin-left: 40px;
  font-size: 20px;
  color: #3cb371;
  font-weight: bold;
}

.header3 {
  margin-top: 20px;
  margin-left: 40px;
  font-size: 20px;
  color: #d4237a;
  font-weight: bold;
}

.header4 {
  margin-top: 20px;
  margin-left: 40px;
  font-size: 20px;
  color: #1296db;
  font-weight: bold;
}

.headerTwo {
  margin-top: 20px;
  margin-left: 40px;
  font-size: 20px;
  color: #ffa500;
  font-weight: bold;
}

.bottom {
  background: #3cb371;
  height: 2px;
  width: 100%;
  margin-top: 10px;
}

.bottom3 {
  background: #d4237a;
  height: 2px;
  width: 100%;
  margin-top: 10px;
}

.bottom4 {
  background: #1296db;
  height: 2px;
  width: 100%;
  margin-top: 10px;
}

.bottomtwo {
  background: #ffa500;
  height: 2px;
  width: 100%;
  margin-top: 10px;
}

.imageOne {
  width: 40px;
  height: 40px;
}

.main-center {
  display: flex;
  flex-direction: row;
}

.image {
  width: 40px;
  height: 40px;
  margin-left: auto;
  margin-top: 10px;
  margin-right: 20px;
}

.map-button {
  position: relative;
  top: 5px; /* 离顶部的距离 */
  right: 5px; /* 离右边的距离 */
  z-index: 10; /* 确保按钮在最上层 */
  padding: 5px 10px; /* 按钮的内边距 */
  background-color: #c3d5dc; /* 淡蓝色背景 */
  color: #000;
}
</style>
