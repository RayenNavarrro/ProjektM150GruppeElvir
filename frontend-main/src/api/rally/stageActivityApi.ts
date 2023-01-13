import type { AxiosResponse, AxiosError } from "axios";
import { StageActivity } from "../../models/rally/stageActivity";
import BaseApi from "../baseApi";

class StageActivityApi extends BaseApi {
  public getAll(stageId: string): Promise<StageActivity[]> {
    return this.get<StageActivity[]>(`rally/v1/stage/${stageId}/activity`)
      .then<StageActivity[]>(StageActivityApi.then)
      .catch<StageActivity[]>(StageActivityApi.catch);
  }

  public create(
    stageId: string,
    stageActivity: Partial<StageActivity>
  ): Promise<StageActivity> {
    return this.post<StageActivity>(
      `rally/v1/stage/${stageId}/activity`,
      JSON.stringify(stageActivity)
    )
      .then<StageActivity>(StageActivityApi.then)
      .catch<StageActivity>(StageActivityApi.catch);
  }

  public update(
    stageId: string,
    stageActivity: StageActivity
  ): Promise<StageActivity> {
    return this.put<StageActivity>(
      `rally/v1/stage/${stageId}/activity`,
      JSON.stringify(stageActivity)
    )
      .then<StageActivity>(StageActivityApi.then)
      .catch<StageActivity>(StageActivityApi.catch);
  }

  public remove(stageId: string, stageActivityId: string): Promise<void> {
    return this.delete<void>(
      `rally/v1/stage/${stageId}/activity/${stageActivityId}`
    )
      .then<void>(StageActivityApi.then)
      .catch<void>(StageActivityApi.catch);
  }

  private static then<T>(response: AxiosResponse<T>) {
    return response.data;
  }

  private static catch<T>(error: AxiosError): T {
    throw error;
  }
}

export const stageActivityApi = new StageActivityApi();
