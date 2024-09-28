<template>
  <el-backtop :bottom="100">
    <div
      style="
        height: 100%;
        width: 100%;
        background-color: var(--el-bg-color-overlay);
        box-shadow: var(--el-box-shadow-lighter);
        text-align: center;
        line-height: 40px;
        color: #9e2323;
      "
    >
      UP
    </div>
  </el-backtop>
  <div style="height: 100%">
    <!-- 当登录成功后显示此DIV -->
    <div
      style="height: 100%"
      v-if="
        userInfo.username && userInfo.username.length > 0 && systemConfig.showLeftMeun
      "
    >
      <el-container style="height: 100%">
        <!-- 主页面的头部区域 -->
        <el-header height="72px" class="topHeader">
          <div class="outer1 flex-col">
            <div class="block1 justify-between">
              <div class="flex-row">
                <div class="section1 flex-col"></div>
                <div class="section2 flex-col"></div>
                <div class="title">飞机票售票平台</div>
              </div>
              <div>
                <el-affix :offset="20">
                  <div>
                    <el-menu
                      default-active="2"
                      class="el-menu-horizontal-demo"
                      :collapse="isCollapse"
                      mode="horizontal"
                      style="width: 700px; height: 40px; overflow: hidden"
                    >
                      <el-sub-menu index="1">
                        <template #title>
                          <el-icon>
                            <User />
                          </el-icon>
                          <span>个人账户</span>
                        </template>
                        <el-menu-item
                          index="/ClientCenter"
                          v-if="userInfo.roles === 'ROLE_CLIENT'"
                          @click="routerName('ClientCenter')"
                          >用户中心</el-menu-item
                        >
                        <el-menu-item
                          index="/AirlineCompanyCenter"
                          v-if="userInfo.roles === 'ROLE_AIRLINECOMPANY'"
                          @click="routerName('AirlineCompanyCenter')"
                          >用户中心</el-menu-item
                        >
                        <el-menu-item
                          index="/MessageCenter"
                          @click="routerName('MessageCenter')"
                          >消息中心</el-menu-item
                        >
                      </el-sub-menu>

                      <el-sub-menu index="2" v-if="userInfo.roles === 'ROLE_ADMIN'">
                        <template #title
                          ><el-icon>
                            <Menu />
                          </el-icon>
                          <span>系统管理</span>
                          <input
                            type="file"
                            ref="fileInput"
                            @change="handleFileUpload"
                            style="display: none"
                        /></template>
                        <el-menu-item
                          index="/menu-manage-panel"
                          @click="routerName('menu-manage-panel')"
                          >菜单管理</el-menu-item
                        >
                        <el-menu-item
                          index="/dictionary-manage-panel"
                          @click="routerName('dictionary-manage-panel')"
                          >字典管理</el-menu-item
                        >
                        <el-menu-item index="/menu-manage-panel" @click="saveSQL()"
                          >数据库备份</el-menu-item
                        >
                        <el-menu-item index="/import-database" @click="selectFile()">
                          导入数据库
                        </el-menu-item>
                      </el-sub-menu>
                      <el-sub-menu index="3" v-if="userInfo.roles === 'ROLE_ADMIN'">
                        <template #title
                          ><el-icon>
                            <document />
                          </el-icon>
                          <span>人员管理</span></template
                        >
                        <el-menu-item
                          index="/ClientManagement"
                          @click="routerName('ClientManagement')"
                          >用户管理</el-menu-item
                        >
                        <el-menu-item
                          index="/AirlineCompanyManagement"
                          @click="routerName('AirlineCompanyManagement')"
                          >航空公司管理</el-menu-item
                        >
                      </el-sub-menu>
                      <el-sub-menu index="4">
                        <template #title
                          ><el-icon>
                            <MessageBox />
                          </el-icon>
                          <span>信息中心</span></template
                        >
                        <el-menu-item
                          index="/NationManagement"
                          @click="routerName('NationManagement')"
                          v-if="userInfo.roles === 'ROLE_ADMIN'"
                          >国家信息管理</el-menu-item
                        >
                        <el-menu-item
                          index="/CityManagement"
                          @click="routerName('CityManagement')"
                          v-if="userInfo.roles === 'ROLE_ADMIN'"
                          >城市信息管理</el-menu-item
                        >
                        <el-menu-item
                          index="/AirportManagement"
                          @click="routerName('AirportManagement')"
                          v-if="userInfo.roles === 'ROLE_ADMIN'"
                          >机场信息管理</el-menu-item
                        >
                        <el-menu-item
                          index="/SpotManagement"
                          @click="routerName('SpotManagement')"
                          v-if="userInfo.roles === 'ROLE_ADMIN'"
                          >景点信息管理</el-menu-item
                        >
                        <el-menu-item
                          index="/Search"
                          @click="routerName('Search')"
                          v-if="userInfo.roles === 'ROLE_CLIENT'"
                          >飞机票预订查询</el-menu-item
                        >
                        <el-menu-item
                          index="/PublishFlights"
                          @click="routerName('PublishFlights')"
                          v-if="userInfo.roles === 'ROLE_AIRLINECOMPANY'"
                          >发布新航班</el-menu-item
                        >
                        <el-menu-item
                          index="/FlightsManagement"
                          @click="routerName('FlightsManagement')"
                          v-if="userInfo.roles === 'ROLE_AIRLINECOMPANY'"
                          >航班信息管理</el-menu-item
                        >
                      </el-sub-menu>

                      <el-sub-menu index="5">
                        <template #title
                          ><el-icon>
                            <Setting />
                          </el-icon>
                          <span>设置</span></template
                        >
                        <el-menu-item index="/Password" @click="routerName('Password')"
                          >修改密码</el-menu-item
                        >
                        <el-menu-item
                          index="/ChangeEmail"
                          @click="routerName('ChangeEmail')"
                          >修改邮箱</el-menu-item
                        >
                      </el-sub-menu>
                      <el-sub-menu index="6">
                        <template #title
                          ><el-icon>
                            <MapLocation />
                          </el-icon>
                          <span>工具栏</span></template
                        >
                        <el-menu-item @click="goGoogleMap()">谷歌地图</el-menu-item>
                        <el-menu-item @click="goWorldClock()">世界时钟</el-menu-item>
                      </el-sub-menu>
                      <el-sub-menu
                        index="/SystemIntroduce"
                        @click="routerName('SystemIntroduce')"
                      >
                        <template #title
                          ><el-icon> <Document /> </el-icon
                          ><span>系统简介</span></template
                        >
                        <el-menu-item index="6-1">项目文档</el-menu-item>
                        <el-menu-item index="6-2">项目视频</el-menu-item>
                      </el-sub-menu>
                    </el-menu>
                  </div>
                </el-affix>
              </div>
              <div class="flex-row">
                <img
                  class="icon1"
                  referrerpolicy="no-referrer"
                  src="https://static.thenounproject.com/png/5105250-200.png"
                />
                <div class="section3 flex-col justify-between">
                  <span class="word1">您好～</span>
                  <span class="info"
                    >{{ userInfo.perName }}({{ userInfo.username }})
                    {{ currentTime }}</span
                  >
                </div>
                <div class="section4 flex-col"></div>

                <div class="section5" @click="back">
                  <div class="fanhuiImage"></div>
                  <div class="shuaxin">返回</div>
                </div>

                <div class="section5" @click="refreshPage">
                  <div class="shuxinImage"></div>
                  <div class="shuaxin">主页</div>
                </div>

                <div class="section6" @click="logout()">
                  <div class="tuichuImage"></div>
                  <div class="shuaxin">退出</div>
                </div>
              </div>
            </div>
            <el-divider />
          </div>
        </el-header>
        <!-- 主页面的中心区域 -->
        <el-container>
          <!--   router-view 控制显示VUE页面，VUE会根据路由路径不同.vue文件的内容，我们设计的所有vue文件内容都在这里渲染 -->
          <el-main style="position: relative">
            <div class="background-image"></div>
            <router-view />
          </el-main>
        </el-container>
      </el-container>
    </div>
    <!--  当登录前显示此DIV router-view 控制显示VUE页面，VUE会根据路由路径不同.vue文件的内容， 初始路由路径为/，显示Login.vue内容 -->
    <div style="height: 100%" v-else>
      <router-view />
    </div>
  </div>
