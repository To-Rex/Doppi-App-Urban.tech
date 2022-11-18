import { useState } from "react";
import Picture from "../assets/waiter.jpeg";
import Logo from "../assets/Logo.png";
import Button from "@mui/material/Button";
import CssBaseline from "@mui/material/CssBaseline";
import TextField from "@mui/material/TextField";
import Link from "@mui/material/Link";
import Paper from "@mui/material/Paper";
import Box from "@mui/material/Box";
import Grid from "@mui/material/Grid";
import Typography from "@mui/material/Typography";
import { useNavigate } from "react-router-dom";
import toast, { Toaster } from "react-hot-toast";
import api from "../api";

export default function SignInSide() {
  const [name, setName] = useState("");
  const [address, setAddress] = useState("");
  const [phone, setPhone] = useState("");
  const [email, setEmail] = useState("");
  const [password, setPassword] = useState("");
  const [confirm, setConfirm] = useState("");
  const navigate = useNavigate();

  const handleSubmit = async (event: any) => {
    event.preventDefault();
    const data = new FormData(event.currentTarget);
    const email = data.get("email");
    const password = data.get("password");

    await api
      .post("api/auth/sign-up-boss", {
        name,
        address,
        phone,
        email,
        password,
      })
      .then((response) => {
        if (response.status === 200) {
          toast.success("Success!");
          navigate("/");
        }
      })
      .catch((err) => {
        console.error(err);
        toast.error(err.response.data.errors[0].msg);
      })
      .finally(() => {
        console.log("finally");
      });
  };

  return (
    <>
      <Toaster />
      <Grid container component="main" sx={{ height: "100vh" }}>
        <CssBaseline />
        <Grid
          item
          xs={false}
          sm={4}
          md={7}
          sx={{
            backgroundImage: `url(${Picture})`,
            backgroundRepeat: "no-repeat",
            backgroundColor: (t) =>
              t.palette.mode === "light"
                ? t.palette.grey[50]
                : t.palette.grey[900],
            backgroundSize: "cover",
            backgroundPosition: "center",
          }}
        />
        <Grid item xs={12} sm={8} md={5} component={Paper} elevation={6} square>
          <Box
            sx={{
              // my: 8,
              mt: -6,
              mx: 4,
              display: "flex",
              flexDirection: "column",
              alignItems: "center",
            }}
          >
            <Box
              sx={{
                width: "300px",
                height: "150px",
              }}
            >
              <img src={Logo} alt="Logo" />
            </Box>
            <Typography component="h1" variant="h5">
              Sign up
            </Typography>
            <Box
              component="form"
              noValidate
              onSubmit={handleSubmit}
              sx={{
                flexGrow: 1,
                flexDirection: "column",
                alignItems: "center",
              }}
            >
              <TextField
                margin="dense"
                fullWidth
                id="name"
                label="Dinner Name"
                name="dinner name"
                value={name}
                onChange={(e) => {
                  setName(e.target.value);
                }}
              />
              <TextField
                margin="dense"
                fullWidth
                name="address"
                label="Address"
                id="address"
                value={address}
                onChange={(e) => {
                  setAddress(e.target.value);
                }}
              />
              <TextField
                margin="dense"
                fullWidth
                name="phone"
                label="Phone"
                type="phone"
                value={phone}
                onChange={(e) => {
                  setPhone(e.target.value);
                }}
              />
              <TextField
                margin="dense"
                fullWidth
                name="email"
                label="Email Address"
                type="email"
                value={email}
                onChange={(e) => {
                  setEmail(e.target.value);
                }}
              />
              <TextField
                margin="dense"
                fullWidth
                name="password"
                label="Password"
                type="password"
                id="password"
                value={password}
                onChange={(e) => {
                  setPassword(e.target.value);
                }}
              />
              <TextField
                margin="dense"
                fullWidth
                name="confirm password"
                label="Confirm Password"
                type="password"
                id="confirm password"
                value={confirm}
                onChange={(e) => {
                  setConfirm(e.target.value);
                }}
              />
              <Box
                sx={{
                  display: "flex",
                  flexDirection: "row",
                  justifyContent: "space-between",
                  "@media (max-width: 600px)": {
                    flexDirection: "column",
                  },
                  alignItems: "center",
                  mt: 3,
                }}
              >
                <Button
                  type="submit"
                  variant="contained"
                  sx={{ mt: 3, mb: 2, width: 200 }}
                >
                  Sign Up
                </Button>
                <Link href="/" variant="body2">
                  {"Already have an account? Sign In"}
                </Link>
              </Box>
            </Box>
          </Box>
        </Grid>
      </Grid>
    </>
  );
}
