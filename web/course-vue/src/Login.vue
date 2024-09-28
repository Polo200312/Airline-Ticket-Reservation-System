<template>
  <div class="page flex-col">
    <!-- 登录页面上部区域 -->
    <!--<div class="group1 flex-col">
      </div>-->
    <!--<el-carousel :interval="5000" class="carousel-container">
      <el-carousel-item
        v-for="image in images"
        :key="image.id"
        class="carousel-container"
      >
        <img :src="image.url" class="carousel-image" />
      </el-carousel-item>
    </el-carousel>-->
    <el-carousel :interval="5000" class="carousel-container">
      <el-carousel-item
        v-for="image in randomizedImages"
        :key="image.id"
        class="carousel-container"
      >
        <img :src="image.url" class="carousel-image" />
      </el-carousel-item>
    </el-carousel>
    <!-- 登录页面中部区域， 登录登录、密码重置、用户注册表单切换 -->
    <div class="group4 flex-col">
      <div class="group2"></div>
      <span class="line"></span>
      <span class="title">飞机票售票平台</span>
      <div class="group5 flex-col">
        <div class="section4 flex-col">
          <div class="box5 flex-col">
            <!-- 用户登录表单内容 -->
            <div class="main3 flex-col" v-if="pageType == 1">
              <div class="main4 flex-col">用户登录</div>

              <div>
                <div class="main5 flex-col">
                  <div class="wrap2 flex-row justify-between">
                    <div class="main6 flex-col">
                      <div class="box6 flex-col"></div>
                    </div>
                    <input
                      class="inputWidth"
                      v-model="username"
                      placeholder="请输入账号或用户名"
                    />
                  </div>
                </div>
                <div class="main7 flex-col">
                  <div class="wrap3 flex-row justify-between">
                    <div class="group6 flex-col">
                      <div class="mod2 flex-col"></div>
                    </div>
                    <input
                      class="inputWidth"
                      v-model="password"
                      type="password"
                      placeholder="请输入密码"
                    />
                  </div>
                </div>
                <div class="main8 flex-col">
                  <div class="wrap4 flex-row">
                    <div class="bd1 flex-col">
                      <div class="block3 flex-col"></div>
                    </div>
                    <input
                      class="codeWidth"
                      v-model="valiCode"
                      placeholder="请输入验证码"
                    />
                    <img
                      @click="changeValiCode()"
                      class="img1"
                      referrerpolicy="no-referrer"
                      :src="img"
                    />
                  </div>
                </div>
                <!-- 新增的邮箱登录按钮 -->
                <div>
                  <button class="loginWithEmailBtn" @click="switchToEmailLogin()">
                    使用邮箱或手机号登录
                  </button>
                </div>
                <div class="ImageText1 flex-col">
                  <div class="group7 flex-row justify-between">
                    <input type="checkbox" v-model="remember" />
                    <div class="TextGroup1 flex-col">
                      <a class="txt3">记住密码</a>
                      <a @click="forgetPass()" class="info2">忘记密码？</a>
                    </div>
                  </div>
                </div>
                <div class="main9 flex-col" @click="loginSubmit()">
                  <span class="info1">登录</span>
                </div>
                <div class="box2 flex-col">
                  <div class="wrap1 flex-row justify-between">
                    <div class="group3 flex-col"></div>
                    <div class="word2" @click="pageRegister()">新用户注册</div>
                  </div>
                </div>
                <div class="other-way-login flex">
                  <p style="font-size: 18px">第三方登录</p>
                  <div class="list">
                    <img
                      id="qqlogin"
                      src="https://sso.sflep.com/idsvr/assets/img/qq.png"
                    />
                    <img
                      id="wxlogin"
                      src="https://sso.sflep.com/idsvr/assets/img/wx.png"
                    />
                    <img
                      id="apple"
                      src="https://sso.sflep.com/idsvr/assets/img/iphone.png"
                    />
                  </div>
                </div>
              </div>
            </div>
            <!-- 密码找回表单内容 -->
            <div class="main3 flex-col" v-if="pageType == 2">
              <span class="callBackPass">找回密码</span>
              <div class="step">
                <el-steps :space="200" :active="1" simple>
                  <el-step title="Step 1" />
                  <el-step title="Step 2" />
                </el-steps>
              </div>
              <div class="mod33 flex-row">
                <span class="word44">登录账号：</span>
                <input
                  class="inputWidth2"
                  id="username"
                  v-model="username"
                  placeholder="请输入账号或用户名"
                  required
                />
              </div>
              <div class="mod33 flex-row">
                <span class="word44">电子邮箱：</span>
                <input
                  class="inputWidth2"
                  id="email"
                  v-model="email"
                  placeholder="请输入邮箱"
                  required
                />
              </div>
              <div class="mod33 flex-row">
                <span class="word44">验证码：</span>
                <input
                  class="inputWidth4"
                  id="verificationCode"
                  v-model="verificationCode"
                  placeholder="请输入验证码"
                  required
                />
                <div>
                  <div
                    class="sendVerificationCodeBtn"
                    :disabled="disableSendButton"
                    @click="handleSendVerificationCode()"
                  >
                    发送验证码
                  </div>
                </div>
                <!--<img @click="changeValiCode()" class="img2" referrerpolicy="no-referrer" :src="img" />-->
              </div>
              <div class="ImageText19 flex-col">
                <div class="outer49 flex-col justify-between">
                  <div class="box19 flex-col" @click="checkPassword()">
                    <span class="info59">确认</span>
                  </div>
                  <div class="TextGroup19 flex-col" @click="backLogin()">
                    <span class="word89">返回登录</span>
                  </div>
                </div>
              </div>
            </div>
            <!-- 用户注册表单内容 -->
            <div class="main3 flex-col" v-if="pageType == 3">
              <span class="callBackPass">用户注册</span>
              <!--<div class="modd33 flex-row">
                <span class="word44">账号：</span>
                <input class="inputWidth2" v-model="username" placeholder="填写账号" />
              </div>-->
              <div class="modd33 flex-row">
                <span class="word44">用户名：</span>
                <input class="inputWidth2" v-model="perName" placeholder="请输入用户名" />
              </div>
              <div class="modd33 flex-row">
                <span class="word44">密码：</span>
                <input class="inputWidth2" v-model="password" type="password" />
              </div>
              <div class="modd33 flex-row">
                <span class="word44">邮箱：</span>
                <input class="inputWidth2" v-model="email" placeholder="请输入邮箱" />
              </div>
              <div class="modd33 flex-row">
                <span class="word44">角色：</span>
                <select class="inputWidth2" v-model="role">
                  <option value="ADMIN">管理员</option>
                  <option value="CLIENT">用户</option>
                  <option value="AIRLINECOMPANY">航空公司</option>
                </select>
              </div>
              <div class="modd33 flex-row">
                <span class="word44">验证码：</span>
                <input
                  class="inputWidth3"
                  v-model="valiCode"
                  placeholder="请输入验证码"
                />
                <el-button
                  type="primary"
                  :disabled="newDisableSendButton"
                  @click="newHandleSendVerificationCode()"
                  style="margin: 5px 5px 5px 5px"
                >
                  <el-icon><Message /></el-icon>发送验证码
                </el-button>
              </div>
              <div class="ImageText19 flex-col">
                <div class="outer49 flex-col justify-between">
                  <div class="box19 flex-col" @click="register()">
                    <span class="info59">注册提交</span>
                  </div>
                  <div class="TextGroup19 flex-col" @click="backLogin()">
                    <span class="word89">返回登录</span>
                  </div>
                </div>
              </div>
            </div>
            <!--修改密码-->
            <div class="main3 flex-col" v-if="pageType == 4">
              <span class="callBackPass">重置密码</span>
              <div class="step">
                <el-steps :space="200" :active="2" simple>
                  <el-step title="Step 1" />
                  <el-step title="Step 2" />
                </el-steps>
              </div>
              <span class="word44">设置新密码：</span>
              <div class="modd33 flex-row">
                <input
                  class="inputWidth"
                  type="password"
                  id="newPassword"
                  v-model="newPassword"
                  placeholder="请输入新密码"
                  required
                />
              </div>
              <span class="word44">请再次确认密码：</span>
              <div class="modd33 flex-row">
                <input
                  class="inputWidth"
                  v-model="checkPass"
                  type="password"
                  id="checkPass"
                  placeholder="请再次输入新密码"
                  required
                />
              </div>
              <div class="main9 flex-col" @click="changePass()">
                <span class="info1">确认</span>
              </div>
              <div class="TextGroup19 flex-col" @click="backLogin()">
                <span class="word89">返回登录</span>
              </div>
            </div>
            <!--用邮箱登录-->
            <div class="main3 flex-col" v-if="pageType == 5">
              <span class="callBackPass">邮箱登录</span>
              <div class="main5 flex-col">
                <div class="wrap2 flex-row justify-between">
                  <div class="main6 flex-col">
                    <div class="box6 flex-col"></div>
                  </div>
                  <input class="inputWidth" v-model="email" placeholder="请输入邮箱" />
                </div>
              </div>
              <div class="main7 flex-col">
                <div class="wrap3 flex-row justify-between">
                  <div class="group6 flex-col">
                    <div class="mod2 flex-col"></div>
                  </div>
                  <input
                    class="inputWidth"
                    v-model="password"
                    type="password"
                    placeholder="请输入密码"
                  />
                </div>
              </div>
              <div class="main8 flex-col">
                <div class="wrap4 flex-row">
                  <div class="bd1 flex-col">
                    <div class="block3 flex-col"></div>
                  </div>
                  <input
                    class="codeWidth"
                    v-model="valiCode"
                    placeholder="请输入验证码"
                  />
                  <img
                    @click="changeValiCode()"
                    class="img1"
                    referrerpolicy="no-referrer"
                    :src="img"
                  />
                </div>
              </div>
              <div class="main9 flex-col" @click="loginByEmail()">
                <span class="info1">确认</span>
              </div>
              <div class="TextGroup19 flex-col" @click="backLogin()">
                <span class="word89">返回登录</span>
              </div>
            </div>
          </div>

          <!-- 登录下部区域 -->
          <div class="box7 flex-col">
            <span class="txt4">2024.07.18 By：彭彦钧</span>
          </div>
        </div>
      </div>
      <div class="section3 flex-col">
        <span class="txt1">Copyright&nbsp;©天一旅行网</span>
        <div class="mod1 flex-col"></div>
        <span class="word1">欢迎使用飞机票售票系统！我们将竭诚为您服务！</span>
      </div>
    </div>
  </div>
