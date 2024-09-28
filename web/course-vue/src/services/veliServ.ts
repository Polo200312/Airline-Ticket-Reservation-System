import axios, { AxiosResponse,AxiosError} from 'axios';
import { generalRequest, uploadRequest } from "~/services/genServ";
import {
  type DataResponse,
  type Email,
  type Velicode,
} from "~/models/general";

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
  const response = await generalRequest('/api/vetification/sendVerificationCode', { email : email});
    // 处理响应数据
  return response as DataResponse;;
}

export async function updateEmail(email: string  | null, checkCode: string | null, newEmail: string | null): Promise<DataResponse> {
  /*try {
    const response: AxiosResponse<DataResponse> = await axios.post('/api/update-email', {
      email: email,
      verificationCode: verificationCode,
      newEmail: newEmail
    });

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
  const response = await generalRequest('/api/vetification/updateEmail', {
    email: email,
    checkCode: checkCode,
    newEmail: newEmail
  });
    // 处理响应数据
  return response as DataResponse;;
}

export async function checkCode( email: string | null,verificationCode: string | null): Promise<DataResponse> {
  const res = await generalRequest("/api/vetification/checkCode", {
    email:email,
    verificationCode:verificationCode
  });
  return res as DataResponse;
}


