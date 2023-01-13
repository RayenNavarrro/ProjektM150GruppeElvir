import { Attachment } from "./articleResource";

export class Article {
  id: string;
  title: string;
  content: string;
  viewCounter: number;
  attachments: Attachment[];

  constructor(
    id: string,
    title: string,
    content: string,
    viewCounter: number,
    attachments: Attachment[]
  ) {
    this.id = id;
    this.title = title;
    this.content = content;
    this.viewCounter = viewCounter;
    this.attachments = attachments;
  }
}