</template>

<script lang="ts">
// 引入使用的组件、函数和数据接口
import { ref } from 'vue'
import { mapState } from "pinia";
import { defineComponent } from "vue";
import { useAppStore } from "~/stores/app";
import router from "~/router";
import {
  saveSQL,
  uploadSQL,
} from "~/services/infoServ";
import { type MenuInfo } from "~/models/general";
import { formatTime } from "~/tools/comMethod";
import { message } from "~/tools/messageBox";
import { Location, Setting, Menu, Document, MessageBox, User, MapLocation } from '@element-plus/icons-vue';


const isCollapse = ref(true)
const handleOpen = (key: string, keyPath: string[]) => {
  console.log(key, keyPath)
}
const handleClose = (key: string, keyPath: string[]) => {
  console.log(key, keyPath)
}
// vue3中新增了 defineComponent ，它并没有实现任何的逻辑，只是把接收的 Object 直接返回，它的存在就是完全为了服务 TypeScript 而存在的。
// 我都知道普通的组件就是一个普通的对象，既然是一个普通的对象，那自然就不会获得自动的提示，
export default defineComponent({
  // templte中使用的数据

  components: {
            Location, Setting, Menu ,Document, MessageBox, User, MapLocation,
        },

  data: () => ({
    isCollapse: false,
    leList: [] as MenuInfo[],
    funId: "",
    showLeftList: true,
    timer: null as any,
    currentTime: formatTime(new Date()),
  }),
  //生命周期函数  mounted() 在实例挂载之后调用， 设置定期刷新控制台时间
  mounted() {
    if (this.timer) {
      clearInterval(this.timer);
    } else {
      this.timer = setInterval(() => {
        this.currentTime = formatTime(new Date());
      }, 1000);
    }
    const store = useAppStore();
    if (store.userInfo.username &&
      store.userInfo.username.length > 0 &&
      store.systemConfig.showLeftMeun)
      router.push("/MainPage");
    else
      router.push("/Login")
  },
  // 生命周期函数  unmounted() 在实例销毁之后调用，清除定期刷新控制台时间
  unmounted() {
    clearInterval(this.timer);
  },
  // 计算属性 用于计算属性，计算属性的结果会被缓存，除非依赖的响应式属性变化才会重新计算 当用户信息和菜单更新后页面会重新显然，显示主界面
  computed: {
    ...mapState(useAppStore, ["systemConfig"]),
    ...mapState(useAppStore, ["userInfo"]),
  },
  methods: {
    // 退出登录
    logout() {
      const store = useAppStore();
      store.logout();
      router.push("/Login");
    },
    refreshPage() {
      location.reload(); // 刷新当前页面
    },
    back(){
      this.$router.back();
    },
    // 获取二级菜单
    getSecondList(id: number) {
      const store = useAppStore();
      store.setLeftList(id);
      router.push("/MainPage");
    },
    // 路由跳转 如果路由名为ProjectHtml或者ProjectVideo则打开新的窗口 其他的路由跳转到对应的页面
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
      router.push({
        path: "/" + name
      });
    },
    // 打开新窗口 显示projectDoc.html内容，这个文件在public目录下,同学要修改该页面的内容，作为项目详细介绍的页面，用于检查作业的老师直接打开该页面即可看到作业的详细介绍
    openProjectHtml() {
      window.open("projectDoc.html");
    },
    // 打开新窗口 显示projectVideo.html内容，这个文件在public目录下,同学要录制项目特色视频，作为项目特色介绍视频包房，用于检查作业的老师直接打开该页面查看项目特色
    openProjectVideo() {
      window.open("projectVideo.html");
    },
    goGoogleMap() {
      // 在新标签页中打开谷歌地图
      window.open('https://www.google.com/maps', '_blank');
      // window.location.href = 'https://www.google.com/maps';
    },
    goWorldClock() {
      this.$router.push({ path: '/Timer'});
    },
    // 触发文件选择器
    selectFile() {
      (this.$refs.fileInput as HTMLInputElement).click();
    },
    // 处理文件上传
    async handleFileUpload(event: Event) {
      const file = (this.$refs.fileInput as HTMLInputElement)?.files?.[0];
      if (file) {
        let res = await uploadSQL(file);
        if (res.code === 0) {
          message(this, "上传成功");
          // 清空选择的文件
          (this.$refs.fileInput as HTMLInputElement).value = "";
        } else {
          message(this, res.msg);
          return;
        }
      }else{
        message(this, "请选择文件！");
        return;
      }
    },
    async saveSQL(){
      let res = await saveSQL();
      if (res.code != 0) {
        message(this, res.msg);
        return;
      } else {
        message(this, "数据库备份成功！");
      }
    },
  },
});
</script>
<!-- 这个是系统主页面的样式，同学可以根据自己的喜好修改 -->
<style lang="scss" scoped>
.background-image {
  position: absolute;
  top: 0;
  left: 0;
  width: 100%;
  height: 100%;
  background-image: url("background.jpg");
  background-size: cover;
  background-position: center;
  background-repeat: no-repeat;
  z-index: -1;
  opacity: 0.8;
  pointer-events: none;
}
.el-menu-vertical-demo:not(.el-menu--collapse) {
  width: 200px;
  min-height: 100px;
}

