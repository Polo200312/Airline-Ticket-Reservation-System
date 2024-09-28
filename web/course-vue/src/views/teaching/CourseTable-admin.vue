<template>
  <div class="base_form">
    <div class="base_header">
      <div class="blue_column"></div>
      <div class="base_title">课程管理</div>
    </div>

    <div class="base_query_oneLine">
      <div class="query_left">
        <button class="commButton" @click="addItem()">添加</button>
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
          <td>上课时间</td>
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
          <td>{{ item.courseTimeList}}</td>
          <td>{{ item.rest }}</td>
          <td>
            <button class="table_edit_button" @click="editItem(item)">编辑</button>
            <button class="table_delete_button" @click="deleteItem(item.courseId)">删除</button>
          </td>
        </tr>
      </table>
    </div>
  </div>
  <!-- 对话框显示 -->
  <dialog
    id="favDialog"
    onclose="close()"
    style="position: absolute; top: 300px; left: 300px; width: 300px; height: 530px"
  >
    <div class="base_title">课程信息</div>
    <div class="dialog-div" style="margin-top: 5px">
      <table class="content">
        <tr>
          <td colspan="1" style="text-align: right">院系</td>
          <td colspan="1">
            <input v-model="form.department" style="width: 97%" />
          </td>
        </tr>
        <tr>
          <td colspan="1" style="text-align: right">专业</td>
          <td colspan="1">
            <input v-model="form.major" style="width: 97%" />
          </td>
        </tr>
        <tr>
          <td colspan="1" style="text-align: right">课程号</td>
          <td colspan="1"><input v-model="form.num" style="width: 97%" /></td>
        </tr>
        <tr>
          <td colspan="1" style="text-align: right">课程名</td>
          <td colspan="1"><input v-model="form.name" style="width: 97%" /></td>
        </tr>
        <tr>
          <td colspan="1" style="text-align: right">学分</td>
          <td colspan="1">
            <input v-model="form.credit" style="width: 97%" />
          </td>
        </tr>
        <tr>
          <td colspan="1" style="text-align: right">任课老师</td>
          <td colspan="1">
            <input v-model="form.teacher" style="width: 97%" />
          </td>
        </tr>
        <tr>
          <td colspan="1" style="text-align: right">周次</td>
          <td colspan="1">
            <input v-model="form.week" style="width: 97%" />
          </td>
        </tr>
        <tr>
          <td colspan="1" style="text-align: right">前置课程</td>
          <td colspan="1">
            <select class="commInput" v-model="form.preCourseId">
              <option v-for="item in courseSelectList" :key="item.id" :value="item.id">
                {{ item.title }}
              </option>
            </select>
          </td>
        </tr>
        <tr>
          <td colspan="1" style="text-align: right">学年</td>
          <td colspan="1">
            <select class="commInput" v-model="form.term">
              <option v-for="item in termList" :value = "item.value">
                {{ item.value }}
              </option>
            </select>
          </td>
        </tr>
        <tr>
          <td colspan="1" style="text-align: right">上课时间</td>
          <td colspan="1">
          <el-cascader class="commInput" :options="options" :props="props" v-model="form.ct"
            collapse-tags
            collapse-tags-tooltip
            max-collapse-tags="3"
            clearable
            >
          </el-cascader>
          </td>
        </tr>
        <tr>
          <td colspan="1" style="text-align: right">课容量</td>
          <td colspan="1">
            <input v-model="form.rest" style="width: 97%" />
          </td>
        </tr>
        <tr>
          <td colspan="2">
            <button class="commButton" @click="close()" style="margin-right: 30px">取消</button>
            <button class="commButton" @click="confirm()">确认</button>
          </td>
        </tr>
      </table>
    </div>
  </dialog>
</template>

