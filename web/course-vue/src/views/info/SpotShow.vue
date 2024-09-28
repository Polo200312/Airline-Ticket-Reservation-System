<template>
  <div class="spot-show-container">
    <el-card v-if="spot && Object.keys(spot).length !== 0" class="spot-card">
      <h2 class="spot-title">꧁༺ {{ spot.name }} ༻꧂</h2>
      <div class="spot-content">
        <el-row :gutter="20">
          <!-- 左侧景点信息 -->
          <el-col :span="16" class="spot-details">
            <div class="spot-description">
              <!-- 原有内容保留 -->
              <p>
                <strong
                  ><el-icon><Management /></el-icon>分类</strong
                >
                {{ spot.category }}
              </p>
              <p>
                <strong
                  ><el-icon><DataAnalysis /></el-icon>星级</strong
                >
                <el-rate
                  v-model="rating"
                  disabled
                  show-score
                  text-color="#ff9900"
                  score-template="{value} / 5星"
                ></el-rate>
              </p>
              <p>
                <strong
                  ><el-icon><Location /></el-icon>地点</strong
                >
                {{ spot.location }}
              </p>
              <p>
                <strong
                  ><el-icon><Clock /></el-icon>开放时间</strong
                >
                {{ spot.openingHours }}
              </p>
              <p>
                <strong>
                  <el-icon><Money /></el-icon>票价</strong
                >
                {{ spot.ticketPrice }}
              </p>

              <!-- 轮播图部分 -->
              <div class="spot-carousel">
                <el-carousel
                  :interval="3000"
                  type="card"
                  :height="imgHeight"
                  indicator-position="outside"
                >
                  <el-carousel-item v-for="(item, index) in carouselItems" :key="index">
                    <div v-if="item.type === 'image'" class="carousel-image">
                      <img
                        :src="item.src"
                        ref="imgH"
                        alt=""
                        style="object-fit: cover"
                        @load="imgLoad"
                        @click="handleImageClick(index)"
                      />
                    </div>
                  </el-carousel-item>
                </el-carousel>
              </div>

              <p><strong>描述</strong> {{ spot.description }}</p>
              <el-button type="primary" @click="goToWikipedia" class="wiki-button">
                <el-icon><Share /></el-icon>查看维基百科
              </el-button>
              <el-button type="success" @click="goToSpotTicket" class="buyTicket-button">
                <el-icon><Goods /></el-icon>购票
              </el-button>
            </div>
          </el-col>

          <!-- 右侧评论区 -->
          <el-col :span="8" class="spot-comments">
            <div class="comments-section">
              <h3>
                <el-icon><Paperclip /></el-icon>相关评论
              </h3>
              <el-divider></el-divider>
              <!-- 设置滚动条控制，当评论数量超过3条时启用 -->
              <div
                class="comments-list"
                :style="{ maxHeight: comments.length > 3 ? '500px' : 'auto' }"
              >
                <div
                  v-for="(comment, index) in comments"
                  :key="index"
                  class="comment-item"
                >
                  <el-rate
                    v-model="comment.rating"
                    disabled
                    text-color="#ff9900"
                  ></el-rate>
                  <p class="comment-text">
                    <strong
                      ><el-icon><User /></el-icon>{{ comment.userName }}</strong
                    >
                    : {{ comment.evaluluate }}
                  </p>
                </div>
              </div>
            </div>
            <el-divider></el-divider>
            <div class="add-comment-section">
              <h4>༄ 下面由我来美言几句 ࿐ེ</h4>
              <el-rate
                v-model="newRating"
                show-score
                text-color="#ff9900"
                score-template="{value} / 5分"
              ></el-rate>
              <el-input
                type="textarea"
                v-model="newComment"
                placeholder="良言结善意，恶语伤人心..."
                autosize
                maxlength="1000"
                show-word-limit
              ></el-input>
              <el-button type="primary" @click="submitComment"
                ><el-icon><EditPen /></el-icon>提交评论</el-button
              >
            </div>
          </el-col>
        </el-row>
      </div>
    </el-card>

    <!-- 无记录提示 -->
    <div v-else class="no-records">
      <Tips :title="tipTitle" :promptText="tipPromptText" :imageSrc="tipImageSrc" />
      <div class="button-container">
        <el-button class="cancel-ticket-button" @click="goBack()">
          <el-icon><RefreshLeft /></el-icon>返回
        </el-button>
        <el-button class="refresh-button" @click="refresh()">
          <el-icon><refresh /></el-icon>刷新
        </el-button>
      </div>
    </div>
  </div>
