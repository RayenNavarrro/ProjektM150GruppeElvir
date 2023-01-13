import type { AxiosResponse, AxiosError } from "axios";
import { Assignment } from "../../models/rally/assignment";
import BaseApi from "../baseApi";

class AssignmentApi extends BaseApi {
  public getAll(rallyId: string): Promise<Assignment[]> {
    return this.get<Assignment[]>(`rally/v1/rally/${rallyId}/assignment`)
      .then<Assignment[]>(AssignmentApi.then)
      .catch<Assignment[]>(AssignmentApi.catch);
  }

  public getAssignment(
    rallyId: string,
    assignmentId: string
  ): Promise<Assignment> {
    return this.get<Assignment>(
      `rally/v1/rally/${rallyId}/assignment/${assignmentId}`
    )
      .then<Assignment>(AssignmentApi.then)
      .catch<Assignment>(AssignmentApi.catch);
  }

  public create(
    rallyId: string,
    assignment: Partial<Assignment>
  ): Promise<Assignment> {
    return this.post<Assignment>(
      `rally/v1/rally/${rallyId}/assignment`,
      JSON.stringify(assignment)
    )
      .then<Assignment>(AssignmentApi.then)
      .catch<Assignment>(AssignmentApi.catch);
  }

  public remove(rallyId: string, assignmentId: string): Promise<void> {
    return this.delete<void>(
      `rally/v1/rally/${rallyId}/assignment/${assignmentId}`
    )
      .then<void>(AssignmentApi.then)
      .catch<void>(AssignmentApi.catch);
  }

  private static then<T>(response: AxiosResponse<T>) {
    return response.data;
  }

  private static catch<T>(error: AxiosError): T {
    throw error;
  }
}

export const assignmentApi = new AssignmentApi();
