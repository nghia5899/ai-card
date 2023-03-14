import 'package:ai_ecard/import.dart';
import 'package:ai_ecard/styles/app_style.dart';
import 'package:ai_ecard/widgets/button_base.dart';
import 'package:flutter/material.dart';

class MenuPage extends StatelessWidget {
  const MenuPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffE4E4E4),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            const SizedBox(height: 20),
            Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Theme.of(context).cardColor
              ),
              padding: const EdgeInsets.all(12),
              child: Row(
                children: [
                  Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(50),
                    ),
                    height: 65,width: 65,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(50),
                        child: Image.asset('assets/images/image1.png',fit: BoxFit.fill,)),
                  ),
                  const SizedBox(width: 15,),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const [
                        Text('Hoàng Việt',style: TextStyle(
                          fontWeight: FontWeight.w700,
                          fontSize: 18
                        )),
                        Text('Free plan'),
                      ],
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(6),
                        gradient: const LinearGradient(
                            colors: [
                              Color(0xff7968D2),
                              Color(0xffF174B2)
                            ])
                    ),
                    padding: const EdgeInsets.all(5),
                    child: const Text('Upgrade'),
                  )
                ],
              ),
            ),
             Padding(
              padding: const EdgeInsets.symmetric(vertical: 8),
              child: Text('Cards left in free plan: 10',style: AppStyles.descriptionIconText),
            ),
            const SizedBox(height: 20,),
            Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Theme.of(context).cardColor
              ),
              padding: const EdgeInsets.all(12),
              child: Column(
                children: [
                  const ListTile(
                    title: Text('Settings',style: TextStyle(fontWeight: FontWeight.bold)),
                    trailing: Icon(Icons.arrow_forward_ios_outlined,size: 14),
                  ),
                  const ListTile(
                    title: Text('Feedback',style: TextStyle(fontWeight: FontWeight.bold)),
                    trailing: Icon(Icons.arrow_forward_ios_outlined,size: 14),
                  ),

                  Container(
                    margin: const EdgeInsets.all(24.0),
                    width: Get.width,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color: const Color.fromRGBO(252, 165, 165, 0.15),
                    ),
                    child: TextButton(
                      onPressed: (){},
                      child: const Text('Logout',style: TextStyle(
                        fontWeight: FontWeight.w700,fontSize: 16,
                        color: Color(0xffF75555),
                      ),),
                    ),
                  ),
                ],
              ),
            ),
            const Spacer()
          ],
        ),
      ),
    );
  }
}
