import axios from "axios";

const api = axios.create({
  baseURL: "https://doppi-backend-production.up.railway.app/",
});

export default api;
