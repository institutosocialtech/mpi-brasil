import 'dart:convert';

import 'package:diacritic/diacritic.dart';
import 'package:http/http.dart' as http;
import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'package:mpibrasil/models/keyword.dart';
import 'package:mpibrasil/providers/auth_provider.dart';
import 'package:mpibrasil/providers/auth_state.dart';

part 'keywords_provider.g.dart';

@Riverpod(keepAlive: true)
class KeywordsNotifier extends _$KeywordsNotifier {
  static const _baseUrl = 'https://api-staging.mpibrasil.dev';

  @override
  Future<List<Keyword>> build() async {
    return [];
  }

  String? get _authToken {
    final authState = ref.read(authNotifierProvider).valueOrNull;

    if (authState is Authenticated) {
      return authState.token;
    }

    return null;
  }

  Future<void> fetchKeywordsFromDB({bool force = false}) async {
    final currentKeywords = state.valueOrNull ?? [];

    if (!force && currentKeywords.isNotEmpty) {
      return;
    }

    final token = _authToken;
    if (token == null) return;

    final uri = Uri.parse('$_baseUrl/v2_0_0/pt/keywords.json');

    final response = await http.get(
      uri,
      headers: {'Authorization': 'Bearer $token'},
    );

    if (response.statusCode != 200) {
      throw Exception(
        'Erro ao buscar palavras-chave: '
        '${response.statusCode} - ${response.body}',
      );
    }

    final data = json.decode(response.body) as Map<String, dynamic>;

    final List<Keyword> loadedKeywords = [];

    data.forEach((keywordId, value) {
      final keywordData = Map<String, dynamic>.from(value as Map);
      keywordData['id'] = keywordId;

      loadedKeywords.add(Keyword.fromJson(keywordData));
    });

    loadedKeywords.sort(
      (a, b) => removeDiacritics(
        a.word,
      ).toUpperCase().compareTo(removeDiacritics(b.word).toUpperCase()),
    );

    state = AsyncData(loadedKeywords);
  }

  List<Keyword> get keywords => state.valueOrNull ?? [];

  void reset() {
    state = const AsyncData([]);
  }
}
