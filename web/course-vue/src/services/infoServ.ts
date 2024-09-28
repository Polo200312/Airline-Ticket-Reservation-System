import { generalRequest, uploadRequest } from "~/services/genServ";
import { PeerItem, type DataResponse } from "~/models/general";
import { Email } from '../models/general';
//修改口令后台数据请求方法
export async function updatePassword(data: Object): Promise<DataResponse> {
  const res = await generalRequest("/api/base/updatePassword", data);
  return res as DataResponse;
}
//获取个人简介信息后台数据请求方法
export async function getStudentIntroduceData(
  studentId: number | null
): Promise<DataResponse> {
  const res = await generalRequest("/api/student/getStudentIntroduceData", {
    studentId: studentId,
  });
  return res as DataResponse;
}
//获取照片数据后台数据请求方法
export async function getPhotoImageStr(
  fileName: String
): Promise<DataResponse> {
  const res = await generalRequest("/api/base/getPhotoImageStr", {
    fileName: fileName,
  });
  return res as DataResponse;
}
//上传照片数据后台数据请求方法
export async function uploadPhoto(remoteFile: string, file: any): Promise<any> {
  console.log(remoteFile);
  console.log(file);
  const formData = new FormData();
  formData.append("file", file);
  const res = await uploadRequest(
    "/api/base/uploadPhotoWeb?remoteFile=" + remoteFile,
    formData
  );
  return res as DataResponse;
}

//导入数据库
export async function uploadSQL(file: any): Promise<any> {
  console.log(file);
  const formData = new FormData();
  formData.append("file", file);
  const res = await uploadRequest(
    "/api/databaseImport/uploadSQL",
    formData
  );
  return res as DataResponse;
}

//教师介绍
export async function getTeacherIntroduceData(
  teacherId: number | null
): Promise<DataResponse> {
  const res = await generalRequest("/api/teacher/getTeacherIntroduceData", {
    teacherId: teacherId,
  });
  return res as DataResponse;
}
//获奖列表
export async function getPersonAwardList(
  personId: number | null
): Promise<DataResponse> {
  const res = await generalRequest("/api/award/getPersonAwardList", {
    personId: personId,
  });
  return res as DataResponse;
}
//获取社会实践通过列表
export async function getStudentApprovedRecords(
  studentId: number | null
): Promise<DataResponse> {
  const res = await generalRequest("/api/practice/getStudentApprovedRecords", {
    studentId: studentId,
  });
  return res as DataResponse;
}

export async function getApplyStudentList(): Promise<DataResponse> {
  const res = await generalRequest("/api/practice/getApplyStudentList", {
  });
  return res as DataResponse;
}
//提交社会实践
export async function submitPractice(
  data: Object
): Promise<DataResponse> {
  const res = await generalRequest("/api/practice/submitPractice", data);
  return res as DataResponse;
}
//拒绝社会实践
export async function Reject(
  data: Object
): Promise<DataResponse> {
  const res = await generalRequest("/api/practice/reject", data);
  return res as DataResponse;
}
//通过社会实践
export async function Approve(
  data: Object
): Promise<DataResponse> {
  const res = await generalRequest("/api/practice/approve", data);
  return res as DataResponse;
}
//获取社会实践未通过列表
export async function getUnpracticeData(
  studentId: number | null
): Promise<DataResponse> {
  const res = await generalRequest("/api/practice/getUnpracticeData", {
    studentId: studentId,
  });
  return res as DataResponse;
}
//删除申请
export async function deleteApply(
  practiceIdToDelete: number | null
): Promise<DataResponse> {
  const res = await generalRequest("/api/practice/deleteApply", {
    practiceIdToDelete: practiceIdToDelete,
  });
  return res as DataResponse;
}
//Message当前用户查询
export async function getCurrentUserData(
  userId: number | null
): Promise<DataResponse> {
  const res = await generalRequest("/api/message/getCurrentUserData", {
    userId: userId,
  });
  return res as DataResponse;
}
//发送消息
export async function sendMessage(
  data: Object
): Promise<DataResponse> {
  const res = await generalRequest("/api/message/sendMessage", data);
  return res as DataResponse;
}
//通信筛选用户类型
export async function fetchUsersData(
  selectedRole: string
): Promise<DataResponse> {
  const res = await generalRequest("/api/message/fetchUsersData", {
    selectedRole: selectedRole,
  });
  return res as DataResponse;
}
//找到所有消息
export async function findMessages(
  data: Object
): Promise<DataResponse> {
  const res = await generalRequest("/api/message/findMessages", data);
  return res as DataResponse;
}
//更新消息状态（已读未读）
export async function changeStatus(
  messageId: number
): Promise<DataResponse> {
  const res = await generalRequest("/api/message/changeStatus", {
    messageId: messageId,
  });
  return res as DataResponse;
}
//删除Award
export async function editAward(
  awardId: number
): Promise<DataResponse> {
  const res = await generalRequest("/api/award/editAward", {
    awardId: awardId,
  });
  return res as DataResponse;
}
//添加Award
export async function addAward(
  data: Object
): Promise<DataResponse> {
  const res = await generalRequest("/api/award/addAward", data);
  return res as DataResponse;
}

