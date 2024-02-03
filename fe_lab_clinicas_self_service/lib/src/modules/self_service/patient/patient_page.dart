import 'package:brasil_fields/brasil_fields.dart';
import 'package:fe_lab_clinicas_core/fe_lab_clinicas_core.dart';
import 'package:fe_lab_clinicas_self_service/src/model/self_service_model.dart';
import 'package:fe_lab_clinicas_self_service/src/modules/self_service/patient/patient_controller.dart';
import 'package:fe_lab_clinicas_self_service/src/modules/self_service/patient/patient_form_controller.dart';
import 'package:fe_lab_clinicas_self_service/src/modules/self_service/self_service_controller.dart';
import 'package:fe_lab_clinicas_self_service/src/modules/self_service/widget/lab_clinicas_self_service_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_getit/flutter_getit.dart';
import 'package:signals_flutter/signals_flutter.dart';
import 'package:validatorless/validatorless.dart';

class PatientPage extends StatefulWidget {
  const PatientPage({super.key});

  @override
  State<PatientPage> createState() => _PatientPageState();
}

class _PatientPageState extends State<PatientPage>
    with PatientFormController, MessageViewMixin {
  final formKey = GlobalKey<FormState>();
  final selfServiceController = Injector.get<SelfServiceController>();
  final PatientController controller = Injector.get<PatientController>();

  late bool patientFound;
  late bool enableForm;

  @override
  void initState() {
    messageListener(controller);
    final SelfServiceModel(:patient) = selfServiceController.model;

    patientFound = patient != null;
    enableForm = !patientFound;
    initializeForm(patient);
    effect(() {
      if (controller.nextStep) {
        selfServiceController.updatePatientAndGoDocument(controller.patient);
      }
    });

    super.initState();
  }

  @override
  void dispose() {
    disposeForm();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final sizeOf = MediaQuery.sizeOf(context);

    return Scaffold(
      appBar: LabClinicasSelfServiceAppBar(),
      body: Align(
        alignment: Alignment.topCenter,
        child: SingleChildScrollView(
          child: Container(
            width: sizeOf.width * .85,
            margin: const EdgeInsets.only(top: 18),
            padding: const EdgeInsets.all(32),
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: LabClinicasTheme.orangeColor)),
            child: Form(
              key: formKey,
              child: Column(
                children: [
                  Visibility(
                    visible: patientFound,
                    replacement: Image.asset('assets/images/lupa_icon.png'),
                    child: Image.asset('assets/images/check_icon.png'),
                  ),
                  const SizedBox(
                    height: 24,
                  ),
                  Visibility(
                    visible: patientFound,
                    replacement: const Text(
                      'Cadastro não encontrado',
                      style: LabClinicasTheme.titleSmallStyle,
                    ),
                    child: const Text(
                      'Cadastro encontrado',
                      style: LabClinicasTheme.titleSmallStyle,
                    ),
                  ),
                  const SizedBox(
                    height: 32,
                  ),
                  Visibility(
                    visible: patientFound,
                    replacement: const Text(
                      'Preencha o formulário abaixo para fazer o seu cadastro',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: LabClinicasTheme.blueColor,
                      ),
                    ),
                    child: const Text(
                      'Confira os dados do seu cadastro',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: LabClinicasTheme.blueColor,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 24,
                  ),
                  TextFormField(
                    readOnly: !enableForm,
                    controller: nameEC,
                    validator: Validatorless.required('Nome obrigatório'),
                    decoration:
                        const InputDecoration(label: Text('Nome Paciente')),
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  TextFormField(
                    readOnly: !enableForm,
                    controller: emailEC,
                    validator: Validatorless.multiple([
                      Validatorless.required('Email obrigatório'),
                      Validatorless.email('Email inválido'),
                    ]),
                    decoration: const InputDecoration(label: Text('Email')),
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  TextFormField(
                    readOnly: !enableForm,
                    controller: phoneEC,
                    validator: Validatorless.required('Telefone obrigatório'),
                    decoration: const InputDecoration(
                        label: Text('Telefone de Contato')),
                    inputFormatters: [
                      FilteringTextInputFormatter.digitsOnly,
                      TelefoneInputFormatter(),
                    ],
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  TextFormField(
                    readOnly: !enableForm,
                    controller: documentEC,
                    validator: Validatorless.required('CPF obrigatório'),
                    decoration:
                        const InputDecoration(label: Text('Digite seu CPF')),
                    inputFormatters: [
                      FilteringTextInputFormatter.digitsOnly,
                      CpfInputFormatter(),
                    ],
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  TextFormField(
                    readOnly: !enableForm,
                    controller: cepEC,
                    validator: Validatorless.required('CEP obrigatório'),
                    decoration: const InputDecoration(label: Text('CEP')),
                    inputFormatters: [
                      FilteringTextInputFormatter.digitsOnly,
                      CepInputFormatter(),
                    ],
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  Row(
                    children: [
                      Flexible(
                        flex: 3,
                        child: TextFormField(
                          readOnly: !enableForm,
                          controller: streetEC,
                          validator:
                              Validatorless.required('Endereço obrigatório'),
                          decoration:
                              const InputDecoration(label: Text('Endereço')),
                        ),
                      ),
                      const SizedBox(
                        width: 16,
                      ),
                      Flexible(
                        flex: 1,
                        child: TextFormField(
                          readOnly: !enableForm,
                          controller: numberEC,
                          validator:
                              Validatorless.required('Número obrigatório'),
                          decoration:
                              const InputDecoration(label: Text('Número')),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: TextFormField(
                          readOnly: !enableForm,
                          controller: complementEC,
                          decoration:
                              const InputDecoration(label: Text('Complemento')),
                        ),
                      ),
                      const SizedBox(
                        width: 16,
                      ),
                      Expanded(
                        child: TextFormField(
                          readOnly: !enableForm,
                          controller: stateEC,
                          validator:
                              Validatorless.required('Estado obrigatório'),
                          decoration:
                              const InputDecoration(label: Text('Estado')),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: TextFormField(
                          readOnly: !enableForm,
                          controller: cityEC,
                          validator:
                              Validatorless.required('Cidade obrigatória'),
                          decoration:
                              const InputDecoration(label: Text('Cidade')),
                        ),
                      ),
                      const SizedBox(
                        width: 16,
                      ),
                      Expanded(
                        child: TextFormField(
                          readOnly: !enableForm,
                          controller: districtEC,
                          validator:
                              Validatorless.required('Bairro obrigatório'),
                          decoration:
                              const InputDecoration(label: Text('Bairro')),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  TextFormField(
                    readOnly: !enableForm,
                    controller: guardianEC,
                    decoration:
                        const InputDecoration(label: Text('Responsável')),
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  TextFormField(
                    readOnly: !enableForm,
                    controller: guardianIdentificationNumberEC,
                    decoration: const InputDecoration(
                        label: Text('Documento de identificação')),
                    inputFormatters: [
                      FilteringTextInputFormatter.digitsOnly,
                      CpfInputFormatter(),
                    ],
                  ),
                  const SizedBox(
                    height: 32,
                  ),
                  Visibility(
                    visible: !enableForm,
                    replacement: SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {
                          final valid =
                              formKey.currentState?.validate() ?? false;
                          if (valid) {
                            if (patientFound) {
                              controller.updateAndNext(updatePatient(
                                  selfServiceController.model.patient!));
                            } else {
                              controller.saveAndNext(createPatientResgister());
                            }
                          }
                        },
                        child: Visibility(
                            visible: !patientFound,
                            replacement: const Text('SALVAR E CONTINUAR'),
                            child: const Text('CADASTRAR')),
                      ),
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          child: SizedBox(
                            child: OutlinedButton(
                              onPressed: () {
                                setState(() {
                                  enableForm = true;
                                });
                              },
                              child: const Text('EDITAR'),
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 17,
                        ),
                        Expanded(
                          child: SizedBox(
                            child: ElevatedButton(
                              onPressed: () {
                                controller.patient =
                                    selfServiceController.model.patient;
                                controller.goNextStep();
                              },
                              child: const Text('CONTINUAR'),
                            ),
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
