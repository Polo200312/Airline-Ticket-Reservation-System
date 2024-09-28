<template>
  <div class="parent-container">
    <el-row>
      <el-col :span="7" class="custom-img">
        <el-card class="box-card">
          <div slot="header" class="clearfix">
            <el-avatar
              class="avatar"
              :src="imgStr"
              v-if="imgStr !== '' && imgStr !== null"
              :size="200"
            ></el-avatar>
            <el-avatar
              class="avatar"
              style="background: #21b1ff; font-size: 2em"
              :size="200"
              v-else
              >{{ getNameLast(info.name) }}</el-avatar
            >
            <!--<img :src="imgStr" alt="头像" />-->
          </div>
          <div class="user-info">
            <!-- input file 和按钮 -->
            <input
              type="file"
              ref="fileInput"
              accept=".jpg"
              style="display: none"
              @change="handleFileChange"
            />
            <div class="button-group">
              <el-button type="primary" @click="handleUploadClick"
                ><el-icon><folder /></el-icon>选择图片</el-button
              >
              <el-button type="success" v-if="form.avatarUrl" @click="uploadFile"
                ><el-icon><upload-filled /></el-icon>上传图片</el-button
              >
            </div>
          </div>
          <!-- 使用 cropper 进行裁剪 -->
          <el-dialog
            title="裁剪头像"
            :visible.sync="croppingDialogVisible"
            :modal="false"
          >
            <div class="cropper-container">
              <div class="cropper-wrapper">
                <vue-cropper
                  ref="cropper"
                  :src="form.avatarUrl"
                  :guides="true"
                  :view-mode="1"
                  :aspect-ratio="1"
                  :auto-crop-area-ratio="0.8"
                  :crop-box-draggable="true"
                  :crop-box-resizable="true"
                  @cropend="onCropEnd"
                ></vue-cropper>
              </div>

              <!-- 确定和取消按钮 -->
              <div class="cropper-buttons">
                <el-button type="primary" @click="handleCropConfirm">确定</el-button>
                <el-button @click="cancelCrop">取消</el-button>
              </div>

              <!-- 显示裁剪后的圆形头像 -->
              <img :src="croppedAvatar" class="avatar-preview" v-if="croppedAvatar" />
            </div>
          </el-dialog>
        </el-card>
      </el-col>
      <el-col :span="17" class="custom-info">
        <el-card class="box-card" v-if="!editMode">
          <div slot="header" class="clearfix1">
            <span>个人信息</span>
            <el-button type="text" class="edit-button" @click="editMode = true"
              ><el-icon><edit /></el-icon>修改</el-button
            >
            <div>
              <p>
                <strong
                  ><el-icon><user-filled /></el-icon>账号：</strong
                >{{ info.num }}
              </p>
              <p>
                <strong
                  ><el-icon><user /></el-icon>姓名：</strong
                >{{ info.name }}
              </p>
              <p>
                <strong
                  ><el-icon><wallet /></el-icon>账户余额：</strong
                >{{ info.amountOfMoney }}￥
              </p>
              <p>
                <strong
                  ><el-icon><sort /></el-icon>性别：</strong
                >{{ info.gender }}
              </p>
              <p>
                <strong
                  ><el-icon><message /></el-icon>邮箱：</strong
                >{{ info.email }}
              </p>
              <p>
                <strong
                  ><el-icon><phone /></el-icon>电话：</strong
                >{{ maskedPhone() }}
              </p>
              <p>
                <strong
                  ><el-icon><opportunity /></el-icon>真实姓名：</strong
                >{{ info.realName }}
              </p>
              <p>
                <strong
                  ><el-icon><credit-card /></el-icon>身份证号：</strong
                >{{ maskedIdNumber() }}
              </p>
            </div>
          </div>
        </el-card>
        <el-card class="box-card" v-else>
          <!-- 修改个人信息表单 -->
          <el-form ref="form" label-width="100px">
            <el-form-item label="姓名">
              <el-input v-model="name"></el-input>
            </el-form-item>
            <el-form-item label="性别">
              <el-radio-group v-model="gender">
                <el-radio label="男"
                  ><el-icon><Male /></el-icon>男</el-radio
                >
                <el-radio label="女"
                  ><el-icon><Female /></el-icon>女</el-radio
                >
              </el-radio-group>
            </el-form-item>
            <!--<el-form-item label="邮箱">
              <el-input v-model="email"></el-input>
            </el-form-item>-->
            <el-form-item label="电话">
              <el-input v-model="phone"></el-input>
            </el-form-item>
            <el-form-item>
              <el-button type="primary" @click="changeClientData()"
                ><el-icon><finished /></el-icon>保存</el-button
              >
              <el-button @click="editMode = false"
                ><el-icon><refresh-left /></el-icon>返回</el-button
              >
            </el-form-item>
          </el-form>
        </el-card>
      </el-col>
    </el-row>
  </div>
  <div>
    <el-menu
      default-active="2"
      class="el-menu-vertical-demo"
      @open="handleOpen"
      @close="handleClose"
      active-text-color="red"
    >
      <el-sub-menu index="1">
        <template #title
          ><el-icon><ticket /></el-icon> 我的订单
        </template>
        <el-menu-item-group>
          <el-menu-item index="viewPaidDeals" @click="viewPaidDeals(info.clientId)"
            >已付款(机票)</el-menu-item
          >
          <el-menu-item index="viewRefundDeals" @click="viewRefundDeals(info.clientId)"
            >已退款/已部分退款(机票)</el-menu-item
          >
          <el-menu-item index="viewSpotTicket" @click="viewSpotTickets(info.clientId)"
            >已付款(景点门票)</el-menu-item
          >
        </el-menu-item-group>
      </el-sub-menu>

      <el-menu-item
        v-if="!info.realName || !info.idNumber"
        index="realNameVerification"
        @click="handleRealNameVerification(info.clientId)"
        class="centered-menu-item"
      >
        <el-icon><postcard /></el-icon>
        <span>实名认证</span>
      </el-menu-item>

      <el-sub-menu index="2">
        <template #title
          ><el-icon><setting /></el-icon> 设置
        </template>
        <el-menu-item-group>
          <el-menu-item index="changePassword" @click="routerName('Password')"
            >修改密码</el-menu-item
          >
          <el-menu-item index="changeEmail" @click="routerName('ChangeEmail')"
            >修改邮箱</el-menu-item
          >
        </el-menu-item-group>
      </el-sub-menu>

      <el-menu-item
        index="/personalNotice"
        @click="goToNotificationPage()"
        class="centered-menu-item"
      >
        <el-icon><bell /></el-icon>
        <span>通知信息 </span
        ><span v-if="misread > 0"> &nbsp;-&nbsp;🔴 有{{ misread }}条未读通知</span>
        <span v-else> &nbsp;-&nbsp;🟢 全部已读</span>
      </el-menu-item>

      <el-menu-item index="mainPage" @click="goToMainPage()" class="centered-menu-item">
        <el-icon><stopwatch /></el-icon>
        <span>返回主页面</span>
      </el-menu-item>
    </el-menu>
  </div>
