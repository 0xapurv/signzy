import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:signzy/core/normalizeDate.dart';
import 'package:signzy/helper/contants.dart';
import 'package:sms/contact.dart';
import 'package:sms/sms.dart';

class MessageModel {
  final int id;
  final String name;
  final String message;
  final String time;

  MessageModel({
    this.id,
    this.name,
    this.message,
    this.time,
  });
}

class Methods {
  double debitAmount = 0.0;
  double creditAmount = 0.0;
  List<double> arr;

  List<MessageModel> messages = [];
  List<MessageModel> filterMessages1 = [];
  List<MessageModel> debitMessage = [];
  List<MessageModel> creditMessage = [];

  Future<MessageModel> convertSmsToMessage(SmsMessage sms) async {
    String formattedDate = normalizeDate(sms.date);

    String address = sms.address;
    ContactQuery contacts = new ContactQuery();
    Contact contact = await contacts.queryContact(address);
    String messageAddress =
        contact.fullName ?? contact.firstName ?? contact.lastName ?? address;
    print(sms.id);
    print(messageAddress);
    return new MessageModel(
      id: sms.id,
      name: messageAddress,
      message: sms.body,
      time: formattedDate,
    );
  }

  Future<List<MessageModel>> getMessageData(int type) async {
    SmsQuery query = new SmsQuery();
    List<SmsMessage> smsList = await query.querySms();
    List<MessageModel> messageList = [];

    for (SmsMessage sms in smsList) {
      MessageModel msg = await convertSmsToMessage(sms);
      messageList.add(msg);
    }
    messages = messageList;
    return filter1(type);
  }

  Future<List<MessageModel>> filter1(int type) async {
    for (MessageModel model in messages) {
      if ((model.name.contains("PAY") ||
          model.name.contains("UPI") ||
          model.name.contains("PAYTM") ||
          model.name.contains("PHONPE") ||
          model.name.contains("ACB") ||
          model.name.contains("ALB") ||
          model.name.contains("ANB") ||
          model.name.contains("APN") ||
          model.name.contains("AXB") ||
          model.name.contains("BOB") ||
          model.name.contains("BOI") ||
          model.name.contains("BOM") ||
          model.name.contains("BMB") ||
          model.name.contains("CNB") ||
          model.name.contains("CBI") ||
          model.name.contains("CRB") ||
          model.name.contains("DCB") ||
          model.name.contains("DNB") ||
          model.name.contains("FBL") ||
          model.name.contains("GSC") ||
          model.name.contains("HCB") ||
          model.name.contains("HDF") ||
          model.name.contains("ICI") ||
          model.name.contains("IDB") ||
          model.name.contains("INB") ||
          model.name.contains("IOB") ||
          model.name.contains("IIB") ||
          model.name.contains("ING") ||
          model.name.contains("JSB") ||
          model.name.contains("KTB") ||
          model.name.contains("KVB") ||
          model.name.contains("KMB") ||
          model.name.contains("MUC") ||
          model.name.contains("NTB") ||
          model.name.contains("NGB") ||
          model.name.contains("OBC") ||
          model.name.contains("PMC") ||
          model.name.contains("PSB") ||
          model.name.contains("PNB") ||
          model.name.contains("RBL") ||
          model.name.contains("SRC") ||
          model.name.contains("SBJ") ||
          model.name.contains("SBH") ||
          model.name.contains("SBI") ||
          model.name.contains("SBM") ||
          model.name.contains("SBP") ||
          model.name.contains("SBT") ||
          model.name.contains("SYB") ||
          model.name.contains("TMB") ||
          model.name.contains("SIB") ||
          model.name.contains("UCO") ||
          model.name.contains("UOB") ||
          model.name.contains("UBI") ||
          model.name.contains("VJB") ||
          model.name.contains("YBL") ||
          model.name.contains("ABHY") ||
          model.name.contains("ALLA") ||
          model.name.contains("ANDB") ||
          model.name.contains("ASBL") ||
          model.name.contains("UTIB") ||
          model.name.contains("BARB") ||
          model.name.contains("BKID") ||
          model.name.contains("MAHB") ||
          model.name.contains("BMBL") ||
          model.name.contains("CNRB") ||
          model.name.contains("CBIN") ||
          model.name.contains("CORP") ||
          model.name.contains("DCBL") ||
          model.name.contains("BKDN") ||
          model.name.contains("FDRL") ||
          model.name.contains("GSCB") ||
          model.name.contains("HCBL") ||
          model.name.contains("HDFC") ||
          model.name.contains("ICICI") ||
          model.name.contains("IBKL") ||
          model.name.contains("IDIB") ||
          model.name.contains("IOBA") ||
          model.name.contains("INDB") ||
          model.name.contains("VYSA") ||
          model.name.contains("JSBP") ||
          model.name.contains("KARB") ||
          model.name.contains("KVBL") ||
          model.name.contains("KKBK") ||
          model.name.contains("MSNU") ||
          model.name.contains("NTBL") ||
          model.name.contains("NKGS") ||
          model.name.contains("ORBC") ||
          model.name.contains("PMCB") ||
          model.name.contains("PSIB") ||
          model.name.contains("PUNB") ||
          model.name.contains("RATN") ||
          model.name.contains("SRCB") ||
          model.name.contains("SBBJ") ||
          model.name.contains("SBHY") ||
          model.name.contains("SBIN") ||
          model.name.contains("SBMY") ||
          model.name.contains("STBP") ||
          model.name.contains("SBTR") ||
          model.name.contains("SYNB") ||
          model.name.contains("TMBL") ||
          model.name.contains("SIBL") ||
          model.name.contains("UCBA") ||
          model.name.contains("UBIN") ||
          model.name.contains("UTBI") ||
          model.name.contains("VIJB") ||
          model.name.contains("YESB")) &&
          !model.name.contains("OTP")) {
        filterMessages1.add(model);
      }
    }
    return filter2(type);
  }

