import 'package:fe_lab_clinicas_core/fe_lab_clinicas_core.dart';
import 'package:fe_lab_clinicas_painel/src/pages/painel/widgets/painel_principal_widget.dart';
import 'package:fe_lab_clinicas_painel/src/pages/painel/widgets/passaword_tile_widget.dart';
import 'package:flutter/material.dart';

class PainelPage extends StatelessWidget {
  const PainelPage({super.key});

  @override
  Widget build(BuildContext context) {
    var sizeOf = MediaQuery.sizeOf(context);
    return Scaffold(
      appBar: LabClinicasAppBar(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(
              height: 32,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  width: sizeOf.width * .4,
                  child: const PainelPrincipalWidget(
                      passwordLabel: 'Senha anterior',
                      password: 'BG5898',
                      deskNumber: '03',
                      labelColor: LabClinicasTheme.orangeColor,
                      buttonColor: LabClinicasTheme.blueColor),
                ),
                const SizedBox(
                  width: 20,
                ),
                SizedBox(
                  width: sizeOf.width * .4,
                  child: const PainelPrincipalWidget(
                      passwordLabel: 'Chamando senha',
                      password: 'BG5898',
                      deskNumber: '03',
                      labelColor: LabClinicasTheme.blueColor,
                      buttonColor: LabClinicasTheme.orangeColor),
                ),
              ],
            ),
            const SizedBox(
              height: 40,
            ),
            const Divider(
              color: LabClinicasTheme.orangeColor,
            ),
            const SizedBox(
              height: 30,
            ),
            const Text(
              'Últimos chamados',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: LabClinicasTheme.orangeColor,
              ),
            ),
            const SizedBox(
              height: 16,
            ),
            const Wrap(
              runAlignment: WrapAlignment.center,
              spacing: 10,
              runSpacing: 10,
              children: [
                PassawordTileWidget(
                  password: 'PF0909',
                  deskNumber: '03',
                ),
                PassawordTileWidget(
                  password: 'PF0909',
                  deskNumber: '03',
                ),
                PassawordTileWidget(
                  password: 'PF0909',
                  deskNumber: '03',
                ),
                PassawordTileWidget(
                  password: 'PF0909',
                  deskNumber: '03',
                ),
                PassawordTileWidget(
                  password: 'PF0909',
                  deskNumber: '03',
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
