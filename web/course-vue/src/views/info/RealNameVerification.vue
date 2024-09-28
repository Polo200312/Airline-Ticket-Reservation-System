<template>
  <div class="authentication-form">
    <h1 class="form-title">实名认证</h1>

    <!-- Step 1: 输入真实姓名 -->
    <div v-if="currentStep === 1" class="form-step">
      <label for="realname" class="input-label">真实姓名</label>
      <input
        id="realname"
        type="text"
        v-model="realName"
        class="input-field"
        placeholder="请输入您的真实姓名"
        required
      />
      <button @click="nextStep" class="next-button">下一步</button>
    </div>

    <!-- Step 2: 输入身份证号码 -->
    <div v-if="currentStep === 2" class="form-step">
      <label for="idcard" class="input-label">身份证号码</label>
      <input
        id="idcard"
        type="text"
        v-model="idNumber"
        class="input-field"
        placeholder="请输入您的身份证号码"
        required
      />
      <button @click="submitForm" class="submit-button">提交</button>
      <button @click="prevStep" class="prev-button">上一步</button>
    </div>

    <!-- 确认框组件 -->
    <div class="confirm-dialog" v-if="showConfirmDialog">
      <div class="confirm-dialog-content">
        <span>请再次确认您的个人信息</span>
        <p><strong>您的姓名：</strong>{{ realName }}</p>
        <p><strong>身份证号：</strong>{{ idNumber }}</p>
        <div class="confirm-dialog-buttons">
          <button @click="handleConfirm()">确认</button>
          <button @click="handleCancel()">取消</button>
        </div>
      </div>
    </div>
  </div>
</template>

<script lang="ts">
import { defineComponent } from 'vue';
import {
  type OptionItem,
  type ClientItem,
} from "~/models/general";
import axios from 'axios';
import { downloadPost } from "~/services/genServ";
import { message } from "~/tools/messageBox";
import {
  changeClientIDAndName,
  getClientData,
} from "~/services/infoServ";

export default defineComponent({
  data: () => ({
    clientId: null as number | null,
    info: {} as ClientItem,
    currentStep: 1,
    realName: '' as string,
    idNumber: '' as string,
    showConfirmDialog: false,
  }),
  async created() {
    const clientIdStr = this.$route.query.clientId as string;
    this.clientId = Number(clientIdStr);
    console.log(this.clientId);
    let res = await getClientData(this.clientId);
    this.info = res.data.info;

  },
  methods: {
    nextStep() {
      this.currentStep++;
    },
    prevStep() {
      this.currentStep--;
    },
    submitForm() {
      this.openConfirmDialog();
    },
    openConfirmDialog() {
      this.showConfirmDialog = true;
    },
    handleCancel() {
    // 取消操作，直接关闭对话框，不进行任何确认操作
        this.showConfirmDialog = false;
    },
    async handleConfirm(){
        let res = await changeClientIDAndName({
            clientId: this.clientId,
            realName: this.realName,
            idNumber: this.idNumber,
        });
        if (res.code != 0) {
        message(this, res.msg);
        return;
      } else {
        message(this, "修改成功！");
        location.reload();
      }
    },
  }
});
</script>

<style scoped>
.authentication-form {
  max-width: 400px;
  margin: 50px auto;
  padding: 20px;
  background-color: #f8f9fa;
  border: 1px solid #ced4da;
  border-radius: 5px;
  box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
}

.form-title {
  font-size: 24px;
  text-align: center;
  margin-bottom: 20px;
}

.form-step {
  margin-bottom: 20px;
}

.input-label {
  font-size: 16px;
  margin-bottom: 5px;
  display: block;
}

.input-field {
  width: 100%;
  padding: 10px;
  font-size: 16px;
  border: 1px solid #ced4da;
  border-radius: 3px;
}

.next-button,
.submit-button,
.prev-button {
  display: block;
  width: 100%;
  padding: 10px;
  margin-top: 10px;
  background-color: #007bff;
  color: #fff;
  border: none;
  border-radius: 3px;
  cursor: pointer;
  font-size: 16px;
}

.submit-button {
  background-color: #28a745;
}

.prev-button {
  background-color: #6c757d;
}

.confirm-dialog {
  position: fixed;
  top: 0;
  left: 0;
  width: 100%;
  height: 100%;
  background-color: rgba(0, 0, 0, 0.5); /* 半透明的背景遮罩 */
  display: flex;
  justify-content: center;
  align-items: center;
  z-index: 1000; /* 确保在页面上其他元素之上 */
}

.confirm-dialog-content {
  background-color: #fff; /* 白色背景 */
  padding: 20px;
  border-radius: 5px;
  box-shadow: 0 0 10px rgba(0, 0, 0, 0.3); /* 模糊阴影 */
  max-width: 400px; /* 最大宽度 */
  width: 100%;
}

.confirm-dialog p {
  margin-bottom: 15px;
}

.confirm-dialog-buttons {
  display: flex;
  justify-content: flex-end;
}

.confirm-dialog-buttons button {
  padding: 8px 20px;
  margin-left: 10px;
  border: none;
  border-radius: 3px;
  cursor: pointer;
  transition: background-color 0.3s ease; /* 渐变的背景色变化 */
}

.confirm-dialog-buttons button:hover {
  background-color: #007bff; /* 鼠标悬停时的背景色 */
  color: #fff; /* 字体颜色变为白色 */
}
</style>
