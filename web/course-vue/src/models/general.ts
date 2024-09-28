//请求数据接口定义 用于请求数据时的参数的定义
//export 表示输出，其他文件可以引用
export interface DataRequest {
  data: any;
}
//请求数据接口定义 用于请求数据时的返回值的定义
export interface DataResponse {
  data: any;
  code: number;
  msg: string;
}
// 用于文件数据结构的定义
export interface FileInfo {
  url: string;
  name: string;
}
//用于系统提示信息的定义
export interface NotificationMsg {
  show: boolean;
  msg: string;
}
//用于系统确认信息的定义
export interface ConfirmMsg {
  show: boolean;
  msg: string;
  confirm: Function;
}
//用于WebStocet状态数据信息的定义
export interface WebSocketState {
  data: Object;
  webSocket: WebSocket;
}
//用于聊天信息的定义
export interface ChatInfo {
  userId: number;
  username: string;
  avatar: string;
  content: string;
}
export interface PaperItem {
  paperId: number;
  teacherId: number;
  title: string;
  author: string;
  publicationDate: string;
  link: string; // 论文对应的超链接
  image: string; // 图片
}
//用于验证码信息的定义
export interface ValidateCode {
  validateCodeId: number;
  img: string;
}
//用于菜单项信息的定义
export interface MenuInfo {
  id: number;
  name: string;
  title: string;
  sList: MenuInfo[];
}
//用于选择项信息的定义
export interface OptionItem {
  id: number;
  value: string;
  title: string;
}
//用于树节点信息的定义
export interface TreeNode {
  pid: number | null;
  id: number;
  value: string;
  title: string;
  label: string;
  userTypeIds: string;
  parentTitle: string;
  children: TreeNode[];
  isLeaf: number | null;
}
//用于系统配置信息的定义
export interface SystemConfig {
  naviList: MenuInfo[];
  showLeftMeun: boolean;
  leftList: MenuInfo[];
  id: number | null;
}
//用于用户信息的定义
export interface UserInfo {
  loggedIn: boolean;
  username: string;
  perName: string;
  jwtToken: string;
  id: number;
  roles: string;
  password: string;
}
//用于Chart数据信息的定义
export interface ChartItem {
  value: string[];
  label1: string[];
  label2: string[];
}
//用于UserOnline数据信息的定义
export interface UserOnlineItem {
  total: number;
  monthCount: number;
  dayCount: number;
}
//用于学生选择数据信息的定义
export interface Student {
  id: number;
  num: string;
  name: string;
}
export interface Teacher {
  teacherId: number;
  degree: string;
  title: string;
  name: string;
  photoUrl: string;
  intro: string;
  researchDirections: string[];
  courses: string[];
  publications: string[];
}
export interface DirectionItem {
  directionId: number;
  teacherId: number;
  name: string;
}
//用于成绩数据信息的定义
export interface ScoreItem {
  scoreId: number;
  studentId: number;
  courseId: number;
  studentNum: string;
  studentName: string;
  className: string;
  courseNum: string;
  courseName: string;
  credit: number;
  mark: number;
}
//用于学生数据信息的定义
export interface StudentItem {
  studentId: number;
  personId: number;
  num: string;
  name: string;
  dept: string;
  major: string;
  className: string;
  card: string;
  gender: string;
  genderName: string;
  birthday: string;
  email: string;
  phone: string;
  address: string;
  introduce: string;
  term: string;
}
export interface CourseTable {
  cT: string;
  Mon: CourseItem;
  Tue: CourseItem;
  Wed: CourseItem;
  Thu: CourseItem;
  Fri: CourseItem;
  Sat: CourseItem;
  Sun: CourseItem;
}
//用于课程数据信息的定义
export interface CourseItem {
  courseId: number;
  num: string;
  name: string;
  credit: number;
  teacher: string;
  preCourse: string;
  preCourseId: number;
  term: string;
  week: string;
  major: string;
  department: string;
  ct: number[];
  rest: number;
  courseTime: string[];
  courseTimeList: string[];
  score: number;
}
//用于成绩数据信息的定义
export interface ScoreItem {
  scoreId: number;
  studentId: number;
  courseId: number;
  studentNum: string;
  studentName: string;
  courseNum: string;
  courseName: string;
  credit: number;
  mark: number;
  ranking: number;
}
//用于学年数据的定义
export interface TermItem {
  term: string;
}
//用于成绩数据信息的定义
export interface ScoreItem {
  scoreId: number;
  studentId: number;
  courseId: number;
  studentNum: string;
  studentName: string;
  courseNum: string;
  courseName: string;
  credit: number;
  mark: number;
  ranking: number;
}
//用于学生团队数据信息的定义
export interface StudentTermItem {
  taskStudentId: number;
  termId: number;
  studentId: number;
  num: string;
  name: string;
  className: string;
  email: string;
  phone: string;
  address: string;
  teachNo: number;
  teamId: number;
  teamNo: string;
  weight: number;
  teamScore: number;
  uploader: string;
  uploadTime: string;
  birthday: string;
  attachId: number;
}
//用于团队学生数据信息的定义
export interface TermStudentItem {
  studentId: number;
  num: string;
  name: string;
  className: string;
  teachNo: string;
  weight: number;
  score: number;
  level: string;
}
//用于团队数据信息的定义
export interface TermItem {
  termId: number;
  select: boolean;
  teamNo: string;
  taskStudentId1: number;
  student1: string;
  weight1: number;
  taskStudentId2: number;
  student2: string;
  weight2: number;
  taskStudentId3: number;
  student3: string;
  weight3: number;
  taskStudentId4: number;
  student4: string;
  weight4: number;
  taskStudentId5: number;
  student5: string;
  weight5: number;
  teamWeight: number;
  teamScore: number;
  uploader: string;
  uploadTime: string;
}
//用于学科学生数据信息的定义
export interface TaskStudentItem {
  taskStudentId: number;
  studentId: number;
  num: string;
  name: string;
  className: string;
  teachNo: string;
  teamNo: number;
  teamScore: number;
  weight: number;
  score: number;
  level: string;
}
//用于家庭成员数据信息的定义
export interface FamilyMemberItem {
  memberId: number;
  studentId: number;
  relation: string;
  name: string;
  gender: string;
  age: string;
  unit: string;
}
//用于教师数据信息的定义
export interface TeacherItem {
  teacherId: number;
  personId: number;
  num: string;
  name: string;
  dept: string;
  title: string;
  degree: string;
  card: string;
  gender: string;
  genderName: string;
  birthday: string;
  email: string;
  phone: string;
  address: string;
  introduce: string;
}
//用户接口
export interface ClientItem {
  clientId: number;
  personId: number;
  amountOfMoney: number;
  num: string;
  name: string;
  gender: string;
  genderName: string;
  email: string;
  phone: string;
  realName: string;
  idNumber: string;
}
//航空公司接口
export interface AirlineCompanyItem {
  airlineCompanyId: number;
  personId: number;
  num: string;
  name: string;
  address: string;
  introduction: string;
  phone: string;
  email: string;
}
//通知信息接口
export interface NotificationItem {
  notificationId: number;
  personId: number;
  title: string;
  text: string;
  date: string;
  status: string;
}
//创建飞机时用
export interface ServicePlane {
    type: string;
    price: number;
    description: string;
}

