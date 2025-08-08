class FeriadoData {
  final String id;
  final int ciclo;
  final String denominacion;
  final String fechaFeriado;
  final String creadoPor;
  final String fechaCreacion;
  final bool estado;

  FeriadoData({
    required this.id,
    required this.ciclo,
    required this.denominacion,
    required this.fechaFeriado,
    required this.creadoPor,
    required this.fechaCreacion,
    required this.estado,
  });

  factory FeriadoData.fromJson(Map<String, dynamic> json) => FeriadoData(
    id: json['id'] ?? '',
    ciclo: (json['ciclo'] is num)
        ? (json['ciclo'] as num).toInt()
        : int.tryParse(json['ciclo']?.toString() ?? '') ?? 0,
    denominacion: json['denominacion'] ?? '',
    fechaFeriado: json['fechaFeriado'] ?? '',
    creadoPor: json['creadoPor'] ?? '',
    fechaCreacion: json['fechaCreacion'] ?? '',
    estado: json['estado'] ?? false,
  );

  Map<String, dynamic> toJson() => {
    'id': id,
    'ciclo': ciclo,
    'denominacion': denominacion,
    'fechaFeriado': fechaFeriado,
    'creadoPor': creadoPor,
    'fechaCreacion': fechaCreacion,
    'estado': estado,
  };
}

class DatosPagina {
  final int datos;
  final bool sigPaginado;
  final bool antPaginado;
  final int totalDatos;

  DatosPagina({
    required this.datos,
    required this.sigPaginado,
    required this.antPaginado,
    required this.totalDatos,
  });

  factory DatosPagina.fromJson(Map<String, dynamic> j) => DatosPagina(
    datos: (j['datos'] as num).toInt(),
    sigPaginado: j['sigPaginado'] as bool,
    antPaginado: j['antPaginado'] as bool,
    totalDatos: (j['totalDatos'] as num).toInt(),
  );
}

class FeriadosResponse {
  final List<FeriadoData> feriados;
  final DatosPagina datosPagina;

  FeriadosResponse({required this.feriados, required this.datosPagina});

  factory FeriadosResponse.fromJson(Map<String, dynamic> j) => FeriadosResponse(
    feriados: (j['feriados'] as List)
        .map((e) => FeriadoData.fromJson(e as Map<String, dynamic>))
        .toList(),
    datosPagina: DatosPagina.fromJson(j['datosPagina']),
  );
}
