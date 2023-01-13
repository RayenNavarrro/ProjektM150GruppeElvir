import { Location } from "./location";
import { RallyAttachment } from "./rallyAttachment";

export class Stage {
  id: string;
  title: string;
  preArrivalInformation: StageInformation;
  information: StageInformation;
  locations: Location[];

  constructor(
    id: string,
    title: string,
    preArrivalInformation: StageInformation,
    information: StageInformation,
    locations: Location[]
  ) {
    this.id = id;
    this.title = title;
    this.preArrivalInformation = preArrivalInformation;
    this.information = information;
    this.locations = locations;
  }
}

export class StageInformation {
  id: string;
  title: string;
  content: string;
  attachments: RallyAttachment[];

  constructor(
    id: string,
    title: string,
    content: string,
    attachments: RallyAttachment[]
  ) {
    this.id = id;
    this.title = title;
    this.content = content;
    this.attachments = attachments;
  }
}
