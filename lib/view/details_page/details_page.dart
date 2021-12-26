import 'package:flutter/material.dart';
import 'package:home_rental/models/allposts_model.dart';
import 'package:home_rental/widgets/details_page_widgets.dart';

class DetailsPage extends StatefulWidget {
  const DetailsPage({
    Key? key,
    // required this.users,
  }) : super(key: key);

  // final User users;

  @override
  _DetailsPageState createState() => _DetailsPageState();
}

class _DetailsPageState extends State<DetailsPage> {
  @override
  Widget build(BuildContext context) {
    final data = ModalRoute.of(context)!.settings.arguments as User;

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height * 0.3,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20.0),
                    image: DecorationImage(
                        fit: BoxFit.cover,
                        image: NetworkImage(data.picture.toString()))),
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    data.owner.toString().toUpperCase(),
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: MediaQuery.of(context).size.height * 0.04,
                        fontWeight: FontWeight.w600),
                  ),
                  Text(
                    "Available?: " + data.available.toString(),
                    style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.grey),
                  ),
                ],
              ),
              const SizedBox(
                height: 15,
              ),
              ContactWidget(
                icon: Icons.apartment,
                text: data.apartment.toString(),
              ),
              const SizedBox(
                height: 5,
              ),
              ContactWidget(
                icon: Icons.location_on,
                text: data.address.toString(),
              ),
              const SizedBox(
                height: 5,
              ),
              ContactWidget(
                icon: Icons.phone,
                text: data.phone.toString(),
              ),
              
              ContactWidget(
                icon: Icons.description,
                text: data.description.toString(),
              ),
              const SizedBox(
                height: 20,
              ),
              Text(
                "Facilities".toUpperCase(),
                style: TextStyle(
                    color: Colors.black,
                    fontSize: MediaQuery.of(context).size.height * 0.025,
                    fontWeight: FontWeight.w600),
              ),
              const SizedBox(
                height: 10,
              ),
              Wrap(
                // mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: const <Widget>[
                  Facilities(
                    asset: 'assets/images/router.png',
                    name: 'Wifi',
                  ),
                  Facilities(
                    asset: 'assets/images/heater.png',
                    name: 'Heater',
                  ),
                  Facilities(
                    asset: 'assets/images/tray.png',
                    name: 'Food',
                  ),
                  Facilities(
                    asset: 'assets/images/gym.png',
                    name: 'Gym',
                  ),
                ],
              ),
              const SizedBox(
                height: 30,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.grey[300],
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                          vertical: MediaQuery.of(context).size.height * 0.02,
                          horizontal:
                              MediaQuery.of(context).size.height * 0.02),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text(
                            "${data.size.toString()} sq.ft.",
                            style: TextStyle(
                                color: Colors.black,
                                fontSize:
                                    MediaQuery.of(context).size.height * 0.03),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.black,
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                          vertical: MediaQuery.of(context).size.height * 0.02,
                          horizontal:
                              MediaQuery.of(context).size.height * 0.02),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text(
                            "Rs. ${data.rent}",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize:
                                    MediaQuery.of(context).size.height * 0.03),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  // _iconsCard(String asset, String name) {
  //   return
  // }
}
