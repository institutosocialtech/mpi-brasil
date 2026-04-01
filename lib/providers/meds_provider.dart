import 'dart:convert';

import 'package:diacritic/diacritic.dart';
import 'package:http/http.dart' as http;
import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'package:mpibrasil/models/med.dart';
import 'package:mpibrasil/providers/auth_provider.dart';
import 'package:mpibrasil/providers/auth_state.dart';

part 'meds_provider.g.dart';

@Riverpod(keepAlive: true)
class MedsNotifier extends _$MedsNotifier {
  @override
  Future<List<Med>> build() async {
    return [];
  }

  String? get _authToken {
    final authState = ref.read(authNotifierProvider).valueOrNull;
    if (authState is Authenticated) {
      return authState.token;
    }
    return null;
  }

  Future<void> fetchMedsFromDB({bool force = false}) async {
    final currentMeds = state.valueOrNull ?? [];
    if (!force && currentMeds.isNotEmpty) {
      return;
    }

    final token = _authToken;
    if (token == null) return;

    final url = 'https://mpibrasil.firebaseio.com/v2_0_0/pt/meds.json?auth=$token';

    final uri = Uri.parse(url);
    final response = await http.get(uri);
    final data = json.decode(response.body) as Map<String, dynamic>;

    if (data['error'] != null) {
      return;
    }

    List<Med> loadedMeds = [];

    data.forEach((firebaseId, value) {
      value['id'] = firebaseId;
      loadedMeds.add(Med.fromJson(value));
    });

    loadedMeds.sort((a, b) => removeDiacritics(a.name)
        .toUpperCase()
        .compareTo(removeDiacritics(b.name).toUpperCase()));

    state = AsyncData(loadedMeds);
  }

  Med? findById(String medId) {
    final meds = state.valueOrNull;
    if (meds == null) return null;
    try {
      return meds.firstWhere((element) => element.id == medId);
    } catch (_) {
      return null;
    }
  }

  List<Med> get meds => state.valueOrNull ?? [];

  void reset() {
    state = const AsyncData([]);
  }
}
