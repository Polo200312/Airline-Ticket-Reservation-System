<template>
  <div class="users-management">
    <el-row class="header-row">
      <el-col :span="24">
        <el-input
          v-model="searchQuery"
          placeholder="输入用户ID进行搜索"
          clearable
          @clear="clearSearch()"
          @input="select()"
        >
          <template #prepend>
            <el-icon><Search /></el-icon>
          </template>
          <template #append>
            <el-button type="primary" @click="searchClient()">搜索</el-button>
          </template>
        </el-input>
      </el-col>
    </el-row>

    <el-table
      :data="getClients"
      style="width: 100%"
      class="className"
      stripe
      v-loading="loading"
      @row-click="goToClientDetails"
    >
      <el-table-column prop="clientId" label="用户ID" width="180"></el-table-column>
      <el-table-column prop="name" label="用户名" width="220"></el-table-column>
      <el-table-column prop="num" label="用户账号" width="220"></el-table-column>
      <el-table-column prop="gender" label="性别" width="120"></el-table-column>
      <el-table-column prop="email" label="电子邮箱" width="300"></el-table-column>
      <el-table-column prop="phone" label="电话" width="200"></el-table-column>
      <el-table-column prop="realName" label="真实姓名" width="220"></el-table-column>
      <el-table-column prop="idNumber" label="身份证号" width="300"></el-table-column>
      <el-table-column
        prop="amountOfMoney"
        label="账户余额（￥）"
        width="150"
      ></el-table-column>
    </el-table>

    <el-pagination
      v-if="tempClients.length > 0"
      background
      layout="prev, pager, next, jumper, ->, total"
      :total="tempClients.length"
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
  type ClientItem,
} from "~/models/general";
import { getAuthHeader } from "~/services/genServ";
import {
  getClientList,

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
import {Search,Setting, Postcard, ChatDotSquare, Stopwatch, Ticket, Upload, Edit, UploadFilled, Mouse, Finished, RefreshLeft, Bell, Folder, UserFilled, User, Wallet, Sort, Message, Phone, BellFilled, Opportunity, CreditCard} from '@element-plus/icons-vue'

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
  },
  data: () => ({
    page: 1 as number,
    pageSize: 10 as number,
    searchQuery: "" as string,
    loading: false as boolean,
    tempClients: [] as ClientItem[],
    clients: [] as ClientItem[],
  }),
  created(){
    this.query();
  },
  computed: {
    getClients() {
      // 根据当前页码和每页显示条数返回当前页的数据
      const start = (this.page - 1) * this.pageSize;
      const end = start + this.pageSize;
      return this.tempClients.slice(start, end);
    }
  },
  methods: {
    async query(){
      let res = await getClientList();
      this.tempClients = res.data.map((client: ClientItem) => {
        return {
            ...client,
            phone: this.maskedPhone(client.phone),
            idNumber: this.maskedIdNumber(client.idNumber),
        };
      });
      this.clients = res.data.map((client: ClientItem) => {
        return {
            ...client,
            phone: this.maskedPhone(client.phone),
            idNumber: this.maskedIdNumber(client.idNumber),
        };
      });
    },

    maskedPhone(phone: string): string {
        if (phone && phone.length > 7) {
            const start = phone.substring(0, 3);
            const end = phone.substring(phone.length - 4);
            const middle = '*'.repeat(phone.length - 7);
            return start + middle + end;
        } else {
            return phone;
        }
    },

    maskedIdNumber(idNumber: string): string {
        if (idNumber && idNumber.length > 7) {
            const start = idNumber.substring(0, 3);
            const end = idNumber.substring(idNumber.length - 4);
            const middle = '*'.repeat(idNumber.length - 7);
        return start + middle + end;
        } else {
            return idNumber;
        }
    },

    searchClient() {
      this.$router.push({ path: '/ClientDetails', query: { clientId: this.searchQuery } });
      this.page = 1;
    },

    select(){
      this.tempClients = this.searchQuery
        ? this.clients.filter(client =>
            client.name.includes(this.searchQuery) || client.clientId.toString().includes(this.searchQuery)
          )
        : this.clients;
    },

    clearSearch() {
      this.searchQuery = "";
      this.tempClients = this.clients;
    },

    goToClientDetails(client: ClientItem) {
      this.$router.push({ path: '/ClientDetails', query: { clientId: client.clientId } });
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
