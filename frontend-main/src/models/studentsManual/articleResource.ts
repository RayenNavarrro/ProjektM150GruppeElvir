export enum AttachmentType {
  link = <any>"link",
  video = <any>"video",
  pdf = <any>"pdf",
}

export class Attachment {
  id: string;
  title: string;
  url: string;
  type: AttachmentType;

  constructor(id: string, title: string, url: string, type: AttachmentType) {
    this.id = id;
    this.title = title;
    this.url = url;
    this.type = type;
  }
}
