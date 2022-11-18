import Picture from "../assets/waiter.jpeg";
import Logo from "../assets/Logo.png";
import Button from "@mui/material/Button";
import CssBaseline from "@mui/material/CssBaseline";
import TextField from "@mui/material/TextField";
import FormControlLabel from "@mui/material/FormControlLabel";
import Checkbox from "@mui/material/Checkbox";
import Link from "@mui/material/Link";
import Paper from "@mui/material/Paper";
import Box from "@mui/material/Box";
import Grid from "@mui/material/Grid";
import Typography from "@mui/material/Typography";
import AppleLogin from "../components/AppleLogin";
import GoogleLogin from "../components/GoogleLogin";
import FacebookLogin from "../components/FacebookLogin";
import api from "../api";
import { useStore } from "../store/index";
import { useNavigate } from "react-router-dom";
import toast, { Toaster } from "react-hot-toast";
import { useEffect } from "react";

export default function SignInSide() {
  const navigate = useNavigate();
  const { setToken, setName } = useStore();

  const handleLogin = (e: any) => {
    toast.promise(handleSubmit(e), {
      loading: "Loading...",
      success: "Success!",
      error: "Email or password is incorrect",
    });
  };

  const handleSubmit = async (event: any) => {
    event.preventDefault();
    const data = new FormData(event.currentTarget);
    const email = data.get("email");
    const password = data.get("password");

    const checkbox = data.get("checkbox");

    await api
      .post("/api/auth/sign-in", {
        email,
        password,
      })
      .then((res) => {
        setToken(res.data.data.token);
        setName(res.data.data.user.name);
        navigate("/dashboard");

        if (checkbox) {
          sessionStorage.setItem("token", res.data.data.token);
          sessionStorage.setItem("name", res.data.data.user.name);
        }
      })
      .catch((err) => {
        console.error(err);
        throw err;
      });
  };

  useEffect(() => {
    const token = sessionStorage.getItem("token");
    if (token) {
      setToken(token);
      navigate("/dashboard");
    }
  }, []);

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
              my: 8,
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
              Sign in
            </Typography>
            <Box
              component="form"
              noValidate
              onSubmit={handleLogin}
              sx={{ mt: 1 }}
            >
              <TextField
                margin="normal"
                required
                fullWidth
                id="email"
                label="Email Address"
                name="email"
                autoComplete="email"
                autoFocus
              />
              <TextField
                margin="normal"
                required
                fullWidth
                name="password"
                label="Password"
                type="password"
                id="password"
                autoComplete="current-password"
              />
              <FormControlLabel
                control={
                  <Checkbox value="remember" color="primary" name="checkbox" />
                }
                label="Remember me"
              />
              <Button
                type="submit"
                fullWidth
                variant="contained"
                sx={{ mt: 3, mb: 2 }}
              >
                Sign In
              </Button>
              <Grid container>
                <Grid item xs>
                  <Link href="#" variant="body2">
                    Forgot password?
                  </Link>
                </Grid>
                <Grid item>
                  <Link href="/signup" variant="body2">
                    {"Don't have an account? Sign Up"}
                  </Link>
                </Grid>
              </Grid>
              <Box
                sx={{
                  width: "100%",
                  display: "flex",
                  flexDirection: "column",
                  alignItems: "center",
                  marginTop: "20px",
                  gap: "20px",
                }}
              >
                <p
                  style={{
                    color: "#ccc",
                    fontSize: "16px",
                    fontWeight: "300",
                    lineHeight: "20px",
                  }}
                >
                  Or sign in with
                </p>
                <GoogleLogin />
                <FacebookLogin />
                <AppleLogin />
              </Box>
            </Box>
          </Box>
        </Grid>
      </Grid>
    </>
  );
}
