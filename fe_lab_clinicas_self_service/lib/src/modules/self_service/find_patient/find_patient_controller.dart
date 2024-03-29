import 'package:fe_lab_clinicas_core/fe_lab_clinicas_core.dart';
import 'package:fe_lab_clinicas_self_service/src/model/patient_model.dart';
import 'package:fe_lab_clinicas_self_service/src/modules/self_service/patient/patient_repository.dart';
import 'package:signals_flutter/signals_flutter.dart';

class FindPatientController with MessageStateMixin {
  FindPatientController({
    required PatientRepository patientRepository,
  }) : _patientRepository = patientRepository;

  final PatientRepository _patientRepository;

  final _patientNotFound = ValueSignal<bool?>(null);
  final _patient = ValueSignal<PatientModel?>(null);

  bool? get patientNotFound => _patientNotFound();
  PatientModel? get patient => _patient();

  Future<void> findPatientByDocument(String document) async {
    final patientResult =
        await _patientRepository.findPatientByDocument(document);
    bool patientNotFound;
    PatientModel? patient;

    switch (patientResult) {
      case Right<RepositoryException, PatientModel?>(
          value: PatientModel model?
        ):
        patientNotFound = false;
        patient = model;
      case Right(value: _):
        patientNotFound = true;
        patient = null;
      case Left<RepositoryException, PatientModel?>():
        showError('Erro ao buscar pacient');
        return;
    }

    batch(() {
      _patient.value = patient;
      _patientNotFound.forceUpdate(patientNotFound);
    });
  }

  void continueWithoutDocument() {
    batch(() {
      _patient.value = null;
      _patientNotFound.forceUpdate(true);
    });
  }
}
