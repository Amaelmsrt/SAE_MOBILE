import 'package:allo/main.dart';
import 'package:allo/models/DB/annonce_db.dart';
import 'package:allo/models/DB/objet_bd.dart';
import 'package:allo/models/DB/user_bd.dart';
import 'package:allo/models/Utilisateur.dart';
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
          .or('id_envoyeur.eq.$myUUID, id_receveur.eq.$myUUID')
          .order('date_message', ascending: false);

      for (var element in response) {
        Message newMessage = Message.fromDefaultJson(element);
        bool isMine = element['id_envoyeur'] == myUUID;
        newMessage.isMine = isMine;
        newMessage.annonceConcernee =
            await AnnonceDB.getAnnonceWithUser(element['id_annonce_concernee']);
        if (!isMine) {
          newMessage.utilisateurEnvoyeur =
              await UserBD.getUser(element["id_receveur"]);
        }

        String idannonce = element[
            "id_annonce_concernee"]; // Replace with your conversation ID
        if (!messages.containsKey(idannonce) ||
            messages[idannonce]!.dateMessage.isBefore(newMessage.dateMessage)) {
          messages[idannonce] = newMessage;
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
        newMessage.isMine =
            newMessage.utilisateurEnvoyeur!.idUtilisateur == myUUID;

        String idannonce =
            element["idannonce"]; // Replace with your conversation ID
        if (!messages.containsKey(idannonce) ||
            messages[idannonce]!.dateMessage.isBefore(newMessage.dateMessage)) {
          messages[idannonce] = newMessage;
        }
      }

      return messages.values.toList();
    } catch (e) {
      print('Erreur lors de la récupération des messages: $e');
      return [];
    }
  }

  static Future<List<Message>> getMessages(
      {required String idAnnonce, DateTime? beforeDate, int limit = 10}) async {
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

        messages.add(newMessage);
      }

      messages.sort((a, b) => a.dateMessage.compareTo(b.dateMessage));
      return messages;
    } catch (e) {
      print('Erreur lors de la récupération des messages: $e');
      return [];
    }
  }
}
