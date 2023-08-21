class OnboardingContents {
  OnboardingContents({
    required this.title,
    required this.desc,
  });
  final String title;
  final String desc;
}

List<OnboardingContents> contents = [
  OnboardingContents(
    title: 'Explore',
    desc:
        'Somos um aplicativo que conecta os estabelecimentos que querem vender seus excedentes, com usuários que querem contribuir com a diminuição do desperdício e aproveitar preços especiais.',
  ),
  OnboardingContents(
    title: 'Encontre',
    desc:
        'Aqui você encontrará uma imensidão de opções, desde padarias, confeitarias, hortifrutis, restaurantes e muito mais.',
  ),
  OnboardingContents(
    title: 'Contrate',
    desc:
        'Todo dia são liberadas refeições diferentes, o conteúdo é surpresa. Você escolhe o estabelecimento e depois entre as opções salgado, misto ou doce. Compre de acordo com sua preferência.',
  ),
];
