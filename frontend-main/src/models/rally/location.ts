import { LocationMarker } from "./locationMarker";

export class Location {
  id: string;
  title: string;
  locationMarkers: LocationMarker[];

  constructor(id: string, title: string, locationMarkers: LocationMarker[]) {
    this.id = id;
    this.title = title;
    this.locationMarkers = locationMarkers;
  }
}