//邮箱定义
export interface Email {
  email: string;
}
//验证码定义
export interface Velicode {
  veliCode: string;
}
//教师课程定义
export interface TeacherCourseItem {
  teacherId: number;
  time: string;
  day: string;
  name: string;
  major: string;
}
//奖项接口
export interface AwardItem {
  name: string;
  semester: string;
  awardId: number;
  personId: number;
  awardType: string;
  awardStatus: string;
}
//Messages用户
export interface MUser {
  MuserId: number; // 用户ID
  name: string; // 用户名
  num: string; 
  email: string; // 用户邮箱
}

export interface Message {
  messageId: number; // 消息ID
  from: string; // 添加 from 属性，类型为 string
  to: string;
  content: string; // 消息内容
  ifRead: boolean; //是否未读
  time: string; //时间
}
//主界面旅游景点
export interface SpotItem {
  name: string;
  spotId: number;
  category: string;
  rating: string;
  location: string;
  openingHours: string;
  ticketPrice: string;
  description: string;
  cityName: string;
}

//景点评价类
export interface SpotEvaluluateItem{
  spotEvaluluateId: number;
  spotId: number;
  evaluluate: string;
  rating: number;
  userName: string;
}

//景点订单
export interface SpotTicketItem {
  clientId: number;
  spotTicketId: number;
  value: string;
  time: string;
  spotName: string;
  spotId: number;
}

