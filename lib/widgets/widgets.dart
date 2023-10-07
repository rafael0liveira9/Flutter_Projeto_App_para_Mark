import 'package:Mark/globalController/widgets/bottom_navigation_controller.dart';
import 'package:Mark/pages/briefing/site/site_briefing_page.dart';
import 'package:Mark/pages/briefing/site/site_status_page.dart';
import 'package:Mark/pages/briefing/social/social_briefing_page.dart';
import 'package:Mark/pages/briefing/social/social_status_page.dart';
import 'package:Mark/pages/payment/payment_page.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:Mark/consts/colors.dart';
import 'package:Mark/globalController/service_controller.dart';
import 'package:Mark/models/contratedModels/logo_contrated_item_model.dart';
import 'package:Mark/models/contratedModels/site_contrated_item_model.dart';
import 'package:Mark/models/contratedModels/social_contrated_item_model.dart';
import 'package:Mark/pages/briefing/logo/logo_briefing_page.dart';
import 'package:Mark/pages/briefing/logo/logo_status_page.dart';
import 'package:Mark/utils/utils.dart';

import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';

class FadeInUpWidget extends StatefulWidget {
  final Widget child;
  final Duration duration;
  const FadeInUpWidget({
    Key? key,
    required this.child,
    this.duration = const Duration(milliseconds: 500),
  }) : super(key: key);
  @override
  _FadeInUpWidgetState createState() => _FadeInUpWidgetState();
}

class _FadeInUpWidgetState extends State<FadeInUpWidget>
    with TickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<Offset> _slideAnimation;
  late Animation<double> _opacityAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: widget.duration,
    );
    _slideAnimation = Tween<Offset>(
      begin: const Offset(0.0, 50.0),
      end: const Offset(0.0, 0.0),
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.fastLinearToSlowEaseIn,
    ));
    _opacityAnimation = Tween<double>(begin: 0.3, end: 1.0).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.fastLinearToSlowEaseIn,
      ),
    );
    _animationController.forward(from: 0.0);
    _animationController.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SlideTransition(
      position: _slideAnimation,
      child: AnimatedOpacity(
        opacity: _opacityAnimation.value,
        duration: widget.duration,
        child: widget.child,
      ),
    );
  }
}

class AppBarHome extends StatelessWidget implements PreferredSizeWidget {
  const AppBarHome({
    super.key,
    required this.appBar,
    required this.onPressed,
  });

  final AppBar appBar;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: lightWhite,
      leading: IconButton(
        onPressed: onPressed,
        icon: const Icon(
          Icons.menu,
          color: neutralTen,
        ),
      ),
      flexibleSpace: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          SizedBox(
            height: 60,
            child: Image.asset("assets/icons/logo_mark.png"),
          ),
        ],
      ),
      actions: [
        Container(
          margin: const EdgeInsets.only(right: 10),
          child: IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.notifications,
              color: neutralTen,
            ),
          ),
        ),
      ],
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(appBar.preferredSize.height);
}

class ServiceItemFlex extends StatelessWidget {
  const ServiceItemFlex(
      {super.key,
      required this.type,
      required this.status,
      required this.onTap});

  final String type;
  final String status;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: InkWell(
        onTap: onTap,
        child: Container(
          margin: const EdgeInsets.symmetric(
            horizontal: 5,
          ),
          height: 152,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8),
            boxShadow: [
              defaultBoxShadow,
            ],
          ),
          clipBehavior: Clip.antiAlias,
          child: Stack(
            alignment: Alignment.topRight,
            children: [
              Column(
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 13,
                    ),
                    height: 56,
                    decoration: const BoxDecoration(
                      color: mainPrimaryColor,
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Container(
                          margin: const EdgeInsets.only(
                            right: 5,
                          ),
                          child: const Icon(
                            Icons.polyline_rounded,
                            color: Colors.white,
                            size: 20,
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.only(right: 40),
                          constraints: const BoxConstraints(
                            maxWidth: 130,
                          ),
                          child: Text(
                            type,
                            style: GoogleFonts.roboto(
                              color: Colors.white,
                              fontWeight: FontWeight.w700,
                              fontSize: 16,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    height: 96,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 15,
                    ),
                    decoration: const BoxDecoration(
                      color: Colors.white,
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Container(
                              margin: const EdgeInsets.only(
                                right: 10,
                              ),
                              child: const Icon(
                                Icons.check,
                                color: neutralSix,
                              ),
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Status Atual",
                                  style: GoogleFonts.roboto(
                                    color: neutralSix,
                                    fontWeight: FontWeight.w700,
                                    fontSize: 11,
                                  ),
                                ),
                                Text(
                                  status,
                                  style: GoogleFonts.roboto(
                                    color: yellowColor,
                                    fontWeight: FontWeight.w700,
                                    fontSize: 11,
                                  ),
                                ),
                              ],
                            )
                          ],
                        ),
                        Row(
                          children: [
                            Container(
                              margin: const EdgeInsets.only(
                                right: 10,
                              ),
                              child: const Icon(
                                Icons.calendar_month,
                                color: neutralSix,
                              ),
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Data de Entrega",
                                  style: GoogleFonts.roboto(
                                    color: neutralSix,
                                    fontWeight: FontWeight.w700,
                                    fontSize: 11,
                                  ),
                                ),
                                Text(
                                  "Sem data",
                                  style: GoogleFonts.roboto(
                                    color: neutralThree,
                                    fontWeight: FontWeight.w700,
                                    fontSize: 11,
                                  ),
                                ),
                              ],
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const PercentageWidget(percentage: ""),
              // '${getPercentage(statusArray, widget.service.SiteService.status)}%')
            ],
          ),
        ),
      ),
    );
  }
}

