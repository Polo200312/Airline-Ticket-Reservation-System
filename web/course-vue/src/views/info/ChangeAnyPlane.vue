<template>
  <div id="delAnyPlane">
    <el-tabs id="box" type="border-card">
      <el-tab-pane :label="selectedDay">
        <ChangeAnyPlaneIn
          v-if="planesList.length !== 0"
          v-for="plane in planesList"
          :pId="plane.planeId.toString()"
          :dId="dealId.toString()"
        ></ChangeAnyPlaneIn>
        <div v-if="planesList.length === 0">
          <span
            ><el-icon><InfoFilled /></el-icon>当日无航班</span
          >
        </div>
      </el-tab-pane>
    </el-tabs>
  </div>
</template>

<script lang="ts">
import { defineComponent } from "vue";
import {
  type OptionItem,
  type ClientItem,
  type DealItem,
  type PlaneItem,
} from "~/models/general";
import { getAuthHeader } from "~/services/genServ";
import {
  searchForPlanes,
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
  ElTabs,
  ElTabPane,
} from "element-plus";
import ChangeAnyPlaneIn from "./ChangeAnyPlaneIn.vue";
import { InfoFilled, } from '@element-plus/icons-vue';

export default defineComponent ({
  components:{
    ChangeAnyPlaneIn,
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
    ElTabs,
    ElTabPane,
    InfoFilled,
  },
  data: () => ({
    dealId: 0 as number,
    planesList: [] as PlaneItem[],
    startCity: "" as string,
    endCity: "" as string,
    selectedDay: "" as string,
  }),
  created(){
    this.query();
  },
  methods:{
    async query() {
      const dealIdStr = this.$route.query.dealId as string;
      this.dealId = Number(dealIdStr);
      this.startCity = this.$route.query.startCity as string;
      this.endCity = this.$route.query.endCity as string;
      this.selectedDay = this.$route.query.selectedDay as string;
      const res = await searchForPlanes({
        startDay: this.selectedDay,
        startCity: this.startCity,
        endCity: this.endCity,
      });
      this.planesList = res.data;
      console.log(this.planesList);
    },
  },
});
</script>

<style scoped>
#delAnyPlane {
  width: auto;
  height: 498px;
  overflow: auto;
  margin-top: 10px;
}
#box {
  width: auto;
  min-height: 498px;
}
</style>
