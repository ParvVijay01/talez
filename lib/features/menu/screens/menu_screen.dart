import 'package:flutter_social_button/flutter_social_button.dart';
import 'package:hexacom_user/common/models/config_model.dart';
import 'package:hexacom_user/common/widgets/custom_alert_dialog_widget.dart';
import 'package:hexacom_user/common/widgets/custom_app_bar_widget.dart';
import 'package:hexacom_user/common/widgets/custom_image_widget.dart';
import 'package:hexacom_user/common/widgets/language_select_widget.dart';
import 'package:hexacom_user/common/widgets/social_media_launcher.dart';
import 'package:hexacom_user/common/widgets/theme_switch_button_widget.dart';
import 'package:hexacom_user/features/auth/providers/auth_provider.dart';
import 'package:hexacom_user/features/language/widgets/language_select_button_widget.dart';
import 'package:hexacom_user/features/menu/widgets/menu_web_widget.dart';
import 'package:hexacom_user/features/menu/widgets/portion_widget.dart';
import 'package:hexacom_user/features/profile/providers/profile_provider.dart';
import 'package:hexacom_user/features/splash/providers/splash_provider.dart';
import 'package:hexacom_user/helper/responsive_helper.dart';
import 'package:hexacom_user/localization/language_constrants.dart';
import 'package:hexacom_user/provider/language_provider.dart';
import 'package:hexacom_user/utill/app_constants.dart';
import 'package:hexacom_user/utill/dimensions.dart';
import 'package:hexacom_user/utill/images.dart';
import 'package:hexacom_user/utill/routes.dart';
import 'package:hexacom_user/utill/styles.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shimmer_animation/shimmer_animation.dart';

class MenuScreen extends StatefulWidget {
  const MenuScreen({super.key});

  @override
  State<MenuScreen> createState() => _MenuScreenState();
}

