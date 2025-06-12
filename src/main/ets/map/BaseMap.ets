import { map, mapCommon, navi, petalMaps, sceneMap } from '@kit.MapKit';
import { site } from '@kit.MapKit';
import { common } from '@kit.AbilityKit';
import { BusinessError } from '@kit.BasicServicesKit';

export interface BaseMapFace{
  mapController: map.MapComponentController;
  mapEventManager: map.MapEventManager;
  toGCJ02(latLong:mapCommon.LatLng):mapCommon.LatLng
  toWGS84(latLong:mapCommon.LatLng):mapCommon.LatLng
}

export interface BaseCanvasFace{

}

export class BaseMap implements BaseMapFace{

  static chooseLocation(position: mapCommon.LatLng):Promise<sceneMap.LocationChoosingResult>{
    let locationChoosingOptions: sceneMap.LocationChoosingOptions = {
      // 地图中心点坐标
      location: position,
      language: 'zh',
      // 展示搜索控件
      searchEnabled: true,
      // 展示附近POI
      showNearbyPoi: true
    };
    return sceneMap.chooseLocation(getContext() as common.UIAbilityContext, locationChoosingOptions);
  }

  static selectDistrict(position: mapCommon.LatLng):Promise<sceneMap.DistrictSelectResult>{
    let districtSelectOptions: sceneMap.DistrictSelectOptions= {
      countryCode: "CN",
      // 使用子窗拉起方式
      subWindowEnabled: true
    };
    // 拉起区划选择页
    return sceneMap.selectDistrict(getContext(), districtSelectOptions)
  }

  // 打开地图导航
  static openMapRoutePlan(target:petalMaps.RoutePlanParams):Promise<void>{
    return petalMaps.openMapRoutePlan(getContext(), target);
  }

  // 开启地图导航
  static openMapNavi(target:petalMaps.NaviParams):Promise<void>{
    return petalMaps.openMapNavi(getContext(), target);
  }

  mapController: map.MapComponentController;
  mapEventManager: map.MapEventManager;
  constructor(mapController: map.MapComponentController) {
    this.mapController = mapController;
    this.mapEventManager = mapController.getEventManager();

  }

  toGCJ02(latLong:mapCommon.LatLng):mapCommon.LatLng{
    return map.convertCoordinateSync(mapCommon.CoordinateType.WGS84, mapCommon.CoordinateType.GCJ02, latLong);
  }

  toWGS84(latLong:mapCommon.LatLng):mapCommon.LatLng{
    return map.convertCoordinateSync(mapCommon.CoordinateType.GCJ02, mapCommon.CoordinateType.WGS84, latLong);
  }

}