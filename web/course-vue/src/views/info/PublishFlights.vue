<template>
  <div class="container">
    <img src="/plane2.png" width="30" height="30" />
    <span class="newBase_title">发布新航班</span>
    <NewFlightForm />
    <button class="cancel-ticket-button" @click="back()">返回上一页</button>
  </div>
</template>

<script lang="ts">
import { defineComponent } from "vue";
import NewFlightForm from "./NewFlightForm.vue";
export default defineComponent({
  components: {
    NewFlightForm,
  },
  methods: {
    back() {
      this.$router.back();
    },
  },
});
</script>

<style scoped>
.container {
  max-width: 1200px;
  border: 1px solid #ccc;
  border-radius: 5px;
  margin: 0 auto;
  padding: 20px;
  font-family: Arial, sans-serif; /* 设置整体字体 */
  background-color: #fff; /* 设置背景颜色 */
  margin-top: 20px;
  box-shadow: 0 0 10px rgba(0, 0, 0, 0.1); /* 添加阴影效果 */
}

.newBase_title {
  margin-top: 12px;
  margin-left: 8px;
  font-family: SourceHanSansCN-Medium;
  font-size: 16px;
  color: #202020;
  letter-spacing: 0;
  font-weight: bold;
}
.cancel-ticket-button {
  background-color: #f44336; /* 按钮背景色 */
  color: white; /* 文字颜色 */
  border: none; /* 去除边框 */
  padding: 10px 20px; /* 内边距 */
  font-size: 16px; /* 字体大小 */
  cursor: pointer; /* 光标样式为指针 */
  border-radius: 5px; /* 圆角 */
  transition: background-color 0.3s ease; /* 平滑过渡 */

  /* 阴影效果，使按钮看起来更突出 */
  box-shadow: 0 2px 4px rgba(0, 0, 0, 0.2);
}

.cancel-ticket-button:hover {
  background-color: #d32f2f; /* 鼠标悬停时的背景色 */
}
.cancel-ticket-button:active {
  background-color: #b71c1c; /* 按钮按下时的背景色 */
}
</style>
