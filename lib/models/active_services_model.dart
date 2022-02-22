class ActiveServiceModel
{
  late final String result;
  late final int totalresults;
  late final int startnumber;
  late final int numreturned;
  late final Orders orders;

  ActiveServiceModel.fromJson(Map<String, dynamic> json){
    result = json['result'];
    totalresults = json['totalresults'];
    startnumber = json['startnumber'];
    numreturned = json['numreturned'];
    orders = Orders.fromJson(json['orders']);
  }
}
class Orders {

  late final List<Order> order;

  Orders.fromJson(Map<String, dynamic> json){
    order = List.from(json['order']).map((e)=>Order.fromJson(e)).toList();
  }

}

class Order
{
  late final int id;
  late final int ordernum;
  late final int userid;
  late final int contactid;
  late final int requestorId;
  late final int adminRequestorId;
  late final String date;
  late final String nameservers;
  late final String transfersecret;
  late final String renewals;
  late final String promocode;
  late final String promotype;
  late final String promovalue;
  late final String orderdata;
  late final String amount;
  late final String paymentmethod;
  late final int invoiceid;
  late final String status;
  late final String ipaddress;
  late final String fraudmodule;
  late final String fraudoutput;
  late final String notes;
  late final String paymentmethodname;
  late final String paymentstatus;
  late final String name;
  late final String currencyprefix;
  late final String currencysuffix;
  late final String frauddata;
  late final String validationdata;
  late final LineItems lineitems;

  Order.fromJson(Map<String, dynamic> json){
    id = json['id'];
    ordernum = json['ordernum'];
    userid = json['userid'];
    contactid = json['contactid'];
    requestorId = json['requestor_id'];
    adminRequestorId = json['admin_requestor_id'];
    date = json['date'];
    nameservers = json['nameservers'];
    transfersecret = json['transfersecret'];
    renewals = json['renewals'];
    promocode = json['promocode'];
    promotype = json['promotype'];
    promovalue = json['promovalue'];
    orderdata = json['orderdata'];
    amount = json['amount'];
    paymentmethod = json['paymentmethod'];
    invoiceid = json['invoiceid'];
    status = json['status'];
    ipaddress = json['ipaddress'];
    fraudmodule = json['fraudmodule'];
    fraudoutput = json['fraudoutput'];
    notes = json['notes'];
    paymentmethodname = json['paymentmethodname'];
    paymentstatus = json['paymentstatus'];
    name = json['name'];
    currencyprefix = json['currencyprefix'];
    currencysuffix = json['currencysuffix'];
    frauddata = json['frauddata'];
    validationdata = json['validationdata'];
    lineitems = LineItems.fromJson(json['lineitems']);
  }

}
class LineItems {

  late final List<LineItem> lineitem;

  LineItems.fromJson(Map<String, dynamic> json){
    lineitem = List.from(json['lineitem']).map((e)=>LineItem.fromJson(e)).toList();
  }

}

class LineItem {
  late final String type;
  late final int relid;
  late final String producttype;
  late final String product;
  late final String domain;
  late final String billingcycle;
  late final String amount;
  late final String status;

  LineItem.fromJson(Map<String, dynamic> json){
    type = json['type'];
    relid = json['relid'];
    producttype = json['producttype'];
    product = json['product'];
    domain = json['domain'];
    billingcycle = json['billingcycle'];
    amount = json['amount'];
    status = json['status'];
  }

}