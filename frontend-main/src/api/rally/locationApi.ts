import type { AxiosResponse, AxiosError } from "axios";
import { Location } from "../../models/rally/location";
import BaseApi from "../baseApi";

class LocationApi extends BaseApi {
  public getGloballyAll(): Promise<Location[]> {
    return this.get<Location[]>(`rally/v1/location`)
      .then<Location[]>(LocationApi.then)
      .catch<Location[]>(LocationApi.catch);
  }

  public getAll(stageId: string): Promise<Location[]> {
    return this.get<Location[]>(`rally/v1/stage/${stageId}/location`)
      .then<Location[]>(LocationApi.then)
      .catch<Location[]>(LocationApi.catch);
  }

  public create(
    stageId: string,
    location: Partial<Location>
  ): Promise<Location> {
    return this.post<Location>(
      `rally/v1/stage/${stageId}/location`,
      JSON.stringify(location)
    )
      .then<Location>(LocationApi.then)
      .catch<Location>(LocationApi.catch);
  }

  public update(stageId: string, location: Location): Promise<Location> {
    return this.put<Location>(
      `rally/v1/stage/${stageId}/location`,
      JSON.stringify(location)
    )
      .then<Location>(LocationApi.then)
      .catch<Location>(LocationApi.catch);
  }

  public remove(stageId: string, locationId: string): Promise<void> {
    return this.delete<void>(`rally/v1/stage/${stageId}/location/${locationId}`)
      .then<void>(LocationApi.then)
      .catch<void>(LocationApi.catch);
  }

  private static then<T>(response: AxiosResponse<T>) {
    return response.data;
  }

  private static catch<T>(error: AxiosError): T {
    throw error;
  }
}

export const locationApi = new LocationApi();
