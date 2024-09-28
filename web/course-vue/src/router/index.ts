// Composables
import { createRouter, createWebHistory } from "vue-router";
//路由表
const routes = [
  //当路由为空时，重定向到登录页面
  {
    path: "/",
    redirect: "/Login",
  },
  //登录页面
  {
    path: "/Login",
    name: "Login",
    component: () => import("~/Login.vue"),
  },
  //主页面
  {
    path: "/MainPage",
    name: "MainPage",
    component: () => import("~/views/MainPage.vue"),
  },
  {
    path: "/ChangeEmail",
    name: "ChangeEmail",
    component: () => import("~/views/info/ChangeEmail.vue"),
  },
  {
    path: "/SystemIntroduce",
    name: "SystemIntroduce",
    component: () => import("~/views/info/SystemIntroduce.vue"),
  },
  {
    path: "/Try",
    name: "Try",
    component: () => import("~/views/info/SystemIntroduce.vue"),
  },
  {
    path: "/Password",
    name: "Password",
    component: () => import("~/views/info/Password.vue"),
  },
  {
    path: "/StudentIntroduce",
    name: "StudentIntroduce",
    component: () => import("~/views/info/StudentIntroduce.vue"),
  },
  {
    path: "/TeacherIntroduce",
    name: "TeacherIntroduce",
    component: () => import("~/views/info/TeacherIntroduce.vue"),
  },
  {
    path: "/menu-manage-panel",
    name: "MenuManage",
    component: () => import("~/views/system/MenuManage.vue"),
  },
  {
    path: "/dictionary-manage-panel",
    name: "DictionaryManage",
    component: () => import("~/views/system/DictionaryManage.vue"),
  },

  {
    path: "/student-panel",
    name: "StudentTable",
    component: () => import("~/views/person/StudentTable.vue"),
  },
  {
    path: "/StudentInfo",
    name: "StudentInfo",
    component: () => import("~/views/person/StudentInfo.vue"),
  },
  {
    path: "/FamilyMember",
    name: "FamilyMember",
    component: () => import("~/views/person/FamilyMember.vue"),
  },
  {
    path: "/teacher-panel",
    name: "teacherTable",
    component: () => import("~/views/person/TeacherTable.vue"),
  },
  {
    path: "/TeacherInfo",
    name: "TeacherInfo",
    component: () => import("~/views/person/TeacherInfo.vue"),
  },

  {
    path: "/StudentQuery",
    name: "StudentQuery",
    component: () => import("~/views/info/StudentQuery.vue"),
  },
  {
    path: "/TeacherQuery",
    name: "TeacherQuery",
    component: () => import("~/views/info/TeacherQuery.vue"),
  },
  {
    path: "/StudentPractice",
    name: "StudentPractice",
    component: () => import("~/views/info/StudentPractice.vue"),
  },
  {
    path: "/PracticeAudit",
    name: "PracticeAudit",
    component: () => import("~/views/info/PracticeAudit.vue"),
  },
  {
    path: "/AwardAudit",
    name: "AwardAudit",
    component: () => import("~/views/info/AwardAudit.vue"),
  },
  {
    path: "/MessageCenter",
    name: "MessageCenter",
    component: () => import("~/views/info/MessageCenter.vue"),
  },
  {
    path: "/AuditDetail",
    name: "AuditDetail",
    component: () => import("~/views/info/AuditDetail.vue"),
  },
  {
    path: "/AwardApply",
    name: "AwardApply",
    component: () => import("~/views/info/AwardApply.vue"),
  },
  {
    path: "/Activities",
    name: "Activities",
    component: () => import("~/views/info/Activities.vue"),
  },
  {
    path: "/ActivityAudit",
    name: "ActivityAudit",
    component: () => import("~/views/info/ActivityAudit.vue"),
  },
  {
    path: "/ClientCenter",
    name: "ClientCenter",
    component: () => import("~/views/info/ClientCenter.vue"),
  },
  {
    path: "/AirlineCompanyCenter",
    name: "AirlineCompanyCenter",
    component: () => import("~/views/info/AirlineCompanyCenter.vue"),
  },
  {
    path: "/course-panel-admin",
    name: "course-panel-admin",
    component: () => import("~/views/teaching/CourseTable-admin.vue"),
  },
  {
    path: "/course-panel-student-choose",
    name: "course-panel-student-choose",
    component: () => import("~/views/teaching/CourseTable-student-choose.vue"),
  },
  {
    path: "/course-panel-student-Info",
    name: "course-panel-student-Info",
    component: () => import("~/views/teaching/CourseTable-student-Info.vue"),
  },
  {
    path: "/course-panel-student-graph",
    name: "course-panel-student-graph",
    component: () => import("~/views/teaching/CourseTable-student-graph.vue"),
  },
  {
    path: "/score-table-admin-panel",
    name: "score-table-admin-panel",
    component: () => import("~/views/teaching/ScoreTable-admin.vue"),
  },
  {
    path: "/score-table-teacher-panel",
    name: "score-table-teacher-panel",
    component: () => import("~/views/teaching/ScoreTable-teacher.vue"),
  },
  {
    path: "/RealNameVerification",
    name: "RealNameVerification",
    component: () => import("~/views/info/RealNameVerification.vue"),
  },
  {
    path: "/ClientPaidDeals",
    name: "ClientPaidDeals",
    component: () => import("~/views/info/ClientPaidDeals.vue"),
  },
  {
    path: "/ClientRefundDeals",
    name: "ClientRefundDeals",
    component: () => import("~/views/info/ClientRefundDeals.vue"),
  },
  {
    path: "/ChangePlane",
    name: "ChangePlane",
    component: () => import("~/views/info/ChangePlane.vue"),
  },
  {
    path: "/ChangeAnyPlaneIn",
    name: "ChangeAnyPlaneIn",
    component: () => import("~/views/info/ChangeAnyPlaneIn.vue"),
  },
  {
    path: "/ChangeAnyPlane",
    name: "ChangeAnyPlane",
    component: () => import("~/views/info/ChangeAnyPlane.vue"),
  },
  {
    path: "/ChangeTicket",
    name: "ChangeTicket",
    component: () => import("~/views/info/ChangeTicket.vue"),
  },
  {
    path: "/SeatSelection",
    name: "SeatSelection",
    component: () => import("~/views/info/SeatSelection.vue"),
  },
  {
    path: "/Search",
    name: "Search",
    component: () => import("~/views/info/Search.vue"),
  },
  {
    path: "/SearchPlane",
    name: "SearchPlane",
    component: () => import("~/views/info/SearchPlane.vue"),
  },
  {
    path: "/BuyTicket",
    name: "BuyTicket",
    component: () => import("~/views/info/BuyTicket.vue"),
  },
  {
    path: "/PublishFlights",
    name: "PublishFlights",
    component: () => import("~/views/info/PublishFlights.vue"),
  },
  {
    path: "/NewFlightForm",
    name: "NewFlightForm",
    component: () => import("~/views/info/NewFlightForm.vue"),
  },
  {
    path: "/FlightsManagement",
    name: "FlightsManagement",
    component: () => import("~/views/info/FlightsManagement.vue"),
  },
  {
    path: "/FlightDetails",
    name: "FlightDetails",
    component: () => import("~/views/info/FlightDetails.vue"),
  },
  {
    path: "/EditFlight",
    name: "EditFlight",
    component: () => import("~/views/info/EditFlight.vue"),
  },
  {
    path: "/ClientManagement",
    name: "ClientManagement",
    component: () => import("~/views/info/ClientManagement.vue"),
  },
  {
    path: "/ClientDetails",
    name: "ClientDetails",
    component: () => import("~/views/info/ClientDetails.vue"),
  },
  {
    path: "/EditClient",
    name: "EditClient",
    component: () => import("~/views/info/EditClient.vue"),
  },
  {
    path: "/AirlineCompanyManagement",
    name: "AirlineCompanyManagement",
    component: () => import("~/views/info/AirlineCompanyManagement.vue"),
  },
  {
    path: "/AirlineCompanyDetails",
    name: "AirlineCompanyDetails",
    component: () => import("~/views/info/AirlineCompanyDetails.vue"),
  },
  {
    path: "/EditAirlineCompany",
    name: "EditAirlineCompany",
    component: () => import("~/views/info/EditAirlineCompany.vue"),
  },
  {
    path: "/NationManagement",
    name: "NationManagement",
    component: () => import("~/views/info/NationManagement.vue"),
  },
  {
    path: "/NationDetails",
    name: "NationDetails",
    component: () => import("~/views/info/NationDetails.vue"),
  },
  {
    path: "/EditNation",
    name: "EditNation",
    component: () => import("~/views/info/EditNation.vue"),
  },
  {
    path: "/AddNation",
    name: "AddNation",
    component: () => import("~/views/info/AddNation.vue"),
  },
  {
    path: "/CityManagement",
    name: "CityManagement",
    component: () => import("~/views/info/CityManagement.vue"),
  },
  {
    path: "/CityDetails",
    name: "CityDetails",
    component: () => import("~/views/info/CityDetails.vue"),
  },
  {
    path: "/EditCity",
    name: "EditCity",
    component: () => import("~/views/info/EditCity.vue"),
  },
  {
    path: "/AddCity",
    name: "AddCity",
    component: () => import("~/views/info/AddCity.vue"),
  },
  {
    path: "/AirportManagement",
    name: "AirportManagement",
    component: () => import("~/views/info/AirportManagement.vue"),
  },
  {
    path: "/AirportDetails",
    name: "AirportDetails",
    component: () => import("~/views/info/AirportDetails.vue"),
  },
  {
    path: "/EditAirport",
    name: "EditAirport",
    component: () => import("~/views/info/EditAirport.vue"),
  },
  {
    path: "/AddAirport",
    name: "AddAirport",
    component: () => import("~/views/info/AddAirport.vue"),
  },
  {
    path: "/SpotManagement",
    name: "SpotManagement",
    component: () => import("~/views/info/SpotManagement.vue"),
  },
  {
    path: "/SpotDetails",
    name: "SpotDetails",
    component: () => import("~/views/info/SpotDetails.vue"),
  },
  {
    path: "/EditSpot",
    name: "EditSpot",
    component: () => import("~/views/info/EditSpot.vue"),
  },
  {
    path: "/AddSpot",
    name: "AddSpot",
    component: () => import("~/views/info/AddSpot.vue"),
  },
  {
    path: "/NotificationCenter",
    name: "NotificationCenter",
    component: () => import("~/views/info/NotificationCenter.vue"),
  },
  {
    path: "/Timer",
    name: "Timer",
    component: () => import("~/views/info/Timer.vue"),
  },
  {
    path: "/SpotShow",
    name: "SpotShow",
    component: () => import("~/views/info/SpotShow.vue"),
  },
  {
    path: "/SpotTicket",
    name: "SpotTicket",
    component: () => import("~/views/info/SpotTicket.vue"),
  },
  {
    path: "/PaidSpotTicket",
    name: "PaidSpotTicket",
    component: () => import("~/views/info/PaidSpotTicket.vue"),
  },
];
//路由创建
const router = createRouter({
  history: createWebHistory(process.env.BASE_URL),
  routes,
});
//路由导出
export default router;
