<template>
  <div class="users-management">
    <el-row class="header-row">
      <el-col :span="24">
        <el-input
          v-model="searchQuery"
          placeholder="输入景点ID进行搜索"
          clearable
          @clear="clearSearch()"
          @input="select()"
        >
          <template #prepend>
            <el-icon><Search /></el-icon>
          </template>
          <template #append>
            <el-button type="primary" @click="searchSpot()">搜索</el-button>
          </template>
        </el-input>
        <el-button
          class="add-button"
          type="primary"
          size="default"
          @click="addSpot"
          style="
            margin: 10px, 10px, 10px, 10px;
            background-color: rgb(17, 107, 196);
            padding: 10px;
          "
        >
          <el-icon><CirclePlus /></el-icon>新增景点
        </el-button>
      </el-col>
    </el-row>

    <el-table
      :data="getSpots"
      style="width: 100%"
      class="className"
      stripe
      v-loading="loading"
      @row-click="goToSpotDetails"
    >
      <el-table-column prop="spotId" label="景点ID" width="180"></el-table-column>
      <el-table-column prop="name" label="景点名称" width="220"></el-table-column>
      <el-table-column prop="cityName" label="所在城市" width="220"></el-table-column>
      <el-table-column prop="category" label="景点类型" width="220"></el-table-column>
      <el-table-column prop="rating" label="星级" width="180"></el-table-column>
      <el-table-column prop="location" label="位置" width="180"></el-table-column>
      <el-table-column prop="openingHours" label="开放时间" width="180"></el-table-column>
      <el-table-column
        prop="ticketPrice"
        label="票价（￥/位）"
        width="180"
      ></el-table-column>
      <el-table-column prop="description" label="景点描述" width="360"></el-table-column>
    </el-table>

    <el-pagination
      v-if="tempSpots.length > 0"
      background
      layout="prev, pager, next, jumper, ->, total"
      :total="tempSpots.length"
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
  type SpotItem,
} from "~/models/general";
import { getAuthHeader } from "~/services/genServ";
import {
  getAllSpotList,
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
    tempSpots: [] as SpotItem[],
    spots: [] as SpotItem[],
  }),
  created(){
    this.query();
  },
  computed: {
    getSpots() {
      // 根据当前页码和每页显示条数返回当前页的数据
      const start = (this.page - 1) * this.pageSize;
      const end = start + this.pageSize;
      return this.tempSpots.slice(start, end);
    }
  },
  methods: {
    async query(){
      let res = await getAllSpotList();
      this.tempSpots = res.data;
      this.spots = res.data;
    },

    searchSpot() {
      this.$router.push({ path: '/SpotDetails', query: { spotId: this.searchQuery } });
      this.page = 1;
    },

    addSpot(){
      this.$router.push({ path: '/AddSpot'});
    },

    select(){
      this.tempSpots = this.searchQuery
        ? this.spots.filter(spot =>
            spot.name.includes(this.searchQuery) || spot.spotId.toString().includes(this.searchQuery)
          )
        : this.spots;
    },

    clearSearch() {
      this.searchQuery = "";
      this.tempSpots= this.spots;
    },

    goToSpotDetails(spot: SpotItem) {
      this.$router.push({ path: '/SpotDetails', query: { spotId: spot.spotId } });
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
