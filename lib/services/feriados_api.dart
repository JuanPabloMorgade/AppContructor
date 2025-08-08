import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/feriados.dart';

class FeriadosApi {
  static const _base =
      'https://rrhh-notificaciones-dev.web.app/api/feriados/listado';

  static Future<FeriadosResponse> fetch({
    int limit = 25,
    int page = 1,
    String estado = 'todos', // 'activos' | 'inactivos' | 'todos'
  }) async {
    final uri = Uri.parse(_base).replace(
      queryParameters: {'limit': '$limit', 'page': '$page', 'estado': estado},
    );

    final res = await http.get(uri, headers: {'Accept': 'application/json'});

    if (res.statusCode != 200) {
      throw Exception('Error ${res.statusCode}: ${res.body}');
    }

    final Map<String, dynamic> data = json.decode(res.body);
    return FeriadosResponse.fromJson(data);
  }
}
