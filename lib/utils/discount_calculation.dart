double discountPrice(num discount, num itemPrice){
  double discountPrice = (discount/100) * itemPrice;
  return itemPrice - discountPrice;
}