//订单记录
export interface DealItem {
  dealId: number;
  clientId: number;
  seatId: number;
  planeId: number;
  seatColumnNumber: string;
  seatRowNumber: string;
  level: string;
  startDay: string;
  endDay: string;
  startTime: string;
  endTime: string;
  startCity: string;
  endCity: string;
  departureAirport: string;
  arrivalAirport: string;
  planeName: string;
  airlineCompanyName: string;
  planeStatus: string;
  status: string;
  time: string;
  attribute: string;
  value: number;
  travelRecordId: number;
}

//飞机类接口
export interface PlaneItem {
  planeId: number;
  planeName: string;
  planeStatus: string;
  airlineCompanyName: string;
  arrivalAirport: string;
  departureAirport: string;
  startCity: string;
  endCity: string;
  startDay: string;
  endDay: string;
  startTime: string;
  endTime: string;
  number_all: number;
  number_rest: number;
}
//座位类
export interface Seat {
  row: string;
  column: string;
  enabled: boolean;
  disabled: boolean;
}
//座位接口
export interface SeatItem {
  seatId: number;
  seatRowNumber: string;
  seatColumnNumber: string;
  planeId: number;
  dealId: number;
  level: string;
  price: number;
  isBooked: boolean;
}
//机场接口
export interface AirportItem {
  airportId: number;
  airportName: string;
  airportIntroduction: string;
  airportX: number;
  airportY: number;
  status: string;
  cityId: number;
  cityName: string;
}
//城市接口
export interface CityItem {
  cityId: number;
  cityName: string;
  timeZone: string;
  cityX: number;
  cityY: number;
  timeAdapter: string;
  nationId: number;
  nationName: string;
  searchTimes: number;
}
//国家接口
export interface NationItem {
  nationId: number;
  nationName: string;
  visaFreeNations: string[];
}
//出行记录接口
export interface TravelRecordItem {
  travelRecordId: number;
  clientId: string;
  departureAirportName: string;
  arrivalAirportName: string;
  status: string;
}
//价目表接口
export interface TariffItem {
  tariffId: number;
  planeId: number;
  type: string;
  description: string;
  price: number;
}
//用于出行航线查询
export interface RouteSegment {
  departureAirport: string;
  arrivalAirport: string;
  startDate: string;
  startTime: string;
  endDate: string;
  endTime: string;
  price: number;
  planeId: number;
  airlineCompanyName : string;
  number_rest: number;
}

export interface RouteResponse {
  path: RouteSegment[];
  totalDistance: number;
  totalPrice: number;
}

//社会实践记录接口
export interface PracticeItem {
  practiceId: number;
  projectName: string;
  teamName: string;
  summary: string;
  status: string;
}
//课外活动接口
export interface ActivityItem {
  activityId: number;
  activityName: string;
  type: string;
  form: string;
  description: string;
  status: string;
  groupName: string;
  groupMembers: string;
}
//学生互评记录
export interface PeerItem {
  moralityScore: number;
  studyScore: number;
  sportScore: number;
  artScore: number;
  labourScore: number;
}