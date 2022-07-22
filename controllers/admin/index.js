import { PrismaClient } from "@prisma/client";
const prisma = new PrismaClient();




export const deleteById = async (req, res) =>{
try{
    const admin = await prisma.Admin.delete({
        where: {
          idAdmin: req.params.id,
        }
    });
    return res.json(admin);
  } catch (err) {
    console.log(err);
  }
};


export const findById = async (req, res) => {
  try {
    const admin = await prisma.Admin.findUnique({
      where: {
        idAdmin: req.params.id,
      },
    });
    return res.status(200).json({
        admin,
    });
  } catch (err) {
    console.log(err);
  }
};

export const login = async (req, res) => {
  try {
    const admin = await prisma.Admin.findUnique({
      where: {
        username: req.params.username,
        password: req.params.password,
      },
    });
    return res.status(200).json({ success: true, admin });
   // window.location.href = "/admin/dashbord";
  
  } catch (err) {
    console.log(err);
    window.location.reload();
  }
};

export const findAll = async (req, res) => {
  try {
    const admin = await prisma.Admin.findMany();
    return res.status(200).json({
      admin,
    });
  } catch (err) {
    console.log(err);
  }
};
export const rechercherAdmin = async (req,res)=> {
  try{
    const admin = await prisma.Admin.findMany({
      where:{
        OR:[
          {
            firstname: {
              firstname: "k"
            },
          },
          {
            AND: {
              lastname: {
                startsWith: "i"
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
    const admin = await prisma.Admin.findMany({
      where: {
        username: req.params.username,
      },
    });
    return res.status(200).json({
      admin,
    });
  } catch (err) {
    console.log(err);
  }
};

export const create = async (req, res) => {
  try {
    console.log(req.body);
    // on cherche l"Admin" dans la base de données
    let admin = await prisma.Admin.findFirst({
      where: {
        username: req.body.username,
      },
    });
    console.log("Je cherche l'admin");
    // si l'Admin existe on quitte
    if (admin) {
      console.log("L'admin existe déjà");
      return res.status(401).json({
        success: false,
        message: "Admin already exists",
      });
    }
    console.log("L'Admin' n'existe pas");
    // sinon on crée le client
    // console.log(req.body)
    if ("idAdmin" in req.body) {
      delete req.body.idAdmin;
    }
   // console.log("m here");
    let newAdmin = await prisma.Admin.create({
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
    console.log("Je crée l'Admin'");
    res.status(200).json({ success: true, message: "Admin created" });
  } catch (err) {
    console.log(err);
    res.status(500).json({
      success: false,
      message: err.message,
    });
  }
};

