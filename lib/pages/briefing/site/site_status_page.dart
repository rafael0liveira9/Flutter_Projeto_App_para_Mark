import 'package:Mark/models/contratedModels/site_contrated_item_model.dart';
import 'package:Mark/pages/briefing/site/definition/site_definition_page.dart';
import 'package:Mark/pages/briefing/site/finals/site_presentation_finals_page.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/instance_manager.dart';
import 'package:get/route_manager.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:Mark/consts/colors.dart';
import 'package:Mark/globalController/service_controller.dart';
import 'package:Mark/widgets/widgets.dart';

class SiteStatusPage extends StatefulWidget {
  const SiteStatusPage({super.key, required this.service});
  final SiteContratedItem service;
  @override
  State<SiteStatusPage> createState() => _SiteStatusPageState();
}

class _SiteStatusPageState extends State<SiteStatusPage> {
  final serviceController = Get.put<ServiceController>(ServiceController());

  @override
  Widget build(BuildContext context) {
    print(widget.service.SiteService.status);
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
              "Website",
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
              isFinished: widget.service.SiteService.status >= 2,
              iconLeft: FontAwesomeIcons.clipboard,
              subtitle:
                  'A etapa de “briefing” é uma coleta de informações inicial que irá auxiliar a execução do projeto dentro da proposta desejada.',
              title: 'Briefing',
              isLoading: widget.service.SiteService.status < 2,
              onTap: () {},
            ),
            StatusContainer(
              isFinished: widget.service.SiteService.status > 3,
              iconLeft: FontAwesomeIcons.clipboardList,
              subtitle:
                  'O seu planejamento está sendo desenvolvido e em breve estará disponível para revisão e aprovação.',
              title: 'Planejamento',
              isLoading: widget.service.SiteService.status == 3,
              onTap: () {},
            ),
            StatusContainer(
              isFinished: widget.service.SiteService.status > 4,
              iconLeft: FontAwesomeIcons.eye,
              subtitle:
                  'Sugerimos algumas opções de layout para o seu site, dê uma olhada e escolha a que mais lhe agrada.',
              title: 'Definição de Layout',
              isLoading: widget.service.SiteService.status == 4,
              onTap: () {},
            ),
            StatusContainer(
              isFinished: widget.service.SiteService.status > 5,
              iconLeft: FontAwesomeIcons.eye,
              subtitle:
                  'Sugerimos algumas opções de layout para o seu site, dê uma olhada e escolha a que mais lhe agrada.',
              title: "Acompanhe a proposta do site",
              isLoading: widget.service.SiteService.status == 5,
              buttoName: "Visualizar",
              haveButton: true,
              onTap: () {
                Get.to(
                  () => SiteDefinitionPage(
                    service: widget.service,
                  ),
                );
              },
            ),
            StatusContainer(
              isFinished: widget.service.SiteService.status > 7,
              iconLeft: FontAwesomeIcons.computer,
              subtitle:
                  'Veja o produto final do layout com todas informações e faça suas últimas considerações de ajustes antes de finalizar.',
              title: 'Apresentação Final',
              isLoading: widget.service.SiteService.status == 7,
              onTap: () {
                Get.to(
                  SitePresentitionFinalsPage(
                    siteLayoutFinished:
                        widget.service.SiteService.SiteLayoutFinished!,
                  ),
                );
              },
              haveButton: widget.service.SiteService.status == 7,
              buttoName: "Visualizar",
            ),
            StatusContainer(
              isFinished: widget.service.SiteService.status > 9,
              iconLeft: FontAwesomeIcons.box,
              subtitle:
                  'Vamos publicar seu site agora mesmo, informando algumas informações importantes de acesso.',
              title: 'Conclusão',
              isLoading: widget.service.SiteService.status == 8,
              onTap: () {},
            ),
          ],
        ),
      ),
    );
  }
}