  Future<List<MessageModel>> filter2(int type) async {
    for (MessageModel model in filterMessages1) {
      if ((model.message.contains("debit")) ||
          (model.message.contains("used")) ||
          (model.message.contains("deducted")) ||
          (model.message.contains("withdraw")) && !model.name.contains("OTP")) {
        debitMessage.add(model);
        var arr1 = model.message.split("Rs.");
        var arr2 = model.message.split("Rs");
        var arr3 = model.message.split("INR");
        if (arr1.length > 1) {
          if (arr1[1].split(" ")[0] == "") {
            print(arr1[1].split(" ")[0]);
            debitAmount = debitAmount + double.parse(arr1[1].split(" ")[1]);
          } else {
            debitAmount = debitAmount + double.parse(arr1[1].split(" ")[0]);
          }
        }
        else if (arr2.length > 1) {
          if (arr2[1].split(" ")[0] == "") {
            print(arr2[1].split(" ")[0]);
            debitAmount = debitAmount + double.parse(arr2[1].split(" ")[1]);
          } else {
            debitAmount = debitAmount + double.parse(arr2[1].split(" ")[0]);
          }
        }

        else if (arr3.length > 1) {
          if (arr3[1].split(" ")[0] == "") {
            print(arr3[1].split(" ")[0]);
            debitAmount = debitAmount + double.parse(arr3[1].split(" ")[1]);
          } else {
            debitAmount = debitAmount + double.parse(arr3[1].split(" ")[0]);
          }
        }
      }
    }
    for (MessageModel model in filterMessages1) {
      if ((model.message.contains("credited")) ||
          (model.message.contains("deposited")) &&
              !model.name.contains("OTP")) {
        creditMessage.add(model);
        var arr1 = model.message.split("Rs.");
        var arr2 = model.message.split("Rs");
        var arr3 = model.message.split("INR");
        if (arr1.length > 1) {
          if (arr1[1].split(" ")[0] == "") {
            print(arr1[1].split(" ")[0]);
            creditAmount = creditAmount + double.parse(arr1[1].split(" ")[1]);
          } else {
            creditAmount = creditAmount + double.parse(arr1[1].split(" ")[0]);
          }
        }
        else if (arr2.length > 1) {
          if (arr2[1].split(" ")[0] == "") {
            print(arr2[1].split(" ")[0]);
            creditAmount = creditAmount + double.parse(arr2[1].split(" ")[1]);
          } else {
            creditAmount = creditAmount + double.parse(arr2[1].split(" ")[0]);
          }
        }

        else if (arr3.length > 1) {
          if (arr3[1].split(" ")[0] == "") {
            print(arr3[1].split(" ")[0]);
            creditAmount = creditAmount + double.parse(arr3[1].split(" ")[1]);
          } else {
            creditAmount = creditAmount + double.parse(arr3[1].split(" ")[0]);
          }
        }
      }
    }
    if (type == 1)
      return debitMessage;
    else
      return creditMessage;
  }
  Future <List<double>> getTransaction() async{
     getMessageData(1).then((value) {arr.add(debitAmount);
     arr.add(creditAmount);} );

     return arr;
  }
}
