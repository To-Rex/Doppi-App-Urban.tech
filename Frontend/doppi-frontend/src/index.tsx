import React from "react";
import ReactDOM from "react-dom/client";
import "./index.css";
import Login from "./Screens/Login";
import Register from "./Screens/Register";
import Itmes from "./Screens/Dashboard";
import reportWebVitals from "./reportWebVitals";
import { BrowserRouter, Routes, Route } from "react-router-dom";
import Items from "./Screens/Dashboard";

const root = ReactDOM.createRoot(
  document.getElementById("root") as HTMLElement
);

root.render(
  <React.StrictMode>
    <BrowserRouter>
      <Routes>
        <Route path="/" element={<Login />} />
        <Route path="/signup" element={<Register />} />
        <Route path="/dashboard" element={<Items />} />
      </Routes>
    </BrowserRouter>
  </React.StrictMode>
);

reportWebVitals();
