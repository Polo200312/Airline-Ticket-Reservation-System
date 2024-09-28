<template>
  <div class="base_form">
    <div class="page flex-col">
      <div class="base_header">
        <div class="blue_column"></div>
        <div class="base_title">修改邮箱</div>
      </div>
      <div class="base_prompt">
        <el-icon><Warning /></el-icon>发送的验证码5分钟内有效！
      </div>
      <div class="group4 flex-col">
        <div class="main3 flex-col" v-if="pageType == 1">
          <span class="checkOnce">第一步验证</span>
          <div class="oldEmail flex-row">
            <div class="oldE">请输入旧邮箱:</div>
            <div>
              <input
                class="inputWidth"
                type="text"
                id="email"
                v-model="email"
                placeholder="请输入旧邮箱"
                required
              />
            </div>
          </div>
          <div class="veliCode flex-row">
            <div>
              <span class="veli">验证码:</span>
            </div>
            <div class="form-group">
              <input
                class="inputWidth1"
                type="text"
                id="verificationCode"
                v-model="verificationCode"
                placeholder="请输入验证码"
                required
              />
            </div>
            <div>
              <el-button
                type="primary"
                :disabled="disableSendButton"
                @click="handleSendVerificationCode()"
                style="margin: 5px 5px 5px 30px"
              >
                <el-icon><Message /></el-icon>发送验证码
              </el-button>
            </div>
          </div>
          <div class="newEmail flex-row">
            <div>
              <span class="newE">新邮箱:</span>
            </div>
            <div>
              <input
                class="inputWidth"
                type="text"
                id="newEmail"
                v-model="newEmail"
                placeholder="请输入新邮箱"
                required
              />
            </div>
          </div>
          <div class="reconfirmE flex-row">
            <div class="rE">请再次输入新邮箱:</div>
            <div>
              <input
                class="inputWidth"
                v-model="checkEmail"
                type="text"
                id="checkEmail"
                placeholder="请再次输入新邮箱"
                required
              />
            </div>
          </div>
          <div class="main8 flex-row justify-between">
            <div class="group8 flex-col" @click="handleSubmit()">
              <span class="word20"
                ><el-icon><Check /></el-icon>确认</span
              >
            </div>
          </div>
        </div>
        <div class="main3 flex-col" v-if="pageType == 2">
          <span class="checkAgain">二次验证</span>
          <div class="verification-section">
            <span class="word44"
              ><el-icon><Warning /></el-icon>请点击按钮，向新邮箱发送验证码：{{
                newEmail
              }}</span
            >
          </div>

          <div class="modd33 flex-row">
            <span class="word44">验证码：</span>
            <input
              class="inputWidth2"
              v-model="checkCode"
              type="text"
              id="checkCode"
              placeholder="请填写验证码"
              required
            />
            <el-button
              type="primary"
              style="margin: 5px 5px 5px 5px"
              :disabled="twiceSendButton"
              @click="handleCheck"
              class="send-code-button"
            >
              <el-icon><Message /></el-icon>发送验证码
            </el-button>
          </div>

          <div class="confirmation-section">
            <el-button type="success" @click="handleChange" class="confirm-button">
              <el-icon><finished /></el-icon>确认修改
            </el-button>
          </div>
        </div>
      </div>
    </div>
  </div>
</template>

<script lang="ts">
import { defineComponent } from "vue";
import { sendVerificationCode, updateEmail, checkCode } from "~/services/veliServ";
import { message } from "~/tools/messageBox";
import { testValidateInfo } from "~/services/mainServ";
import { ElButton } from "element-plus";
import { Finished, Message, Check, Warning } from "@element-plus/icons-vue";
import { finished } from "stream";

