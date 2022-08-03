class Strings {
  Strings._();

  //Errors
  static const String loginErrorHeader =
      "Nom d'utilisateur ou mot de passe incorrect";
  static const String loginErrorBody =
      "Le nom d'utilisateur ou mot de passe saisi est incorrect.";
  static const String networkErrorHeader = "Erreur réseau";
  static const String networkErrorBody =
      "La connexion ne peut pas être établie avec le serveur.";
  static const String connectionErrorHeader = "Connexion impossible";
  static const String connectionErrorBody =
      "Vérifie que tu as accès à Internet avant de rafraichir la page.";
  static const String videoErrorHeader = "Vidéo inaccessible";
  static const String videoErrorBody =
      "Vérifie ta connexion à Internet. Si le problème persiste, contacte l'administrateur.";
  static const String unknownErrorHeader = "Une erreur est survenue";
  static const String unknownErrorBody = "Une erreur inconnue est survenue.";
  static const String noContentErrorHeader = "Il n'y a rien par ici";
  static const String noContentErrorBody =
      "Tu n'as accès à aucun service. Abonne-toi pour pouvoir y accéder.";
  static const String noCommentErrorHeader = "Aucun commentaire";
  static const String noCommentErrorBody =
      "Il n'y a encore rien ici. Soit le premier à commenter !";

  static const String refreshButton = "Rafraichir";
  static const String loginAlertButton = "OK";

  //AppBar
  static const String appBarWeek = "Programme de la semaine";
  static const String appBarPreview = "Demonstration";
  static const String appBarProfile = "Mon Profile";
  static const String appBarAMRAP = "AMRAP";
  static const String appBarEMOM = "EMOM";
  static const String appBarForTime = "For Time";
  static const String appBarSet = "Série";
  static const String appBarTabata = "Tabata";
  static const String appBarUnknownType = "Type inconnu";
  static const String appBarError = "Erreur";
  static const String appBarReplies = "réponses";
  static const String appBarComments = "commentaires";

  //Login
  static const String loginPageTitle = "Connecte toi";
  static const String loginHint = "Nom d'utilisateur";
  static const String passwordHint = "Mot de passe";
  static const String signUpButton = "S'inscrire";
  static const String logInButton = "Se connecter";
  static const String forgottenPassword = "Mot de passe oublié";
  static const String forgottenPasswordHost = "i.imgflip.com";
  static const String forgottenPasswordPath = "2mskjg.jpg";
  static const String createAccountHost = "i.imgflip.com";
  static const String createAccountPath = "2mskjg.jpg";

  //Profile
  static const String logOutMessage =
      "Êtes-vous sûr de vouloir vous déconnecter ?";
  static const String logOutAccept = "Se déconnecter";
  static const String logOutDeny = "Annuler";
  static const String parametersTitle = "Paramètres";
  static const String myAccountButton = "Mon Compte";
  static const String notificationsSettings = "Notifications";
  static const String deviceSettingsButton = "Paramètres de l'appareil";
  static const String myAccountHost = "i.imgflip.com";
  static const String myAccountPath = "2mskjg.jpg";

  //Shared Preferences
  static const String notificationSettingKey = "notifications";
  static const String accessTokenKey = "access_token";
  static const String refreshTokenKey = "refresh_token";
  static const String isMutedKey = "muted";

  //API
  static const String apiProtocol = "http://";
  static const String apiHost = "192.168.1.20:8000";
  static const String apiAuthPath = "/login/auth";
  static const String apiAccessPath = "/login/access";
  static const String apiRefreshPath = "/login/refesh";
  static const String apiUserPath = "/user";
  static const String apiPicturePath = "/picture";
  static const String apiDailyPath = "/daily";
  static const String apiDailyAssetsPath = "/daily/video.mp4";
  static const String apiCommentsPath = "/comments";
  static const String apiRepliesPath = "/replies";

  //Stopwatch
  static const String finishedWorkoutLabel = "Fin";
  // ignore: constant_identifier_names
  static const String AMRAPLastRoundLabel = "Dernier round";
  static const String forTimeButton = "Stop";
  static const String setButton = "Repos";
  // ignore: constant_identifier_names
  static const String AMRAPButton = "+1";
  static const String restLabel = "Repos";
  static const String endLabel = "  Fin  ";
  static const String workLabel = "WORK TODO";
  static const String pauseLabel = "Mettre en pause";
  static const String resumeLabel = "Reprendre";
  static const String startLabel = "Commencer";
  static const String leavingTitle =
      "Voulez-vous sauvegarder votre progression ?";
  static const String leavingMessage =
      "Si vous quittez l'application, votre progression sera perdue quoi qu'il arrive.";
  static const String saveWorkoutButton = "Sauvegarder";
  static const String leaveWorkoutButton = "Quitter";
  static const String assetsFolder = "assets/beeps/";
  static const String highBeepSound = "high.wav";
  static const String mediumBeepSound = "medium.wav";
  static const String lowBeepSound = "low.wav";

  //Workout Backups
  static const String isRestKey = "isRest";
  static const String elapsedKey = "elapsed";
  static const String timeCapKey = "timeCap";
  static const String setsKey = "sets";
  static const String progressKey = "progress";
  static const String isPauseKey = "isPause";
  static const String lastRepKey = "lastRep";
  static const String totalElapsedKey = "totalElapsedSinceIncrement";
  static const String workoutBackupKey = "workout";
  static const String idKey = "id";

  //Comments
  static const String sendMessageHint = "Envoyer un message";
  static const String copyTextButton = "Copier le texte";
  static const String replyTextButton = "Répondre";

  //Hero
  static const String heroBigLogo = "big_logo";
}
