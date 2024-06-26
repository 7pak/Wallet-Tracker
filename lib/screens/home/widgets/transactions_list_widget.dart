import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class TransactionsList extends StatelessWidget {
  const TransactionsList({super.key});


  Widget _transacitonItem(){
    return Container(
      margin: EdgeInsets.only(bottom: 15),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15)
      ),
      child:Padding(
        padding: const EdgeInsets.all(20.0),
        child: Row(
          children: [
            Stack(
                alignment: Alignment.center,
                children:[ Container(
                  height: 50,
                  width: 50,
                  decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.deepOrange
                  ),
                ),
                  const Icon(FontAwesomeIcons.burger,color: Colors.white,)
                ]
            ),
            const SizedBox(width: 10,),
            const Text('Food',style: TextStyle(fontSize: 14,fontWeight: FontWeight.bold),),
            const Spacer(),
            const Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text('-\$230.00',style: TextStyle(fontSize: 14,fontWeight: FontWeight.bold),),
                Text('Today',style: TextStyle(fontSize: 14,fontWeight: FontWeight.w400,color: Colors.grey),)
              ],
            )
          ],
        ),
      ) ,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text('Transactions',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              TextButton(
                  onPressed: () {},
                  child: const Text('View all',
                      style: TextStyle(fontSize: 14, color: Colors.grey)))
            ],
          ),
          Expanded(
            child: ListView.builder(itemCount: 12,itemBuilder: (context,int i){
              return _transacitonItem();
            }),
          )
        ],
      ),
    );
  }
}
