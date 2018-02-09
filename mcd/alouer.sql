#------------------------------------------------------------
#        Script MySQL.
#------------------------------------------------------------


#------------------------------------------------------------
# Table: al_type_contact
#------------------------------------------------------------

CREATE TABLE al_type_contact(
        id_contact Int NOT NULL ,
        contact    Varchar (25) ,
        PRIMARY KEY (id_contact )
)ENGINE=InnoDB;


#------------------------------------------------------------
# Table: al_disponibilite
#------------------------------------------------------------

CREATE TABLE al_disponibilite(
        id_disponibilite Int NOT NULL ,
        id_logement      Int NOT NULL ,
        date_debut       Date NOT NULL ,
        date_fin         Date NOT NULL ,
        expire           TinyINT NOT NULL ,
        PRIMARY KEY (id_disponibilite ) ,
        INDEX (id_logement )
)ENGINE=InnoDB;


#------------------------------------------------------------
# Table: al_logements
#------------------------------------------------------------

CREATE TABLE al_logements(
        id_logement           Int NOT NULL ,
        nb_interieur          Varchar (15) ,
        nb_civique            Varchar (15) NOT NULL ,
        rue                   Varchar (75) NOT NULL ,
        cod_post              Varchar (7) NOT NULL ,
        province              Varchar (75) NOT NULL ,
        ville                 Varchar (75) NOT NULL ,
        nb_persones           TinyINT ,
        nb_chambres           TinyINT ,
        nb_lits               TinyINT ,
        nb_salle_de_bain      TinyINT ,
        nb_demi_salle_de_bain Int ,
        lat                   Varchar (25) ,
        lon                   Varchar (25) ,
        description           Text NOT NULL ,
        is_parking            Bool ,
        is_wifi               Int ,
        is_cuisine            Bool ,
        is_tv                 Bool ,
        is_fer_a_repasser     Bool ,
        is_cintres            Bool ,
        is_seche_chevaux      Bool ,
        is_clima              Bool ,
        is_laveuse            Bool ,
        is_secheuse           Bool ,
        is_chauffage          Bool ,
        premiere__photo       Varchar (75) ,
        notation_actuel       Int NOT NULL ,
        l_banned              TinyINT ,
        l_baned_date          Date ,
        l_banned_commentaire  Text ,
        courriel              Varchar (25) NOT NULL ,
        id_type_logement      Int NOT NULL ,
        PRIMARY KEY (id_logement )
)ENGINE=InnoDB;


#------------------------------------------------------------
# Table: al_location
#------------------------------------------------------------

CREATE TABLE al_location(
        id_reservation           int (11) Auto_increment  NOT NULL ,
        id_logement              Int ,
        id_client                Int NOT NULL ,
        date_debut               Date NOT NULL ,
        date_retour              Date ,
        date_reservation         Date ,
        cout                     Float ,
        valide                   Bool ,
        id_logement_al_logements Int ,
        courriel                 Varchar (25) NOT NULL ,
        PRIMARY KEY (id_reservation ) ,
        INDEX (id_logement )
)ENGINE=InnoDB;


#------------------------------------------------------------
# Table: al_type_usager
#------------------------------------------------------------

CREATE TABLE al_type_usager(
        id_type_usager int (11) Auto_increment  NOT NULL ,
        type_usager    Varchar (35) NOT NULL ,
        PRIMARY KEY (id_type_usager )
)ENGINE=InnoDB;


#------------------------------------------------------------
# Table: al_type_paiement
#------------------------------------------------------------

CREATE TABLE al_type_paiement(
        id_paiement int (11) Auto_increment  NOT NULL ,
        paiement    Varchar (25) NOT NULL ,
        PRIMARY KEY (id_paiement )
)ENGINE=InnoDB;


#------------------------------------------------------------
# Table: al_type_logement
#------------------------------------------------------------