/*.el-menu-item.is-active {
  background-color: rgb(105, 74, 74) !important;
}

.el-menu--horizontal > .el-menu-item {
  height: 44px;
  line-height: 44px;
  font-family: SourceHanSansCN-Regular;
  font-size: 16px;
  color: #ffffff;
  letter-spacing: 0;
  font-weight: 400;
}

.el-menu--horizontal > .el-menu-item.is-active {
  background-color: rgb(197, 24, 32) !important;
}*/

.topHeader {
  padding: 0px;
}

.m-header {
  height: 60px !important;
  background-color: rgb(255, 255, 255);
  display: flex;
  flex-direction: row;
  justify-content: space-between;
}

.header {
  display: flex;
  flex-direction: column;
}

.right {
  cursor: pointer;
  display: flex;
  flex-direction: row;
}

.scrollar {
  height: 100%;
  overflow-x: hidden;
  background-color: rgb(44, 48, 57);
}

.pername {
  margin-top: 15px;
  font-size: 20px;
  color: gray;
  font-weight: bold;
}

.titile {
  font-size: 29px;
  color: #0067ff;
  letter-spacing: 0;
  font-weight: bold;
  background-color: #ffffff;
  width: 180px;
  height: 40px;
  margin-top: 10px;
  margin-left: 40px;
}

