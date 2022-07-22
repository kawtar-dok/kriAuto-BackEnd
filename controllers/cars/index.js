import { PrismaClient } from "@prisma/client";
const prisma = new PrismaClient();

export const getAvailableCars = async (req, res) => {
  try {
    const cars = await prisma.modele.findMany({
      where: {
        Available: true,
      },
    });
    return res.status(200).json({ success: true, cars });
  } catch (err) {
    console.log(err);
    return res.status(200).json({ success: false });
  }
};
export const bookCar = async (req, res) => {
  try {
    const car = await prisma.modele.findFirst({
      where: {
        idModele: req.body.id,
      },
    });
    if (!car) {
      return res.status(200).json({ success: false });
    }
    const client = await prisma.client.findFirst({
      where: {
        idClient: req.body.clientId,
      },
    });
    if (!client) {
      return res.status(200).json({ success: false });
    }
    const booking = await prisma.reservation.create({
      data: {
        dateDebut: req.body.dateDebut,
        dateFin: req.body.dateFin,
        heureDebut: req.body.heureDebut,
        heureFin: req.body.heureFin,
        statut: req.body.statut,
        villeDepart: req.body.villeDepart,
        villeArrivee: req.body.villeArrivee,
        client: {
          connect: {
            idClient: req.body.clientId,
          },
        },
        modele: {
          connect: {
            idModele: req.body.id,
          },
        },
        agence: {
          connect: {
            idAgence:0,
          },
        },
      },
    });
    return res.status(200).json({ success: true, booking });
  } catch (err) {
    console.log(err);
    return res.status(200).json({ success: false });
  }
};
