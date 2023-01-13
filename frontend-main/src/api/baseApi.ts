import type { AxiosRequestConfig, AxiosResponse } from "axios";
import axiosInstance from "./axios";

export default class BaseApi {
  public get<T, R = AxiosResponse<T>>(
    url: string,
    config?: AxiosRequestConfig
  ): Promise<R> {
    return axiosInstance.get(url, config);
  }

  public post<T, R = AxiosResponse<T>>(
    url: string,
    data?: string,
    config?: AxiosRequestConfig
  ): Promise<R> {
    return axiosInstance.post(url, data, config);
  }

  public postFile<T, R = AxiosResponse<T>>(
    url: string,
    data: FormData,
    config?: AxiosRequestConfig
  ): Promise<R> {
    return axiosInstance.post(url, data, config);
  }

  public put<T, R = AxiosResponse<T>>(
    url: string,
    data?: string,
    config?: AxiosRequestConfig
  ): Promise<R> {
    return axiosInstance.put(url, data, config);
  }

  public delete<T, R = AxiosResponse<T>>(
    url: string,
    config?: AxiosRequestConfig
  ): Promise<R> {
    return axiosInstance.delete(url, config);
  }
}
