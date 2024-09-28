<template>
  <div class="user-details">
    <el-card class="box-card">
      <div slot="header" class="header-section clearfix">
        <span class="header-title"
          ><el-icon><View /></el-icon>{{ info.name }} - 详情</span
        >
        <div class="button-group">
          <el-button
            class="edit-button"
            type="primary"
            size="default"
            @click="editClient"
          >
            <el-icon><edit-pen /></el-icon>编辑用户信息
          </el-button>
          <el-button
            class="delete-button"
            type="warning"
            size="default"
            @click="deleteClient"
          >
            <el-icon><circle-close /></el-icon>删除用户
          </el-button>
          <el-button class="back-button" @click="back"
            ><el-icon><refresh-left /></el-icon>返回</el-button
          >
        </div>
      </div>
      <div>
        <el-form label-width="120px" class="flight-info-form">
          <el-form-item label="用户ID">
            <span>{{ info.clientId }}</span>
          </el-form-item>
          <el-form-item label="用户名">
            <span>{{ info.name }}</span>
          </el-form-item>
          <el-form-item label="用户账号">
            <span>{{ info.num }}</span>
          </el-form-item>
          <el-form-item label="性别">
            <span>{{ info.gender }}</span>
          </el-form-item>
          <el-form-item label="电话号码">
            <span>{{ info.phone }}</span>
          </el-form-item>
          <el-form-item label="电子邮箱">
            <span>{{ info.email }}</span>
          </el-form-item>
          <el-form-item label="真实姓名">
            <span>{{ info.realName }}</span>
          </el-form-item>
          <el-form-item label="身份证号">
            <span>{{ info.idNumber }}</span>
          </el-form-item>
          <el-form-item label="账户余额（￥）">
            <span>{{ info.amountOfMoney }}</span>
          </el-form-item>
        </el-form>
      </div>
    </el-card>
  </div>
</template>

<script lang="ts">
import { defineComponent } from "vue";
import {
  ElSelect,
  ElButton,
  ElForm,
  ElFormItem,
  ElInput,
  ElCard,
  ElRow,
  ElCol,
  ElImage,
  ElTable,
} from "element-plus";
import {
  type OptionItem,
  type ClientItem,
} from "~/models/general";
import { getAuthHeader } from "~/services/genServ";
import {
  getClientInfo,
  clientDelete,
  getClientIntroduceData,
} from "~/services/infoServ";
import { message } from "~/tools/messageBox";
import 'cropperjs/dist/cropper.css'; // 引入 Cropper.js 的样式文件
import VueCropper from 'cropperjs';
import Cropper from "cropperjs";
import {View, EditPen, CircleClose, RefreshLeft,} from '@element-plus/icons-vue'

export default defineComponent({
  name: "FlightDetails",
  components: {
    ElTable,
    ElImage,
    ElSelect,
    ElButton,
    ElForm,
    ElFormItem,
    ElInput,
    ElCard,
    ElRow,
    ElCol,
    View,
    EditPen,
    CircleClose,
    RefreshLeft,
  },
  data: () => ({
    info: {} as ClientItem,
    clientId: null as number | null,
  }),
  created() {
    this.query();
  },
  methods: {
    async query() {
      const clientIdStr = this.$route.query.clientId as string;
      this.clientId = Number(clientIdStr);
      let res = await getClientInfo(this.clientId);
      this.info = res.data.info;
      this.info.phone = this.maskedPhone(this.info.phone);
      this.info.idNumber = this.maskedIdNumber(this.info.idNumber);
      console.log(this.info);
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
    editClient() {
      this.$router.push({ path: '/EditClient', query: { clientId: this.info.clientId, clientName: this.info.name } });
    },
    async deleteClient() {
        let res = await clientDelete(this.clientId);
        if (res.code != 0) {
        message(this, res.msg);
        return;
      } else {
        message(this, "删除成功！");
        this.$router.push({path:'/ClientManagement'});
      }
    },
    back(){
      this.$router.back();
    },
  },

});
</script>

<style scoped>
.user-details {
  margin-top: 10px;
  display: flex;
  justify-content: center;
  align-items: center;
  min-height: 100vh;
  background-color: #f5f7fa;
  padding: 20px;
}

.box-card {
  max-width: 800px;
  width: 100%;
  padding: 20px;
  margin-top: -150px;
  background-color: #fff;
  border-radius: 10px;
  box-shadow: 0 4px 12px rgba(0, 0, 0, 0.1);
}

.flight-info-form {
  border: 1px solid #dcdfe6;
  border-radius: 8px;
  padding: 15px;
  background-color: #fff;
}

.el-form-item {
  margin-bottom: 20px;
}

.el-form-item span {
  font-weight: 500;
  color: #606266;
}

.el-form-item::after {
  content: "";
  display: block;
  clear: both;
}

.el-form-item label {
  font-size: 1.2em;
  font-weight: bold;
  color: #409eff;
}

.flight-info-form .el-form-item:last-child {
  margin-bottom: 0;
}

.el-card__header {
  font-size: 20px;
  font-weight: 700;
  color: #333;
  padding: 0 10px;
  border-bottom: 1px solid #ebeef5;
  position: relative;
}

.el-card__header span {
  vertical-align: middle;
}

.el-button {
  border-radius: 6px;
}

.el-button-primary {
  background-color: #409eff;
  border-color: #409eff;
}

.el-button-primary:hover {
  background-color: #66b1ff;
  border-color: #66b1ff;
}

.header-section {
  display: flex;
  align-items: center;
  justify-content: space-between;
  padding: 10px 20px;
  background-color: #f5f5f5;
  border-bottom: 1px solid #dcdcdc;
  border-radius: 5px 5px 0 0;
}

.header-title {
  font-size: 20px;
  font-weight: bold;
  color: #333;
}

.button-group {
  display: flex;
  gap: 10px;
}

.edit-button {
  background-color: #409eff;
  border-color: #409eff;
  color: white;
  border-radius: 5px;
  transition: all 0.3s ease;
}

.edit-button:hover {
  background-color: #66b1ff;
  border-color: #66b1ff;
}

.back-button {
  background-color: #909399;
  border-color: #909399;
  color: white;
  border-radius: 5px;
  transition: all 0.3s ease;
}

.back-button:hover {
  background-color: #e63c0d;
  border-color: #a6a9ad;
}
</style>
