<template>
  <div class="notification-center" v-if="notificationList.length != 0">
    <el-card class="card">
      <div style="text-align: right; margin-bottom: 10px;">
        <el-button type="danger" @click="deleteAllNotifications">
          删除所有消息记录
        </el-button>
      </div>
      <el-row class="notification-row" :gutter="20">
        <el-col
          :span="8"
          v-for="notification in notificationList"
          :key="notification.notificationId"
          class="notification-col"
        >
          <el-card class="box-card" shadow="always">
            <div slot="header" class="clearfix">
              <span>{{ notification.title }}</span>
              <el-tag
                :type="notification.status === '已读' ? 'success' : 'warning'"
                class="status-tag"
              >
                {{ formatStatus(notification.status) }}
              </el-tag>
            </div>
            <div class="content">
              <p>{{ notification.text }}</p>
              <div class="date">{{ notification.date }}</div>
            </div>
          </el-card>
        </el-col>
      </el-row>
    </el-card>
  </div>
  <div class="notification-center" v-else>
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
import {
  type OptionItem,
  type NotificationItem,
} from "~/models/general";
import { getAuthHeader } from "~/services/genServ";
import {
  getNotificationListByPersonId,
  changeNotificationSave,
  deleteAllNotifications,
} from "~/services/infoServ";
import { message } from "~/tools/messageBox";
import 'cropperjs/dist/cropper.css'; // 引入 Cropper.js 的样式文件
import VueCropper from 'cropperjs';
import Cropper from "cropperjs";
import { ElButton, ElCard, ElTag, ElCol, ElRow, } from 'element-plus';
import {} from '@element-plus/icons-vue'
import Tips from './Tips.vue';

export default defineComponent({
  name: "NotificationCenter",
  components: {
    VueCropper,
    ElButton,
    ElTag,
    ElCard,
    ElCol,
    ElRow,
    Tips,
  },
  data() {
    return {
      loading: false as boolean,
      personId: null as number | null,
      title: "" as string,
      content: "" as string,
      date: "" as string,
      status: "" as string,
      notificationList: [] as NotificationItem[],
      tipTitle: "o(*￣▽￣*)o" as string,
      tipPromptText: "似乎没有通知哦！" as string,
      tipImageSrc: "/NoNotification.jpg" as string,
    };
  },
  created() {
    this.query();
  },
  methods: {
    async query() {
      const personIdStr = this.$route.query.personId as string;
      this.personId = Number(personIdStr);
      console.log(this.personId);
      let res = await getNotificationListByPersonId(this.personId);
      this.notificationList = res.data;
      console.log(res.data);
      this.markAsRead();
    },
    formatStatus(status: string) {
      return status === "未读" ? "🔴 未读" : "🟢 已读";
    },
    async markAsRead() {
      const notificationFilter = this.notificationList.filter(notification => (notification.status === "未读") );
      if (notificationFilter.length > 0) {
        // 使用 Promise.all 并行处理所有请求
        const promises = notificationFilter.map((notification) =>
        changeNotificationSave({
          notificationId: notification.notificationId,
          status: "已读",
        }).then((res) => {
        if (res.code === 0) {
              console.log("修改成功！");
            } else {
              console.log(res.msg);
            }
            return res;
          })
        );

        try {
          const results = await Promise.all(promises);
          console.log("所有通知处理完成！");
        } catch (error) {
          console.log("处理过程中出现错误：", error);
        }
      }
      return;
    },
    goBack(){
      this.$router.back();
    },
    refresh(){
      this.query();
    },
    async deleteAllNotifications(){
      let res = await deleteAllNotifications();
      if (res.code === 0) {
        message(this,"删除成功");
        this.$router.back();
      }else{
        message(this,res.msg);
        return;
      }
    },
  },
});
</script>

<style scoped>
.notification-center {
  padding: 20px;
  background-color: #f5f7fa;
  min-height: 100vh;
  margin-top: 10px;
}

.notification-row {
  display: flex;
  justify-content: center; /* 使列水平居中 */
}

.notification-col {
  display: flex;
  justify-content: center;
}

.el-row {
  margin-left: -10px;
  margin-right: -10px;
}

.el-col {
  padding-left: 10px;
  padding-right: 10px;
}

.el-card {
  margin: 10px 0; /* 添加上下间距使卡片之间留有一定空隙 */
}

.box-card {
  margin-top: 10px;
  box-shadow: 0 2px 12px 0 rgba(0, 0, 0, 0.1);
  width: 100%; /* 让卡片占据列的宽度 */
  max-width: 800px; /* 你可以根据需要调整最大宽度 */
}

.box-card {
  background-color: #ffffff;
  border-radius: 8px;
  overflow: hidden;
  box-shadow: 0 4px 12px rgba(0, 0, 0, 0.1);
  transition: transform 0.3s ease, box-shadow 0.3s ease;
}

.box-card:hover {
  transform: translateY(-5px);
  box-shadow: 0 6px 20px rgba(0, 0, 0, 0.15);
}

.box-card .el-card__header {
  background-color: #409eff;
  color: #ffffff;
  padding: 12px 20px;
  font-size: 16px;
  font-weight: bold;
  border-bottom: none;
}

.box-card .el-card__body {
  padding: 20px;
  color: #666666;
}

.status-tag {
  float: right;
  font-size: 12px;
  padding: 0 10px;
  height: 24px;
  line-height: 24px;
  border-radius: 12px;
}

.content p {
  font-size: 14px;
  line-height: 1.6;
  margin-bottom: 10px;
  color: #333333;
}

.date {
  margin-top: 10px;
  font-size: 12px;
  color: #999999;
  text-align: right;
}

@media (max-width: 1024px) {
  .el-col {
    margin-bottom: 20px;
  }
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
  background-color: #30b0ff;
}

.button-container {
  display: flex;
  justify-content: center;
  margin-bottom: 20px;
}
</style>
