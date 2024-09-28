<template>
  <div style="margin-top: 20px">
    <el-card class="booking-card">
      <div slot="header" class="clearfix">
        <span id="title"
          ><el-icon><promotion /></el-icon>飞机票预订</span
        >
      </div>

      <!-- 出发国家选择 -->
      <div class="country-selection">
        <el-select
          v-model="departureNationId"
          filterable
          placeholder="请选择出发国家"
          @change="fetchCitys(1)"
        >
          <el-option
            v-for="country in nationList"
            :key="country.nationId"
            :label="country.nationName"
            :value="country.nationId"
          >
            <div style="display: flex; align-items: center">
              <el-image
                style="
                  width: 30px;
                  height: 30px;
                  margin-right: 20px;
                  border-radius: 100px;
                "
                :src="'/' + country.nationName + '.jpg'"
                fit="fill"
              ></el-image>
              <div>{{ country.nationName }}</div>
            </div>
          </el-option>
        </el-select>
      </div>

      <!-- 目的地国家选择 -->
      <div
        class="country-selection"
        v-if="departureNationId && departureNationId !== '请选择出发国家'"
      >
        <el-select
          v-model="destinationNationId"
          placeholder="请选择目的地国家"
          filterable
          @change="fetchCitys(2)"
        >
          <el-option
            v-for="country in nationList"
            :key="country.nationId"
            :label="country.nationName"
            :value="country.nationId"
          >
            <div style="display: flex; align-items: center">
              <el-image
                style="
                  width: 30px;
                  height: 30px;
                  margin-right: 20px;
                  border-radius: 100px;
                "
                :src="'/' + country.nationName + '.jpg'"
                fit="fill"
              ></el-image>
              <div>{{ country.nationName }}</div>
            </div>
          </el-option>
        </el-select>
      </div>

      <!-- 出发城市和目的地城市选择 -->
      <el-card
        class="city-selection-card"
        v-if="
          departureNationId !== 0 &&
          destinationNationId !== 0 &&
          departureNationId !== '请选择出发国家' &&
          destinationNationId !== '请选择目的地国家'
        "
      >
        <el-row :gutter="20">
          <el-col :span="10">
            <div class="city-selection">
              <el-select
                v-model="selectedCity1Id"
                placeholder="请选择出发城市"
                filterable
                @change="fetchAirports(1)"
              >
                <el-option
                  v-for="city in cityList1"
                  :key="city.cityId"
                  :label="city.cityName"
                  :value="city.cityId"
                >
                </el-option>
              </el-select>
            </div>
          </el-col>
          <el-col :span="4" class="arrow-icon">
            <i class="el-icon-arrow-right">→→→</i>
          </el-col>
          <el-col :span="10">
            <div class="city-selection">
              <el-select
                v-model="selectedCity2Id"
                placeholder="请选择目的地城市"
                filterable
                @change="fetchAirports(2)"
              >
                <el-option
                  v-for="city in cityList2"
                  :key="city.cityId"
                  :label="city.cityName"
                  :value="city.cityId"
                >
                </el-option>
              </el-select>
            </div>
          </el-col>
        </el-row>

        <!-- 出发和到达机场选择 -->
        <el-row
          v-if="
            departureNationId !== 0 &&
            destinationNationId !== 0 &&
            selectedCity1Id !== 0 &&
            selectedCity1Id !== 0 &&
            departureNationId !== '请选择出发国家' &&
            destinationNationId !== '请选择目的地国家' &&
            selectedCity1Id !== '请选择出发城市' &&
            selectedCity1Id !== '请选择目的地城市'
          "
          :gutter="20"
        >
          <el-col :span="10">
            <div class="airport-selection">
              <el-select
                v-model="departureAirport"
                filterable
                placeholder="请选择出发机场"
              >
                <el-option
                  v-for="airport in airports1"
                  :key="airport.airportId"
                  :label="airport.airportName"
                  :value="airport.airportName"
                >
                </el-option>
              </el-select>
            </div>
          </el-col>
          <el-col :span="4"></el-col>
          <el-col :span="10">
            <div class="airport-selection">
              <el-select v-model="arrivalAirport" filterable placeholder="请选择到达机场">
                <el-option
                  v-for="airport in airports2"
                  :key="airport.airportId"
                  :label="airport.airportName"
                  :value="airport.airportName"
                >
                </el-option>
              </el-select>
            </div>
          </el-col>
        </el-row>
        <el-row v-else>
          <el-col :span="24" class="no-selection">
            （<el-icon><warning /></el-icon>请完善相关信息以选择机场）
          </el-col>
        </el-row>
      </el-card>

      <!-- 出发日期选择 -->
      <el-card class="date-selection-card">
        <div class="date-selection">
          <el-date-picker
            v-model="selectedDate"
            type="date"
            placeholder="请选择出发日期"
            :picker-options="pickerOptions"
            :disabled-date="disabledDate"
          >
          </el-date-picker>
        </div>
      </el-card>

      <!-- 筛选条件 -->
      <el-card class="filter-card">
        <el-form ref="filterForm" label-width="120px">
          <el-form-item label="航空公司名" prop="airlineCompanyName">
            <el-input
              v-model="airlineCompanyName"
              placeholder="请输入航空公司名"
            ></el-input>
          </el-form-item>
          <el-form-item label="是否直飞" prop="directFlight">
            <el-radio-group v-model="directFlight">
              <el-radio label="true">是</el-radio>
              <el-radio label="false">否</el-radio>
            </el-radio-group>
          </el-form-item>
          <el-form-item
            label="指定中转机场"
            prop="viaAirport"
            v-if="!directFlight || directFlight === 'false'"
          >
            <el-input v-model="viaAirport" placeholder="请输入中转机场"></el-input>
          </el-form-item>
          <el-form-item label="查询类型" prop="searchType">
            <el-select v-model="searchType" placeholder="请选择查询类型">
              <el-option
                v-for="option in filteredOptions"
                :key="option.value"
                :label="option.label"
                :value="option.value"
              ></el-option>
            </el-select>
          </el-form-item>
          <el-form-item label="购票数" prop="tNumber">
            <el-input v-model="tNumber" placeholder="请输入购票数"></el-input>
          </el-form-item>
        </el-form>
      </el-card>

      <!-- 查询按钮 -->
      <div class="button-container">
        <el-button id="search-button" type="primary" @click="searchFlights()"
          ><el-icon><search /></el-icon>查询</el-button
        >
      </div>
    </el-card>
  </div>