<script lang="ts">
import { type CourseItem, type OptionItem } from '~/models/general'
import { defineComponent } from 'vue'
import { getCourseList, courseDelete, courseSave} from '~/services/teachingServ'
import { message, messageConform } from '~/tools/messageBox'
import { getDialog } from '~/tools/comMethod'
export default defineComponent({
  // 双向绑定数据
  
  data: () => ({
    props: { 
      multiple: true,
    },
    options: [
    {
      value:1,
      label: '星期一',
      children: [
        {value: 1,label: '第一、二节'},
        {value: 2,label: '第三、四节'},
        {value: 3,label: '第五、六节'},
        {value: 4,label: '第七、八节'},
        {value: 5,label: '第九、十节'},
     ],
    },
    {
      value:2,
      label: '星期二',
      children: [
        {value: 1,label: '第一、二节'},
        {value: 2,label: '第三、四节'},
        {value: 3,label: '第五、六节'},
        {value: 4,label: '第七、八节'},
        {value: 5,label: '第九、十节'},
      ],
    },
    {
      value:3,
      label: '星期三',
      children: [
        {value: 1,label: '第一、二节'},
        {value: 2,label: '第三、四节'},
        {value: 3,label: '第五、六节'},
        {value: 4,label: '第七、八节'},
        {value: 5,label: '第九、十节'},
      ],
    },
    {
      value:4,
      label: '星期四',
      children: [
        {value: 1,label: '第一、二节'},
        {value: 2,label: '第三、四节'},
        {value: 3,label: '第五、六节'},
        {value: 4,label: '第七、八节'},
        {value: 5,label: '第九、十节'},
      ],
    },
    {
      value:5,
      label: '星期五',
      children: [
        {value: 1,label: '第一、二节'},
        {value: 2,label: '第三、四节'},
        {value: 3,label: '第五、六节'},
        {value: 4,label: '第七、八节'},
        {value: 5,label: '第九、十节'},
      ],
    },
    {
      value:6,
      label: '星期六',
      children: [
        {value: 1,label: '第一、二节'},
        {value: 2,label: '第三、四节'},
        {value: 3,label: '第五、六节'},
        {value: 4,label: '第七、八节'},
        {value: 5,label: '第九、十节'},
      ],
    },
    {
      value:7,
      label: '星期日',
      children: [
        {value: 1,label: '第一、二节'},
        {value: 2,label: '第三、四节'},
        {value: 3,label: '第五、六节'},
        {value: 4,label: '第七、八节'},
        {value: 5,label: '第九、十节'},
      ],
    },
    ],
    numName: '',
    courseList: [] as CourseItem[],
    courseSelectList: [] as OptionItem[],
    termList:[
      {
        index:'01',
        value:'大一第一学年'
      },
      {
        index:'02',
        value:'大一第二学年'
      },
      {
        index:'03',
        value:'大二第一学年'
      },
      {
        index:'04',
        value:'大二第二学年'
      },
      {
        index:'05',
        value:'大三第一学年'
      },
      {
        index:'06',
        value:'大三第二学年'
      },
      {
        index:'07',
        value:'大四第一学年'
      },
      {
        index:'08',
        value:'大四第二学年'
      },
    ],
    deleteId: -1,
    form: {} as CourseItem,
  }),
  
  //初始加载一次,直接获取课程列表
  created() {
    this.query()
  },
  methods: {
    //设置课程选择列表
    makeSelectCourseList() {
      this.courseSelectList = []
      for (let i = 0; i < this.courseList.length; i++) {
        const item = this.courseList[i]
        this.courseSelectList.push({
          id: item.courseId,
          value: item.num,
          title: item.num + '-' + item.name
        })
      }
      this.courseSelectList.push({
          id: 0,
          value: "",
          title: ""
        })
    },
    //查询课程列表
    makeCourseTimeList(){
      for(let i=0;i<this.courseList.length;i++){
        const item = this.courseList[i]
        item.courseTimeList = []
        for(let j=0;j<item.courseTime.length;j++){
          if(item.courseTime[j]!=null){
            item.courseTimeList.push(item.courseTime[j])
          }
        }
      }
    },
    async query() {
      this.courseList = await getCourseList(this.numName)
      this.makeSelectCourseList()
      this.makeCourseTimeList()
    },
    //刷新页面
    refresh(){
      this.numName = ""
      this.query()
    },
    //添加课程,显示对话框
    async addItem() {
      this.form = {} as CourseItem
      getDialog('favDialog').show()
    },
    //编辑课程,显示对话框
    async editItem(item: CourseItem) {
      this.form = item
      getDialog('favDialog').show()
    },
    //关闭对话框
    close() {
      getDialog('favDialog').close()
      this.query()
    },
    //确认对话框
    async confirm() {   
      const res = await courseSave(this.form)
      if (res.code == 0) {
        message(this, '保存成功')
        this.query()
        this.close()
      } else {
        message(this, res.msg)
      }
    },
    //删除课程
    async deleteItem(courseId: number) {
      const result = await messageConform('确认删除吗?')
      if (!result) {
        return
      }
      const res = await courseDelete(courseId)
      if (res.code == 0) {
        message(this, '删除成功')
        this.query()
      } else {
        message(this, res.msg)
      }
    }
  }
})
</script>
<style></style>
