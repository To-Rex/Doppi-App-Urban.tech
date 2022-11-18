import Facebook from "../assets/Facebook Logo.png";
import { makeStyles } from "@mui/styles";

const useStyles = makeStyles({
  FacebookLogin: {
    display: "flex",
    flexDirection: "row",
    alignItems: "flex-start",
    padding: "15px",
    gap: "15px",
    maxWidth: "550px",
    width: "100%",
    height: "54px",
    background: "#1877F2",
    borderRadius: "10px",
    cursor: "pointer",
  },

  "&:hover": {
    background: "#f5f5f5",
  },

  text: {
    color: "#ffffff",
    fontSize: "20px",
    fontFamily: "SF Pro Display",
    fontWeight: "500",
    lineHeight: "24px",
  },
});

function FacebookLogin() {
  const classes = useStyles();

  return (
    <div className={classes.FacebookLogin}>
      <img
        src={Facebook}
        alt="Facebook"
        style={{
          width: "24px",
          height: "24px",
        }}
      />
      <p className={classes.text}>Sign in with Facebook</p>
    </div>
  );
}

export default FacebookLogin;
