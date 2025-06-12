import { BaseMap } from './BaseMap';
import { map, mapCommon, sceneMap, site } from '@kit.MapKit';
import { common } from '@kit.AbilityKit';
import { BusinessError, print } from '@kit.BasicServicesKit';

export interface SelectMapFace{
  // markerClick:(marker: map.Marker)=>void;
}


export class MarkerMap extends BaseMap implements SelectMapFace{

  markerList:Array<map.Marker>  = [];

  constructor(mapController: map.MapComponentController) {
    super(mapController);
    // this.mapEventManager.on("mapClick", this.mapClick);
    this.mapEventManager.on("mapLongClick", this.mapLongClick);
  }

  mapClick:(position: mapCommon.LatLng)=>void = (position: mapCommon.LatLng)=>{
    this.addMarker(position);
  };

  mapLongClick:(position: mapCommon.LatLng)=>void = (position: mapCommon.LatLng)=>{
    this.addMarker(position);
  };

  private addMarker(latLong:mapCommon.LatLng){
    let markerOptions: mapCommon.MarkerOptions = {
      position: latLong,
    };
    this.mapController.addMarker(markerOptions).then((marker)=>{
      // this.markerList.push(marker);
    })
  }

  delMarker(){

  }

  clean(){
    for (let index = 0; index < this.markerList.length; index++) {
      const marker = this.markerList[index];
      marker.remove();
    }
    this.markerList = [];
  }
}