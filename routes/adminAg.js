import { create, findAll,findById,findByUsername,rechercherAdminAg,deleteById} from "../controllers/adminAg/index.js";
import { Router } from "express";
const router = Router();
router.get("/findAll", findAll);
router.get("/findById/:id", findById);
router.get("/findByUsername/:username", findByUsername);
router.post("/create", create);
router.post("/rechercherAdminAg/:id", rechercherAdminAg);
router.post("/delete", deleteById);


export default router;