</template>

<script lang="ts">
import { defineComponent } from "vue";
import {
  type OptionItem,
  type ClientItem,
  type NotificationItem,
} from "~/models/general";
import { getAuthHeader } from "~/services/genServ";
import {
  getClientIntroduceData,
  getPhotoImageStr,
  uploadPhoto,
  changeClientData,
  getNotificationListByPersonId,
} from "~/services/infoServ";
import { message } from "~/tools/messageBox";
import 'cropperjs/dist/cropper.css'; // 引入 Cropper.js 的样式文件
import VueCropper from 'cropperjs';
import Cropper from "cropperjs";
import { ElMenu, ElSubMenu, ElMenuItemGroup, ElMenuItem, ElDialog, ElButton, ElIcon } from 'element-plus';
import {Setting, Postcard, ChatDotSquare, Stopwatch, Ticket, Upload, Edit, UploadFilled, Mouse, Finished, RefreshLeft, Bell, Folder, UserFilled, User, Wallet, Sort, Message, Phone, BellFilled, Opportunity, CreditCard, Male, Female,} from '@element-plus/icons-vue'

export default defineComponent({
  data: () => ({
    editMode: false as boolean,
    info: {} as ClientItem,
    clientId: null as number | null,
    imgStr: "",
    form: {
      avatarUrl: null as string | null,
    },
    cropper: null as unknown as Cropper,
    name: "" as string,
    gender: "" as string,
    genderName: "" as string,
    email: "" as string,
    phone: "" as string,
    realName: "" as string,
    idNumber: "" as string,
    croppingDialogVisible: false, // 控制裁剪对话框显示隐藏
    croppedAvatar: null as string | null, // 裁剪后的图片路径
    notificationList: [] as NotificationItem[],
    misread: 0 as number,
  }),
  components: {
    ElMenu,
    ElSubMenu,
    ElMenuItemGroup,
    ElMenuItem,
    VueCropper,
    ElDialog,
    ElButton,
    ElIcon,
    Setting,
    Postcard,
    ChatDotSquare,
    Stopwatch,
    Ticket,
    Upload,
    Edit,
    UploadFilled,
    Mouse,
    Finished,
    RefreshLeft,
    Bell,
    Folder,
    UserFilled,
    User,
    Wallet,
    Sort,
    Message,
    Phone,
    BellFilled,
    Opportunity,
    CreditCard,
    Male,
    Female,
  },
  mounted() {
    this.name = this.info.name; // 在组件加载时预填充输入框的值
    this.gender = this.info.gender;
    this.email = this.info.email;
    this.phone = this.info.phone;
    this.realName = this.info.realName;
    this.idNumber = this.info.idNumber;
    this.genderName = this.info.genderName;
  },
  created() {
    this.query();
  },

  methods: {
    async query(){
      let res = await getClientIntroduceData(this.clientId);
      this.info = res.data.info;
      console.log(this.info);
      this.clientId = this.info.clientId;
      this.name = this.info.name; // 在组件加载时预填充输入框的值
      this.gender = this.info.gender;
      this.email = this.info.email;
      this.phone = this.info.phone;
      this.realName = this.info.realName;
      this.idNumber = this.info.idNumber;
      this.genderName = this.info.genderName;
      res = await getPhotoImageStr("photo/" + this.info.personId + ".jpg");
      this.imgStr = res.data;
      console.log(this.imgStr);
      res = await getNotificationListByPersonId(this.info.personId);
      this.notificationList = res.data;
      this.misread = this.notificationList.filter(notification => (notification.status == "未读") ).length;
    },
    maskedPhone() : string {
      if (this.info.phone && this.info.phone.length > 7) {
        // 截取前3位和后3位
        const start = this.info.phone.substring(0, 3);
        const end = this.info.phone.substring(this.info.phone.length - 4);

        // 中间部分用 "*" 替换
        const middle = '*'.repeat(this.info.phone.length - 7); // 长度减去前3位和后4位

        // 拼接隐藏后的身份证号
        return start + middle + end;
      } else {
        return this.info.phone; // 如果长度小于等于7，则直接返回原始值
      }
    },
    maskedIdNumber() : string {
      if (this.info.idNumber && this.info.idNumber.length > 7) {
        // 截取前3位和后3位
        const start = this.info.idNumber.substring(0, 3);
        const end = this.info.idNumber.substring(this.info.idNumber.length - 4);

        // 中间部分用 "*" 替换
        const middle = '*'.repeat(this.info.idNumber.length - 7); // 长度减去前3位和后4位

        // 拼接隐藏后的身份证号
        return start + middle + end;
      } else {
        return this.info.idNumber; // 如果长度小于等于7，则直接返回原始值
      }
    },
    refresh(){
      this.clientId = null;
      this.query();
    },
    handleOpen() {
      console.log('菜单已打开');
    },
    handleClose() {
      console.log('菜单已关闭');
    },
    onCropEnd(cropper: Cropper) {
      this.croppedAvatar = cropper.getCroppedCanvas({
        width: 200, // 裁剪后的宽度
        height: 200, // 裁剪后的高度
        fillColor: '#fff', // 背景填充色
        imageSmoothingEnabled: true,
        imageSmoothingQuality: 'high',
      }).toDataURL(); // 将裁剪后的图像转换为 Data URL
    },
    handleCropConfirm() {
      if (this.cropper) {
        this.croppedAvatar = this.cropper.getCroppedCanvas({
          width: 200,
          height: 200,
          fillColor: '#fff',
          imageSmoothingEnabled: true,
          imageSmoothingQuality: 'high',
        }).toDataURL();
      }
      this.croppingDialogVisible = false;
    },
    getNameLast(str : string) : string {
      if(str === "" || str === undefined){
        return "null";
      }
      // 如果有括号返回(前一个字
      if (str.indexOf('(') > -1 || str.indexOf('（') > -1) {
        const _str = str.split('(') || str.split('（');
        const newStr = _str[0].substring(_str[0].length - 1);
        return newStr;
      } else {
        return str.substring(str.length - 1)
      }
    },

    cancelCrop() {
      // 取消裁剪操作
      this.croppedAvatar = '';
      this.form.avatarUrl = ''; // 清空选择的图片
      this.croppingDialogVisible = false; // 取消裁剪关闭对话框
    },
    handleUploadClick() {
      (this.$refs.fileInput as HTMLInputElement).click();
    },
    handleFileChange(event: Event) {
      const file = (event.target as HTMLInputElement).files?.[0];
      if (file) {
        this.form.avatarUrl = URL.createObjectURL(file); // 在界面上显示选择的图片
        this.croppingDialogVisible = true; // 选择图片后显示裁剪对话框
      } else {
        this.form.avatarUrl = null;
      }
    },
    async uploadFile() {
      const file = (this.$refs.fileInput as HTMLInputElement)?.files?.[0];
      if (!file) {
        message(this, "请选择文件！");
        return;
      }
      const res = await uploadPhoto("photo/" + this.info.personId + ".jpg", file);
      if (res.code === 0) {
        message(this, "上传成功");
        // 清空表单
        this.form.avatarUrl = null;
        // 清空选择的文件
        (this.$refs.fileInput as HTMLInputElement).value = "";
        this.query();
      } else {
        message(this, "上传失败");
      }
    },
    async changeClientData() {
      let res = await changeClientData({
        clientId: this.info.clientId,
        name: this.name,
        phone: this.phone,
        gender: this.gender,
      });
      if (res.code != 0) {
        message(this, res.msg);
        return;
      } else {
        message(this, "修改成功！");
        this.query();
      }
    },
    handleRealNameVerification(clientId: number){
      this.$router.push({ path: '/RealNameVerification', query: { clientId: clientId } });
    },
    viewPaidDeals(clientId: number){
      this.$router.push({ path: '/ClientPaidDeals', query: { clientId: clientId } });
    },
    viewRefundDeals(clientId: number){
      this.$router.push({ path: '/ClientRefundDeals', query: { clientId: clientId } });
    },
    viewSpotTickets(clientId: number){
      this.$router.push({ path: '/PaidSpotTicket', query: { clientId: clientId } });
    },
    routerName(name: string) {
      if (name == null || name == undefined || name == "") {
        return;
      }
      if (name == "ProjectHtml") {
        this.openProjectHtml();
        return;
      }
      if (name == "ProjectVideo") {
        this.openProjectVideo();
        return;
      }
      this.$router.push({
        path: "/" + name
      });
    },
    openProjectHtml() {
      window.open("projectDoc.html");
    },
    // 打开新窗口 显示projectVideo.html内容，这个文件在public目录下,同学要录制项目特色视频，作为项目特色介绍视频包房，用于检查作业的老师直接打开该页面查看项目特色
    openProjectVideo() {
      window.open("projectVideo.html");
    },
    goToMainPage(){
      this.$router.push("/MainPage")
    },
    goToNotificationPage(){
      this.$router.push({ path: '/NotificationCenter', query: { personId: this.info.personId } });
    },
  },
});
</script>
<style scoped>
.avatar-preview {
  width: 100px;
  height: 100px;
  border-radius: 50%;
  margin-top: 10px;
}

