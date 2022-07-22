import { create, findAll,findById,findByUsername,rechercherAdmin,deleteById} from "../controllers/admin/index.js";
import { Router } from "express";
const router = Router();
router.get("/findAll", findAll);
router.get("/findById/:id", findById);
router.get("/findByUsername/:username", findByUsername);
router.post("/create", create);
router.post("/rechercherAdmin/:id", rechercherAdmin);
router.post("/delete", deleteById);


export default router;