export async function getStudentData(
  studentId: number | null
): Promise<DataResponse> {
  const res = await generalRequest("/api/student/getStudentData", {
    studentId: studentId,
  });
  return res as DataResponse;
}

export async function getTeacherData(
  teacherId: number | null
): Promise<DataResponse> {
  const res = await generalRequest("/api/teacher/getTeacherData", {
    teacherId: teacherId,
  });
  return res as DataResponse;
}

export async function getClientData(
  clientId: number | null
): Promise<DataResponse> {
  const res = await generalRequest("/api/client/getClientData", {
    clientId: clientId,
  });
  return res as DataResponse;
}

export async function getPersonIntro(
  personId: number | null
): Promise<DataResponse> {
  const res = await generalRequest("/api/person/getPersonIntro", {
    personId: personId,
  });
  return res as DataResponse;
}

export async function changeTeacherData(
  data: Object
): Promise<DataResponse> {
  const res = await generalRequest("/api/teacher/changeTeacherData", data);
  return res as DataResponse;
}

export async function deletedirection(
  directionId: number | null
): Promise<DataResponse> {
  const res = await generalRequest("/api/teacher/deletedirection", {
    directionId: directionId,
  });
  return res as DataResponse;
}

export async function deletePaper(
  paperId: number | null
): Promise<DataResponse> {
  const res = await generalRequest("/api/teacher/deletePaper", {
    paperId: paperId,
  });
  return res as DataResponse;
}

export async function submitdirection(
  data: Object
): Promise<DataResponse> {
  const res = await generalRequest("/api/teacher/submitdirection", data);
  return res as DataResponse;
}

export async function getShowTeachers(
  personId: number | null
): Promise<DataResponse> {
  const res = await generalRequest("/api/teacher/getShowTeachers", {
    personId: personId,
  });
  return res as DataResponse;
}

export async function changePass(
  data: Object
): Promise<DataResponse> {
  const res = await generalRequest("/auth/changePass", data);
  return res as DataResponse;
}

export async function sendVerificationCode(email: string): Promise<DataResponse> {
  /*try {
    const response: AxiosResponse<DataResponse> = await axios.post('/api/send-verification-code', { email : email});
    const data = response.data;
    // 处理响应数据
    return data.data;
  } catch (error) {
    const axiosError = error as AxiosError;
    if (axiosError.response) {
      const errorData = axiosError.response.data as DataResponse;
      return errorData.data;
    }
    // 处理错误
  }*/
  const response = await generalRequest('/auth/sendVerificationCode', { email: email });
  // 处理响应数据
  return response as DataResponse;;
}

export async function checkCode(email: string | null, verificationCode: string | null): Promise<DataResponse> {
  const res = await generalRequest("/auth/checkCode", {
    email: email,
    verificationCode: verificationCode
  });
  return res as DataResponse;
}

export async function checkEmailUser(data: Object): Promise<DataResponse> {
  const res = await generalRequest("/auth/checkEmailUser", data);
  return res as DataResponse;
}

export async function submitAward(data: Object): Promise<DataResponse> {
  const res = await generalRequest("/api/award/submitAward", data);
  return res as DataResponse;
}