.parent-container {
  width: 100%;
  align-items: stretch; /* 让子元素高度相等 */
}

.buttons-container {
  margin-top: 20px; /* 适当的上边距 */
  text-align: center; /* 让按钮居中显示 */

  /* 如果需要可以设置背景颜色和边框 */
  background-color: #f0f0f0;
  padding: 10px;
  border-radius: 5px;
}

.buttons-container el-button {
  margin: 0 10px; /* 按钮之间的间距 */
  width: 120px; /* 按钮的宽度 */
  height: 40px; /* 按钮的高度 */
  font-size: 14px; /* 字体大小 */
}

.buttons-container el-button:first-child {
  margin-left: 0; /* 第一个按钮没有左边距 */
}

.buttons-container el-button:last-child {
  margin-right: 0; /* 最后一个按钮没有右边距 */
}

/* 按钮的主题颜色和悬停效果 */
.buttons-container el-button[type="primary"] {
  background-color: #409eff;
  border-color: #409eff;
  color: #fff;
}

.buttons-container el-button[type="primary"]:hover {
  background-color: #66b1ff;
  border-color: #66b1ff;
}

/* 如果需要不同类型的按钮样式，可以分别设置 */
.buttons-container el-button[type="success"] {
  background-color: #67c23a;
  border-color: #67c23a;
  color: #fff;
}

