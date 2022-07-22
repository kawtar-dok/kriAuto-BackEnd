import { PrismaClient } from "@prisma/client";
const prisma = new PrismaClient();



export const deleteById = async (req, res) =>{
try{
    const client = await prisma.Client.delete({
        where: {
          idClient: req.params.id,
        }
    });
    return res.json(client);
  } catch (err) {
    console.log(err);
  }
};


export const findById = async (req, res) => {
  try {
    const client = await prisma.Client.findUnique({
      where: {
        idClient: req.params.id,
      },
    });
    return res.status(200).json({
      client,
    });
  } catch (err) {
    console.log(err);
  }
};

export const login = async (req, res) => {
  try {
    const client = await prisma.Client.findUnique({
      where: {
        username: req.params.username,
        password: req.params.password,
      },
    });
    return res.status(200).json({ success: true, client });
   // window.location.href = "/client/landingClient";
  
  } catch (err) {
    console.log(err);
    window.location.reload();
  }
};

export const findAll = async (req, res) => {
  try {
    const clients = await prisma.Client.findMany();
    return res.status(200).json({
      clients,
    });
  } catch (err) {
    console.log(err);
  }
};
export const rechercherCar = async (req,res)=> {
  try{
    const car = await prisma.modele.findMany({
      where:{
        OR:[
          {
            marque : {
              startsWith: "audi"
            },
          },
          {
            AND: {
              nameModele: {
                startsWith: "A"
              },
            },
          },
        ],
      },
    })
  }
  catch(err){
    console.log(err);
  }
};

export const findByUsername = async (req, res) => {
  try {
    const client = await prisma.Client.findMany({
      where: {
        username: req.params.username,
      },
    });
    return res.status(200).json({
      client,
    });
  } catch (err) {
    console.log(err);
  }
};

export const create = async (req, res) => {
  try {
    console.log(req.body);
    // on cherche le client dans la base de données
    let client = await prisma.Client.findFirst({
      where: {
        username: req.body.username,
      },
    });
    console.log("Je cherche le client");
    // si le client existe on quitte
    if (client) {
      console.log("Le client existe déjà");
      return res.status(401).json({
        success: false,
        message: "User already exists",
      });
    }
    console.log("Le client n'existe pas");
    // sinon on crée le client
    // console.log(req.body)
    if ("idClient" in req.body) {
      delete req.body.idClient;
    }
   // console.log("m here");
    let newClient = await prisma.Client.create({
      data: {
        username: req.body.username,
        password: req.body.password,
        email: req.body.email,
        firstname: req.body.firstName,
        lastname: req.body.lastName,
        age : parseInt(req.body.age),
        city : req.body.city,
        telephone : req.body.phone,
        sexe : req.body.sexe
      }
    });
    console.log("Je crée le client");
    res.status(200).json({ success: true, message: "User created" });
  } catch (err) {
    console.log(err);
    res.status(500).json({
      success: false,
      message: err.message,
    });
  }
};