</template>

<script lang="ts">
import { defineComponent } from "vue";
import Tips from './Tips.vue';
import {
  type OptionItem,
  type SpotItem,
  type SpotEvaluluateItem,
} from "~/models/general";
import { getAuthHeader } from "~/services/genServ";
import {
  getSpotData,
  submitComment,
  getSpotEvaluluateData,
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
import { Search, CirclePlus, Share, Management, Location, DataAnalysis, Clock, Money, Goods, RefreshLeft, Refresh, EditPen, User, Paperclip,} from '@element-plus/icons-vue'

export default defineComponent({
  components: {
    Search,
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
    CirclePlus,
    ElCarousel,
    ElCarouselItem,
    Share,
    Management,
    Location,
    DataAnalysis,
    Clock,
    Money,
    Goods,
    Tips,
    RefreshLeft,
    Refresh,
    EditPen,
    User,
    Paperclip,
  },
  data: () => ({
    name: "" as string,
    spotId: null as number | null,
    spot: {} as SpotItem,
    carouselItems: [] as Array<{ type: string; src: string }>,
    imgHeight:'200px',
    rating: 5 as number,
    tipTitle: "ε=(´ο｀*)))" as string,
    tipPromptText: "抱歉，没有查询到相关信息，请重试！" as string,
    tipImageSrc: "/xf1.jpg" as string,
    comments: [] as SpotEvaluluateItem[], // 评论列表
    newRating: 0 as number, // 新评论评分
    newComment: "" as string, // 新评论内容
  }),
  created(){
    this.query();
  },
  methods: {
    async query(){
      this.name = this.$route.query.spotName as string;
      let res = await getSpotData(this.name);
      console.log(res.data);
      this.spot = res.data.info;
      this.spotId = this.spot.spotId;
      this.rating = Number(this.spot.rating);
      this.carouselItems = [
        { type: 'image', src: this.name + '.jpg' },
        { type: 'image', src: this.name + '1.jpg' },
        { type: 'image', src: this.name + '2.jpg' },
        { type: 'image', src: this.name + '3.jpg' },
      ];
      res = await getSpotEvaluluateData(this.name);
      this.comments = res.data.map((comment: SpotEvaluluateItem) => {
        return {
          ...comment,
          rating: Number(comment.rating) // 将 rating 转换为数字
        };
      });
    },
    imgLoad() {
      this.$nextTick(()=>{
        const imgRefs = this.$refs.imgH as HTMLImageElement[];
        if (imgRefs && imgRefs.length > 0) {
          this.imgHeight = `${imgRefs[0].height}px`;
          // console.log(this.imgHeight);
        }
      })
    },
    goToWikipedia() {
      const wikiUrl = `https://en.wikipedia.org/wiki/${encodeURIComponent(this.spot.name)}`;
      window.open(wikiUrl, '_blank');
    },
    goToSpotTicket() {
      this.$router.push({ path: '/SpotTicket', query: { spotId: this.spotId, spotName: this.spot.name } });
    },
    handleImageClick(index: number) {
      console.log('Image clicked:', index);
    },
    async submitComment(){
      if(this.newComment == undefined || this.newComment == "") {
        message(this, "评论为空,请填写！");
        return;
      }
      if(this.newRating == undefined) {
        message(this, "评分为空,请评价！");
        return;
      }
      let res = await submitComment({
        evaluate: this.newComment,
        rating: this.newRating,
        spotName: this.spot.name,
      });
      if (res.code != 0) {
        message(this, res.msg);
        return;
      } else {
        message(this, "评论成功！");
        this.newComment = "" as string;
        this.newRating = 0 as number;
        this.query();
      }
    },
    goBack(){
      this.$router.back();
    },
    refresh(){
      this.query();
    },
  },
});
</script>

<style scoped>
.spot-show-container {
  padding: 30px;
  background-color: #f0f4f8;
  min-height: 100vh;
  display: flex;
  justify-content: center;
  align-items: center;
}

.spot-card {
  background-color: #fff;
  border-radius: 15px;
  box-shadow: 0 8px 16px rgba(0, 0, 0, 0.1);
  padding: 30px;
  max-width: 1200px;
  width: 100%;
  font-family: "Roboto", sans-serif;
}

.spot-title {
  font-family: "Arial", sans-serif;
  color: #2c3e50;
  font-size: 32px;
  font-weight: 700;
  margin-bottom: 20px;
  text-align: center;
  border-bottom: 2px solid #3f5efb;
  padding-bottom: 10px;
}

.spot-content {
  padding: 20px;
}

.spot-description p {
  font-size: 18px;
  line-height: 1.8;
  color: #34495e;
  margin-bottom: 10px;
}

.spot-carousel {
  margin: 30px 0;
  text-align: center;
  max-height: 1000px;
}

.carousel-image img {
  width: 100%;
  max-width: 600px;
  max-height: 900px;
  cursor: pointer;
  border-radius: 10px;
  transition: transform 0.3s ease;
}

.carousel-image img:hover {
  transform: scale(1.05);
}

.wiki-button {
  display: flex;
  align-items: center;
  justify-content: center;
  margin: 20px auto 0;
  padding: 12px 24px;
  background-color: #3f5efb;
  border-color: #3f5efb;
  color: #fff;
  border-radius: 25px;
  font-size: 16px;
  font-weight: 600;
  text-align: center;
  transition: background-color 0.3s ease;
}

.wiki-button:hover {
  background-color: #2c3e50;
  border-color: #2c3e50;
}

.wiki-button .el-icon-share {
  margin-right: 8px; /* 图标与文字间距 */
  font-size: 18px; /* 调整图标大小 */
  vertical-align: middle;
}

.buyTicket-button {
  display: flex;
  align-items: center;
  justify-content: center;
  margin: 10px auto 0;
  padding: 6px 12px;
  background-color: #48fb3f;
  border-color: #3f5efb29;
  color: #fff;
  border-radius: 25px;
  font-size: 16px;
  font-weight: 400;
  text-align: center;
  transition: background-color 0.3s ease;
}

.buyTicket-button:hover {
  background-color: #2c3e50;
  border-color: #2c3e50;
}

.buyTicket-button .el-icon-share {
  margin-right: 8px; /* 图标与文字间距 */
  font-size: 18px; /* 调整图标大小 */
  vertical-align: middle;
}

.spot-details p strong {
  color: #3f5efb;
}

.spot-description p {
  display: flex;
  justify-content: space-between;
  align-items: center;
  font-size: 16px;
  padding: 10px 0;
  border-bottom: 1px solid #eaeaea;
}

.spot-description p:last-child {
  border-bottom: none;
}

.spot-description {
  margin-bottom: 20px;
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

/* 新增样式 */
.spot-comments {
  background-color: #f9fafb;
  padding: 20px;
  border-radius: 10px;
  box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
}

.comments-section {
  margin-bottom: 20px;
}

.comments-list {
  overflow-y: auto; /* 允许垂直方向出现滚动条 */
}

.comment-item {
  margin-bottom: 15px;
}

.comment-text {
  font-size: 16px;
  color: #34495e;
  margin-bottom: 5px;
  word-break: break-word; /* 确保长单词或链接能够换行 */
  overflow-wrap: break-word; /* 确保文本可以在边界内换行 */
  white-space: normal; /* 允许换行 */
}

.add-comment-section {
  text-align: center;
}

.add-comment-section h4 {
  margin-bottom: 10px;
}

.add-comment-section .el-input {
  margin-bottom: 10px;
}

.add-comment-section .el-button {
  margin-top: 10px;
  background-color: #3f5efb;
  border-color: #3f5efb;
  color: #fff;
  border-radius: 5px;
  transition: background-color 0.3s ease;
}

.add-comment-section .el-button:hover {
  background-color: #2c3e50;
  border-color: #2c3e50;
}
</style>
