import 'package:background_downloader/background_downloader.dart';
import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:Mark/consts/colors.dart';
import 'package:Mark/models/contratedModels/logo_contrated_item_model.dart';

class LogoFinishPage extends StatefulWidget {
  const LogoFinishPage({super.key, required this.LogoArchives});
  final List<LogoArchivesModel> LogoArchives;

  @override
  State<LogoFinishPage> createState() => _LogoFinishPageState();
}

class _LogoFinishPageState extends State<LogoFinishPage> {
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
          children: [
            Container(
              padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    margin: const EdgeInsets.only(bottom: 10),
                    child: Text(
                      "Conclusão",
                      style: GoogleFonts.roboto(
                        fontSize: 22,
                        fontWeight: FontWeight.w700,
                        color: neutralTen,
                      ),
                    ),
                  ),
                  Text(
                    "Aqui estão os arquivos da sua Logo para download, você também pode contratar novos serviços e aplicar ela agora mesmo é materiais incríveis, estamos à sua disposição.",
                    style: GoogleFonts.roboto(
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                      color: neutralFourty,
                      letterSpacing: 0.4,
                    ),
                  ),
                ],
              ),
            ),
            Container(
              margin: const EdgeInsets.symmetric(vertical: 20),
              child: Column(
                children: [
                  for (var i = 0; i < widget.LogoArchives.length; i++)
                    ItemDownContractContainer(
                      isContract: false,
                      variation: i % 2 == 0 ? 1 : 2,
                      photoPreview: widget.LogoArchives[i].preview.url,
                      url: widget.LogoArchives[i].url,
                      name: widget.LogoArchives[i].name,
                      type: widget.LogoArchives[i].type,
                    ),
                ],
              ),
            ),
            // Container(
            //   height: 69,
            //   margin: const EdgeInsets.symmetric(horizontal: 20),
            //   padding: const EdgeInsets.symmetric(
            //     horizontal: 20,
            //     vertical: 10,
            //   ),
            //   decoration: BoxDecoration(
            //     borderRadius: BorderRadius.circular(8),
            //     gradient: gradientOrange,
            //   ),
            //   child: Row(
            //     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            //     children: [
            //       const Icon(
            //         Icons.shopping_cart,
            //         color: Colors.white,
            //       ),
            //       Text(
            //         "COMPRAR MAIS PRODUTOS",
            //         style: GoogleFonts.roboto(
            //           fontSize: 16,
            //           fontWeight: FontWeight.w700,
            //           color: Colors.white,
            //           letterSpacing: 0.4,
            //         ),
            //       )
            //     ],
            //   ),
            // )
          ],
        ),
      ),
    );
  }
}

class ItemDownContractContainer extends StatelessWidget {
  const ItemDownContractContainer({
    super.key,
    required this.isContract,
    required this.variation,
    required this.photoPreview,
    required this.url,
    required this.type,
    required this.name,
  });

  final bool isContract;
  final int variation;
  final String photoPreview;
  final String url;
  final String type;
  final String name;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: isContract == false && variation == 2
          ? backgroundColor8
          : isContract == true && variation == 1
              ? orange40
              : isContract == true && variation == 2
                  ? orange20
                  : null,
      padding: const EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 8,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Container(
                height: 48,
                width: 96,
                margin: const EdgeInsets.only(right: 10),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(4),
                ),
                clipBehavior: Clip.antiAlias,
                child: FadeInImage(
                  placeholder: const AssetImage(
                    "assets/images/rectangleOrange.png",
                  ),
                  image: NetworkImage(
                    photoPreview,
                  ),
                  imageErrorBuilder: (context, error, stackTrace) {
                    return Image.asset(
                      'assets/images/rectangleOrange.png',
                      fit: BoxFit.cover,
                    );
                  },
                  fit: BoxFit.cover,
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    name,
                    style: GoogleFonts.roboto(
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      color: Colors.black,
                    ),
                  ),
                  Text(
                    type,
                    style: GoogleFonts.roboto(
                      fontSize: 11,
                      fontWeight: FontWeight.w700,
                      color: neutralSix,
                    ),
                  ),
                ],
              ),
            ],
          ),
          InkWell(
            onTap: () async {
              await FileDownloader().download(
                DownloadTask(
                  url: url,
                ),
                onProgress: (progress) => print(
                  'Progress: ${progress * 100}%',
                ),
                onStatus: (status) => print('Status: $status'),
              );
            },
            child: Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 30,
                vertical: 10,
              ),
              decoration: BoxDecoration(
                color: mainPrimaryColor,
                borderRadius: BorderRadius.circular(30),
              ),
              child: Text(
                "Download",
                style: GoogleFonts.roboto(
                  fontSize: 12,
                  fontWeight: FontWeight.w700,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
