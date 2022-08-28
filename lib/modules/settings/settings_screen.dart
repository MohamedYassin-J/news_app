import 'package:flutter/material.dart';

import '../../shared/components/components.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double displayWidth = MediaQuery.of(context).size.width;
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(15.0),
          child: Row(
            children: [
              const Padding(
                padding: EdgeInsets.all(15.0),
                child: CircleAvatar(
                  radius: 42.0,
                  backgroundImage: AssetImage('assets/no_avatar.png'),
                ),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    '[User Name Here]',
                    style: Theme.of(context).textTheme.bodyText2,
                  ),
                  const SizedBox(
                    height: 8.0,
                  ),
                  const Text(
                    'User.names@domainname.com',
                    style: TextStyle(
                      fontSize: 15.0,
                      color: Colors.grey,
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
        Expanded(
          child: Container(
            width: double.infinity,
            decoration: BoxDecoration(
              color: Colors.blueAccent.withOpacity(.2),
              borderRadius: const BorderRadius.only(
                topRight: Radius.circular(15.0),
                topLeft: Radius.circular(15.0),
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Column(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Account Settings',
                        style: Theme.of(context).textTheme.bodyText1,
                      ),
                      const SizedBox(height: 20.0,),
                      defaultSettingsButton(
                          context,
                          function: (){},
                          buttonText: 'Change Password',
                          displayWidth: displayWidth
                      ),
                      const SizedBox(height: 15.0,),
                      defaultSettingsButton(
                          context,
                          function: (){},
                          buttonText: 'Terms & Services',
                          displayWidth: displayWidth
                      ),
                      const SizedBox(height: 15.0,),
                      defaultSettingsButton(
                          context,
                          function: (){},
                          buttonText: 'Contact Us',
                          displayWidth: displayWidth
                      ),
                    ],
                  ),
                  const SizedBox(height: 80.0,),
                  defaultButton(
                    context,
                    function: (){},
                    buttonText: 'Log Out',
                    buttonWidth: 100.0,
                    buttonHeight: displayWidth * .120,
                    buttonColor: Colors.blueAccent.withOpacity(.7),
                  ),
                ],
              ),
            ),
          ),
        )
      ],
    );
  }
}