export async function rejectAward(
  awardId: number | null
): Promise<DataResponse> {
  const res = await generalRequest("/api/award/rejectAward", {
    awardId: awardId,
  });
  return res as DataResponse;
}

export async function appAward(
  awardId: number | null
): Promise<DataResponse> {
  const res = await generalRequest("/api/award/appAward", {
    awardId: awardId,
  });
  return res as DataResponse;
}

export async function getStudentActivityList(
  studentId: number | null
): Promise<DataResponse> {
  const res = await generalRequest("/api/activity/getStudentActivityList", {
    studentId: studentId,
  });
  return res as DataResponse;
}

export async function submitActivity(
  data: Object
): Promise<DataResponse> {
  const res = await generalRequest("/api/activity/submitActivity", data);
  return res as DataResponse;
}

export async function editActivity(
  activityId: number | null
): Promise<DataResponse> {
  const res = await generalRequest("/api/activity/editActivity", {
    activityId: activityId,
  });
  return res as DataResponse;
}

export async function rejectActivity(
  activityId: number | null
): Promise<DataResponse> {
  const res = await generalRequest("/api/activity/rejectActivity", {
    activityId: activityId,
  });
  return res as DataResponse;
}

export async function appActivity(
  activityId: number | null
): Promise<DataResponse> {
  const res = await generalRequest("/api/activity/appActivity", {
    activityId: activityId,
  });
  return res as DataResponse;
}

export async function getStudentPeerScoreList(
  studentId: number | null
): Promise<PeerItem[]> {
  const res = await generalRequest("/api/peer/getStudentPeerScoreList", {
    studentId: studentId,
  });
  return res.data as PeerItem[];
}

export async function submitPeer(
  data: Object
): Promise<DataResponse> {
  const res = await generalRequest("/api/peer/submitPeer", data);
  return res as DataResponse;
}

export async function getMessages(
  name: string
): Promise<DataResponse> {
  const res = await generalRequest("/api/message/getMessages", {
    name: name,
  });
  return res as DataResponse;
}

export async function submitPaper(
  data:Object
): Promise<DataResponse>  {
  const res = await generalRequest("/api/teacher/submitPaper", data);
  return res as DataResponse;
}

//获取用户信息（邮箱登录）
export async function getUserDataByEmail(
  email: string
): Promise<DataResponse> {
  const res = await generalRequest("/auth/getUserDataByEmail", {
    email: email,
  });
  return res as DataResponse;
}

export async function getSpotList(
  spotId : number,
): Promise<DataResponse> {
  const res = await generalRequest("/api/spot/getSpotList", {
    spotId: spotId,
  });
  return res as DataResponse;
}
//根据起降城市和日期查找航班
export async function searchForPlanes(
  data: Object
): Promise<DataResponse> {
  const res = await generalRequest("/api/plane/searchForPlanes", data);
  return res as DataResponse;
}
export async function searchForPlaneById(
  planeId: number | null
): Promise<DataResponse> {
  const res = await generalRequest("/api/plane/searchForPlaneById", {
    planeId: planeId
  });
  return res as DataResponse;
}
//查询航班上的座位情况（选座用）
export async function getPlaneDetails(
  planeId: number | null
): Promise<DataResponse> {
  const res = await generalRequest("/api/plane/getPlaneDetails", {
    planeId: planeId
  });
  return res as DataResponse;
}

export async function getCityListByNationId(
  nationId: number | null
): Promise<DataResponse> {
  const res = await generalRequest("/api/city/getCityListByNationId", {
    nationId: nationId
  });
  return res as DataResponse;
}

export async function getAirportListByCityId(
  cityId: number | null
): Promise<DataResponse> {
  const res = await generalRequest("/api/airport/getAirportListByCityId", {
    cityId: cityId
  });
  return res as DataResponse;
}
//找国家列表
export async function getAllNationList(
): Promise<DataResponse> {
  const res = await generalRequest("/api/nation/getAllNationList", {
  });
  return res as DataResponse;
}

//找城市列表
export async function getAllCityList(
): Promise<DataResponse> {
  const res = await generalRequest("/api/city/getAllCityList", {
  });
  return res as DataResponse;
}

