<template>
  <div class="qq-interface">
    <!-- 左侧用户列表区域 -->
    <div class="user-list">
      <el-card class="user-filter">
        <el-select
          v-model="selectedRole"
          placeholder="选择用户类型"
          style="width: 100%"
          @change="fetchUsers"
        >
          <el-option label="用户" value="用户"></el-option>
          <el-option label="航空公司" value="航空公司"></el-option>
          <el-option label="管理员" value="管理员"></el-option>
        </el-select>
      </el-card>

      <el-menu
        class="el-menu-vertical-demo user-list-content"
        background-color="#ffffff"
        text-color="#333333"
        active-text-color="#409EFF"
        v-if="users.length > 0"
      >
        <el-menu-item v-for="user in users" :key="user.MuserId" @click="selectUser(user)">
          <el-icon v-if="user.name === '管理员'"><platform /></el-icon>
          <el-icon v-else-if="user.name.includes('航空')"><promotion /></el-icon>
          <el-icon v-else><user /></el-icon>
          {{ user.name }} - {{ user.num }}
          <el-badge
            v-if="hasUnreadMessage(user)"
            value="有未读消息"
            class="unread-badge"
            type="danger"
          ></el-badge>
        </el-menu-item>
      </el-menu>

      <el-button type="danger" @click="refresh()" class="refresh-button"
        ><el-icon><refresh /></el-icon>刷新</el-button
      >
    </div>

    <!-- 右侧聊天区域 -->
    <div class="chat-area">
      <el-card class="chat-header" v-if="selectedUser">
        <h3>与 {{ selectedUser.name }} 的对话 --- 共{{ messages.length }}条消息记录</h3>
      </el-card>

      <el-card class="chat-header1" v-else>
        <h3 style="margin-top: 0px">
          ⠄⠄⠄⠄⢠⣿⣿⣿⣿⣿⢻⣿⣿⣿⣿⣿⣿⣿⣿⣯⢻⣿⣿⣿⣿⣆⠄⠄⠄&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
          ⣿⢟⣽⣿⣿⣿⣿⣫⡾⣵⣿⣿⣿⠃⠄⠄⠘⢿⣿⣾⣿⣿⣿⢿⣿<br />
          ⠄⠄⣼⢀⣿⣿⣿⣿⣏⡏⠄⠹⣿⣿⣿⣿⣿⣿⣿⣿⣧⢻⣿⣿⣿⣿⡆⠄⠄&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
          ⢫⣿⣿⣿⣿⡿⣳⣿⣱⣿⣿⣿⡋⠄⠄⠄⠄⠄⠛⠛⠋⠁⠄⠄⣿<br />
          ⠄⠄⡟⣼⣿⣿⣿⣿⣿⠄⠄⠄⠈⠻⣿⣿⣿⣿⣿⣿⣿⣇⢻⣿⣿⣿⣿⠄⠄&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
          ⣿⣿⣿⣿⡿⣹⡿⣃⣿⣿⣿⢳⠁⠄⠄⠄⢀⣀⠄⠄⠄⠄⠄⢀⣿<br />
          ⠄⢰⠃⣿⣿⠿⣿⣿⣿⠄⠄⠄⠄⠄⠙⠿⣿⣿⣿⣿⣿⣿⠄⢿⣿⣿⣿⡄⠄&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
          ⡿⣿⣿⣿⢡⣫⣾⢸⢿⣿⡟⣿⣶⡶⢰⣿⣿⣿⢷⠄⠄⠄⠄⢼⣿<br />
          ⠄⢸⢠⣿⣿⣧⡙⣿⣿⡆⠄⠄⠄⠄⠄⠄⠈⠛⢿⣿⣿⡇⠸⣿⡿⣸⡇⠄&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
          ⣽⣿⣿⠃⣲⣿⣿⣸⣷⡻⡇⣿⣿⢇⣿⣿⣿⣏⣎⣸⣦⣠⡞⣾⢧<br />
          ⠄⠈⡆⣿⣿⣿⣿⣦⡙⠳⠄⠄⠄⠄⠄⢀⣠⣤⣀⣈⠙⠃⠄⠿⢇⣿⡇⠄&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
          ⣿⣿⡏⣼⣿⣿⡏⠙⣿⣿⣤⡿⣿⢸⣿⣿⢟⡞⣰⣿⣿⡟⣹⢯⣿<br />
          ⠄⠄⡇⢿⣿⣿⣿⣿⡇⠄⠄⠄⣠⣶⣿⣿⣿⣿⣿⣿⣿⣷⣆⡀⣼⣿⡇⠄&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
          ⣿⣿⣸⣿⣿⣿⣿⣦⡈⠻⣿⣿⣮⣿⣿⣯⣏⣼⣿⠿⠏⣰⡅⢸⣿<br />
          ⠄⠄⢹⡘⣿⣿⣿⢿⣷⡀⠄⢀⣴⣾⣟⠉⠉⣽⣿⣿⣿⣿⠇⢹⣿⠃⠄&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
          ⣿⣇⣿⣿⡿⠛⠛⠛⠛⠄⣘⣿⣿⣿⣿⣿⣿⣶⣿⠿⠛⢾⡇⢸⣿<br />
          ⠄⠄⠄⢷⡘⢿⣿⣎⢻⣷⠰⣿⣿⣿⣿⣦⣀⣴⣿⣿⣿⠟⢫⡾⢸⡟⠄.&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
          ⣿⢻⣿⣿⣷⣶⣾⣿⣿⣿⣿⣿⣿⣿⣿⣿⡋⠉⣠⣴⣾⣿⡇⣸⣿<br />
          ⠄⠄⠄⠄⠻⣦⡙⠿⣧⠙⢷⠙⠛⠿⢿⡿⠿⠛⠋⠉⠂⠘⠁⠞⠄⠄⠄&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
          ⣿⢸⢻⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣄⠘⢿⣿⠏⠄⣿⣿<br />
          ⠄⠄⠄⠄⠄⠈⠙⠑⣠⣤⣴⡖⠄⠿⣋⣉⣉⡁⠄⢾⣦⠄⠄⠄⠄⠄⠄&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
          ⣿⠸⣿⣿⣿⣿⣿⣿⠿⠿⢿⣿⣿⣿⣿⣿⣿⣿⣦⣼⠃⠄⢰⣿⣿<br />
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
          ⣿⡄⠙⢿⣿⣿⡿⠁⠄⠄⠄⠄⠉⣿⣿⣿⣿⣿⣿⡏⠄⢀⣾⣿⢯<br />
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
          ⣿⡇⠄⠄⠙⢿⣀⠄⠄⠄⠄⠄⣰⣿⣿⣿⣿⣿⠟⠄⠄⣼⡿⢫
        </h3>
      </el-card>

      <div class="chat-container" v-if="selectedUser">
        <div
          v-for="message in messages"
          :key="message.time"
          class="chat-message"
          :class="message.from === info.name ? 'sent' : 'received'"
        >
          <div class="message-name">{{ message.from }}:</div>
          <div class="msg-bubble">
            {{ message.content }}
            <div class="message-info">——— {{ message.time }}</div>
          </div>
        </div>
      </div>

      <div class="chat-input-area" v-if="selectedUser">
        <el-input
          v-model="content"
          type="text"
          class="chat-input"
          placeholder="输入消息"
        ></el-input>
        <el-button type="primary" @click="send()">发送</el-button>
        <el-button @click="backPage()">返回</el-button>
      </div>

      <div class="chat-placeholder" v-else>
        <p>请选择一个用户开启聊天</p>
      </div>
    </div>

    <!-- 弹出消息详情 -->
    <el-dialog :visible.sync="showMessageModal" title="消息详情" width="30%">
      <p>{{ selectedMessage.content }}</p>
      <span>{{ selectedMessage.time }}</span>
    </el-dialog>
  </div>
