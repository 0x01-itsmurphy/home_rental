import 'package:flutter/material.dart';
import 'package:home_rental/models/allposts_model.dart';

class DetailsPage extends StatefulWidget {
  const DetailsPage({
    Key? key,
    required this.users,
  }) : super(key: key);

  final User users;

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
                    data.owner.toString(),
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: MediaQuery.of(context).size.height * 0.04,
                        fontWeight: FontWeight.w600),
                  ),
                  Text(
                    "Available: " + data.available.toString(),
                    style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.grey),
                  ),
                ],
              ),
              const SizedBox(
                height: 5,
              ),
              Text(
                "Apartment: " + data.apartment.toString(),
                style: TextStyle(
                    color: Colors.grey[700],
                    fontSize: MediaQuery.of(context).size.height * 0.025,
                    fontWeight: FontWeight.w500),
              ),
              const SizedBox(
                height: 5,
              ),
              Text(
                "Address: " +
                    data.address.toString() +
                    ", " +
                    data.city.toString(),
                style: TextStyle(
                    color: Colors.grey[700],
                    fontSize: MediaQuery.of(context).size.height * 0.025,
                    fontWeight: FontWeight.w500),
              ),
              const SizedBox(
                height: 5,
              ),
              Text(
                "Contact: ${data.phone.toString()}",
                style: TextStyle(
                    color: Colors.grey[700],
                    fontSize: MediaQuery.of(context).size.height * 0.025,
                    fontWeight: FontWeight.w500),
              ),
              const SizedBox(
                height: 20,
              ),
              Text(
                "Facilities",
                style: TextStyle(
                    color: Colors.black,
                    fontSize: MediaQuery.of(context).size.height * 0.030,
                    fontWeight: FontWeight.w600),
              ),
              const SizedBox(
                height: 10,
              ),
              SingleChildScrollView(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    _iconsCard("assets/images/router.png", "Wifi"),
                    _iconsCard("assets/images/heater.png", "Heater"),
                    _iconsCard("assets/images/tray.png", "Food"),
                    _iconsCard("assets/images/gym.png", "Gym"),
                  ],
                ),
              ),
              const SizedBox(
                height: 20,
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

  _iconsCard(String asset, String name) {
    return SingleChildScrollView(
      child: Container(
        decoration: BoxDecoration(
            color: Colors.blue[100],
            borderRadius: BorderRadius.zero,
            border: Border.all(color: Colors.black)),
        child: Padding(
          padding: EdgeInsets.symmetric(
            vertical: MediaQuery.of(context).size.height * 0.01,
            horizontal: MediaQuery.of(context).size.height * 0.02,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Image.asset(
                asset,
                height: 2 * MediaQuery.of(context).size.height * 0.02,
                width: 2 * MediaQuery.of(context).size.height * 0.02,
              ),
              const SizedBox(
                height: 5,
              ),
              Text(
                name,
                style: TextStyle(
                    fontSize: MediaQuery.of(context).size.height * 0.025,
                    fontWeight: FontWeight.w600),
              )
            ],
          ),
        ),
      ),
    );
  }
}
