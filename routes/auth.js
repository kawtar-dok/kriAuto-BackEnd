import { Router } from "express";
import { login,signup } from "../controllers/auth/index.js";
const router = Router();
router.post("/login", login);
router.post("/register", signup);


export default router;
