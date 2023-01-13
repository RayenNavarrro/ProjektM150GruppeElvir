import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gibz_mobileapp/bloc/rally/rally_bloc.dart';
import 'package:gibz_mobileapp/bloc/rally/rally_event.dart';
import 'package:gibz_mobileapp/bloc/rally/rally_state.dart';
import 'package:gibz_mobileapp/pages/skeleton_page.dart';
import 'package:permission_handler/permission_handler.dart';

class RallyPermissionsPage extends StatefulWidget {
  const RallyPermissionsPage({Key? key}) : super(key: key);

  @override
  State<RallyPermissionsPage> createState() => _RallyPermissionsPageState();
}

class _RallyPermissionsPageState extends State<RallyPermissionsPage> {
  @override
  Widget build(BuildContext context) {
    return SkeletonPage(
      pageTitle: "GIBZ Rallye",
      slivers: [
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: BlocBuilder<RallyBloc, RallyState>(
              buildWhen: (previous, current) =>
                  current is PendingInitializationState,
              builder: (context, state) => Column(
                children: [
                  const Padding(
                    padding: EdgeInsets.only(bottom: 15),
                    child: Text(
                        'Diese App benötigt Zugriff auf die Bluetooth-Schnittstelle deines Smartphones, damit die GIBZ Rallye funktionieren kann.'),
                  ),
                  if (state is PendingInitializationState &&
                      state.bluetoothStatus.isDenied)
                    SizedBox(
                      width: MediaQuery.of(context).size.width,
                      child: OutlinedButton(
                        onPressed: _requestBluetoothAccess,
                        child: const Text('Bluetooth erlauben'),
                      ),
                    ),
                  if (state is PendingInitializationState &&
                      state.bluetoothStatus.isPermanentlyDenied)
                    SizedBox(
                      width: MediaQuery.of(context).size.width,
                      child: const OutlinedButton(
                        onPressed: openAppSettings,
                        child: Text("Bluetooth-Einstellungen ändern"),
                      ),
                    ),
                  if (state is PendingInitializationState &&
                      state.bluetoothStatus.isGranted)
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        Padding(
                          padding: EdgeInsets.only(right: 10),
                          child: Icon(
                            Icons.check,
                            color: Color.fromARGB(255, 1, 130, 1),
                          ),
                        ),
                        Text(
                          "Bluetooth Berechtigung OK",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Color.fromARGB(255, 1, 130, 1),
                          ),
                        ),
                      ],
                    ),
                  if (Platform.isAndroid) const AndroidBluetoothScanConsent(),
                  const Padding(
                    padding: EdgeInsets.symmetric(vertical: 15),
                    child: Text(
                        'Für die Lokalisierung einzelner Stationen der GIBZ Rallye benötigt die App, während Sie ausgeführt wird, Zugriff auf den Standort deines Smartphones.'),
                  ),
                  if (state is PendingInitializationState &&
                      state.locationStatus.isDenied)
                    SizedBox(
                      width: MediaQuery.of(context).size.width,
                      child: OutlinedButton(
                        onPressed: state.bluetoothStatus.isGranted
                            ? _requestLocationAccess
                            : null,
                        child: const Text('Standortzugriff erlauben'),
                      ),
                    ),
                  if (state is PendingInitializationState &&
                      state.locationStatus.isPermanentlyDenied)
                    SizedBox(
                      width: MediaQuery.of(context).size.width,
                      child: const OutlinedButton(
                        onPressed: openAppSettings,
                        child: Text('Standort-Einstellungen ändern'),
                      ),
                    )
                ],
              ),
            ),
          ),
        )
      ],
    );
  }

  Future<void> _requestBluetoothAccess() async {
    PermissionStatus bluetooth = await Permission.bluetooth.status;
    if (bluetooth.isDenied) {
      Permission.bluetooth.request().then((permissionStatus) {
        context
            .read<RallyBloc>()
            .add(BluetoothPermissionChangedEvent(permissionStatus));
      });
    }
  }

  void _requestLocationAccess() async {
    PermissionStatus location = await Permission.locationWhenInUse.status;
    if (location.isDenied) {
      Permission.locationWhenInUse.request().then((permissionStatus) {
        context
            .read<RallyBloc>()
            .add(LocationPermissionChangedEvent(permissionStatus));
      });
    }
  }
}

class AndroidBluetoothScanConsent extends StatelessWidget {
  const AndroidBluetoothScanConsent({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RallyBloc, RallyState>(
      buildWhen: (previous, current) => current is PendingInitializationState,
      builder: (context, state) => Column(
        children: [
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 15),
            child: Text(
                'Für die Lokalisierung innerhalb des GIBZ muss diese App Bluetooth Beacons in der Umgebung scannen und erkennen.'),
          ),
          if (state is PendingInitializationState &&
              state.bluetoothScanStatus.isDenied)
            SizedBox(
              width: MediaQuery.of(context).size.width,
              child: OutlinedButton(
                onPressed: (() {
                  _requestBluetoothScanAccess(context);
                }),
                child: const Text('Bluetooth-Scanning erlauben'),
              ),
            ),
          if (state is PendingInitializationState &&
              state.bluetoothScanStatus.isPermanentlyDenied)
            SizedBox(
              width: MediaQuery.of(context).size.width,
              child: const OutlinedButton(
                onPressed: openAppSettings,
                child: Text("Bluetooth-Einstellungen ändern"),
              ),
            ),
          if (state is PendingInitializationState &&
              state.bluetoothScanStatus.isGranted)
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                Padding(
                  padding: EdgeInsets.only(right: 10),
                  child: Icon(
                    Icons.check,
                    color: Color.fromARGB(255, 1, 130, 1),
                  ),
                ),
                Text(
                  "Bluetooth-Scanning OK",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Color.fromARGB(255, 1, 130, 1),
                  ),
                ),
              ],
            ),
        ],
      ),
    );
  }

  Future<void> _requestBluetoothScanAccess(BuildContext context) async {
    PermissionStatus bluetoothScan = await Permission.bluetoothScan.status;
    if (bluetoothScan.isDenied) {
      Permission.bluetoothScan.request().then((permissionStatus) {
        context
            .read<RallyBloc>()
            .add(BluetoothScanPermissionChangedEvent(permissionStatus));
      });
    }
  }
}
