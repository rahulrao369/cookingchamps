import 'dart:convert' as convert;
import 'dart:convert';
import 'dart:io';

import 'package:cooking_champs/constant/apiConnectorConstants.dart';
import 'package:cooking_champs/constant/stringfile.dart/all_key.dart';
import 'package:cooking_champs/constant/stringfile.dart/locale_constant.dart';
import 'package:cooking_champs/services/api_path.dart';
import 'package:cooking_champs/services/user_prefences.dart';
import 'package:cooking_champs/utils/all_dialogs.dart';
import 'package:cooking_champs/utils/utility.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:mime/mime.dart';

class HttpServices {
  // Utility function to convert model to Map if it's not already a Map
  static Map<String, dynamic> toMap(dynamic data) {
    if (data is Map<String, dynamic>) {
      return data;
    } else {
      return data.toJson(); // Assuming `ModelRequest` has a `toJson()` method
    }
  }

  /// Old Code
  // static Future<dynamic> getDataObjectFromAPI(
  //     BuildContext context, String url, bool load) async {
  //   final language = await PreferencesServices.getPreferencesData(
  //           prefSelectedLanguageCode) ??
  //       "en";
  //   ApiConnectorConstants.accessToken =
  //       await PreferencesServices.getPreferencesData(
  //               PreferencesServices.userToken) ??
  //           "";
  //
  //   debugPrint(
  //       "url.....${'${ApiPath.baseUrl}$url'}....${ApiConnectorConstants.accessToken}");
  //   try {
  //     if (context.mounted) {
  //       load ? AllDialogs.progressLoadingDialog(context, true) : null;
  //     }
  //     var headers = {
  //       "Accept": "application/json",
  //       "X-CLIENT": ApiConnectorConstants.apiKey
  //     };
  //
  //     if (language.isNotEmpty) {
  //       headers.addAll({"Accept-Language": language});
  //     }
  //     if (ApiConnectorConstants.accessToken.isNotEmpty) {
  //       headers.addAll(
  //           {"Authorization": "Bearer ${ApiConnectorConstants.accessToken}"});
  //     }
  //     var response =
  //         await http.get(Uri.parse('${ApiPath.baseUrl}$url'), headers: headers);
  //     if (context.mounted) {
  //       load ? AllDialogs.progressLoadingDialog(context, false) : null;
  //     }
  //     var jsonResponse = convert.jsonDecode(response.body);
  //     debugPrint("jsonResponse.......${response.statusCode}");
  //     if (response.statusCode == 200) {
  //       return jsonResponse;
  //     } else {
  //       Utility.userNotExit(context, jsonResponse['message'].toString());
  //     }
  //   } on SocketException catch (e) {
  //     print("e$e");
  //     throw Exception(e);
  //   }
  //   return;
  // }

  /// New Code (Vaibhav)
  static Future<dynamic> getDataObjectFromAPI(
      BuildContext context,
      String url,
      bool load,
      ) async {
    final language =
        await PreferencesServices.getPreferencesData(prefSelectedLanguageCode) ??
            "en";

    ApiConnectorConstants.accessToken =
        await PreferencesServices.getPreferencesData(
            PreferencesServices.userToken) ??
            "";

    debugPrint(
        "URL => ${ApiPath.baseUrl}$url\nTOKEN => ${ApiConnectorConstants.accessToken}");

    try {
      if (context.mounted && load) {
        AllDialogs.progressLoadingDialog(context, true);
      }

      final headers = <String, String>{
        "Accept": "application/json",
        "X-CLIENT": ApiConnectorConstants.apiKey,
        "Accept-Language": language,
        if (ApiConnectorConstants.accessToken.isNotEmpty)
          "Authorization": "Bearer ${ApiConnectorConstants.accessToken}",
      };

      final response =
      await http.get(Uri.parse('${ApiPath.baseUrl}$url'), headers: headers);

      if (context.mounted && load) {
        AllDialogs.progressLoadingDialog(context, false);
      }

      debugPrint("STATUS CODE => ${response.statusCode}");
      debugPrint(
          "RAW RESPONSE => ${response.body.substring(0, response.body.length > 200 ? 200 : response.body.length)}");

      // ❌ HTML RESPONSE PROTECTION
      final contentType = response.headers['content-type'] ?? "";
      if (!contentType.contains("application/json")) {
        throw Exception("Server returned non-JSON response");
      }

      // ✅ Decode ONLY when safe
      final jsonResponse = convert.jsonDecode(response.body);

      if (response.statusCode == 200) {
        return jsonResponse;
      } else if (response.statusCode == 401) {
        Utility.userNotExit(context, "Session expired, please login again");
        return null;
      } else {
        Utility.userNotExit(
          context,
          jsonResponse['message']?.toString() ?? "Something went wrong",
        );
        return null;
      }
    } on SocketException catch (e) {
      debugPrint("SocketException => $e");
      throw Exception(e);
    } on FormatException catch (e) {
      debugPrint("FormatException => $e");
      throw Exception("Invalid server response");
    } catch (e) {
      debugPrint("Unknown Exception => $e");
      throw Exception(e);
    }
  }


