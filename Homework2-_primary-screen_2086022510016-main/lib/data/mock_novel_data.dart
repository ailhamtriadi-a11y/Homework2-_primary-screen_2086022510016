final List<Map<String, dynamic>> mockNovelLogs = [
  {
    'id': '1',
    'titleEnglish': 'Conan: Being a Crazy Traitor in a Winery',
    'titleOriginal': '柯南：在酒厂当一个疯批二五仔',
    'author': '狂笑三杰',
    'status': 'Reading',
    'currentChapter': 824,
    'ratingValue': 4.7,
    'imagePlaceholder': 'LotM',
    'imageUrl': '',
    'mcName': 'Kamiya Minazuki',
    'mcPersonality': 'Gila, Anarkis, penyayang, semakin kacau semakin baik',
    'mcAbilities': 'Mengeluarkan berbagai senjata militer dimana saja kapan saja ( dimentional pocket)',
    'worldLore': 'Dunia Conan dimana ada conan disana ada kematian dengan juga cuaca yang berubah terlalu drastic yang tidak nyata.',
    'nextExpectation': 'Filler cerita dimana ran dan temannya ketakutan dengan vampir?, sebelum perang dimulai.',
    'dropReason': null,
    'isSaved': true,
  },
  {
    'id': '2',
    'titleEnglish': 'Bone King: Welcome the Birth of the King',
    'titleOriginal': '骨王：恭迎王的诞生',
    'author': '大赦天下L',
    'status': 'Reading',
    'currentChapter': 777,
    'ratingValue': 4.8,
    'imagePlaceholder': 'SL',
    'imageUrl': '',
    'mcName': 'Tang Zheng',
    'mcPersonality': 'Tenang, dingin terhadap musuh, Berhati-hati ketitik paranoid',
    'mcAbilities': 'Penguasa 1 guild , penguasa 3 negara dengan 1 sebagai sekutu , 4 pemain level 100 , 2 Npc level 80 , 1 Npc 70',
    'worldLore': 'Dunia abad pertengahan dimana naga berkuasa walaupun sempat dikuasai beberapa kali oleh pemain yang menyebabkan dunianya lebih berkembang',
    'nextExpectation': 'Kelanjutan Perang nazarick dengan bantuan para naga dan re-tize kingdom sebagai medan perang utama',
    'isSaved': false,
  },
  {
    'id': '3',
    'titleEnglish': 'My Superpower is Piloting Magical Girl Corpses?',
    'titleOriginal': '我的超能力是驾驶魔法少女的尸体？',
    'author': ' 成年阿冰',
    'status': 'Reading',
    'currentChapter': 498,
    'ratingValue': 4.8,
    'imagePlaceholder': 'SS',
    'imageUrl': '',
    'mcName': 'Lin Guang',
    'mcPersonality': 'Tenang, Rational, Gila berkorban',
    'mcAbilities': 'Hacker, Pemanfaatan kekuatan dengan terlalu presisi',
    'worldLore': 'Dunia modern dengan adanya kekuatan supernatural yang muncul secara tiba-tiba dan mengubah kehidupan manusia walaupun masih ditahan dengan dunianya',
    'nextExpectation': 'Kelanjutan gadis penyihir W vs gadis kelinci di pabrik pembuatan narkotika',
    'dropReason': null,
    'isSaved': true,
  },
  {
    'id': '4',
    'titleEnglish': 'Reverend Insanity',
    'titleOriginal': '蛊真人',
    'author': 'Gu Zhen Ren',
    'status': 'Finished',
    'currentChapter': 0,
    'ratingValue': 4.9,
    'imagePlaceholder': 'RI',
    'imageUrl': '',
    'mcName': 'Fang Yuan',
    'mcPersonality': 'Kejam, rasional tanpa batas, pantang menyerah',
    'mcAbilities': 'Spring Autumn Cicada, Gu Cultivation',
    'worldLore': 'Dunia Gu Master di mana serangga ajaib digunakan sebagai sumber kekuatan.',
    'nextExpectation': 'Selesai dibaca (ending menyesal karena belum ada kelanjutan cerita)',
    'dropReason': null,
    'isSaved': false,
  },
  {
    'id': '5',
    'titleEnglish': 'Star Rail Simulation, But Fate is a Madman',
    'titleOriginal': '星铁模拟， Spanish命途颠佬',
    'author': '天气真好',
    'status': 'Completed',
    'currentChapter': 342,
    'ratingValue': 4.6,
    'imagePlaceholder': 'SR',
    'imageUrl': '',
    'mcName': 'Bai Ge',
    'mcPersonality': 'Gila',
    'mcAbilities': 'Cone berbagai jenis yang bisa menghancurkan peradaban',
    'worldLore': 'Dunia yang dipenuhi dengan teknologi canggih dan kekuatan supernatural.',
    'nextExpectation': 'Permainan yang pemenangnya bakal bisa menjadi Aeon',
    'dropReason': null,
    'isSaved': true,
  },
];

List<Map<String, dynamic>> getLargeMockNovelLogs({int count = 500}) {
  final prefixes = ['Shadow', 'Celestial', 'Immortal', 'Reborn', 'Supreme', 'Abyssal', 'Infinite', 'Divine'];
  final nouns = ['Sovereign', 'Alchemist', 'Necromancer', 'Architect', 'Monarch', 'Vanguard', 'Dominator', 'Scholar'];
  final authors = ['Er Gen', 'I Eat Tomatoes', 'Tango Jia San', 'Cocooned Butterfly', 'Heavenly Silkworm Potato'];
  final statuses = ['Reading', 'Completed', 'Plan to Read', 'Dropped'];

  return List.generate(count, (i) {
    if (i < mockNovelLogs.length) {
      final base = Map<String, dynamic>.from(mockNovelLogs[i]);
      return {
        ...base,
        'mcCharacteristics': {
          'name': base['mcName'] ?? '-',
          'personality': base['mcPersonality'] ?? '-',
          'abilities': base['mcAbilities'] ?? '-',
        },
        'worldLoreHistory': [
          {'version': 'v1.0', 'lore': base['worldLore'] ?? '-'}
        ],
      };
    }

    final p = prefixes[i % prefixes.length];
    final n = nouns[(i * 3) % nouns.length];
    final titleEng = '$p $n $i';
    final placeholder = titleEng.length >= 3 ? titleEng.substring(0, 3).toUpperCase() : 'NVL';

    return {
      'id': '${i + 1}',
      'titleEnglish': titleEng,
      'titleOriginal': '神魔秘境 $i',
      'author': authors[i % authors.length],
      'status': statuses[i % statuses.length],
      'currentChapter': 100 + (i * 7) % 900,
      'ratingValue': double.parse((3.5 + (i % 16) * 0.1).toStringAsFixed(1)),
      'imagePlaceholder': placeholder,
      'imageUrl': '',
      'isSaved': i % 3 == 0,
      'mcCharacteristics': {'name': 'MC Hero $i', 'personality': 'Strategic & Cold', 'abilities': 'Elemental Mastery'},
      'worldLoreHistory': [{'version': 'v1.0', 'lore': 'World with magic towers and ancient dungeons.'}],
    };
  });
}