CREATE TABLE al_type_logement(
        id_type_logement int (11) Auto_increment  NOT NULL ,
        type_logement    Varchar (55) NOT NULL ,
        PRIMARY KEY (id_type_logement )
)ENGINE=InnoDB;


#------------------------------------------------------------
# Table: al_usager
#------------------------------------------------------------

CREATE TABLE al_usager(
        courriel             Varchar (25) NOT NULL ,
        nom                  Char (25) NOT NULL ,
        prenom               Varchar (25) NOT NULL ,
        cellulaire           Varchar (25) ,
        mot_de_passe         Char (25) NOT NULL ,
        u_banned             TinyINT ,
        u_commentaire_banned Text ,
        u_date_banned        Date ,
        id_contact           Int NOT NULL ,
        id_type_usager       Int NOT NULL ,
        id_paiement          Int NOT NULL ,
        PRIMARY KEY (courriel )
)ENGINE=InnoDB;


#------------------------------------------------------------
# Table: al_evaluations
#------------------------------------------------------------

CREATE TABLE al_evaluations(
        id_evaluation        int (11) Auto_increment  NOT NULL ,
        commentaire          Text ,
        date_notation        Date NOT NULL ,
        ponctuation          Int NOT NULL ,
        e_banned             TinyINT ,
        e_date_banned        Date ,
        e_commentaire_banned Text ,
        courriel             Varchar (25) NOT NULL ,
        id_logement          Int ,
        PRIMARY KEY (id_evaluation )
)ENGINE=InnoDB;


#------------------------------------------------------------
# Table: al_photos_logement
#------------------------------------------------------------

CREATE TABLE al_photos_logement(
        id_photo_logement int (11) Auto_increment  NOT NULL ,
        chemin_photo      Varchar (175) NOT NULL ,
        id_logement       Int ,
        PRIMARY KEY (id_photo_logement )
)ENGINE=InnoDB;


#------------------------------------------------------------
# Table: al_messagerie
#------------------------------------------------------------

CREATE TABLE al_messagerie(
        id_message    int (11) Auto_increment  NOT NULL ,
        id_reference  Int ,
        sujet         Varchar (255) NOT NULL ,
        fichier_joint Varchar (255) ,
        message       Text NOT NULL ,
        msg_date      Date NOT NULL ,
        courriel      Varchar (25) NOT NULL ,
        PRIMARY KEY (id_message ) ,
        INDEX (id_reference ,msg_date )
)ENGINE=InnoDB;


#------------------------------------------------------------
# Table: agender
#------------------------------------------------------------

CREATE TABLE agender(
        id_logement      Int NOT NULL ,
        id_disponibilite Int NOT NULL ,
        PRIMARY KEY (id_logement ,id_disponibilite )
)ENGINE=InnoDB;


#------------------------------------------------------------
# Table: assigner  destinataire
#------------------------------------------------------------

CREATE TABLE assigner__destinataire(
        courriel   Varchar (25) NOT NULL ,
        id_message Int NOT NULL ,
        PRIMARY KEY (courriel ,id_message )
)ENGINE=InnoDB;

