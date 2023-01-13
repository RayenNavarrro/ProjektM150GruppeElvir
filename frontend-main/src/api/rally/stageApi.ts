import type { AxiosResponse, AxiosError } from "axios";
import { Stage } from "../../models/rally/stage";
import BaseApi from "../baseApi";

class StageApi extends BaseApi {
  public getAll(): Promise<Stage[]> {
    return this.get<Stage[]>("rally/v1/stage")
      .then<Stage[]>(StageApi.then)
      .catch<Stage[]>(StageApi.catch);
  }

  public getStage(stageId: String): Promise<Stage> {
    return this.get<Stage>(`rally/v1/stage/${stageId}`)
      .then<Stage>(StageApi.then)
      .catch<Stage>(StageApi.catch);
  }

  public create(stage: Partial<Stage>): Promise<Stage> {
    return this.post<Stage>("rally/v1/stage", JSON.stringify(stage))
      .then<Stage>(StageApi.then)
      .catch<Stage>(StageApi.catch);
  }

  private static then<T>(response: AxiosResponse<T>) {
    return response.data;
  }

  private static catch<T>(error: AxiosError): T {
    throw error;
  }
}

export const stageApi = new StageApi();
