import clientRoutes from "./routes/client.js";
import adminRoutes from "./routes/admin.js";
import adminAgRoutes from "./routes/adminAg.js";
import authRoutes from "./routes/auth.js";
import carsRoutes from "./routes/cars.js";
import express from "express";
import cors from "cors";
const app = express();
app.use(cors());
app.use(express.json());



app.use("/client", clientRoutes);
app.use("/admin", adminRoutes);
app.use("/adminAg", adminAgRoutes);
app.use("/auth", authRoutes);
app.use("/cars", carsRoutes);

app.listen(process.env.PORT || 3001, () => {
  console.log("listening on port 3001");
});