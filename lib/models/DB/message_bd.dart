import 'package:allo/main.dart';
import 'package:allo/models/DB/annonce_db.dart';
import 'package:allo/models/DB/objet_bd.dart';
import 'package:allo/models/DB/user_bd.dart';
import 'package:allo/models/Utilisateur.dart';
import 'package:allo/models/annonce.dart';
import 'package:allo/models/message.dart';
import 'package:allo/models/objet.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class MessageBD {
  static Future<int> getNbNotifs(String idAnnonceConcernee) async {
    try {
      String? myUUID = await UserBD.getMyUUID();
      final response = await supabase
          .from('message')
          .select('idmessage')
          .eq('id_annonce_concernee', idAnnonceConcernee)
          .eq('id_receveur', myUUID)
          .eq('estvu', false);

      return response.length;
    } catch (e) {
      print('Erreur lors de la récupération du nombre de notifications: $e');
      return 0;
    }
  }

  static Future<List<Message>> getConversations() async {
    try {
      Map<String, Message> messages = {};
      String? myUUID = await UserBD.getMyUUID();

      final response = await supabase
          .from('message')
          .select(
              'idmessage, date_message, contenu, estvu, id_annonce_concernee, id_envoyeur, id_receveur')
          .or('id_envoyeur.eq.$myUUID')
          .or('id_receveur.eq.$myUUID')
          .order('date_message', ascending: false);

      for (var element in response) {
        Message newMessage = Message.fromDefaultJson(element);
        bool isMine = element['id_envoyeur'] == myUUID;
        newMessage.isMine = isMine;
        newMessage.annonceConcernee =
            await AnnonceDB.getAnnonceWithUser(element['id_annonce_concernee']);
        newMessage.utilisateurEnvoyeur =
            await UserBD.getUser(element["id_envoyeur"]);
        newMessage.utilisateurReceveur =
            await UserBD.getUser(element["id_receveur"]);

        String idannonce = element[
            "id_annonce_concernee"]; 
        String idAutreUtilisateur = isMine
            ? element["id_receveur"]
            : element["id_envoyeur"];
        String idConversation = idannonce + idAutreUtilisateur;
        if (!messages.containsKey(idConversation) ||
            messages[idConversation]!.dateMessage.isBefore(newMessage.dateMessage)) {
          messages[idConversation] = newMessage;
        }
      }

      final responseAide = await supabase
          .from('aider')
          .select(
              'idannonce, idobjet, commentaire, estaccepte, date_aide, estRepondu')
          .order('date_aide', ascending: false);

      for (var element in responseAide) {
        Message newMessage = Message.fromAideJson(element);
        newMessage.annonceConcernee =
            await AnnonceDB.getAnnonceWithUser(element['idannonce']);
        newMessage.utilisateurEnvoyeur =
            await ObjetBd.getProprietaireObjet(element['idobjet']);

        if (newMessage.utilisateurEnvoyeur!.idUtilisateur != myUUID &&
            newMessage.annonceConcernee!.utilisateur!.idUtilisateur != myUUID) {
          continue;
        }

        newMessage.isMine =
            newMessage.utilisateurEnvoyeur!.idUtilisateur == myUUID;

        newMessage.utilisateurReceveur =
            newMessage.annonceConcernee!.utilisateur;

        String idannonce =
            element["idannonce"];
        String idAutreUtilisateur = newMessage.isMine
            ? newMessage.annonceConcernee!.utilisateur!.idUtilisateur
            : newMessage.utilisateurEnvoyeur!.idUtilisateur;
        String idConversation = idannonce + idAutreUtilisateur;
        if (!messages.containsKey(idConversation) ||
            messages[idConversation]!.dateMessage.isBefore(newMessage.dateMessage)) {
          messages[idConversation] = newMessage;
        }
      }

      final responseMesAnnonces =
          await AnnonceDB.getMesAnnonces(forMessage: true);

      for (var element in responseMesAnnonces) {
        if (element.etatAnnonce == Annonce.CLOTUREES) {
          Message newMessage = Message(
              typeMessage: Message.AVIS,
              dateMessage: element.dateAideAnnonce!,
              contenu:
                  "On vous a aidé le ${element.dateAideAnnonce!.day}/${element.dateAideAnnonce!.month}/${element.dateAideAnnonce!.year} à ${element.dateAideAnnonce!.hour}:${element.dateAideAnnonce!.minute}",
              estVu: false,
              isMine: true,
              estRepondu: element.avisLaisse);

          newMessage.annonceConcernee = element;

          // on va aller get dans la table avis l'idutilisateur_dest là où l'idannonce = element.idAnnonce


          final responseAvis = await supabase
              .from('avis')
              .select('idutilisateur_dest')
              .eq('idannonce', element.idAnnonce);

          String idAutreUtilisateur = responseAvis[0]['idutilisateur_dest'];

          if (idAutreUtilisateur == myUUID){
            // on va aller regarder dans l'annonce correspondant à l'avis l'idutilisateur

            final responseAnnonceAvis = await supabase
                .from('annonce')
                .select('idutilisateur')
                .eq('idannonce', element.idAnnonce);

            idAutreUtilisateur = responseAnnonceAvis[0]['idutilisateur'];
          }

          String idannonce = element.idAnnonce;
          String idConversation = idannonce + idAutreUtilisateur;
          if (!messages.containsKey(idConversation) ||
              messages[idConversation]!
                  .dateMessage
                  .isBefore(newMessage.dateMessage)) {
            messages[idConversation] = newMessage;
          }
        }
      }

      return messages.values.toList();
    } catch (e) {
      print('Erreur lors de la récupération des messages: $e');
      return [];
    }
  }

  static Future<List<Message>> getMessages(
      {required String idAnnonce,
      DateTime? beforeDate,
      int limit = 10,
      required String idUser}) async {
    try {
      String? myUUID = await UserBD.getMyUUID();
      PostgrestFilterBuilder query = supabase
          .from('message')
          .select(
              'idmessage, date_message, contenu, estvu, id_envoyeur, id_receveur')
          .eq('id_annonce_concernee', idAnnonce);

      if (beforeDate != null) {
        query = query.lte('date_message', beforeDate.toIso8601String());
      }

      PostgrestTransformBuilder finalQuery =
          query.order('date_message', ascending: false).limit(limit);

      final response = await finalQuery;

      List<Message> messages = [];
      for (var element in response) {
        Message newMessage = Message.fromDefaultJson(element);
        bool isMine = element['id_envoyeur'] == myUUID;

        newMessage.isMine = isMine;
        newMessage.annonceConcernee =
            await AnnonceDB.getAnnonceWithUser(idAnnonce);

        // on regarde si le message nous concerne c'est à dire si on est l'envoyeur ou le receveur
        // ou si idUser est l'envoyeur ou le receveur

        if (!((element['id_envoyeur'] == myUUID &&
                element['id_receveur'] == idUser) ||
            (element['id_envoyeur'] == idUser &&
                element['id_receveur'] == myUUID))) {
          continue;
        }

        if (!isMine) {
          newMessage.utilisateurEnvoyeur =
              await UserBD.getUser(element["id_receveur"]);
        }

        messages.add(newMessage);
      }

      final responseAide = await supabase
          .from('aider')
          .select(
              'idannonce, idobjet, commentaire, estaccepte, date_aide, estRepondu')
          .eq('idannonce', idAnnonce)
          .order('date_aide', ascending: false)
          .limit(limit);

      for (var element in responseAide) {
        Message newMessage = Message.fromAideJson(element);
        newMessage.annonceConcernee =
            await AnnonceDB.getAnnonceWithUser(element['idannonce']);
        newMessage.utilisateurEnvoyeur =
            await ObjetBd.getProprietaireObjet(element['idobjet']);

        newMessage.isMine =
            newMessage.utilisateurEnvoyeur!.idUtilisateur == myUUID;

        if (!((newMessage.utilisateurEnvoyeur!.idUtilisateur == myUUID &&
                newMessage.annonceConcernee!.utilisateur!.idUtilisateur ==
                    idUser) ||
            (newMessage.utilisateurEnvoyeur!.idUtilisateur == idUser &&
                newMessage.annonceConcernee!.utilisateur!.idUtilisateur ==
                    myUUID))) {
          continue;
        }

        messages.add(newMessage);
      }

      final responseMesAnnonces =
          await AnnonceDB.getMesAnnonces(forMessage: true);

      for (var element in responseMesAnnonces) {
        if (element.etatAnnonce == Annonce.CLOTUREES &&
            element.idAnnonce == idAnnonce) {
          Message newMessage = Message(
              typeMessage: Message.AVIS,
              dateMessage: element.dateAideAnnonce!,
              contenu:
                  "On vous a aidé le ${element.dateAideAnnonce!.day}/${element.dateAideAnnonce!.month}/${element.dateAideAnnonce!.year} à ${element.dateAideAnnonce!.hour}:${element.dateAideAnnonce!.minute}",
              estVu: false,
              isMine: true,
              estRepondu: element.avisLaisse);

          newMessage.annonceConcernee = element;

          messages.add(newMessage);
          break;
        }
      }

      messages.sort((a, b) => a.dateMessage.compareTo(b.dateMessage));
      return messages.reversed.toList();
    } catch (e) {
      print('Erreur lors de la récupération des messages: $e');
      return [];
    }
  }

  static Future<void> sendMessage(
      {required String idAnnonce,
      required String contenu,
      required String idReceveur}) async {
    try {
      String? myUUID = await UserBD.getMyUUID();
      final response = await supabase.from('message').insert([
        {
          'id_annonce_concernee': idAnnonce,
          'contenu': contenu,
          'id_envoyeur': myUUID,
          'id_receveur': idReceveur,
        }
      ]);

      print('Response: $response');
    } catch (e) {
      print('Erreur lors de l\'envoi du message: $e');
    }
  }
}
