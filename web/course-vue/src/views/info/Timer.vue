<template>
  <el-container>
    <!-- 动态系统时间 -->
    <el-header style="text-align: center; font-size: 24px; padding: 20px 0">
      <el-card>
        <div class="clock-wrapper">
          <div class="clock">
            <div
              class="hand hour-hand"
              :style="{ transform: `rotate(${hoursDegree}deg)` }"
            ></div>
            <div
              class="hand minute-hand"
              :style="{ transform: `rotate(${minutesDegree}deg)` }"
            ></div>
            <div
              class="hand second-hand"
              :style="{ transform: `rotate(${secondsDegree}deg)` }"
            ></div>
          </div>
        </div>
        <div>系统时间 ： {{ currentTime }}</div>
      </el-card>
    </el-header>

    <!-- 四个城市的时间窗口 -->
    <el-main style="margin-top: 270px">
      <el-row :gutter="20">
        <el-col :span="12" v-for="(city, index) in selectedCities" :key="city.cityId">
          <el-card>
            <div>
              <h3>{{ city.cityName }} - 时区 ：{{ city.timeZone }}</h3>
              <p>
                <el-icon><Clock /></el-icon>{{ cityTime[index] }}
              </p>
            </div>
            <el-select placeholder="选择城市" @change="cityChanged($event, index)">
              <el-option
                v-for="item in cities"
                :key="item.cityId"
                :label="item.cityName"
                :value="item.cityId"
              ></el-option>
            </el-select>
          </el-card>
        </el-col>
      </el-row>
    </el-main>

    <!-- 时差计算器 -->
    <el-footer style="padding: 20px 0; text-align: center">
      <el-card>
        <el-row :gutter="20">
          <el-col :span="10">
            <el-select v-model="selectedCity1" placeholder="选择城市">
              <el-option
                v-for="item in cities"
                :key="item.cityId"
                :label="item.cityName"
                :value="item.cityId"
              ></el-option>
            </el-select>
          </el-col>
          <el-col :span="10">
            <el-select v-model="selectedCity2" placeholder="选择城市">
              <el-option
                v-for="item in cities"
                :key="item.cityId"
                :label="item.cityName"
                :value="item.cityId"
              ></el-option>
            </el-select>
          </el-col>
          <el-col :span="4">
            <el-button type="primary" @click="calculateTimeDifference">
              <el-icon><Edit /></el-icon>计算时差
            </el-button>
          </el-col>
        </el-row>
        <p v-if="timeDifference !== null">时差: {{ timeDifference }} 小时</p>
      </el-card>
    </el-footer>
  </el-container>
</template>

<script lang="ts">
import { defineComponent, ref, onMounted } from 'vue';
import {
  type OptionItem,
  type CityItem,
} from "~/models/general";
import { getAuthHeader } from "~/services/genServ";
import {
  getClientIntroduceData,
  getAllCityList,
} from "~/services/infoServ";
import { message } from "~/tools/messageBox";
import 'cropperjs/dist/cropper.css'; // 引入 Cropper.js 的样式文件
import VueCropper from 'cropperjs';
import Cropper from "cropperjs";
import { ElMenu, ElSubMenu, ElMenuItemGroup, ElMenuItem, ElDialog, ElButton, ElIcon, ElSelect, ElOption, ElContainer, ElMain,} from 'element-plus';
import { Clock, Edit, } from "@element-plus/icons-vue";


export default defineComponent({
  data: () => ({
    currentTime: "" as string,
    cities: [] as CityItem[],
    selectedCities: [] as CityItem[],
    cityTime: [] as string[],
    selectedCity1: "请选择城市" as number | string,
    selectedCity2: "请选择城市" as number | string,
    timeDifference: 0 as number,
    intervalId: null as number | null,// 定时器Id
    hoursDegree: 0,
    minutesDegree: 0,
    secondsDegree: 0,
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
    ElSelect,
    ElOption,
    ElContainer,
    ElMain,
    Clock,
    Edit,
  },
  created() {
    this.query();
    this.intervalId = setInterval(() => {
      this.currentTime = new Date().toLocaleTimeString();
      this.selectedCities.forEach((_, index) => this.updateCityTime(index));
    }, 1000) as unknown as number;
  },
  mounted() {
    this.updateClock();
    setInterval(this.updateClock, 1000); // 每秒更新一次
  },
  beforeDestroy() {
    // 销毁之前清除定时器
    if (this.intervalId) {
      clearInterval(this.intervalId);
    }
  },
  methods: {
    async query(){
        let res = await getAllCityList();
        this.cities = res.data;
        console.log(this.cities);
        this.currentTime = new Date().toLocaleTimeString();
        this.selectedCities = [this.cities[0], this.cities[6], this.cities[5], this.cities[3]];
        this.selectedCities.forEach((_, index) => this.updateCityTime(index));
    },
    updateClock() {
      const now = new Date();
      const seconds = now.getSeconds();
      const minutes = now.getMinutes();
      const hours = now.getHours();

      this.secondsDegree = (seconds / 60) * 360 + 90; // 每秒钟移动6度
      this.minutesDegree = (minutes / 60) * 360 + (seconds / 60) * 6 + 90; // 每分钟移动6度
      this.hoursDegree = (hours / 12) * 360 + (minutes / 60) * 30 + 90; // 每小时移动30度
    },
    updateCityTime(index: number) {
      const timeZone = this.selectedCities[index].timeZone;
      this.cityTime[index] = this.getTimeInTimeZone(timeZone);
    },
    getTimeInTimeZone(timeZone: string): string {
      const utcOffset = parseFloat(timeZone.replace('UTC/GMT ', ''));
      const currentTime = new Date();
      const utcTime = currentTime.getTime() + currentTime.getTimezoneOffset() * 60000;
      const localTime = new Date(utcTime + utcOffset * 3600000);
      return localTime.toLocaleTimeString();
    },
    calculateTimeDifference() {
      if (this.selectedCity1 && this.selectedCity2) {
        const city1 = this.cities.find(city => city.cityId === this.selectedCity1);
        const city2 = this.cities.find(city => city.cityId === this.selectedCity2);

        if (city1 && city2) {
          const utcOffset1 = parseFloat(city1.timeZone.replace('UTC/GMT ', ''));
          const utcOffset2 = parseFloat(city2.timeZone.replace('UTC/GMT ', ''));
          this.timeDifference = Math.abs(utcOffset1 - utcOffset2);
        }
      }
    },
    cityChanged(Id: number, index: number) {
      console.log(this.cities);
      const selectedCity = this.cities.find(
        (item) => item.cityId === Id
      );
      console.log(this.cities);
      if (selectedCity) {
        this.selectedCities[index] = selectedCity;
        this.updateCityTime(index);
      }
    },
  },
});
</script>

<style scoped>
.el-card {
  border-radius: 10px;
}

.clock-wrapper {
  display: flex;
  justify-content: center;
  align-items: center;
  height: 200px;
  width: 220px;
  margin: 20px auto;
}

.clock {
  position: relative;
  width: 100%;
  height: 100%;
  border: 10px solid #333;
  border-radius: 50%;
  background: white;
  box-shadow: 0 0 20px rgba(0, 0, 0, 0.1);
}

.hand {
  position: absolute;
  width: 50%;
  height: 2px;
  background: #333;
  top: 50%;
  transform-origin: 100%;
  transition: all 0.05s ease-in-out;
}

.hour-hand {
  height: 4px;
  background: #333;
}

.minute-hand {
  height: 3px;
  background: #555;
}

.second-hand {
  height: 2px;
  background: red;
}
</style>
