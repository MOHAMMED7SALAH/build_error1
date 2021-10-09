import 'package:firebase_admob/firebase_admob.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:saffi/controller/userController.dart';
import 'package:saffi/helper/ad_manager.dart';
import 'package:saffi/helper/appLocalization.dart';
import 'package:saffi/ui/Pages/cart/CartPage.dart';
import 'package:saffi/ui/Pages/shop/shopScreen.dart';
import 'package:saffi/ui/Pages/user/userProfile/profilePage.dart';
import 'package:saffi/ui/Pages/wishList/WishListPage.dart';
import 'package:saffi/ui/widget/CustomNavBar.dart';
import 'package:saffi/ui/widget/custom_alert.dart';

class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage>
    with SingleTickerProviderStateMixin {
  // COMPLETE: Add _isRewardedAdReady
  bool _isRewardedAdReady;

  var _bottomNavIndex = 0;

  List<Widget> widgets = [
    ShopPage(),
    CartPage(),
    WishListPage(),
    ProfilePage(),
  ];
  @override
  void initState() {
    super.initState();

    // COMPLETE: Initialize _isRewardedAdReady
    _isRewardedAdReady = false;

    // COMPLETE: Set Rewarded Ad Event listener
    RewardedVideoAd.instance.listener = _onRewardedAdEvent;

    // COMPLETE: Load a Rewarded Ad
    _loadRewardedAd();
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: localization.text("lang") == "ar"
          ? TextDirection.rtl
          : TextDirection.ltr,
      child: Scaffold(
        // key: drawerKey,
        // drawer: CustomDrawer(),
        extendBody: true,
        body: FutureBuilder(
          future: _initAdMob(),
          builder: (context, snapshot) {
            return widgets[_bottomNavIndex];
          },
        ),
        floatingActionButton: _buildFloatingActionButton(),
        bottomNavigationBar: AppBottomBar(
          onTap: (v) {
            setState(() {
              _bottomNavIndex = v;
            });
          },
        ),
      ),
    );
  }

  // COMPLETE: Implement _onRewardedAdEvent()
  void _onRewardedAdEvent(RewardedVideoAdEvent event,
      {String rewardType, int rewardAmount}) {
    switch (event) {
      case RewardedVideoAdEvent.loaded:
        setState(() {
          _isRewardedAdReady = true;
        });
        break;
      case RewardedVideoAdEvent.closed:
        setState(() {
          _isRewardedAdReady = false;
        });
        _loadRewardedAd();
        break;
      case RewardedVideoAdEvent.failedToLoad:
        setState(() {
          _isRewardedAdReady = false;
        });
        _loadRewardedAd();
        print('Failed to load a rewarded ad');
        break;
      case RewardedVideoAdEvent.rewarded:
        Provider.of<UserController>(context, listen: false)
            .increasePoints(context, points: rewardAmount);
        print("ass reworded");
        _loadRewardedAd();

        break;
      default:
      // do nothing
    }
  }

  // COMPLETE: Implement _loadRewardedAd()
  void _loadRewardedAd() {
    RewardedVideoAd.instance.load(
      targetingInfo: MobileAdTargetingInfo(),
      adUnitId: AdManager.rewardedAdUnitId,
    );
  }

  Widget _buildFloatingActionButton() {
    // COMPLETE: Return a FloatingActionButton if a Rewarded Ad is available
    return (_isRewardedAdReady)
        ? FloatingActionButton.extended(
            onPressed: () {
              CustomAlert().showOptionDialog(
                  btnMsg: localization.text("ok"),
                  cancel: localization.text("cancel"),
                  context: context,
                  msg: localization.text("WatchanAdtogetaPoint"),
                  onCancel: () => Navigator.pop(context),
                  onClick: () {
                    Navigator.pop(context);
                    RewardedVideoAd.instance.show();
                  });
            },
            label: Text(localization.text("getPoints"),
                style: TextStyle(color: Colors.white)),
            icon: Icon(
              Icons.card_giftcard,
              color: Colors.white,
            ),
          )
        : null;
  }

  Future<void> _initAdMob() {
    return FirebaseAdMob.instance.initialize(appId: AdManager.appId);
  }
}
