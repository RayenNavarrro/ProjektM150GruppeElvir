import type { AxiosResponse, AxiosError } from "axios";
import { Rally, RallyStage } from "../../models/rally/rally";
import BaseApi from "../baseApi";

class RallyApi extends BaseApi {
  public getAll(): Promise<Rally[]> {
    return this.get<Rally[]>("rally/v1/rally")
      .then<Rally[]>(RallyApi.then)
      .catch<Rally[]>(RallyApi.catch);
  }

  public getRally(rallyId: String): Promise<Rally> {
    return this.get<Rally>(`rally/v1/rally/${rallyId}`)
      .then<Rally>(RallyApi.then)
      .catch<Rally>(RallyApi.catch);
  }

  public create(rally: Partial<Rally>): Promise<Rally> {
    return this.post<Rally>("rally/v1/rally", JSON.stringify(rally))
      .then<Rally>(RallyApi.then)
      .catch<Rally>(RallyApi.catch);
  }

  public getRallyStage(
    rallyId: string,
    rallyStageId: string
  ): Promise<RallyStage> {
    return this.get<RallyStage>(
      `rally/v1/rally/${rallyId}/stage/${rallyStageId}`
    )
      .then<RallyStage>(RallyApi.then)
      .catch<RallyStage>(RallyApi.catch);
  }

  public addRallyStage(
    rallyId: string,
    rallyStage: RallyStage
  ): Promise<RallyStage> {
    return this.post<RallyStage>(
      `rally/v1/rally/${rallyId}/stage`,
      JSON.stringify(rallyStage)
    )
      .then<RallyStage>(RallyApi.then)
      .catch<RallyStage>(RallyApi.catch);
  }

  public deleteRallyStage(
    rallyId: string,
    rallyStageId: string
  ): Promise<void> {
    return this.delete<void>(`rally/v1/rally/${rallyId}/stage/${rallyStageId}`)
      .then<void>(RallyApi.then)
      .catch<void>(RallyApi.catch);
  }

  private static then<T>(response: AxiosResponse<T>) {
    return response.data;
  }

  private static catch<T>(error: AxiosError): T {
    throw error;
  }
}

export const rallyApi = new RallyApi();
