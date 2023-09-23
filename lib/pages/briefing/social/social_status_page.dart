import 'package:Mark/globalController/service_controller.dart';
import 'package:Mark/models/contratedModels/social_contrated_item_model.dart';
import 'package:Mark/pages/briefing/social/posts/social_show_posts_page.dart';
import 'package:Mark/pages/briefing/social/tema/social_show_tema_page.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/instance_manager.dart';
import 'package:get/route_manager.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:Mark/consts/colors.dart';
import 'package:Mark/widgets/widgets.dart';

class SocialStatusPage extends StatefulWidget {
  const SocialStatusPage({super.key, required this.service});
  final SocialContratedItem service;

  @override
  State<SocialStatusPage> createState() => _SocialStatusPageState();
}

class _SocialStatusPageState extends State<SocialStatusPage> {
  final serviceController = Get.put<ServiceController>(ServiceController());
  @override
  Widget build(BuildContext context) {
    print(widget.service.SocialService);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: lightWhite,
        leadingWidth: 230,
        leading: Row(
          children: [
            Container(
              margin: const EdgeInsets.only(
                right: 10,
              ),
              child: IconButton(
                onPressed: () {
                  Get.back();
                },
                icon: const Icon(
                  Icons.arrow_back_rounded,
                  color: neutralTen,
                ),
              ),
            ),
            Text(
              "Redes Sociais",
              style: GoogleFonts.roboto(
                fontSize: 22,
                color: neutralTen,
                fontWeight: FontWeight.w700,
              ),
            )
          ],
        ),
      ),
      backgroundColor: backgroundColor,
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(20),
          children: [
            Container(
              margin: const EdgeInsets.only(bottom: 10),
              child: Text(
                "Etapas de Criação",
                style: GoogleFonts.roboto(
                  fontSize: 22,
                  color: neutralTen,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
            StatusContainer(
              isFinished: widget.service.SocialService.status >= 2,
              iconLeft: FontAwesomeIcons.clipboard,
              subtitle:
                  'A etapa de “briefing” é uma coleta de informações inicial que irá auxiliar a execução do projeto dentro da proposta desejada.',
              title: 'Briefing',
              isLoading: widget.service.SocialService.status < 2,
              onTap: () {},
            ),
            StatusContainer(
              isFinished: widget.service.SocialService.status > 3,
              iconLeft: FontAwesomeIcons.clipboard,
              subtitle:
                  'O seu planejamento está sendo desenvolvido e em breve estará disponível para revisão e aprovação.',
              title: 'Planejamento',
              isLoading: widget.service.SocialService.status == 3,
              onTap: () {},
            ),
            StatusContainer(
              isFinished: widget.service.SocialService.status > 4 ||
                  widget.service.SocialService.status == 6,
              iconLeft: FontAwesomeIcons.tv,
              subtitle:
                  'Veja um exempo de aplicação das suas postagem em uma simulação da plataforma.',
              title: 'Aprovação dos Temas',
              isLoading: widget.service.SocialService.status == 4,
              onTap: () {
                // Get.to(const LogoProvePage());
                if (widget.service.SocialService.SocialShow != null) {
                  Get.to(SocialShowTemaPage(
                    showData: widget.service.SocialService.SocialShow!,
                  ));
                }
              },
              haveButton: true,
              buttoName: "Visualizar",
            ),
            StatusContainer(
              isFinished: widget.service.SocialService.status > 9,
              iconLeft: Icons.star,
              subtitle:
                  'As suas artes estão sendo desenvolvidas e em breve estarão disponíveis para revisão e aprovação.',
              title: 'Aprovação da Postagem',
              isLoading: widget.service.SocialService.status == 8,
              onTap: () {
                if (widget.service.SocialService.SocialShow != null) {
                  Get.to(SocialShowFinalPostPage(
                    showData: widget.service.SocialService.SocialShow!,
                  ));
                }
              },
              haveButton: true,
              buttoName: "Visualizar",
            ),
            StatusContainer(
              isFinished: widget.service.SocialService.status >= 12,
              iconLeft: FontAwesomeIcons.box,
              subtitle:
                  'Veja as artes para as postagens que vocês aprovou os textos anteriormente em uma simulação da plataforma.',
              title: 'Conclusão',
              isLoading: widget.service.SocialService.status == 11,
              onTap: () {
                // Get.to(const LogoFinishPage(LogoArchives: ,));
              },
            ),
          ],
        ),
      ),
    );
  }
}
