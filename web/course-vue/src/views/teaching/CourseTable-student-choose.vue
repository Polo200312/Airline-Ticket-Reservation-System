<template>
  <div class="base_form">
    <div class="base_header">
      <div class="blue_column"></div>
      <div class="base_title">课程管理</div>
    </div>

    <div class="base_query_oneLine">
      <div class="query_left">
      </div>
      <div class="query_right">
        <span style="margin-top: 5px">课程号或课程名</span>
        <input type="text" v-model="numName" style="margin-left: 10px; width: 230px" />
        <button style="margin-left: 5px" class="commButton" @click="query()">查询</button>
        <button style="margin-left: 5px" class="commButton" @click="refresh()">刷新</button>
      </div>
    </div>
    <div class="table_center" style="margin-top: 5px">
      <table class="content">
        <tr class="table_th">
          <td>院系</td>
          <td>专业</td>
          <td>课程号</td>
          <td>课程名</td>
          <td>学分</td>
          <td>前置课程</td>
          <td>任课老师</td>
          <td>学期</td>
          <td>周次</td>
          <td>课容量</td>
          <td>操作</td>
        </tr>
        <tr v-for="item in courseList" :key="item.courseId">
          <td>{{ item.department }}</td>
          <td>{{ item.major }}</td>
          <td>{{ item.num }}</td>
          <td>{{ item.name }}</td>
          <td>{{ item.credit }}</td>
          <td>{{ item.preCourse }}</td>
          <td>{{ item.teacher }}</td>
          <td>{{ item.term }}</td>
          <td>{{ item.week }}</td>
          <td>{{ item.rest }}</td>
          <td>
            <button class="table_edit_button" @click="addItem(item)">选入</button>
          </td>
        </tr>
      </table>
    </div>
  </div>
</template>

<script lang="ts">
import { type CourseItem, type OptionItem } from '~/models/general'
import { defineComponent } from 'vue'
import { getTermCourseList, personalCourseSave} from '~/services/teachingServ'
import { message, messageConform } from '~/tools/messageBox'
export default defineComponent({
  // 双向绑定数据
  
  data: () => ({
    numName: '',
    courseList: [] as CourseItem[],
    courseSelectList: [] as OptionItem[],
    deleteId: -1,
    form: {} as CourseItem,
    weekday:"",
    cnt:0,
    classper:""
  }),
  
  //初始加载一次,直接获取课程列表
  created() {
    this.query()
  },
  methods: {
    //查询课程列表
    async query() {
      this.courseList = await getTermCourseList(this.numName)
    },
    //刷新页面
    refresh(){
      this.numName = ""
      this.query()
    },
    //添加课程
    async addItem(item: CourseItem) {
      this.form = item
      this.confirm()
    },
    //确认对话框
    async confirm() {   
      const res = await personalCourseSave(this.form)
      if (res.code == 0) {
        message(this, '已成功选入')
        this.query()
      } else {
        message(this, res.msg)
      }
    },
  }
})
</script>
<style></style>
