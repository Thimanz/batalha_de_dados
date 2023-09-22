import 'dart:math';
import 'dart:io';

import 'package:interact/interact.dart';

void main(List<String> arguments) {
  final entrada = Input(
    prompt: 'Digite o número de rodadas',
    validator: (String entrada) {
      if (entrada.contains(RegExp(r'[^0-9]'))) {
        throw ValidationError('Isso não é um número');
      } else {
        return true;
      }
    },
  ).interact();

  int rodadas = int.parse(entrada);

  int vitoriasUsuario = 0;
  int vitoriasPC = 0;
  bool usouDado = false;
  for (int i = 0;
      i < rodadas &&
          vitoriasUsuario <= (rodadas ~/ 2) &&
          vitoriasPC <= (rodadas ~/ 2);
      i++) {
    var gerador = Random();
    print("\n${(i + 1).toString()}º rodada\n");
    int somaUsuario = 0;
    for (int i = 0; i < 3; i++) {
      print("Para jogar seu ${(i + 1).toString()}º dado aperte ENTER");
      stdin.readLineSync();
      var valorDado = gerador.nextInt(6) + 1;
      somaUsuario += valorDado;
      print("Você tirou um ${valorDado.toString()}");
    }
    print("O seu total de pontos foi: ${somaUsuario.toString()}");

    if (!usouDado) {
      final opcoes = ['Sim', 'Não'];
      final opcao = Select(
        prompt: 'Deseja usar o dado mágico?',
        options: opcoes,
      ).interact();

      if (opcoes[opcao] == 'Sim') {
        usouDado = true;
        var dadoMagico = gerador.nextBool();
        if (dadoMagico) {
          somaUsuario *= 2;
          print(
              "Sorte! seus pontos foram dobrado para: ${somaUsuario.toString()}\n");
        } else {
          somaUsuario = somaUsuario ~/ 2;
          print(
              "Azar! seus pontos foram divididos para: ${somaUsuario.toString()}\n");
        }
      }
    }

    stdout.writeln();
    int somaPC = 0;
    for (int i = 0; i < 3; i++) {
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
