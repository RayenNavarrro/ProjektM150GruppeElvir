export enum RallyAttachmentType {
  link = <any>"link",
  video = <any>"video",
  pdf = <any>"pdf",
}

export class RallyAttachment {
  id: string;
  title: string;
  url: string;
  type: RallyAttachmentType;

  constructor(
    id: string,
    title: string,
    url: string,
    type: RallyAttachmentType
  ) {
    this.id = id;
    this.title = title;
    this.url = url;
    this.type = type;
  }
}
