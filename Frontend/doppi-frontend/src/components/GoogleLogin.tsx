import React from "react";
import { makeStyles } from "@mui/styles";
import Google from "../assets/Google Logo.png";

const useStyles = makeStyles({
  GoogleLogin: {
    display: "flex",
    flexDirection: "row",
    alignItems: "flex-start",
    padding: "15px",
    gap: "15px",
    maxWidth: "550px",
    width: "100%",
    height: "54px",
    background: "#ffffff",
    borderRadius: "10px",
    boxShadow:
      "0px 0px 3px rgba(0, 0, 0, 0.084), 0px 2px 3px rgba(0, 0, 0, 0.168)",
    cursor: "pointer",

    "&:hover": {
      background: "#f5f5f5",
    },
  },
  text: {
    color: "#000000",
    fontSize: "20px",
    fontFamily: "SF Pro Display",
    fontWeight: "500",
    lineHeight: "24px",
  },
});

function GoogleLogin() {
  const classes = useStyles();

  return (
    <div className={classes.GoogleLogin}>
      <img
        src={Google}
        alt="Google"
        style={{
          width: "24px",
          height: "24px",
        }}
      />

      <p className={classes.text}>Sign in with Google</p>
    </div>
  );
}

export default GoogleLogin;
