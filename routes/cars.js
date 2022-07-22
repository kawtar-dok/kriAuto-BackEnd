import { Router } from "express";
import { getAvailableCars, bookCar } from "../controllers/cars/index.js";
const router = Router();
router.get("/findAll", getAvailableCars);
router.post("/book", bookCar);
export default router;
