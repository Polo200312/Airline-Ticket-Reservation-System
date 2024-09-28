<template>
  <div class="flights-management">
    <el-row class="chart-row">
      <el-col :span="24">
        <div ref="chart" style="width: 100%; height: 400px; margin-bottom: 20px"></div>
      </el-col>
    </el-row>
    <el-row class="header-row">
      <el-col :span="24">
        <el-input
          v-model="searchQuery"
          placeholder="输入航班名称进行搜索"
          clearable
          @clear="clearSearch()"
          @input="select()"
        >
          <template #prepend>
            <el-icon><Search /></el-icon>
          </template>
          <template #append>
            <el-button type="primary" @click="searchFlights()">搜索</el-button>
          </template>
        </el-input>
      </el-col>
    </el-row>

    <el-table
      :data="getFlights"
      stripe
      style="width: 100%"
      class="className"
      v-loading="loading"
      @row-click="goToFlightDetails"
      :default-sort="{ prop: 'ticketRate', order: 'descending' }"
    >
      <el-table-column prop="ticketRate" label="购票率" width="180" sortable>
        <!-- 使用 v-slot 来定义插槽 -->
        <template v-slot="slotProps">
          <div>
            <span
              v-if="getTicketStatus(slotProps.row).type === 'high'"
              style="color: red"
            >
              🔥🔥🔥 火爆
            </span>
            <span
              v-else-if="getTicketStatus(slotProps.row).type === 'medium'"
              style="color: orange"
            >
              🔥🔥 热门
            </span>
            <span v-else style="color: green"> 🔥 热度上升 </span>
          </div>
        </template>
      </el-table-column>
      <el-table-column prop="planeId" label="航班ID" width="180"></el-table-column>
      <el-table-column prop="planeName" label="航班名称" width="220"></el-table-column>
      <el-table-column
        prop="airlineCompanyName"
        label="航空公司"
        width="220"
      ></el-table-column>
      <el-table-column
        prop="departureAirport"
        label="起飞机场"
        width="220"
      ></el-table-column>
      <el-table-column
        prop="arrivalAirport"
        label="到达机场"
        width="220"
      ></el-table-column>
      <el-table-column prop="startDay" label="起飞日期" width="180"></el-table-column>
      <el-table-column prop="startTime" label="起飞时间" width="180"></el-table-column>
      <el-table-column prop="endDay" label="到达日期" width="180"></el-table-column>
      <el-table-column prop="endTime" label="到达时间" width="180"></el-table-column>
      <el-table-column prop="planeStatus" label="航班状态" width="180"></el-table-column>
      <el-table-column prop="number_all" label="总座位数" width="120"></el-table-column>
      <el-table-column
        prop="number_rest"
        label="剩余座位数"
        width="120"
      ></el-table-column>
    </el-table>

    <el-pagination
      v-if="flights.length > 0"
      background
      layout="prev, pager, next,jumper, ->, total"
      :total="flights.length"
      :page-size="pageSize"
      :current-page="page"
      @current-change="handlePageChange"
      class="pagination"
    ></el-pagination>
  </div>
</template>

<script lang="ts">
import { defineComponent, ref } from "vue";
import * as echarts from 'echarts';
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
  ElTable,
  ElPagination,
  TableColumnCtx,
} from "element-plus";
import {
  type OptionItem,
  type AirlineCompanyItem,
  type PlaneItem,
} from "~/models/general";
import { getAuthHeader } from "~/services/genServ";
import {
  searchForPlaneById,
  getPlaneList,
  getAirlineCompanyIntroduceData,
} from "~/services/infoServ";
import { message } from "~/tools/messageBox";
import 'cropperjs/dist/cropper.css'; // 引入 Cropper.js 的样式文件
import VueCropper from 'cropperjs';
import Cropper from "cropperjs";
import { type SpotItem } from '~/models/general';
import { Search } from "@element-plus/icons-vue";
import debounce from 'lodash/debounce';

