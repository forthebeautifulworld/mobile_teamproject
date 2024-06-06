enum TableShape {
  square,
  rectangle,
}

enum TableState {
  available,
  unavailable,
  reserved,
  myReserved,
}

class TableStatus {
  final int id;
  final int seats;
  final int maxSeats;
  final TableShape shape;
  TableState status;
  String visitTime;
  String visitPeople;

  TableStatus({
    required this.id,
    required this.seats,
    required this.maxSeats,
    required this.status,
    required this.shape,
    this.visitTime = '',
    this.visitPeople = '',
  });
}
