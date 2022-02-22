class InvoiceDetails
{
late final String result;
late final int invoiceid;
late final String invoicenum;
late final int userid;
late final String date;
late final String duedate;
late final String datepaid;
late final String lastcaptureattempt;
late final String subtotal;
late final String credit;
late final String tax;
late final String tax2;
late final String total;
late final String balance;
late final String taxrate;
late final String taxrate2;
late final String status;
late final String paymentmethod;
late final String notes;
late final bool ccgateway;
late final Items items;
late final String transactions;

InvoiceDetails.fromJson(Map<String, dynamic> json){
result = json['result'];
invoiceid = json['invoiceid'];
invoicenum = json['invoicenum'];
userid = json['userid'];
date = json['date'];
duedate = json['duedate'];
datepaid = json['datepaid'];
lastcaptureattempt = json['lastcaptureattempt'];
subtotal = json['subtotal'];
credit = json['credit'];
tax = json['tax'];
tax2 = json['tax2'];
total = json['total'];
balance = json['balance'];
taxrate = json['taxrate'];
taxrate2 = json['taxrate2'];
status = json['status'];
paymentmethod = json['paymentmethod'];
notes = json['notes'];
ccgateway = json['ccgateway'];
items = Items.fromJson(json['items']);
transactions = json['transactions'];
}
}

class Items
{
  late final List<Item> item;

  Items.fromJson(Map<String, dynamic> json){
    item = List.from(json['item']).map((e)=>Item.fromJson(e)).toList();
  }
}

class Item
{
  late final int id;
  late final String type;
  late final int relid;
  late final String description;
  late final String amount;
  late final int taxed;

  Item.fromJson(Map<String, dynamic> json){
    id = json['id'];
    type = json['type'];
    relid = json['relid'];
    description = json['description'];
    amount = json['amount'];
    taxed = json['taxed'];
  }
}