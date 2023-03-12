// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

class RoleTile extends StatelessWidget {
  
  final Map<String, dynamic> role ;
  
  const RoleTile({
    Key? key,
    required this.role,
  }) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
         CircleAvatar(radius: 14, child: Text(role['role'].substring(0,1).toUpperCase(),),),
         const SizedBox(width: 5,),
         Expanded(
           child: Text(role['role'], style: const TextStyle(fontSize: 18),),
         )
      ],
    );
  }
}