</template>

<script lang="ts">
import { defineComponent, ref } from "vue";
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
} from "element-plus";
import {
  type OptionItem,
  type AirportItem,
  type CityItem,
  type NationItem,
} from "~/models/general";
import { getAuthHeader } from "~/services/genServ";
import {
  searchForPlaneById,
  getCityListByNationId,
  getAirportListByCityId,
  reBook,
  getAllNationList,
  getTravelOptions,
} from "~/services/infoServ";
import { message } from "~/tools/messageBox";
import 'cropperjs/dist/cropper.css'; // 引入 Cropper.js 的样式文件
import VueCropper from 'cropperjs';
import Cropper from "cropperjs";
import { type SpotItem } from '~/models/general';
import {Promotion, Search, Warning} from '@element-plus/icons-vue'

export default defineComponent({
  components: {
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
    Promotion,
    Search,
    Warning,
  },
  data: () => ({
    cityList1: [] as CityItem[],
    cityList2: [] as CityItem[],
    airports1: [] as AirportItem[],
    airports2: [] as AirportItem[],
    nationList: [] as NationItem[],
    departureNationId: "请选择出发国家" as number | string,
    destinationNationId: "请选择目的地国家" as number | string,
    selectedCity1Id: "请选择出发城市" as number | string,
    selectedCity2Id: "请选择目的地城市" as number | string,
    selectedAirport1Id: "请选择起飞机场" as number | string,
    selectedAirport2Id: "请选择到达机场" as number | string,
    tNumber: 1 as number,
    selectedDate: '',
    pickerOptions: {
      shortcuts: [
        {
          text: "今天",
          onClick(picker: { $emit: Function }) {
            picker.$emit("pick", new Date());
          },
        },
        {
          text: "明天",
          onClick(picker: { $emit: Function }) {
            const date = new Date();
            date.setTime(date.getTime() + 3600 * 1000 * 24);
            picker.$emit("pick", date);
          },
        },
        {
          text: "后天",
          onClick(picker: { $emit: Function }) {
            const date = new Date();
            date.setTime(date.getTime() + 3600 * 1000 * 24 * 2);
            picker.$emit("pick", date);
          },
        },
        {
          text: "三天后",
          onClick(picker: { $emit: Function }) {
            const date = new Date();
            date.setTime(date.getTime() + 3600 * 1000 * 24 * 3);
            picker.$emit("pick", date);
          },
        },
        {
          text: "四天后",
          onClick(picker: { $emit: Function }) {
            const date = new Date();
            date.setTime(date.getTime() + 3600 * 1000 * 24 * 4);
            picker.$emit("pick", date);
          },
        },
        {
          text: "五天后",
          onClick(picker: { $emit: Function }) {
            const date = new Date();
            date.setTime(date.getTime() + 3600 * 1000 * 24 * 5);
            picker.$emit("pick", date);
          },
        },
      ],
    },
    options: [         // 所有可选的查询类型
      { label: '航程最短', value: '航程最短' },
      { label: '价格最低', value: '价格最低' }
    ],
    optionsDirect: [         // 所有可选的查询类型
      { label: '直飞', value: '直飞' },
      { label: '价格最低', value: '价格最低' }
    ],
    departureAirport: "" as string,
    arrivalAirport: "" as string,
    airlineCompanyName: null as string | null,
    viaAirport: null as string | null,
    directFlight: "true" as boolean | string,
    searchType: "" as string,
  }),
  async created(){
    let res = await getAllNationList();
    this.nationList = res.data;
  },
  computed: {
    filteredOptions() {
      if (this.directFlight === true || this.directFlight === "true" ) {
        // 如果选择了直飞，不显示航程最短选项
        return this.optionsDirect;
      } else {
        // 否则显示所有选项
        return this.options;
      }
    },
  },
  methods: {
    async fetchCitys(type: number) {
      if (type === 1 && this.departureNationId) {
        this.selectedCity1Id = "请选择出发城市";
        this.departureAirport = "";
        this.cityList1 = [];
        this.airports1 = [];
        // 根据选中的出发城市查询机场列表
        if(typeof this.departureNationId === 'number') {
          let res = await getCityListByNationId(this.departureNationId);
          this.cityList1 = res.data;
        }
      } else if (type === 2 && this.destinationNationId) {
        this.selectedCity2Id = "请选择出发城市";
        this.arrivalAirport = "";
        this.cityList2 = [];
        this.airports2 = [];
        // 根据选中的目的地城市查询机场列表
        if(typeof this.destinationNationId === 'number') {
          let res = await getCityListByNationId(this.destinationNationId);
          this.cityList2 = res.data;
        }
      } else {
        this.cityList1 = [];
        this.cityList2 = [];
      }
    },
    async fetchAirports(type: number) {
      if (type === 1 && this.selectedCity1Id) {
        this.departureAirport = "";
        this.airports1 = [];
        // 根据选中的出发城市查询机场列表
        if(typeof this.selectedCity1Id === 'number') {
          let res = await getAirportListByCityId(this.selectedCity1Id);
          this.airports1 = res.data;
        }
      } else if (type === 2 && this.selectedCity2Id) {
        this.arrivalAirport = "";
        this.airports2 = [];
        // 根据选中的目的地城市查询机场列表
        if(typeof this.selectedCity2Id === 'number') {
          let res = await getAirportListByCityId(this.selectedCity2Id);
          this.airports2 = res.data;
        }
      } else {
        this.airports1 = [];
        this.airports2 = [];
      }
    },
    disabledDate(time: Date) {
      return time.getTime() < Date.now() - 8.64e7 || time.getTime() > Date.now() + 24 * 60 * 60 * 1000 * 30;
    },
    searchFlights() {
      // 转到查询航班页面
      if (this.departureAirport == "" || this.departureAirport == undefined) {
        message(this, "出发机场为空,请填写！");
        return;
      }
      if (this.arrivalAirport == "" || this.arrivalAirport == undefined) {
        message(this, "到达机场为空,请填写！");
        return;
      }
      if (this.selectedDate == "" || this.selectedDate == undefined) {
        message(this, "日期为空,请填写！");
        return;
      }
      if (this.departureAirport === this.arrivalAirport) {
        message(this, "起降机场不能相同！");
        return;
      }
      if (this.tNumber < 1) {
        message(this, "购票数不应小于1张！");
        return;
      }
        // 将选中的日期字符串转换为日期对象
      const dateObj = new Date(this.selectedDate);

      // 格式化选中的日期为 yyyy-MM-dd 格式
      const formattedDate = this.formatDate(dateObj);
      console.log(formattedDate);
      this.$router.push({ path: '/SearchPlane', query: {
        selectedCity1Id: this.selectedCity1Id,
        selectedCity2Id: this.selectedCity2Id,
        departureAirport: this.departureAirport,
        arrivalAirport: this.arrivalAirport,
        startDateString: formattedDate,
        airlineCompanyName: this.airlineCompanyName,
        viaAirport: this.viaAirport,
        directFlight: this.directFlight.toString(),
        searchType: this.searchType,
        tNumber: this.tNumber,
       }
      });

      console.log("执行查询航班的逻辑");
    },
    formatDate(date: Date) {
      if (!(date instanceof Date)) return '';
      const year = date.getFullYear();
      let month = '' + (date.getMonth() + 1);
      let day = '' + date.getDate();
      if (month.length < 2) month = '0' + month;
      if (day.length < 2) day = '0' + day;
      return [year, month, day].join('-');
    },
  },
});
</script>

<style scoped>
.booking-card {
  width: 100%;
  max-width: 600px;
  margin: auto;
  padding: 20px;
  box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
  border-radius: 8px;
}

.country-selection,
.city-selection,
.airport-selection,
.date-selection {
  margin-bottom: 20px;
}

#flight-booking-card {
  margin: 20px;
}

.city-selection-card {
  margin-bottom: 20px;
}

.city-selection {
  width: 100%;
}

.arrow-icon {
  display: flex;
  align-items: center;
  justify-content: center;
  height: 100%;
}

.arrow-icon i {
  font-size: 24px; /* 调整箭头图标的大小 */
  color: #ee0606; /* 箭头图标的颜色 */
}

.airport-selection {
  width: 100%;
}

.date-selection-card {
  margin-bottom: 20px;
}

.date-selection {
  width: 100%;
}

.filter-card {
  margin-bottom: 20px;
}

.button-container {
  display: flex;
  justify-content: center;
  margin-bottom: 20px;
}

.no-selection {
  text-align: center;
  color: #f00; /* 红色字体 */
}
</style>