export default defineComponent({
  components: {
    ElButton,
    Finished,
    Message,
    Check,
    Warning,
  },
  data: () => ({
    email: "",
    verificationCode: "",
    checkCode: "",
    newEmail: "",
    checkEmail: "",
    disableSendButton: false as boolean,
    twiceSendButton: false as boolean,
    countdown: 0,
    pageType: 1,
    timeoutId: null as ReturnType<typeof setTimeout> | null, // 修改类型声明
  }),
  async created() {
    this.email = "";
    this.verificationCode = "";
    this.newEmail = "";
    if (this.disableSendButton == true) {
      this.disableSendButton = true;
    } else {
      this.disableSendButton = false;
    }
    (this.countdown = 0), (this.timeoutId = null as ReturnType<typeof setTimeout> | null); // 修改类型声明
  },
  methods: {
    async handleSendVerificationCode() {
      if (this.disableSendButton == false) {
        if (this.email == "" || this.email == undefined) {
          message(this, "原邮箱为空,请填写！");
          return;
        }
        const res = await sendVerificationCode(this.email);
        if (res.code != 0) {
          message(this, res.msg);
          this.verificationCode = "";
          this.newEmail = "";
          this.disableSendButton = false;
          return;
        } else {
          message(this, "验证码已发送！");
          this.disableSendButton = true;
          this.countdown = 60;
          this.timeoutId = setTimeout(() => {
            this.disableSendButton = false;
            this.timeoutId = null; // 清除 timeoutId
          }, this.countdown * 1000); //每60秒回调一次，延迟为毫秒单位
          return;
        }
      } else {
        message(this, `请等待${this.countdown}秒后再次发送！`);
        return;
      }
    },
    async handleSubmit() {
      if (this.email == "" || this.email == undefined) {
        message(this, "原邮箱为空,请填写！");
        return;
      }
      if (this.newEmail == "" || this.newEmail == undefined) {
        message(this, "新邮箱为空,请填写！");
        return;
      }
      if (this.email === this.newEmail) {
        message(this, "新密码和旧密码相同，不能修改！");
        return;
      }
      if (this.checkEmail !== this.newEmail) {
        message(this, "新邮箱和确认邮箱不相同，不能修改！");
        return;
      }
      if (this.verificationCode == "" || this.verificationCode == undefined) {
        message(this, "验证码为空,请填写！");
        return;
      }
      const codeRegex = /^\d{6}$/;
      if (!codeRegex.test(this.verificationCode)) {
        message(this, "验证码格式不正确，请填写6位数字组成的字符串！");
        return;
      }
      const res = await checkCode(this.email, this.verificationCode);
      if (res.code != 0) {
        message(this, res.msg);
        this.verificationCode = "";
        this.newEmail = "";
        this.disableSendButton = false;
      } else {
        message(this, "验证成功！");
        this.pageType = 2;
      }
      if (this.timeoutId) {
        clearTimeout(this.timeoutId); // 清除定时器
        this.timeoutId = null; // 清除 timeoutId
      }
      this.disableSendButton = false; // 重置发送按钮状态
      return;
    },
    async handleCheck() {
      if (this.twiceSendButton == false) {
        const res = await sendVerificationCode(this.newEmail);
        if (res.code != 0) {
          message(this, res.msg);
          this.twiceSendButton = false;
          return;
        } else {
          message(this, "验证码已发送！");
          this.twiceSendButton = true;
          this.countdown = 60;
          this.timeoutId = setTimeout(() => {
            this.disableSendButton = false;
            this.timeoutId = null; // 清除 timeoutId
          }, this.countdown * 1000); //每60秒回调一次，延迟为毫秒单位
          return;
        }
      } else {
        message(this, `请等待${this.countdown}秒后再次发送！`);
        return;
      }
    },
    async handleChange() {
      if (this.checkCode == "" || this.verificationCode == undefined) {
        message(this, "验证码为空,请填写！");
        return;
      }
      const codeRegex = /^\d{6}$/;
      if (!codeRegex.test(this.verificationCode)) {
        message(this, "验证码格式不正确，请填写6位数字组成的字符串！");
        return;
      }
      let res = await updateEmail(this.email, this.checkCode, this.newEmail);
      if (res.code != 0) {
        message(this, res.msg);
        this.checkCode = "";
        this.twiceSendButton = false;
      } else {
        message(this, "修改成功！");
        this.email = "";
        this.checkCode = "";
        this.newEmail = "";
        this.pageType = 1;
        this.$router.push({
          path: "/ClientCenter",
        });
      }
      if (this.timeoutId) {
        clearTimeout(this.timeoutId); // 清除定时器
        this.timeoutId = null; // 清除 timeoutId
      }
      this.disableSendButton = false; // 重置发送按钮状态
      return;
    },
  },
});
</script>

