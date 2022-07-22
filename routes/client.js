import { create, findAll,findById,findByUsername,rechercherCar,deleteById} from "../controllers/client/index.js";
import { Router } from "express";
const router = Router();
router.get("/findAll", findAll);
router.get("/findById/:id", findById);
router.get("/findByUsername/:username", findByUsername);
router.post("/create", create);
router.post("/rechercherCar/:id", rechercherCar);
router.post("/delete", deleteById);


export default router;