export default defineComponent({
  name: "FlightsManagement",
  components: {
    Search,
    ElTable,
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
    ElPagination,
  },
  data: () => ({
    info: {} as AirlineCompanyItem,
    airlineCompanyId: null as number | null,
    page: 1 as number,
    pageSize: 10 as number,
    searchQuery: "" as string,
    loading: false as boolean,
    filteredFlights: [] as PlaneItem[],
    flights: [] as PlaneItem[],
    chart: null as echarts.ECharts | null,  // 新增的chart实例
    previousPlaneNames: [] as string[],
  }),
  created(){
    this.query();
  },
  computed: {
    getFlights() {
      // 根据当前页码和每页显示条数返回当前页的数据
      const start = (this.page - 1) * this.pageSize;
      const end = start + this.pageSize;
      this.flights = this.flights.map(flight => {
        const numberAll = flight.number_all;
        const numberRest = flight.number_rest;
        const ticketRate = 1 - numberRest / numberAll;

        let ticketStatus = {};
        if (ticketRate > 0.9) {
          ticketStatus = { type: 'high', text: '火爆' };
        } else if (ticketRate > 0.6) {
          ticketStatus = { type: 'medium', text: '热门' };
        } else {
          ticketStatus = { type: 'low', text: '热度上升' };
        }

        return {
          ...flight,
          ticketRate: ticketRate * 100, // 购票率百分比
          ticketStatus: ticketStatus,   // 添加购票状态
        };
      });
      //this.updateChart();
      return this.flights.slice(start, end);
    }
  },
  mounted() {
    this.query().then(() => {
      this.initChart();
      this.updateChart(); // 确保在数据加载完成后更新图表
    });
  },
  methods: {
    async query(){
      let res = await getAirlineCompanyIntroduceData(this.airlineCompanyId);
      this.info = res.data.info;
      this.airlineCompanyId = this.info.airlineCompanyId;
      res = await getPlaneList(this.airlineCompanyId);
      this.filteredFlights = res.data;
      this.flights = res.data;
    },
    searchFlights() {
      this.$router.push({ path: '/FlightDetails', query: { planeName: this.searchQuery } });
      this.page = 1;
    },

    sortByTicketRate(a : PlaneItem, b : PlaneItem) {
      const rateA = 1 - a.number_rest / a.number_all;
      const rateB = 1 - b.number_rest / b.number_all;

      return rateB - rateA; // 降序排序
    },

initChart() {
  const chartDom = this.$refs.chart as HTMLElement;
  if (!chartDom) {
    console.error("Chart DOM element not found.");
    return;
  }
  const myChart = echarts.init(chartDom);

  const option = {
    title: {
      text: '航班数据分析',
    },
    tooltip: {
      trigger: 'axis',
      axisPointer: {
        type: 'cross',
      },
    },
    legend: {
      data: ['购票率', '飞行时长'],
    },
    xAxis: [
      {
        type: 'category',
        boundaryGap: true,
        data: [], // 初始化为空，后续通过 updateChart 填充
        axisLabel: {
          formatter: '{value} 航班',
        },
        name: '航班',
        position: 'bottom',
      },
      {
        type: 'category',
        boundaryGap: true,
        data: [], // 初始化为空，后续通过 updateChart 填充
        axisLabel: {
          formatter: '{value} 日期',
        },
        name: '日期',
        position: 'top',
        offset: 0,
      }
    ],
    yAxis: [
      {
        type: 'value',
        name: '购票率(%)',
        position: 'left',
        min: 0,
        max: 100,
      },
      {
        type: 'value',
        name: '飞行时长(分钟)',
        position: 'right',
      }
    ],
    series: [
      {
        name: '购票率',
        type: 'line',
        data: [], // 初始化为空，后续通过 updateChart 填充
        xAxisIndex: 0,
        yAxisIndex: 0,
        animationDuration: 800,  // 动画持续时间
        animationEasing: 'cubicOut', // 动画缓动函数
      },
      {
        name: '飞行时长',
        type: 'line',
        data: [], // 初始化为空，后续通过 updateChart 填充
        xAxisIndex: 1,
        yAxisIndex: 1,
        animationDuration: 800,
        animationEasing: 'cubicOut',
      },
    ],
    dataZoom: [
      {
        type: 'inside',
        xAxisIndex: [0, 1]
      },
      {
        type: 'slider',
        xAxisIndex: [0, 1]
      }
    ],
  };

  myChart.setOption(option);

  this.chart = myChart;

  this.updateChart();
},

calculateFlightDuration(flight: PlaneItem): number {
  // 计算单个航班的飞行时长（以分钟为单位）
  const startDateTime = new Date(`${flight.startDay}T${flight.startTime}`);
  const endDateTime = new Date(`${flight.endDay}T${flight.endTime}`);

  // 处理跨天情况
  if (endDateTime < startDateTime) {
    endDateTime.setDate(endDateTime.getDate() + 1);
  }

  const durationInMinutes = (endDateTime.getTime() - startDateTime.getTime()) / (1000 * 60);

  return durationInMinutes > 0 ? durationInMinutes : 0; // 确保返回的时长非负
},
updateChart() {
  if (!this.chart) {
    console.error('Chart instance is not initialized!');
    return;
  }

  const start = (this.page - 1) * this.pageSize;
  const end = start + this.pageSize;
  const Flight = this.flights.slice(start, end) as PlaneItem[];

  const planeNames = Flight.map(flight => flight.planeName);
  const ticketRates = Flight.map(flight => (1 - flight.number_rest / flight.number_all) * 100);

  const flightDurations: { [key: string]: number } = {};

  this.filteredFlights.forEach(flight => {
    const flightDate = new Date(flight.startDay);
    const dateKey = flightDate.toISOString().split('T')[0];
    const duration = this.calculateFlightDuration(flight);

    if (flightDurations[dateKey]) {
      flightDurations[dateKey] += duration;
    } else {
      flightDurations[dateKey] = duration;
    }
  });

  const dateKeys = Object.keys(flightDurations).sort();
  const flightDurationValues = dateKeys.map(key => flightDurations[key]);

  if (JSON.stringify(this.previousPlaneNames) !== JSON.stringify(planeNames)) {
    this.previousPlaneNames = planeNames;
    this.chart.setOption({
      xAxis: [
        {
          data: planeNames,
          boundaryGap: planeNames.length > 1 ? false : true,
        },
        {
          data: dateKeys,
        }
      ],
      series: [
        {
          name: '购票率',
          data: ticketRates,
          xAxisIndex: 0,
          yAxisIndex: 0,
        },
        {
          name: '飞行时长',
          data: flightDurationValues,
          xAxisIndex: 1,
          yAxisIndex: 1,
        },
      ],
    }, {
      notMerge: false,   // 允许合并更新
      lazyUpdate: true,  // 延迟更新，提高性能
    });
  } else {
    this.chart.setOption({
      series: [
        {
          name: '购票率',
          data: ticketRates,
        },
        {
          name: '飞行时长',
          data: flightDurationValues,
        },
      ],
    }, {
      notMerge: false,
      lazyUpdate: true,
    });
  }
},

    select(){
      this.flights = this.searchQuery
        ? this.filteredFlights.filter(flight =>
            flight.planeName.includes(this.searchQuery) || flight.startCity.includes(this.searchQuery) || flight.endCity.includes(this.searchQuery) || flight.startDay.includes(this.searchQuery) || flight.endDay.includes(this.searchQuery)
          )
        : this.filteredFlights;
      this.updateChart();
    },

    clearSearch() {
      this.searchQuery = "";
      this.flights = this.filteredFlights;
      this.updateChart(); // 清除搜索后更新图表
    },

    goToFlightDetails(flight: PlaneItem) {
      this.$router.push({ path: '/FlightDetails', query: { planeName: flight.planeName } });
    },

    getTicketStatus(flight : PlaneItem) {
      const numberAll = flight.number_all;
      const numberRest = flight.number_rest;
      const ticketRate = 1 - numberRest / numberAll;

      if (ticketRate > 0.9) {
        return { type: 'high', text: '火爆' };
      } else if (ticketRate > 0.6) {
        return { type: 'medium', text: '热门' };
      } else {
        return { type: 'low', text: '热度上升' };
      }
    },

    handlePageChange(page: number) {
      // 分页逻辑
      this.page = page;
      console.log("当前页:", page);
      this.updateChart(); // 分页更改后更新图表
    },
  },
});
</script>