//找机场列表
export async function getAllAirportList(
): Promise<DataResponse> {
  const res = await generalRequest("/api/airport/getAllAirportList", {
  });
  return res as DataResponse;
}

//找景点列表
export async function getAllSpotList(
): Promise<DataResponse> {
  const res = await generalRequest("/api/spot/getSpotList", {
  });
  return res as DataResponse;
}

//找航空公司列表
export async function getAirlineCompanyDataList(
): Promise<DataResponse> {
  const res = await generalRequest("/api/airlineCompany/getAirlineCompanyDataList", {
  });
  return res as DataResponse;
}

//找国家列表
export async function getNationDataList(
): Promise<DataResponse> {
  const res = await generalRequest("/api/nation/getNationDataList", {
  });
  return res as DataResponse;
}

//找用户列表
export async function getClientList(
): Promise<DataResponse> {
  const res = await generalRequest("/api/client/getClientList", {
  });
  return res as DataResponse;
}

//找航空公司信息
export async function getAirlineCompanyInfo(
  airlineCompanyId: number | null
): Promise<DataResponse> {
  const res = await generalRequest("/api/airlineCompany/getAirlineCompanyInfo", {
    airlineCompanyId: airlineCompanyId
  });
  return res as DataResponse;
}

//找国家信息
export async function getNationInfo(
  nationId: number | null
): Promise<DataResponse> {
  const res = await generalRequest("/api/nation/getNationInfo", {
    nationId: nationId
  });
  return res as DataResponse;
}

//找城市信息
export async function getCityInfo(
  cityId: number | null
): Promise<DataResponse> {
  const res = await generalRequest("/api/city/getCityInfo", {
    cityId: cityId
  });
  return res as DataResponse;
}

//找机场信息
export async function getAirportInfo(
  airportId: number | null
): Promise<DataResponse> {
  const res = await generalRequest("/api/airport/getAirportInfo", {
    airportId: airportId
  });
  return res as DataResponse;
}

//找景点信息
export async function getSpotInfo(
  spotId: number | null
): Promise<DataResponse> {
  const res = await generalRequest("/api/spot/getSpotInfo", {
    spotId: spotId
  });
  return res as DataResponse;
}

//找景点信息
export async function getSpotData(
  spotName: string | null
): Promise<DataResponse> {
  const res = await generalRequest("/api/spot/getSpotData", {
    spotName: spotName
  });
  return res as DataResponse;
}
//找评价
export async function getSpotEvaluluateData(
  spotName: string | null
): Promise<DataResponse> {
  const res = await generalRequest("/api/spotEvaluluate/getSpotEvaluluateList", {
    spotName: spotName
  });
  return res as DataResponse;
}

//景点评价
export async function submitComment(
  data: Object
): Promise<DataResponse> {
  const res = await generalRequest("/api/spotEvaluluate/addSpotEvaluluate", data);
  return res as DataResponse;
}

//景点购票
export async function purchaseSpotTicket(
  data: Object
): Promise<DataResponse> {
  const res = await generalRequest("/api/spotTicket/purchaseSpotTicket", data);
  return res as DataResponse;
}

//找用户信息
export async function getClientInfo(
  clientId: number | null
): Promise<DataResponse> {
  const res = await generalRequest("/api/client/getClientInfo", {
    clientId: clientId
  });
  return res as DataResponse;
}

//改用户信息
export async function changeClientSave(
  data: Object
): Promise<DataResponse> {
  const res = await generalRequest("/api/client/changeClientSave", data);
  return res as DataResponse;
}

//改航空公司信息
export async function changeAirlineCompanySave(
  data: Object
): Promise<DataResponse> {
  const res = await generalRequest("/api/airlineCompany/changeAirlineCompanySave", data);
  return res as DataResponse;
}

//改国家信息
export async function changeNationSave(
  data: Object
): Promise<DataResponse> {
  const res = await generalRequest("/api/nation/changeNationSave", data);
  return res as DataResponse;
}

//改城市信息
export async function changeCitySave(
  data: Object
): Promise<DataResponse> {
  const res = await generalRequest("/api/city/changeCitySave", data);
  return res as DataResponse;
}

