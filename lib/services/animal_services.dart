import 'dart:math';
import '../models/animal.dart';

class AnimalService {

  static Future<Animal?> getRandomAnimal(String langCode) async {
    final animals = await getAnimals(langCode);
    return animals.isNotEmpty ? animals[Random().nextInt(animals.length)] : null;
  }

  static Future<List<Animal>> getAnimals(String langCode) async {
    await Future.delayed(const Duration(seconds: 2));

    if (langCode == 'en') {
      return [
        Animal('Dog', 'assets/images/animais/cachorrinho.jpg', 'audio/animais/cachorro.mp3',
            'The dog is a popular domestic animal, known for its loyalty and intelligence.'),
        Animal('Cat', 'assets/images/animais/gatinha.jpg', 'audio/animais/gato.mp3',
            'The cat is an independent and playful domestic animal, known for its agility and grace.'),
        Animal('Cow', 'assets/images/animais/vaquinha.jpg', 'audio/animais/vaca.mp3',
            'The cow is an important farm animal, known for its production of milk and meat.'),
        Animal('Sheep', 'assets/images/animais/ovelha.jpg', 'audio/animais/ovelha.mp3',
            'The sheep is a gentle and sociable farm animal, known for its soft wool.'),
        Animal('Goat', 'assets/images/animais/cabrito.jpg', 'audio/animais/cabrito.mp3',
            'The goat is a young and playful farm animal, known for its energy and vitality.'),
        Animal('Horse', 'assets/images/animais/cavalo.jpg', 'audio/animais/cavalo.mp3',
            'The horse is a large animal, known for its strength and speed.'),
        Animal('Chicken', 'assets/images/animais/galinha.jpg', 'audio/animais/galinha.mp3',
            'The chicken is a popular domestic bird, known for its egg production.'),
        Animal('Rooster', 'assets/images/animais/galo.jpg', 'audio/animais/galo.mp3',
            'The rooster is a domestic bird known for its morning crow and for protecting the hens.'),
        Animal('Cricket', 'assets/images/animais/grilo.jpg', 'audio/animais/grilo.mp3',
            'The cricket is an insect known for its loud chirping and acrobatic jumps.'),
        Animal('Hippopotamus', 'assets/images/animais/hipopotamo.jpg', 'audio/animais/hipopotamo.m4a',
            'The hippopotamus is a large semi-aquatic animal, known for its territorial and aggressive nature.'),
        Animal('Monkey', 'assets/images/animais/macaquinho.jpg', 'audio/animais/macaco.mp3',
            'The monkey is a primate known for its intelligence and acrobatic skills.'),
        Animal('Pig', 'assets/images/animais/porquinho.jpg', 'audio/animais/porco.mp3',
            'The pig is a farm animal known for its intelligence and sociability.'),
        Animal('Bear', 'assets/images/animais/ursinho.jpg', 'audio/animais/urso.mp3',
            'The bear is a large wild animal, known for its strength and hibernation.'),
        Animal('Zebra', 'assets/images/animais/zebra.jpg', 'audio/animais/zebra.m4a',
            'The zebra is a wild herbivore animal, known for its black and white stripes.'),
      ];
    } else {
      return [
        Animal('Cachorro', 'assets/images/animais/cachorrinho.jpg', 'audio/animais/cachorro.mp3',
            'O cachorro é um animal doméstico popular, conhecido por sua lealdade e inteligência.'),
        Animal('Gata', 'assets/images/animais/gatinha.jpg', 'audio/animais/gato.mp3',
            'A gata é um animal doméstico independente e brincalhão, conhecido por sua agilidade e graça.'),
        Animal('Vaca', 'assets/images/animais/vaquinha.jpg', 'audio/animais/vaca.mp3',
            'A vaca é um animal de fazenda importante, conhecida por sua produção de leite e carne.'),
        Animal('Ovelha', 'assets/images/animais/ovelha.jpg', 'audio/animais/ovelha.mp3',
            'A ovelha é um animal de fazenda dócil e sociável, conhecida por sua lã macia.'),
        Animal('Cabrito', 'assets/images/animais/cabrito.jpg', 'audio/animais/cabrito.mp3',
            'O cabrito é um animal de fazenda jovem e brincalhão, conhecido por sua energia e vitalidade.'),
        Animal('Cavalo', 'assets/images/animais/cavalo.jpg', 'audio/animais/cavalo.mp3',
            'O cavalo é um animal de grande porte, conhecido por sua força e velocidade.'),
        Animal('Galinha', 'assets/images/animais/galinha.jpg', 'audio/animais/galinha.mp3',
            'A galinha é uma ave doméstica popular, conhecida por sua produção de ovos.'),
        Animal('Galo', 'assets/images/animais/galo.jpg', 'audio/animais/galo.mp3',
            'O galo é uma ave doméstica conhecida por seu canto matinal e por proteger as galinhas.'),
        Animal('Grilo', 'assets/images/animais/grilo.jpg', 'audio/animais/grilo.mp3',
            'O grilo é um inseto conhecido por seu canto estridente e por seus saltos acrobáticos.'),
        Animal('Hipopotamo', 'assets/images/animais/hipopotamo.jpg', 'audio/animais/hipopotamo.m4a',
            'O hipopótamo é um animal semi-aquático de grande porte, conhecido por sua natureza territorial e agressiva.'),
        Animal('Macaco', 'assets/images/animais/macaquinho.jpg', 'audio/animais/macaco.mp3',
            'O macaco é um primata conhecido por sua inteligência e habilidades acrobáticas.'),
        Animal('Porco', 'assets/images/animais/porquinho.jpg', 'audio/animais/porco.mp3',
            'O porco é um animal de fazenda conhecido por sua inteligência e sociabilidade.'),
        Animal('Urso', 'assets/images/animais/ursinho.jpg', 'audio/animais/urso.mp3',
            'O urso é um animal selvagem de grande porte, conhecido por sua força e hibernação.'),
        Animal('Zebra', 'assets/images/animais/zebra.jpg', 'audio/animais/zebra.m4a',
            'A zebra é um animal selvagem herbívoro, conhecido por suas listras pretas e brancas.'),
      ];
    }
  }
}
