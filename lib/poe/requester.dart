import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;

const tencentPoeForumHost = "poe.game.qq.com";
const tradePath = "/trade";
const getCharactersPath = "/character-window/get-characters";
const viewProfilePath = "/account/view-profile";
const getPassiveSkillsPath = "/character-window/get-passive-skills";
const getItemsPath = "/character-window/get-items";

var tradeUri = Uri.https(tencentPoeForumHost, tradePath);
var getCharactersUri = Uri.https(tencentPoeForumHost, getCharactersPath);
var getPassiveSkillsUri = Uri.https(tencentPoeForumHost, getPassiveSkillsPath);
var getItemsUri = Uri.http(tencentPoeForumHost, getItemsPath);

/// The POE api-requested [http.Client].
///
/// Request with POESESSID and disable redirect.
class _PoeClient extends http.BaseClient {
  final String _poeSessId;
  final _inner = http.Client();

  _PoeClient(this._poeSessId);

  @override
  Future<http.StreamedResponse> send(http.BaseRequest request) {
    request.headers['Cookie'] = "POESESSID=$_poeSessId";
    request.followRedirects = false;

    return _inner.send(request);
  }

  @override
  void close() {
    _inner.close();
  }
}

class Requester {
  _PoeClient _client;

  set poeSessId(String poeSessId) {
    _client.close();
    _client = _PoeClient(poeSessId);
  }

  Requester(String poeSessId) : _client = _PoeClient(poeSessId);

  /// Test whether the session is valid.
  ///
  /// Return false if a network error occurs.
  Future<bool> isEffectiveSession() async {
    try {
      var resp = await _client.get(tradeUri);
      if (resp.statusCode == HttpStatus.ok) {
        return true;
      }
    } catch (err) {
      //network error
    }

    return false;
  }

  /// Get characters data of a account.
  ///
  /// Throw [HttpRequestException] if a network error occurs.
  ///
  /// Throw [HttpRequestException] if the http status code not equals [HttpStatus.ok].
  Future<String> getCharacters(String accountName, String realm) async {
    var forumData = <String, dynamic>{};
    forumData["accountName"] = accountName;
    forumData["realm"] = realm;

    http.Response resp;
    try {
      resp = await _client.post(getCharactersUri, body: forumData);
    } catch (err) {
      //network error
      throw HttpRequestException(HttpStatus.badGateway);
    }

    if (resp.statusCode == HttpStatus.ok) {
      var contentType = resp.headers["content-type"];
      if (contentType != null && contentType.contains("charset")) {
        return resp.body;
      }
      return utf8.decode(resp.bodyBytes);
    }

    throw HttpRequestException(resp.statusCode);
  }

  Future<String> viewProfile(String accountName) async {
    http.Response resp;
    try {
      resp = await _client.get(Uri.https(tencentPoeForumHost,
          "$viewProfilePath/${Uri.encodeComponent(accountName)}"));
    } catch (err) {
      //network error
      throw HttpRequestException(HttpStatus.badGateway);
    }

    if (resp.statusCode == HttpStatus.ok) {
      var contentType = resp.headers["content-type"];
      if (contentType != null && contentType.contains("charset")) {
        return resp.body;
      }
      return utf8.decode(resp.bodyBytes);
    }

    throw HttpRequestException(resp.statusCode);
  }

  Future<String> getPassiveSkills(
      String accountName, String character, String realm) async {
    var forumData = <String, dynamic>{};
    forumData["accountName"] = accountName;
    forumData["character"] = character;
    forumData["realm"] = realm;

    http.Response resp;
    try {
      resp = await _client.post(getPassiveSkillsUri, body: forumData);
    } catch (err) {
      //network error
      throw HttpRequestException(HttpStatus.badGateway);
    }

    if (resp.statusCode == HttpStatus.ok) {
      var contentType = resp.headers["content-type"];
      if (contentType != null && contentType.contains("charset")) {
        return resp.body;
      }
      return utf8.decode(resp.bodyBytes);
    }

    throw HttpRequestException(resp.statusCode);
  }

  Future<String> getItems(
      String accountName, String character, String realm) async {
    var forumData = <String, dynamic>{};
    forumData["accountName"] = accountName;
    forumData["character"] = character;
    forumData["realm"] = realm;

    http.Response resp;
    try {
      resp = await _client.post(getItemsUri, body: forumData);
    } catch (err) {
      //network error
      throw HttpRequestException(HttpStatus.badGateway);
    }

    if (resp.statusCode == HttpStatus.ok) {
      var contentType = resp.headers["content-type"];
      if (contentType != null && contentType.contains("charset")) {
        return resp.body;
      }
      return utf8.decode(resp.bodyBytes);
    }

    throw HttpRequestException(resp.statusCode);
  }
}

///The [Exception] contains status code and optional message.
class HttpRequestException implements Exception {
  int statusCode;
  String? message;
  HttpRequestException(this.statusCode, {String? message});

  @override
  String toString() {
    return "$statusCode $message";
  }
}