//改城市信息
export async function changeAirportSave(
  data: Object
): Promise<DataResponse> {
  const res = await generalRequest("/api/airport/changeAirportSave", data);
  return res as DataResponse;
}

//改景点信息
export async function changeSpotSave(
  data: Object
): Promise<DataResponse> {
  const res = await generalRequest("/api/spot/changeSpotSave", data);
  return res as DataResponse;
}

//新增国家信息
export async function addNation(
  data: Object
): Promise<DataResponse> {
  const res = await generalRequest("/api/nation/addNation", data);
  return res as DataResponse;
}

//新增国家信息
export async function addCity(
  data: Object
): Promise<DataResponse> {
  const res = await generalRequest("/api/city/addCity", data);
  return res as DataResponse;
}

//新增机场信息
export async function addAirport(
  data: Object
): Promise<DataResponse> {
  const res = await generalRequest("/api/airport/addAirport", data);
  return res as DataResponse;
}

//新增景点信息
export async function addSpot(
  data: Object
): Promise<DataResponse> {
  const res = await generalRequest("/api/spot/addSpot", data);
  return res as DataResponse;
}

//删除航空公司信息
export async function airlineCompanyDelete(
  airlineCompanyId: number | null
): Promise<DataResponse> {
  const res = await generalRequest("/api/airlineCompany/airlineCompanyDelete", {
    airlineCompanyId: airlineCompanyId
  });
  return res as DataResponse;
}

//删除用户信息
export async function clientDelete(
  clientId: number | null
): Promise<DataResponse> {
  const res = await generalRequest("/api/client/clientDelete", {
    clientId: clientId
  });
  return res as DataResponse;
}

//删除航班信息
export async function deletePlane(
  planeId: number | null
): Promise<DataResponse> {
  const res = await generalRequest("/api/plane/deletePlane", {
    planeId: planeId
  });
  return res as DataResponse;
}

//删除景点信息
export async function deleteSpot(
  spotId: number | null
): Promise<DataResponse> {
  const res = await generalRequest("/api/spot/deleteSpot", {
    spotId: spotId
  });
  return res as DataResponse;
}

export async function getCityById(
  cityId: number | null
): Promise<DataResponse> {
  const res = await generalRequest("/api/city/getCityById", {
    cityId: cityId
  });
  return res as DataResponse;
}
//查航班（筛选）
export async function getTravelOptions(
  data: Object
): Promise<DataResponse> {
  const res = await generalRequest("/api/airport/getTravelOptions", data);
  return res as DataResponse;
}

//改通知信状态
export async function changeNotificationSave(
  data: Object
): Promise<DataResponse> {
  const res = await generalRequest("/api/notification/changeNotificationSave", data);
  return res as DataResponse;
}

//删通知
export async function deleteAllNotifications(
): Promise<DataResponse> {
  const res = await generalRequest("/api/notification/deleteAllNotification", {
  });
  return res as DataResponse;
}

//改用户信息
export async function changeClientData(
  data: Object
): Promise<DataResponse> {
  const res = await generalRequest("/api/client/changeClientData", data);
  return res as DataResponse;
}

//改航空公司信息
export async function changeAirlineCompanyData(
  data: Object
): Promise<DataResponse> {
  const res = await generalRequest("/api/airlineCompany/changeAirlineCompanyData", data);
  return res as DataResponse;
}

//改签方法
export async function reBook(
  data: Object
): Promise<DataResponse> {
  const res = await generalRequest("/api/client/reBook", data);
  return res as DataResponse;
}
//购票方法
export async function purchaseTicket(
  data: Object
): Promise<DataResponse> {
  const res = await generalRequest("/api/client/purchaseTicket", data);
  return res as DataResponse;
}
//创建出行记录
export async function createNewRecord(
  data: Object
): Promise<DataResponse> {
  const res = await generalRequest("/api/client/createNewRecord", data);
  return res as DataResponse;
}

//通知信息
export async function getNotificationListByPersonId(
  personId: number | null
): Promise<DataResponse> {
  const res = await generalRequest("/api/notification/getNotificationListByPersonId", {
    personId: personId,
  });
  return res as DataResponse;
}