ALTER TABLE al_logements ADD CONSTRAINT FK_al_logements_courriel FOREIGN KEY (courriel) REFERENCES al_usager(courriel);
ALTER TABLE al_logements ADD CONSTRAINT FK_al_logements_id_type_logement FOREIGN KEY (id_type_logement) REFERENCES al_type_logement(id_type_logement);
ALTER TABLE al_location ADD CONSTRAINT FK_al_location_id_logement_al_logements FOREIGN KEY (id_logement_al_logements) REFERENCES al_logements(id_logement);
ALTER TABLE al_location ADD CONSTRAINT FK_al_location_courriel FOREIGN KEY (courriel) REFERENCES al_usager(courriel);
ALTER TABLE al_usager ADD CONSTRAINT FK_al_usager_id_contact FOREIGN KEY (id_contact) REFERENCES al_type_contact(id_contact);
ALTER TABLE al_usager ADD CONSTRAINT FK_al_usager_id_type_usager FOREIGN KEY (id_type_usager) REFERENCES al_type_usager(id_type_usager);
ALTER TABLE al_usager ADD CONSTRAINT FK_al_usager_id_paiement FOREIGN KEY (id_paiement) REFERENCES al_type_paiement(id_paiement);
ALTER TABLE al_evaluations ADD CONSTRAINT FK_al_evaluations_courriel FOREIGN KEY (courriel) REFERENCES al_usager(courriel);
ALTER TABLE al_evaluations ADD CONSTRAINT FK_al_evaluations_id_logement FOREIGN KEY (id_logement) REFERENCES al_logements(id_logement);
ALTER TABLE al_photos_logement ADD CONSTRAINT FK_al_photos_logement_id_logement FOREIGN KEY (id_logement) REFERENCES al_logements(id_logement);
ALTER TABLE al_messagerie ADD CONSTRAINT FK_al_messagerie_courriel FOREIGN KEY (courriel) REFERENCES al_usager(courriel);
ALTER TABLE agender ADD CONSTRAINT FK_agender_id_logement FOREIGN KEY (id_logement) REFERENCES al_logements(id_logement);
ALTER TABLE agender ADD CONSTRAINT FK_agender_id_disponibilite FOREIGN KEY (id_disponibilite) REFERENCES al_disponibilite(id_disponibilite);
ALTER TABLE assigner__destinataire ADD CONSTRAINT FK_assigner__destinataire_courriel FOREIGN KEY (courriel) REFERENCES al_usager(courriel);
ALTER TABLE assigner__destinataire ADD CONSTRAINT FK_assigner__destinataire_id_message FOREIGN KEY (id_message) REFERENCES al_messagerie(id_message);

--
-- Déchargement des données de la table `type_contact`
--



INSERT INTO `type_contact` (`id_contact`, `contact`) VALUES
(0, NULL),
(1, 'Courriel'),
(2, 'Messagerie'),
(3, 'Téléphone');

-- --------------------------------------------------------


--
-- Déchargement des données de la table `type_logement`
--

INSERT INTO `type_logement` (`id_type_logement`, `type_logement`) VALUES
(1, 'Maison unifamiliale'),
(2, 'Condo / Loft'),
(3, 'Chalet'),
(4, '');

-- --------------------------------------------------------



--
-- Déchargement des données de la table `type_paiement`
--

INSERT INTO `type_paiement` (`id_paiement`, `paiement`) VALUES
(1, 'Interact'),
(2, 'Paypal'),
(3, 'Carte Crédit');

-- --------------------------------------------------------

--
-- Déchargement des données de la table `type_usager`
--

INSERT INTO `type_usager` (`id_type_usager`, `type_usager`) VALUES
(1, 'Administrateur'),
(2, 'Propietaire'),
(3, 'Locataire');

-- --------------------------------------------------------


--
-- Déchargement des données de la table `usager`
--

INSERT INTO `usager` (`courriel`, `nom`, `prenom`, `cellulaire`, `mot_de_passe`, `u_banned`, `u_commentaire_banned`, `u_date_banned`, `id_contact`, `id_type_usager`, `id_paiement`) VALUES
('gabrielzoraidag@gmail.com', 'Ortiz', 'Zoraida', NULL, 'ZOrtiz123', NULL, NULL, NULL, 1, 1, 1),
('jsubirats@yahoo.com', 'Subirats', 'Jorge', NULL, 'JSubirats123', NULL, NULL, NULL, 1, 1, 1),
('missde0404@gmail.com', 'Ratté', 'Denise', NULL, 'DRatté123', NULL, NULL, NULL, 1, 1, 1),
('Oudayan@gmail.com', 'Dutta', 'Oudayan', NULL, 'ODutta123', NULL, NULL, NULL, 1, 1, 1);


