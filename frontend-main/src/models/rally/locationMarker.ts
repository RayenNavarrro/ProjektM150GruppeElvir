export abstract class LocationMarker {
  id: string;

  constructor(id: string) {
    this.id = id;
  }
}

export class IBeaconLocationMarker extends LocationMarker {
  uuid: string;
  major: number;
  minor: number;

  constructor(id: string, uuid: string, major: number, minor: number) {
    super(id);
    this.uuid = uuid;
    this.major = major;
    this.minor = minor;
  }
}

export class QRCodeLocationMarker extends LocationMarker {
  content: string;

  constructor(id: string, content: string) {
    super(id);
    this.content = content;
  }
}