.buttons-container el-button[type="success"]:hover {
  background-color: #85ce61;
  border-color: #85ce61;
}

#myChartBar {
  float: left;
}

#myChartLine {
  float: right;
}

#myChartPie {
  float: right;
}

.word20 {
  width: 28px;
  height: 14px;
  overflow-wrap: break-word;
  color: rgba(255, 255, 255, 1);
  font-size: 14px;
  font-family: STHeitiSC-Medium;
  text-align: left;
  white-space: nowrap;
  line-height: 14px;
  display: block;
  margin: 15px 0 0 140px;
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

.inputWidth {
  width: 478px;
  margin-top: 10px;
}

.flex-col {
  display: flex;
  flex-direction: column;
}

.flex-row {
  display: flex;
  flex-direction: row;
}

.justify-between {
  display: flex;
  justify-content: space-between;
}

.oldPass {
  text-align: center;
  width: 100px;
  height: 42px;
  font-size: 14px;
  font-family: PingFangTC-Regular, PingFangTC;
  font-weight: 400;
  color: #202020;
  line-height: 42px;
  margin-right: 12px;
}

.oldPassword {
  margin-left: 100px;
  margin-top: 5px;
}

.group8 {
  background-color: rgba(147, 14, 20, 1);
  border-radius: 4px;
  height: 42px;
  width: 311px;
  margin-left: 1000px;
  cursor: pointer;
}

.user-center {
  padding: 20px;
}

.user-header {
  display: flex;
  align-items: center;
  margin-bottom: 20px;
}

.user-info {
  display: flex;
  justify-content: center;
  align-items: center;
  margin-top: 20px; /* 根据需要调整间距 */
}

.button-group {
  display: flex;
  justify-content: center;
  align-items: center;
  gap: 20px; /* 按钮之间的间隔 */
}

.settings-btn {
  margin-left: auto;
}

.user-card {
  width: 100%;
}

.section {
  margin-bottom: 20px;
}

.section h3 {
  font-size: 18px;
  margin-bottom: 10px;
}

.edit-button {
  float: right;
  margin-top: -5px;
  border: 1px solid #409eff; /* 添加边框 */
  padding: 5px 10px; /* 添加内边距 */
  color: #409eff; /* 蓝色按钮 */
  cursor: pointer;
}

.box-card {
  margin-top: 20px;
  box-shadow: 0 2px 12px 0 rgba(0, 0, 0, 0.1);
  height: 100%;
}

.box-card > .el-form {
  padding: 20px;
}

.box-card > div {
  padding: 20px;
}

.box-card p {
  margin-bottom: 10px;
}

.el-form-item {
  margin-bottom: 15px;
}

.el-button {
  margin-right: 10px;
}

.user-info {
  font-family: Arial, sans-serif;
  background-color: #f0f0f0;
  padding: 20px;
  border-radius: 5px;
  box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
}
.user-info p {
  margin-bottom: 10px;
  line-height: 1.5;
}
.user-info strong {
  font-weight: bold;
}

.avatar-container {
  text-align: center;
}

.avatar {
  border: 3px solid #0c0c0c; /* 边框粗细和颜色 */
  border-radius: 50%; /* 让头像变成圆形 */
  overflow: hidden; /* 确保边框不会被裁剪 */
}

.clearfix::after {
  content: "";
  display: table;
  clear: both;
  margin-bottom: 20px;
}

.clearfix {
  content: "";
  display: table;
  clear: both; /* 触发 hasLayout */
  margin: 0 auto; /* 水平居中 */
  text-align: center; /* 文本内容水平居中 */
}

.clearfix img {
  max-width: 100%; /* 图片最大宽度为父元素宽度的100% */
  height: auto; /* 高度自适应，保持宽高比 */
  max-height: 200px; /* 图片最大高度为200px，防止图片过大 */
}

.clearfix:before,
.clearfix:after {
  content: " ";
  display: table;
}

.clearfix:after {
  clear: both;
}

.clearfix1::after {
  content: "";
  display: table;
  clear: both;
}

.clearfix1 {
  content: "";
  display: table;
  clear: both; /* 触发 hasLayout */
}

.clearfix1 img {
  max-width: 100%; /* 图片最大宽度为父元素宽度的100% */
  height: auto; /* 高度自适应，保持宽高比 */
  max-height: 200px; /* 图片最大高度为200px，防止图片过大 */
}

.clearfix1:before,
.clearfix1:after {
  content: " ";
  display: table;
}

.clearfix1:after {
  clear: both;
}

/*.avatar-preview {
  max-width: 100%;
  max-height: 300px;
  margin-top: 10px;
}*/

.avatar-preview {
  max-width: 100px; /* 根据需求调整显示大小 */
  max-height: 100px;
  border-radius: 50%; /* 圆形头像效果 */
}

.custom-img {
  width: 300px;
}

.custom-info {
  width: 700px;
}

.custom-menu {
  background-color: #f0f2f5; /* 菜单背景色 */
  width: 200px; /* 菜单宽度 */
  border-right: 1px solid #c0c4cc; /* 右边框 */
}

.custom-menu-item {
  text-align: center; /* 居中菜单项文本 */
  padding: 12px 20px; /* 调整菜单项内边距 */
  color: #606266; /* 文本颜色 */
  font-size: 14px; /* 字体大小 */
}

.custom-menu-item:hover {
  background-color: #e6f7ff; /* 鼠标悬停时的背景色 */
}

.custom-menu-item i {
  font-size: 18px; /* 图标大小 */
  margin-right: 10px; /* 图标右边距 */
}

.custom-submenu {
  text-align: left; /* 子菜单标题左对齐 */
  font-weight: bold; /* 粗体子菜单标题 */
  background-color: #fafafa; /* 子菜单背景色 */
}

.el-submenu__title {
  font-size: 14px; /* 子菜单标题字体大小 */
  padding: 10px 20px; /* 子菜单标题内边距 */
}

.el-submenu__title:hover {
  background-color: #f5f7fa; /* 鼠标悬停时的子菜单标题背景色 */
}

.el-menu-item-group__title {
  font-size: 13px; /* 分组标题字体大小 */
  padding: 8px 20px; /* 分组标题内边距 */
  color: #909399; /* 分组标题颜色 */
}

.el-menu-item-group__item {
  font-size: 12px; /* 分组项字体大小 */
  padding: 8px 40px; /* 分组项内边距 */
}

.el-menu-item-group__item:hover {
  background-color: #f0f2f5; /* 鼠标悬停时的分组项背景色 */
}

.menu-title {
  display: flex; /* 使用 Flex 布局 */
  align-items: center; /* 垂直居中对齐 */
}

.menu-title span {
  font-weight: bold; /* 设置文字粗体 */
  font-size: 14px; /* 设置文字大小 */
  color: #0c0909; /* 设置文字颜色 */
}

.centered-menu-item {
  text-align: center;
}

.centered-menu-item span {
  display: block;
}

.cropper-container {
  position: relative;
  width: 300px; /* 自定义容器宽度 */
  height: 300px; /* 自定义容器高度 */
  margin: auto; /* 居中显示 */
  overflow: hidden; /* 隐藏裁剪框之外的内容 */
}
.cropper-wrapper {
  width: 100%;
  height: 100%;
}
.cropper-buttons {
  text-align: center;
  margin-top: 10px;
}
</style>