.right-header {
  font-family: PingFangSC-Regular;
  font-size: 14px;
  color: #47474a;
  letter-spacing: 0;
  font-weight: 400;
  margin-top: 20px;
  margin-right: 30px;
}

.shuxian {
  margin-top: 5px;
  margin-bottom: 5px;
  height: 50px;
  width: 1px;
  background: #cfd2d7;
  margin-right: 30px;
}

.tuichu {
  font-family: PingFangSC-Regular;
  font-size: 14px;
  color: #47474a;
  letter-spacing: 0;
  font-weight: 400;
  margin-top: 20px;
  margin-right: 30px;
}

.icon_tuichu {
  margin-top: 23px;
  margin-right: 10px;
  background: url("/loginOut.png");
  width: 14px;
  height: 14px;
}

.image {
  width: 30px;
  margin-top: 15px;
  margin-right: 20px;
  height: 30px;
}

.search {
  margin-top: 23px;
  margin-right: 30px;
  background: url("/serch.png");
  width: 18px;
  height: 18px;
}

.question {
  margin-top: 23px;
  margin-right: 30px;
  background: url("/question.png");
  width: 18px;
  height: 18px;
}

.alarm {
  margin-top: 23px;
  margin-right: 80px;
  background: url("/alarm.png");
  width: 18px;
  height: 18px;
}

.leftIcon {
  cursor: pointer;
  margin-top: 23px;
  margin-left: 18px;
  background: url("/leftright.png");
  width: 18px;
  height: 18px;
}