//用户信息
export async function getClientIntroduceData(
  clientId: number | null
): Promise<DataResponse> {
  const res = await generalRequest("/api/client/getClientIntroduceData", {
    clientId: clientId,
  });
  return res as DataResponse;
}
//航空公司信息
export async function getAirlineCompanyIntroduceData(
  airlineCompanyId: number | null
): Promise<DataResponse> {
  const res = await generalRequest("/api/airlineCompany/getAirlineCompanyIntroduceData", {
    airlineCompanyId: airlineCompanyId,
  });
  return res as DataResponse;
}

//查询航班列表
export async function getPlaneList(
  airlineCompanyId: number | null
): Promise<DataResponse> {
  const res = await generalRequest("/api/plane/getPlaneList", {
    airlineCompanyId: airlineCompanyId,
  });
  return res as DataResponse;
}
//查询飞机
export async function getPlaneByName(
  planeName: string | null
): Promise<DataResponse> {
  const res = await generalRequest("/api/plane/getPlaneByName", {
    planeName: planeName,
  });
  return res as DataResponse;
}
//添加新航班
export async function addPlane(
  data: Object
): Promise<DataResponse> {
  const res = await generalRequest("/api/plane/addPlane", data);
  return res as DataResponse;
}

export async function changeClientIDAndName(
  data: Object
): Promise<DataResponse> {
  const res = await generalRequest("/api/client/changeClientIDAndName", data);
  return res as DataResponse;
}
//用户订单
export async function getClientDealList(
  clientId: number | null
): Promise<DataResponse> {
  const res = await generalRequest("/api/deal/getClientDealList", {
    clientId: clientId,
  });
  return res as DataResponse;
}

//用户景点门票
export async function getClientSpotTicketList(
  clientId: number | null
): Promise<DataResponse> {
  const res = await generalRequest("/api/spotTicket/getSpotTicketList", {
    clientId: clientId,
  });
  return res as DataResponse;
}

//用户出行记录
export async function getClientTravelRecordList(
  clientId: number | null
): Promise<DataResponse> {
  const res = await generalRequest("/api/client/getClientTravelRecordList", {
    clientId: clientId,
  });
  return res as DataResponse;
}

export async function getClientDealListWithTravelRecordId(
  data: Object
): Promise<DataResponse> {
  const res = await generalRequest("/api/deal/getClientDealListWithTravelRecordId", data);
  return res as DataResponse;
}

//记录内全部退票
export async function handleRefundAll(
  data: Object
): Promise<DataResponse> {
  const res = await generalRequest("/api/client/handleRefundAll", data);
  return res as DataResponse;
}

//机票退票
export async function refundTicket(
  data: Object
): Promise<DataResponse> {
  const res = await generalRequest("/api/client/refundTicket", data);
  return res as DataResponse;
}

//门票退票
export async function refundSpotTicket(
  data: Object
): Promise<DataResponse> {
  const res = await generalRequest("/api/spotTicket/refundSpotTicket", data);
  return res as DataResponse;
}

export async function cancelTicket(
  travelRecordId: number | null
): Promise<DataResponse> {
  const res = await generalRequest("/api/client/cancelTicket", {
    travelRecordId: travelRecordId,
  });
  return res as DataResponse;
}

export async function getTariffList(
  planeId: number | null
): Promise<DataResponse> {
  const res = await generalRequest("/api/plane/getTariffList", {
    planeId: planeId,
  });
  return res as DataResponse;
}

export async function changePlaneSave(
  data: Object
): Promise<DataResponse> {
  const res = await generalRequest("/api/plane/changePlaneSave", data);
  return res as DataResponse;
}

export async function searchPrice(
  data: Object
): Promise<DataResponse> {
  const res = await generalRequest("/api/plane/searchPrice", data);
  return res as DataResponse;
}

export async function getDealById(
  dealId: number | null
): Promise<DataResponse> {
  const res = await generalRequest("/api/deal/getDealById", {
    dealId: dealId,
  });
  return res as DataResponse;
}

//备份数据库
export async function saveSQL(
): Promise<DataResponse> {
  const res = await generalRequest("/api/databaseBackup/saveSQL", {
  });
  return res as DataResponse;
}


