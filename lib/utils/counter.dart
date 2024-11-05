class Counter{
  int value = 0;

  void decrement(){
    if(value>0){
      value--;
    }
  }
  void increment(){
      value++;
  }

  void reset(){
    value = 0;
  }

}