import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/instance_manager.dart';
import 'package:get/route_manager.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:Mark/consts/colors.dart';
import 'package:Mark/globalController/service_controller.dart';
import 'package:Mark/models/contratedModels/logo_contrated_item_model.dart';
import 'package:Mark/pages/briefing/logo/logo_finish_page.dart';
import 'package:Mark/pages/briefing/logo/prove/logo_prove_page.dart';
import 'package:Mark/widgets/widgets.dart';

class LogoStatusPage extends StatefulWidget {
  const LogoStatusPage({super.key, required this.service});
  final LogoContratedItem service;
  @override
  State<LogoStatusPage> createState() => _LogoStatusPageState();
}

class _LogoStatusPageState extends State<LogoStatusPage> {
  final serviceController = Get.put<ServiceController>(ServiceController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: lightWhite,
        leadingWidth: 130,
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
              "Logo",
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
              isFinished: widget.service.LogoService.status >= 2,
              iconLeft: FontAwesomeIcons.clipboard,
              subtitle:
                  'A etapa de “briefing” é uma coleta de informações inicial que irá auxiliar a execução do projeto dentro da proposta desejada.',
              title: 'Briefing',
              isLoading: widget.service.LogoService.status < 2,
              onTap: () {},
            ),
            StatusContainer(
              isFinished: widget.service.LogoService.status >= 3,
              iconLeft: FontAwesomeIcons.gear,
              subtitle:
                  'A sua Logo está em processo de produção, em breve estará disponível para revisão e aprovação.',
              title: 'Criação',
              isLoading: widget.service.LogoService.status == 3,
              onTap: () {},
            ),
            StatusContainer(
              isFinished: widget.service.LogoService.status >= 6,
              iconLeft: FontAwesomeIcons.tv,
              subtitle:
                  'Veja um exempo de aplicação da sua logo em diversos materiais diferentes, desde impressos até digitais.',
              title: 'Provas',
              isLoading: widget.service.LogoService.status <= 5 &&
                  widget.service.LogoService.status >= 4,
              onTap: () {
                if (widget.service.LogoService.LogoProof != null) {
                  Get.to(LogoProvePage(
                    logoProof: widget.service.LogoService.LogoProof!,
                  ));
                }
              },
              haveButton: widget.service.LogoService.status != 5 &&
                  widget.service.LogoService.status != 6,
              buttoName: "Visualizar",
            ),
            // StatusContainer(
            //   isFinished: widget.service.LogoService.feedbackSended == true,
            //   iconLeft: Icons.star,
            //   subtitle:
            //       'Como foi sua experiência com o processo de criação? Gostou do resultado? Conte-nos tudo....',
            //   title: 'Avaliação',
            //   isLoading: widget.service.LogoService.status >= 4 &&
            //       widget.service.LogoService.feedbackSended == false,
            //   onTap: () {
            //     Get.to(const ReviewPage());
            //   },
            //   haveButton: true,
            //   buttoName: "Avaliar",
            // ),
            StatusContainer(
              isFinished: false,
              iconLeft: FontAwesomeIcons.box,
              subtitle:
                  'Acesse os arquivos da sua logo e contrate produtos e planos que melhor se adaptam a sua necessidade e seu bolso.',
              title: 'Conclusão',
              isLoading: widget.service.LogoService.status >= 7,
              onTap: () {
                Get.to(() => LogoFinishPage(
                      LogoArchives: widget.service.LogoService.LogoArchives,
                    ));
              },
              haveButton: true,
              buttoName: "Acessar Arquivos",
            ),
          ],
        ),
      ),
    );
  }
}