  static Future<dynamic> deleteApi(
      BuildContext context, String url, bool successStatus) async {
    final language = await PreferencesServices.getPreferencesData(
            prefSelectedLanguageCode) ??
        "en";
    ApiConnectorConstants.accessToken =
        await PreferencesServices.getPreferencesData(
                PreferencesServices.userToken) ??
            "";
    if (context.mounted) {
      successStatus ? AllDialogs.progressLoadingDialog(context, true) : null;
    }
    try {
      var headers = {
        "Accept": "application/json",
        "Content-type": 'application/json',
        "X-CLIENT": ApiConnectorConstants.apiKey
      };

      if (language.isNotEmpty) {
        headers.addAll({"Accept-Language": language});
      }
      if (ApiConnectorConstants.accessToken.isNotEmpty) {
        headers.addAll(
            {"Authorization": "Bearer ${ApiConnectorConstants.accessToken}"});
      }

      var request = http.Request('DELETE', Uri.parse('${ApiPath.baseUrl}$url'));
      if (ApiConnectorConstants.accessToken.isNotEmpty) {
        request.headers.addAll(
            {"Authorization": "Bearer ${ApiConnectorConstants.accessToken}"});
      }
      request.headers.addAll(headers);

      http.StreamedResponse response = await request.send();
      if (context.mounted) {
        successStatus ? AllDialogs.progressLoadingDialog(context, false) : null;
      }
      if (response.statusCode == 200) {
        String responseString = await response.stream.bytesToString();

        var jsonResponse = json.decode(responseString);

        return jsonResponse;
      }
    } on SocketException catch (e) {
      debugPrint("e......$e");
      throw Exception(e);
    }
    return;
  }

  static Future<dynamic> postApi(
      BuildContext context, String url, dynamic requestModel, bool load) async {
    final language = await PreferencesServices.getPreferencesData(
            prefSelectedLanguageCode) ??
        "en";
    ApiConnectorConstants.accessToken =
        await PreferencesServices.getPreferencesData(
                PreferencesServices.userToken) ??
            "";
    final requestData =
        toMap(requestModel); // Convert data to Map if it's a model
    try {
      if (context.mounted) {
        load ? AllDialogs.progressLoadingDialog(context, true) : null;
      }
      var headers = {
        "Accept": "application/json",
        "Content-type": 'application/json',
        "X-CLIENT": ApiConnectorConstants.apiKey
      };

      if (language.isNotEmpty) {
        headers.addAll({"Accept-Language": language});
      }
      if (ApiConnectorConstants.accessToken.isNotEmpty) {
        headers.addAll(
            {"Authorization": "Bearer ${ApiConnectorConstants.accessToken}"});
      }
      var request = http.Request('POST', Uri.parse('${ApiPath.baseUrl}$url'));
      debugPrint('${ApiPath.baseUrl}$url');
      request.body = json.encode(requestData);
      request.headers.addAll(headers);
      debugPrint("Request.......${json.encode(requestData)}");
      http.StreamedResponse response = await request.send();

      String responseString = await response.stream.bytesToString();
      if (context.mounted) {
        load ? AllDialogs.progressLoadingDialog(context, false) : null;
      }
      if (response.statusCode == 200) {
        var jsonResponse = json.decode(responseString);
        debugPrint("Response.......$jsonResponse");
        return jsonResponse;
      } else if (response.statusCode == 401 || response.statusCode == 400) {
        var jsonResponse = json.decode(responseString);
        Utility.userNotExit(context, jsonResponse['message'].toString());
        return jsonResponse;
      }
    } on SocketException catch (e) {
      debugPrint("e......$e");
      throw Exception(e);
    }
    return;
  }

