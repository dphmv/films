import 'package:films/domain/models/film_card_model.dart';
import 'package:films/domain/widgets/film_card.dart';
import 'package:flutter/material.dart';

class FilmGrid extends StatelessWidget {
  const FilmGrid({Key? key}) : super(key: key);

  static final List<FilmCardModel> _films = <FilmCardModel>[
    const FilmCardModel(
      id: 0,
      title: 'Зелёная миля',
      picture:
          'https://avatars.mds.yandex.net/get-kinopoisk-image/1946459/acb932eb-c7d0-42de-92df-f5f306c4c48e/1920x',
      voteAverage: 9.1,
      releaseDate: '1999-12-06',
      description:
          'Обвиненный в страшном преступлении, Джон Коффи оказывается в блоке смертников тюрьмы «Холодная гора». Вновь прибывший обладал поразительным ростом и был пугающе спокоен, что, впрочем, никак не влияло на отношение к нему начальника блока Пола Эджкомба, привыкшего исполнять приговор.',
    ),
    const FilmCardModel(
      id: 1,
      title: 'Побег из Шоушенка',
      picture:
          'https://avatars.mds.yandex.net/get-kinopoisk-image/1773646/e26044e5-2d5a-4b38-a133-a776ad93366f/1920x',
      voteAverage: 9.1,
      releaseDate: '1994-09-10',
      description:
          'Бухгалтер Энди Дюфрейн обвинён в убийстве собственной жены и её любовника. Оказавшись в тюрьме под названием Шоушенк, он сталкивается с жестокостью и беззаконием, царящими по обе стороны решётки. Каждый, кто попадает в эти стены, становится их рабом до конца жизни. Но Энди, обладающий живым умом и доброй душой, находит подход как к заключённым, так и к охранникам, добиваясь их особого к себе расположения.',
    ),
    const FilmCardModel(
      id: 2,
      title: 'Список Шиндлера',
      picture:
          'https://avatars.mds.yandex.net/get-kinopoisk-image/1900788/ad682589-603d-40c1-b63a-fe01af9f3012/1920x',
      voteAverage: 8.8,
      releaseDate: '1993-11-30',
      description:
          'Лента рассказывает реальную историю загадочного Оскара Шиндлера, члена нацистской партии, преуспевающего фабриканта, спасшего во время Второй мировой войны более тысячи ста евреев. Это триумф одного человека, не похожего на других, и драма тех, кто, благодаря ему, выжил в ужасный период человеческой истории.',
    ),
    const FilmCardModel(
      id: 3,
      title: 'Властелин колец: Возвращение короля',
      picture:
          'https://avatars.mds.yandex.net/get-kinopoisk-image/1773646/7dfa6dbd-15ea-41e9-b869-63dd33ffdb0d/1920x',
      voteAverage: 8.6,
      releaseDate: '2003-12-01',
      description:
          'Последняя часть трилогии о Кольце Всевластия и о героях, взявших на себя бремя спасения Средиземья. Повелитель сил Тьмы Саурон направляет свои бесчисленные рати под стены Минас-Тирита, крепости Последней Надежды. Он предвкушает близкую победу, но именно это и мешает ему заметить две крохотные фигурки — хоббитов, приближающихся к Роковой Горе, где им предстоит уничтожить Кольцо Всевластия. Улыбнется ли им счастье.',
    ),
    const FilmCardModel(
      id: 4,
      title: 'Форрест Гамп',
      picture:
          'https://avatars.mds.yandex.net/get-kinopoisk-image/1599028/6aa4d966-9a35-4209-98e0-ec3b09297f46/1920x',
      voteAverage: 8.9,
      releaseDate: '1994-06-23',
      description:
          'Сидя на автобусной остановке, Форрест Гамп — не очень умный, но добрый и открытый парень — рассказывает случайным встречным историю своей необыкновенной жизни.',
    ),
    const FilmCardModel(
      id: 5,
      title: '1+1',
      picture:
          'https://avatars.mds.yandex.net/get-kinopoisk-image/1900788/bd3c56b3-3681-4137-9335-b849c42ed6ea/1920x',
      voteAverage: 8.8,
      releaseDate: '2011-09-23',
      description:
          'Пострадав в результате несчастного случая, богатый аристократ Филипп нанимает в помощники человека, который менее всего подходит для этой работы, — молодого жителя предместья Дрисса, только что освободившегося из тюрьмы. Несмотря на то, что Филипп прикован к инвалидному креслу, Дриссу удается привнести в размеренную жизнь аристократа дух приключений.',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      itemBuilder: (BuildContext context, int index) {
        return Padding(
          padding: const EdgeInsets.all(5.0),
          child: FilmCard.fromFilmModel(model: _films[index % _films.length]),
        );
      },
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 2 / 3,
      ),
    );
  }
}
