<template>
  <div class="users-management">
    <el-row class="header-row">
      <el-col :span="24">
        <el-input
          v-model="searchQuery"
          placeholder="输入机场ID进行搜索"
          clearable
          @clear="clearSearch()"
          @input="select()"
        >
          <template #prepend>
            <el-icon><Search /></el-icon>
          </template>
          <template #append>
            <el-button type="primary" @click="searchNation()">搜索</el-button>
          </template>
        </el-input>
        <el-button
          class="add-button"
          type="primary"
          size="default"
          @click="addCity"
          style="
            margin: 10px, 10px, 10px, 10px;
            background-color: rgb(17, 107, 196);
            padding: 10px;
          "
        >
          <el-icon><CirclePlus /></el-icon>新增机场
        </el-button>
      </el-col>
    </el-row>

    <el-table
      :data="getAirports"
      style="width: 100%"
      class="className"
      stripe
      v-loading="loading"
      @row-click="goToAirportDetails"
    >
      <el-table-column prop="airportId" label="机场ID" width="180"></el-table-column>
      <el-table-column prop="airportName" label="机场名称" width="220"></el-table-column>
      <el-table-column prop="cityName" label="所属城市" width="220"></el-table-column>
      <el-table-column prop="airportX" label="纬度" width="180"></el-table-column>
      <el-table-column prop="airportY" label="经度" width="180"></el-table-column>
      <el-table-column prop="status" label="机场状态" width="180"></el-table-column>
      <el-table-column
        prop="airportIntroduction"
        label="机场简介"
        width="360"
      ></el-table-column>
    </el-table>

    <el-pagination
      v-if="tempAirports.length > 0"
      background
      layout="prev, pager, next, jumper, ->, total"
      :total="tempAirports.length"
      :page-size="pageSize"
      :current-page="page"
      @current-change="handlePageChange"
      class="pagination"
    ></el-pagination>
  </div>
</template>

<script lang="ts">
import { defineComponent } from "vue";
import {
  type OptionItem,
  type AirportItem,
} from "~/models/general";
import { getAuthHeader } from "~/services/genServ";
import {
  getAllAirportList,
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
  ElImage,
  ElTable,
  ElPagination,
} from "element-plus";
import { Search, CirclePlus } from '@element-plus/icons-vue'

export default defineComponent({
  name: "UsersManagement",
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
    CirclePlus,
  },
  data: () => ({
    page: 1 as number,
    pageSize: 10 as number,
    searchQuery: "" as string,
    loading: false as boolean,
    tempAirports: [] as AirportItem[],
    airports: [] as AirportItem[],
  }),
  created(){
    this.query();
  },
  computed: {
    getAirports() {
      // 根据当前页码和每页显示条数返回当前页的数据
      const start = (this.page - 1) * this.pageSize;
      const end = start + this.pageSize;
      return this.tempAirports.slice(start, end);
    }
  },
  methods: {
    async query(){
      let res = await getAllAirportList();
      this.tempAirports = res.data;
      this.airports = res.data;
    },

    searchNation() {
      this.$router.push({ path: '/AirportDetails', query: { airportId: this.searchQuery } });
      this.page = 1;
    },

    addCity(){
      this.$router.push({ path: '/AddAirport'});
    },

    select(){
      this.tempAirports = this.searchQuery
        ? this.airports.filter(airport =>
            airport.airportName.includes(this.searchQuery) || airport.airportId.toString().includes(this.searchQuery)
          )
        : this.airports;
    },

    clearSearch() {
      this.searchQuery = "";
      this.tempAirports= this.airports;
    },

    goToAirportDetails(airport: AirportItem) {
      this.$router.push({ path: '/AirportDetails', query: { airportId: airport.airportId } });
    },

    handlePageChange(page: number) {
      // 分页逻辑
      this.page = page;
      console.log("当前页:", page);
    },
  },
});
</script>

<style scoped>
.users-management {
  margin-top: 10px;
  padding: 20px;
  background-color: #f9fafc;
  min-height: 100vh;
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
