import '../models/animal.dart';

class AnimalService {
  static Future<List<Animal>> getAnimals() async {
    await Future.delayed(const Duration(seconds: 2));
    return [
      Animal('Cachorro', 'assets/images/cachorrinho.jpg', 'audio/cachorro.mp3',
          'O cachorro é um animal doméstico popular, conhecido por sua lealdade e inteligência.'),
      Animal('Gata', 'assets/images/gatinha.jpg', 'audio/gato.mp3',
          'A gata é um animal doméstico independente e brincalhão, conhecido por sua agilidade e graça.'),
      Animal('Vaca', 'assets/images/vaquinha.jpg', 'audio/vaca.mp3',
          'A vaca é um animal de fazenda importante, conhecida por sua produção de leite e carne.'),
      Animal('Ovelha', 'assets/images/ovelha.jpg', 'audio/ovelha.mp3',
          'A ovelha é um animal de fazenda dócil e sociável, conhecida por sua lã macia.'),
      Animal('Cabrito', 'assets/images/cabrito.jpg', 'audio/cabrito.mp3',
          'O cabrito é um animal de fazenda jovem e brincalhão, conhecido por sua energia e vitalidade.'),
      Animal('Cavalo', 'assets/images/cavalo.jpg', 'audio/cavalo.mp3',
          'O cavalo é um animal de grande porte, conhecido por sua força e velocidade.'),
      Animal('Galinha', 'assets/images/galinha.jpg', 'audio/galinha.mp3',
          'A galinha é uma ave doméstica popular, conhecida por sua produção de ovos.'),
      Animal('Galo', 'assets/images/galo.jpg', 'audio/galo.mp3',
          'O galo é uma ave doméstica conhecida por seu canto matinal e por proteger as galinhas.'),
      Animal('Grilo', 'assets/images/grilo.jpg', 'audio/grilo.mp3',
          'O grilo é um inseto conhecido por seu canto estridente e por seus saltos acrobáticos.'),
      Animal('Hipopotamo', 'assets/images/hipopotamo.jpg', 'audio/hipopotamo.m4a',
          'O hipopótamo é um animal semi-aquático de grande porte, conhecido por sua natureza territorial e agressiva.'),
      Animal('Macaco', 'assets/images/macaquinho.jpg', 'audio/macaco.mp3',
          'O macaco é um primata conhecido por sua inteligência e habilidades acrobáticas.'),
      Animal('Porco', 'assets/images/porquinho.jpg', 'audio/porco.mp3',
          'O porco é um animal de fazenda conhecido por sua inteligência e sociabilidade.'),
      Animal('Urso', 'assets/images/ursinho.jpg', 'audio/urso.mp3',
          'O urso é um animal selvagem de grande porte, conhecido por sua força e hibernação.'),
      Animal('Zebra', 'assets/images/zebra.jpg', 'audio/zebra.m4a',
          'A zebra é um animal selvagem herbívoro, conhecido por suas listras pretas e brancas.'),
    ];
  }
}