.outer1 {
  background-color: rgba(255, 255, 255, 1);
  height: 100px;
  width: 100%;
}

.block1 {
  width: 95%;
  height: 44px;
  margin: 13px 0 0 35px;
}

.section1 {
  width: 236px;
  height: 40px;
  background: url("/logo3.png") 100% no-repeat;
  margin-top: 2px;
}

.section2 {
  background-color: rgba(147, 14, 20, 1);
  width: 1px;
  height: 35px;
  margin: 5px 0 0 26px;
}

.txt1 {
  width: 216px;
  height: 29px;
  overflow-wrap: break-word;
  color: rgba(147, 14, 20, 1);
  font-size: 24px;
  font-family: jiangxizhuokai;
  text-align: right;
  white-space: nowrap;
  line-height: 29px;
  display: block;
  margin: 8px 0 0 19px;
}

.icon1 {
  width: 44px;
  height: 44px;
}

.section3 {
  width: 140px;
  height: 33px;
  margin: 7px 0 0 14px;
  background-color: rgba(255, 255, 255, 1);
}

.word1 {
  width: 36px;
  height: 12px;
  overflow-wrap: break-word;
  color: #2d2d2d;
  font-size: 12px;
  font-family: SourceHanSansCN-Regular;
  text-align: right;
  white-space: nowrap;
  line-height: 12px;
  display: block;
}

.info {
  width: 140px;
  height: 14px;
  font-size: 12px;
  overflow-wrap: break-word;
  font-family: SourceHanSansCN-Regular, SourceHanSansCN;
  font-weight: 400;
  color: #2d2d2d;
  white-space: nowrap;
  line-height: 21px;
}

.section4 {
  background-color: rgba(229, 227, 227, 1);
  width: 1px;
  height: 33px;
  margin: 7px 0 0 25px;
}

.section5 {
  width: 20px;
  height: 33px;
  margin: 9px 0 0 35px;
  cursor: pointer;
}

.section6 {
  width: 20px;
  height: 32px;
  margin: 9px 0 0 25px;
  cursor: pointer;
}

.info2 {
  width: 20px;
  height: 10px;
  overflow-wrap: break-word;
  color: rgba(45, 45, 45, 1);
  font-size: 10px;
  font-family: SourceHanSansCN-Regular;
  text-align: right;
  white-space: nowrap;
  line-height: 10px;
  margin-top: 8px;
  display: block;
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

.shuaxin {
  width: 20px;
  height: 10px;
  overflow-wrap: break-word;
  color: rgba(45, 45, 45, 1);
  font-size: 10px;
  text-align: right;
  white-space: nowrap;
  line-height: 10px;
  margin-top: 8px;
}

.fanhuiImage {
  width: 14px;
  height: 14px;
  background: url("/back.png");
  margin-left: 3px;
}

.shuxinImage {
  width: 16px;
  height: 14px;
  background: url("/refresh.png");
  margin-left: 3px;
}

.tuichuImage {
  width: 14px;
  height: 14px;
  background: url("/tuichu.png");
  margin-left: 5px;
}

.box1 {
  width: 235px;
  height: 24px;
  background: url("/gradms.png") -1px -1px no-repeat;
  margin: 12px 0 0 19px;
}

.title {
  font-size: 26px;
  font-weight: 500;
  margin: 2px 0 0 10px;
  color: rgb(157, 27, 53);
}

.el-menu-horizontal-demo {
  //background-color: #545c64; /* 背景颜色 */
  color: #040404; /* 文字颜色 */
  display: flex; /* 使用 flexbox 布局 */
  align-items: center; /* 垂直居中 */
  padding: 10px; /* 内边距 */
}

.el-menu-horizontal-demo .el-menu-item {
  cursor: pointer; /* 光标样式 */
  padding: 10px; /* 菜单项内边距 */
  transition: background-color 0.3s; /* 过渡效果 */
}

.el-menu-horizontal-demo .el-menu-item:hover {
  background-color: #409eff; /* 鼠标悬停时背景颜色 */
}

.el-menu-horizontal-demo .el-menu-item.is-active {
  background-color: #67c23a; /* 被激活（点击）时的背景颜色 */
}
</style>