</template>

<!--<template>
  <div class="base_form">
    <div class="main3 flex-col" v-if="pageType === 1">
      <select v-model="selectedRole">
        <option value="用户">用户</option>
        <option value="航空公司">航空公司</option>
        <option value="管理员">管理员</option>
      </select>
      <button
        @click="fetchUsers()"
        style="background-color: rgb(164, 33, 33); cursor: pointer"
      >
        筛选
      </button>

      <div v-if="users.length > 0">
        <div style="display: none" v-for="user in users" :key="user.MuserId">
          {{ getMessages(user) }}
        </div>
        <ul>
          <li v-once v-for="user in users" :key="user.MuserId" @click="selectUser(user)">
            {{ user.name }} - {{ user.num }}
            <span v-if="hasUnreadMessage(user)">（有未读消息）</span>
          </li>
        </ul>
      </div>
      <button
        @click="refresh()"
        style="background-color: rgb(164, 33, 33); cursor: pointer"
      >
        刷新
      </button>
    </div>

    <div class="main3 flex-col" v-if="pageType === 2">
      <div v-if="selectedUser" style="width: 700px">
        <div class="chat-header">
          <h3>与{{ selectedUser.name }}的对话</h3>
        </div>
        <div class="chat-container" style="overflow: auto">
          <div class="modal-content" v-for="message in messages" :key="message.time">
            <div
              v-if="message.from === info.name"
              style="width: 400px; height: auto; margin-left: 300px"
            >
              <div class="sentName" style="text-align: right">{{ message.from }}:</div>
              <div class="msg-bubble sent" @click="showMessage(message)">
                {{ message.content }}
                <div class="message-info sentTime">————{{ message.time }}</div>
              </div>
            </div>
            <div v-else style="width: 400px; height: auto">
              <div class="receiveName">{{ message.from }}:</div>
              <div class="msg-bubble received" @click="showMessage(message)">
                {{ message.content }}
                <div class="message-info receiveTime">————{{ message.time }}</div>
              </div>
            </div>
          </div>
        </div>
        <div class="chat-input">
          <input class="inputWidth" v-model="content" type="text" required />
          <div>
            <button @click="send()">发送</button>
            <div></div>
            <button @click="backPage()" style="margin-top: 2px">返回上一页</button>
          </div>
        </div>
        <div class="chat-container1" v-if="showMessageModal">
          <div class="modal-content">
            <span class="close" @click="closeMessageModal()">&times;</span>
            <div class="message-content">{{ selectedMessage.content }}</div>
            <div class="message-info">{{ selectedMessage.time }}</div>
          </div>
        </div>
      </div>
    </div>
  </div>