class LogoServiceItemFlex extends StatefulWidget {
  const LogoServiceItemFlex({
    super.key,
    required this.service,
  });

  final LogoContratedItem service;

  @override
  State<LogoServiceItemFlex> createState() => _LogoServiceItemFlexState();
}

class _LogoServiceItemFlexState extends State<LogoServiceItemFlex> {
  final serviceController = Get.put<ServiceController>(ServiceController());

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: InkWell(
        onTap: () {
          serviceController.serviceId.value = widget.service.LogoService.id;
          if (widget.service.LogoService.status == 1) {
            Get.to(const LogoBrienfingPage());
          } else {
            Get.to(LogoStatusPage(service: widget.service));
          }
        },
        child: Container(
          margin: const EdgeInsets.symmetric(
            horizontal: 5,
          ),
          height: 152,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8),
            boxShadow: [
              defaultBoxShadow,
            ],
          ),
          clipBehavior: Clip.antiAlias,
          child: Stack(
            alignment: Alignment.topRight,
            children: [
              Column(
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 13,
                    ),
                    height: 56,
                    decoration: const BoxDecoration(
                      color: mainPrimaryColor,
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Container(
                          margin: const EdgeInsets.only(
                            right: 5,
                          ),
                          child: const Icon(
                            Icons.polyline_rounded,
                            color: Colors.white,
                            size: 20,
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.only(right: 40),
                          constraints: const BoxConstraints(
                            maxWidth: 130,
                          ),
                          child: Text(
                            "Logo",
                            style: GoogleFonts.roboto(
                              color: Colors.white,
                              fontWeight: FontWeight.w700,
                              fontSize: 16,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    height: 96,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 15,
                    ),
                    decoration: const BoxDecoration(
                      color: Colors.white,
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Container(
                              margin: const EdgeInsets.only(
                                right: 10,
                              ),
                              child: const Icon(
                                Icons.check,
                                color: neutralSix,
                              ),
                            ),
                            Flexible(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Status Atual",
                                    style: GoogleFonts.roboto(
                                      color: neutralSix,
                                      fontWeight: FontWeight.w700,
                                      fontSize: 11,
                                    ),
                                  ),
                                  Text(
                                    logoStatus[
                                        widget.service.LogoService.status - 1],
                                    style: GoogleFonts.roboto(
                                      color: yellowColor,
                                      fontWeight: FontWeight.w700,
                                      fontSize: 11,
                                    ),
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                        Row(
                          children: [
                            Container(
                              margin: const EdgeInsets.only(
                                right: 10,
                              ),
                              child: const Icon(
                                Icons.calendar_month,
                                color: neutralSix,
                              ),
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Data de Entrega",
                                  style: GoogleFonts.roboto(
                                    color: neutralSix,
                                    fontWeight: FontWeight.w700,
                                    fontSize: 11,
                                  ),
                                ),
                                Text(
                                  widget.service.LogoService.dueDate != null
                                      ? DateFormat().format(DateTime.parse(
                                          widget.service.LogoService.dueDate
                                              .toString()))
                                      : "Sem data",
                                  style: GoogleFonts.roboto(
                                    color: neutralThree,
                                    fontWeight: FontWeight.w700,
                                    fontSize: 11,
                                  ),
                                ),
                              ],
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              PercentageWidget(
                percentage:
                    '${getPercentage(logoStatus, widget.service.LogoService.status)}%',
              )
            ],
          ),
        ),
      ),
    );
  }
}

class SiteServiceItemFlex extends StatefulWidget {
  const SiteServiceItemFlex({
    super.key,
    required this.service,
  });

  final SiteContratedItem service;

  @override
  State<SiteServiceItemFlex> createState() => _SiteServiceItemFlexState();
}

class _SiteServiceItemFlexState extends State<SiteServiceItemFlex> {
  final serviceController = Get.put<ServiceController>(ServiceController());

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: InkWell(
        onTap: () {
          serviceController.serviceId.value = widget.service.SiteService.id;
          if (widget.service.SiteService.status == 1) {
            Get.to(const SiteBrienfingPage());
          } else {
            Get.to(SiteStatusPage(service: widget.service));
          }
        },
        child: Container(
          margin: const EdgeInsets.symmetric(
            horizontal: 5,
          ),
          height: 152,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8),
            boxShadow: [
              defaultBoxShadow,
            ],
          ),
          clipBehavior: Clip.antiAlias,
          child: Stack(
            alignment: Alignment.topRight,
            children: [
              Column(
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 13,
                    ),
                    height: 56,
                    decoration: const BoxDecoration(
                      color: mainPrimaryColor,
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Container(
                          margin: const EdgeInsets.only(
                            right: 5,
                          ),
                          child: const Icon(
                            Icons.polyline_rounded,
                            color: Colors.white,
                            size: 20,
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.only(right: 40),
                          constraints: const BoxConstraints(
                            maxWidth: 130,
                          ),
                          child: Text(
                            "Site",
                            style: GoogleFonts.roboto(
                              color: Colors.white,
                              fontWeight: FontWeight.w700,
                              fontSize: 16,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    height: 96,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 15,
                    ),
                    decoration: const BoxDecoration(
                      color: Colors.white,
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Container(
                              margin: const EdgeInsets.only(
                                right: 10,
                              ),
                              child: const Icon(
                                Icons.check,
                                color: neutralSix,
                              ),
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Status Atual",
                                  style: GoogleFonts.roboto(
                                    color: neutralSix,
                                    fontWeight: FontWeight.w700,
                                    fontSize: 11,
                                  ),
                                ),
                                Text(
                                  siteStatus[
                                      widget.service.SiteService.status - 1],
                                  style: GoogleFonts.roboto(
                                    color: yellowColor,
                                    fontWeight: FontWeight.w700,
                                    fontSize: 11,
                                  ),
                                ),
                              ],
                            )
                          ],
                        ),
                        Row(
                          children: [
                            Container(
                              margin: const EdgeInsets.only(
                                right: 10,
                              ),
                              child: const Icon(
                                Icons.calendar_month,
                                color: neutralSix,
                              ),
                            ),
                            Flexible(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Data de Entrega",
                                    style: GoogleFonts.roboto(
                                      color: neutralSix,
                                      fontWeight: FontWeight.w700,
                                      fontSize: 11,
                                    ),
                                  ),
                                  Text(
                                    widget.service.SiteService.dueDate != null
                                        ? DateFormat().format(DateTime.parse(
                                            widget.service.SiteService.dueDate
                                                .toString()))
                                        : "Sem data",
                                    style: GoogleFonts.roboto(
                                      color: neutralThree,
                                      fontWeight: FontWeight.w700,
                                      fontSize: 11,
                                    ),
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              PercentageWidget(
                percentage:
                    '${getPercentage(siteStatus, widget.service.SiteService.status)}%',
              )
            ],
          ),
        ),
      ),
    );
  }
}

class SocialServiceItemFlex extends StatefulWidget {
  const SocialServiceItemFlex({
    super.key,
    required this.service,
  });

  final SocialContratedItem service;

  @override
  State<SocialServiceItemFlex> createState() => _SocialServiceItemFlexState();
}

class _SocialServiceItemFlexState extends State<SocialServiceItemFlex> {
  final serviceController = Get.put<ServiceController>(ServiceController());
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: InkWell(
        onTap: () {
          serviceController.serviceId.value = widget.service.SocialService.id;
          if (widget.service.SocialService.status == 1) {
            Get.to(const SocialBrienfingPage());
          } else {
            Get.to(SocialStatusPage(
              service: widget.service,
            ));
          }
        },
        child: Container(
          margin: const EdgeInsets.symmetric(
            horizontal: 5,
          ),
          height: 152,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8),
            boxShadow: [
              defaultBoxShadow,
            ],
          ),
          clipBehavior: Clip.antiAlias,
          child: Stack(
            alignment: Alignment.topRight,
            children: [
              Column(
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 13,
                    ),
                    height: 56,
                    decoration: const BoxDecoration(
                      color: mainPrimaryColor,
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Container(
                          margin: const EdgeInsets.only(
                            right: 5,
                          ),
                          child: const Icon(
                            Icons.polyline_rounded,
                            color: Colors.white,
                            size: 20,
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.only(right: 40),
                          constraints: const BoxConstraints(
                            maxWidth: 130,
                          ),
                          child: Text(
                            "Social",
                            style: GoogleFonts.roboto(
                              color: Colors.white,
                              fontWeight: FontWeight.w700,
                              fontSize: 16,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    height: 96,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 15,
                    ),
                    decoration: const BoxDecoration(
                      color: Colors.white,
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Container(
                              margin: const EdgeInsets.only(
                                right: 10,
                              ),
                              child: const Icon(
                                Icons.check,
                                color: neutralSix,
                              ),
                            ),
                            Flexible(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Status Atual",
                                    style: GoogleFonts.roboto(
                                      color: neutralSix,
                                      fontWeight: FontWeight.w700,
                                      fontSize: 11,
                                    ),
                                  ),
                                  Text(
                                    socialStatus[
                                        widget.service.SocialService.status -
                                            1],
                                    style: GoogleFonts.roboto(
                                      color: yellowColor,
                                      fontWeight: FontWeight.w700,
                                      fontSize: 11,
                                    ),
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                        Row(
                          children: [
                            Container(
                              margin: const EdgeInsets.only(
                                right: 10,
                              ),
                              child: const Icon(
                                Icons.calendar_month,
                                color: neutralSix,
                              ),
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Data de Entrega",
                                  style: GoogleFonts.roboto(
                                    color: neutralSix,
                                    fontWeight: FontWeight.w700,
                                    fontSize: 11,
                                  ),
                                ),
                                Text(
                                  widget.service.SocialService.dueDate != null
                                      ? DateFormat().format(DateTime.parse(
                                          widget.service.SocialService.dueDate
                                              .toString()))
                                      : "Sem data",
                                  style: GoogleFonts.roboto(
                                    color: neutralThree,
                                    fontWeight: FontWeight.w700,
                                    fontSize: 11,
                                  ),
                                ),
                              ],
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              PercentageWidget(
                percentage:
                    '${getPercentage(socialStatus, widget.service.SocialService.status)}%',
              )
            ],
          ),
        ),
      ),
    );
  }
}

class AplicationImages extends StatelessWidget {
  const AplicationImages({
    super.key,
    required this.url,
  });

  final String url;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Get.defaultDialog(
            backgroundColor: Colors.transparent,
            title: "",
            middleText: "",
            content: Container(
              color: Colors.black,
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Image.network(url),
            ));
      },
      child: Container(
        width: 127,
        height: 127,
        margin: const EdgeInsets.only(
          right: 8,
        ),
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8),
            boxShadow: [
              defaultBoxShadow,
            ]),
        clipBehavior: Clip.antiAlias,
        child: FadeInImage(
          placeholder: const AssetImage(
            "assets/images/rectangleOrange.png",
          ),
          image: NetworkImage(
            url,
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
    );
  }
}

class StatusContainer extends StatelessWidget {
  const StatusContainer({
    super.key,
    required this.isFinished,
    required this.iconLeft,
    required this.title,
    required this.subtitle,
    required this.isLoading,
    required this.onTap,
    this.haveButton,
    this.buttoName,
  });

  final bool isFinished;
  final bool isLoading;
  final bool? haveButton;
  final String? buttoName;
  final IconData iconLeft;
  final String title;
  final String subtitle;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: isLoading ? onTap : null,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 5),
        decoration: BoxDecoration(
          color: isFinished ? const Color(0xFFDCD7F4) : Colors.white,
          borderRadius: BorderRadius.circular(8),
          border: !isLoading
              ? null
              : Border.all(
                  color: mainSecondayColor,
                  width: 2,
                ),
        ),
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        margin: const EdgeInsets.only(right: 20),
                        child: Icon(
                          iconLeft,
                          color: isFinished
                              ? mainPrimaryColor
                              : isLoading
                                  ? mainSecondayColor
                                  : neutralThree,
                          size: 20,
                        ),
                      ),
                      Flexible(
                        child: Text(
                          title,
                          style: GoogleFonts.roboto(
                            fontSize: 22,
                            fontWeight: FontWeight.w700,
                            color: isFinished
                                ? mainPrimaryColor
                                : isLoading
                                    ? mainSecondayColor
                                    : neutralThree,
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                if (isLoading || isFinished)
                  if (isLoading && haveButton == true)
                    InkWell(
                      onTap: onTap,
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 5),
                        decoration: BoxDecoration(
                          color: mainSecondayColor,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Text(
                          buttoName!,
                          style: GoogleFonts.roboto(
                            fontSize: 12,
                            fontWeight: FontWeight.w400,
                            color: lightWhite,
                          ),
                        ),
                      ),
                    )
                  else
                    Icon(
                      isFinished ? Icons.check : Icons.timer,
                      color: isFinished
                          ? mainPrimaryColor
                          : isLoading
                              ? mainSecondayColor
                              : neutralThree,
                    )
              ],
            ),
            Container(
              margin: const EdgeInsets.only(top: 10),
              child: Text(
                subtitle,
                style: GoogleFonts.roboto(
                  fontSize: 12,
                  fontWeight: FontWeight.w400,
                  color: neutralThree,
                ),
                textAlign: TextAlign.justify,
              ),
            )
          ],
        ),
      ),
    );
  }
}

