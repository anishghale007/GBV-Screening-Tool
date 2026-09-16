enum IncidentCategory {
  stalking('T1'),
  cyberbullying('T2'),
  slander('T3'),
  leakedImages('T4'),
  sharingDetails('T5'),
  fakeAccounts('T6'),
  threats('T7'),
  offlineEscalation('T8'),
  sexualHarassment('T9'),
  politicalIntimidation('T10');

  const IncidentCategory(this.id);

  final String id;
}
