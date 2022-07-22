import { PrismaClient } from "@prisma/client";
const prisma = new PrismaClient();

export const login = async (req, res) => {
  const { username, password } = req.body.data;
  try {
    const admin = await prisma.admin.findFirst({
      where: {
        username: username,
        password: password,
      },
    });
    const adminAg = await prisma.adminAg.findFirst({
      where: {
        username: username,
        password: password,
      },
    });
    const client = await prisma.client.findFirst({
      where: {
        username: username,
        password: password,
      },
    });
    if (!admin && !adminAg && !client) {
      res.json({
        success: false,
        message: "Invalid credentials",
      });
    } else {
      if (admin) {
        return res.status(200).json({ success: true, role: "admin", admin });
      } else if (adminAg) {
        return res
          .status(200)
          .json({ success: true, role: "adminAg", adminAg });
      } else if (client) {
        return res.status(200).json({ success: true, role: "client", client });
      }
    }
  } catch (err) {
    console.log(err);
    return res.status(200).json({ success: false });
  }
};
export const signup = async (req, res) => {
  try {
    const data = req.body;
    const username = data.username;
    const user = await prisma.client.findFirst({
      where: {
        username: username,
      },
    });
    const agency = await prisma.adminAg.findFirst({
      where: {
        username: username,
      },
    });
    if (user || agency) {
      return res
        .status(200)
        .json({ success: false, message: "Username already exists" });
    }
    if (data.role === "client") {
      const client = await prisma.client.create({
        data: {
          firstname: data.firstName,
          lastname: data.lastName,
          username: data.username,
          password: data.password,
          email: data.email,
          telephone: data.telephone,
          address: data.address,
          city: data.city,
          sexe: data.sexe,
          age: data.age,
        },
      });

      return res.status(200).json({ success: true, role: "client", client });
    } else {
      const adminAg = await prisma.adminAg.create({
        data: {
          firstname: data.firstName,
          lastname: data.lastName,
          username: data.username,
          password: data.password,
          email: data.email,
          telephone: data.telephone,
          address: data.address,
          city: data.city,
          sexe: data.sexe,
          age: data.age,
        },
      });
      return res.status(200).json({ success: true, role: "admin", adminAg });
    }
  } catch (err) {
    console.log(err);
    return res.status(200).json({ success: false });
  }
};
