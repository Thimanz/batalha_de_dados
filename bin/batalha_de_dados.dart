import 'dart:math';
import 'dart:io';

void main(List<String> arguments) {
  stdout.write("\nDigite o número de rodadas: ");
  var entrada = stdin.readLineSync();
  int? rodadas;
  if (entrada != null) rodadas = int.tryParse(entrada);
  while (entrada == null || rodadas == null || rodadas < 1) {
    stdout.write('\nDigite uma opção válida: ');
    entrada = stdin.readLineSync();
    if (entrada != null) rodadas = int.tryParse(entrada);
  }

  int vitoriasUsuario = 0;
  int vitoriasPC = 0;
  for (int i = 0;
      i < rodadas &&
          vitoriasUsuario <= (rodadas ~/ 2) &&
          vitoriasPC <= (rodadas ~/ 2);
      i++) {
    print("\n${(i + 1).toString()}º rodada\n");
    int somaUsuario = 0;
    for (int i = 0; i < 3; i++) {
      stdout.write("Para jogar seu ${(i + 1).toString()}º dado aperte ENTER");
      stdin.readLineSync();
      var gerador = Random();
      var valorDado = gerador.nextInt(6) + 1;
      somaUsuario += valorDado;
      print("Você tirou um ${valorDado.toString()}");
    }
    print("O seu total de pontos foi: ${somaUsuario.toString()}\n");

    int somaPC = 0;
    for (int i = 0; i < 3; i++) {
      var gerador = Random();
      var valorDado = gerador.nextInt(6) + 1;
      somaPC += valorDado;
      print(
          "O ${(i + 1).toString()}º dado do adversário foi: ${valorDado.toString()}");
    }
    print("O total de pontos do seu adversário foi: ${somaPC.toString()}\n");

    if (somaUsuario > somaPC) {
      print("Você venceu a ${(i + 1).toString()}º rodada");
      vitoriasUsuario++;
    } else if (somaUsuario < somaPC) {
      print("O Adversário venceu a ${(i + 1).toString()}º rodada");
      vitoriasPC++;
    } else {
      print("A ${(i + 1).toString()}º rodada empatou");
    }

    print("\nPlacar: Você $vitoriasUsuario X $vitoriasPC Adversário");
  }

  if (vitoriasUsuario > vitoriasPC) {
    print("\nVocê venceu a partida!\n");
    vitoriasUsuario++;
  } else if (vitoriasUsuario < vitoriasPC) {
    print("\nVocê perdeu!\n");
    vitoriasPC++;
  } else {
    print("\nEmpate!\n");
  }
}