<style scoped>
/* 基本布局样式 */
.base_form {
  max-width: 750px;
  margin: auto;
  padding: 20px;
  background-color: #ffffff;
  border-radius: 8px;
  box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
  margin-top: 20px;
}

.page {
  display: flex;
  flex-direction: column;
  align-items: center;
}

.base_header {
  width: 100%;
  display: flex;
  align-items: center;
  margin-bottom: 20px;
}

.blue_column {
  width: 5px;
  height: 40px;
  background-color: #409eff;
  margin-right: 10px;
  border-radius: 2px;
}

.base_title {
  font-size: 1.5em;
  font-weight: bold;
  color: #333;
}

.base_prompt {
  width: 100%;
  font-size: 0.9em;
  color: #666;
  margin-bottom: 20px;
  text-align: left;
}

.group4 {
  width: 100%;
}

.main3 {
  max-width: 100%;
  background-color: #f7f8fa;
  padding: 5px;
  border-radius: 8px;
  margin-bottom: 20px;
  box-shadow: 0 2px 6px rgba(0, 0, 0, 0.05);
}

.checkOnce,
.checkAgain {
  font-size: 1.2em;
  font-weight: bold;
  color: #409eff;
  margin-bottom: 15px;
}

.flex-row {
  display: flex;
  align-items: center;
  margin-top: 15px;
  margin-bottom: 15px;
}

.inputWidth,
.inputWidth1 {
  width: 100%;
  padding: 10px;
  border: 1px solid #ccc;
  border-radius: 4px;
  font-size: 1em;
}
.inputWidth2 {
  width: 60%;
  padding: 10px;
  border: 1px solid #ccc;
  border-radius: 4px;
  font-size: 1em;
}

.oldE,
.veli,
.newE,
.rE {
  font-size: 1em;
  color: #333;
  margin-right: 10px;
  max-width: 200px;
}

.word44 {
  font-size: 1em;
  color: #333;
  margin-right: 10px;
  max-width: 600px;
}

.form-group {
  display: flex;
  flex-direction: column;
  max-width: 60%;
  margin: 2px 2px 2px 2px;
}

.form-group input {
  max-width: 240px;
  padding: 10px;
  border: 1px solid #ccc;
  border-radius: 4px;
  font-size: 1em;
}

/* 如果 form-group 内有需要对齐的内容，可以使用 flex 布局 */
.form-group .flex-row {
  display: flex;
  align-items: center;
}

.form-group .flex-row span {
  margin-right: 10px;
  color: #333;
  font-size: 1em;
}

.send-code-button {
  margin-left: auto;
}

.verification-section {
  display: flex;
  justify-content: space-between;
  align-items: center;
  margin-bottom: 20px;
}

.modd33 {
  display: flex;
  align-items: center;
}

.confirmation-section {
  display: flex;
  justify-content: center;
  margin-top: 20px;
}

.confirm-button,
.send-code-button {
  padding: 10px 20px;
  font-size: 1em;
  border-radius: 4px;
}

.main8 {
  display: flex;
  justify-content: center; /* 水平居中 */
}

.group8 {
  background-color: #409eff;
  color: #fff;
  padding: 10px 30px;
  border-radius: 4px;
  cursor: pointer;
  text-align: center;
}

.word20 {
  font-size: 1.1em;
  font-weight: bold;
}

.group8:hover {
  background-color: #66b1ff;
}

@media (max-width: 600px) {
  .inputWidth,
  .inputWidth1,
  .inputWidth2 {
    width: 100%;
  }

  .main3,
  .verification-section {
    flex-direction: column;
  }

  .send-code-button {
    margin-left: 0;
    margin-top: 10px;
  }
}
</style>
