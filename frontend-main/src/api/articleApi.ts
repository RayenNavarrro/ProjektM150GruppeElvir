import type { AxiosResponse, AxiosError } from "axios";
import { Article } from "../models/studentsManual/article";
import BaseApi from "./baseApi";

class ArticleApi extends BaseApi {
  public getAll(): Promise<Article[]> {
    return this.get<Article[]>("studentsmanual/v1/article")
      .then<Article[]>(ArticleApi.then)
      .catch<Article[]>(ArticleApi.catch);
  }

  public create(article: Partial<Article>): Promise<Article> {
    return this.post<Article>(
      "studentsmanual/v1/article",
      JSON.stringify(article)
    )
      .then<Article>(ArticleApi.then)
      .catch<Article>(ArticleApi.catch);
  }

  // public update(topicId: Id, topic: Article): Promise<Article> {
  //     return this.put<Article>(`topic/${topicId}`, JSON.stringify(topic))
  //         .then(TopicApi.then)
  //         .catch(TopicApi.catch);
  // }

  // public remove(topicId: Id): Promise<void> {
  //     return this.delete(`topic/${topicId}`);
  // }

  private static then<T>(response: AxiosResponse<T>) {
    return response.data;
  }

  private static catch<T>(error: AxiosError): T {
    throw error;
  }
}

export const articleApi = new ArticleApi();