class RadioSelectWidget extends StatelessWidget {
  const RadioSelectWidget({
    super.key,
    required this.isSelected,
  });

  final bool isSelected;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 20,
      height: 20,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(
          width: 2,
          color: isSelected ? mainPrimaryColor : neutralTen,
        ),
      ),
      alignment: Alignment.center,
      child: isSelected
          ? Container(
              width: 10,
              height: 10,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: mainPrimaryColor,
              ),
            )
          : null,
    );
  }
}

class PercentageWidget extends StatelessWidget {
  const PercentageWidget({super.key, required this.percentage});
  final String percentage;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(right: 8),
      decoration: const BoxDecoration(
        image: DecorationImage(
          fit: BoxFit.contain,
          image: AssetImage(
            "assets/images/rectangleOrange.png",
          ),
        ),
      ),
      width: 42,
      height: 70,
      alignment: Alignment.center,
      child: Text(
        percentage,
        style: GoogleFonts.roboto(
          color: Colors.white,
          fontWeight: FontWeight.w900,
          fontSize: 13,
        ),
      ),
    );
  }
}

class BottomBarCustom extends StatefulWidget {
  const BottomBarCustom({super.key});

  @override
  State<BottomBarCustom> createState() => _BottomBarCustomState();
}

class _BottomBarCustomState extends State<BottomBarCustom> {
  final navigationController =
      Get.put<NavigationController>(NavigationController());

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: SalomonBottomBar(
        currentIndex: navigationController.indexSelected.value,
        onTap: (i) =>
            setState(() => navigationController.indexSelected.value = i),
        items: [
          SalomonBottomBarItem(
            icon: const Icon(Icons.home),
            title: const Text("Home"),
            selectedColor: Colors.purple,
          ),
          SalomonBottomBarItem(
            icon: const Icon(Icons.archive_rounded),
            title: const Text("Arquivos"),
            selectedColor: Colors.pink,
          ),
          SalomonBottomBarItem(
            icon: const Icon(Icons.payment_rounded),
            title: const Text("Pagamentos"),
            selectedColor: Colors.orange,
          ),
          SalomonBottomBarItem(
            icon: const Icon(Icons.person),
            title: const Text("Perfil"),
            selectedColor: Colors.teal,
          ),
        ],
      ),
    );
  }
}

class WidgetBuyProducts extends StatelessWidget {
  const WidgetBuyProducts({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: InkWell(
        onTap: () {
          Get.to(() => const PaymentPage());
        },
        child: Container(
          margin: const EdgeInsets.symmetric(
            horizontal: 5,
          ),
          padding: const EdgeInsets.symmetric(horizontal: 20),
          height: 152,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8),
            boxShadow: [
              defaultBoxShadow,
            ],
            gradient: const LinearGradient(
              colors: [
                Color(0xFFFE7200),
                Color(0xFFFE597C),
              ],
            ),
          ),
          clipBehavior: Clip.antiAlias,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                margin: const EdgeInsets.only(
                  right: 10,
                ),
                child: const Icon(
                  FontAwesomeIcons.cartShopping,
                  color: Colors.white,
                ),
              ),
              Flexible(
                child: Text(
                  "COMPRAR MAIS PRODUTOS",
                  style: GoogleFonts.roboto(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    color: Colors.white,
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