</template>
-->

<script lang="ts">
import { create } from "domain";
import { defineComponent } from "vue";
import { MUser, Message } from "~/models/general";
import {
  getCurrentUserData,
  fetchUsersData,
  sendMessage,
  findMessages,
  changeStatus,
  getMessages,
} from "~/services/infoServ";
import { message } from "~/tools/messageBox";
import {
  ElInput,
  ElDialog,
  ElButton,
  ElCard,
  ElSelect,
  ElOption,
  ElMenu,
  ElMenuItem,
  ElBadge,
} from "element-plus";
import { User, Promotion, Platform, Refresh, Upload } from "@element-plus/icons-vue";

export default defineComponent({
  name: "MessageCenter",
  components: {
    ElInput,
    ElDialog,
    ElButton,
    ElCard,
    ElSelect,
    ElOption,
    ElMenu,
    ElMenuItem,
    ElBadge,
    User,
    Promotion,
    Platform,
    Refresh,
    Upload,
  },
  data: () => ({
    selectedRole: "请选择用户类型" as string,
    MuserId: null as number | null,
    info: {} as MUser,
    users: [] as MUser[],
    selectedUser: null as MUser | null,
    messages: [] as Message[],
    messages1: [] as Message[],
    selectedMessage: {} as Message,
    content: "",
    pageType: 1,
    showMessageModal: false as boolean,
  }),
  created() {
    this.query();
  },
  methods: {
    async query() {
      // 在页面创建时获取当前用户信息
      this.pageType = 1;
      let res = await getCurrentUserData(this.MuserId);
      if (res.code !== 0) {
        console.error("Failed to get current user data", res.msg);
        return;
      }
      this.info = res.data.info;
      this.MuserId = this.info.MuserId;
    },
    formattedUsers(): MUser[] {
      return this.users.map((user) => {
        // 在这里处理每个用户的逻辑
        return {
          MuserId: user.MuserId,
          name: user.name,
          num: user.num,
          email: user.email,
        };
      });
    },
    async fetchUsers() {
      // 获取符合指定角色的用户列表
      const res = await fetchUsersData(this.selectedRole);
      if (res.code !== 0) {
        console.error("Failed to fetch users", res.msg);
        message(this, res.msg);
        return;
      }
      message(this, "筛选成功");
      this.users = res.data.users;
    },
    async selectUser(user: MUser) {
      // 选择用户，并获取与该用户的消息记录
      this.selectedUser = user;
      this.messages = []; // 清空消息列表
      const resp = await findMessages({
        from: user.name,
        to: this.info.name,
      });
      if (resp.code !== 0) {
        console.error("Failed to find messages", resp.msg);
        message(this, resp.msg);
        return;
      }
      this.messages = resp.data.messages.concat(resp.data.messages1);
      this.messages.sort((a, b) => {
        const timestampA = Date.parse(a.time);
        const timestampB = Date.parse(b.time);
        return timestampA - timestampB;
      }); // 按时间排序

      // 找到未读消息并调用后端接口将其标记为已读
      const unreadMessages = this.messages.filter(
        (message) => message.from === user.name && !message.ifRead
      );

      for (const msg of unreadMessages) {
        const changeStatusResp = await changeStatus(msg.messageId);

        if (changeStatusResp.code !== 0) {
          console.error("Failed to change message status", changeStatusResp.msg);
        } else {
          // 更新本地消息状态
          msg.ifRead = true;
          console.log("更新状态成功");
        }
      }

      console.log(this.messages);
      this.pageType = 2;
    },
    async send() {
      // 发送消息
      if (!this.selectedUser) {
        message(this, "未选择用户！");
        return;
      }
      const res = await sendMessage({
        from: this.info.name,
        to: this.selectedUser.name,
        content: this.content,
      });
      if (res.code !== 0) {
        console.error("Failed to send message", res.msg);
        message(this, res.msg);
        return;
      }
      message(this, "发送成功");
      this.selectUser(this.selectedUser);
    },
    async getMessages(user: MUser) {
      const res = await getMessages(user.name);
      console.log(res.data.messages);
      this.messages = res.data.messages;
    },
    hasUnreadMessage(user: MUser): boolean {
      // 判断用户是否有未读消息
      const unreadMessages = this.messages.filter((message) => {
        return (
          message.from === user.name && message.to === this.info.name && !message.ifRead
        );
      });
      console.log(unreadMessages.length);
      return unreadMessages.length > 0;
    },
    refresh() {
      // 刷新页面
      this.fetchUsers();
      message(this, "刷新成功");
    },
    backPage() {
      this.selectedRole = "用户";
      this.users = [] as MUser[];
      this.selectedUser = null as MUser | null;
      this.messages = [] as Message[];
      this.selectedMessage = {} as Message;
      this.content = "";
      this.showMessageModal = false as boolean;
      this.pageType = 1;
      this.query();
    },
    showMessage(message: Message) {
      this.selectedMessage = message;
      this.showMessageModal = true;
    },
    async closeMessageModal() {
      const res = await changeStatus(this.selectedMessage.messageId);
      if (res.code != 0) {
        console.error("Failed to send message", res.msg);
        message(this, res.msg);
        return;
      } else {
        message(this, "OK");
        this.showMessageModal = false;
        this.selectedMessage = {} as Message;
        this.pageType = 2;
      }
    },
  },
});
</script>

