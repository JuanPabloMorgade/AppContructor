import 'package:flutter/material.dart';
import '../models/feriados.dart';
import '../services/feriados_api.dart';

class FeriadosList extends StatefulWidget {
  const FeriadosList({super.key, this.estado = 'todos', this.limit = 25});

  final String estado;
  final int limit;

  @override
  State<FeriadosList> createState() => _FeriadosListState();
}

class _FeriadosListState extends State<FeriadosList> {
  int _page = 1;
  late Future<FeriadosResponse> _future;

  @override
  void initState() {
    super.initState();
    _load();
  }

  void _load() {
    _future = FeriadosApi.fetch(
      page: _page,
      limit: widget.limit,
      estado: widget.estado,
    );
  }

  Future<void> _refresh() async {
    _page = 1;
    setState(_load);
  }

  // --- Helpers de formato (sin intl) ---
  String _pad2(int v) => v.toString().padLeft(2, '0');

  String _formatFechaFeriado(String iso) {
    // Esperamos "YYYY-MM-DD"
    try {
      final dt = DateTime.parse(iso);
      return '${_pad2(dt.day)}/${_pad2(dt.month)}/${dt.year}';
    } catch (_) {
      return iso;
    }
  }

  String _formatFechaCreacion(String millisStr) {
    try {
      final ms = int.parse(millisStr);
      final dt = DateTime.fromMillisecondsSinceEpoch(ms);
      return '${_pad2(dt.day)}/${_pad2(dt.month)}/${dt.year}, ${_pad2(dt.hour)}:${_pad2(dt.minute)}';
    } catch (_) {
      return millisStr;
    }
  }

  void _showFeriadoDialog(FeriadoData f) {
    showDialog(
      context: context,
      builder: (ctx) {
        final colorOk = Colors.green;
        final colorNo = Colors.red;
        final isActivo = f.estado;

        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          contentPadding: const EdgeInsets.fromLTRB(20, 16, 20, 8),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Título
              Row(
                children: [
                  const Icon(Icons.info_outline, size: 25),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      f.denominacion,
                      style: const TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),

              // Fila: Fecha del feriado
              _DetailRow(
                icon: Icons.event,
                label: 'Fecha del feriado:',
                value: _formatFechaFeriado(f.fechaFeriado),
              ),

              // Fila: Ciclo anual
              _DetailRow(
                icon: Icons.date_range,
                label: 'Ciclo anual:',
                value: '${f.ciclo}',
              ),

              // Fila: Creado por
              _DetailRow(
                icon: Icons.person_outline,
                label: 'Creado por:',
                value: f.creadoPor.isEmpty ? '—' : f.creadoPor,
              ),

              // Fila: Fecha de creación
              _DetailRow(
                icon: Icons.calendar_month_outlined,
                label: 'Fecha de creación:',
                value: _formatFechaCreacion(f.fechaCreacion),
              ),

              // Fila: Estado
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(
                    Icons.diversity_1_outlined,
                    size: 18,
                    color: isActivo ? colorOk : colorNo,
                  ),
                  const SizedBox(width: 10),
                  const Text(
                    'Estado:',
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
                  ),
                  const SizedBox(width: 6),
                  Expanded(
                    child: Text(
                      isActivo ? 'Activo' : 'Inactivo',
                      style: TextStyle(
                        fontSize: 14,
                        color: isActivo ? colorOk : colorNo,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 16),
              Align(
                alignment: Alignment.centerRight,
                child: TextButton(
                  onPressed: () => Navigator.of(ctx).pop(),
                  child: const Text(
                    'Cerrar',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<FeriadosResponse>(
      future: _future,
      builder: (context, snap) {
        if (snap.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }
        if (snap.hasError) {
          return Center(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Text('Error: ${snap.error}'),
            ),
          );
        }

        final data = snap.data!;
        final feriados = data.feriados;

        return Column(
          children: [
            Expanded(
              child: RefreshIndicator(
                onRefresh: _refresh,
                child: ListView.separated(
                  physics: const AlwaysScrollableScrollPhysics(),
                  itemCount: feriados.length,
                  separatorBuilder: (_, __) => const Divider(height: 1),
                  itemBuilder: (context, i) {
                    final f = feriados[i];
                    return ListTile(
                      onTap: () => _showFeriadoDialog(f), // 👈 POP UP
                      title: Text(f.denominacion),
                      subtitle: Text(
                        'Fecha: ${_formatFechaFeriado(f.fechaFeriado)} • Ciclo: ${f.ciclo}',
                      ),
                      trailing: Icon(
                        f.estado ? Icons.check_circle : Icons.cancel,
                        color: f.estado ? Colors.green : Colors.red,
                      ),
                    );
                  },
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(12, 8, 12, 12),
              child: Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                      onPressed: data.datosPagina.antPaginado && _page > 1
                          ? () {
                              setState(() {
                                _page--;
                                _load();
                              });
                            }
                          : null,
                      child: const Text('Anterior'),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: data.datosPagina.sigPaginado
                          ? () {
                              setState(() {
                                _page++;
                                _load();
                              });
                            }
                          : null,
                      child: const Text('Siguiente'),
                    ),
                  ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }
}

/// Fila de detalle reutilizable para el popup
class _DetailRow extends StatelessWidget {
  const _DetailRow({
    required this.icon,
    required this.label,
    required this.value,
  });

  final IconData icon;
  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, size: 18, color: Colors.grey.shade800),
          const SizedBox(width: 10),
          const Text(' ', style: TextStyle(fontSize: 14)),
          Text(
            label,
            style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
          ),
          const SizedBox(width: 6),
          Expanded(child: Text(value, style: const TextStyle(fontSize: 14))),
        ],
      ),
    );
  }
}
