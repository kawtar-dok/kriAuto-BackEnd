-- CreateTable
CREATE TABLE "Admin" (
    "idAdmin" TEXT NOT NULL,
    "username" TEXT NOT NULL,
    "password" TEXT NOT NULL,
    "firstname" TEXT NOT NULL,
    "lastname" TEXT NOT NULL,
    "sexe" TEXT NOT NULL,
    "age" INTEGER NOT NULL,
    "telephone" TEXT NOT NULL,
    "city" TEXT NOT NULL,
    "email" TEXT NOT NULL,
    "registerDate" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "Admin_pkey" PRIMARY KEY ("idAdmin")
);

-- CreateTable
CREATE TABLE "AdminAg" (
    "idAdminAg" TEXT NOT NULL,
    "username" TEXT NOT NULL,
    "password" TEXT NOT NULL,
    "firstname" TEXT NOT NULL,
    "lastname" TEXT NOT NULL,
    "sexe" TEXT NOT NULL,
    "age" INTEGER NOT NULL,
    "telephone" TEXT NOT NULL,
    "city" TEXT NOT NULL,
    "email" TEXT NOT NULL,
    "registerDate" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "AdminAg_pkey" PRIMARY KEY ("idAdminAg")
);

-- CreateTable
CREATE TABLE "Client" (
    "idClient" TEXT NOT NULL,
    "username" TEXT NOT NULL,
    "password" TEXT NOT NULL,
    "firstname" TEXT NOT NULL,
    "lastname" TEXT NOT NULL,
    "sexe" TEXT NOT NULL,
    "age" INTEGER NOT NULL,
    "telephone" TEXT NOT NULL,
    "city" TEXT NOT NULL,
    "email" TEXT NOT NULL,
    "registerDate" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "Client_pkey" PRIMARY KEY ("idClient")
);

-- CreateTable
CREATE TABLE "Reservation" (
    "idReservation" TEXT NOT NULL,
    "dateDebut" DATE NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "dateFin" DATE NOT NULL,
    "heureDebut" TIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "heureFin" TIME NOT NULL,
    "villeDepart" TEXT NOT NULL,
    "villeRetour" TEXT NOT NULL,
    "statut" TEXT NOT NULL,
    "idClient" TEXT,
    "idAgence" TEXT,
    "idModele" TEXT,

    CONSTRAINT "Reservation_pkey" PRIMARY KEY ("idReservation")
);

-- CreateTable
CREATE TABLE "PieceJointe" (
    "idPieceJointe" TEXT NOT NULL,
    "pieceIdentifiante" BYTEA NOT NULL,
    "piecePermis" BYTEA NOT NULL,
    "idClient" TEXT NOT NULL,

    CONSTRAINT "PieceJointe_pkey" PRIMARY KEY ("idPieceJointe")
);

-- CreateTable
CREATE TABLE "Ville" (
    "idVille" TEXT NOT NULL,
    "nomVille" TEXT NOT NULL,
    "prixVilleJour" DOUBLE PRECISION NOT NULL,

    CONSTRAINT "Ville_pkey" PRIMARY KEY ("idVille")
);

-- CreateTable
CREATE TABLE "Modele" (
    "idModele" TEXT NOT NULL,
    "nameModele" TEXT NOT NULL,
    "marque" TEXT NOT NULL,
    "capacity" INTEGER NOT NULL,
    "Available" BOOLEAN NOT NULL,
    "idCategorieTarif" TEXT NOT NULL,

    CONSTRAINT "Modele_pkey" PRIMARY KEY ("idModele")
);

-- CreateTable
CREATE TABLE "Agence" (
    "idAgence" TEXT NOT NULL,
    "nameAgence" TEXT NOT NULL,
    "logo" BYTEA NOT NULL,
    "telephoneAg" TEXT NOT NULL,
    "emailAg" TEXT NOT NULL,
    "idAdminAg" TEXT NOT NULL,

    CONSTRAINT "Agence_pkey" PRIMARY KEY ("idAgence")
);

-- CreateTable
CREATE TABLE "CategorieTarifaire" (
    "idCategorieTarif" TEXT NOT NULL,
    "nomCategorie" TEXT NOT NULL,
    "typeMoteur" TEXT NOT NULL,
    "idAgence" TEXT NOT NULL,

    CONSTRAINT "CategorieTarifaire_pkey" PRIMARY KEY ("idCategorieTarif")
);

