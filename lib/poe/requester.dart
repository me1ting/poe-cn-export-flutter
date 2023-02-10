import 'dart:io';

import 'package:http/http.dart' as http;

const testUrl = "https://poe.game.qq.com/trade";
const getCharactersUrl =
    "https://poe.game.qq.com/character-window/get-characters";
const viewProfileUrlPrefix = "https://poe.game.qq.com/account/view-profile/";
const getPassiveSkillUrl =
    "https://poe.game.qq.com/character-window/get-passive-skills";
const getItemsUrl = "https://poe.game.qq.com/character-window/get-items";

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
      var resp = await _client.get(Uri.parse(testUrl));
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
      resp = await _client.post(Uri.parse(getCharactersUrl), body: forumData);
    } catch (err) {
      //network error
      throw HttpRequestException(HttpStatus.badGateway);
    }

    if (resp.statusCode == HttpStatus.ok) {
      return resp.body;
    }

    throw HttpRequestException(resp.statusCode);
  }

  Future<String> viewProfile(String accountName) async {
    http.Response resp;
    try {
      resp = await _client.get(Uri.parse(
          "$viewProfileUrlPrefix${Uri.encodeComponent(accountName)}"));
    } catch (err) {
      //network error
      throw HttpRequestException(HttpStatus.badGateway);
    }

    if (resp.statusCode == HttpStatus.ok) {
      return resp.body;
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
      resp = await _client.post(Uri.parse(getPassiveSkillUrl), body: forumData);
    } catch (err) {
      //network error
      throw HttpRequestException(HttpStatus.badGateway);
    }

    if (resp.statusCode == HttpStatus.ok) {
      return resp.body;
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
      resp = await _client.post(Uri.parse(getItemsUrl), body: forumData);
    } catch (err) {
      //network error
      throw HttpRequestException(HttpStatus.badGateway);
    }

    if (resp.statusCode == HttpStatus.ok) {
      return resp.body;
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