<style scoped>
.flights-management {
  margin-top: 20px;
  padding: 20px;
  background-color: #f9fafc;
  min-height: 100vh;
}

.chart-row {
  margin-bottom: 20px;
}

.header-row {
  margin-bottom: 20px;
  display: flex;
  justify-content: center;
}

.el-input {
  width: 100%;
  max-width: 600px;
}

.el-input .el-icon {
  color: #909399;
}

.el-table {
  background-color: #ffffff;
  border-radius: 8px;
  box-shadow: 0 2px 12px rgba(0, 0, 0, 0.1);
}

.el-table th {
  background-color: #f2f6fc;
  color: #333;
  font-weight: 600;
  text-align: center;
  padding: 12px 8px;
}

.el-table td {
  text-align: center;
  padding: 12px 8px;
  color: #606266;
  font-weight: 500;
}

.el-pagination {
  margin-top: 20px;
  text-align: center;
}

.el-pagination::v-deep .el-pager li {
  margin: 0 4px;
}

.el-pagination .el-pager li.active {
  background-color: #409eff;
  border-color: #409eff;
  color: #ffffff;
}

.el-pagination .el-pager li:hover {
  background-color: #66b1ff;
  border-color: #66b1ff;
}

.el-pagination .el-pager li {
  border-radius: 4px;
  padding: 0 12px;
}

.el-pagination::v-deep .el-pagination__button {
  color: #409eff;
}

.el-pagination::v-deep .el-pagination__button:hover {
  color: #66b1ff;
}

.className :empty::before {
  content: "--（暂无记录）--";
  color: gray;
}
</style>
