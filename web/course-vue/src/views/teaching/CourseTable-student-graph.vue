<template>
  <div class="base_form">
    <div class="base_header">
      <div class="blue_column"></div>
      <div class="base_title">课表</div>
    </div>
    <div class="base_query_oneLine">
      <div class="query_right">
        <button style="margin-left: 5px" class="commButton" @click="refresh()">刷新</button>
      </div>
    </div>
    <div class="course_table" style="width: 100%">
      <el-table :data="courseTable" border>
        <el-table-column class-name="ct" prop="cT" label="节次/星期" width="100" />
        <el-table-column label="星期一" width="180">
          <template #default="scope">
            <el-popover effect="light" placement="top" width="auto" trigger="hover">
              <template #default>
                <div>课程名：{{ scope.row.Mon.name }}</div>
                <div>上课周次：{{ scope.row.Mon.week }}</div>
                <div>课序号：{{ scope.row.Mon.num }}</div>
              </template>
              <template #reference>
                <el-button color="white" size="large" style="color: gray; font-size: large; font-weight: 700;">{{
                  scope.row.Mon.name }}</el-button>
              </template>
            </el-popover>
          </template>
        </el-table-column>
        <el-table-column label="星期二" width="180">
          <template #default="scope">
            <el-popover effect="light" placement="top" width="auto" trigger="hover">
              <template #default>
                <div>课程名：{{ scope.row.Tue.name }}</div>
                <div>上课周次：{{ scope.row.Tue.week }}</div>
                <div>课序号：{{ scope.row.Tue.num }}</div>
              </template>
              <template #reference>
                <el-button color="white" size="large" style="color: gray; font-size: large; font-weight: 700;">{{
                  scope.row.Tue.name }}</el-button>
              </template>
            </el-popover>
          </template>
        </el-table-column>
        <el-table-column label="星期三" width="180">
          <template #default="scope">
            <el-popover effect="light" placement="top" width="auto" trigger="hover">
              <template #default>
                <div>课程名：{{ scope.row.Wed.name }}</div>
                <div>上课周次：{{ scope.row.Wed.week }}</div>
                <div>课序号：{{ scope.row.Wed.num }}</div>
              </template>
              <template #reference>
                <el-button color="white" size="large" style="color: gray; font-size: large; font-weight: 700;">{{
                  scope.row.Wed.name }}</el-button>
              </template>
            </el-popover>
          </template>
        </el-table-column>
        <el-table-column label="星期四" width="180">
          <template #default="scope">
            <el-popover effect="light" placement="top" width="auto" trigger="hover">
              <template #default>
                <div>课程名：{{ scope.row.Thu.name }}</div>
                <div>上课周次：{{ scope.row.Thu.week }}</div>
                <div>课序号：{{ scope.row.Thu.num }}</div>
              </template>
              <template #reference>
                <el-button color="white" size="large" style="color: gray; font-size: large; font-weight: 700;">{{
                  scope.row.Thu.name }}</el-button>
              </template>
            </el-popover>
          </template>
        </el-table-column>
        <el-table-column label="星期五" width="180">
          <template #default="scope">
            <el-popover effect="light" placement="top" width="auto" trigger="hover">
              <template #default>
                <div>课程名：{{ scope.row.Fri.name }}</div>
                <div>上课周次：{{ scope.row.Fri.week }}</div>
                <div>课序号：{{ scope.row.Fri.num }}</div>
              </template>
              <template #reference>
                <el-button color="white" size="large" style="color: gray; font-size: large; font-weight: 700;">{{
                  scope.row.Fri.name }}</el-button>
              </template>
            </el-popover>
          </template>
        </el-table-column>
        <el-table-column label="星期六" width="180">
          <template #default="scope">
            <el-popover effect="light" placement="top" width="auto" trigger="hover">
              <template #default>
                <div>课程名：{{ scope.row.Sat.name }}</div>
                <div>上课周次：{{ scope.row.Sat.week }}</div>
                <div>课序号：{{ scope.row.Sat.num }}</div>
              </template>
              <template #reference>
                <el-button color="white" size="large" style="color: gray; font-size: large; font-weight: 700;">{{
                  scope.row.Sat.name }}</el-button>
              </template>
            </el-popover>
          </template>
        </el-table-column>
        <el-table-column label="星期日" width="180">
          <template #default="scope">
            <el-popover effect="light" placement="top" width="auto" trigger="hover">
              <template #default>
                <div>课程名：{{ scope.row.Sun.name }}</div>
                <div>上课周次：{{ scope.row.Sun.week }}</div>
                <div>课序号：{{ scope.row.Sun.num }}</div>
              </template>
              <template #reference>
                <el-button color="white" size="large" style="color: gray; font-size: large; font-weight: 700;">{{
                  scope.row.Sun.name }}</el-button>
              </template>
            </el-popover>
          </template>
        </el-table-column>
      </el-table>
    </div>
  </div>
</template>

<script lang="ts">
import { type CourseItem, type CourseTable } from '~/models/general'
import { defineComponent } from 'vue'
import { getPersonalCourseTable, getPersonalCourseList } from '~/services/teachingServ'
import { isDark } from '~/composables/dark'
export default defineComponent({
  // 双向绑定数据

  data: () => ({
    numName: '',
    courseList: [] as CourseItem[],
    deleteId: -1,
    form: {} as CourseItem,
    courseTable: [] as CourseTable[],
  }),

  //初始加载一次,直接获取课程列表
  created() {
    this.query()
  },
  methods: {
    async query() {
      this.courseTable = await getPersonalCourseTable(this.numName)
      this.courseList = await getPersonalCourseList(this.numName)
    },
    //刷新页面
    refresh() {
      this.numName = ""
      this.query()
    },
  }
})
</script>
<style>.ct {
  font-weight: 700;
  color: gray;
  height: 120px;
}</style>
