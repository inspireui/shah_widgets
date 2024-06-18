import 'package:shah_widgets/shah_widgets.dart';
import 'dart:convert' as convert;

import '../entities/coupon.dart';
import 'package:http/http.dart' as http;

class CouponService {
  static String get domain => ShahWidgets.component.domain;

  static Future<List<ShahCoupon>> getShahCoupons() async {
    try {
      var coupons = <ShahCoupon>[];
      var endPoint = '$domain/wp-json/wp/v2/shah_coupon';
      final response = await http.get(Uri.parse(endPoint));
      final body = convert.jsonDecode(response.body);
      if (body is List) {
        for (var item in body) {
          coupons.add(ShahCoupon.fromJson(item));
        }
      }
      return coupons;
    } catch (e) {
      return [];
    }
  }

  static Future<List<ShahCoupon>> getFavoriteShahCoupons(String cookie) async {
    try {
      var coupons = <ShahCoupon>[];
      var endPoint = '$domain/wp-json/wc/v3/coupon/favorite/list';
      final response = await http.get(
        Uri.parse(endPoint),
        headers: {'User-Cookie': cookie},
      );
      final body = convert.jsonDecode(response.body);
      if (body is List) {
        for (var item in body) {
          coupons.add(ShahCoupon.fromJson(item));
        }
      }
      return coupons;
    } catch (e) {
      return [];
    }
  }

  static Future<Map> shahCouponAction({
    required String id,
    required CouponAction action,
    required String cookie,
  }) async {
    try {
      var endPoint = '$domain/wp-json/wc/v3/coupon/';
      switch (action) {
        case CouponAction.like:
          endPoint += 'like';
          break;
        case CouponAction.unlike:
          endPoint += 'unlike';
          break;
        case CouponAction.favorite:
          endPoint += 'favorite';
          break;
        case CouponAction.status:
          endPoint += 'actions/list?coupon_id=$id';
        default:
      }
      http.Response response;
      var headers = {'User-Cookie': cookie};
      if (action == CouponAction.status) {
        response = await http.get(
          Uri.parse(endPoint),
          headers: headers,
        );
      } else {
        response = await http.post(
          Uri.parse(endPoint),
          body: {'coupon_id': id},
          headers: headers,
        );
      }
      final body = convert.jsonDecode(response.body);
      if (body is Map && body['data'] is Map) {
        return Map.from(body['data']);
      }
      return {};
    } catch (e) {
      return {};
    }
  }
}
