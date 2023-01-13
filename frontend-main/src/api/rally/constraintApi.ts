import type { AxiosResponse, AxiosError } from "axios";
import { Constraint, Rally, RallyStage } from "../../models/rally/rally";
import BaseApi from "../baseApi";

class ConstraintApi extends BaseApi {
  public getAll(rallyId: string, rallyStageId: string): Promise<Constraint[]> {
    return this.get<Constraint[]>(
      `rally/v1/rally/${rallyId}/stage/${rallyStageId}/constraint`
    )
      .then<Constraint[]>(ConstraintApi.then)
      .catch<Constraint[]>(ConstraintApi.catch);
  }

  public getConstraint(
    rallyId: String,
    rallyStageId: string,
    constraintId: string
  ): Promise<Constraint> {
    return this.get<Constraint>(
      `rally/v1/rally/${rallyId}/stage/${rallyStageId}/constraint/${constraintId}`
    )
      .then<Constraint>(ConstraintApi.then)
      .catch<Constraint>(ConstraintApi.catch);
  }

  public create(
    rallyId: string,
    rallyStageId: string,
    constraint: Partial<Constraint>
  ): Promise<Constraint> {
    return this.post<Constraint>(
      `rally/v1/rally/${rallyId}/stage/${rallyStageId}/constraint`,
      JSON.stringify(constraint)
    )
      .then<Constraint>(ConstraintApi.then)
      .catch<Constraint>(ConstraintApi.catch);
  }

  public remove(
    rallyId: string,
    rallyStageId: string,
    constraintId: string
  ): Promise<void> {
    return this.delete<void>(
      `rally/v1/rally/${rallyId}/stage/${rallyStageId}/constraint/${constraintId}`
    )
      .then<void>(ConstraintApi.then)
      .catch<void>(ConstraintApi.catch);
  }

  private static then<T>(response: AxiosResponse<T>) {
    return response.data;
  }

  private static catch<T>(error: AxiosError): T {
    throw error;
  }
}

export const constraintApi = new ConstraintApi();