<style scoped>
.qq-interface {
  display: flex;
  height: 100vh;
  background-color: #f5f7fa;
}

.user-list {
  width: 30%;
  background-color: #ffffff;
  border-right: 1px solid #e0e0e0;
  padding: 20px;
  box-sizing: border-box;
}

.user-filter {
  margin-bottom: 20px;
  text-align: center;
}

.user-list-content {
  max-height: calc(100vh - 180px);
  overflow-y: auto;
}

.unread-badge {
  float: right;
  margin-top: -5px;
}

.refresh-button {
  margin-top: 20px;
  width: 100%;
}

.chat-area {
  flex: 1;
  width: 70%;
  display: flex;
  flex-direction: column;
  padding: 20px;
  background-color: #ffffff;
  box-sizing: border-box;
}

.chat-header {
  margin-bottom: 10px;
  padding: 10px;
  border-radius: 2px;
  background-color: #6c1e8e;
  color: #ffffff;
}

.chat-header1 {
  margin-top: 0px;
  padding: 1px;
  border-radius: 2px;
  height: 700px;
  background-color: #5f6062;
  color: #ffffff;
}

.chat-header h3 {
  filter: contrast(2); /* 增强对比度 */
  text-shadow: 1px 1px 2px black; /* 添加阴影，使文字更明显 */
  font-family: monospace; /* 使用等宽字体以保持字符的对齐 */
}

.chat-container {
  flex: 1;
  overflow-y: auto;
  padding: 10px;
  background-color: #f9f9f9;
  border-radius: 4px;
  margin-bottom: 20px;
  box-shadow: inset 0 1px 3px rgba(0, 0, 0, 0.1);
}

.chat-message {
  margin-bottom: 15px;
}

.chat-message.sent {
  text-align: right;
}

.chat-message.received {
  text-align: left;
}

.message-name {
  font-weight: bold;
  margin-bottom: 5px;
}

.msg-bubble {
  display: inline-block;
  padding: 10px;
  border-radius: 5px;
  background-color: #d1e7dd;
  max-width: 70%;
  word-wrap: break-word;
  line-height: 1.6;
}

.chat-message.received .msg-bubble {
  background-color: #f8d7da;
}

.chat-input-area {
  display: flex;
  align-items: center;
  gap: 10px;
}

.chat-input {
  flex: 1;
}

.chat-placeholder {
  display: flex;
  justify-content: center;
  align-items: center;
  height: 100%;
  color: #aaa;
  font-size: 18px;
}
</style>
