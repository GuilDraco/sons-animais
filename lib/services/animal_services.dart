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
        Animal('Cricket', 'assets/images/animais/grilo.jpg', 'audio/animais/grilo.m4a',
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

        // Novos Animais em Inglês
        Animal('Lion', 'assets/images/animais/leaozinho.jpg', 'audio/animais/leao.mp3',
            'The lion is known as the king of the jungle.'),
        Animal('Elephant', 'assets/images/animais/elefante.jpg', 'audio/animais/elefante.mp3',
            'The elephant is the largest land animal, known for its intelligence.'),
        Animal('Fox', 'assets/images/animais/raposa.jpg', 'audio/animais/raposa.mp3',
            'Foxes are known for their cunning and speed.'),
        Animal('Crocodile', 'assets/images/animais/crocodilo.jpg', 'audio/animais/crocodilo.mp3',
            'Crocodiles are aquatic reptiles known for their powerful jaws.'),
        Animal('Eagle', 'assets/images/animais/aguia.jpg', 'audio/animais/aguia.m4a',
            'Eagles are birds of prey known for their sharp eyesight.'),
        Animal('Penguin', 'assets/images/animais/pinguim.jpg', 'audio/animais/pinguim.m4a',
            'Penguins are flightless birds known for their waddle.'),
        Animal('Duck', 'assets/images/animais/patinho.jpg', 'audio/animais/pato.mp3',
            'Ducks are aquatic birds known for their quacking.'),
        // Animal('Rabbit', 'assets/images/animais/coelho.jpg', 'audio/animais/rabbit.mp3',
        //     'Rabbits are small mammals known for their long ears and agility.'),
        Animal('Frog', 'assets/images/animais/sapinho.jpg', 'audio/animais/sapo.mp3',
            'Frogs are amphibians known for their croaking and jumping.'),
        // Animal('Turkey', 'assets/images/animais/peru.jpg', 'audio/animais/turkey.mp3',
        //     'Turkeys are large birds known for their gobbling sound.'),
        // Animal('Pigeon', 'assets/images/animais/pombo.jpg', 'audio/animais/pigeon.mp3',
        //     'Pigeons are known for their ability to navigate long distances.'),
        // Animal('Donkey', 'assets/images/animais/burro.jpg', 'audio/animais/donkey.mp3',
        //     'Donkeys are known for their braying and are used as work animals.'),
        // Animal('Llama', 'assets/images/animais/lhama.jpg', 'audio/animais/llama.mp3',
        //     'Llamas are known for their thick wool and use as pack animals.'),
        // Animal('Deer', 'assets/images/animais/corca.jpg', 'audio/animais/deer.mp3',
        //     'Deer are herbivores known for their antlers.'),
        Animal('Parrot', 'assets/images/animais/papagaio.jpg', 'audio/animais/papagaio.m4a',
            'Parrots are known for their colorful feathers and ability to mimic sounds.'),
        Animal('Crow', 'assets/images/animais/corvo.jpg', 'audio/animais/corvo.m4a',
            'Crows are highly intelligent birds known for their adaptability.'),
        Animal('Whale', 'assets/images/animais/baleia.jpg', 'audio/animais/baleia.m4a',
            'Whales are large marine mammals known for their songs.'),
        Animal('Seal', 'assets/images/animais/foca.jpg', 'audio/animais/foca.m4a',
            'Seals are marine mammals known for their playful nature.'),
        Animal('Dolphin', 'assets/images/animais/golfinho.jpg', 'audio/animais/golfinho.m4a',
            'Dolphins are intelligent marine mammals known for their clicks and whistles.'),
        Animal('Tiger', 'assets/images/animais/tigrinho.jpg', 'audio/animais/tigre.mp3',
            'are excellent swimmers and, unlike many cats, enjoy water.'),
        // Animal('Sparrow', 'assets/images/animais/pardal.jpg', 'audio/animais/sparrow.mp3',
        //     'Sparrows are small birds known for their chirping.'),
        // Animal('Hawk', 'assets/images/animais/falcao.jpg', 'audio/animais/hawk.mp3',
        //     'Hawks are birds of prey known for their sharp talons.'),
        // Animal('Bat', 'assets/images/animais/morcego.jpg', 'audio/animais/bat.mp3',
        //     'Bats are nocturnal mammals known for their echolocation.'),
        // Animal('Bee', 'assets/images/animais/abelha.jpg', 'audio/animais/bee.mp3',
        //     'Bees are known for their buzzing and their important role in pollination.'),
        // Animal('Lobster', 'assets/images/animais/lagosta.jpg', 'audio/animais/lobster.mp3',
        //     'Lobsters are marine crustaceans known for their hard shell and claws.'),
        // Animal('Camel', 'assets/images/animais/camelo.jpg', 'audio/animais/camel.mp3',
        //     'Camels are known for their ability to survive in desert environments.'),
        // Animal('Raccoon', 'assets/images/animais/guaxinim.jpg', 'audio/animais/raccoon.mp3',
        //     'Raccoons are nocturnal animals known for their dexterous front paws.'),
        // Animal('Panda', 'assets/images/animais/panda.jpg', 'audio/animais/panda.mp3',
        //     'Pandas are bears known for their love of bamboo.'),
        // Animal('Koala', 'assets/images/animais/coala.jpg', 'audio/animais/koala.mp3',
        //     'Koalas are marsupials known for their slow movements and eucalyptus diet.')
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
        Animal('Grilo', 'assets/images/animais/grilo.jpg', 'audio/animais/grilo.m4a',
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

        // Novos Animais em Português
        Animal('Leão', 'assets/images/animais/leao.jpg', 'audio/animais/leao.mp3',
            'O leão é conhecido como o rei da selva.'),
        Animal('Elefante', 'assets/images/animais/elefante.jpg', 'audio/animais/elefante.mp3',
            'O elefante é o maior animal terrestre, conhecido por sua inteligência.'),
        Animal('Raposa', 'assets/images/animais/raposa.jpg', 'audio/animais/raposa.mp3',
            'As raposas são conhecidas por sua astúcia e rapidez.'),
        Animal('Crocodilo', 'assets/images/animais/crocodilo.jpg', 'audio/animais/crocodilo.mp3',
            'Os crocodilos são répteis aquáticos conhecidos por suas mandíbulas poderosas.'),
        Animal('Águia', 'assets/images/animais/aguia.jpg', 'audio/animais/aguia.m4a',
            'As águias são aves de rapina conhecidas por sua visão aguçada.'),
        Animal('Pinguim', 'assets/images/animais/pinguim.jpg', 'audio/animais/pinguim.m4a',
            'Os pinguins são aves que não voam, conhecidas por sua caminhada engraçada.'),
        Animal('Pato', 'assets/images/animais/patinho.jpg', 'audio/animais/pato.mp3',
            'Os patos são aves aquáticas conhecidas pelo seu grasnar.'),
        // Animal('Coelho', 'assets/images/animais/coelho.jpg', 'audio/animais/coelho.mp3',
        //     'Os coelhos são pequenos mamíferos conhecidos por suas longas orelhas e agilidade.'),
        Animal('Sapo', 'assets/images/animais/sapinho.jpg', 'audio/animais/sapo.mp3',
            'Os sapos são anfíbios conhecidos por seu coaxar e saltos.'),
        // Animal('Peru', 'assets/images/animais/peru.jpg', 'audio/animais/peru.mp3',
        //     'Os perus são grandes aves conhecidas por seu som característico.'),
        // Animal('Pombo', 'assets/images/animais/pombo.jpg', 'audio/animais/pombo.mp3',
        //     'Os pombos são conhecidos por sua capacidade de navegação a longas distâncias.'),
        // Animal('Burro', 'assets/images/animais/burro.jpg', 'audio/animais/burro.mp3',
        //     'Os burros são conhecidos por seu relinchar e usados como animais de trabalho.'),
        // Animal('Lhama', 'assets/images/animais/lhama.jpg', 'audio/animais/lhama.mp3',
        //     'As lhamas são conhecidas por sua lã espessa e uso como animais de carga.'),
        // Animal('Cervo', 'assets/images/animais/cervo.jpg', 'audio/animais/cervo.mp3',
        //     'Os cervos são herbívoros conhecidos por seus chifres.'),
        Animal('Papagaio', 'assets/images/animais/papagaio.jpg', 'audio/animais/papagaio.m4a',
            'Os papagaios são conhecidos por suas penas coloridas e habilidade de imitar sons.'),
        Animal('Corvo', 'assets/images/animais/corvo.jpg', 'audio/animais/corvo.m4a',
            'Os corvos são aves altamente inteligentes, conhecidas por sua adaptabilidade.'),
        Animal('Baleia', 'assets/images/animais/baleia.jpg', 'audio/animais/baleia.m4a',
            'As baleias são grandes mamíferos marinhos conhecidos por seus cantos.'),
        Animal('Foca', 'assets/images/animais/foca.jpg', 'audio/animais/foca.m4a',
            'As focas são mamíferos marinhos conhecidos por sua natureza brincalhona.'),
        Animal('Golfinho', 'assets/images/animais/golfinho.jpg', 'audio/animais/golfinho.m4a',
            'Os golfinhos são mamíferos marinhos inteligentes, conhecidos por seus assobios e cliques.'),
        Animal('Tigre', 'assets/images/animais/tigrinho.jpg', 'audio/animais/tigre.mp3',
            'Os tigres são excelentes nadadores e, ao contrário de muitos felinos, gostam de água.'),
        // Animal('Pardal', 'assets/images/animais/pardal.jpg', 'audio/animais/pardal.mp3',
        //     'Os pardais são pequenos pássaros conhecidos por seu canto.'),
        // Animal('Falcão', 'assets/images/animais/falcao.jpg', 'audio/animais/falcao.mp3',
        //     'Os falcões são aves de rapina conhecidas por suas garras afiadas.'),
        // Animal('Morcego', 'assets/images/animais/morcego.jpg', 'audio/animais/morcego.mp3',
        //     'Os morcegos são mamíferos noturnos conhecidos por sua ecolocalização.'),
        // Animal('Abelha', 'assets/images/animais/abelha.jpg', 'audio/animais/abelha.mp3',
        //     'As abelhas são conhecidas por seu zumbido e seu papel crucial na polinização.'),
        // Animal('Lagosta', 'assets/images/animais/lagosta.jpg', 'audio/animais/lagosta.mp3',
        //     'As lagostas são crustáceos marinhos conhecidos por sua casca dura e garras.'),
        // Animal('Camelo', 'assets/images/animais/camelo.jpg', 'audio/animais/camelo.mp3',
        //     'Os camelos são conhecidos por sua capacidade de sobreviver em ambientes desérticos.'),
        // Animal('Guaxinim', 'assets/images/animais/guaxinim.jpg', 'audio/animais/guaxinim.mp3',
        //     'Os guaxinins são animais noturnos conhecidos por suas patas hábeis.'),
        // Animal('Panda', 'assets/images/animais/panda.jpg', 'audio/animais/panda.mp3',
        //     'Os pandas são ursos conhecidos por sua dieta à base de bambu.'),
        // Animal('Coala', 'assets/images/animais/coala.jpg', 'audio/animais/coala.mp3',
        //     'Os coalas são marsupiais conhecidos por sua alimentação de eucalipto e movimentos lentos.')
      ];
    }
  }
}
