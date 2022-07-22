/*
  Warnings:

  - You are about to drop the column `typeMoteur` on the `CategorieTarifaire` table. All the data in the column will be lost.
  - Added the required column `prix` to the `CategorieTarifaire` table without a default value. This is not possible if the table is not empty.
  - Added the required column `boiteVitesse` to the `Modele` table without a default value. This is not possible if the table is not empty.
  - Added the required column `carburant` to the `Modele` table without a default value. This is not possible if the table is not empty.
  - Added the required column `typeMoteur` to the `Modele` table without a default value. This is not possible if the table is not empty.

*/
-- AlterTable
ALTER TABLE "CategorieTarifaire" DROP COLUMN "typeMoteur",
ADD COLUMN     "prix" TEXT NOT NULL;

-- AlterTable
ALTER TABLE "Client" ADD COLUMN     "balance" INTEGER NOT NULL DEFAULT 0;

-- AlterTable
ALTER TABLE "Modele" ADD COLUMN     "boiteVitesse" TEXT NOT NULL,
ADD COLUMN     "carburant" TEXT NOT NULL,
ADD COLUMN     "image" TEXT,
ADD COLUMN     "typeMoteur" TEXT NOT NULL;