</template>

<script lang="ts">
import { defineComponent } from "vue";
import { useAppStore } from "./stores/app";
import {
  changePass,
  sendVerificationCode,
  checkCode,
  checkEmailUser,
  getUserDataByEmail,
} from "~/services/infoServ";
import {
  getValidateCode,
  testValidateInfo,
  resetPassWord,
  registerUser,
} from "./services/mainServ";
import { message } from "./tools/messageBox";
import router from "./router";
import { Base64 } from "js-base64";
import { ElButton } from "element-plus";
import { Finished, Message, Check, Warning } from "@element-plus/icons-vue";

//import { async } from './services/genServ';
function checkNotEmpty(value: string): boolean | string {
  if (value) return true;

  return "您必须输入用户名密码";
}
const USER_KEY = "UserKey";
export default defineComponent({
  //返回的数据，templte中使用的数据
  components: {
    ElButton,
    Finished,
    Message,
    Check,
    Warning,
  },
  data() {
    return {
      images: [
        { id: 1, url: "/World.jpg" },
        { id: 2, url: "/Plane1.jpg" },
        { id: 3, url: "/Plane2.jpg" },
        { id: 3, url: "/Plane3.jpg" },
        { id: 4, url: "/Airport1.jpg" },
        { id: 5, url: "/Airport2.jpg" },
        { id: 5, url: "/Airport3.jpg" },
        { id: 6, url: "/tourist1.jpg" },
        { id: 7, url: "/tourist2.jpg" },
        { id: 8, url: "/tourist3.jpg" },
        { id: 9, url: "/Tiantan.jpg" },
        { id: 9, url: "/GreatWall.jpg" },
        { id: 10, url: "/Fujiyama.jpg" },
        { id: 11, url: "/Jinzita.jpg" },
        { id: 12, url: "/Milanjiaotang.jpg" },
        { id: 12, url: "/st-peter.jpg" },
      ],
      disableSendButton: false as boolean,
      newDisableSendButton: false as boolean,
      newEmail: "",
      countdown: 0,
      timeoutId: null as ReturnType<typeof setTimeout> | null, // 修改类型声明
      username: "",
      password: "",
      inputCode: "",
      cheakCode: "",
      valiCode: "",
      verificationCode: "",
      pageType: 1,
      newPassword: "",
      checkPass: "",
      id: 0,
      jwt: "",
      img: "",
      funId: "",
      vueName: "",
      loginCode: "",
      email: "",
      messageCode: "",
      showSlider: false,
      remember: true,
      role: "CLIENT",
      perName: "",
      rules: [checkNotEmpty],
    };
  },
  computed: {
    randomizedImages(): { id: number; url: string }[] {
      // 使用数组的slice方法复制，然后使用Fisher-Yates随机洗牌算法
      const shuffled = this.images.slice().sort(() => Math.random() - 0.5);
      return shuffled;
    },
  },

  //页面加载前执行的函数 设置初始为登录界面
  beforeMount() {
    this.pageType = 1;
  },
  //页面加载后执行的函数， 执行性一次， 从后台请求验证码，从浏览器获取上次登录的用户信息作为用户和密码的初始值
  async created() {
    const res = await getValidateCode();
    this.id = res.validateCodeId;
    this.img = res.img;
    const store = useAppStore();
    if (store.remember) {
      this.username = Base64.decode(store.usernameSave);
      this.password = Base64.decode(store.passwordSave);
      this.remember = true;
    } else {
      this.username = "";
      this.password = "";
      this.remember = false;
    }
  },
  //页面加载后执行的函数， 执行性多次
  methods: {
    async checkPassword() {
      if (this.username == "" || this.username == undefined) {
        message(this, "姓名为空,请填写！");
        return;
      }
      if (this.email == "" || this.email == undefined) {
        message(this, "邮箱为空,请填写！");
        return;
      }
      if (this.verificationCode == "" || this.verificationCode == undefined) {
        message(this, "验证码为空,请填写！");
        return;
      }
      const res = await checkCode(this.email, this.verificationCode);
      if (res.code != 0) {
        message(this, res.msg);
        this.verificationCode = "";
        this.username = "";
        this.newEmail = "";
        this.disableSendButton = false;
      } else {
        message(this, "验证成功！");
        this.pageType = 4;
      }
      if (this.timeoutId) {
        clearTimeout(this.timeoutId); // 清除定时器
        this.timeoutId = null; // 清除 timeoutId
      }
      this.disableSendButton = false; // 重置发送按钮状态
      return;
    },
    //刷新验证码
    async changeValiCode() {
      const res = await getValidateCode();
      this.id = res.validateCodeId;
      this.img = res.img;
      this.valiCode = "";
    },
    //返回登录界面
    backLogin() {
      this.username = "";
      this.password = "";
      this.valiCode = "";
      this.email = "";
      this.pageType = 1;
    },
    //忘记密码 显示密码设置表单显示
    forgetPass() {
      this.username = "";
      this.password = "";
      this.valiCode = "";
      this.pageType = 2;
    },
    //用户注册 显示用户注册表单
    pageRegister() {
      this.username = "";
      this.password = "";
      this.valiCode = "";
      this.pageType = 3;
    },
    //用邮箱登录
    switchToEmailLogin() {
      this.username = "";
      this.password = "";
      this.valiCode = "";
      this.email = "";
      this.pageType = 5;
    },
    async handleSendVerificationCode() {
      if (this.disableSendButton == false) {
        if (this.email == "" || this.email == undefined) {
          message(this, "邮箱为空,请填写！");
          return;
        }
        if (this.username == "" || this.username == undefined) {
          message(this, "账号为空,请填写！");
          return;
        }
        const resp = await checkEmailUser({
          email: this.email,
          username: this.username,
        });
        if (resp.code != 0) {
          message(this, resp.msg);
          this.verificationCode = "";
          this.newEmail = "";
          this.disableSendButton = false;
          return;
        } else {
          message(this, "比对成功！");
        }
        console.log("111");
        const res = await sendVerificationCode(this.email);
        console.log(res);
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

    async newHandleSendVerificationCode() {
      if (this.newDisableSendButton == false) {
        if (this.email == "" || this.email == undefined) {
          message(this, "邮箱为空,请填写！");
          return;
        }
        const res = await sendVerificationCode(this.email);
        if (res.code != 0) {
          message(this, res.msg);
          this.verificationCode = "";
          this.newEmail = "";
          this.newDisableSendButton = false;
          return;
        } else {
          message(this, "验证码已发送！");
          this.newDisableSendButton = true;
          this.countdown = 60;
          this.timeoutId = setTimeout(() => {
            this.newDisableSendButton = false;
            this.timeoutId = null; // 清除 timeoutId
          }, this.countdown * 1000); //每60秒回调一次，延迟为毫秒单位
          return;
        }
      } else {
        message(this, `请等待${this.countdown}秒后再次发送！`);
        return;
      }
    },

    // 初始密码 请求后台服务，将发送初始密码到邮箱
    async initPassword() {
      let res = await testValidateInfo({
        validateCodeId: this.id,
        validateCode: this.valiCode,
      });
      if (res.code != 0) {
        message(this, res.msg);
        this.changeValiCode();
        return;
      }
      if (this.username == "" || this.username == undefined) {
        message(this, "账号为空,请填写账号");
        return;
      }
      if (this.email == "" || this.email == undefined) {
        message(this, "邮箱为空,请填写邮箱");
        return;
      }
      res = await resetPassWord({
        username: this.username,
        email: this.email,
      });
      if (res.code == 0) {
        message(this, "初始密码已发送至您的邮箱，请注意查收");
        this.changeValiCode();
        this.pageType = 1;
      } else {
        message(this, res.msg);
      }
    },
    //用户注册 请求后台服务，将用户注册信息发送到后台，后台添加账户人员教师或学生信息
    async register() {
      /*let res = await testValidateInfo({
        validateCodeId: this.id,
        validateCode: this.valiCode,
      });
      if (res.code != 0) {
        message(this, res.msg);
        this.changeValiCode();
        return;
      }
      /*if (this.username == "" || this.username == undefined) {
        message(this, "账号为空,请填写账号");
        return;
      }*/
      if (this.password == "" || this.password == undefined) {
        message(this, "账号为空,请填写密码");
        return;
      }
      if (this.perName == "" || this.perName == undefined) {
        message(this, "姓名为空,请填写姓名");
        return;
      }
      if (this.email == "" || this.email == undefined) {
        message(this, "邮箱为空,请填写邮箱");
        return;
      }
      if (this.role == "" || this.role == undefined) {
        message(this, "角色为空,请选择角色");
        return;
      }
      if (this.valiCode == "" || this.valiCode == undefined) {
        message(this, "验证码为空,请填写！");
        return;
      }
      const codeRegex = /^\d{6}$/;
      if (!codeRegex.test(this.valiCode)) {
        message(this, "验证码格式不正确，请填写6位数字组成的字符串！");
        return;
      }
      let res = await checkCode(this.email, this.valiCode);
      if (res.code != 0) {
        message(this, res.msg);
        this.valiCode = "";
        this.email = "";
        this.newDisableSendButton = false;
        return;
      }
      res = await registerUser({
        username: this.username,
        password: this.password,
        perName: this.perName,
        email: this.email,
        role: this.role,
      });
      if (res.code == 0) {
        //message(this, "已注册成功！");
        message(this, "注册成功！您的新账户是 ：" + res.msg);
        this.username = res.msg;
        this.changeValiCode();
        this.valiCode = "";
        this.email = "";
        this.pageType = 1;
      } else {
        message(this, res.msg);
      }
    },
    async changePass() {
      if (this.newPassword == "" || this.newPassword == undefined) {
        message(this, "新密码为空,请填写！");
        return;
      }
      if (this.checkPass == "" || this.checkPass == undefined) {
        message(this, "二次密码为空,请填写！");
        return;
      }
      if (this.newPassword != this.checkPass) {
        message(this, "二次密码与新密码不同，请确认一致！");
        return;
      }
      let res = await changePass({
        username: this.username,
        newPassword: this.newPassword,
      });
      if (res.code == 0) {
        message(this, "密码修改成功！");
        location.reload();
      } else {
        message(this, res.msg);
        return;
      }
    },
    //登录请求后台服务，将用户登录信息发送到后台，后台验证用户信息，返回jwt
    async loginSubmit() {
      const res = await testValidateInfo({
        validateCodeId: this.id,
        validateCode: this.valiCode,
      });
      if (res.code != 0) {
        message(this, res.msg);
        this.changeValiCode();
        return;
      }
      if (this.username == "" || this.username == undefined) {
        message(this, "用户名为空");
      } else if (this.password == "" || this.password == undefined) {
        message(this, "密码为空");
      } else {
        const store = useAppStore();
        try {
          //登录成功后，将用户信息保存到store中，将用户信息保存到浏览器中
          await store.login(this.username, this.password);
          await store.setNavi();
          if (this.remember) {
            store.saveAccount(Base64.encode(this.username), Base64.encode(this.password));
          } else {
            store.removeAccount();
          }
          message(this, "登录成功！欢迎您！");
          router.push("/MainPage");
        } catch (err) {
          message(this, this.username + "登录失败!");
        }
      }
    },
    //邮箱登录
    async loginByEmail() {
      const res = await testValidateInfo({
        validateCodeId: this.id,
        validateCode: this.valiCode,
      });
      if (res.code != 0) {
        message(this, res.msg);
        this.changeValiCode();
        return;
      }
      if (this.email == "" || this.email == undefined) {
        message(this, "邮箱为空");
      } else if (this.password == "" || this.password == undefined) {
        message(this, "密码为空");
      } else {
        let res = await getUserDataByEmail(this.email);
        if (res.code != 0) {
          message(this, res.msg);
          return;
        } else {
          this.username = res.data.info.userName;
        }
        const store = useAppStore();
        try {
          //登录成功后，将用户信息保存到store中，将用户信息保存到浏览器中
          await store.login(this.username, this.password);
          await store.setNavi();
          if (this.remember) {
            store.saveAccount(Base64.encode(this.username), Base64.encode(this.password));
          } else {
            store.removeAccount();
          }
          message(this, "登录成功！欢迎您！");
          router.push("/MainPage");
        } catch (err) {
          message(this, this.username + "登录失败!");
        }
      }
    },
  },
});
</script>

<style>
.send-code-button {
  margin-left: 5px;
}
.modq9 {
  width: 478px;
  height: 46px;
  margin-top: 39px;
}

.bdq3 {
  background-color: rgba(147, 14, 20, 1);
  border-radius: 4px;
  height: 46px;
  width: 232px;
  cursor: pointer;
}

.txtq4 {
  width: 48px;
  height: 16px;
  overflow-wrap: break-word;
  color: rgba(255, 255, 255, 1);
  font-size: 16px;
  font-family: STHeitiSC-Medium;
  text-align: left;
  white-space: nowrap;
  line-height: 16px;
  display: block;
  margin: 15px 0 0 92px;
}

.bdq4 {
  background-color: rgba(147, 14, 20, 1);
  border-radius: 4px;
  height: 46px;
  width: 232px;
  cursor: pointer;
}

.infoq4 {
  width: 32px;
  height: 16px;
  overflow-wrap: break-word;
  color: rgba(255, 255, 255, 1);
  font-size: 16px;
  font-family: STHeitiSC-Medium;
  text-align: left;
  white-space: nowrap;
  line-height: 16px;
  display: block;
  margin: 15px 0 0 92px;
}

.wordd4 {
  width: 418px;
  height: 20px;
  overflow-wrap: break-word;
  color: rgba(153, 153, 153, 1);
  font-size: 14px;
  font-family: PingFangTC-Regular;
  text-align: left;
  white-space: nowrap;
  line-height: 20px;
  display: block;
  margin: 8px 0 0 74px;
}

.ImageText19 {
  height: 86px;
  width: 478px;
  margin: 34px 0 0 0px;
}

.outer49 {
  width: 478px;
  height: 86px;
}

.box19 {
  background-color: rgba(147, 14, 20, 1);
  border-radius: 4px;
  height: 46px;
  width: 360px;
  cursor: pointer;
}

.info59 {
  width: 48px;
  height: 16px;
  overflow-wrap: break-word;
  color: rgba(255, 255, 255, 1);
  font-size: 16px;
  font-family: STHeitiSC-Medium;
  text-align: left;
  white-space: nowrap;
  line-height: 16px;
  display: block;
  margin: 15px 0 0 160px;
}

.TextGroup19 {
  height: 22px;
  width: 64px;
  margin: 18px 0 0 207px;
}

.word89 {
  width: 64px;
  height: 22px;
  overflow-wrap: break-word;
  color: rgba(147, 14, 20, 1);
  font-size: 16px;
  font-family: PingFangTC-Regular;
  text-align: left;
  white-space: nowrap;
  line-height: 22px;
  display: block;
  cursor: pointer;
  margin-left: -40px;
}

.mod33 {
  width: 486px;
  height: 40px;
  margin-top: 45px;
}

.modd33 {
  width: 486px;
  height: 40px;
  margin-top: 12px;
}

.word44 {
  width: 80px;
  height: 16px;
  overflow-wrap: break-word;
  color: rgba(47, 47, 47, 1);
  font-size: 16px;
  font-family: SourceHanSansCN-Regular;
  text-align: left;
  white-space: nowrap;
  line-height: 16px;
  margin-top: 10px;
  display: block;
}

.section88 {
  background-color: rgba(255, 255, 255, 1);
  border-radius: 2px;
  height: 40px;
  border: 1px solid rgba(217, 217, 217, 1);
  width: 403px;
}

.info33 {
  width: 105px;
  height: 20px;
  overflow-wrap: break-word;
  color: rgba(153, 153, 153, 1);
  font-size: 14px;
  font-family: PingFangTC-Regular;
  text-align: left;
  white-space: nowrap;
  line-height: 20px;
  display: block;
  margin: 10px 0 0 11px;
}

.mod22 {
  width: 486px;
  height: 449px;
}

.callBackPass {
  width: 88px;
  height: 22px;
  overflow-wrap: break-word;
  color: rgba(147, 14, 20, 1);
  font-size: 22px;
  font-family: SourceHanSansCN-Bold;
  text-align: left;
  white-space: nowrap;
  line-height: 22px;
  margin-left: 160px;
  display: block;
}

body * {
  box-sizing: border-box;
  flex-shrink: 0;
}

body {
  font-family: PingFangSC-Regular, Roboto, Helvetica Neue, Helvetica, Tahoma, Arial,
    PingFang SC-Light, Microsoft YaHei;
}

button {
  margin: 10px 0 0 3px;
  padding: 0;
  border: 3px solid transparent;
  outline: none;
  background-color: transparent;
}

button:active {
  opacity: 0.6;
}

.flex-col {
  display: flex;
  flex-direction: column;
}

.flex-row {
  display: flex;
  flex-direction: row;
}

.justify-start {
  display: flex;
  justify-content: flex-start;
}

.justify-center {
  display: flex;
  justify-content: center;
}

.justify-end {
  display: flex;
  justify-content: flex-end;
}

.justify-evenly {
  display: flex;
  justify-content: space-evenly;
}

.justify-around {
  display: flex;
  justify-content: space-around;
}

.justify-between {
  display: flex;
  justify-content: space-between;
}

.align-start {
  display: flex;
  align-items: flex-start;
}

.align-center {
  display: flex;
  align-items: center;
}

.align-end {
  display: flex;
  align-items: flex-end;
}

.inputWidth {
  width: 300px;
}

.inputWidth2 {
  width: 300px;
}

.inputWidth3 {
  width: 220px;
}

.inputWidth4 {
  width: 200px;
}

.codeWidth {
  width: 200px;
}

input {
  border: 1px solid rgba(217, 217, 217, 1);
}

input:focus {
  outline: none;
  border: 1px solid rgba(147, 14, 20, 1);
}

.page {
  background-color: rgba(255, 255, 255, 1);
  position: relative;
  width: 100%;
  height: 809px;
  overflow: hidden;
}

.group1 {
  background: url("/backgroud.png") 100% no-repeat;
  visibility: visible;
  height: 1066.88px;
  margin-left: 0px;
  margin-top: -128.938px;
  position: absolute;
  width: 1707px;
}

.section1 {
  background-color: rgba(29, 32, 38, 1);
  z-index: 2;
  height: 34px;
  width: 100%;
  position: relative;
}

.main1 {
  width: 127px;
  height: 12px;
  margin: 11px 0 0 1437px;
}

.mod1 {
  width: 13px;
  height: 20px;
  background: url("/hi.png") 0px 0px no-repeat;
  margin: -10px 0 0 20px;
}

.word1 {
  width: 108px;
  height: 12px;
  overflow-wrap: break-word;
  color: rgba(255, 255, 255, 1);
  font-size: 12px;
  font-family: SourceHanSansCN-Regular;
  text-align: right;
  white-space: nowrap;
  line-height: 12px;
  display: block;
  margin: -20px 0 0 40px;
}

.main2 {
  background-color: rgba(147, 14, 20, 1);
  z-index: 12;
  height: 110px;
  width: 284px;
  position: absolute;
  left: 360px;
  top: 0;
}

.group2 {
  width: 100px;
  height: 66px;
  background: url("dist/newLOGO.png") 0px 0px no-repeat;
  margin: 25px 0 0 45px;
}

.section2 {
  width: 891px;
  height: 34px;
  margin: 21px 0 0 669px;
}

.box1 {
  width: 235px;
  height: 24px;
  background: url("/studentms.png") -1px -1px no-repeat;
  margin-top: 9px;
}

.box2 {
  height: 34px;
  background: linear-gradient(180deg, #ffffff 0%, #fceff0 100%);
  border-radius: 4px;
  border: 1px solid #930e14;
  margin: 10px 0 0 0;
  width: 140px;
  cursor: pointer;
}

.wrap1 {
  width: 92px;
  height: 14px;
  margin: 10px 0 0 24px;
}

.group3 {
  width: 14px;
  height: 14px;
  background: url("/en.png") 100% no-repeat;
}

.word2 {
  width: 70px;
  height: 14px;
  overflow-wrap: break-word;
  color: rgba(147, 14, 20, 1);
  font-size: 14px;
  font-family: SourceHanSansCN-Regular;
  text-align: right;
  white-space: nowrap;
  line-height: 14px;
  display: block;
}

.box3 {
  height: 34px;
  background: linear-gradient(180deg, #ffffff 0%, #fceff0 100%);
  border-radius: 4px;
  border: 1px solid #930e14;
  margin-left: 9px;
  width: 140px;
  cursor: pointer;
}

.block1 {
  width: 92px;
  height: 14px;
  margin: 10px 0 0 27px;
}

.block2 {
  width: 14px;
  height: 14px;
  background: url("/wx.png") 100% no-repeat;
}

.word3 {
  width: 70px;
  height: 14px;
  overflow-wrap: break-word;
  color: rgba(147, 14, 20, 1);
  font-size: 14px;
  font-family: SourceHanSansCN-Regular;
  text-align: right;
  white-space: nowrap;
  line-height: 14px;
  display: block;
}

.section3 {
  background-color: rgba(29, 32, 38, 1);
  height: 34px;
  margin-top: -107px;
  width: 100%;
}

.txt1 {
  width: 163px;
  height: 12px;
  overflow-wrap: break-word;
  color: rgba(255, 255, 255, 1);
  font-size: 12px;
  font-family: SourceHanSansCN-Regular;
  text-align: right;
  white-space: nowrap;
  line-height: 12px;
  display: block;
  margin: 11px 0 0 700px;
}

.group4 {
  z-index: 124;
  height: 938px;
  width: 100%;
  position: absolute;
  left: 0;
}

.group5 {
  height: 811px;
  width: 100%;
}

.section4 {
  width: 100%;
  height: 775px;
}

.box4 {
  background-color: rgba(147, 14, 20, 1);
  width: 100%;
  height: 2px;
}

.box5 {
  background-color: rgba(255, 255, 255, 0.89);
  border-radius: 8px;
  height: 500px;
  width: 500px;
  margin: 50px 0 0 1100px;
}

.main3 {
  width: 478px;
  height: 445px;
  margin: 35px 0 0 65px;
}

.main4 {
  width: 263px;
  height: 24px;
  font-size: 28px;
  margin-left: 120px;
}

.main5 {
  background-color: rgba(255, 255, 255, 1);
  border-radius: 2px;
  height: 46px;
  border: 1px solid rgba(217, 217, 217, 1);
  margin-top: 33px;
  width: 300px;
}

.wrap2 {
  width: 138px;
  height: 46px;
}

.main6 {
  background-color: rgba(251, 251, 251, 1);
  border-radius: 2px;
  height: 46px;
  border: 1px solid rgba(217, 217, 217, 1);
  width: 46px;
}

.box6 {
  width: 16px;
  height: 18px;
  background: url("/loginName.png") 0px 0px no-repeat;
  margin: 14px 0 0 15px;
}

.word4 {
  width: 70px;
  height: 20px;
  overflow-wrap: break-word;
  color: rgba(153, 153, 153, 1);
  font-size: 14px;
  font-family: PingFangTC-Regular;
  text-align: left;
  white-space: nowrap;
  line-height: 20px;
  margin-top: 13px;
  display: block;
}

.main7 {
  background-color: rgba(255, 255, 255, 1);
  border-radius: 2px;
  height: 46px;
  border: 1px solid rgba(217, 217, 217, 1);
  margin-top: 23px;
  width: 300px;
}

.wrap3 {
  width: 152px;
  height: 46px;
}

.group6 {
  background-color: rgba(251, 251, 251, 1);
  border-radius: 2px;
  height: 46px;
  border: 1px solid rgba(217, 217, 217, 1);
  width: 46px;
}

.mod2 {
  width: 16px;
  height: 18px;
  background: url("/password.png") 100% no-repeat;
  margin: 14px 0 0 15px;
}

.word5 {
  width: 84px;
  height: 20px;
  overflow-wrap: break-word;
  color: rgba(153, 153, 153, 1);
  font-size: 14px;
  font-family: PingFangTC-Regular;
  text-align: left;
  white-space: nowrap;
  line-height: 20px;
  margin-top: 13px;
  display: block;
}

.main8 {
  background-color: rgba(255, 255, 255, 1);
  border-radius: 2px;
  height: 46px;
  border: 1px solid rgba(217, 217, 217, 1);
  margin-top: 23px;
  width: 345px;
}

.main11 {
  background-color: rgba(255, 255, 255, 1);
  border-radius: 2px;
  height: 46px;
  border: 1px solid rgba(217, 217, 217, 1);
  margin-top: 23px;
  width: 345px;
  display: flex; /* 使用 flex 布局 */
  justify-content: center; /* 水平居中 */
  align-items: center; /* 垂直居中 */
}

.wrap4 {
  width: 470px;
  height: 46px;
}

.bd1 {
  background-color: rgba(251, 251, 251, 1);
  border-radius: 2px;
  height: 46px;
  border: 1px solid rgba(217, 217, 217, 1);
  width: 46px;
}

.block3 {
  width: 15px;
  height: 18px;
  background: url("/certifiy.png") 0px 0px no-repeat;
  margin: 14px 0 0 16px;
}

.txt2 {
  width: 98px;
  height: 20px;
  overflow-wrap: break-word;
  color: rgba(153, 153, 153, 1);
  font-size: 14px;
  font-family: PingFangTC-Regular;
  text-align: left;
  white-space: nowrap;
  line-height: 20px;
  display: block;
  margin: 13px 0 0 22px;
}

.img1 {
  width: 86px;
  height: 35px;
  margin: 5px 0 0 8px;
  cursor: pointer;
}

.img2 {
  width: 86px;
  height: 35px;
  margin: 3px 0 0 3px;
  cursor: pointer;
}

.ImageText1 {
  height: 22px;
  margin-top: 25px;
  width: 87px;
}

.group7 {
  width: 87px;
  height: 22px;
}

.bd2 {
  background-color: rgba(255, 255, 255, 1);
  border-radius: 2px;
  width: 16px;
  height: 16px;
  border: 1px solid rgba(217, 217, 217, 1);
  margin-top: 3px;
}

.TextGroup1 {
  height: 22px;
  width: 64px;
}

.txt3 {
  width: 64px;
  height: 22px;
  overflow-wrap: break-word;
  color: rgba(85, 85, 85, 1);
  font-size: 16px;
  font-family: PingFangTC-Regular;
  text-align: left;
  white-space: nowrap;
  line-height: 22px;
  display: block;
}

.main9 {
  background-color: rgba(147, 14, 20, 1);
  border-radius: 4px;
  height: 46px;
  margin-top: 35px;
  width: 360px;
  cursor: pointer;
}

.info1 {
  width: 32px;
  height: 16px;
  overflow-wrap: break-word;
  color: rgba(255, 255, 255, 1);
  font-size: 16px;
  font-family: STHeitiSC-Medium;
  text-align: left;
  white-space: nowrap;
  line-height: 16px;
  display: block;
  margin: 15px 0 0 160px;
}

.main10 {
  height: 46px;
  border: 1px solid rgba(147, 14, 20, 1);
  background: linear-gradient(180deg, #ffffff 0%, #fceff0 100%);
  margin-top: 9px;
  width: 478px;
  cursor: pointer;
}

.word6 {
  width: 96px;
  height: 16px;
  overflow-wrap: break-word;
  color: rgba(147, 14, 20, 1);
  font-size: 16px;
  font-family: STHeitiSC-Medium;
  text-align: left;
  white-space: nowrap;
  line-height: 16px;
  display: block;
  margin: 15px 0 0 191px;
}

.info2 {
  width: 64px;
  height: 22px;
  overflow-wrap: break-word;
  color: rgba(147, 14, 20, 1);
  font-size: 16px;
  font-family: PingFangTC-Regular;
  text-align: left;
  white-space: nowrap;
  line-height: 22px;
  display: block;
  margin: -22px 0 0 250px;
  cursor: pointer;
}

.box7 {
  background-color: rgba(255, 255, 255, 0.89);
  border-radius: 8px;
  height: 78px;
  width: 500px;
  margin: 6px 0 0 1100px;
}

.txt4 {
  width: 548px;
  height: 44px;
  overflow-wrap: break-word;
  color: rgba(85, 85, 85, 1);
  font-size: 16px;
  font-family: PingFangTC-Regular;
  text-align: left;
  line-height: 22px;
  overflow: hidden;
  text-overflow: ellipsis;
  display: block;
  margin: 17px 0 0 39px;
}

.other-way-login {
  font-size: 16px;
  line-height: 26px;
  margin: -45px 0 0 210px;
}

.list img {
  cursor: pointer;
  margin: 10px 0 0 10px;
}

.line {
  height: 58px;
  border-left: 2px solid #ffffff;
  float: left;
  width: 20px;
  margin: -58px 0 0 150px;
}

.title {
  float: left;
  font-size: 28px;
  color: #ffffff;
  margin: -50px 0 0 165px;
}

.carousel-container {
  height: 1066.88px;
  width: 1707px;
}

.carousel-image {
  visibility: visible;
  height: 1066.88px;
  margin-left: 0px;
  margin-top: -128.938px;
  position: absolute;
  width: 1707px;
}

.carousel-enter-active,
.carousel-leave-active {
  transition: opacity 0.5s ease;
}
.carousel-enter,
.carousel-leave-to {
  opacity: 0;
}

.step {
  margin: 14px 81px 0 -3px;
}

.loginWithEmailBtn {
  width: 340px; /* 设置固定宽度 */
  height: 35px;
  padding: 10px 20px;
  font-size: 16px;
  font-weight: bold;
  color: #fff;
  background-color: #3498db;
  border: none;
  border-radius: 5px;
  cursor: pointer;
  transition: background-color 0.3s ease;
}

.loginWithEmailBtn:hover {
  background-color: #2980b9;
}

.loginWithEmailBtn:focus {
  outline: none;
  box-shadow: 0 0 5px rgba(52, 152, 219, 0.5);
}

.sendVerificationCodeBtn {
  width: 100px; /* 设置固定宽度 */
  height: 40px;
  padding: 10px 20px;
  font-size: 12px;
  font-weight: bold;
  color: #fff;
  background-color: #2ecc71;
  border: none;
  border-radius: 5px;
  cursor: pointer;
  transition: background-color 0.3s ease;
  text-align: center; /* 文字居中 */
  line-height: 1; /* 垂直居中 */
}

.sendVerificationCodeBtn:hover {
  background-color: #27ae60;
}

.sendVerificationCodeBtn:active {
  background-color: #1e8449;
}

.sendVerificationCodeBtn:disabled {
  background-color: #bdc3c7;
  cursor: not-allowed;
}

.sendVerificationCodeBtn:focus {
  outline: none;
  box-shadow: 0 0 5px rgba(46, 204, 113, 0.5);
}
</style>
