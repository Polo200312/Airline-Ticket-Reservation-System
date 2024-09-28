<template>
  <div class="users-management">
    <el-row class="header-row">
      <el-col :span="24">
        <el-input
          v-model="searchQuery"
          placeholder="输入城市ID进行搜索"
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
          <el-icon><CirclePlus /></el-icon>新增城市
        </el-button>
      </el-col>
    </el-row>

    <el-table
      :data="getCitys"
      style="width: 100%"
      class="className"
      v-loading="loading"
      @row-click="goToCityDetails"
    >
      <el-table-column prop="cityId" label="城市ID" width="180"></el-table-column>
      <el-table-column prop="cityName" label="城市名称" width="220"></el-table-column>
      <el-table-column prop="nationName" label="所属国家" width="220"></el-table-column>
      <el-table-column prop="timeZone" label="时区" width="220"></el-table-column>
      <el-table-column prop="cityX" label="纬度" width="180"></el-table-column>
      <el-table-column prop="cityY" label="经度" width="180"></el-table-column>
      <el-table-column prop="searchTimes" label="搜索次数" width="180"></el-table-column>
    </el-table>

    <el-pagination
      v-if="tempCitys.length > 0"
      background
      layout="prev, pager, next, jumper, ->, total"
      :total="tempCitys.length"
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
  type CityItem,
} from "~/models/general";
import { getAuthHeader } from "~/services/genServ";
import {
  getAllCityList,
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
    tempCitys: [] as CityItem[],
    citys: [] as CityItem[],
  }),
  created(){
    this.query();
  },
  computed: {
    getCitys() {
      // 根据当前页码和每页显示条数返回当前页的数据
      const start = (this.page - 1) * this.pageSize;
      const end = start + this.pageSize;
      return this.tempCitys.slice(start, end);
    }
  },
  methods: {
    async query(){
      let res = await getAllCityList();
      this.tempCitys = res.data;
      this.citys = res.data;
    },

    searchNation() {
      this.$router.push({ path: '/CityDetails', query: { cityId: this.searchQuery } });
      this.page = 1;
    },

    addCity(){
      this.$router.push({ path: '/AddCity'});
    },

    select(){
      console.log(this.searchQuery);
      this.tempCitys = this.searchQuery
        ? this.citys.filter(city =>
            city.cityName.includes(this.searchQuery) || city.cityId.toString().includes(this.searchQuery)
          )
        : this.citys;
    },

    clearSearch() {
      this.searchQuery = "";
      this.tempCitys= this.citys;
    },

    goToCityDetails(city: CityItem) {
      this.$router.push({ path: '/CityDetails', query: { cityId: city.cityId } });
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
