class Trainer {
  final int id;
  final String nama;
  final int umur;
  final String noTelp;
  final String tipe;

  Trainer({
    required this.id,
    required this.nama,
    required this.umur,
    required this.noTelp,
    required this.tipe,
  });

  factory Trainer.fromJson(Map<String, dynamic> json) {
    return Trainer(
      id: json['id'],
      nama: json['nama'],
      umur: json['umur'],
      noTelp: json['no_telp'],
      tipe: json['tipe'],
    );
  }
}
