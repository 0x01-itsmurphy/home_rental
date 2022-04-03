import 'package:flutter/material.dart';
import 'package:home_rental/controller/Elements/footer_size_price.dart';
import 'package:home_rental/controller/loading.dart';
import 'package:home_rental/models/allposts_model.dart';
import 'package:home_rental/view/details_page/widgets/details_page_widgets.dart';

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
  bool loading = false;
  @override
  Widget build(BuildContext context) {
    final data = ModalRoute.of(context)!.settings.arguments as UserDetailsModel;

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text(
          "Available: " + data.available.toString(),
          style: const TextStyle(
              fontSize: 16, fontWeight: FontWeight.bold, color: Colors.grey),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding:
              const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                padding: EdgeInsets.zero,
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height * 0.3,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image.network(
                    data.picture.toString(),
                    fit: BoxFit.cover,
                    loadingBuilder: (context, child, loadingProgress) {
                      if (loadingProgress == null) {
                        return child;
                      } else {
                        return const Center(
                          child: Loading(),
                        );
                      }
                    },
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Text(
                      data.owner.toString().toUpperCase(),
                      style: TextStyle(
                          color: Colors.black,
                          fontSize:
                              MediaQuery.of(context).size.height * 0.035,
                          fontWeight: FontWeight.w600),
                    ),
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
                icon: Icons.location_on,
                text: data.city.toString(),
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
                    asset: 'assets/facilities-Icons/router.png',
                    name: 'Wifi',
                  ),
                  Facilities(
                    asset: 'assets/facilities-Icons/heater.png',
                    name: 'Heater',
                  ),
                  Facilities(
                    asset: 'assets/facilities-Icons/tray.png',
                    name: 'Food',
                  ),
                  Facilities(
                    asset: 'assets/facilities-Icons/gym.png',
                    name: 'Gym',
                  ),
                ],
              ),
              // const SizedBox(
              //   height: 30,
              // ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: FooterSizePrice(
        size: data.size!,
        rent: data.rent!,
      ),
    );
  }
}