class _MenuScreenState extends State<MenuScreen> {
  @override
  Widget build(BuildContext context) {
    final AuthProvider authProvider =
        Provider.of<AuthProvider>(context, listen: false);
    final SplashProvider splashProvider =
        Provider.of<SplashProvider>(context, listen: false);
    final ConfigModel? configModel = splashProvider.configModel;
    final policyModel =
        Provider.of<SplashProvider>(context, listen: false).policyModel;

    return Scaffold(
      appBar: ResponsiveHelper.isDesktop(context)
          ? const CustomAppBarWidget()
          : null,
      body: Consumer<ProfileProvider>(builder: (ctx, userController, _) {
        final bool isLoggedIn = authProvider.isLoggedIn();

        return ResponsiveHelper.isDesktop(context)
            ? MenuWebWidget(isLoggedIn: isLoggedIn)
            : Column(children: [
                Container(
                  decoration:
                      BoxDecoration(color: Theme.of(context).primaryColor),
                  child: Padding(
                    padding: const EdgeInsets.only(
                      left: Dimensions.paddingSizeExtraLarge,
                      right: Dimensions.paddingSizeExtraLarge,
                      top: 50,
                      bottom: Dimensions.paddingSizeExtraLarge,
                    ),
                    child: Row(children: [
                      Container(
                        decoration: BoxDecoration(
                          color: Theme.of(context).secondaryHeaderColor,
                          shape: BoxShape.circle,
                        ),
                        padding: const EdgeInsets.all(1),
                        child: ClipOval(
                            child: CustomImageWidget(
                          placeholder: Images.profile,
                          image: '${configModel?.baseUrls?.customerImageUrl}'
                              '/${(userController.userInfoModel != null && isLoggedIn) ? userController.userInfoModel!.image : ''}',
                          height: 60,
                          width: 60,
                          fit: BoxFit.cover,
                        )),
                      ),
                      const SizedBox(width: Dimensions.paddingSizeDefault),
                      Expanded(
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              isLoggedIn && userController.userInfoModel == null
                                  ? Shimmer(
                                      duration: const Duration(seconds: 2),
                                      enabled: true,
                                      child: Container(
                                        height: Dimensions.paddingSizeDefault,
                                        width: 200,
                                        decoration: BoxDecoration(
                                          color: Theme.of(context).shadowColor,
                                          borderRadius: BorderRadius.circular(
                                              Dimensions.radiusSizeSmall),
                                        ),
                                      ),
                                    )
                                  : Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          isLoggedIn
                                              ? '${userController.userInfoModel?.fName} ${userController.userInfoModel?.lName}'
                                              : getTranslated(
                                                  'guest_user', context),
                                          style: rubikBold.copyWith(
                                              fontSize:
                                                  Dimensions.fontSizeExtraLarge,
                                              color:
                                                  Theme.of(context).cardColor),
                                        ),
                                        if (isLoggedIn)
                                          Text(
                                            userController
                                                    .userInfoModel?.email ??
                                                '',
                                            style: rubikRegular.copyWith(
                                                fontSize:
                                                    Dimensions.fontSizeSmall,
                                                color: Theme.of(context)
                                                    .cardColor),
                                          ),
                                      ],
                                    ),
                              const SizedBox(
                                  height: Dimensions.paddingSizeExtraSmall),
                            ]),
                      ),
                      const ThemeSwitchButtonWidget(fromWebBar: false),
                    ]),
                  ),
                ),
                Expanded(
                    child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: Ink(
                    padding:
                        const EdgeInsets.only(top: Dimensions.paddingSizeLarge),
                    child: Column(children: [
                      Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: Dimensions.paddingSizeDefault),
                              child: Text(
                                getTranslated('general', context),
                                style: rubikMedium.copyWith(
                                    fontSize: Dimensions.fontSizeDefault,
                                    color: Theme.of(context)
                                        .primaryColor
                                        .withOpacity(0.5)),
                              ),
                            ),
                            Container(
                              decoration: BoxDecoration(
                                color: Theme.of(context).cardColor,
                                borderRadius: BorderRadius.circular(
                                    Dimensions.radiusSizeDefault),
                                boxShadow: const [
                                  BoxShadow(
                                      color: Colors.black12,
                                      spreadRadius: 1,
                                      blurRadius: 5)
                                ],
                              ),
                              padding: const EdgeInsets.symmetric(
                                  horizontal: Dimensions.paddingSizeLarge,
                                  vertical: Dimensions.paddingSizeDefault),
                              margin: const EdgeInsets.all(
                                  Dimensions.paddingSizeDefault),
                              child: Column(children: [
                                PortionWidget(
                                    imageIcon: Images.profileMenuIcon,
                                    title: getTranslated('profile', context),
                                    route: () =>
                                        RouteHelper.getProfileRoute(context)),
                                PortionWidget(
                                    imageIcon: Images.trackOrder,
                                    title:
                                        getTranslated('track_order', context),
                                    route: () =>
                                        RouteHelper.getOrderSearchScreen(
                                            context)),
                                PortionWidget(
                                    imageIcon: Images.order,
                                    title: getTranslated('my_orders', context),
                                    route: () => RouteHelper.getOrderListScreen(
                                        context)),
                                PortionWidget(
                                    imageIcon: Images.address,
                                    title: getTranslated('my_address', context),
                                    route: () =>
                                        RouteHelper.getAddressRoute(context)),
                                PortionWidget(
                                    imageIcon: Images.couponMenuIcon,
                                    title: getTranslated('coupon', context),
                                    route: () =>
                                        RouteHelper.getCouponRoute(context)),
                                InkWell(
                                  onTap: () {
                                    Provider.of<LanguageProvider>(context,
                                            listen: false)
                                        .initializeAllLanguages(context);
                                    showModalBottomSheet(
                                      backgroundColor: Colors.transparent,
                                      isScrollControlled: true, // 🟢 Important!
                                      context: context,
                                      builder: (ctx) =>
                                          DraggableScrollableSheet(
                                        initialChildSize: 0.7,
                                        minChildSize: 0.4,
                                        maxChildSize: 0.95,
                                        expand: false,
                                        builder: (context, scrollController) =>
                                            Container(
                                          padding: const EdgeInsets.all(
                                              Dimensions.paddingSizeDefault),
                                          decoration: BoxDecoration(
                                            color:
                                                Theme.of(context).canvasColor,
                                            borderRadius:
                                                ResponsiveHelper.isMobile(
                                                        context)
                                                    ? const BorderRadius.only(
                                                        topLeft:
                                                            Radius.circular(20),
                                                        topRight:
                                                            Radius.circular(20),
                                                      )
                                                    : const BorderRadius.all(
                                                        Radius.circular(20)),
                                          ),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Center(
                                                child: Container(
                                                  height: 4,
                                                  width: 40,
                                                  margin: const EdgeInsets.only(
                                                      bottom: 12),
                                                  decoration: BoxDecoration(
                                                    color: Theme.of(context)
                                                        .dividerColor,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            25),
                                                  ),
                                                ),
                                              ),
                                              Text(
                                                getTranslated(
                                                    'select_language', context),
                                                style: rubikMedium,
                                              ),
                                              const SizedBox(
                                                  height: Dimensions
                                                      .paddingSizeExtraSmall),
                                              Text(
                                                getTranslated(
                                                    'choose_the_language',
                                                    context),
                                                style: rubikRegular.copyWith(
                                                  fontSize:
                                                      Dimensions.fontSizeSmall,
                                                ),
                                              ),
                                              const SizedBox(
                                                  height: Dimensions
                                                      .paddingSizeLarge),

                                              /// 🟣 Replace `Flexible` + `SingleChildScrollView` with Expanded + ListView
                                              Expanded(
                                                child: ListView(
                                                  controller: scrollController,
                                                  children: [
                                                    LanguageSelectWidget(
                                                        fromMenu: true),
                                                  ],
                                                ),
                                              ),

                                              const SizedBox(
                                                  height: Dimensions
                                                      .paddingSizeDefault),
                                              const LanguageSelectButtonWidget(
                                                  fromMenu: true),
                                            ],
                                          ),
                                        ),
                                      ),
                                    );
                                  },
                                  child: PortionWidget(
                                    imageIcon: Images.language,
                                    title: getTranslated('language', context),
                                    hideDivider: true,
                                  ),
                                )
                              ]),
                            )
                          ]),
                      Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: Dimensions.paddingSizeDefault),
                              child: Text(
                                getTranslated('help_and_support', context),
                                style: rubikMedium.copyWith(
                                    fontSize: Dimensions.fontSizeDefault,
                                    color: Theme.of(context)
                                        .primaryColor
                                        .withOpacity(0.5)),
                              ),
                            ),
                            Container(
                              decoration: BoxDecoration(
                                color: Theme.of(context).cardColor,
                                borderRadius: BorderRadius.circular(
                                    Dimensions.radiusSizeDefault),
                                boxShadow: const [
                                  BoxShadow(
                                      color: Colors.black12,
                                      spreadRadius: 1,
                                      blurRadius: 5)
                                ],
                              ),
                              padding: const EdgeInsets.symmetric(
                                  horizontal: Dimensions.paddingSizeLarge,
                                  vertical: Dimensions.paddingSizeDefault),
                              margin: const EdgeInsets.all(
                                  Dimensions.paddingSizeDefault),
                              child: Column(children: [
                                // PortionWidget(imageIcon: Images.message, title: getTranslated('live_chat', context), route: ()=>  RouteHelper.getChatRoute(context)),
                                PortionWidget(
                                    imageIcon: Images.helpSupport,
                                    title: getTranslated(
                                        'help_and_support', context),
                                    route: () =>
                                        RouteHelper.getSupportRoute(context)),
                                PortionWidget(
                                    imageIcon: Images.aboutUs,
                                    title: getTranslated('about_us', context),
                                    route: () =>
                                        RouteHelper.getAboutUsRoute(context)),
                                PortionWidget(
                                    imageIcon: Images.termsAndCondition,
                                    title: getTranslated(
                                        'terms_and_condition', context),
                                    route: () =>
                                        RouteHelper.getTermsRoute(context)),
                                PortionWidget(
                                    imageIcon: Images.privacyPolicy,
                                    title: getTranslated(
                                        'privacy_policy', context),
                                    route: () =>
                                        RouteHelper.getPolicyRoute(context)),

                                if (policyModel?.refundPage?.status ?? false)
                                  PortionWidget(
                                      imageIcon: Images.refundPolicy,
                                      title: getTranslated(
                                          'refund_policy', context),
                                      route: () =>
                                          RouteHelper.getRefundPolicyRoute(
                                              context)),

                                if (policyModel?.returnPage?.status ?? false)
                                  PortionWidget(
                                      imageIcon: Images.refundPolicy,
                                      title: getTranslated(
                                          'return_policy', context),
                                      route: () =>
                                          RouteHelper.getReturnPolicyRoute(
                                              context)),

                                if (policyModel?.cancellationPage?.status ??
                                    false)
                                  PortionWidget(
                                      imageIcon: Images.cancellationPolicy,
                                      title: getTranslated(
                                          'cancellation_policy', context),
                                      route: () => RouteHelper
                                          .getCancellationPolicyRoute(context),
                                      hideDivider: true),
                              ]),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Center(
                                    child: IconButton(
                                  onPressed: () => openSocialMedia(
                                      "https://www.facebook.com/share/1EZxgL2L41/?mibextid=wwXIfr"),
                                  icon: Icon(
                                    FontAwesomeIcons.facebook,
                                    size: 20,
                                    color: Colors.blue,
                                  ),
                                )),
                                Center(
                                  child: IconButton(
                                    onPressed: () => openSocialMedia(
                                        "https://www.instagram.com/talez_chd?igsh=emhjaG5rcTU0OXFq&utm_source=qr"),
                                    icon: ShaderMask(
                                      shaderCallback: (Rect bounds) {
                                        return LinearGradient(
                                          colors: [
                                            Color(0xFFFEDA75), // Yellow
                                            Color(0xFFFA7E1E), // Orange
                                            Color(0xFFD62976), // Pinkish Red
                                            Color(0xFF962FBF), // Purple
                                            Color(0xFF4F5BD5), // Deep Blue
                                          ],
                                          begin: Alignment.topLeft,
                                          end: Alignment.bottomRight,
                                        ).createShader(bounds);
                                      },
                                      child: Icon(
                                        FontAwesomeIcons.instagram,
                                        size: 20,
                                        color: Colors
                                            .white, // Keep white to allow gradient to show
                                      ),
                                    ),
                                  ),
                                ),
                                Center(
                                    child: IconButton(
                                  onPressed: () => openSocialMedia(
                                      "https://youtube.com/@talezchd?si=RIH_EqKhVvTndsgA"),
                                  icon: Icon(
                                    FontAwesomeIcons.youtube,
                                    size: 20,
                                    color: Colors.red,
                                  ),
                                )),
                                Center(
                                    child: IconButton(
                                  onPressed: () => openSocialMedia(
                                      "https://snapchat.com/t/9JbNdhjS"),
                                  icon: Icon(
                                    FontAwesomeIcons.snapchat,
                                    size: 20,
                                    color:
                                        const Color.fromARGB(255, 224, 202, 0),
                                  ),
                                )),
                              ],
                            )
                          ]),
                      if (isLoggedIn)
                        Container(
                          margin: const EdgeInsets.symmetric(
                              horizontal: Dimensions.paddingSizeDefault),
                          padding: const EdgeInsets.symmetric(
                              horizontal: Dimensions.paddingSizeLarge),
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                InkWell(
                                  onTap: () {
                                    ResponsiveHelper.showDialogOrBottomSheet(
                                        context, Consumer<AuthProvider>(builder:
                                            (context, authProvider, _) {
                                      return CustomAlertDialogWidget(
                                        title: getTranslated(
                                            'are_you_sure_to_delete_account',
                                            context),
                                        subTitle: getTranslated(
                                            'it_will_remove_your_all_information',
                                            context),
                                        icon: Icons.contact_support_outlined,
                                        isLoading: authProvider.isLoading,
                                        onPressRight: () =>
                                            authProvider.deleteUser(),
                                      );
                                    }));
                                  },
                                  child: PortionWidget(
                                      imageIcon: Images.userDeleteIcon,
                                      title: getTranslated(
                                          'delete_account', context),
                                      hideDivider: true),
                                ),
                              ]),
                        ),
                      InkWell(
                        onTap: () {
                          if (isLoggedIn) {
                            ResponsiveHelper.showDialogOrBottomSheet(
                                context,
                                CustomAlertDialogWidget(
                                  title: getTranslated(
                                      'want_to_sign_out', context),
                                  icon: Icons.contact_support_outlined,
                                  onPressRight: () async {
                                    await Provider.of<AuthProvider>(context,
                                            listen: false)
                                        .clearSharedData();
                                    Navigator.pop(context);
                                    RouteHelper.getDashboardRoute(
                                        context, 'home',
                                        action: RouteAction
                                            .pushNamedAndRemoveUntil);
                                  },
                                ));
                          } else {
                            RouteHelper.getLoginRoute(context,
                                action: RouteAction.push);
                          }
                        },
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: Dimensions.paddingSizeSmall),
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                  padding: const EdgeInsets.all(2),
                                  decoration: const BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: Colors.red),
                                  child: Icon(Icons.power_settings_new_sharp,
                                      size: Dimensions.paddingSizeDefault,
                                      color: Theme.of(context).cardColor),
                                ),
                                const SizedBox(
                                    width: Dimensions.paddingSizeExtraSmall),
                                Text(
                                    isLoggedIn
                                        ? getTranslated('logout', context)
                                        : getTranslated('sign_in', context),
                                    style: rubikRegular),
                              ]),
                        ),
                      ),
                      const SizedBox(height: Dimensions.paddingSizeLarge),
                      Text(
                          '${getTranslated('version', context)} ${AppConstants.appVersion}',
                          style: rubikMedium.copyWith(
                            color: Theme.of(context)
                                .textTheme
                                .titleMedium
                                ?.color
                                ?.withOpacity(0.4),
                          )),
                      const SizedBox(height: Dimensions.paddingSizeExtraLarge),
                    ]),
                  ),
                )),
              ]);
      }),
    );
  }
}