-- CreateTable
CREATE TABLE "Extra" (
    "idExtra" TEXT NOT NULL,
    "SiegeEnfant" INTEGER NOT NULL DEFAULT 0,
    "Clima" BOOLEAN NOT NULL,
    "idAgence" TEXT NOT NULL,

    CONSTRAINT "Extra_pkey" PRIMARY KEY ("idExtra")
);

-- CreateTable
CREATE TABLE "FraisAbonndon" (
    "idFraisAbonndon" TEXT NOT NULL,
    "prixDepotAutreVille" DOUBLE PRECISION NOT NULL,
    "idAgence" TEXT NOT NULL,

    CONSTRAINT "FraisAbonndon_pkey" PRIMARY KEY ("idFraisAbonndon")
);

-- CreateTable
CREATE TABLE "Periode" (
    "idPeriod" TEXT NOT NULL,
    "saison" TEXT NOT NULL,

    CONSTRAINT "Periode_pkey" PRIMARY KEY ("idPeriod")
);

-- CreateTable
CREATE TABLE "Duree" (
    "idDuree" TEXT NOT NULL,

    CONSTRAINT "Duree_pkey" PRIMARY KEY ("idDuree")
);

-- CreateTable
CREATE TABLE "Tarif" (
    "idTarif" TEXT NOT NULL,
    "total" DOUBLE PRECISION NOT NULL,
    "idPeriod" TEXT NOT NULL,
    "idDuree" TEXT NOT NULL,
    "idCategorieTarif" TEXT NOT NULL,
    "idVille" TEXT NOT NULL,

    CONSTRAINT "Tarif_pkey" PRIMARY KEY ("idTarif")
);

-- CreateIndex
CREATE UNIQUE INDEX "PieceJointe_idClient_key" ON "PieceJointe"("idClient");

-- CreateIndex
CREATE UNIQUE INDEX "Agence_idAdminAg_key" ON "Agence"("idAdminAg");

-- CreateIndex
CREATE UNIQUE INDEX "CategorieTarifaire_idAgence_key" ON "CategorieTarifaire"("idAgence");

-- CreateIndex
CREATE UNIQUE INDEX "Extra_idAgence_key" ON "Extra"("idAgence");

-- CreateIndex
CREATE UNIQUE INDEX "FraisAbonndon_idAgence_key" ON "FraisAbonndon"("idAgence");

-- AddForeignKey
ALTER TABLE "Reservation" ADD CONSTRAINT "Reservation_idClient_fkey" FOREIGN KEY ("idClient") REFERENCES "Client"("idClient") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Reservation" ADD CONSTRAINT "Reservation_idModele_fkey" FOREIGN KEY ("idModele") REFERENCES "Modele"("idModele") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Reservation" ADD CONSTRAINT "Reservation_idAgence_fkey" FOREIGN KEY ("idAgence") REFERENCES "Agence"("idAgence") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "PieceJointe" ADD CONSTRAINT "PieceJointe_idClient_fkey" FOREIGN KEY ("idClient") REFERENCES "Client"("idClient") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Modele" ADD CONSTRAINT "Modele_idCategorieTarif_fkey" FOREIGN KEY ("idCategorieTarif") REFERENCES "CategorieTarifaire"("idCategorieTarif") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Agence" ADD CONSTRAINT "Agence_idAdminAg_fkey" FOREIGN KEY ("idAdminAg") REFERENCES "AdminAg"("idAdminAg") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "CategorieTarifaire" ADD CONSTRAINT "CategorieTarifaire_idAgence_fkey" FOREIGN KEY ("idAgence") REFERENCES "Agence"("idAgence") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Extra" ADD CONSTRAINT "Extra_idAgence_fkey" FOREIGN KEY ("idAgence") REFERENCES "Agence"("idAgence") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "FraisAbonndon" ADD CONSTRAINT "FraisAbonndon_idAgence_fkey" FOREIGN KEY ("idAgence") REFERENCES "Agence"("idAgence") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Tarif" ADD CONSTRAINT "Tarif_idVille_fkey" FOREIGN KEY ("idVille") REFERENCES "Ville"("idVille") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Tarif" ADD CONSTRAINT "Tarif_idCategorieTarif_fkey" FOREIGN KEY ("idCategorieTarif") REFERENCES "CategorieTarifaire"("idCategorieTarif") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Tarif" ADD CONSTRAINT "Tarif_idPeriod_fkey" FOREIGN KEY ("idPeriod") REFERENCES "Periode"("idPeriod") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Tarif" ADD CONSTRAINT "Tarif_idDuree_fkey" FOREIGN KEY ("idDuree") REFERENCES "Duree"("idDuree") ON DELETE RESTRICT ON UPDATE CASCADE;
