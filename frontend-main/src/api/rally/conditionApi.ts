import type { AxiosResponse, AxiosError } from "axios";
import { Condition } from "../../models/rally/rally";
import BaseApi from "../baseApi";

class ConditionApi extends BaseApi {
  public getAll(
    rallyId: string,
    rallyStageId: string,
    constraintId: string
  ): Promise<Condition[]> {
    return this.get<Condition[]>(
      `rally/v1/rally/${rallyId}/stage/${rallyStageId}/constraint/${constraintId}/condition`
    )
      .then<Condition[]>(ConditionApi.then)
      .catch<Condition[]>(ConditionApi.catch);
  }

  public getCondition(
    rallyId: String,
    rallyStageId: string,
    constraintId: string,
    conditionId: string
  ): Promise<Condition> {
    return this.get<Condition>(
      `rally/v1/rally/${rallyId}/stage/${rallyStageId}/constraint/${constraintId}/condition/${conditionId}`
    )
      .then<Condition>(ConditionApi.then)
      .catch<Condition>(ConditionApi.catch);
  }

  public create(
    rallyId: string,
    rallyStageId: string,
    constraintId: string,
    condition: Partial<Condition>
  ): Promise<Condition> {
    return this.post<Condition>(
      `rally/v1/rally/${rallyId}/stage/${rallyStageId}/constraint/${constraintId}/condition`,
      JSON.stringify(condition)
    )
      .then<Condition>(ConditionApi.then)
      .catch<Condition>(ConditionApi.catch);
  }

  public remove(
    rallyId: string,
    rallyStageId: string,
    constraintId: string,
    conditionId: string
  ): Promise<void> {
    return this.delete<void>(
      `rally/v1/rally/${rallyId}/stage/${rallyStageId}/constraint/${constraintId}/condition/${conditionId}`
    )
      .then<void>(ConditionApi.then)
      .catch<void>(ConditionApi.catch);
  }

  private static then<T>(response: AxiosResponse<T>) {
    return response.data;
  }

  private static catch<T>(error: AxiosError): T {
    throw error;
  }
}

export const conditionApi = new ConditionApi();
