import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:emartstore/constants.dart';
import 'package:emartstore/main.dart';
import 'package:emartstore/model/User.dart';
import 'package:emartstore/model/VendorModel.dart';
import 'package:emartstore/model/inbox_model.dart';
import 'package:emartstore/services/FirebaseHelper.dart';
import 'package:emartstore/services/helper.dart';
import 'package:emartstore/ui/chat_screen/chat_screen.dart';
import 'package:flutterflow_paginate_firestore/paginate_firestore.dart';

class InboxScreen extends StatefulWidget {
  const InboxScreen({Key? key}) : super(key: key);

  @override
  State<InboxScreen> createState() => _InboxScreenState();
}

class _InboxScreenState extends State<InboxScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PaginateFirestore(
        //item builder type is compulsory.
        shrinkWrap: true,
        itemBuilder: (context, documentSnapshots, index) {
          final data = documentSnapshots[index].data() as Map<String, dynamic>?;
          InboxModel inboxModel = InboxModel.fromJson(data!);
          return InkWell(
            onTap: () async {
              await showProgress(context, "Please wait".tr(), false);

              User? customer = await FireStoreUtils.getCurrentUser(inboxModel.customerId.toString());
              User? restaurantUser = await FireStoreUtils.getCurrentUser(inboxModel.restaurantId.toString());
              VendorModel? vendorModel = await FireStoreUtils.getVendor(restaurantUser!.vendorID.toString());
              hideProgress();
              push(
                  context,
                  ChatScreens(
                    customerName: '${customer!.firstName + " " + customer.lastName}',
                    restaurantName: vendorModel!.title,
                    orderId: inboxModel.orderId,
                    restaurantId: restaurantUser.userID,
                    customerId: customer.userID,
                    customerProfileImage: customer.profilePictureURL,
                    restaurantProfileImage: vendorModel.photo,
                  ));
            },
            child: ListTile(
              leading: ClipOval(
                child: CachedNetworkImage(
                    width: 50,
                    height: 50,
                    imageUrl: inboxModel.customerProfileImage.toString(),
                    imageBuilder: (context, imageProvider) => Container(
                          width: 50,
                          height: 50,
                          decoration: BoxDecoration(
                              image: DecorationImage(
                            image: imageProvider,
                            fit: BoxFit.cover,
                          )),
                        ),
                    errorWidget: (context, url, error) => ClipRRect(
                        borderRadius: BorderRadius.circular(5),
                        child: Image.network(
                          placeholderImage,
                          fit: BoxFit.cover,
                        ))),
              ),
              title: Row(
                children: [
                  Expanded(child: Text(inboxModel.customerName.toString())),
                  Text(DateFormat('MMM d, yyyy').format(DateTime.fromMillisecondsSinceEpoch(inboxModel.createdAt!.millisecondsSinceEpoch)),style: TextStyle(color: Colors.grey,fontSize: 14)),
                ],
              ),
              subtitle: Text("Order Id : #" + inboxModel.orderId.toString()),
            ),
          );
        },
        onEmpty: Center(child: Text("No Conversion found")),
        // orderBy is compulsory to enable pagination
        query: FirebaseFirestore.instance.collection('chat_store').where("restaurantId", isEqualTo: MyAppState.currentUser!.userID).orderBy('createdAt',descending: true),
        //Change types customerId
        itemBuilderType: PaginateBuilderType.listView,
        // to fetch real-time data
        isLive: true,
      ),
    );
  }
}