  ///--------------Multipart Method-----------------------

  static Future<dynamic> multiPartMethod(
      BuildContext context,
      String url,
      Map<String, dynamic> body,
      var image,
      var images,
      bool load,
      String type,
      String key) async {
    final language = await PreferencesServices.getPreferencesData(
            prefSelectedLanguageCode) ??
        "en";
    ApiConnectorConstants.accessToken =
        await PreferencesServices.getPreferencesData(
                PreferencesServices.userToken) ??
            "";
    try {
      var headers = {
        "Accept": "application/json",
        "X-CLIENT": ApiConnectorConstants.apiKey
      };

      if (language.isNotEmpty) {
        headers.addAll({"Accept-Language": language});
      }
      if (ApiConnectorConstants.accessToken.isNotEmpty) {
        headers.addAll(
            {"Authorization": "Bearer ${ApiConnectorConstants.accessToken}"});
      }
      if (context.mounted && load) {
        AllDialogs.progressLoadingDialog(context, true);
      }

      var apiUrl = Uri.parse('${ApiPath.baseUrl}$url');
      var request = http.MultipartRequest('POST', apiUrl);

      // Convert body to Map<String, String>
      request.fields.addAll(body.map((key, value) => MapEntry(key, value.toString())));
      request.headers.addAll(headers);
      debugPrint(" request.fields..${request.fields}");
      debugPrint(" request.fields..${request.headers}");

      if (type == "list" && image.isNotEmpty) {
        debugPrint("image List..${image}");
        for (var img in image) {
          uploadImage(img, request, key);
        }
      } else if (image != null) {
        debugPrint("image ..${image}");
        uploadImage(image, request, key);
      }

      if (images.isNotEmpty) {
        for (int i = 0; images.length > i; i++) {
          uploadImages(images[i], request, i);
        }
      }

      var response = await request.send();

      if (context.mounted && load) {
        AllDialogs.progressLoadingDialog(context, false);
      }
      String responseString = await response.stream.bytesToString();
      var jsonResponse = json.decode(responseString);

      return jsonResponse;
    } on SocketException catch (e) {
      AllDialogs.progressLoadingDialog(context, false);
      throw Exception(e);
    } finally {
      // Optionally close dialogs if needed
    }
  }

  static uploadImage(var img, var request, String key) async {
    debugPrint("__${img.path.split("-").last}");
    var stream = http.ByteStream(img.openRead());
    var length = await img.length();
    var contentType = lookupMimeType(img.path) ?? 'image/jpeg';
    print("img.path.split>>>${img.path.split("-").last}");
    request.files.add(http.MultipartFile(
      key == "banner" ? AllKeys.bannerImage : AllKeys.image,
      stream,
      length,
      filename: "Image__${img.path.split("-").last}",
      contentType: MediaType.parse(contentType),
    ));
  }

  static uploadImages(var img, var request, int index) async {
    debugPrint("__${img.path.split("-").last}");
    var stream = http.ByteStream(img.openRead());
    var length = await img.length();
    var contentType = lookupMimeType(img.path) ?? 'image/jpeg';
    request.files.add(http.MultipartFile(
      "${AllKeys.images}[$index]",
      stream,
      length,
      filename: "Image__${img.path.split("-").last}",
      contentType: MediaType.parse(contentType),
    ));
  }
}
